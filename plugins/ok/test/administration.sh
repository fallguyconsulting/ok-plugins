#!/usr/bin/env bash
# Test harness for the front door's administration of the carried
# families: family discovery is a filesystem check, and a family's
# converge core is an idempotent installer — a bootstrap from nothing,
# a repair after deliberate drift in a suite-owned file, and a no-op on
# the resulting compliant estate, with hook wiring written only by the
# consented wire-hooks path and the retired merged verb removed.
#
# The consolidated act is exercised at the end over a project carrying
# one integrated family and one carried-but-unintegrated family: marker
# discovery splits them, the consented family is administered in the
# same pass while the declined one is left untouched, and the closing
# table's cells — carried version, project-stamped version, outcome —
# are read back off the filesystem the run leaves behind. The dialogue
# itself — the single bootstrap question, the recorded decline, the
# printed table — is prompt-realized and carries no deterministic
# check here; its verification is the implementation audit.
#
# Two things converge does that nothing else does are exercised here
# against the estate a real run leaves behind: it sweeps the payloads and
# story sections earlier suite versions owned — files and whole
# directories alike, the retired corpus view among them — and, at the
# suite's own layer, it vendors the four ceremony verbs under their bare
# names while retiring the family-prefixed audit verbs they replaced.
#
# @story: one-command-suite-upkeep
# @story: converge-project-estate
# @decision: vendored-skills
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
suite_repo="$(cd "$here/../../.." && pwd)"
planner_core="$suite_repo/plugins/ok/families/ok-planner/admin/converge"
suite_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "$suite_repo/plugins/ok/.claude-plugin/plugin.json" | head -1)

fail=0
fails=0
ok()   { echo "ok: $1"; }
bad()  { echo "FAIL: $1"; fail=1; fails=$((fails + 1)); }

section() { :; }  # readability marker; sections carry no machinery

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cd "$tmp"
git init -q .
git -c user.email=test@example.com -c user.name=test commit -q --allow-empty -m init

# --- Discovery is a filesystem check (the contract's markers) ---------------
section one-command-suite-upkeep
[ ! -d .ok-planner ] && ok "no marker, no integration: .ok-planner/ absent means bootstrap candidate" \
  || bad "fresh project unexpectedly carries .ok-planner/"

# A retired merged verb from an earlier suite version, awaiting removal.
mkdir -p .claude/skills/true-up
echo "stale merged verb" > .claude/skills/true-up/SKILL.md

# --- Pass 1: bootstrap from nothing -----------------------------------------
section converge-project-estate
out=$(bash "$planner_core" 2>&1)
if [ -d .ok-planner/issues ] && [ -d .ok-planner/history/sprints ]; then
  ok "bootstrap materializes the estate layout"
else
  bad "bootstrap did not create the estate layout"; echo "$out"
fi
grep -q "Materialized by ok-planner v${suite_version}" .ok-planner/CLAUDE.md \
  && ok "estate guide stamped with the suite version (front-door manifest)" \
  || bad "estate guide missing the suite-version stamp"
[ -f .claude/rules/ok-planner-cheatsheet.md ] \
  && ok "cheatsheet materialized" || bad "cheatsheet missing"
[ -x .ok-planner/hooks/session-start ] \
  && ok "session-start hook materialized into the estate" || bad "session-start hook missing"
# Completeness of the vendored set is asserted against the family's own
# vendoring map rather than a hand-maintained floor: a hard-coded count
# rots into a false failure the moment a verb is retired (as `browse`
# was) and into a silent pass the moment one is added. The map is the
# declaration of what should be vendored; what it cannot vouch for is
# that converge actually wrote it, which is what is checked here —
# every mapped destination present, and nothing extra beside it. The
# collision rule the map could misdeclare is checked separately below,
# against the rule itself.
expected_skills=$(python3 - "$planner_core" <<'PY'
import ast, re, sys
src = open(sys.argv[1]).read()
m = re.search(r"^SKILLS = \{.*?^\}", src, re.S | re.M)
for name in sorted(ast.literal_eval(m.group(0).split("=", 1)[1].strip()).values()):
    print(name)
PY
)
want=$(grep -c . <<<"$expected_skills")
missing=""
while IFS= read -r s; do
  [ -n "$s" ] || continue
  [ -f ".claude/skills/$s/SKILL.md" ] || missing="$missing $s"
done <<<"$expected_skills"
n=$(find .claude/skills -name SKILL.md | wc -l | tr -d ' ')
if [ "$want" -lt 1 ]; then
  bad "could not read the family's vendoring map out of admin/converge"
elif [ -z "$missing" ] && [ "$n" -eq "$want" ]; then
  ok "vendored skill set written: every verb the family's map declares, and no others ($n)"
