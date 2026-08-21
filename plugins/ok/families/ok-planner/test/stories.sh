#!/usr/bin/env bash
# Story-level integration tests for the planner family — an ordinary
# test suite, run like any other.
#
# Every check here runs something — a vendored binary, a materialized
# hook, the converge core — and asserts on what
# running it produced. The certify-completion section asserts on
# text. The prompt corpus the converge core vendors is the artifact
# the consumer receives, so that text is what running the core
# produced. Every other section leaves static text, code, and prose
# alone; the @story: annotations below are
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
# certify-completion: the gate's machinery reaches a consumer only as
# the files the converge core vendors. The run reads that vendored copy
# block by block and asserts each rule landed in the block whose prompt
# carries it. A rule in the wrong block reaches no agent that needs
# it.
#
# @story: see-governing-versions
# @story: session-awareness
# @story: certify-completion
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

# --- certify-completion: the gate's machinery as the consumer gets it --------
section certify-completion
core="$conv/.claude/skills/_shared/certification-core.md"
block() {
  awk -v t="### {{$2}}" '$0 == t { on = 1; next } on && /^### \{\{/ { exit } on' "$1"
}

loop=$(block "$core" CERTIFY-REVIEW-FIX-LOOP)
printf '%s\n' "$loop" | grep -q "first round in which neither the fixer nor the architect edited" \
  && ok "certify-completion: the vendored loop ends at the first round in which neither the fixer nor the architect edited any file" \
  || bad "certify-completion: the vendored loop states no edit-test exit rule"
printf '%s\n' "$loop" | grep -q "## Certification ledger" \
  && ok "certify-completion: the vendored loop names the finding ledger's section in the completion report" \
  || bad "certify-completion: the vendored loop names no ledger section"
printf '%s\n' "$loop" | grep -q "After \*\*8 rounds\*\*" \
  && ok "certify-completion: the cap counts rounds and guards against thrash" \
  || bad "certify-completion: the cap does not count rounds"
printf '%s\n' "$loop" | grep -q '| `repeats` |' \
  && ok "certify-completion: the ledger row holds the repeat count the presentation reports" \
  || bad "certify-completion: the ledger row has no repeats column"
printf '%s\n' "$loop" | grep -q '| `rounds touched` |' \
  && ok "certify-completion: the ledger row holds the per-site round count the cap reports" \
  || bad "certify-completion: the ledger row has no rounds touched column"
printf '%s\n' "$loop" | grep -q "The fixer and the architect own \`## Divergences\`" \
  && ok "certify-completion: the loop splits the report between the orchestrator and the fixing agents" \
  || bad "certify-completion: the loop leaves the report's two writers unsettled"

fixer=$(block "$core" CERTIFY-FIXER-PROMPT)
printf '%s\n' "$fixer" | grep -q '\*\*REFUTE\.\*\*' \
  && ok "certify-completion: the vendored fixer prompt lists REFUTE as a legal non-fix" \
  || bad "certify-completion: the vendored fixer prompt lists no REFUTE"
printf '%s\n' "$fixer" | grep -q "a REFUTED" \
  && ok "certify-completion: the fixer's completion check reports every refutation" \
  || bad "certify-completion: the fixer's completion check omits the REFUTED list"
printf '%s\n' "$fixer" | grep -q "Settled ledger rows arrive with each batch" \
  && ok "certify-completion: the fixer receives the settled ledger rows for the sites its batch names" \
  || bad "certify-completion: the fixer prompt never mentions the ledger rows it receives"

architect=$(block "$core" CERTIFY-ARCHITECT-PROMPT)
printf '%s\n' "$architect" | grep -qE '^ +### Refutations$' \
  && ok "certify-completion: the vendored architect prompt rules on refutations" \
  || bad "certify-completion: the vendored architect prompt has no refutations section"
