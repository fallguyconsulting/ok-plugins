#!/usr/bin/env bash
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
plumbline="$here/../bin/plumbline"
fixtures="$here/fixtures"
fail=0

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
# End-to-end exercise of the materialized PostToolUse hook: each case builds a
# real repo, materializes the hook and the vendored binary exactly as true-up
# does, and invokes the hook as the harness would — JSON event on stdin. The
# cases pin changed-line scoping (a violation on an untouched line passes, the
# same violation on a changed line blocks), the untracked whole-file check,
# and every fail-open branch degrading to a silent pass.
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

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
