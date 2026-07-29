#!/usr/bin/env bash
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
audit_check="$here/../scripts/audit-check"
fixtures="$here/fixtures"
fail=0


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

# repoint — the deterministic half of staleness: a pure move (cited
# code changed location, not content) is re-pointed in place; an
# ambiguous move (the same content hash at several identities) is
# left stale for the auditor. A renamed file breaks both cited
# identities here — the unit and the whole-file pin — while their
# recorded hashes stand.
sgraph="$here/../scripts/source-graph"
d=$(mktemp -d)
cp -R "$fixtures/node-cited-clean/." "$d/"
mv "$d/src/app.js" "$d/src/core.js"
python3 "$sgraph" build "$d" >/dev/null
if python3 "$audit_check" repoint "$d" | grep -q "repointed src/app.js#go -> src/core.js#go"; then
  echo "ok: repoint: pure move rewrites the citation"
else
  echo "FAIL: repoint: pure move rewrites the citation"
  fail=1
fi
run_case "repoint: corpus clean after a pure move" "$d" 0 ""
rm -rf "$d"

d=$(mktemp -d)
cp -R "$fixtures/node-cited-clean/." "$d/"
cp "$d/src/app.js" "$d/src/twin.js"
mv "$d/src/app.js" "$d/src/core.js"
python3 "$sgraph" build "$d" >/dev/null
if [ -z "$(python3 "$audit_check" repoint "$d")" ]; then
  echo "ok: repoint: ambiguous move rewrites nothing"
else
  echo "FAIL: repoint: ambiguous move rewrites nothing"
  fail=1
fi
run_case "repoint: ambiguous move stays stale" "$d" 2 "graph-missing"
rm -rf "$d"

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

reset_registry() {  # reset_registry <dir> — an empty but well-formed registry
  cat > "$1/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

REG
}

sub_in_file() {  # sub_in_file <path> <old text> <new text>
  # Read, then write. `open(p, "w").write(open(p).read()...)` truncates
  # before it reads — the file lands empty and every fixture built on it
  # exercises "the whole file vanished" instead of the edit it names.
  python3 - "$1" "$2" "$3" <<'PY'
import sys
path, old, new = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path) as f:
    text = f.read()
if old not in text:
    raise SystemExit("fixture edit found nothing to replace: %r" % old)
with open(path, "w") as f:
    f.write(text.replace(old, new))
PY
  if [ $? -ne 0 ]; then
    echo "FAIL: fixture edit did not apply to $1"
    fail=1
  fi
}

