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
  local skill=$1
  python3 - "$family/skills/$skill/SKILL.md" <<'PY'
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

  local output
  output=$(node "$plumbline" "$dir" 2>&1)
  local actual_exit=$?

  if [ "$actual_exit" -ne "$expected_exit" ]; then
    echo "FAIL: $name — expected exit $expected_exit, got $actual_exit"
    echo "$output" | sed 's/^/    /'
    fail=1
    return
  fi

  if [ -n "$expected_substr" ] && ! echo "$output" | grep -q -- "$expected_substr"; then
    echo "FAIL: $name — expected output to contain '$expected_substr'"
    echo "$output" | sed 's/^/    /'
    fail=1
    return
  fi

  echo "ok: $name"
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

proof_ok()  { echo "ok: proof — $1"; }
proof_bad() { echo "FAIL: proof — $1"; fail=1; }

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
  out=$( cd "$repo" && CLAUDE_PLUGIN_ROOT="$family/../.." bash -c "$(skill_run_block port)" port-verb . 2>&1 )
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

  ( cd "$repo" && CLAUDE_PLUGIN_ROOT="$family/../.." bash -c "$(skill_run_block port)" port-verb . ./plan.md >/dev/null 2>&1 )
  [ -f "$repo/plan.md" ] \
    && proof_ok "naming an output path writes the plan there" \
    || proof_bad "an explicitly named output path was not written"
  rm -f "$repo/plan.md"

  out=$( cd "$repo" && bash -c "$(skill_run_block audit)" audit-verb 2>&1 ); rc=$?
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
run_adoption_proof

# @story: rules-compliance-report
run_roster_proof() {
  local families="$family/.." verb body
  for f in ok-planner ok-plumbline ok-workspaces; do
    case "$f" in
      ok-planner) verb="$families/ok-planner/skills/audit/SKILL.md" ;;
      ok-plumbline) verb="$families/ok-plumbline/skills/audit/SKILL.md" ;;
      ok-workspaces) verb="$families/ok-workspaces/skills/audit/SKILL.md" ;;
    esac
    if [ ! -f "$verb" ]; then
      proof_bad "$f: no compliance verb on disk"
      continue
    fi
    body=$(cat "$verb")
    if printf '%s' "$body" | grep -qi "read-only"; then
      proof_ok "$f: its compliance verb declares itself read-only"
    else
      proof_bad "$f: its compliance verb does not declare itself read-only"
    fi
    if printf '%s' "$body" | grep -qi "mechanical" && printf '%s' "$body" | grep -qi "judgment"; then
      proof_ok "$f: its compliance verb separates mechanical fixes from judgment calls"
    else
      proof_bad "$f: its compliance verb delivers no mechanical-vs-judgment remediation view"
    fi
  done
  if grep -q "mkdir -p .ok-planner" "$families/ok-planner/skills/audit/SKILL.md"; then
    proof_bad "ok-planner: its compliance verb still creates directories in the project"
  else
    proof_ok "ok-planner: its compliance verb writes nothing at all, not even its own layout"
  fi
}
run_roster_proof

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
