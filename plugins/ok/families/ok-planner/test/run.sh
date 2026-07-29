#!/usr/bin/env bash
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
audit_check="$here/../scripts/audit-check"
fixtures="$here/fixtures"
fail=0

# Per-case cost. Every case reports what it took, so a run of this
# harness is itself a profile naming which fixture is expensive rather
# than only that the harness is slow. `proof-timings run` exports
# PROOF_TIMINGS_OUT and folds these lines into the durable record a
# later session reads without re-running anything.
# @story: corpus-proof
# @decision: measure-first-verification-cost
TIMEFORMAT='%3R'
emit_timing() {  # emit_timing <seconds> <verdict> <story> <case-name>
  [ -n "${PROOF_TIMINGS_OUT:-}" ] || return 0
  printf '%s\t%s\t%s\t%s\n' "$1" "$2" "$3" "$4" >> "$PROOF_TIMINGS_OUT"
}

run_case() {
  local name=$1 dir=$2 expected_exit=$3 expected_substr=$4
  shift 4
  local output actual_exit secs verdict captured
  captured=$(mktemp)
  secs=$( { time python3 "$audit_check" "$dir" "$@" >"$captured" 2>&1; } 2>&1 )
  actual_exit=$?
  output=$(cat "$captured")
  rm -f "$captured"
  verdict=ok
  if [ "$actual_exit" -ne "$expected_exit" ]; then
    echo "FAIL: $name — expected exit $expected_exit, got $actual_exit"
    echo "$output" | sed 's/^/    /'
    fail=1
    verdict=fail
  elif [ -n "$expected_substr" ] && ! echo "$output" | grep -q -- "$expected_substr"; then
    echo "FAIL: $name — expected output to contain '$expected_substr'"
    echo "$output" | sed 's/^/    /'
    fail=1
    verdict=fail
  else
    echo "ok: $name (${secs}s)"
  fi
  emit_timing "$secs" "$verdict" "" "$name"
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
# Node citations resolve through the committed source graph: a fresh
# graph verifies the pinned node hash; an edited unit (graph rebuilt)
# trips the citation; an un-rebuilt graph is its own finding rather
# than a silent pass; a missing graph likewise; a renamed declaration
# no longer resolves; and a release that changes only version stamps
# inside the cited node moves no pinned hash once the graph rebuilds.
run_case "node citation clean"       "$fixtures/node-cited-clean"   0 ""
run_case "node content change trips" "$fixtures/node-cited-stale"   2 "the cited content changed"
run_case "node re-audit set"         "$fixtures/node-cited-stale"   2 "decision:node-pin" --list-stale
run_case "stale graph is a finding"  "$fixtures/node-graph-stale"   2 "graph-stale"
run_case "missing graph is a finding" "$fixtures/node-graph-missing" 2 "graph-missing"
run_case "renamed node unresolves"   "$fixtures/node-unresolved"    2 "no longer resolves"
run_case "node stamp bump masked"    "$fixtures/node-masked-bump"   0 ""

# The change-inspection floor (--inspection): every node the
# uncommitted change touched must be dispositioned — mechanically (a
# citation tripped) or by a live registry entry — so a skipped
# inspector pass surfaces as findings instead of vacuous clean.
# These fixtures need git history, so they are built into temp dirs
# from node-cited-clean at run time.
sgraph="$here/../scripts/source-graph"
mk_git_fixture() {
  local d
  d=$(mktemp -d)
  cp -R "$fixtures/node-cited-clean/." "$d/"
  (cd "$d" && git init -q && git add -A && \
   git -c user.email=t@t.t -c user.name=t commit -qm base) >/dev/null
  echo "$d"
}

d=$(mk_git_fixture)
run_case "inspection: clean tree" "$d" 0 "" --inspection
rm -rf "$d"

d=$(mk_git_fixture)
cat > "$d/src/util.js" <<'JS'
function helper(n) {
  return n - 1;
}
module.exports = { helper };
JS
python3 "$sgraph" build "$d" >/dev/null
run_case "inspection: missing registry" "$d" 2 "inspection-missing" --inspection

cat > "$d/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

- node: src/app.js#stay @ sha256:65d67c1d5ccc
  class: residue
  note: increment helper, no audit claims it
REG
run_case "inspection: unclassified node" "$d" 2 "inspection-unclassified" --inspection

pin=$(grep '^node src/util.js#helper ' "$d/.ok-planner/graph/src/util.js.graph" \
      | sed 's/.*sha256:\([0-9a-f]*\).*/\1/')
cat >> "$d/.ok-planner/audits/inspection.md" <<REG
- node: src/util.js#helper @ sha256:$pin
  class: residue
  note: new helper, unclaimed territory
REG
run_case "inspection: residue entry covers" "$d" 0 "" --inspection

python3 - "$d/src/util.js" <<'PY'
import sys
p = sys.argv[1]
open(p, "w").write(open(p).read().replace("n - 1", "n - 2"))
PY
python3 "$sgraph" build "$d" >/dev/null
run_case "inspection: lapsed entry trips" "$d" 2 "inspection-unclassified" --inspection
rm -rf "$d"

d=$(mk_git_fixture)
python3 - "$d/src/app.js" <<'PY'
import sys
p = sys.argv[1]
open(p, "w").write(open(p).read().replace("n * 2", "n * 3"))
PY
python3 "$sgraph" build "$d" >/dev/null
run_case "inspection: mechanical account" "$d" 2 "audit-stale-citation" --inspection
if python3 "$audit_check" "$d" --inspection 2>&1 | grep -q "inspection-"; then
  echo "FAIL: inspection: mechanical account — a citation-tripped change"
  echo "      must need no registry entry, but an inspection finding fired"
  fail=1
else
  echo "ok: inspection: mechanical needs no entry"
fi
rm -rf "$d"

exit $fail