else
  bad "vendored skill set disagrees with the family's vendoring map (found $n, map declares $want; missing:${missing:- none})"
fi
[ ! -e .claude/skills/true-up ] \
  && ok "retired merged true-up verb removed on converge" \
  || bad "retired merged true-up verb still present"
[ ! -e .ok-planner/bin/audit-check ] \
  && ok "the retired audit-corpus checker is not materialized (the audit run no longer runs a shape tool)" \
  || bad "bin/audit-check materialized despite the tool being retired"
[ ! -e .ok-planner/bin/document-check ] \
  && ok "the retired documentation-corpus checker is not materialized (the documentation run no longer runs a shape tool)" \
  || bad "bin/document-check materialized despite the tool being retired"
[ ! -e .ok-planner/bin/surface-reconcile ] \
  && ok "the retired surface reconciler is not materialized (the audit dispatches a surface extractor subagent each run)" \
  || bad "bin/surface-reconcile materialized despite the tool being retired"
for goal in audit-goal document-goal; do
  [ -f ".ok-planner/ceremony/$goal.md" ] \
    && ok "ceremony goal file materialized ($goal.md)" \
    || bad ".ok-planner/ceremony/$goal.md missing after converge"
done
grep -q "^/goal the audit run described in .ok-planner/ceremony/audit-goal.md" \
    .ok-planner/ceremony/audit-goal.md \
  && ok "the audit goal file carries the one-line /goal paste" \
  || bad "the audit goal file lost its one-line /goal paste"
grep -q "WIRING NEEDED" <<<"$out" \
  && ok "unwired hook surfaces as a WIRING NEEDED block, not a silent write" \
  || bad "no WIRING NEEDED block for the unwired hook"
[ ! -f .claude/settings.json ] \
  && ok "converge alone never touches .claude/settings.json" \
  || bad "converge wrote .claude/settings.json without consent"

# --- Consented wiring: the wire-hooks path is the only settings writer ------
bash "$planner_core" wire-hooks >/dev/null 2>&1
matcher=$(python3 -c "import json;print(json.load(open('.claude/settings.json'))['hooks']['SessionStart'][0]['matcher'])" 2>/dev/null)
[ "$matcher" = "startup|clear|compact" ] \
  && ok "wire-hooks transcribes the exact consented entry (startup|clear|compact)" \
  || bad "wire-hooks entry wrong or missing (matcher: ${matcher:-none})"

# --- Pass 2: repair after deliberate drift in a suite-owned file ------------
echo "local edit" >> .ok-planner/CLAUDE.md
if bash "$planner_core" diagnose >/dev/null 2>&1; then
  bad "diagnose missed drift in a suite-owned file"
else
  ok "diagnose reports drift in a suite-owned file (read-only, non-zero exit)"
fi
bash "$planner_core" >/dev/null 2>&1
grep -q "local edit" .ok-planner/CLAUDE.md \
  && bad "converge failed to repair the drifted suite-owned file" \
  || ok "converge repairs the drifted suite-owned file by overwrite"

# --- Pass 3: no-op on a compliant estate -------------------------------------
git add -A
git -c user.email=test@example.com -c user.name=test commit -qm "converged estate"
bash "$planner_core" >/dev/null 2>&1
if [ -z "$(git status --porcelain)" ]; then
  ok "third pass is a no-op: git status empty on a compliant estate"
else
  bad "third pass churned the working tree:"; git status --porcelain
fi
bash "$planner_core" diagnose >/dev/null 2>&1 \
  && ok "diagnose clean on the converged estate" \
  || bad "diagnose still reports findings on the converged estate"

# --- converge-project-estate: the upgrade sweep over a legacy estate --------
# An estate materialized by an earlier suite version carries payloads this
# version no longer owns and stories carrying the retired `## Falsifier`,
# `## Proof` and `## Acceptance` sections. All of it is suite-owned, so
# removing it is converge's job and not a consent question — but a sweep
# that overreaches is worse than one that under-reaches, so what survives
# matters as much as what goes: everything outside the retired sections
# must come through byte-for-byte. Pre-migration layout is the third
# thing: converge never migrates it, it reports every marker it found and
# points at the administration document.
# @story: converge-project-estate
section converge-project-estate
legacy=$(mktemp -d)
(
  cd "$legacy"
  git init -q .
  git -c user.email=test@example.com -c user.name=test commit -q --allow-empty -m init
)
mkdir -p "$legacy/.ok-planner/context" "$legacy/.ok-planner/hooks" "$legacy/.ok-planner/bin" \
         "$legacy/.ok-planner/design/stories" "$legacy/.ok-planner/design/concepts" \
         "$legacy/.ok-planner/design/decisions" "$legacy/.ok-planner/design/tensions" \
         "$legacy/.ok-planner/plans" "$legacy/.ok-planner/coverage" \
         "$legacy/.ok-planner/specs" "$legacy/.ok-planner/history/specs" \
         "$legacy/.ok-planner/backlogs" "$legacy/.ok-planner/history/backlogs"

