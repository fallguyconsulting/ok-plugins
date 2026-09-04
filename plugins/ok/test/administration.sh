#!/usr/bin/env bash

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

section() { :; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cd "$tmp"
git init -q .
git -c user.email=test@example.com -c user.name=test commit -q --allow-empty -m init

section one-command-suite-upkeep
[ ! -d .ok-planner ] && ok "no marker, no integration: .ok-planner/ absent means bootstrap candidate" \
  || bad "fresh project unexpectedly carries .ok-planner/"

mkdir -p .claude/skills/true-up
echo "stale merged verb" > .claude/skills/true-up/SKILL.md

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

bash "$planner_core" wire-hooks >/dev/null 2>&1
matcher=$(python3 -c "import json;print(json.load(open('.claude/settings.json'))['hooks']['SessionStart'][0]['matcher'])" 2>/dev/null)
[ "$matcher" = "startup|clear|compact" ] \
  && ok "wire-hooks transcribes the exact consented entry (startup|clear|compact)" \
  || bad "wire-hooks entry wrong or missing (matcher: ${matcher:-none})"

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

mkdir -p "$legacy/.ok-planner/surface/members" \
         "$legacy/.ok-planner/audits/surface"
echo "stale reconciler" > "$legacy/.ok-planner/bin/surface-reconcile"
echo '{"kinds":[]}'     > "$legacy/.ok-planner/surface/surface.json"
echo "stale guidance"   > "$legacy/.ok-planner/surface/guidance.md"
echo "GET /v1"          > "$legacy/.ok-planner/surface/members/routes"
echo '{"commit":"x"}'   > "$legacy/.ok-planner/audits/surface/ruling.json"
echo '{"commit":"x"}'   > "$legacy/.ok-planner/audits/surface/extraction.json"

echo "stale doc-checker" > "$legacy/.ok-planner/bin/document-check"

echo '{"id":1}' > "$legacy/.ok-planner/issues.jsonl"
echo "old notes" > "$legacy/.ok-planner/design/review-notes.md"
printf '# D\n\n## Choice\n\nc\n\n## Proof\n\np\n' > "$legacy/.ok-planner/design/decisions/d.md"

echo "the retired kind" > "$legacy/.ok-planner/design/concepts/falsifier.md"
cat > "$legacy/.ok-planner/design/concepts.md" <<'MD'
# Concept catalog

- [`estate`](concepts/estate.md) — the project-side directory
- [`falsifier`](concepts/falsifier.md) — the retired kind
MD

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

section one-command-suite-upkeep
families_dir="$suite_repo/plugins/ok/families"
two=$(mktemp -d)
(
  cd "$two"
  git init -q .
  git -c user.email=test@example.com -c user.name=test commit -q --allow-empty -m init
)

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

mkdir -p "$two/.ok-workspaces"
cat > "$two/.ok-workspaces/config.json" <<'JSON'
{
  "stacks": [],
  "runtime": "none",
  "worktrees": { "dirPrefix": ".ok-workspaces/worktrees/", "branchPrefix": "wt/" },
  "runTag": { "path": ".ok-workspaces/bin/run-tag" }
}
JSON
(cd "$two" && bash "$families_dir/ok-workspaces/admin/converge" >/dev/null 2>&1)
[ -f "$two/.claude/rules/ok-workspaces-cheatsheet.md" ] \
  && ok "the consented family is administered in the same pass (estate + cheatsheet materialized)" \
  || bad "the consented family was not administered"
[ ! -e "$two/.ok-plumbline" ] \
  && ok "the declined family is left alone — nothing bootstrapped without consent" \
  || bad "a declined family was bootstrapped anyway"

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

if [ ! -e "$two/.ok-conduct" ] && [ ! -d "$two/.claude/skills/ok-conduct" ] \
   && [ -z "$(ls -1 "$two/.claude/rules" 2>/dev/null | grep -i conduct)" ]; then
  ok "the personal conduct is never vendored into the project"
else
  bad "the conduct leaked into the project"
fi

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

for f in ok-planner ok-workspaces; do
  estate=".ok-${f#ok-}"
  for verb in plan-sprint certify-work audit document; do
    [ -f "$two/$estate/ceremony/$verb.md" ] \
      && ok "$f exposes its $verb ceremony contribution at $estate/ceremony/$verb.md" \
      || bad "$f is missing $estate/ceremony/$verb.md — the ceremony would have nothing to read"
  done
done

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
  && ok "hook denies a fork from the session (inherits the session model)" \
  || bad "hook let a session fork through"
[ -f "$two/.claude/agents/ok-audit.md" ] \
  && ok "the audit profile is vendored (.claude/agents/ok-audit.md)" \
  || bad "the audit profile is missing"
allow "{\"cwd\":\"$two\",\"agent_type\":\"ok-audit\",\"tool_name\":\"Agent\",\"tool_input\":{\"subagent_type\":\"fork\",\"prompt\":\"x\"}}" \
  && ok "hook allows a fork from the vendored audit profile (inherits its pinned model)" \
  || bad "hook refused the audit profile's fork"
deny "{\"cwd\":\"$two\",\"agent_type\":\"general-purpose\",\"tool_name\":\"Agent\",\"tool_input\":{\"subagent_type\":\"fork\"}}" \
  && ok "hook denies a fork from a subagent with no pinned profile" \
  || bad "hook let an unpinned subagent fork"
deny "{\"cwd\":\"$two\",\"agent_type\":\"ok-audit\",\"tool_name\":\"Agent\",\"tool_input\":{\"model\":\"opus\",\"prompt\":\"x\"}}" \
  && ok "hook denies a non-fork dispatch from a vendored profile" \
  || bad "hook let a vendored profile dispatch a non-fork subagent"
printf -- '---\nname: mine\nmodel: opus\n---\nproject-owned profile\n' > "$two/.claude/agents/mine.md"
printf -- '---\nname: odd\nmodel: fable\n---\nodd profile\n' > "$two/.claude/agents/odd.md"
allow "{\"cwd\":\"$two\",\"agent_type\":\"mine\",\"tool_name\":\"Agent\",\"tool_input\":{\"model\":\"sonnet\",\"prompt\":\"x\"}}" \
  && ok "hook allows an ordinary dispatch from a project-owned profile that names a model" \
  || bad "hook refused a project-owned profile's ordinary dispatch"
deny "{\"cwd\":\"$two\",\"agent_type\":\"odd\",\"tool_name\":\"Agent\",\"tool_input\":{\"subagent_type\":\"fork\"}}" \
  && ok "hook denies a fork from a profile pinning a refused model" \
  || bad "hook let a fork inherit a refused model"
rm -f "$two/.claude/agents/mine.md" "$two/.claude/agents/odd.md"
mkdir -p "$two/deep/sub"
allow "{\"cwd\":\"$two/deep/sub\",\"agent_type\":\"ok-audit\",\"tool_name\":\"Agent\",\"tool_input\":{\"subagent_type\":\"fork\",\"prompt\":\"x\"}}" \
  && ok "hook finds the caller's profile by walking up from a subdirectory cwd" \
  || bad "hook lost the profile when cwd was a subdirectory"
rmdir "$two/deep/sub" "$two/deep"
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

[ -x "$two/.claude/hooks/ok-subagent-batching" ] \
  && ok "the subagent-batching hook is materialized executable (.claude/hooks/ok-subagent-batching)" \
  || bad "the subagent-batching hook is missing or not executable"
batch_out=$(printf '{"agent_type":"Explore"}' | python3 "$two/.claude/hooks/ok-subagent-batching")
grep -q '"hookEventName": "SubagentStart"' <<<"$batch_out" \
  && grep -q '"additionalContext"' <<<"$batch_out" \
  && grep -q 'independent tool call' <<<"$batch_out" \
  && ok "the batching hook emits the SubagentStart additionalContext payload" \
  || bad "the batching hook payload is wrong: $batch_out"

diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1)
printf '%s\n' "$diag" | grep -q "WIRING NEEDED (ok)" \
  && ok "the unwired subagent-model hook surfaces as a WIRING NEEDED block" \
  || bad "no WIRING NEEDED block for the unwired subagent-model hook"
