#!/usr/bin/env bash

# @story: edit-time-lint-enforcement
# @story: incremental-lint-adoption
# @story: lint-rules-compliance-report
# @decision: code-cites-design

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

# @decision: comments-forbidden-by-default
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
  hook_case "no repository: estate presence still lints, whole file" 2 $?
  rm -rf "$bare"

  local floater
  floater=$(mktemp -d)
  mkdir -p "$floater/hooks"
  cp "$repo/.ok-plumbline/hooks/post-edit.js" "$floater/hooks/post-edit.js"
  printf '# violation\n' > "$floater/loose.py"
  printf '{"tool_input":{"file_path":"%s"}}' "$floater/loose.py" \
    | CLAUDE_PROJECT_DIR="$floater" node "$floater/hooks/post-edit.js" >/dev/null 2>&1
  hook_case "no plumbline presence at resolved root: silent" 0 $?
  rm -rf "$floater"

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

# @decision: per-project-pinning
skill_fallback_note() {
  skill_run_block "$1" | sed -n 's/^[[:space:]]*echo "\(note: .*\)" >&2$/\1/p' | head -1
}

vendored_skill_file() {
  local root=$1 verb=$2
  if [ -f "$root/.claude/skills/$verb/SKILL.md" ]; then
    printf '%s\n' "$root/.claude/skills/$verb/SKILL.md"
  else
    printf '%s\n' "$root/.claude/skills/$(basename "$family")-$verb/SKILL.md"
  fi
}

run_payload_fallback_announcement_case() {
  local name="with the pinned binary gone, every advisory verb still runs and announces that it fell back to the carried payload — the direction the pinning clause licenses, asserted against the note literal each skill's own run block declares"
  local tmp out rc spec verb want_rc arg want_text skill note payload
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  payload="$family/../.."

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  mkdir -p "$tmp/src"
  printf '# stray note about the loop\nx = 1\n' > "$tmp/src/a.py"
  printf '// TODO: revisit this\nconst z = 3;\n' > "$tmp/src/b.js"

  rm "$tmp/.ok-plumbline/bin/plumbline"

  node "$plumbline" budget save "$tmp" >/dev/null 2>&1
  if [ ! -f "$tmp/.ok-plumbline/budget.json" ]; then
    echo "FAIL: $name — could not record a baseline for the budget verb"
    fail=1; rm -rf "$tmp"; return
  fi

  for spec in \
    'budget|0||plumbline budget:' \
    'explain|0||comment-hygiene' \
    'patterns|2||cluster(s)' \
    'port|0|.|# Plumbline port plan' \
    'starter|0||"citations"' \
    'suggest|0||suggestion:'
  do
    IFS='|' read -r verb want_rc arg want_text <<EOF
$spec
EOF
    skill=$(vendored_skill_file "$tmp" "$verb")
    if [ ! -f "$skill" ]; then
      echo "FAIL: $name — no vendored skill file for the $verb verb"
      fail=1; rm -rf "$tmp"; return
    fi

    note=$(skill_fallback_note "$skill")
    case "$note" in
      "note: no vendored binary"*) ;;
      *)
        echo "FAIL: $name — the $verb verb's run block declares no fallback announcement (read: '$note')"
        fail=1; rm -rf "$tmp"; return
        ;;
    esac

    out=$( cd "$tmp" && CLAUDE_PLUGIN_ROOT="$payload" \
      bash -c "$(skill_run_block "$skill")" "$verb" $arg 2>&1 ); rc=$?

    if [ "$rc" -ne "$want_rc" ]; then
      echo "FAIL: $name — the $verb verb did not run from the payload (expected exit $want_rc, got $rc)"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
    if ! printf '%s\n' "$out" | grep -q -F -- "$want_text"; then
      echo "FAIL: $name — the $verb verb fell back but produced no real output (wanted '$want_text')"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
    if ! printf '%s\n' "$out" | grep -q -x -F -- "$note"; then
      echo "FAIL: $name — the $verb verb ran from the payload without announcing it (wanted the line '$note')"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
  done

  rm -rf "$tmp"
  echo "ok: $name"
}
run_payload_fallback_announcement_case

