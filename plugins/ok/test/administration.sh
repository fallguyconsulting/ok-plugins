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
# directories alike, the retired corpus view among them — and it
# materializes the colliding audit verb family-prefixed per the
# integration contract.
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
grep -rq "ok-planner-audit-check" .claude/skills/ \
  && bad "renderer corrupted a support-script path (ok-planner-audit-check)" \
  || ok "renderer leaves support-script paths intact (bin/audit-check)"
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
grep -qF "Retired audit corpus removed: 1 audit file(s)" <<<"$old_out" \
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

# The first thing a consumer runs after upgrading. Every finding must be
# "no audit yet" — the honest state — and none may be a shape complaint
# about a file the migration was supposed to remove.
first_run=$(cd "$old" && python3 .ok-planner/bin/audit-check . 2>&1)
if grep -q 'audit-missing' <<<"$first_run" \
   && ! grep -qE 'audit-malformed|audit-verbose|audit-orphaned' <<<"$first_run"; then
  ok "the first checker run after upgrading reports only unaudited artifacts, not malformed ones"
else
  bad "the first run after upgrading is not clean: $first_run"
fi

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

# --- vendored-skills: the contract's collision rule, read off the disk ------
# `audit` is a verb more than one family claims, so the contract says it
# materializes family-prefixed while every other verb keeps its name —
# which is only observable in a project that integrates two families, as
# this one now does. The expectation is built from the rule itself (family
# name, hyphen, verb) and never from a family's own vendoring map: a test
# that read the map would pass just as happily against a map that had
# dropped the prefix, which is the one failure it exists to catch. The
# rename has to reach inside the rendered file too — a skill that still
# tells the user to type `/audit` names a slash command that does not
# exist in the project.
# @decision: vendored-skills
section vendored-skills
for f in ok-planner ok-workspaces; do
  materialized=".claude/skills/${f}-audit"
  if [ -f "$two/$materialized/SKILL.md" ]; then
    ok "$f materializes the colliding audit verb family-prefixed ($materialized)"
  else
    bad "$f did not materialize the audit verb at $materialized"
    continue
  fi
  grep -q "^name: ${f}-audit$" "$two/$materialized/SKILL.md" \
    && ok "$f's vendored audit skill declares the materialized name in its frontmatter" \
    || bad "$f's vendored audit skill does not declare 'name: ${f}-audit'"
  grep -q "/${f}-audit" "$two/$materialized/SKILL.md" \
    && ok "$f's vendored audit skill reaches itself by the materialized slash command (/${f}-audit)" \
    || bad "$f's vendored audit skill carries no /${f}-audit reference"
  if grep -qE '/audit([^-]|$)' "$two/$materialized/SKILL.md"; then
    bad "$f's vendored audit skill still self-references the bare /audit slash command:"
    grep -nE '/audit([^-]|$)' "$two/$materialized/SKILL.md"
  else
    ok "$f's vendored audit skill has no bare /audit self-reference left"
  fi
done
[ ! -e "$two/.claude/skills/audit" ] \
  && ok "no bare .claude/skills/audit/ — the colliding verb never materializes unprefixed" \
  || bad "a bare .claude/skills/audit/ materialized despite the collision rule"

rm -rf "$two"

exit $fail