# Retired estate payloads, one per path the sweep is responsible for.
# The last five are the retired corpus view: its service, its up/down
# helper, the build converge used to place, the machine-local run state
# the helper recorded, and the estate ignore file whose only entries
# covered those two directories. Two are directories, so the sweep has
# to remove more than plain files.
echo "stale index" > "$legacy/.ok-planner/context/skills-index.md"
echo "stale hook"  > "$legacy/.ok-planner/hooks/user-prompt-submit"
echo "stale timer" > "$legacy/.ok-planner/bin/proof-timings"
echo '{"runs":[]}' > "$legacy/.ok-planner/proof-timings.json"
echo "stale view"  > "$legacy/.ok-planner/bin/corpus-view"
echo "stale browse" > "$legacy/.ok-planner/bin/browse"
mkdir -p "$legacy/.ok-planner/browser" "$legacy/.ok-planner/run"
echo "stale build" > "$legacy/.ok-planner/browser/index.html"
echo "4242 7777"   > "$legacy/.ok-planner/run/corpus-view"
printf 'browser/\nrun/\n' > "$legacy/.ok-planner/.gitignore"

# The retired public-surface apparatus a legacy estate carries: the
# reconciler tool, the declaration, the guidance, the per-kind
# committed member lists, the stamped ruling, and any cached
# extraction from an earlier release. All swept on converge; the
# .ok-planner/surface/ directory itself survives — the new intent
# document lives there. Seeded before converge and asserted after.
mkdir -p "$legacy/.ok-planner/surface/members" \
         "$legacy/.ok-planner/audits/surface"
echo "stale reconciler" > "$legacy/.ok-planner/bin/surface-reconcile"
echo '{"kinds":[]}'     > "$legacy/.ok-planner/surface/surface.json"
echo "stale guidance"   > "$legacy/.ok-planner/surface/guidance.md"
echo "GET /v1"          > "$legacy/.ok-planner/surface/members/routes"
echo '{"commit":"x"}'   > "$legacy/.ok-planner/audits/surface/ruling.json"
echo '{"commit":"x"}'   > "$legacy/.ok-planner/audits/surface/extraction.json"

# The retired documentation-corpus checker: an earlier release
# materialized it into consumer estates; the ceremony no longer runs
# a shape checker, so converge sweeps it on sight.
echo "stale doc-checker" > "$legacy/.ok-planner/bin/document-check"

# Pre-migration markers converge reports but never migrates.
echo '{"id":1}' > "$legacy/.ok-planner/issues.jsonl"
echo "old notes" > "$legacy/.ok-planner/design/review-notes.md"
printf '# D\n\n## Choice\n\nc\n\n## Proof\n\np\n' > "$legacy/.ok-planner/design/decisions/d.md"

# The retired falsifier concept and its catalog line; the sibling concept
# line beside it proves the TOC edit is surgical.
echo "the retired kind" > "$legacy/.ok-planner/design/concepts/falsifier.md"
cat > "$legacy/.ok-planner/design/concepts.md" <<'MD'
# Concept catalog

- [`estate`](concepts/estate.md) — the project-side directory
- [`falsifier`](concepts/falsifier.md) — the retired kind
MD

# A story carrying all three retired sections interleaved with prose that
# must survive; the expectation beside it is the same file minus exactly
# those sections.
cat > "$legacy/.ok-planner/design/stories/keep.md" <<'MD'
# Story: keep

## Story

As a maintainer I want retired sections eliminated on sight so that a story
is its statement alone.

## Falsifier

A converged estate still carries a falsifier section.

## Proof

Run the administration harness.

## Notes

This prose sits outside the retired sections and must survive byte-for-byte.

## Acceptance

- every retired section is gone
MD
cat > "$legacy/expected-story.md" <<'MD'
# Story: keep

## Story

As a maintainer I want retired sections eliminated on sight so that a story
is its statement alone.

## Notes

This prose sits outside the retired sections and must survive byte-for-byte.

MD

legacy_out=$(cd "$legacy" && bash "$planner_core" 2>&1)

