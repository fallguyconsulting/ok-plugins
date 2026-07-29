#!/usr/bin/env bash

# @story: edit-time-lint-enforcement
# @story: incremental-lint-adoption
# @story: rules-compliance-report

set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
plumbline="$here/../bin/plumbline"
family="$(cd "$here/.." && pwd)"
fixtures="$here/fixtures"
fail=0
fails=0

TIMEFORMAT='%3R'
section() { :; }

run_self_lint_gate() {
  local name="the family's own tree is clean under its own lint"
  local out rc
  out=$(node "$plumbline" lint "$family" 2>&1); rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "ok: $name"
  else
    echo "FAIL: $name"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1
  fi
}
run_self_lint_gate

skill_run_block() {
  local skill_file=$1
  python3 - "$skill_file" <<'PY'
import sys

lines = open(sys.argv[1]).read().split("\n")
start = next(i for i, l in enumerate(lines) if l.strip() == "## Run")
open_at = next(i for i in range(start, len(lines)) if lines[i] == "```bash")
# The block's own text may contain fences and headings, so the closing
# fence is the bare ``` whose next non-empty line is a document heading
# (or end of file).
for end in range(open_at + 1, len(lines)):
    if lines[end] != "```":
        continue
    rest = [l for l in lines[end + 1:] if l.strip()]
    if not rest or rest[0].startswith("## "):
        break
sys.stdout.write("\n".join(lines[open_at + 1:end]))
PY
}

run_case() {
  local name=$1
  local dir=$2
  local expected_exit=$3
  local expected_substr=$4

  local output secs verdict captured actual_exit
  captured=$(mktemp)
  secs=$( { time node "$plumbline" "$dir" >"$captured" 2>&1; } 2>&1 )
  actual_exit=$?
  output=$(cat "$captured")
  rm -f "$captured"

  verdict=ok
  if [ "$actual_exit" -ne "$expected_exit" ]; then
    echo "FAIL: $name — expected exit $expected_exit, got $actual_exit"
    echo "$output" | sed 's/^/    /'
    fail=1
    fails=$((fails + 1))
    verdict=fail
  elif [ -n "$expected_substr" ] && ! echo "$output" | grep -q -- "$expected_substr"; then
    echo "FAIL: $name — expected output to contain '$expected_substr'"
    echo "$output" | sed 's/^/    /'
    fail=1
    fails=$((fails + 1))
    verdict=fail
  else
    echo "ok: $name (${secs}s)"
  fi
}

run_case "clean (legacy root config)"  "$fixtures/clean"                       0 ""
run_case "license-header"              "$fixtures/license-header"              0 ""
run_case "machine-directives"          "$fixtures/machine-directives"          0 ""
run_case "docstring-opted-in"          "$fixtures/docstring-opted-in"          0 ""
run_case "citation-file-resolved (legacy root config)" "$fixtures/citation-file-resolved" 0 ""
run_case "citation-glob-resolved"      "$fixtures/citation-glob-resolved"      0 ""
run_case "regex-literals"              "$fixtures/regex-literals"              0 ""
run_case "shell-quoting-clean"         "$fixtures/shell-quoting-clean"         0 ""

run_case "disallowed-comment"          "$fixtures/disallowed-comment"          2 "plumbline/comment-hygiene"
run_case "docstring-not-opted-in"      "$fixtures/docstring-not-opted-in"      2 "plumbline/comment-hygiene"
run_case "comment-after-regex"         "$fixtures/comment-after-regex"         2 "plumbline/comment-hygiene"
run_case "shell-comment-after-quoting" "$fixtures/shell-comment-after-quoting" 2 "plumbline/comment-hygiene"
run_case "citation-file-unresolved"    "$fixtures/citation-file-unresolved"    2 "plumbline/citation-unresolved"
run_case "citation-glob-unresolved"    "$fixtures/citation-glob-unresolved"    2 "plumbline/citation-unresolved"