printf '%s\n' "$architect" | grep -qE '^ +### Reversals$' \
  && ok "certify-completion: the vendored architect prompt rules on reversals" \
  || bad "certify-completion: the vendored architect prompt has no reversals section"
printf '%s\n' "$architect" | grep -q 'KICKBACK OVERTURNED' \
  && ok "certify-completion: the architect's kickback outcome is named apart from the fixer's refutation" \
  || bad "certify-completion: the architect's kickback outcome still collides with refuted"
printf '%s\n' "$architect" | grep -q '\*\*REFUTE and fix\.\*\*' \
  && bad "certify-completion: the architect still calls its kickback outcome REFUTE" \
  || ok "certify-completion: no architect outcome reuses REFUTE"
printf '%s\n' "$architect" | grep -q 'DISSOLUTION OVERTURNED' \
  && ok "certify-completion: the architect's dissolution outcome carries its own item kind" \
  || bad "certify-completion: the architect's dissolution outcome is a bare OVERTURNED"

review=$(block "$core" CERTIFY-CODE-REVIEW-PROMPT)
printf '%s\n' "$review" | grep -q "SWEEP: complete" \
  && ok "certify-completion: the vendored code-review prompt has the reviewer declare its sweep complete" \
  || bad "certify-completion: the vendored code-review prompt carries no SWEEP: complete signal"
printf '%s\n' "$review" | grep -q "SWEEP: in progress" \
  && ok "certify-completion: the reviewer marks an unfinished sweep in progress" \
  || bad "certify-completion: the reviewer has no in-progress sweep signal"
printf '%s\n' "$review" | grep -q "LEDGER: n of m files read" \
  && ok "certify-completion: the reviewer reports its file ledger with every batch" \
  || bad "certify-completion: the reviewer reports no file ledger"
printf '%s\n' "$review" | grep -q "the files you closed since your last reply" \
  && ok "certify-completion: the reviewer names the files it closed, so the orchestrator can mark them read" \
  || bad "certify-completion: the reviewer never names the files it closed"
printf '%s\n' "$review" | grep -q '`DRY`' \
  && ok "certify-completion: the reviewer signals DRY when a complete sweep finds nothing new" \
  || bad "certify-completion: the reviewer has no DRY signal"
printf '%s\n' "$review" | grep -q '`VERIFIED` or `STILL OPEN`' \
  && ok "certify-completion: the reviewer verifies each resolved finding on the round's message" \
  || bad "certify-completion: the reviewer has no per-finding verification verdict"
printf '%s\n' "$review" | grep -q "Do not read the completion report beside the sprint" \
  && ok "certify-completion: the gate's reviewer stays blind to the executor's account" \
  || bad "certify-completion: the vendored code-review prompt lost its blindness clause"

printf '%s\n' "$review" | grep -q '{{CODE-REVIEW-BRIEF}}' \
  && ok "certify-completion: the gate's cold reviewer runs the one shared code-review brief" \
  || bad "certify-completion: the gate's code-review prompt no longer transcludes {{CODE-REVIEW-BRIEF}}"
standing=$(block "$core" STANDING-REVIEWER-PROMPT)
printf '%s\n' "$standing" | grep -q '{{CODE-REVIEW-BRIEF}}' \
  && ok "certify-completion: the build's standing reviewer runs that same brief" \
  || bad "certify-completion: the standing-reviewer prompt no longer transcludes {{CODE-REVIEW-BRIEF}}"
printf '%s\n' "$standing" | grep -q "### The stage's sprint alignment" \
  && ok "certify-completion: the standing reviewer judges each stage's own work items against the sprint" \
  || bad "certify-completion: the standing-reviewer prompt carries no stage-scoped alignment section"
printf '%s\n' "$standing" | grep -q 'what it breaks anywhere in the tree' \
  && ok "certify-completion: the standing reviewer's findings reach anywhere in the tree the increment breaks" \
  || bad "certify-completion: the standing reviewer's scope no longer reaches beyond the increment"

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