retired_paths="context/skills-index.md hooks/user-prompt-submit bin/proof-timings proof-timings.json bin/corpus-view bin/browse browser run .gitignore"
for p in $retired_paths; do
  [ ! -e "$legacy/.ok-planner/$p" ] \
    && ok "retired estate payload swept on converge: .ok-planner/$p" \
    || bad "retired estate payload survived converge: .ok-planner/$p"
done
grep -qF "Retired payloads removed: ${retired_paths}" <<<"$legacy_out" \
  && ok "converge names every retired payload it removed" \
  || bad "converge did not report the retired payloads it removed"

# The retired surface apparatus: the reconciler binary and the whole
# declaration/guidance/members/ruling/extraction set are swept, but the
# .ok-planner/surface/ directory itself must survive (the new intent
# lives there). Converge names what it swept.
for p in bin/surface-reconcile surface/surface.json surface/guidance.md \
         surface/members audits/surface/ruling.json \
         audits/surface/extraction.json; do
  [ ! -e "$legacy/.ok-planner/$p" ] \
    && ok "retired surface apparatus swept on converge: .ok-planner/$p" \
    || bad "retired surface apparatus survived converge: .ok-planner/$p"
done
[ -d "$legacy/.ok-planner/surface" ] \
  && ok ".ok-planner/surface/ directory survives the sweep — the owner-authored intent lives there" \
  || bad ".ok-planner/surface/ directory was removed by the sweep"
grep -qF "Retired surface apparatus swept:" <<<"$legacy_out" \
  && ok "converge names the retired surface apparatus it swept" \
  || bad "converge did not report the retired surface apparatus sweep"
grep -qF "No surface intent document at .ok-planner/surface/surface.md" <<<"$legacy_out" \
  && ok "converge advises when the surface intent is absent (the audit will file an intake issue)" \
  || bad "converge did not advise the missing surface intent after the sweep"
grep -qF "Retired binary removed: .ok-planner/bin/surface-reconcile" <<<"$legacy_out" \
  && ok "converge names the retired surface-reconcile binary it removed" \
  || bad "converge did not report the removed surface-reconcile binary"
[ ! -e "$legacy/.ok-planner/bin/document-check" ] \
  && ok "the retired documentation-corpus checker is swept on converge" \
  || bad ".ok-planner/bin/document-check survived converge"
grep -qF "Retired binary removed: .ok-planner/bin/document-check" <<<"$legacy_out" \
  && ok "converge names the retired document-check binary it removed" \
  || bad "converge did not report the removed document-check binary"

if cmp -s "$legacy/expected-story.md" "$legacy/.ok-planner/design/stories/keep.md"; then
  ok "## Falsifier / ## Proof / ## Acceptance stripped, the rest of the story byte-for-byte intact"
else
  bad "the story sweep changed more (or less) than the three retired sections:"
  diff "$legacy/expected-story.md" "$legacy/.ok-planner/design/stories/keep.md"
fi
grep -qF "Retired story sections eliminated: 1 story file(s) stripped" <<<"$legacy_out" \
  && ok "converge reports the story files it stripped" \
  || bad "converge did not report the stripped story"
[ ! -e "$legacy/.ok-planner/design/concepts/falsifier.md" ] \
  && ok "the retired falsifier concept file is removed with the sections" \
  || bad "the retired falsifier concept file survived converge"
if grep -q 'falsifier' "$legacy/.ok-planner/design/concepts.md"; then
  bad "the falsifier line survived in the concept catalog"
elif grep -q 'estate' "$legacy/.ok-planner/design/concepts.md"; then
  ok "the catalog's falsifier line is removed and its sibling entries left alone"
else
  bad "the catalog edit took the sibling concept lines with it"
fi

# --- the audit-model migration: a pre-migration estate upgrades cleanly ----
# The whole point of this migration is the FIRST run after an upgrade: a
# consumer whose audits are all in the retired shape must land on "no
# audit yet" findings, never a wall of malformed ones, and an in-flight
# sprint must not be left holding a contract term nothing can satisfy.
# Both are driven here against a legacy estate seeded with exactly what
# a pre-migration project carries.
# @story: converge-project-estate
section converge-project-estate
old=$(mktemp -d)
(cd "$old" && git init -q .)
mkdir -p "$old/.ok-planner/audits/stories" "$old/.ok-planner/audits/decisions" \
         "$old/.ok-planner/design/stories" "$old/.ok-planner/design/decisions" \
         "$old/.ok-planner/sprints"
printf -- '---\nstory: see-data\n---\n\n# See it\n\n## Story\n\nAs a reader, I want the data, so that I can act.\n' \
  > "$old/.ok-planner/design/stories/see-data.md"
cat > "$old/.ok-planner/audits/stories/see-data.md" <<'MD'
---
audit: see-data
artifact: story:see-data
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:a50c2aad3ba1
---