[ ! -e "$two/.claude/settings.json" ] || ! grep -qE "ok-agent-model|ok-subagent-batching" "$two/.claude/settings.json" \
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
smatcher=$(python3 -c '
import json,sys
s=json.load(open(sys.argv[1]))
for e in s.get("hooks",{}).get("SubagentStart",[]):
    if any("ok-subagent-batching" in h.get("command","") for h in e.get("hooks",[])):
        print(e.get("matcher")); break
' "$two/.claude/settings.json")
[ "$smatcher" = "*" ] \
  && ok "wire-hooks transcribes the SubagentStart entry for the batching hook beside it (matcher *)" \
  || bad "SubagentStart entry wrong or missing (matcher: ${smatcher:-none})"

# @story: watch-execution-progress
# @decision: task-tools-mirror-the-report
diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1)
printf '%s\n' "$diag" | grep -q "needs the env entry below" \
  && printf '%s\n' "$diag" | grep -q '"CLAUDE_CODE_ENABLE_TODO_TOOLS": "1"' \
  && printf '%s\n' "$diag" | grep -q "wire-env" \
  && ok "the missing task-tools env entry surfaces as a WIRING NEEDED block with the exact entry and consent command" \
  || bad "no WIRING NEEDED block for the task-tools env entry: $diag"