# @decision: ratchet-over-soft-start
run_ratchet_case() {
  local name="budget ratchet"
  local tmp
  tmp=$(mktemp -d)
  mkdir -p "$tmp/.ok-plumbline"
  printf '{}\n' > "$tmp/.ok-plumbline/config.json"
  printf 'x = 1\n' > "$tmp/clean.py"

  local output
  output=$(node "$plumbline" budget save "$tmp" 2>&1)
  if [ $? -ne 0 ] || [ ! -f "$tmp/.ok-plumbline/budget.json" ]; then
    echo "FAIL: $name — baseline save did not write .ok-plumbline/budget.json"
    echo "$output" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf '# stray comment\ny = 2\n' > "$tmp/new.py"
  output=$(node "$plumbline" budget check "$tmp" 2>&1)
  if [ $? -ne 2 ] || ! echo "$output" | grep -q "exceeds baseline"; then
    echo "FAIL: $name — net-new violation did not trip the ratchet (expected exit 2)"
    echo "$output" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  mv "$tmp/.ok-plumbline/budget.json" "$tmp/.plumbline-budget.json"
  output=$(node "$plumbline" budget check "$tmp" 2>&1)
  if [ $? -ne 2 ]; then
    echo "FAIL: $name — pre-migration baseline location was not read during migration"
    echo "$output" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_ratchet_case

# @decision: edit-hook-blocks-in-turn
hook_repo() {
  local tmp
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  mkdir -p "$tmp/.ok-plumbline/bin" "$tmp/.ok-plumbline/hooks"
  cp "$here/../bin/plumbline" "$tmp/.ok-plumbline/bin/plumbline"
  sed "s/{{OK_PLUMBLINE_VERSION}}/test/g" "$here/../scripts/hooks/post-edit.js" > "$tmp/.ok-plumbline/hooks/post-edit.js"
  printf '{}\n' > "$tmp/.ok-plumbline/config.json"
  printf '%s\n' "$tmp"
}

invoke_hook() {
  local repo=$1 file=$2
  printf '{"tool_input":{"file_path":"%s"}}' "$file" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
}

hook_case() {
  local name=$1 expected=$2 actual=$3
  if [ "$actual" -ne "$expected" ]; then
    echo "FAIL: hook harness — $name (expected exit $expected, got $actual)"
    fail=1
  else
    echo "ok: hook harness — $name"
  fi
}

run_hook_harness() {
  local repo file
  repo=$(hook_repo)

  file="$repo/legacy.py"
  printf '# pre-existing violation\nx = 1\n' > "$file"
  git -C "$repo" add legacy.py
  git -C "$repo" -c user.email=t@t -c user.name=t commit -q -m legacy
  printf '# pre-existing violation\nx = 1\ny = 2\n' > "$file"
  invoke_hook "$repo" "$file"; hook_case "violation on untouched line passes" 0 $?

  printf '# pre-existing violation\nx = 1\ny = 2\n# fresh violation\n' > "$file"
  invoke_hook "$repo" "$file"; hook_case "violation on changed line blocks" 2 $?

  file="$repo/untracked.py"
  printf '# violation in untracked file\nz = 3\n' > "$file"
  invoke_hook "$repo" "$file"; hook_case "untracked file checked whole" 2 $?

  printf '' | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
  hook_case "fail-open: missing input" 0 $?

  local bare
  bare=$(mktemp -d)
  mkdir -p "$bare/.ok-plumbline/hooks" "$bare/.ok-plumbline/bin"
  cp "$repo/.ok-plumbline/hooks/post-edit.js" "$bare/.ok-plumbline/hooks/post-edit.js"
  cp "$here/../bin/plumbline" "$bare/.ok-plumbline/bin/plumbline"
  printf '# violation\n' > "$bare/loose.py"
  printf '{"tool_input":{"file_path":"%s"}}' "$bare/loose.py" \
    | CLAUDE_PROJECT_DIR="$bare" node "$bare/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
  hook_case "fail-open: no repository" 0 $?
  rm -rf "$bare"

  rm "$repo/.ok-plumbline/bin/plumbline"
  printf '# still a violation\nx = 1\ny = 2\n# fresh violation\n' > "$repo/legacy.py"
  invoke_hook "$repo" "$repo/legacy.py"; hook_case "fail-open: no vendored binary" 0 $?

  cp "$here/../bin/plumbline" "$repo/.ok-plumbline/bin/plumbline"
  printf '{"tool_input":{"file_path":"%s"}}' "$repo/legacy.py" \
    | CLAUDE_PROJECT_DIR="$repo" PATH="" "$(command -v node)" "$repo/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
  hook_case "fail-open: spawn error" 0 $?

  rm -rf "$repo"
}
run_hook_harness

# @concept: materialized-artifact
# @concept: integration-contract
run_esm_root_case() {
  local name="converge under an ESM project root" tmp out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  printf '{ "type": "module" }\n' > "$tmp/package.json"

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge aborted under the ESM root (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  ( cd "$tmp" && node .ok-plumbline/bin/plumbline version >/dev/null 2>&1 )
  if [ $? -ne 0 ]; then
    echo "FAIL: $name — the vendored binary does not run under the ESM root"
    fail=1; rm -rf "$tmp"; return
  fi

  printf '# stray comment under an ESM root\nx = 1\n' > "$tmp/loose.py"
  invoke_hook "$tmp" "$tmp/loose.py"
  if [ $? -ne 2 ]; then
    echo "FAIL: $name — the materialized hook did not load and block under the ESM root"
    fail=1; rm -rf "$tmp"; return
  fi

  rm "$tmp/.ok-plumbline/package.json"
  ( cd "$tmp" && node .ok-plumbline/bin/plumbline version >/dev/null 2>&1 )
  if [ $? -eq 0 ]; then
    echo "FAIL: $name — without the module marker the ESM fixture should fail, but the binary ran"
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(printf '{"tool_input":{"file_path":"%s"}}' "$tmp/loose.py" \
    | CLAUDE_PROJECT_DIR="$tmp" node "$tmp/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -ne 0 ] || [ -n "$out" ]; then
    echo "FAIL: $name — without the module marker the hook must degrade to silence (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_esm_root_case

# @concept: materialized-artifact
# @decision: per-project-pinning
run_module_marker_fidelity_case() {
  local name="the module marker is diagnosed by exact content" tmp out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 && bash "$family/admin/converge" wire-hooks 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(node "$plumbline" diagnose "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — a freshly converged estate does not diagnose clean (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf '{ "type": "commonjs", "private": true }\n' > "$tmp/.ok-plumbline/package.json"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] || ! printf '%s' "$out" | grep -q "differs from its canonical content"; then
    echo "FAIL: $name — a drifted marker whose \"type\" still parses to commonjs was not reported (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  node "$plumbline" module-marker > "$tmp/canonical.json"
  if [ "$rc" -ne 0 ] || ! cmp -s "$tmp/.ok-plumbline/package.json" "$tmp/canonical.json"; then
    echo "FAIL: $name — converge did not restore the canonical bytes (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi
  rm "$tmp/canonical.json"

  node "$plumbline" diagnose "$tmp" >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "FAIL: $name — the repaired estate still does not diagnose clean"
    fail=1; rm -rf "$tmp"; return
  fi

  rm "$tmp/.ok-plumbline/package.json"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] || ! printf '%s' "$out" | grep -q "no module marker"; then
    echo "FAIL: $name — a missing marker in an integrated estate was not reported (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_module_marker_fidelity_case

# @decision: vendored-skills
# @decision: per-project-pinning
run_clone_self_containment_case() {
  local name="a converged clone runs every vendored verb with nothing installed"
  local tmp verb out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  for verb in version starter port; do
    out=$( cd "$tmp" && env -u CLAUDE_PLUGIN_ROOT bash -c \
      "$(skill_run_block "$tmp/.claude/skills/$verb/SKILL.md")" "$verb" . 2>&1 ); rc=$?
    if [ "$rc" -ne 0 ]; then
      echo "FAIL: $name — the vendored $verb verb failed with nothing installed (exit $rc)"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
    if printf '%s' "$out" | grep -q "no vendored binary"; then
      echo "FAIL: $name — the vendored $verb verb reached for the payload instead of the project's binary"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
  done

  rm -rf "$tmp"
  echo "ok: $name"
}
run_clone_self_containment_case

proof_ok()  { echo "ok: proof — $1"; }
proof_bad() { echo "FAIL: proof — $1"; fail=1; fails=$((fails + 1)); }

# @story: edit-time-lint-enforcement
run_message_proof() {
  local repo file out rc
  repo=$(hook_repo)

  file="$repo/legacy.py"
  printf '# pre-existing violation\nx = 1\n' > "$file"
  git -C "$repo" add legacy.py
  git -C "$repo" -c user.email=t@t -c user.name=t commit -q -m legacy

  printf '# pre-existing violation\nx = 1\n# fresh violation\n' > "$file"
  out=$(printf '{"tool_input":{"file_path":"%s"}}' "$file" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1 >/dev/null)
  rc=$?
  if [ "$rc" -eq 2 ] \
     && printf '%s' "$out" | grep -q "legacy.py:3:" \
     && printf '%s' "$out" | grep -q "plumbline/comment-hygiene" \
     && printf '%s' "$out" | grep -q "comment is not permitted"; then
    proof_ok "the block carries file, line and rule on the channel the agent receives"
  else
    proof_bad "the agent was blocked without the violation message (exit $rc): $out"
  fi

  printf '# pre-existing violation\nx = 1\ny = 2\n' > "$file"
  printf '{"tool_input":{"file_path":"%s"}}' "$file" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
  [ $? -eq 0 ] \
    && proof_ok "a clean edit passes while an older violation stands elsewhere in the file" \
    || proof_bad "a clean edit was blocked by an old violation"

  file="$repo/tool"
  printf '#!/usr/bin/env bash\n# stray prose in an extensionless script\necho hi\n' > "$file"
  out=$(printf '{"tool_input":{"file_path":"%s"}}' "$file" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1 >/dev/null)
  rc=$?
  if [ "$rc" -eq 2 ] && printf '%s' "$out" | grep -q "tool:2:"; then
    proof_ok "an extensionless script is checked by its shebang, not skipped"
  else
    proof_bad "an extensionless script was walked past unchecked (exit $rc): $out"
  fi

  rm "$repo/.ok-plumbline/bin/plumbline"
  out=$(printf '{"tool_input":{"file_path":"%s"}}' "$repo/legacy.py" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1)
  rc=$?
  if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
    proof_ok "no vendored binary: the session degrades to silence"
  else
    proof_bad "a missing binary was not silent (exit $rc): $out"
  fi

  rm -rf "$repo"
}
section edit-time-lint-enforcement
run_message_proof

# @story: incremental-lint-adoption
# @story: rules-compliance-report
run_adoption_proof() {
  local repo out rc before after
  repo=$(mktemp -d)
  git -C "$repo" init -q
  mkdir -p "$repo/.ok-plumbline/bin"
  cp "$plumbline" "$repo/.ok-plumbline/bin/plumbline"
  printf '{}\n' > "$repo/.ok-plumbline/config.json"

  mkdir -p "$repo/src"
  printf '# leftover note about the loop\nx = 1\n' > "$repo/src/a.py"
  printf '# leftover note about the parser\ny = 2\n' > "$repo/src/b.py"
  printf '// TODO: revisit this\nconst z = 3;\n' > "$repo/src/c.js"
  printf '// TODO: and this too\nconst w = 4;\n' > "$repo/src/d.js"
  git -C "$repo" add -A
  git -C "$repo" -c user.email=t@t -c user.name=t commit -q -m seed

  node "$plumbline" budget save "$repo" >/dev/null 2>&1
  [ -f "$repo/.ok-plumbline/budget.json" ] \
    && proof_ok "a baseline is recorded in the estate" \
    || proof_bad "no baseline was recorded"

  printf '# one more stray note\nq = 9\n' > "$repo/src/e.py"
  node "$plumbline" budget check "$repo" >/dev/null 2>&1
  [ $? -eq 2 ] \
    && proof_ok "a change adding one violation fails the ratchet check" \
    || proof_bad "an added violation did not fail the ratchet"

  rm "$repo/src/e.py"
  node "$plumbline" budget check "$repo" >/dev/null 2>&1
  [ $? -eq 0 ] \
    && proof_ok "a holding change passes the ratchet check" \
    || proof_bad "a holding change was rejected"

  printf 'x = 1\n' > "$repo/src/a.py"
  out=$(node "$plumbline" budget check "$repo" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "below baseline"; then
    proof_ok "a reducing change passes and is reported as below baseline"
  else
    proof_bad "a reducing change did not pass cleanly (exit $rc): $out"
  fi

  printf '# a whole new stray note\nr = 5\n' > "$repo/src/f.py"
  printf '# and another\ns = 6\n' > "$repo/src/g.py"
  out=$(node "$plumbline" budget save "$repo" 2>&1); rc=$?
  if [ "$rc" -eq 2 ] && printf '%s' "$out" | grep -q "refusing to raise the baseline"; then
    proof_ok "save refuses to raise the baseline — the ratchet is one-way in code"
  else
    proof_bad "save raised the baseline (exit $rc): $out"
  fi
  rm "$repo/src/f.py" "$repo/src/g.py"

  out=$(node "$plumbline" patterns "$repo" 2>&1)
  if printf '%s' "$out" | grep -q "cluster(s)" \
     && printf '%s' "$out" | grep -q "todo-marker" \
     && printf '%s' "$out" | grep -q "disallowed-prose"; then
    proof_ok "the clustered report groups the seeded backlog by shape"
  else
    proof_bad "no clustered report over the seeded backlog: $out"
  fi

  before=$(git -C "$repo" status --porcelain | sort)
  out=$( cd "$repo" && CLAUDE_PLUGIN_ROOT="$family/../.." bash -c "$(skill_run_block "$family/skills/port/SKILL.md")" port-verb . 2>&1 )
  rc=$?
  if [ "$rc" -eq 0 ] \
     && printf '%s' "$out" | grep -q "# Plumbline port plan" \
     && printf '%s' "$out" | grep -q "comment-hygiene" \
     && printf '%s' "$out" | grep -q "Maintain (steady state)"; then
    proof_ok "a port plan enumerates the passes to zero for the seeded backlog"
  else
    proof_bad "the port verb produced no usable plan (exit $rc): $out"
  fi
  [ ! -f "$repo/plumbline-port-plan.md" ] \
    && proof_ok "the port verb is read-only: nothing was written into the project" \
    || proof_bad "the port verb wrote into the project without being asked"

  ( cd "$repo" && CLAUDE_PLUGIN_ROOT="$family/../.." bash -c "$(skill_run_block "$family/skills/port/SKILL.md")" port-verb . ./plan.md >/dev/null 2>&1 )
  [ -f "$repo/plan.md" ] \
    && proof_ok "naming an output path writes the plan there" \
    || proof_bad "an explicitly named output path was not written"
  rm -f "$repo/plan.md"

  out=$( cd "$repo" && bash -c "$(skill_run_block "$family/skills/audit/SKILL.md")" audit-verb 2>&1 ); rc=$?
  after=$(git -C "$repo" status --porcelain | sort)
  if [ "$rc" -eq 0 ] \
     && printf '%s' "$out" | grep -q "by category:" \
     && printf '%s' "$out" | grep -q "top files:" \
     && printf '%s' "$out" | grep -q "plumbline/comment-hygiene" \
     && printf '%s' "$out" | grep -q "src/c.js"; then
    proof_ok "the compliance verb reports the seeded violations grouped by rule and by file"
  else
    proof_bad "the compliance report is not reconcilable against the seeded defects (exit $rc): $out"
  fi
  [ "$before" = "$after" ] \
    && proof_ok "the compliance run left the working tree unchanged" \
    || proof_bad "the compliance run mutated the project"

  rm -rf "$repo"
}
section incremental-lint-adoption rules-compliance-report
run_adoption_proof


# @story: explain-lint-rules
topic_listing() {
  node "$plumbline" explain 2>&1 | sed -n 's/^  \([^ ][^ ]*\)$/\1/p'
}

topic_config_paths() {
  node "$plumbline" explain "$1" 2>&1 | grep -o '[.A-Za-z0-9/_-]*\.json'
}

example_block() {
  node "$plumbline" explain "$1" 2>&1 \
    | awk -v want="$2" 'index($0, "Worked example") > 0 { keep = index($0, want) > 0 } keep'
}

example_config_path() {
  example_block "$1" "$2" | grep -o '[.A-Za-z0-9/_-]*\.json' | head -1
}

sentence_config_path() {
  node "$plumbline" explain "$1" 2>&1 | grep -F -- "$2" | head -1 \
    | grep -o '[.A-Za-z0-9/_-]*\.json' | head -1
}

example_reported_line() {
  example_block "$1" "$2" | awk '
    seen && $0 ~ /[^[:space:]]/ { sub(/^[[:space:]]+/, ""); print; exit }
    index($0, "lint reports:") > 0 { seen = 1 }
  '
}

example_source_file() {
  example_block "$1" "$2" \
    | sed -n 's/^.*[Ii]n \([^ :]*\):$/\1/p' | grep -v '\.json$' | head -1
}

example_source_content() {
  example_block "$1" "$2" | awk '
    /[Ii]n [^ :]*\.json:$/ { next }
    !grab && /[Ii]n [^ :]*:$/ { grab = 1; next }
    grab && /^    / { print substr($0, 5); n = 1; next }
    /^[[:space:]]*$/ { next }
    grab && n { exit }
  '
}

example_config_entry() {
  example_block "$1" "$2" | sed -n 's/^    \({.*}\)$/\1/p' | head -1
}

lint_transcript() {
  local repo=$1 physical out
  physical=$(cd "$repo" && pwd -P)
  out=$(cd "$repo" && node .ok-plumbline/bin/plumbline . 2>&1)
  printf '%s\n' "$out" | sed -e "s|^$physical/||" -e "s|^$repo/||"
}

documented_line_holds() {
  [ -n "$1" ] || return 1
  [ -n "$2" ] || return 1
  printf '%s\n' "$2" | grep -q -x -F -- "$1"
}

brief() {
  local text=$1 max=${2:-100} squashed
  squashed=$(printf '%s' "$text" | tr '\n\t' '  ' | sed -e 's/  */ /g' \
    -e 's/^ *//' -e 's/ *$//')
  if [ "${#squashed}" -gt "$max" ]; then
    printf '%s…' "${squashed:0:$max}"
  else
    printf '%s' "$squashed"
  fi
}

lint_resolved_config() {
  node "$plumbline" diagnose "$1" 2>&1 \
    | sed -n 's/.*[^A-Za-z0-9/_.-]\([.A-Za-z0-9/_-]*\.json\) parses.*/\1/p' | head -1
}

config_path_candidates() {
  python3 - "$plumbline" <<'PY'
import re, sys
src = open(sys.argv[1]).read()
body = src.split('function configPathFor(repoRoot) {', 1)[1].split('\n}\n', 1)[0]
seen = []
for m in re.finditer(r"path\.join\(repoRoot,([^)]*)\)", body):
    parts = [p.strip().strip("'\"") for p in m.group(1).split(',') if p.strip()]
    joined = '/'.join(parts)
    if joined and joined not in seen:
        seen.append(joined)
for s in seen:
    print(s)
PY
}

# @story: explain-lint-rules
lint_repo() {
  local tmp
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  mkdir -p "$tmp/.ok-plumbline/bin" "$tmp/src"
  cp "$plumbline" "$tmp/.ok-plumbline/bin/plumbline"
  printf '{}\n' > "$tmp/.ok-plumbline/config.json"
  printf 'x = 1\n' > "$tmp/src/clean.py"
  printf '%s\n' "$tmp"
}

run_explain_proof() {
  local repo out rc code listing emitted_codes missing exampleless c cfg resolved hyg
  local topics t p mentions divergent ntopics cfgtopic other again doc actual
  local entry ex_file ex_src

  repo=$(lint_repo)
  printf '# a comment the lint rejects\nq = 1\n' > "$repo/src/violating.py"
  out=$(cd "$repo" && node .ok-plumbline/bin/plumbline . 2>&1)
  code=$(printf '%s\n' "$out" | sed -n 's/.*plumbline\/\([a-z-]*\):.*/\1/p' | head -1)
  if [ "$code" = "comment-hygiene" ]; then
    proof_ok "a real lint run names the check code that fired ($code)"
  else
    proof_bad "the lint run named no comment-hygiene violation: $out"
  fi

  out=$(cd "$repo" && node .ok-plumbline/bin/plumbline explain "$code" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q -- "$code"; then
    proof_ok "the project's own committed lint explains the code that fired"
  else
    proof_bad "the committed lint could not explain $code (exit $rc): $out"
  fi

  resolved=$(lint_resolved_config "$repo")
  topics=$(topic_listing)
  ntopics=$(printf '%s\n' $topics | grep -c .)
  mentions=0
  divergent=""
  for t in $topics; do
    out=$(node "$plumbline" explain "$t" 2>&1); rc=$?
    if [ "$rc" -ne 0 ] || [ -z "$out" ]; then
      divergent="$divergent $t(undeliverable)"
      continue
    fi
    for p in $(topic_config_paths "$t"); do
      mentions=$((mentions + 1))
      [ "$p" = "$resolved" ] || divergent="$divergent $t:$p"
    done
  done
  if [ -n "$resolved" ] && [ "$ntopics" -ge 2 ] && [ "$mentions" -ge 1 ] && [ -z "$divergent" ]; then
    proof_ok "every one of the $ntopics topic(s) the verb lists — check codes and configuration topics alike, enumerated from the verb's own listing rather than hardcoded — is deliverable, and all $mentions config-file mention(s) across them name the file the lint resolves ($resolved)"
  else
    proof_bad "a topic's text names a config file the lint does not resolve — resolved '$resolved', $mentions mention(s) over $ntopics topic(s), an empty resolution being a failure and not a pass:$divergent"
  fi
  printf '# SPDX-License-Identifier: Apache-2.0\nq = 1\n' > "$repo/src/violating.py"
  (cd "$repo" && node .ok-plumbline/bin/plumbline .) >/dev/null 2>&1; rc=$?
  if [ "$rc" -eq 0 ] && [ -f "$repo/src/violating.py" ] \
     && grep -q '^#' "$repo/src/violating.py"; then
    proof_ok "comment-hygiene stops firing once the file takes one of the three structural exemptions the explanation names — the file and its comment both still there"
  else
    proof_bad "comment-hygiene still fires on a file satisfying the exemption it documents (exit $rc)"
  fi
  rm -rf "$repo"

  repo=$(lint_repo)
  hyg=$(sentence_config_path comment-hygiene '"citations" array')
  resolved=$(lint_resolved_config "$repo")
  if [ -n "$hyg" ] && [ -n "$resolved" ] && [ "$hyg" = "$resolved" ]; then
    proof_ok "the config path comment-hygiene's own exemption-2 sentence names is the one the lint resolves ($hyg)"
  else
    proof_bad "comment-hygiene's exemption-2 sentence names '$hyg'; the lint resolves '$resolved' — either side empty is a failure, never a pass"
  fi

  doc=$(example_reported_line comment-hygiene 'Worked example.')
  ex_file=$(example_source_file comment-hygiene 'Worked example.')
  ex_src=$(example_source_content comment-hygiene 'Worked example.')
  if [ -n "$ex_file" ] && [ -n "$ex_src" ]; then
    mkdir -p "$repo/$(dirname "$ex_file")"
    printf '%s\n' "$ex_src" > "$repo/$ex_file"
    actual=$(lint_transcript "$repo")
    if documented_line_holds "$doc" "$actual"; then
      proof_ok "comment-hygiene's worked example, built from its own text at run time — the source its block shows, written to the file its block names ($ex_file) — emits the very line its own 'the lint reports:' block documents, also read from the topic: '$doc'"
    else
      proof_bad "comment-hygiene's worked example documents '$doc' but the starting state read out of its own block ($ex_file) emitted: $actual — an empty documented line or an empty run is a failure, never a pass"
    fi
  else
    proof_bad "comment-hygiene's worked example yields no readable starting state (file '$ex_file', source '$(brief "$ex_src")') — an example whose documented inputs cannot be read out of its own block cannot be exercised as documented"
  fi

  if [ -n "$hyg" ] && [ -n "$ex_file" ]; then
    mkdir -p "$repo/$(dirname "$hyg")" "$repo/design/concepts"
    printf '{"citations":[{"tag":"@my-concept:","file_template":"design/concepts/{slug}.md"}]}\n' \
      > "$repo/$hyg"
    printf '// @my-concept: basis-points\nexport function compare(a: number, b: number) {\n  return a * 10000 > b * 10000;\n}\n' \
      > "$repo/$ex_file"
    actual=$(lint_transcript "$repo")
    if printf '%s\n' "$actual" | grep -q 'citation-unresolved' \
       && ! printf '%s\n' "$actual" | grep -q "$ex_file:1: plumbline/comment-hygiene"; then
      proof_ok "the citations entry comment-hygiene's exemption 2 describes takes effect when written at the path that sentence itself names — the same line that fired comment-hygiene above now fires citation-unresolved instead, so the comment is read as a declared citation and not as prose"
    else
      proof_bad "a citations entry written where comment-hygiene's exemption 2 says it lives was not read — the declared citation was judged as prose: $actual"
    fi
    printf '# basis points\n' > "$repo/design/concepts/basis-points.md"
    (cd "$repo" && node .ok-plumbline/bin/plumbline .) >/dev/null 2>&1; rc=$?
    if [ "$rc" -eq 0 ] && grep -q '@my-concept: basis-points' "$repo/$ex_file"; then
      proof_ok "the declared-citation fix comment-hygiene's worked example states, run verbatim against a config at the path exemption 2 names, actually clears the violation — the comment still at the code site"
    else
      proof_bad "comment-hygiene's declared-citation fix leaves the violation firing (exit $rc)"
    fi
  fi
  rm -rf "$repo"

  repo=$(lint_repo)
  cfgtopic=$(sentence_config_path citations 'mechanism for declaring')
  resolved=$(lint_resolved_config "$repo")
  if [ -n "$cfgtopic" ] && [ -n "$resolved" ] && [ "$cfgtopic" = "$resolved" ]; then
    proof_ok "the citations configuration topic — the one that documents the config file itself — names the file the lint resolves ($cfgtopic)"
  else
    proof_bad "the citations topic names '$cfgtopic'; the lint resolves '$resolved' — either side empty is a failure, never a pass"
  fi
  if [ -n "$cfgtopic" ]; then
    mkdir -p "$repo/$(dirname "$cfgtopic")"
    printf '{"citations":[{"tag":"@my-invariant:","appears_in_glob":"**/*_test.*,test_*.py"}]}\n' \
      > "$repo/$cfgtopic"
    printf '# @my-invariant: unheld\nq = 1\n' > "$repo/src/held.py"
    out=$(cd "$repo" && node .ok-plumbline/bin/plumbline . 2>&1)
    if printf '%s' "$out" | grep -q 'citation-unresolved'; then
      proof_ok "the entry shape the citations topic documents, written at the path that topic names, is accepted by the lint and governs the tag it declares"
    else
      proof_bad "the citations topic's own documented entry, written where that topic says configuration lives, did not govern its tag: $out"
    fi
  fi
  rm -rf "$repo"

  repo=$(lint_repo)
  cfg=$(example_config_path citation-unresolved file_template)
  resolved=$(lint_resolved_config "$repo")
  if [ -n "$cfg" ] && [ -n "$resolved" ] && [ "$cfg" = "$resolved" ]; then
    proof_ok "the config path the file_template worked example names in its own block — not the first path anywhere in the topic — is the one the lint resolves ($cfg)"
  else
    proof_bad "the file_template worked example's own block names '$cfg'; the lint resolves '$resolved' — either side empty is a failure, never a pass"
  fi
  entry=$(example_config_entry citation-unresolved file_template)
  ex_file=$(example_source_file citation-unresolved file_template)
  ex_src=$(example_source_content citation-unresolved file_template)
  if [ -n "$cfg" ] && [ -n "$entry" ] && [ -n "$ex_file" ] && [ -n "$ex_src" ]; then
    mkdir -p "$repo/$(dirname "$cfg")"
    printf '{"citations":[%s]}\n' "$entry" > "$repo/$cfg"
    mkdir -p "$repo/design/concepts" "$repo/$(dirname "$ex_file")"
    printf '%s\n' "$ex_src" > "$repo/$ex_file"
    doc=$(example_reported_line citation-unresolved file_template)
    actual=$(lint_transcript "$repo")
    if documented_line_holds "$doc" "$actual"; then
      proof_ok "the file_template worked example, built from its own text at run time — the config entry its block shows ($entry) at the path its block states, the citation its block shows written to the file its block names ($ex_file) — emits the very line its 'the lint reports:' block documents, also read from the topic: '$doc'"
    else
      proof_bad "the file_template worked example documents '$doc' but the starting state read out of its own block (entry $entry at $cfg, citation in $ex_file) emitted: $actual — an empty documented line or an empty run is a failure, never a pass"
    fi

    out=$(cd "$repo" && node .ok-plumbline/bin/plumbline explain citation-unresolved 2>&1); rc=$?
    if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q 'Worked example'; then
      proof_ok "the committed lint explains citation-unresolved with worked examples, not a definition alone"
    else
      proof_bad "citation-unresolved's explanation carries no worked example (exit $rc): $out"
    fi

    printf '# cascade\n' > "$repo/design/concepts/casacde.md"
    (cd "$repo" && node .ok-plumbline/bin/plumbline .) >/dev/null 2>&1; rc=$?
    if [ "$rc" -eq 0 ] && grep -q -F -- "$ex_src" "$repo/$ex_file"; then
      proof_ok "citation-unresolved stops firing once the artifact the slug names exists — the citation the explanation is about is still at the code site"
    else
      proof_bad "citation-unresolved still fires once its slug resolves (exit $rc)"
    fi
  else
    proof_bad "the file_template worked example yields no readable starting state out of its own block — config '$cfg', entry '$entry', file '$ex_file', source '$(brief "$ex_src")' — an example whose documented inputs cannot be read cannot be exercised as documented"
  fi
  rm -rf "$repo"

  repo=$(lint_repo)
  cfg=$(example_config_path citation-unresolved appears_in_glob)
  resolved=$(lint_resolved_config "$repo")
  if [ -n "$cfg" ] && [ -n "$resolved" ] && [ "$cfg" = "$resolved" ]; then
    proof_ok "the config path the appears_in_glob worked example names in its own block — read separately from the file_template example's — is the one the lint resolves ($cfg)"
  else
    proof_bad "the appears_in_glob worked example's own block names '$cfg'; the lint resolves '$resolved' — either side empty is a failure, never a pass"
  fi
  entry=$(example_config_entry citation-unresolved appears_in_glob)
  ex_file=$(example_source_file citation-unresolved appears_in_glob)
  ex_src=$(example_source_content citation-unresolved appears_in_glob)
  if [ -n "$cfg" ] && [ -n "$entry" ] && [ -n "$ex_file" ] && [ -n "$ex_src" ]; then
    mkdir -p "$repo/$(dirname "$cfg")"
    printf '{"citations":[%s]}\n' "$entry" > "$repo/$cfg"
    mkdir -p "$repo/tests" "$repo/$(dirname "$ex_file")"
    printf '%s\n' "$ex_src" > "$repo/$ex_file"
    doc=$(example_reported_line citation-unresolved appears_in_glob)
    actual=$(lint_transcript "$repo")
    if documented_line_holds "$doc" "$actual"; then
      proof_ok "the appears_in_glob worked example's starting state, built from its own text at run time — the config entry its block shows ($entry), the citation its block shows written to the file its block names ($ex_file) — fires exactly as the explanation says it does: the emitted line is the very line its own 'the lint reports:' block documents, also read from the topic: '$doc'"
    else
      proof_bad "the appears_in_glob worked example documents '$doc' but the starting state read out of its own block (entry $entry at $cfg, citation in $ex_file) emitted: $actual — an empty documented line or an empty run is a failure, never a pass"
    fi

    printf 'def test_no_negative_balances():\n    pass\n' > "$repo/tests/ledger_test.py"
    (cd "$repo" && node .ok-plumbline/bin/plumbline .) >/dev/null 2>&1; rc=$?
    if [ "$rc" -ne 0 ]; then
      proof_ok "an identifier merely derived from the slug does not satisfy it — the explanation says so and the lint agrees"
    else
      proof_bad "a derived identifier satisfied the slug, contradicting the explanation"
    fi

    printf '# @my-invariant: no-negative-balances\ndef test_ledger_never_goes_negative():\n    pass\n' \
      > "$repo/tests/ledger_test.py"
    (cd "$repo" && node .ok-plumbline/bin/plumbline .) >/dev/null 2>&1; rc=$?
    if [ "$rc" -eq 0 ] && grep -q -F -- "$ex_src" "$repo/$ex_file"; then
      proof_ok "the appears_in_glob worked example's stated remediation, run verbatim, actually clears the violation — the cited code site untouched"
    else
      proof_bad "the appears_in_glob worked example's stated fix leaves the violation firing (exit $rc)"
    fi
  else
    proof_bad "the appears_in_glob worked example yields no readable starting state out of its own block — config '$cfg', entry '$entry', file '$ex_file', source '$(brief "$ex_src")' — an example whose documented inputs cannot be read cannot be exercised as documented"
  fi
  rm -rf "$repo"

  repo=$(lint_repo)
  resolved=$(lint_resolved_config "$repo")
  other=$(config_path_candidates | grep -v -x -F -- "$resolved" | head -1)
  if [ -n "$resolved" ] && [ -n "$other" ]; then
    proof_ok "the lint can resolve configuration at more than one location — the candidates read out of the resolver's own source, '$resolved' and '$other' — so the path the topics name is a preference, not the only possibility"
  else
    proof_bad "no second config location was readable out of the resolver's source (resolved '$resolved', other '$other'), so its preference order cannot be exercised"
  fi
  if [ -n "$resolved" ] && [ -n "$other" ]; then
    mkdir -p "$repo/$(dirname "$other")" "$repo/design/ghosts"
    printf '{"citations":[{"tag":"@ghost:","file_template":"design/ghosts/{slug}.md"}]}\n' \
      > "$repo/$other"
    printf '# @ghost: absent\nq = 1\n' > "$repo/src/preference.py"
    again=$(lint_resolved_config "$repo")
    out=$(cd "$repo" && node .ok-plumbline/bin/plumbline . 2>&1)
    if [ -n "$again" ] && [ "$again" = "$resolved" ]; then
      proof_ok "with a config at both locations the lint still resolves the one the topics name ($again) — the preference the explanation relies on, exercised rather than assumed"
    else
      proof_bad "with a config at both locations the lint resolved '$again', not the path the topics name ('$resolved')"
    fi
    if printf '%s' "$out" | grep -q 'comment-hygiene' \
       && ! printf '%s' "$out" | grep -q 'citation-unresolved'; then
      proof_ok "the losing location's citations are not read at all — its tag governs nothing, so following the explanation is self-fulfilling rather than merely consistent"
    else
      proof_bad "the losing config location governed the lint's behaviour: $out"
    fi
  fi
  rm -rf "$repo"

  listing=$(node "$plumbline" explain 2>&1); rc=$?
  emitted_codes=$(python3 - "$plumbline" <<'PY'
import re, sys
src = open(sys.argv[1]).read()
consts = dict(re.findall(r"^const (CODE_[A-Z_]+) = '([^']+)';$", src, re.M))
used = set(re.findall(r"code: (CODE_[A-Z_]+),", src))
for name in sorted(used):
    print(consts.get(name, name))
PY
)
  missing=""
  for c in $emitted_codes; do
    printf '%s' "$listing" | grep -q -- "$c" || missing="$missing $c"
  done
  if [ "$rc" -eq 0 ] && [ -z "$missing" ] && [ -n "$emitted_codes" ]; then
    proof_ok "the topic listing covers every check code the lint can emit"
  else
    proof_bad "check codes the lint emits are unexplained (exit $rc):$missing"
  fi

  exampleless=""
  for c in $emitted_codes; do
    node "$plumbline" explain "$c" 2>&1 | grep -q 'Worked example' \
      || exampleless="$exampleless $c"
  done
  if [ -z "$exampleless" ]; then
    proof_ok "every check code the lint can emit carries a worked example — a coverage check over the emittable codes, and nothing more than that"
  else
    proof_bad "check codes explained without a worked example:$exampleless"
  fi
}
section explain-lint-rules
run_explain_proof

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