# The reader can see the data

## Confirmation

Satisfied. The route answers and the suite exercises it.

## Citations

- cite-node: src/app.py#serve @ sha256:0123456789ab
MD
# The shape the release immediately before this one wrote: well-formed by
# its own rules, and unreadable by a checker that renamed the axes. One
# model change back, not two — the case an upgrading project actually
# holds.
printf -- '---\ndecision: loopback\n---\n\n# Ports bind loopback\n\n## Choice\n\nThe port binds loopback.\n' \
  > "$old/.ok-planner/design/decisions/loopback.md"
cat > "$old/.ok-planner/audits/decisions/loopback.md" <<'MD'
---
audit: loopback
artifact: decision:loopback
determination: supported
compliance: compliant
commit: abc1234
audited: 2026-07-29T00:00:00Z
---

# Whether the port binds loopback

Supported. Checked both listener registrations.
MD
printf -- '---\ninspection-registry: v1\ninspected: 2026-07-29T00:00:00Z\n---\n\n# Inspection registry\n' \
  > "$old/.ok-planner/audits/inspection.md"
# The committed source graph and its extractor: mechanically derived
# state whose only reader was the retired citation machinery. A
# directory of mirrors, so the sweep has to take it whole.
mkdir -p "$old/.ok-planner/graph/src" "$old/.ok-planner/bin"
printf 'file src/app.py sha256:abc123abc123\n' > "$old/.ok-planner/graph/src/app.py.graph"
echo "old extractor" > "$old/.ok-planner/bin/source-graph"
cat > "$old/.ok-planner/sprints/live.md" <<'MD'
# Sprint: in flight when the model changed

## Completion contract

The work is not done until all of the following hold, each
verifiable from the repository as it stands:

1. The design corpus matches every delta above (applied verbatim).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue — mechanically: `.ok-planner/bin/audit-check
   --inspection` exits 0 (citations current, and every changed
   source-graph node dispositioned by the change inspection).
4. The completion report beside this sprint (same filename with
   `-completion`) is finished.

**The goal rule, for any checker verifying this contract.** The goal
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp, or this file
is still at its `sprints/` path and items 1–4 all verify against the
repository.
MD
old_out=$(cd "$old" && bash "$planner_core" 2>&1)

[ ! -e "$old/.ok-planner/audits/stories/see-data.md" ] \
  && ok "the retired-shape audit corpus is removed on upgrade" \
  || bad "a retired-shape audit survived the upgrade"
[ ! -e "$old/.ok-planner/audits/decisions/loopback.md" ] \
  && ok "an audit from the release before the two-axis model is swept too — it would read malformed, not stale" \
  || bad "a one-release-old audit survived, and the checker will call every one of them malformed"
grep -qF "Retired audit corpus removed: 2 audit file(s)" <<<"$old_out" \
  && ok "converge reports how many retired audits it removed" \
  || bad "converge did not report the retired audit corpus"
[ ! -e "$old/.ok-planner/audits/inspection.md" ] \
  && ok "the retired inspection registry is swept with the other payloads" \
  || bad "the inspection registry survived the upgrade"
if [ ! -e "$old/.ok-planner/graph" ] && [ ! -e "$old/.ok-planner/bin/source-graph" ]; then
  ok "the committed source graph and its extractor are swept whole"
else
  bad "the source graph survived the upgrade"
fi

# The tool that used to validate audit shape is retired: converge sweeps
# any prior-release copy from the estate, and the audit run no longer
# invokes it. What survives the migration must be file state: the design
# corpus intact, and no audit files (they were all in retired shapes
# swept above).
[ ! -e "$old/.ok-planner/bin/audit-check" ] \
  && ok "the retired audit-corpus checker is not present in a converged estate" \
  || bad ".ok-planner/bin/audit-check survived the upgrade"
[ -f "$old/.ok-planner/design/stories/see-data.md" ] \
  && [ -f "$old/.ok-planner/design/decisions/loopback.md" ] \
  && ok "the design corpus is intact after the retired-shape audits are swept" \
  || bad "the design corpus lost artifacts during the upgrade"
[ -z "$(find "$old/.ok-planner/audits/stories" "$old/.ok-planner/audits/decisions" -name '*.md' 2>/dev/null)" ] \
  && ok "no retired-shape audit files survive the upgrade (the next /audit writes the corpus fresh)" \
  || bad "retired-shape audit files survived the upgrade"

if grep -q '3. The completion report beside this sprint' "$old/.ok-planner/sprints/live.md" \
   && ! grep -q 'audit-check' "$old/.ok-planner/sprints/live.md" \
   && grep -q 'items 1–3 all verify' "$old/.ok-planner/sprints/live.md"; then
  ok "an in-flight sprint's contract loses the retired audit term and is renumbered"
