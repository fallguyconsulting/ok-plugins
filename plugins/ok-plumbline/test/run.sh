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

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