add_node_entry() {  # add_node_entry <dir> <identity> <note>
  (cd "$1" && python3 "$audit_check" cite-node "$2" \
    | sed 's/^- cite-node: /- node: /') \
    >> "$1/.ok-planner/audits/inspection.md"
  printf '  class: residue\n  note: %s\n' "$3" \
    >> "$1/.ok-planner/audits/inspection.md"
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

add_node_entry "$d" src/util.js#helper "new helper, unclaimed territory"
# A brand-new file is not accounted by its units alone: everything it
# declares is new, and so is whatever it carries outside every
# declaration — here the module-level export line.
run_case "inspection: a new file's units leave its module-level content unaccounted" "$d" 2 "node src/util.js has no disposition" --inspection
add_node_entry "$d" src/util.js "the new module's export line, claimed by no audit"
run_case "inspection: residue entries cover a new file whole" "$d" 0 "" --inspection

sub_in_file "$d/src/util.js" "n - 1" "n - 2"
python3 "$sgraph" build "$d" >/dev/null
run_case "inspection: lapsed entry trips" "$d" 2 "inspection-unclassified" --inspection
rm -rf "$d"

d=$(mk_git_fixture)
sub_in_file "$d/src/app.js" "n * 2" "n * 3"
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

# The region outside every declared unit — module-level javascript here;
# markdown frontmatter and top-level shell are the same region. Such a
# change moves the file's own hash and no unit's, so before the file node
# was accounted it entered the changed set nowhere: when it was the whole
# change the floor returned before parsing the registry and exited 0 with
# the judgment pass wholly skipped. Held here in all three directions: a
# skipped pass fails, an unrelated entry does not cover it, and a
# file-node entry does.
mk_committed_util() {  # a base commit that already carries src/util.js
  local d
  d=$(mk_git_fixture)
  cat > "$d/src/util.js" <<'JS'
function helper(n) {
  return n - 1;
}
module.exports = { helper };
JS
  python3 "$sgraph" build "$d" >/dev/null
  (cd "$d" && git add -A && \
   git -c user.email=t@t.t -c user.name=t commit -qm util) >/dev/null
  echo "$d"
}

edit_util_module_level() {  # touch only bytes outside every declared unit
  sub_in_file "$1/src/util.js" "module.exports = { helper };" \
    "module.exports = { helper, alias: helper };"
  python3 "$sgraph" build "$1" >/dev/null
}

d=$(mk_committed_util)
edit_util_module_level "$d"
run_case "inspection: outside-units change is no vacuous clean" "$d" 2 "inspection-missing" --inspection

cat > "$d/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

- node: src/app.js#stay @ sha256:65d67c1d5ccc
  class: residue
  note: an unrelated entry — it covers nothing in util.js
REG
run_case "inspection: outside-units change needs a disposition" "$d" 2 "src/util.js" --inspection

add_node_entry "$d" src/util.js "the module-level export list, claimed by no audit"
run_case "inspection: a file-node entry covers the outside-units region" "$d" 0 "" --inspection
rm -rf "$d"

# The other two directions of the same rule, which a file-hash-moved
# test alone cannot tell apart. A pure in-unit edit must lapse its unit
# and nothing else — the file's hash moves too, but the region outside
# every unit sits exactly where it was, so demanding a file-node
# disposition here would flag a node the change never touched and cost
# the floor its unit granularity.
edit_util_in_unit() {  # touch only bytes inside a declared unit
  sub_in_file "$1/src/util.js" "return n - 1" "return n - 3"
  python3 "$sgraph" build "$1" >/dev/null
}

d=$(mk_committed_util)
edit_util_in_unit "$d"
reset_registry "$d"
add_node_entry "$d" src/util.js#helper "the helper's arithmetic, claimed by no audit"
run_case "inspection: a pure in-unit edit needs no file-node disposition" "$d" 0 "" --inspection
rm -rf "$d"

# And one change touching both at once: the unit's own disposition
# accounts the unit, and the outside-unit bytes still need the file
# node — they are reachable through no other node, so inferring the
# file node's fate from "no unit moved" dropped them silently.
d=$(mk_committed_util)
edit_util_in_unit "$d"
edit_util_module_level "$d"
reset_registry "$d"
add_node_entry "$d" src/util.js#helper "the helper's arithmetic, claimed by no audit"
run_case "inspection: a unit edit does not absorb the outside-units bytes" "$d" 2 "node src/util.js has no disposition" --inspection
add_node_entry "$d" src/util.js "the module-level export list, claimed by no audit"
run_case "inspection: both nodes dispositioned closes the combined change" "$d" 0 "" --inspection
rm -rf "$d"

# A range-scoped run: the gate's subject is a commit range plus the tree,
# so the floor has to judge against the range's base, not against HEAD.
# With the change committed and the tree clean, --inspection alone sees
# nothing; --inspection=<base> sees the same unclassified node it saw
# while the change was uncommitted.
d=$(mk_committed_util)
base=$(cd "$d" && git rev-parse HEAD)
edit_util_module_level "$d"
(cd "$d" && git add -A && \
 git -c user.email=t@t.t -c user.name=t commit -qm outside-units) >/dev/null
run_case "inspection: a committed change leaves the tree-scoped floor clean" "$d" 0 "" --inspection
run_case "inspection: the range-scoped floor sees the committed change" "$d" 2 "inspection-missing" "--inspection=$base"
run_case "inspection: an unresolvable base ref fails closed" "$d" 1 "" "--inspection=no-such-ref"
rm -rf "$d"

exit $fail