else
  bad "the in-flight sprint contract was not brought current:"
  sed -n '/^1\. The design corpus/,/^\*\*The goal rule/p' "$old/.ok-planner/sprints/live.md"
fi
grep -qF "In-flight sprint contracts brought current: 1 sprint(s)" <<<"$old_out" \
  && ok "converge reports the in-flight contracts it brought current" \
  || bad "converge did not report the contract migration"
rm -rf "$old"

# Every marker detect_premigration knows, seeded at once: the report is
# the whole set, in the order the detector walks them, on the last line.
expected_pre="plans coverage design/tensions specs history/specs backlogs history/backlogs decision-proof-sections design/review-notes.md issues.jsonl"
legacy_last=$(tail -1 <<<"$legacy_out")
[ "$legacy_last" = "PRE-MIGRATION LAYOUT PRESENT: ${expected_pre} - run the migration procedures in admin/ADMINISTRATION.md." ] \
  && ok "converge reports every pre-migration marker on its last line and points at ADMINISTRATION.md" \
  || bad "pre-migration report wrong on converge's last line: ${legacy_last}"
legacy_diag=$(cd "$legacy" && bash "$planner_core" diagnose 2>&1)
grep -qF "PRE-MIGRATION LAYOUT PRESENT: ${expected_pre}" <<<"$legacy_diag" \
  && ok "the read-only diagnose reports the same pre-migration set (converge migrates none of it)" \
  || bad "diagnose does not report the pre-migration set converge reported"
[ -d "$legacy/.ok-planner/specs" ] && [ -f "$legacy/.ok-planner/issues.jsonl" ] \
  && ok "pre-migration layout is reported, never migrated behind the owner's back" \
  || bad "converge migrated pre-migration layout instead of reporting it"

rm -rf "$legacy"

# --- one-command-suite-upkeep: the consolidated act over two families -------
section one-command-suite-upkeep
# The front door is a skill, so the dialogue itself is prompt-realized:
# the single consent question and the printed table are asserted against
# plugins/ok/skills/ok/SKILL.md, and everything the run is supposed to
# produce on disk is exercised here against a project carrying one
# integrated family and one carried-but-unintegrated family.
families_dir="$suite_repo/plugins/ok/families"
two=$(mktemp -d)
(
  cd "$two"
  git init -q .
  git -c user.email=test@example.com -c user.name=test commit -q --allow-empty -m init
)

# One family integrated: its marker is materialized by its own core.
(cd "$two" && bash "$planner_core" >/dev/null 2>&1)

integrated=""
candidates=""
for f in ok-planner ok-plumbline ok-workspaces; do
  if [ -d "$two/.$f" ]; then integrated="$integrated $f"; else candidates="$candidates $f"; fi
done
[ "$(echo $integrated)" = "ok-planner" ] \
  && ok "discovery by marker alone finds exactly the integrated family (ok-planner)" \
  || bad "discovery found '$(echo $integrated)' instead of ok-planner"
[ "$(echo $candidates)" = "ok-plumbline ok-workspaces" ] \
  && ok "the carried-but-unintegrated families are the bootstrap candidates" \
  || bad "bootstrap candidates wrong: '$(echo $candidates)'"

# The owner consents to one candidate; its profile is transcription of
# their answers, and administering it is the same one-pass shape.
mkdir -p "$two/.ok-workspaces"
cat > "$two/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "srcTag": { "path": ".ok-workspaces/bin/src-tag" }
}
JSON
(cd "$two" && bash "$families_dir/ok-workspaces/admin/converge" >/dev/null 2>&1)
[ -f "$two/.claude/rules/ok-workspaces-cheatsheet.md" ] \
  && ok "the consented family is administered in the same pass (estate + cheatsheet materialized)" \
  || bad "the consented family was not administered"
[ ! -e "$two/.ok-plumbline" ] \
  && ok "the declined family is left alone — nothing bootstrapped without consent" \
  || bad "a declined family was bootstrapped anyway"

# The closing table: per family, carried version, project-stamped
# version, outcome — every cell readable off the filesystem the run
# leaves behind.
table_rows=0
for f in ok-planner ok-workspaces; do
  case "$f" in
    ok-planner)    stamp=$(sed -n 's/.*Materialized by ok-planner v\([0-9][0-9A-Za-z.-]*[0-9A-Za-z]\).*/\1/p' "$two/.ok-planner/CLAUDE.md" | head -1) ;;
    ok-workspaces) stamp=$(sed -n 's/.*Materialized by ok-workspaces v\([0-9][0-9A-Za-z.-]*[0-9A-Za-z]\).*/\1/p' "$two/.claude/rules/ok-workspaces-cheatsheet.md" | head -1) ;;
  esac
  if [ "$stamp" = "$suite_version" ]; then
    table_rows=$((table_rows + 1))
  else
    bad "closing table: $f stamped '${stamp:-none}', carried '$suite_version'"
  fi
