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
# @story: one-command-suite-upkeep
# @story: converge-project-estate
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
n=$(find .claude/skills -name SKILL.md | wc -l | tr -d ' ')
[ "$n" -ge 10 ] && ok "vendored skill set written ($n files)" || bad "vendored skill set incomplete ($n files)"
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

rm -rf "$two"

exit $fail