! grep -q "CLAUDE_CODE_ENABLE_TODO_TOOLS" "$two/.claude/settings.json" \
  && ok "wire-hooks and diagnose wrote no env entry on their own" \
  || bad "the env entry appeared without its own consent"
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" wire-env >/dev/null 2>&1)
envval=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("env",{}).get("CLAUDE_CODE_ENABLE_TODO_TOOLS"))' "$two/.claude/settings.json")
[ "$envval" = "1" ] \
  && ok "wire-env transcribes exactly env.CLAUDE_CODE_ENABLE_TODO_TOOLS=1" \
  || bad "wire-env entry wrong or missing (value: ${envval:-none})"
matcher=$(python3 -c '
import json,sys
s=json.load(open(sys.argv[1]))
for e in s.get("hooks",{}).get("PreToolUse",[]):
    if any("ok-agent-model" in h.get("command","") for h in e.get("hooks",[])):
        print(e.get("matcher")); break
' "$two/.claude/settings.json")
[ "$matcher" = "Agent|Workflow" ] \
  && ok "wire-env leaves the hook entry beside it untouched" \
  || bad "wire-env disturbed the PreToolUse entry (matcher: ${matcher:-none})"

(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose >/dev/null 2>&1) \
  && ok "the suite's diagnose reports clean on a converged, wired project" \
  || bad "the suite's diagnose found drift on a project it had just converged and wired"

# @story: watch-execution-progress
# @decision: task-tools-mirror-the-report
settings="$two/.claude/settings.json"
wired=$(cat "$settings")
seed_settings() { printf '%s\n' "$1" > "$settings"; }
restore_settings() { printf '%s' "$wired" > "$settings"; }
mutate_settings() { restore_settings; python3 -c "$1" "$settings"; }

seed=$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["env"]["CLAUDE_CODE_ENABLE_TODO_TOOLS"]="0"
print(json.dumps(s, indent=2))')
seed_settings "$seed"
diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1); rc=$?
if [ "$rc" -ne 0 ] \
   && printf '%s\n' "$diag" | grep -qF "env.CLAUDE_CODE_ENABLE_TODO_TOOLS is '0' — must be '1'" \
   && printf '%s\n' "$diag" | grep -q "needs the env entry below" \
   && [ "$(cat "$settings")" = "$seed" ]; then
  ok "diagnose names a wrong task-tools env value, offers the entry, and writes nothing"
else
  bad "diagnose missed a wrong task-tools env value (exit $rc)"
  printf '%s\n' "$diag" | sed 's/^/    /'
fi

seed=$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["env"]["CLAUDE_CODE_ENABLE_TODO_TOOLS"]=1
print(json.dumps(s, indent=2))')
seed_settings "$seed"
diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1); rc=$?
if [ "$rc" -ne 0 ] \
   && printf '%s\n' "$diag" | grep -qF "env.CLAUDE_CODE_ENABLE_TODO_TOOLS is 1 — must be '1'" \
   && [ "$(cat "$settings")" = "$seed" ]; then
  ok "diagnose names a numeric task-tools env value as drift and writes nothing"
else
  bad "diagnose accepted a numeric task-tools env value (exit $rc)"
  printf '%s\n' "$diag" | sed 's/^/    /'
fi
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" wire-env >/dev/null 2>&1)
envval=$(python3 -c 'import json,sys; print(json.dumps(json.load(open(sys.argv[1]))["env"]["CLAUDE_CODE_ENABLE_TODO_TOOLS"]))' "$settings")
[ "$envval" = '"1"' ] \
&& ok "wire-env rewrites a numeric task-tools env value as the string 1" \
|| bad "wire-env left a numeric task-tools env value in place (value: $envval)"