done
[ "$table_rows" -eq 2 ] \
  && ok "the closing table has a row per administered family, carried and project-stamped versions agreeing (v$suite_version)" \
  || bad "the closing table cannot be built from the run's own output"

# The conduct is never vendored or offered.
if [ ! -e "$two/.ok-conduct" ] && [ ! -d "$two/.claude/skills/ok-conduct" ] \
   && [ -z "$(ls -1 "$two/.claude/rules" 2>/dev/null | grep -i conduct)" ]; then
  ok "the personal conduct is never vendored into the project"
else
  bad "the conduct leaked into the project"
fi

# --- the ceremony layer: suite-owned, bare-named, family-agnostic ----------
# The four ceremony verbs belong to no family, so the collision rule never
# reaches them: they materialize under their bare names in every project,
# and the family-prefixed audit verbs the rule used to produce are retired.
# Read off the disk rather than out of any map — a test that read the
# suite's own list would pass just as happily against a list that had
# quietly dropped a verb, which is the one failure it exists to catch.
# @story: one-ceremony-per-project
# @decision: suite-owned-ceremonies
section suite-owned-ceremonies
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" >/dev/null 2>&1)
for verb in plan-sprint certify-work audit document; do
  if [ -f "$two/.claude/skills/$verb/SKILL.md" ]; then
    ok "the suite vendors /$verb under its bare name"
  else
    bad "the suite did not vendor /$verb"
    continue
  fi
  grep -q "^name: $verb$" "$two/.claude/skills/$verb/SKILL.md" \
    && ok "/$verb declares its own name in frontmatter" \
    || bad "/$verb does not declare 'name: $verb'"
  [ -f "$two/.claude/skills/$verb/LICENSE" ] \
    && ok "/$verb carries the suite LICENSE beside its body" \
    || bad "/$verb has no LICENSE in its vendored folder"
done

# A ceremony reads what a family contributes from the family's own estate,
# so every integrated family must carry one contribution per verb.
for f in ok-planner ok-workspaces; do
  estate=".ok-${f#ok-}"
  for verb in plan-sprint certify-work audit document; do
    [ -f "$two/$estate/ceremony/$verb.md" ] \
      && ok "$f exposes its $verb ceremony contribution at $estate/ceremony/$verb.md" \
      || bad "$f is missing $estate/ceremony/$verb.md — the ceremony would have nothing to read"
  done
done

# The retired verbs: three family-prefixed audits and the separate periodic
# run, all swept by the suite's converge.
for retired in ok-planner-audit ok-plumbline-audit ok-workspaces-audit verify-corpus; do
  mkdir -p "$two/.claude/skills/$retired"
  echo stale > "$two/.claude/skills/$retired/SKILL.md"
done
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" >/dev/null 2>&1)
for retired in ok-planner-audit ok-plumbline-audit ok-workspaces-audit verify-corpus; do
  [ ! -e "$two/.claude/skills/$retired" ] \
    && ok "retired verb removed on converge: $retired" \
    || bad "retired verb still present: $retired"
done

# The suite's own rules file and subagent-model hook ride the same converge:
# materialized on every run, the hook executable, and wired into settings
# only through the consented wire-hooks path.
[ -f "$two/.claude/rules/ok-cheatsheet.md" ] \
  && grep -q "Materialized by ok v${suite_version}" "$two/.claude/rules/ok-cheatsheet.md" \
  && ok "the suite's rules file is materialized and stamped (.claude/rules/ok-cheatsheet.md)" \
  || bad "the suite's rules file is missing or unstamped"
[ -x "$two/.claude/hooks/ok-agent-model" ] \
  && ok "the subagent-model hook is materialized executable (.claude/hooks/ok-agent-model)" \
  || bad "the subagent-model hook is missing or not executable"
hook="$two/.claude/hooks/ok-agent-model"
deny() { printf '%s' "$1" | python3 "$hook" | grep -q '"permissionDecision": "deny"'; }
allow() { [ -z "$(printf '%s' "$1" | python3 "$hook")" ]; }
deny '{"tool_name":"Agent","tool_input":{"prompt":"x"}}' \
  && ok "hook denies an Agent dispatch with no model" \
  || bad "hook let an omitted model through"
