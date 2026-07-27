#!/usr/bin/env bash
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
audit_check="$here/../scripts/audit-check"
fixtures="$here/fixtures"
fail=0

run_case() {
  local name=$1 dir=$2 expected_exit=$3 expected_substr=$4
  shift 4
  local output actual_exit
  output=$(python3 "$audit_check" "$dir" "$@" 2>&1)
  actual_exit=$?
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

run_case "clean corpus"            "$fixtures/clean"             0 ""
run_case "missing audit"           "$fixtures/missing-audit"     2 "audit-missing"
run_case "stale artifact"          "$fixtures/stale-artifact"    2 "audit-stale-artifact"
run_case "stale citation anchor"   "$fixtures/stale-citation"    2 "audit-stale-citation"
run_case "stale population source" "$fixtures/stale-popsource"   2 "population source changed"
run_case "violated without issue"  "$fixtures/violated-unlinked" 2 "violated-unlinked"
run_case "violated with issue"     "$fixtures/violated-linked"   0 ""
run_case "orphaned audit"          "$fixtures/orphaned"          2 "audit-orphaned"
run_case "span changed inside"     "$fixtures/span-changed"      2 "the mechanism changed"
run_case "span safe past tail"     "$fixtures/span-tail-safe"    0 ""
run_case "ambiguous span anchor"   "$fixtures/anchor-ambiguous"  2 "anchor-ambiguous"
run_case "re-audit set"            "$fixtures/stale-citation"    2 "story:see-data" --list-stale
run_case "re-audit set popsource"  "$fixtures/stale-popsource"   2 "decision:loopback-ports" --list-stale
# Release-mutable masking: one fixture whose every suite-version stamp
# shape materialization writes — the `Materialized by … vX.Y.Z` line, the
# session hook's `… vX.Y.Z is materialized …` banner, a vendored script
# header naming its family, a VERSION assignment, and the manifest
# version field — sits two releases ahead of the audit that cites it, and
# its twin with a non-version edit on each of those same surfaces.
run_case "version bump masked"     "$fixtures/masked-version-bump" 0 ""
run_case "edit beside stamp trips" "$fixtures/masked-edit-trips"   2 "audit-stale-citation"
run_case "edit in hook banner trips" "$fixtures/masked-edit-trips" 2 "hooks/session-start"
run_case "edit in script header trips" "$fixtures/masked-edit-trips" 2 "in bin/src-tag"
run_case "non-manifest pin trips"  "$fixtures/masked-edit-trips"   2 "rules/cheatsheet.md is sha256"
# A cite-file pin over a non-UTF-8 population source: the two byte
# sequences differ only inside invalid UTF-8, which a lossy decode would
# collapse to the same replacement characters — the pin must still trip.
run_case "binary pin change trips"  "$fixtures/binary-pin-changed" 2 "population source changed"

exit $fail