unusable_guard_holds() {
  local label="$1" seed="$2" want="$3"
  seed_settings "$seed"
  local diag rc hooks_rc env_rc
  diag=$(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose 2>&1); rc=$?
  (cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" wire-hooks >/dev/null 2>&1); hooks_rc=$?
  (cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" wire-env >/dev/null 2>&1); env_rc=$?
  if [ "$rc" -ne 0 ] \
     && [ "$(printf '%s\n' "$diag" | grep -cF "$want")" -eq 1 ] \
     && ! printf '%s\n' "$diag" | grep -q "WIRING NEEDED" \
     && [ "$(cat "$settings")" = "$seed" ]; then
    ok "$label"
  else
    bad "$label (diagnose exit $rc, wire-hooks $hooks_rc, wire-env $env_rc)"
    printf '%s\n' "$diag" | sed 's/^/    /'
  fi
}

unusable_guard_holds \
  "diagnose reports an env that is not an object once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["env"]=["CLAUDE_CODE_ENABLE_TODO_TOOLS"]
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has an env that is not an object"

unusable_guard_holds \
  "diagnose reports a hooks entry that is not an object once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["hooks"]="PreToolUse"
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has a hooks entry that is not an object"

unusable_guard_holds \
  "diagnose reports a hooks.PreToolUse that is not an array once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["hooks"]["PreToolUse"]="ok-agent-model"
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has a hooks.PreToolUse that is not an array"

unusable_guard_holds \
  "diagnose reports a settings file that is not an object once, offers no wiring block, and both wiring commands leave the file alone" \
  '["CLAUDE_CODE_ENABLE_TODO_TOOLS"]' \
  "unusable: .claude/settings.json is not an object"

unusable_guard_holds \
  "diagnose reports an unparseable settings file once, offers no wiring block, and both wiring commands leave the file alone" \
  '{"env": ' \
  "unparseable: .claude/settings.json"

unusable_guard_holds \
  "diagnose reports a hooks.PreToolUse entry that is not an object once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["hooks"]["PreToolUse"].insert(0, "ok-agent-model")
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has a hooks.PreToolUse entry the suite cannot read"

unusable_guard_holds \
  "diagnose reports a PreToolUse entry whose hooks value is not an array once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["hooks"]["PreToolUse"].insert(0, {"matcher": "Agent", "hooks": ""})
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has a hooks.PreToolUse entry the suite cannot read"

unusable_guard_holds \
  "diagnose reports a PreToolUse hook that is not an object once, offers no wiring block, and both wiring commands leave the file alone" \
  "$(mutate_settings '
import json,sys
s=json.load(open(sys.argv[1])); s["hooks"]["PreToolUse"].insert(0, {"matcher": "Agent", "hooks": ["ok-agent-model"]})
print(json.dumps(s, indent=2))')" \
  "unusable: .claude/settings.json has a hooks.PreToolUse entry the suite cannot read"

restore_settings
(cd "$two" && bash "$suite_repo/plugins/ok/admin/converge" diagnose >/dev/null 2>&1) \
  && ok "the restored settings file diagnoses clean again" \
  || bad "the restored settings file still reports drift"

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

kept=$(mktemp -d)
mkdir -p "$kept/.ok-planner/design/concepts" "$kept/.ok-planner/audits/surface"
echo '{"commit":"d977250c"}' > "$kept/.ok-planner/audits/surface/extraction.json"
(cd "$kept" && bash "$planner_core" >/dev/null 2>&1)
[ -f "$kept/.ok-planner/audits/surface/extraction.json" ] \
  && ok "a stamped extraction standing alone survives converge" \
  || bad "converge swept a current audit's extraction"
(cd "$kept" && bash "$planner_core" diagnose 2>&1 | grep -q "extraction.json") \
  && bad "diagnose reports a lone stamped extraction as retired" \
  || ok "diagnose is silent about a lone stamped extraction"
echo '{}' > "$kept/.ok-planner/audits/surface/ruling.json"
(cd "$kept" && bash "$planner_core" >/dev/null 2>&1)
[ ! -f "$kept/.ok-planner/audits/surface/extraction.json" ] \
  && ok "an extraction beside the retired ruling is swept with it" \
  || bad "the legacy extraction survived beside ruling.json"
rm -rf "$kept"

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