# @decision: vendored-skills
claiming_families() {
  local verb=$1 dir n=0
  for dir in "$family"/../*/skills/"$verb"; do
    [ -d "$dir" ] && n=$((n + 1))
  done
  printf '%s\n' "$n"
}

run_vendored_name_collision_case() {
  local name="the skill set converge materialized obeys the contract's collision rule — every verb this family claims alone keeps its bare name, the ceremony verbs it claims not at all are absent, and the rendered sibling references were rewritten to match"
  local tmp out rc fam bare
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  fam=$(basename "$family")

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  local v collided=""
  for v in $(cd "$family/.." && for d in */skills/*/; do basename "$d"; done | sort | uniq -d); do
    collided="$collided $v"
  done
  if [ -n "$collided" ]; then
    echo "FAIL: $name — a verb name is claimed by more than one carried family:$collided; the rule's premise must be re-read from the contract"
    fail=1; rm -rf "$tmp"; return
  fi

  bare="$tmp/.claude/skills/explain/SKILL.md"
  if [ ! -f "$bare" ] || [ -e "$tmp/.claude/skills/$fam-explain" ]; then
    echo "FAIL: $name — an unclaimed verb name did not keep its bare form"
    fail=1; rm -rf "$tmp"; return
  fi
  if ! grep -q -x -F -- "name: explain" "$bare" || grep -q -F -- "$fam:explain" "$bare"; then
    echo "FAIL: $name — the materialized bytes do not declare the bare name"
    grep -n -F -- "explain" "$bare" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi
  if grep -q -F -- "$fam:suggest" "$bare"; then
    echo "FAIL: $name — a sibling reference inside the materialized body was not rewritten"
    fail=1; rm -rf "$tmp"; return
  fi

  for v in plan-sprint certify-work audit document; do
    if [ -e "$tmp/.claude/skills/$v" ]; then
      echo "FAIL: $name — the family converge vendored the suite ceremony verb $v"
      fail=1; rm -rf "$tmp"; return
    fi
  done

  rm -rf "$tmp"
  echo "ok: $name"
}
run_vendored_name_collision_case

# @story: record-coding-practices
# @concept: citation-tag
run_practice_corpus_case() {
  local name="the practice corpus is citable: converge lays out the collections, the starter proposes the tags, and a declared tag makes a cited slug resolvable or a violation"
  local tmp out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  local d
  for d in subjects practices audits/subjects; do
    if [ ! -d "$tmp/.ok-plumbline/$d" ]; then
      echo "FAIL: $name — converge did not lay out .ok-plumbline/$d"
      fail=1; rm -rf "$tmp"; return
    fi
  done
  if [ ! -f "$tmp/.ok-plumbline/practice-definitions.md" ]; then
    echo "FAIL: $name — the authoring rules were not materialized"
    fail=1; rm -rf "$tmp"; return
  fi
  for d in subjects practices; do
    if [ ! -f "$tmp/.ok-plumbline/$d.md" ]; then
      echo "FAIL: $name — converge left no catalog TOC beside .ok-plumbline/$d"
      fail=1; rm -rf "$tmp"; return
    fi
  done

  out=$(node "$plumbline" starter "$tmp" 2>/dev/null)
  if ! printf '%s' "$out" | grep -q -F -- '"@subject:"' \
     || ! printf '%s' "$out" | grep -q -F -- '"@practice:"'; then
    echo "FAIL: $name — the starter proposes no citation tags for the collections it found"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf -- '---\npractice: one-registry\nsubject: registries\n---\n\n# One registry\n\n## Practice\n\nEvery handler is registered in the one registry module, by name.\n' \
    > "$tmp/.ok-plumbline/practices/one-registry.md"

  out=$(python3 "$tmp/.ok-plumbline/bin/catalog-toc" --check "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 2 ] || ! printf '%s' "$out" | grep -q "practices.md"; then
    echo "FAIL: $name — a new practice did not make its catalog TOC stale (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi
  python3 "$tmp/.ok-plumbline/bin/catalog-toc" "$tmp" >/dev/null 2>&1
  if ! grep -q -F -- '- `one-registry` (subject: `registries`)' "$tmp/.ok-plumbline/practices.md"; then
    echo "FAIL: $name — the regenerated TOC does not index the new practice or name its subject"
    sed 's/^/    /' "$tmp/.ok-plumbline/practices.md"
    fail=1; rm -rf "$tmp"; return
  fi
  if ! python3 "$tmp/.ok-plumbline/bin/catalog-toc" --check "$tmp" >/dev/null 2>&1; then
    echo "FAIL: $name — the TOC is still stale after regenerating it"
    fail=1; rm -rf "$tmp"; return
  fi

  mkdir -p "$tmp/src"
  printf '// @practice: one-registry\nconst a = 1;\n' > "$tmp/src/good.js"

  out=$(node "$plumbline" "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 2 ] || ! printf '%s' "$out" | grep -q "comment-hygiene"; then
    echo "FAIL: $name — an undeclared @practice: tag was not treated as an ordinary comment (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf '%s\n' '{"citations":[{"tag":"@practice:","file_template":".ok-plumbline/practices/{slug}.md"},{"tag":"@subject:","file_template":".ok-plumbline/subjects/{slug}.md"}]}' \
    > "$tmp/.ok-plumbline/config.json"

  out=$(node "$plumbline" "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — a declared tag citing a real practice did not resolve (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf '// @practice: no-such-practice\nconst b = 2;\n' > "$tmp/src/bad.js"
  out=$(node "$plumbline" "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 2 ] || ! printf '%s' "$out" | grep -q "citation-unresolved"; then
    echo "FAIL: $name — a cited slug naming no practice was not a violation (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_practice_corpus_case

# @story: record-coding-practices
run_estate_diagnose_case() {
  local name="diagnose reports the estate's corpus layer rather than dying on it: a broken config still yields the report, and each missing piece is named"
  local tmp out
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  mkdir -p "$tmp/.ok-plumbline"

  printf '%s\n' '{not json' > "$tmp/.ok-plumbline/config.json"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1)
  if ! printf '%s' "$out" | grep -q "is malformed" \
     || ! printf '%s' "$out" | grep -q "plumbline diagnose"; then
    echo "FAIL: $name — an unparseable config killed the report"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  local shape
  for shape in '[]' '"hello"' '3' 'null'; do
    printf '%s\n' "$shape" > "$tmp/.ok-plumbline/config.json"
    out=$(node "$plumbline" diagnose "$tmp" 2>&1)
    if ! printf '%s' "$out" | grep -q "top level must be an object" \
       || ! printf '%s' "$out" | grep -q "plumbline diagnose"; then
      echo "FAIL: $name — a $shape config did not report as a non-object top level"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
    if node "$plumbline" "$tmp" >/dev/null 2>&1; then
      echo "FAIL: $name — the lint accepted a $shape config the diagnosis rejected"
      fail=1; rm -rf "$tmp"; return
    fi
  done

  printf '%s\n' '{"citations":[{"tag":"@subject:"}]}' > "$tmp/.ok-plumbline/config.json"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1)
  if ! printf '%s' "$out" | grep -q "must set exactly one of" \
     || ! printf '%s' "$out" | grep -q "plumbline diagnose"; then
    echo "FAIL: $name — a structurally invalid config killed the report"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  printf '%s\n' '{}' > "$tmp/.ok-plumbline/config.json"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1)
  local piece
  for piece in "subjects" "practices" "audits/subjects" "practice-definitions.md" "ceremony/audit.md" "subjects.md"; do
    if ! printf '%s' "$out" | grep -q -F -- "$piece"; then
      echo "FAIL: $name — diagnose names no finding for the missing $piece"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
  done
  if ! printf '%s' "$out" | grep -q "citation tags not declared"; then
    echo "FAIL: $name — undeclared citation tags were not reported"
    fail=1; rm -rf "$tmp"; return
  fi

  ( cd "$tmp" && bash "$family/admin/converge" >/dev/null 2>&1 )
  printf '\nhand edit\n' >> "$tmp/.ok-plumbline/ceremony/audit.md"
  out=$(node "$plumbline" diagnose "$tmp" 2>&1)
  if ! printf '%s' "$out" | grep -q "stale or hand-edited: .ok-plumbline/ceremony/audit.md"; then
    echo "FAIL: $name — a hand-edited ceremony contribution was not caught from the payload"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  # @concept: materialized-artifact
  # @story: write-time-prose-steering
  local hook
  for hook in post-edit pre-write; do
    ( cd "$tmp" && bash "$family/admin/converge" >/dev/null 2>&1 )
    printf '\n// hand edit\n' >> "$tmp/.ok-plumbline/hooks/${hook}.js"
    out=$(node "$plumbline" diagnose "$tmp" 2>&1)
    if ! printf '%s' "$out" | grep -q "stale or hand-edited: .ok-plumbline/hooks/${hook}.js"; then
      echo "FAIL: $name — a hand-edited ${hook}.js hook was not caught from the payload"
      printf '%s\n' "$out" | sed 's/^/    /'
      fail=1; rm -rf "$tmp"; return
    fi
  done
  ( cd "$tmp" && bash "$family/admin/converge" >/dev/null 2>&1 )

  out=$(node "$tmp/.ok-plumbline/bin/plumbline" diagnose "$tmp" 2>&1)
  if ! printf '%s' "$out" | grep -q "presence only, not fidelity"; then
    echo "FAIL: $name — the vendored run did not announce its presence-only limit"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_estate_diagnose_case

# @concept: integration-contract
# @decision: whole-file-ownership
run_retired_layout_migration_case() {
  local name="converge migrates the retired root config and budget baseline into the estate — moved, not copied, contents intact, and still governing the lint and the ratchet from their new paths"
  local tmp out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init

  printf '{"citations":[{"tag":"@my-concept:","file_template":"design/concepts/{slug}.md"}]}\n' \
    > "$tmp/.plumbline.json"
  printf '{"count":99,"by_check":{"plumbline/comment-hygiene":99}}\n' \
    > "$tmp/.plumbline-budget.json"
  cp "$tmp/.plumbline.json" "$tmp/config.expected"
  cp "$tmp/.plumbline-budget.json" "$tmp/budget.expected"
  mkdir -p "$tmp/src"
  printf '# @my-concept: absent\nq = 1\n' > "$tmp/src/cited.py"

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge failed (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi
  if ! printf '%s\n' "$out" | grep -q -F -- "config migrated: .plumbline.json -> .ok-plumbline/config.json" \
     || ! printf '%s\n' "$out" | grep -q -F -- "budget baseline migrated: .plumbline-budget.json -> .ok-plumbline/budget.json"; then
    echo "FAIL: $name — converge did not report the two retired-layout migrations"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  if [ -e "$tmp/.plumbline.json" ] || [ -e "$tmp/.plumbline-budget.json" ]; then
    echo "FAIL: $name — a migrated file was copied, not moved: the retired path still exists"
    fail=1; rm -rf "$tmp"; return
  fi
  if ! cmp -s "$tmp/.ok-plumbline/config.json" "$tmp/config.expected" \
     || ! cmp -s "$tmp/.ok-plumbline/budget.json" "$tmp/budget.expected"; then
    echo "FAIL: $name — a migrated file's contents did not survive the move"
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(node "$plumbline" "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 2 ] || ! printf '%s\n' "$out" | grep -q -F -- "src/cited.py:1: plumbline/citation-unresolved"; then
    echo "FAIL: $name — the migrated config does not govern the lint from its new path (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(node "$plumbline" budget check "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 0 ] || ! printf '%s\n' "$out" | grep -q -F -- "below baseline"; then
    echo "FAIL: $name — the migrated baseline is not read from its new path (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_retired_layout_migration_case

run_retired_layout_conflict_case() {
  local name="converge reports a retired/current collision for the owner instead of picking a winner — both copies survive byte-for-byte and the estate's copy keeps governing"
  local tmp out rc
  tmp=$(mktemp -d)
  git -C "$tmp" init -q
  git -C "$tmp" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  mkdir -p "$tmp/.ok-plumbline" "$tmp/src"

  printf '{"citations":[{"tag":"@root:","file_template":"design/root/{slug}.md"}]}\n' \
    > "$tmp/.plumbline.json"
  printf '{"citations":[{"tag":"@dot:","file_template":"design/dot/{slug}.md"}]}\n' \
    > "$tmp/.ok-plumbline/config.json"
  printf '{"count":1,"by_check":{}}\n'  > "$tmp/.plumbline-budget.json"
  printf '{"count":42,"by_check":{}}\n' > "$tmp/.ok-plumbline/budget.json"
  cp "$tmp/.plumbline.json"        "$tmp/root-config.expected"
  cp "$tmp/.ok-plumbline/config.json" "$tmp/dot-config.expected"
  cp "$tmp/.plumbline-budget.json" "$tmp/root-budget.expected"
  cp "$tmp/.ok-plumbline/budget.json" "$tmp/dot-budget.expected"
  printf '# @dot: absent\nq = 1\n'  > "$tmp/src/dot.py"
  printf '# @root: absent\nr = 2\n' > "$tmp/src/root.py"

  out=$( cd "$tmp" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    echo "FAIL: $name — converge aborted on the collision instead of reporting it (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi
  if ! printf '%s\n' "$out" | grep -q -F -- "CONFLICT: both .ok-plumbline/config.json and root .plumbline.json exist" \
     || ! printf '%s\n' "$out" | grep -q -F -- "CONFLICT: both .ok-plumbline/budget.json and root .plumbline-budget.json exist"; then
    echo "FAIL: $name — neither collision was surfaced for the owner"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  if ! cmp -s "$tmp/.plumbline.json"           "$tmp/root-config.expected" \
     || ! cmp -s "$tmp/.ok-plumbline/config.json" "$tmp/dot-config.expected" \
     || ! cmp -s "$tmp/.plumbline-budget.json"  "$tmp/root-budget.expected" \
     || ! cmp -s "$tmp/.ok-plumbline/budget.json" "$tmp/dot-budget.expected"; then
    echo "FAIL: $name — a collided copy was overwritten or removed"
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(node "$plumbline" "$tmp" 2>&1)
  if ! printf '%s\n' "$out" | grep -q -F -- "src/dot.py:1: plumbline/citation-unresolved" \
     || ! printf '%s\n' "$out" | grep -q -F -- "src/root.py:1: plumbline/comment-hygiene"; then
    echo "FAIL: $name — with both copies standing the lint did not keep reading the estate's config"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  out=$(node "$plumbline" budget check "$tmp" 2>&1); rc=$?
  if [ "$rc" -ne 0 ] || ! printf '%s\n' "$out" | grep -q -F -- "below baseline"; then
    echo "FAIL: $name — with both copies standing the baseline read is not the estate's (exit $rc)"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1; rm -rf "$tmp"; return
  fi

  rm -rf "$tmp"
  echo "ok: $name"
}
run_retired_layout_conflict_case

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
# @story: lint-rules-compliance-report
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

  out=$( cd "$repo" && node "$plumbline" . 2>&1 ); rc=$?
  clustered=$( cd "$repo" && node "$plumbline" patterns . 2>&1 )
  after=$(git -C "$repo" status --porcelain | sort)
  if [ "$rc" -eq 2 ] \
     && printf '%s' "$out" | grep -q "plumbline/comment-hygiene" \
     && printf '%s' "$out" | grep -q "src/c.js" \
     && printf '%s' "$clustered" | grep -q "cluster(s)" \
     && printf '%s' "$clustered" | grep -q "comment-hygiene"; then
    proof_ok "the compliance report reaches the seeded violations by rule and by file, and clusters them by shape"
  else
    proof_bad "the compliance report is not reconcilable against the seeded defects (exit $rc): $out"
  fi
  [ "$before" = "$after" ] \
    && proof_ok "the compliance run left the working tree unchanged" \
    || proof_bad "the compliance run mutated the project"

  rm -rf "$repo"
}
section incremental-lint-adoption lint-rules-compliance-report
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

# @story: write-time-prose-steering
# @decision: steering-over-prose-lint
run_steering_proof() {
  local repo out rc
  repo=$(mktemp -d)
  git -C "$repo" init -q
  git -C "$repo" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init

  out=$( cd "$repo" && bash "$family/admin/converge" 2>&1 && bash "$family/admin/converge" wire-hooks 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    proof_bad "converge + wire-hooks failed (exit $rc): $out"
    rm -rf "$repo"; return
  fi

  [ -f "$repo/.ok-plumbline/docs/technical-writing.md" ] \
    && proof_ok "the writing standard is materialized into the estate" \
    || proof_bad "no .ok-plumbline/docs/technical-writing.md after converge"

  if grep -q "post-edit.js" "$repo/.claude/settings.json" \
     && grep -q "pre-write.js" "$repo/.claude/settings.json" \
     && grep -q "stop-review.js" "$repo/.claude/settings.json" \
     && grep -q "PreToolUse" "$repo/.claude/settings.json" \
     && grep -q '"Stop"' "$repo/.claude/settings.json" \
     && grep -q "SubagentStop" "$repo/.claude/settings.json" \
     && [ "$(python3 -c "import json;s=json.load(open('$repo/.claude/settings.json'));print(s['hooks']['PreToolUse'][0]['matcher']+'|'+s['hooks']['PostToolUse'][0]['matcher'])")" = "|" ]; then
    proof_ok "one consent wires every entry: PreToolUse and PostToolUse on every tool, Stop and SubagentStop for the review"
  else
    proof_bad "wire-hooks did not transcribe the four entries into .claude/settings.json"
  fi

  node "$plumbline" diagnose "$repo" >/dev/null 2>&1 \
    && proof_ok "a converged, wired estate diagnoses clean with the steering layer in place" \
    || proof_bad "diagnose is not clean after converge + wire-hooks"

  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Write","tool_input":{"file_path":"%s"}}' "$repo/notes.md" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>/dev/null); rc=$?
  if [ "$rc" -eq 0 ] \
     && printf '%s' "$out" | grep -q '"permissionDecision":"allow"' \
     && printf '%s' "$out" | grep -q '"additionalContext"' \
     && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "a markdown write receives the writing standard as context and the write proceeds"
  else
    proof_bad "no writing standard injected for a markdown write (exit $rc): $out"
  fi

  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Edit","agent_id":"sub-1","agent_type":"general-purpose","tool_input":{"file_path":"%s"}}' "$repo/notes.md" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>/dev/null); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "a dispatched subagent's markdown edit receives the same injection"
  else
    proof_bad "a subagent-shaped event was not steered (exit $rc): $out"
  fi

  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Write","tool_input":{"file_path":"%s"}}' "$repo/main.go" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>/dev/null); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "a non-markdown write receives the standard: the file kind is not consulted"
  else
    proof_bad "a non-markdown write was not steered (exit $rc): $out"
  fi

  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Bash","session_id":"s1","tool_use_id":"t1","tool_input":{"command":"ls"}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>/dev/null); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "a Bash call receives the standard: a heredoc is steered like a Write"
  else
    proof_bad "a Bash call was not steered (exit $rc): $out"
  fi
  [ -f "${TMPDIR:-/tmp}/ok-plumbline-tool-start-t1" ] \
    && proof_ok "a Bash call leaves a start marker for the post hook's changed-file scan" \
    || proof_bad "no start marker written for the Bash call"
  rm -f "${TMPDIR:-/tmp}/ok-plumbline-tool-start-t1"

  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Grep","tool_input":{"pattern":"x"}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>/dev/null); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "every tool call receives the standard, whatever the tool"
  else
    proof_bad "a non-writing tool call was not steered (exit $rc): $out"
  fi

  # @decision: filesystem-discovery-markers
  local bare
  bare=$(mktemp -d)
  mkdir -p "$bare/.ok-plumbline/hooks" "$bare/.ok-plumbline/docs"
  cp "$repo/.ok-plumbline/hooks/pre-write.js" "$bare/.ok-plumbline/hooks/pre-write.js"
  cp "$repo/.ok-plumbline/docs/technical-writing.md" "$bare/.ok-plumbline/docs/technical-writing.md"
  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Write","tool_input":{"file_path":"%s"}}' "$bare/notes.md" \
    | CLAUDE_PROJECT_DIR="$bare" node "$bare/.ok-plumbline/hooks/pre-write.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb"; then
    proof_ok "no repository: estate presence alone still steers the write, with no .git anywhere"
  else
    proof_bad "with no .git anywhere the steering hook did not inject (exit $rc): $out"
  fi
  rm -rf "$bare"

  local floater
  floater=$(mktemp -d)
  mkdir -p "$floater/hooks"
  cp "$repo/.ok-plumbline/hooks/pre-write.js" "$floater/hooks/pre-write.js"
  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Write","tool_input":{"file_path":"%s"}}' "$floater/notes.md" \
    | CLAUDE_PROJECT_DIR="$floater" node "$floater/hooks/pre-write.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
    proof_ok "no plumbline presence at the resolved root: the steering hook is silent"
  else
    proof_bad "a rootless, presence-free write was not silent (exit $rc): $out"
  fi
  rm -rf "$floater"

  rm "$repo/.ok-plumbline/docs/technical-writing.md"
  out=$(printf '{"hook_event_name":"PreToolUse","tool_name":"Write","tool_input":{"file_path":"%s"}}' "$repo/notes.md" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
    proof_ok "fail-open: with the standard missing the hook degrades to silence, never blocks"
  else
    proof_bad "a missing standard was not silent (exit $rc): $out"
  fi

  rm -rf "$repo"
}
section write-time-prose-steering
run_steering_proof

run_prose_review_proof() {
  local repo out rc flag
  repo=$(mktemp -d)
  git -C "$repo" init -q
  git -C "$repo" -c user.email=t@t -c user.name=t commit -q --allow-empty -m init
  out=$( cd "$repo" && bash "$family/admin/converge" 2>&1 ); rc=$?
  if [ "$rc" -ne 0 ]; then
    proof_bad "converge failed (exit $rc): $out"
    rm -rf "$repo"; return
  fi
  local tmpd="${TMPDIR:-/tmp}"
  flag="$tmpd/ok-plumbline-prose-written-sessA"
  rm -f "$flag"

  local prose='The create path brings a deployment up and then dies, and no folder a new user can stand in gets past it. The connect path does exactly what the story says it does.'
  out=$(printf '{"hook_event_name":"PostToolUse","tool_name":"Write","session_id":"sessA","tool_input":{"file_path":"%s","content":"%s"}}' "$repo/notes.md" "$prose" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -f "$flag" ] && grep -q "notes.md" "$flag"; then
    proof_ok "a Write carrying prose passes and flags the agent's turn as prose-bearing"
  else
    proof_bad "a prose Write did not flag the turn (exit $rc, flag $([ -f "$flag" ] && echo present || echo absent)): $out"
  fi

  rm -f "$flag"
  out=$(printf '{"hook_event_name":"PostToolUse","tool_name":"Write","session_id":"sessA","tool_input":{"file_path":"%s","content":"x = 1\\ny = compute(x, 2)\\nreturn y\\n"}}' "$repo/code.py" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ ! -f "$flag" ]; then
    proof_ok "a Write carrying only code leaves no flag"
  else
    proof_bad "a code-only write flagged the turn or blocked (exit $rc): $out"
  fi

  rm -f "$flag"
  printf '{"hook_event_name":"PreToolUse","tool_name":"Bash","session_id":"sessA","tool_use_id":"tb1","tool_input":{"command":"x"}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/pre-write.js" >/dev/null 2>&1
  sleep 1
  printf '# Notes\n\nThe create path brings a deployment up and then dies, and no folder a new user can stand in gets past it.\n' > "$repo/heredoc.md"
  out=$(printf '{"hook_event_name":"PostToolUse","tool_name":"Bash","session_id":"sessA","tool_use_id":"tb1","tool_input":{"command":"cat > heredoc.md <<EOF\\n...\\nEOF"}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -f "$flag" ] && grep -q "heredoc.md" "$flag"; then
    proof_ok "prose a Bash heredoc wrote to disk is found by the start marker and flagged"
  else
    proof_bad "a heredoc-written file escaped the detector (exit $rc): $out $(cat "$flag" 2>/dev/null)"
  fi

  rm -f "$flag"
  out=$(printf '{"hook_event_name":"PostToolUse","tool_name":"Bash","session_id":"sessA","tool_use_id":"tb2","tool_input":{"command":"git commit -q -m \\"Converge the ok suite\\" -m \\"The create path brings a deployment up and then dies, and nothing a new user can do gets past it.\\""}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -f "$flag" ] && grep -q "Bash command text" "$flag"; then
    proof_ok "prose in a Bash command itself — a commit message — is flagged"
  else
    proof_bad "a commit message escaped the detector (exit $rc): $out"
  fi

  rm -f "$flag"
  out=$(printf '{"hook_event_name":"PostToolUse","tool_name":"Bash","session_id":"sessA","tool_use_id":"tb3","tool_input":{"command":"ls -la"}}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ ! -f "$flag" ]; then
    proof_ok "a Bash call that writes no prose leaves no flag"
  else
    proof_bad "a prose-free Bash call flagged the turn or blocked (exit $rc): $out"
  fi

  out=$(printf '{"hook_event_name":"Stop","session_id":"sessA","stop_hook_active":false}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/stop-review.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
    proof_ok "a stop with no prose written this turn passes in silence"
  else
    proof_bad "a prose-free stop was blocked (exit $rc): $out"
  fi

  printf 'Write\t%s\nBash\tthe Bash command text\n' "$repo/notes.md" > "$flag"
  out=$(printf '{"hook_event_name":"Stop","session_id":"sessA","stop_hook_active":false}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/stop-review.js" 2>&1 >/dev/null); rc=$?
  if [ "$rc" -eq 2 ] \
     && printf '%s' "$out" | grep -q "plumbline/prose" \
     && printf '%s' "$out" | grep -q "review every sentence you wrote" \
     && printf '%s' "$out" | grep -q "Write notes.md" \
     && printf '%s' "$out" | grep -q "Bash the Bash command text" \
     && printf '%s' "$out" | grep -q "Name an actor as the subject and its action as the verb" \
     && [ ! -f "$flag" ]; then
    proof_ok "a stop after prose was written is blocked once with the review instruction, the sources, and the standard"
  else
    proof_bad "the stop review did not block as expected (exit $rc): $out"
  fi

  out=$(printf '{"hook_event_name":"Stop","session_id":"sessA","stop_hook_active":true}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/stop-review.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ -z "$out" ]; then
    proof_ok "the retry after the review stops cleanly: no loop"
  else
    proof_bad "the post-review stop was blocked again (exit $rc): $out"
  fi

  printf 'Write\t%s\n' "$repo/notes.md" > "$flag"
  out=$(printf '{"hook_event_name":"Stop","session_id":"sessA","stop_hook_active":true}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/stop-review.js" 2>&1); rc=$?
  if [ "$rc" -eq 0 ] && [ ! -f "$flag" ]; then
    proof_ok "prose written during the review itself is consumed by the retry stop, never carried into the next turn"
  else
    proof_bad "the retry stop left a flag or blocked (exit $rc): $out"
  fi

  local subflag="$tmpd/ok-plumbline-prose-written-agent-7"
  rm -f "$subflag" "$flag"
  printf '{"hook_event_name":"PostToolUse","tool_name":"Write","session_id":"sessA","agent_id":"agent-7","agent_type":"general-purpose","tool_input":{"file_path":"%s","content":"%s"}}' "$repo/sub.md" "$prose" \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/post-edit.js" >/dev/null 2>&1
  out=$(printf '{"hook_event_name":"SubagentStop","session_id":"sessA","agent_id":"agent-7","stop_hook_active":false}' \
    | CLAUDE_PROJECT_DIR="$repo" node "$repo/.ok-plumbline/hooks/stop-review.js" 2>&1 >/dev/null); rc=$?
  if [ "$rc" -eq 2 ] && printf '%s' "$out" | grep -q "Write sub.md" && [ ! -f "$flag" ]; then
    proof_ok "a subagent's prose is keyed to the subagent: its own stop reviews it and the main agent's stop is untouched"
  else
    proof_bad "subagent prose was not reviewed at SubagentStop or leaked to the session (exit $rc): $out"
  fi

  rm -f "$flag" "$subflag"
  rm -rf "$repo"
}
section write-time-prose-steering
run_prose_review_proof

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