deny '{"tool_name":"Agent","tool_input":{"model":"fable"}}' \
  && ok "hook denies a fable subagent" \
  || bad "hook let a fable subagent through"
deny '{"tool_name":"Agent","tool_input":{"subagent_type":"fork","model":"opus"}}' \
  && ok "hook denies a fork (inherits the session model)" \
  || bad "hook let a fork through"
allow '{"tool_name":"Agent","tool_input":{"model":"sonnet"}}' \
  && allow '{"tool_name":"Agent","tool_input":{"model":"opus"}}' \
  && allow '{"tool_name":"Agent","tool_input":{"model":"haiku"}}' \
  && ok "hook allows opus, sonnet, and haiku" \
  || bad "hook refused an allowed model"
deny '{"tool_name":"Workflow","tool_input":{"script":"await agent(\"x\", {label: \"a\"})"}}' \
  && ok "hook denies a Workflow script whose agent() calls name no model" \
  || bad "hook let a model-less Workflow script through"
deny '{"tool_name":"Workflow","tool_input":{"script":"await agent(\"x\", {model: \"fable\"})"}}' \
  && ok "hook denies a Workflow script naming a refused model" \
  || bad "hook let a fable Workflow script through"
allow '{"tool_name":"Workflow","tool_input":{"script":"await agent(\"x\", {model: \"sonnet\"})"}}' \
  && ok "hook allows a Workflow script whose agents name sonnet" \
  || bad "hook refused an allowed Workflow script"
allow '{"tool_name":"Edit","tool_input":{"file_path":"x"}}' \
  && ok "hook ignores tools other than Agent and Workflow" \
  || bad "hook interfered with an unrelated tool"

diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1)
printf '%s\n' "$diag" | grep -q "WIRING NEEDED (ok)" \
  && ok "the unwired subagent-model hook surfaces as a WIRING NEEDED block" \
  || bad "no WIRING NEEDED block for the unwired subagent-model hook"
[ ! -e "$two/.claude/settings.json" ] || ! grep -q "ok-agent-model" "$two/.claude/settings.json" \
  && ok "converge and diagnose wrote no settings entry on their own" \
  || bad "a settings entry appeared without consent"
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" wire-hooks >/dev/null 2>&1)
matcher=$(python3 -c '
import json,sys
s=json.load(open(sys.argv[1]))
for e in s.get("hooks",{}).get("PreToolUse",[]):
    if any("ok-agent-model" in h.get("command","") for h in e.get("hooks",[])):
        print(e.get("matcher")); break
' "$two/.claude/settings.json")
[ "$matcher" = "Agent|Workflow" ] \
  && ok "wire-hooks transcribes the exact consented PreToolUse entry (Agent|Workflow)" \
  || bad "wire-hooks entry wrong or missing (matcher: ${matcher:-none})"

# converge -> diagnose -> converge is a no-op: the read-only mode is what an
# owner runs to find out where a project stands, so it has to be right about a
# clean project, a drifted one, and a retired payload alike.
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose >/dev/null 2>&1) \
  && ok "the suite's diagnose reports clean on a converged, wired project" \
  || bad "the suite's diagnose found drift on a project it had just converged and wired"

printf '\nhand edit\n' >> "$two/.claude/skills/audit/SKILL.md"
mkdir -p "$two/.claude/skills/verify-corpus"
echo stale > "$two/.claude/skills/verify-corpus/SKILL.md"
diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1); rc=$?
if [ "$rc" -ne 0 ] \
   && printf '%s\n' "$diag" | grep -q "stale: .claude/skills/audit/SKILL.md" \
   && printf '%s\n' "$diag" | grep -q "retired payload present: .claude/skills/verify-corpus/"; then
  ok "the suite's diagnose names a hand-edited body and a retired payload, and writes nothing"
else
  bad "the suite's diagnose missed the seeded drift (exit $rc)"
  printf '%s\n' "$diag" | sed 's/^/    /'
fi
grep -q "hand edit" "$two/.claude/skills/audit/SKILL.md" \
  && ok "diagnose repaired nothing — it is read-only" \
  || bad "diagnose rewrote a file it was only asked to inspect"
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" >/dev/null 2>&1)

# No family vendors a verb by a ceremony name — that is what makes the bare
# names safe.
claimed=""
for f in ok-planner ok-plumbline ok-workspaces; do
  for verb in plan-sprint certify-work audit document; do
    [ ! -d "$families_dir/$f/skills/$verb" ] || claimed="$claimed $f/$verb"
  done
done
[ -z "$claimed" ] \
  && ok "no family carries a skill by a ceremony verb's name" \
  || bad "a family carries a ceremony verb's name:$claimed"

rm -rf "$two"

exit $fail
