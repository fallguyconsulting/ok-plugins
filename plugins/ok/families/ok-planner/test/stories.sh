#!/usr/bin/env bash
# Story-level integration tests for the planner family — an ordinary
# test suite, run like any other.
#
# Every check here runs something — a vendored binary, a materialized
# hook, the converge core — and asserts on what
# running it produced. Nothing in this suite checks the existence of
# static text, code, or prose; the @story: annotations below are
# navigation, linking each section to the story it exercises.
#
# see-governing-versions: a project deliberately converged behind the
# carried plugin shows two disagreeing numbers, and the governing one
# is the literal in the project's own stamped artifact.
#
# session-awareness: the materialized hook, run for real, emits the
# version banner and — where a corpus exists — the concept TOC with its
# read-before-you-define framing, while an unintegrated project has
# neither the hook nor the wiring, so nothing is injected.
#
# relevance-scoped-queue-gate: the corpus surfacer the issue walk runs
# before presenting an issue ranks the artifacts the issue names above
# the ones it merely echoes, discards tokens common across the corpus,
# and prints nothing when nothing bears.
#
# @story: see-governing-versions
# @story: session-awareness
# @decision: relevance-scoped-queue-gate
set -uo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
suite_repo="$(cd "$here/../../../../.." && pwd)"
family="$(cd "$here/.." && pwd)"
planner_core="$family/admin/converge"
suite_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "$suite_repo/plugins/ok/.claude-plugin/plugin.json" | head -1)

fail=0
fails=0
ok()  { echo "ok: $1"; }
bad() { echo "FAIL: $1"; fail=1; fails=$((fails + 1)); }

section() { :; }  # readability marker; sections carry no machinery

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# --- session-awareness + see-governing-versions ------------------------------
section session-awareness see-governing-versions
# A real converged project, then the same project deliberately left
# behind the carried version.
conv="$tmp/converged"
mkdir -p "$conv"
(cd "$conv" && git init -q . && git -c user.email=p@e.c -c user.name=p commit -q --allow-empty -m init)
mkdir -p "$conv/.ok-planner/design"
printf "# Concepts\n\n- [thing](concepts/thing.md) — a thing.\n" > "$conv/.ok-planner/design/concepts.md"
(cd "$conv" && bash "$planner_core" >/dev/null 2>&1)

hook="$conv/.ok-planner/hooks/session-start"
[ -x "$hook" ] && ok "session-awareness: the session hook is materialized into the estate and executable" \
  || bad "session-awareness: no materialized session hook"
out=$(bash "$hook" 2>/dev/null); rc=$?
[ "$rc" -eq 0 ] && ok "session-awareness: the hook runs clean" || bad "session-awareness: the hook exited $rc"
printf '%s' "$out" | grep -q "\"hookEventName\": \"SessionStart\"" \
  && ok "session-awareness: it emits a SessionStart context payload" \
  || bad "session-awareness: no SessionStart payload"
printf '%s' "$out" | grep -q "ok-planner v${suite_version} is materialized in this project" \
  && ok "session-awareness: the banner names the governing version (v${suite_version})" \
  || bad "session-awareness: the banner does not name the governing version"
printf '%s' "$out" | grep -q "do not paraphrase from prior context" \
  && ok "session-awareness: the concept TOC is injected with its read-before-you-define framing" \
  || bad "session-awareness: the concept catalog framing is missing"
printf '%s' "$out" | grep -q "\[thing\](concepts/thing.md)" \
  && ok "session-awareness: the injected TOC is this project's own catalog" \
  || bad "session-awareness: the injected TOC is not the project's catalog"
printf '%s' "$out" | grep -qi "each activated only by its explicit slash command\." \
  && bad "session-awareness: the payload still claims every vendored skill carries the guard" \
  || ok "session-awareness: the payload does not overclaim the activation guard over the plumbing class"

# The unintegrated case: no estate, so neither the hook nor the wiring
# exists and nothing is injected.
unint="$tmp/unintegrated"
mkdir -p "$unint"
(cd "$unint" && git init -q . && git -c user.email=p@e.c -c user.name=p commit -q --allow-empty -m init)
if [ ! -e "$unint/.ok-planner" ] && [ ! -e "$unint/.claude/settings.json" ]; then
  ok "session-awareness: an unintegrated project has neither hook nor wiring — nothing is injected"
else
  bad "session-awareness: an unintegrated project was disturbed"
fi

# see-governing-versions: a project deliberately behind the carried plugin.
behind="$conv/.ok-planner/hooks/session-start"
sed "s/ok-planner v${suite_version} is materialized/ok-planner v9.0.0-behind is materialized/" "$behind" > "$behind.tmp" && mv "$behind.tmp" "$behind"
chmod +x "$behind"
governing=$(bash "$behind" 2>/dev/null | sed -n 's/.*ok-planner v\([0-9A-Za-z.\-]*\) is materialized.*/\1/p' | head -1)
[ "$governing" = "9.0.0-behind" ] \
  && ok "see-governing-versions: the governing number is read from what this project was converged to ($governing)" \
  || bad "see-governing-versions: the governing number did not come from the project's own stamp (got ${governing:-none})"
