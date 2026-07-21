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

run_case "clean"                       "$fixtures/clean"                       0 ""
run_case "license-header"              "$fixtures/license-header"              0 ""
run_case "machine-directives"          "$fixtures/machine-directives"          0 ""
run_case "docstring-opted-in"          "$fixtures/docstring-opted-in"          0 ""
run_case "citation-file-resolved"      "$fixtures/citation-file-resolved"      0 ""
run_case "citation-glob-resolved"      "$fixtures/citation-glob-resolved"      0 ""

run_case "disallowed-comment"          "$fixtures/disallowed-comment"          2 "plumbline/comment-hygiene"
run_case "docstring-not-opted-in"      "$fixtures/docstring-not-opted-in"      2 "plumbline/comment-hygiene"
run_case "citation-file-unresolved"    "$fixtures/citation-file-unresolved"    2 "plumbline/citation-unresolved"
run_case "citation-glob-unresolved"    "$fixtures/citation-glob-unresolved"    2 "plumbline/citation-unresolved"

if [ $fail -eq 0 ]; then
  echo "---"
  echo "all tests passed"
fi
exit $fail