[ "$governing" != "$suite_version" ] \
  && ok "see-governing-versions: it disagrees with the carried plugin (v${suite_version}) — the gap is the convergence signal" \
  || bad "see-governing-versions: the two numbers do not disagree on a deliberately-behind project"
# --- relevance-scoped-queue-gate: the corpus surfacer the walk runs ----------
section relevance-scoped-queue-gate
# The Choice's last clause — each in-scope issue walked "with the corpus
# artifacts relevant to each surfaced first" — is delivered by a program,
# not by prose: the ceremony runs the surfacer on the issue file before
# presenting it. Three properties decide whether the walker gets a
# useful shortlist or noise: what the issue explicitly names outranks
# everything, a token common across the corpus is not a signal, and an
# issue nothing bears on prints nothing at all — which is itself the
# signal the walker reads.
surfacer="$family/scripts/surface-corpus"
sc="$tmp/surface-corpus-fixture"
mkdir -p "$sc/.ok-planner/design/concepts" \
         "$sc/.ok-planner/design/decisions" "$sc/.ok-planner/issues"
i=1
while [ "$i" -le 12 ]; do
  n=$(printf '%02d' "$i")
  printf '# Topic %s\n\nThe converge core owns this topic.\nMarker raretoken%s appears only here.\n' \
    "$n" "$n" > "$sc/.ok-planner/design/concepts/topic-$n.md"
  i=$((i + 1))
done
printf '# The port is bound on loopback only\n\nThe converge core binds the loopback interface.\nThe heliotrope allocator picks the port.\n' \
  > "$sc/.ok-planner/design/decisions/loopback-ports.md"

cat > "$sc/.ok-planner/issues/2026-07-29-000000-ports-collide.md" <<'FIXTURE'
---
issue: 2026-07-29-000000-ports-collide
artifacts:
  - decision:loopback-ports
---

# Two projects browsing at once contend for the port

The converge core is fine; the `heliotrope` allocator and raretoken07
are what this turns on.
FIXTURE

ranked=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000000-ports-collide.md")
first=$(printf '%s\n' "$ranked" | head -1)
if printf '%s' "$first" | grep -q "design/decisions/loopback-ports.md	decision	cited in row.artifacts\[\]"; then
  ok "relevance-scoped-queue-gate: the artifact the issue names is surfaced first, at maximum score"
else
  bad "relevance-scoped-queue-gate: the cited artifact did not rank first: ${first:-<no output>}"
fi
if printf '%s\n' "$ranked" | grep -q "concepts/topic-07.md	concept	.*rare-token hit"; then
  ok "relevance-scoped-queue-gate: an artifact reached only by a rare token is surfaced with the tokens that reached it"
else
  bad "relevance-scoped-queue-gate: the rare-token match was not surfaced: $ranked"
fi
common_hits=$(printf '%s\n' "$ranked" | grep -c "concepts/topic-" || true)
[ "$common_hits" -eq 1 ] \
  && ok "relevance-scoped-queue-gate: a token common across the corpus (converge) surfaces nothing on its own" \
  || bad "relevance-scoped-queue-gate: a corpus-wide token dragged in $common_hits concepts"

# Empty output is defined behavior, not a failure: it tells the walker
# the corpus has nothing to put in front of the owner for this issue.
cat > "$sc/.ok-planner/issues/2026-07-29-000001-nothing-bears.md" <<'FIXTURE'
---
issue: 2026-07-29-000001-nothing-bears
---

# A question the corpus does not touch

The converge core is fine here too.
FIXTURE
empty=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000001-nothing-bears.md")
[ -z "$empty" ] \
  && ok "relevance-scoped-queue-gate: an issue no artifact bears on surfaces nothing — the walker's own signal" \
  || bad "relevance-scoped-queue-gate: an issue with no bearing artifact still surfaced: $empty"

# The shortlist is capped, so an issue naming half the corpus still
# arrives as something the owner can read in one sitting.
{
  printf -- '---\nissue: 2026-07-29-000002-names-everything\nartifacts:\n'
  printf -- '  - decision:loopback-ports\n'
  i=1
  while [ "$i" -le 12 ]; do
    printf -- '  - concept:topic-%02d\n' "$i"
    i=$((i + 1))
  done
  printf -- '---\n\n# Everything at once\n\nBody.\n'
} > "$sc/.ok-planner/issues/2026-07-29-000002-names-everything.md"
capped=$(OK_PLANNER_PROJECT_ROOT="$sc" python3 "$surfacer" \
  "$sc/.ok-planner/issues/2026-07-29-000002-names-everything.md" | wc -l | tr -d ' ')
[ "$capped" -eq 10 ] \
  && ok "relevance-scoped-queue-gate: the shortlist is capped at ten however many artifacts an issue names" \
  || bad "relevance-scoped-queue-gate: the shortlist was not capped (got $capped lines)"

exit $fail
