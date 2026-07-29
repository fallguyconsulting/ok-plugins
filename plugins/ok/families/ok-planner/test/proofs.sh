#!/usr/bin/env bash
# Proof harness for the planner's ceremony stories.
#
# corpus-proof: a run over stories containing one honest passing proof,
# one deliberately failing proof, and one story with no annotated proof
# reports pass, failing, and missing respectively — collection by
# annotation exactly as /prove documents — and leaves a durable cost
# record a second, fresh process reads without executing anything,
# carrying each proof's own measured time (the passing proof sleeps a
# known quarter second and the record has to show it) and its own
# verdict (a story passing beside a failing one in a single harness
# invocation is recorded as passing, because that invocation's exit code
# is an aggregate over every story it proves), with the working tree
# otherwise unchanged: the estate's own ignore file is what keeps the
# record out of the repository.
#
# plan-a-sprint: the finished sprint document is self-sufficient — the
# ceremony's baked template and the produced sprints carry final-form
# deltas, flat work items, and the verbatim execution and completion
# boilerplate, so a third party can state from the document alone what
# will change and when the work is done.
#
# certify-completion: a close leaves its record — the newest archived
# sprint carries a `closed:` stamp naming a commit git can resolve, the
# baseline the next planning ceremony reads — and the gate's unattended
# promises (an undershoot is blocking at both ends of the alignment
# dispatch and never merely reported, a call made in the owner's absence
# reaches Divergences or the intake, the cap offers exactly two steps and
# reserves the choice between them to the owner alone — the run waiting
# for their word however long it takes, attended or not, and never taking
# either step itself — the presentation is
# written into the sprint's completion report, and archival waits for a
# clean status and takes the report with it) stand verbatim in the gate a
# project actually runs. Two conjuncts are not presence: the sprint /
# completion-report pairing is read off disk in both directions, and the
# judgment layer's mechanical floor is exercised through the project's
# own checker against a seeded repository — a skipped inspection pass
# fails the clean bar, and the same tree passes once the disposition is
# recorded durably.
#
# bootstrap-design-corpus: the bootstrap's abort-on-populated guard,
# evaluated over an empty and a populated fixture corpus, plus the
# produced estate's traceability — a discovery scaffold behind
# populated catalogs whose tables of contents match the files on disk —
# and the queue conjunct: every issue the intake holds declares a
# category from the canonical judgment taxonomy, with the filing rule
# the run applies named at its assertion in the skill that carries it.
#
# sketch-an-idea: a sketch produced from a one-line topic against the
# verb's own template lands dated among the records, carries the
# not-authorization stamp and the four mandated sections, and leaves
# `design/`, the intake, and `sprints/` untouched.
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
# corpus-audit: the audit verb a project actually runs is a pure
# in-context reporter — all four passes present, every finding carrying
# the advisory mechanical/judgment class in the report contract, and
# the read-only stance (no layout creation, no intake writes, no proof
# execution) standing verbatim in both the family source and the
# vendored copy — plus one conjunct that is not presence: every block
# the passes transclude resolves to exactly one canonical heading, so a
# pass cannot dispatch a prompt assembled from nothing. The seeded demo
# itself — three planted defects read back from the caller's report with
# the tree unchanged — is prompt-realized and named at its assertion.
#
# trace-corpus-to-code: the corpus view, exercised over a fixture project
# carrying both live artifact kinds, through its real HTTP surface: the
# listing carries every live story and decision with the determination
# its audit recorded; opening a story excerpts the code its audit cites;
# following that into the source file shows the same story
# claiming exactly those lines, an unclaimed region beside them, and the
# audit's whole-file pin held as a file-level claim rather than smeared
# over every line; a decision whose audit reaches a file by a plain
# anchor that appears twice claims both occurrences, excerpted on the
# artifact and marked in the code, so the two directions never give
# contradictory answers about one region; a source nothing claims is a
# row of its own; coverage
# is reported over the committed graph once one exists; and a
# deliberately broken citation reads stale in the view exactly as the
# project's own checker reports it — which is the point of the view
# calling that checker instead of reimplementing it. Both of the last
# two are asked of one long-lived server process after the tree moved
# under it, with nothing telling it so: the view reads the tree afresh
# per request, or it would answer from the snapshot it built at start
# and drift away from the checker it exists to agree with.
#
# deterministic-source-graph: the vendored extractor builds the
# committed graph twice on an unchanged fixture and the results
# byte-compare identical; an edit inside one declared unit moves
# exactly that unit's recorded hash and no unrelated hash — including
# an edit past a shell heredoc whose body carries stray braces, which
# naive brace counting would have written out of the enclosing
# function's span; a corrupted committed graph makes the checker exit
# non-zero.
#
# Where a Proof field names an inherently agentic observable — a live
# ceremony's dialogue, a subagent's refusal — the deterministic
# conjuncts are exercised here and the prompt-realized one is named at
# its assertion, with the skill file that carries it.
#
# @story: deterministic-source-graph
# @story: trace-corpus-to-code
# @story: corpus-proof
# @story: plan-a-sprint
# @story: certify-completion
# @story: bootstrap-design-corpus
# @story: sketch-an-idea
# @story: see-governing-versions
# @story: session-awareness
# @story: corpus-audit
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

# Per-story cost. Each story's section reports what proving that story
# took, so a run leaves a profile naming the expensive proof rather than
# only an expensive harness. `proof-timings run` exports
# PROOF_TIMINGS_OUT and folds these lines into the durable record a
# later session reads without re-running anything. A section that proves
# more than one story reports the one elapsed time it genuinely
# measured, marked shared, rather than inventing a split.
# @story: corpus-proof
# @decision: measure-first-verification-cost
emit_timing() {  # emit_timing <seconds> <verdict> <story> <case-name> [<scope>]
  [ -n "${PROOF_TIMINGS_OUT:-}" ] || return 0
  printf '%s\t%s\t%s\t%s\t%s\n' "$1" "$2" "$3" "$4" "${5:-}" >> "$PROOF_TIMINGS_OUT"
}

section_stories=""
section_started=""
section_fails=0

close_section() {
  [ -n "$section_stories" ] || return 0
  local secs verdict scope s count
  secs=$(python3 -c 'import sys, time; print("%.3f" % (time.time() - float(sys.argv[1])))' \
    "$section_started")
  verdict=ok
  if [ "$fails" -gt "$section_fails" ]; then verdict=fail; fi
  count=$(printf '%s\n' $section_stories | wc -l | tr -d ' ')
  scope=story-section
  if [ "$count" -gt 1 ]; then scope=shared-section; fi
  for s in $section_stories; do
    printf 'time: story:%s proved in %ss (%s)\n' "$s" "$secs" "$scope"
    emit_timing "$secs" "$verdict" "$s" "" "$scope"
  done
  section_stories=""
}

section() {  # section <story> [<story>...] — close the open section, open a new one
  close_section
  section_stories="$*"
  section_fails=$fails
  section_started=$(python3 -c 'import time; print("%.6f" % time.time())')
}

# --- corpus-proof: pass / failing / missing verdicts -------------------------
section corpus-proof
tmp=$(mktemp -d)
trap 'close_section; rm -rf "$tmp"' EXIT
mkdir -p "$tmp/design/stories" "$tmp/src"
for s in alpha beta gamma; do
  printf -- "---\nstory: %s\n---\n\n## Proof\n\nDemo — run the annotated test.\n" "$s" > "$tmp/design/stories/$s.md"
done
printf '#!/bin/sh\n# @story: alpha\nsleep 0.25\nexit 0\n' > "$tmp/src/alpha_test.sh"
printf '#!/bin/sh\n# @story: beta\nexit 1\n'  > "$tmp/src/beta_test.sh"
# One harness invocation proving two stories, one of which fails — the
# shape this family's own proofs.sh has (ten stories, one process, one
# aggregate exit code). The process exits non-zero because of the failing
# story; the passing story's own emitted section says ok.
cat > "$tmp/src/mixed_test.sh" <<'MIXED'
#!/bin/sh
# @story: mixed-pass
# @story: mixed-fail
emit() {
  [ -n "${PROOF_TIMINGS_OUT:-}" ] || return 0
  printf '%s\t%s\t%s\t\t%s\n' "$1" "$2" "$3" story-section >> "$PROOF_TIMINGS_OUT"
}
emit 0.010 ok   mixed-pass
emit 0.020 fail mixed-fail
exit 1
MIXED
chmod +x "$tmp/src"/*.sh
(cd "$tmp" && git init -q . && git add -A && git -c user.email=p@e.c -c user.name=p commit -qm fixture)

verdict_for() {
  local slug=$1 hits
  hits=$(grep -rl "@story: ${slug}" "$tmp/src" 2>/dev/null || true)
  if [ -z "$hits" ]; then echo "missing"; return; fi
  if sh "$hits" >/dev/null 2>&1; then echo "pass"; else echo "failing"; fi
}

[ "$(verdict_for alpha)" = "pass" ]    && ok "corpus-proof: honest passing proof reports pass"    || bad "alpha verdict wrong"
[ "$(verdict_for beta)"  = "failing" ] && ok "corpus-proof: deliberately failing proof reports failing" || bad "beta verdict wrong"
[ "$(verdict_for gamma)" = "missing" ] && ok "corpus-proof: unannotated story reports missing"    || bad "gamma verdict wrong"
# The run's durable half: what each proof cost, left where a later
# session reads it without re-running anything. The estate's own ignore
# file is what keeps that record out of the repository, so the tree is
# "otherwise unchanged" for real rather than by exemption.
# @decision: measure-first-verification-cost
timings_bin="$family/scripts/proof-timings"
mkdir -p "$tmp/.ok-planner"
sed "s/{{OK_PLANNER_VERSION}}/${suite_version}/g" \
  "$family/scripts/ok-planner-gitignore" > "$tmp/.ok-planner/.gitignore"
(cd "$tmp" && git add -A && git -c user.email=p@e.c -c user.name=p commit -qm ignore) >/dev/null

(cd "$tmp" && python3 "$timings_bin" run alpha src/alpha_test.sh -- sh src/alpha_test.sh) >/dev/null 2>&1
(cd "$tmp" && python3 "$timings_bin" run beta  src/beta_test.sh  -- sh src/beta_test.sh)  >/dev/null 2>&1
(cd "$tmp" && python3 "$timings_bin" record gamma - missing 0) >/dev/null 2>&1

[ -f "$tmp/.ok-planner/proof-timings.json" ] \
  && ok "corpus-proof: the run leaves a durable cost record" \
  || bad "corpus-proof: the run left no cost record"

# A second session, by construction: a fresh process that executes no
# proof and still reports what each one cost.
second_session=$(cd "$tmp" && python3 "$timings_bin" show 2>&1)
if printf '%s' "$second_session" | grep -q "alpha" \
   && printf '%s' "$second_session" | grep -q "beta" \
   && printf '%s' "$second_session" | grep -q "gamma"; then
  ok "corpus-proof: a later session reads every proof's cost without re-running"
else
  bad "corpus-proof: the record does not carry every proof's cost: $second_session"
fi

# The recorded number is a measurement, not a placeholder: alpha's proof
# sleeps a known quarter second and the record has to show it.
measured=$(cd "$tmp" && python3 - "$timings_bin" <<'PY'
import json, subprocess, sys
out = subprocess.check_output([sys.executable, sys.argv[1], "show", "--json"])
rows = {e["story"]: e for e in json.loads(out)["proofs"]}
alpha = rows.get("alpha", {})
print("yes" if alpha.get("seconds", 0) >= 0.2 and alpha.get("verdict") == "pass"
      and rows.get("beta", {}).get("verdict") == "failing"
      and rows.get("gamma", {}).get("verdict") == "missing" else "no")
PY
)
[ "$measured" = "yes" ] \
  && ok "corpus-proof: each proof's recorded cost is its own measured time" \
  || bad "corpus-proof: the recorded costs are not per-proof measurements"

# A mixed run: two stories in one harness invocation, one failing. The
# invocation's exit code is an aggregate and says nothing about the story
# that passed, so a passing story sharing a process with a failing one
# must still be recorded as passing — otherwise the durable profile
# reports a verdict no proof produced.
(cd "$tmp" && python3 "$timings_bin" run mixed-pass,mixed-fail src/mixed_test.sh \
  -- sh src/mixed_test.sh) >/dev/null 2>&1
mixed=$(cd "$tmp" && python3 - "$timings_bin" <<'PY'
import json, subprocess, sys
out = subprocess.check_output([sys.executable, sys.argv[1], "show", "--json"])
rows = {e["story"]: e for e in json.loads(out)["proofs"]}
print("yes" if rows.get("mixed-pass", {}).get("verdict") == "pass"
      and rows.get("mixed-fail", {}).get("verdict") == "failing" else
      "no (%s / %s)" % (rows.get("mixed-pass", {}).get("verdict"),
                        rows.get("mixed-fail", {}).get("verdict")))
PY
)
[ "$mixed" = "yes" ] \
  && ok "corpus-proof: a story that passes beside a failing one in the same invocation is recorded as passing" \
  || bad "corpus-proof: a shared invocation's exit code overwrote a passing story's verdict — $mixed"

[ -z "$(cd "$tmp" && git status --porcelain)" ] \
  && ok "corpus-proof: working tree otherwise unchanged after the run" \
  || bad "corpus-proof: the run mutated the working tree"

# --- plan-a-sprint: the sprint document is the whole brief --------------------
section plan-a-sprint
template="$suite_repo/plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md"
for needle in "## How to execute this sprint" "## Completion contract" "## Corpus deltas" "## Work items"; do
  grep -qF "$needle" "$template" \
    && ok "plan-a-sprint: ceremony template bakes \"$needle\"" \
    || bad "plan-a-sprint: ceremony template lacks \"$needle\""
done

# Sprint discovery excludes companion completion reports: a report lives
# beside its sprint with `-completion` before the extension and is never a
# sprint (@concept: completion-report), so it carries none of the sprint
# boilerplate a sprint is asserted to carry.
produced=$(ls -1 "$suite_repo/.ok-planner/sprints" "$suite_repo/.ok-planner/history/sprints" 2>/dev/null | grep '\.md$' | grep -vc -- '-completion\.md$' || true)
if [ "$produced" -gt 0 ]; then
  newest=$(ls -1t "$suite_repo/.ok-planner/sprints"/*.md "$suite_repo/.ok-planner/history/sprints"/*.md 2>/dev/null | grep -v -- '-completion\.md$' | head -1)
  if grep -qF "## How to execute this sprint" "$newest" && grep -qF "## Completion contract" "$newest"; then
    ok "plan-a-sprint: produced sprint carries the verbatim execution and completion boilerplate ($(basename "$newest"))"
  else
    bad "plan-a-sprint: produced sprint is missing its baked boilerplate ($(basename "$newest"))"
  fi
else
  ok "plan-a-sprint: no produced sprints in this checkout — template assertion stands alone"
fi

# --- certify-completion: the close leaves its record --------------------------
section certify-completion
archive="$suite_repo/.ok-planner/history/sprints"
if [ -d "$archive" ] && ls "$archive"/*.md >/dev/null 2>&1; then
  stamped=$(grep -l "^closed: " "$archive"/*.md 2>/dev/null | sort | tail -1)
  if [ -n "${stamped:-}" ]; then
    sha=$(sed -n 's/^closed: \([0-9a-f]\{7,40\}\).*/\1/p' "$stamped" | head -1)
    if [ -n "$sha" ] && git -C "$suite_repo" cat-file -e "${sha}^{commit}" 2>/dev/null; then
      ok "certify-completion: archived sprint carries a closed: stamp resolving to a real commit ($(basename "$stamped"))"
    else
      bad "certify-completion: closed: stamp does not resolve to a commit ($(basename "$stamped"))"
    fi
  else
    bad "certify-completion: no archived sprint carries a closed: stamp"
  fi
else
  bad "certify-completion: no archived sprint in this checkout — the close record is unexhibited"
fi

# certify-completion, the unattended promises. The gate is a prompt, so
# the seeded run itself is prompt-realized; what is checkable — and what
# a regression would silently drop — is that the governing sentences
# stand in the gate and its shared core, verbatim.
gate="$family/skills/certify-work/SKILL.md"
core="$family/skills/_shared/certification-core.md"
# Undershoot-blocking is stated at both ends of one dispatch: the gate's
# producer line names it, and the governing sentence the dispatched judge
# actually reads lives in the shared core's alignment prompt. Both are
# asserted, so neither end can be dropped silently.
grep -qF "an undershoot is a **blocking** finding" "$gate" \
  && ok "certify-completion: an undershoot is blocking in the gate a project runs" \
  || bad "certify-completion: the gate no longer treats an undershoot as blocking"
grep -qF "An undershoot is a BLOCKING finding even when every" "$core" \
  && ok "certify-completion: the dispatched alignment judge reads undershoot as blocking even when the tests are green" \
  || bad "certify-completion: the alignment prompt no longer governs undershoot as blocking"
grep -qiF "never appear" "$core" && grep -qi "undershoot" "$core" \
  && ok "certify-completion: a fixed undershoot is barred from the presentation's Divergences" \
  || bad "certify-completion: nothing bars a fixed undershoot from Divergences"
grep -qi "divergence" "$core" && grep -qi "sprint and corpus were silent\|corpus were silent" "$core" \
  && ok "certify-completion: calls made where sprint and corpus were silent land in Divergences" \
  || bad "certify-completion: the silent-intent call has no reporting channel"
grep -qi "only if.*clean\|only when.*clean\|certified clean" "$gate" \
  && ok "certify-completion: archival is offered only on a clean status" \
  || bad "certify-completion: archival is not gated on a clean status"
# The cap's two steps stand, and the choice between them is reserved to
# the owner at both ends: the shared core's exit rule states it for the
# loop, and each gate a project runs states it at its own touchpoint.
# Both gates are read — change-scoped and whole-corpus alike — so a
# regression that reintroduces a default cap step in either one fails
# here, whether by dropping the waiting sentence or by restating the
# removed unattended exception ("interactive run only") anywhere in the
# file.
grep -qF "puts exactly two process steps to the owner" "$core" \
  && grep -qF "The choice between those two steps is the owner's alone, and the run never takes either step itself." "$core" \
  && grep -qF "there is no default and no unattended exception" "$core" \
  && ok "certify-completion: the loop's exit rule offers exactly two cap steps, reserves the choice to the owner alone, and grants no unattended exception" \
  || bad "certify-completion: the cap's two steps or the owner-only reservation of its choice are gone from the loop's exit rule"
for cap_gate in "$family/skills/certify-work/SKILL.md" "$family/skills/certify-all/SKILL.md"; do
  cap_gate_name="$(basename "$(dirname "$cap_gate")")"
  grep -qF "the gate never takes either cap step itself" "$cap_gate" \
    && grep -qF "waits for their word, however long that takes, attended or not" "$cap_gate" \
    && ! grep -qF "interactive run only" "$cap_gate" \
    && ok "certify-completion: /$cap_gate_name stops at the cap and waits for the owner's word however long it takes, attended or not — no default step" \
    || bad "certify-completion: a default cap step has crept back into /$cap_gate_name for runs with nobody watching"
done
# Parked at the cap is a legal in-flight state, not a licence to finish:
# the sprint boilerplate the ceremony bakes says so to any goal checker.
grep -qF "loop's cycle cap awaiting the owner's direction is a legal in-flight" "$family/skills/plan-sprint/SKILL.md" \
  && grep -qF "either cap step itself. Nothing else counts either way." "$family/skills/plan-sprint/SKILL.md" \
  && ok "certify-completion: the baked completion contract's goal rule recognises a run parked at the cap as legally in flight" \
  || bad "certify-completion: the goal rule leaves a run parked at the cap with no legal state"

# The presentation is the completion report's, not the conversation's, and
# the two archive as one record. Both promises are new in the Acceptance
# and both are checkable: the governing sentences stand in the core and
# the gate, and the file layout they describe holds on disk.
grep -qF "written into the sprint's completion report" "$core" \
  && ok "certify-completion: the composed presentation is written into the sprint's completion report" \
  || bad "certify-completion: nothing routes the presentation into the completion report"
grep -qF "together with its completion report" "$gate" \
  && ok "certify-completion: the close-out archives the sprint together with its completion report" \
  || bad "certify-completion: archival no longer pairs the sprint with its report"

# The layout that promise produces, read off disk. A completion report
# lives beside its sprint, named for it with `-completion` before the
# extension (@concept: completion-report), and is never itself a sprint:
# so every sprint in flight has its report, and every report — in flight
# or archived — has its sprint beside it.
pair_report=$(python3 - "$suite_repo/.ok-planner" <<'PY'
import glob, os, sys
root = sys.argv[1]
problems, live, pairs = [], 0, 0
for d in ("sprints", os.path.join("history", "sprints")):
    files = sorted(glob.glob(os.path.join(root, d, "*.md")))
    reports = [f for f in files if f.endswith("-completion.md")]
    sprints = [f for f in files if not f.endswith("-completion.md")]
    for r in reports:
        if r[:-len("-completion.md")] + ".md" not in sprints:
            problems.append("%s has no sprint beside it" % os.path.basename(r))
        else:
            pairs += 1
    if d == "sprints":
        for s in sprints:
            live += 1
            if s[:-3] + "-completion.md" not in reports:
                problems.append("%s is in flight with no completion report"
                                % os.path.basename(s))
if problems:
    print("BAD " + "; ".join(problems))
elif pairs or live:
    print("OK %d sprint/report pair(s), %d sprint(s) in flight" % (pairs, live))
else:
    print("EMPTY no sprint and no report to pair")
PY
)
case "$pair_report" in
  OK*)  ok "certify-completion: every completion report sits beside its sprint and every sprint in flight has one (${pair_report#OK })" ;;
  BAD*) bad "certify-completion: the sprint/report pairing is broken — ${pair_report#BAD }" ;;
  *)    bad "certify-completion: the pairing conjunct is unexhibited — ${pair_report#EMPTY }" ;;
esac

# The judgment layer's mechanical floor — the Falsifier's "the judgment
# layer is skipped and the gate still reads clean". This one is not
# agentic: the gate's own clean bar is a deterministic program, so it is
# exhibited here through the checker a project actually runs, against a
# seeded repository whose change no citation covers. Skipped pass first
# (no registry at all), then the same tree with the inspector's judgment
# recorded.
floor="$suite_repo/.ok-planner/bin/audit-check"
sgraph_bin="$suite_repo/.ok-planner/bin/source-graph"
floor_repo="$tmp/inspection-floor"
if [ -x "$floor" ] && [ -x "$sgraph_bin" ]; then
  mkdir -p "$floor_repo"
  cp -R "$family/test/fixtures/node-cited-clean/." "$floor_repo/"
  (cd "$floor_repo" && git init -q && git add -A \
    && git -c user.email=t@t.t -c user.name=t commit -qm base) >/dev/null 2>&1
  cat > "$floor_repo/src/util.js" <<'JS'
function helper(n) {
  return n - 1;
}
module.exports = { helper };
JS
  python3 "$sgraph_bin" build "$floor_repo" >/dev/null
  skipped=$(python3 "$floor" "$floor_repo" --inspection 2>&1); skipped_rc=$?
  if [ "$skipped_rc" -ne 0 ] && printf '%s\n' "$skipped" | grep -q "inspection-"; then
    ok "certify-completion: a skipped judgment pass fails the gate's clean bar mechanically instead of reading clean"
  else
    bad "certify-completion: a skipped judgment pass read clean (exit $skipped_rc): $skipped"
  fi
  cat > "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
---
inspection-registry: v1
inspected: 2026-07-29T00:00:00Z
---

# Inspection registry

REG
  # Both nodes the new file put in play: the declared unit, and the
  # file node — the only handle on what the file carries outside every
  # declared unit (here its module-level export line).
  (cd "$floor_repo" && python3 "$floor" cite-node src/util.js#helper \
    | sed 's/^- cite-node: /- node: /') >> "$floor_repo/.ok-planner/audits/inspection.md"
  cat >> "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
  class: residue
  note: a new helper, claimed by no audit
REG
  (cd "$floor_repo" && python3 "$floor" cite-node src/util.js \
    | sed 's/^- cite-node: /- node: /') >> "$floor_repo/.ok-planner/audits/inspection.md"
  cat >> "$floor_repo/.ok-planner/audits/inspection.md" <<'REG'
  class: residue
  note: the new module's export line, claimed by no audit
REG
  judged=$(python3 "$floor" "$floor_repo" --inspection 2>&1); judged_rc=$?
  if [ "$judged_rc" -eq 0 ]; then
    ok "certify-completion: the same tree passes once the judgment pass recorded its disposition durably"
  else
    bad "certify-completion: a recorded disposition did not satisfy the floor (exit $judged_rc): $judged"
  fi
else
  bad "certify-completion: the project's own checker or graph builder is absent — the gate's clean bar is unexhibited"
fi

# --- plan-a-sprint: the queue fold ------------------------------------------
section plan-a-sprint
# Every issue a ceremony walked closed exactly two ways: promoted into a
# named sprint that exists, or retired with a reason under Ruling.
fold_check() {
  local root=$1 label=$2 walked=0 problems=0 f status sprint
  for f in "$root"/issues/*.md "$root"/history/issues/*.md; do
    [ -e "$f" ] || continue
    status=$(sed -n 's/^status:[[:space:]]*"*\([a-z]*\)"*.*/\1/p' "$f" | head -1)
    sprint=$(sed -n 's/^sprint:[[:space:]]*"*\([^"]*\)"*[[:space:]]*$/\1/p' "$f" | head -1)
    case "$status" in
      promoted)
        walked=$((walked + 1))
        if [ -z "$sprint" ]; then
          echo "    $(basename "$f"): promoted with no sprint named"; problems=$((problems + 1))
        elif [ ! -f "$root/sprints/$sprint" ] && [ ! -f "$root/history/sprints/$sprint" ]; then
          echo "    $(basename "$f"): promoted into a sprint that does not exist ($sprint)"; problems=$((problems + 1))
        fi
        ;;
      retired)
        walked=$((walked + 1))
        if ! awk '/^## Ruling/{r=1;next} r&&NF{found=1} END{exit !found}' "$f"; then
          echo "    $(basename "$f"): retired with no reason under Ruling"; problems=$((problems + 1))
        fi
        ;;
      *) ;;
    esac
  done
  if [ "$walked" -eq 0 ]; then
    echo "    no walked issue to fold"
    return 1
  fi
  [ "$problems" -eq 0 ] || return 1
  echo "    $walked walked"
  return 0
}

report_fold() {
  local root=$1 label=$2 out
  if out=$(fold_check "$root" "$label"); then
    ok "plan-a-sprint: $label — every walked issue is promoted into an existing sprint or retired with a reason ($(echo "$out" | tail -1 | tr -d ' '))"
  else
    bad "plan-a-sprint: $label — walked issues fold to nothing:"; echo "$out"
  fi
}

report_fold "$suite_repo/.ok-planner" "this project's queue"

# The same fold over a seeded fixture, so the check is exhibited failing
# as well as passing.
fixture="$tmp/fold"
mkdir -p "$fixture/issues" "$fixture/history/issues" "$fixture/sprints" "$fixture/history/sprints"
printf -- "---\nissue: a\nstatus: promoted\nsprint: 2026-01-01-real.md\n---\n" > "$fixture/history/issues/a.md"
printf -- "---\nissue: b\nstatus: retired\n---\n\n## Ruling\n\nThe owner dropped it: superseded by the profile.\n" > "$fixture/history/issues/b.md"
printf "# Sprint\n" > "$fixture/history/sprints/2026-01-01-real.md"
report_fold "$fixture" "seeded fixture"

printf -- "---\nissue: c\nstatus: promoted\nsprint: 2026-01-01-missing.md\n---\n" > "$fixture/history/issues/c.md"
if fold_check "$fixture" "dangling" >/dev/null 2>&1; then
  bad "plan-a-sprint: the fold accepts a promotion pointing at no sprint"
else
  ok "plan-a-sprint: the fold rejects a promotion pointing at no sprint"
fi
rm -f "$fixture/history/issues/c.md"

# The first conjunct, sharpened: the produced sprint's deltas are
# final-form artifact bodies, not summaries.
if [ -n "${newest:-}" ]; then
  if awk '/^## Corpus deltas/{d=1} d&&/^```markdown$/{f=1} d&&f&&/^(concept|story|decision): /{print; exit}' "$newest" | grep -q ':'; then
    ok "plan-a-sprint: the produced sprint's deltas are final-form artifact bodies ($(basename "$newest"))"
  else
    bad "plan-a-sprint: the produced sprint's deltas are not final-form artifact bodies ($(basename "$newest"))"
  fi
  if grep -qE '^- \*\*' "$newest"; then
    ok "plan-a-sprint: the produced sprint's work items are a flat list"
  else
    bad "plan-a-sprint: the produced sprint carries no flat work-item list"
  fi
fi

# --- bootstrap-design-corpus -------------------------------------------------
section bootstrap-design-corpus
# The guard's predicate, evaluated over both fixture states. The refusal
# itself is prompt-realized in skills/discover-design/SKILL.md, whose
# governing sentence is asserted below.
bootstrap_state() {
  local corpus=$1
  for kind in concepts stories decisions; do
    if [ -d "$corpus/$kind" ] && [ -n "$(ls -A "$corpus/$kind" 2>/dev/null)" ]; then
      echo abort; return
    fi
  done
  echo proceed
}
empty_corpus="$tmp/bootstrap-empty/design"
mkdir -p "$empty_corpus/concepts" "$empty_corpus/stories" "$empty_corpus/decisions"
[ "$(bootstrap_state "$empty_corpus")" = "proceed" ] \
  && ok "bootstrap-design-corpus: an empty corpus is a first invocation — the run proceeds" \
  || bad "bootstrap-design-corpus: an empty corpus was refused"
printf -- "---\nconcept: thing\n---\n" > "$empty_corpus/concepts/thing.md"
[ "$(bootstrap_state "$empty_corpus")" = "abort" ] \
  && ok "bootstrap-design-corpus: a second invocation against populated catalogs aborts rather than overwrite" \
  || bad "bootstrap-design-corpus: a populated corpus was not refused"
grep -qF "Non-empty \`concepts/\`, \`stories/\`, or \`decisions/\` → abort." "$family/skills/discover-design/SKILL.md" \
  && ok "bootstrap-design-corpus: the refusal the harness models is the skill's own stated guard" \
  || bad "bootstrap-design-corpus: the skill no longer states the abort guard"

# The queue conjunct — "sees only judgment items in the queue". The
# filing itself is prompt-realized: the extractor prompt in
# skills/discover-design/SKILL.md transcludes {{ISSUE-DEFINITION}}, whose
# "Only judgment items become issues" is the rule the run files under.
# Deterministic here: the transclusion is live, the canonical rule still
# says it, and every issue the intake actually holds declares a category
# from that block's own taxonomy — a mechanical item has none to declare.
grep -qF "{{ISSUE-DEFINITION}}" "$family/skills/discover-design/SKILL.md" \
  && ok "bootstrap-design-corpus: the bootstrap's filer runs under the canonical issue definition" \
  || bad "bootstrap-design-corpus: the extractor prompt no longer transcludes the issue definition"
grep -qF "Only judgment items become issues." "$family/skills/_shared/artifact-definitions.md" \
  && ok "bootstrap-design-corpus: the canonical definition still admits only judgment items to the queue" \
  || bad "bootstrap-design-corpus: the canonical definition no longer restricts the queue to judgment items"
queue_report=$(python3 - "$family/skills/_shared/artifact-definitions.md" "$suite_repo/.ok-planner" <<'PY'
import glob, os, re, sys
defs, root = sys.argv[1], sys.argv[2]
block = re.search(r"### \{\{ISSUE-DEFINITION\}\}(.*?)\n---\n", open(defs).read(), re.S)
taxonomy = set(re.findall(r"^- `([a-z-]+)`", block.group(1), re.M)) if block else set()
files = sorted(glob.glob(os.path.join(root, "issues", "*.md")) +
               glob.glob(os.path.join(root, "history", "issues", "*.md")))
bad = []
for f in files:
    m = re.search(r"^category:\s*\"?([a-z-]+)\"?\s*$", open(f).read(), re.M)
    if not m or m.group(1) not in taxonomy:
        bad.append("%s (%s)" % (os.path.basename(f), m.group(1) if m else "no category"))
if not taxonomy or not files:
    print("EMPTY %d categories / %d issues" % (len(taxonomy), len(files)))
elif bad:
    print("BAD " + ", ".join(bad))
else:
    print("OK %d issues against %d categories" % (len(files), len(taxonomy)))
PY
)
case "$queue_report" in
  OK*)  ok "bootstrap-design-corpus: every issue in the queue declares a judgment category (${queue_report#OK })" ;;
  BAD*) bad "bootstrap-design-corpus: the queue holds a non-judgment item — ${queue_report#BAD }" ;;
  *)    bad "bootstrap-design-corpus: the queue conjunct is unexhibited — ${queue_report#EMPTY }" ;;
esac

# The produced estate: catalogs traceable to a discovery scaffold, with
# tables of contents matching the files on disk.
corpus="$suite_repo/.ok-planner/design"
scaffold=$(ls -1 "$corpus/_discover"/*.md 2>/dev/null | wc -l | tr -d ' ')
[ "$scaffold" -gt 0 ] \
  && ok "bootstrap-design-corpus: the discovery scaffold the catalogs were extracted from is present ($scaffold entries)" \
  || bad "bootstrap-design-corpus: no discovery scaffold behind the catalogs"
for kind in concepts stories decisions; do
  on_disk=$(ls -1 "$corpus/$kind"/*.md 2>/dev/null | wc -l | tr -d ' ')
  listed=$(grep -cE '^- `[a-z0-9-]+`' "$corpus/$kind.md" 2>/dev/null)
  listed=${listed:-0}
  if [ "$on_disk" -gt 0 ] && [ "$listed" -eq "$on_disk" ]; then
    ok "bootstrap-design-corpus: the $kind table of contents lists exactly the $on_disk files on disk"
  else
    bad "bootstrap-design-corpus: the $kind TOC lists $listed of $on_disk artifacts"
  fi
done

# --- sketch-an-idea ----------------------------------------------------------
section sketch-an-idea
# The sketch is authored by the verb (prompt-realized); what is checkable
# is that its own template, instantiated from a one-line topic, produces
# a record with the mandated shape and touches nothing else.
sketch_repo="$tmp/sketch"
mkdir -p "$sketch_repo/.ok-planner/design/concepts" "$sketch_repo/.ok-planner/issues" "$sketch_repo/.ok-planner/sprints" "$sketch_repo/.ok-planner/sketches"
before_state=$(cd "$sketch_repo" && find . -type f | sort)
topic="tag-scoped-runtimes"
sketch_path="$sketch_repo/.ok-planner/sketches/$(date +%Y-%m-%d)-${topic}-sketch.md"
python3 - "$family/skills/sketch/SKILL.md" "$sketch_path" "$topic" <<'PY'
import re, sys
skill, out, topic = sys.argv[1:4]
text = open(skill).read()
body = text.split("## Sketch template", 1)[1]
body = body.split("```markdown", 1)[1].split("```", 1)[0]
body = body.replace("<Topic>", topic).replace("<topic>", topic)
open(out, "w").write(body.lstrip("\n"))
PY
[ -f "$sketch_path" ] \
  && ok "sketch-an-idea: a single dated sketch lands among the project's live records" \
  || bad "sketch-an-idea: no sketch was produced"
grep -qF "Sketch (not a sprint; not authorization to build)" "$sketch_path" \
  && ok "sketch-an-idea: the sketch is stamped as not a sprint and not authorization to build" \
  || bad "sketch-an-idea: the not-authorization stamp is missing"
missing=""
for section in "## Idea" "## Shape" "## Open questions" "## Risks"; do
  grep -qF "$section" "$sketch_path" || missing="$missing $section"
done
[ -z "$missing" ] \
  && ok "sketch-an-idea: the sketch carries the idea, its shape, open questions and risks" \
  || bad "sketch-an-idea: mandated sections missing:$missing"
after_state=$(cd "$sketch_repo" && find . -type f -not -path "./.ok-planner/sketches/*" | sort)
[ "$before_state" = "$after_state" ] \
  && ok "sketch-an-idea: the corpus, the intake and sprints/ are untouched" \
  || bad "sketch-an-idea: capturing the idea wrote outside sketches/"
grep -qF 'Does not write to `design/` or file into `.ok-planner/issues/`' "$family/skills/sketch/SKILL.md" \
  && ok "sketch-an-idea: the verb states the prohibition the fixture exhibits" \
  || bad "sketch-an-idea: the verb no longer prohibits writing the corpus or the intake"

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
grep -qF 'find the line that begins `Conduct version:`' "$family/skills/ok-version/SKILL.md" \
  && ok "see-governing-versions: the conduct number is read from the style actually loaded, not from what is installed" \
  || bad "see-governing-versions: the verb no longer reads the conduct number from the active output style"
# On this project, the governing number and the stamped artifact agree.
this_stamp=$(sed -n 's/.*ok-planner v\([0-9A-Za-z.\-]*\) is materialized.*/\1/p' \
  "$suite_repo/.ok-planner/hooks/session-start" 2>/dev/null | head -1)
[ -n "$this_stamp" ] && [ "$this_stamp" = "$suite_version" ] \
  && ok "see-governing-versions: this project's stamped artifact matches the carried manifest (v$this_stamp)" \
  || bad "see-governing-versions: this project's stamp (${this_stamp:-none}) does not match the manifest (v${suite_version})"

# --- deterministic-source-graph: build twice, edit one unit, corrupt ---------
section deterministic-source-graph
source_graph="$family/scripts/source-graph"
sg="$tmp/source-graph-fixture"
mkdir -p "$sg/src" "$sg/docs"
cat > "$sg/src/app.js" <<'EOF'
const util = require('./util.js');

function main(argv) {
  return util.go(argv.length);
}

function side(x) {
  return x - 1;
}
EOF
cat > "$sg/src/util.js" <<'EOF'
function go(n) { return n * 2; }
module.exports = { go };
EOF
printf '# Guide\n\nSee src/app.js.\n\n## Setup\n\nSteps.\n' > "$sg/docs/readme.md"

python3 "$source_graph" build "$sg" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the extractor builds the committed graph from the fixture tree" \
  || bad "deterministic-source-graph: build failed"
first=$(cd "$sg/.ok-planner/graph" && find . -name '*.graph' | sort | xargs cat | shasum)
python3 "$source_graph" build "$sg" >/dev/null 2>&1
second=$(cd "$sg/.ok-planner/graph" && find . -name '*.graph' | sort | xargs cat | shasum)
[ "$first" = "$second" ] \
  && ok "deterministic-source-graph: two builds on an unchanged tree byte-compare identical" \
  || bad "deterministic-source-graph: repeated builds differ on an identical tree"
python3 "$source_graph" check "$sg" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the checker is clean on a freshly built graph" \
  || bad "deterministic-source-graph: the checker flags a fresh graph"

# Edit inside one declared unit: exactly that node's hash moves.
before_app=$(cat "$sg/.ok-planner/graph/src/app.js.graph")
before_util=$(cat "$sg/.ok-planner/graph/src/util.js.graph")
sed_i() { sed "$1" "$2" > "$2.tmp" && mv "$2.tmp" "$2"; }
sed_i 's/return x - 1;/return x - 2;/' "$sg/src/app.js"
python3 "$source_graph" check "$sg" >/dev/null 2>&1
[ $? -eq 2 ] \
  && ok "deterministic-source-graph: the checker reports drift after an in-unit edit and exits non-zero" \
  || bad "deterministic-source-graph: a stale committed graph passed the checker silently"
python3 "$source_graph" build "$sg" >/dev/null 2>&1
after_app=$(cat "$sg/.ok-planner/graph/src/app.js.graph")
after_util=$(cat "$sg/.ok-planner/graph/src/util.js.graph")
moved=$(diff <(echo "$before_app") <(echo "$after_app") | grep -c '^[<>] node' || true)
side_moved=$(diff <(echo "$before_app") <(echo "$after_app") | grep -c '^[<>] node src/app.js#side' || true)
if [ "$side_moved" -eq 2 ] && [ "$moved" -eq 2 ]; then
  ok "deterministic-source-graph: the edited unit's hash moved and no other node's did"
else
  bad "deterministic-source-graph: hash movement was not confined to the edited unit ($moved node lines changed)"
fi
[ "$before_util" = "$after_util" ] \
  && ok "deterministic-source-graph: an unrelated file's recorded hashes are untouched" \
  || bad "deterministic-source-graph: the edit moved hashes in an unrelated file"

# Corrupt the committed graph: the checker exits non-zero.
echo "corrupt" >> "$sg/.ok-planner/graph/src/util.js.graph"
python3 "$source_graph" check "$sg" >/dev/null 2>&1
[ $? -eq 2 ] \
  && ok "deterministic-source-graph: a corrupted committed graph makes the checker exit non-zero" \
  || bad "deterministic-source-graph: a corrupted graph passed the checker"

# A declared unit's span must survive text the language does not read as
# code: a shell heredoc body carrying a stray closing brace would end the
# enclosing function early under naive brace counting, and an edit after
# the heredoc — still inside the function — would then move no hash at
# all, falsifying the story. The seeded bodies are deliberately
# *unbalanced* — a lone `}` in the first, a lone `{` in the second — so
# that per-line net brace counting cannot cancel them out: drop the
# heredoc blanking and the first body closes `emit` early, the second
# reopens the depth so the neighbouring function is unharmed, and the
# post-heredoc edit lands outside the recorded span. Both heredoc forms
# are exercised: the quoted `<<'EOF'` and the tab-stripping `<<-END`.
sgh="$tmp/source-graph-heredoc"
mkdir -p "$sgh"
cat > "$sgh/tool.sh" <<'SHFIXTURE'
#!/usr/bin/env bash

emit() {
  cat <<'EOF'
a lone } closing brace, unbalanced, inside heredoc prose
EOF
	cat <<-END
	{ a lone opening brace in an indented heredoc body
	END
  echo "after the heredoc, still inside emit"
}

other() {
  echo "untouched"
}
SHFIXTURE
python3 "$source_graph" build "$sgh" >/dev/null 2>&1
hd_graph="$sgh/.ok-planner/graph/tool.sh.graph"
before_emit=$(grep -c '^node tool.sh#emit ' "$hd_graph" || true)
before_other=$(grep '^node tool.sh#other ' "$hd_graph" || true)
before_emit_line=$(grep '^node tool.sh#emit ' "$hd_graph" || true)
[ "$before_emit" -eq 1 ] && [ -n "$before_other" ] \
  && ok "deterministic-source-graph: a heredoc body's braces do not split or swallow the enclosing shell function" \
  || bad "deterministic-source-graph: heredoc braces corrupted the shell function nodes"
sed_i 's/after the heredoc, still inside emit/after the heredoc, edited/' "$sgh/tool.sh"
python3 "$source_graph" build "$sgh" >/dev/null 2>&1
after_emit_line=$(grep '^node tool.sh#emit ' "$hd_graph" || true)
after_other=$(grep '^node tool.sh#other ' "$hd_graph" || true)
[ -n "$after_emit_line" ] && [ "$before_emit_line" != "$after_emit_line" ] \
  && ok "deterministic-source-graph: an edit after a heredoc but inside the function moves that node's hash" \
  || bad "deterministic-source-graph: an edit past a heredoc left the enclosing function's hash standing still"
[ "$before_other" = "$after_other" ] \
  && ok "deterministic-source-graph: the neighbouring shell function's hash is untouched" \
  || bad "deterministic-source-graph: the heredoc edit moved an unrelated function's hash"

# "Identical trees yield byte-identical graphs" is a claim about the
# *committed* tree, so what a contributor leaves lying around must not
# reach the graph: a gitignored file is machine- or session-local —
# personal settings, editor state, a runtime lock — and graphing one
# makes two checkouts of the same commit disagree, which is precisely
# this story's falsifier. The walk therefore sources its file list from
# git wherever the root is a git working tree. Both halves are asserted:
# a walk that merely dropped such files by name would silently stop
# graphing whole projects that do not use git.
sgi="$tmp/source-graph-gitignore"
mkdir -p "$sgi/src"
printf 'function keep(x) { return x + 1; }\n' > "$sgi/src/keep.js"
printf 'function local_only(x) { return x; }\n' > "$sgi/src/settings.local.js"
printf 'src/settings.local.js\n' > "$sgi/.gitignore"
(cd "$sgi" && git init -q . && git add -A \
  && git -c user.email=p@e.c -c user.name=p commit -qm fixture) >/dev/null 2>&1
python3 "$source_graph" build "$sgi" >/dev/null 2>&1
if [ -f "$sgi/.ok-planner/graph/src/keep.js.graph" ] \
   && [ ! -f "$sgi/.ok-planner/graph/src/settings.local.js.graph" ]; then
  ok "deterministic-source-graph: a gitignored local file stays out of the graph while its tracked neighbour is graphed"
else
  bad "deterministic-source-graph: the walk graphed a gitignored file (or lost a tracked one), so a contributor's local files move the graph"
fi
python3 "$source_graph" check "$sgi" >/dev/null 2>&1 \
  && ok "deterministic-source-graph: the checker is clean on a git tree whose ignored files are absent from the graph" \
  || bad "deterministic-source-graph: the checker flags the graph it just built over a git tree"
rm -rf "$sgi/.git" "$sgi/.ok-planner"
python3 "$source_graph" build "$sgi" >/dev/null 2>&1
[ -f "$sgi/.ok-planner/graph/src/settings.local.js.graph" ] \
  && ok "deterministic-source-graph: with no git present the fallback walk still graphs every file" \
  || bad "deterministic-source-graph: the fallback walk lost files in a project without git"

# --- trace-corpus-to-code: the corpus view, both directions ------------------
section trace-corpus-to-code
view_tmp=$(mktemp -d)
mkdir -p "$view_tmp/.ok-planner/design/stories" \
         "$view_tmp/.ok-planner/design/decisions" \
         "$view_tmp/.ok-planner/audits/stories" \
         "$view_tmp/.ok-planner/audits/decisions" \
         "$view_tmp/.ok-planner/issues" \
         "$view_tmp/src"
(cd "$view_tmp" && git init -q .)

# A fixture project carrying both live artifact kinds: a story whose audit
# cites one source file by span and pins it whole, a decision whose audit
# reaches a second file by a plain anchor that appears on two lines — the
# multi-hit form the checker allows — and a third file nothing in the
# corpus reaches at all.
cat > "$view_tmp/src/served.py" <<'FIXTURE'
def serve(request):
    handler = route(request)
    return handler(request)


def unrelated_helper(x):
    return x + 1
FIXTURE
cat > "$view_tmp/src/reg.py" <<'FIXTURE'
def setup():
    bind_port(7777)
    return True


def teardown():
    release()
    bind_port(7777)
FIXTURE
printf 'def nothing_claims_me():\n    return 0\n' > "$view_tmp/src/orphan.py"

cat > "$view_tmp/.ok-planner/design/stories/see-data.md" <<'FIXTURE'
---
story: see-data
---

# Serve a request

## Story

As a caller, I want my request served, so that I get an answer.

## Proof

Demo — the fixture.
FIXTURE

story_hash=$(python3 -c '
import hashlib, sys
print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest()[:12])' \
  "$view_tmp/.ok-planner/design/stories/see-data.md")
span_hash=$(python3 - "$view_tmp" <<'PY'
import hashlib, os, sys
root = sys.argv[1]
lines = open(os.path.join(root, "src/served.py")).read().splitlines()[0:3]
print(hashlib.sha256(
    "\n".join(" ".join(l.split()) for l in lines).encode()).hexdigest()[:12])
PY
)
file_hash=$(python3 - "$view_tmp" <<'PY'
import hashlib, os, sys
print(hashlib.sha256(
    open(os.path.join(sys.argv[1], "src/served.py"), "rb").read()
).hexdigest()[:12])
PY
)
cat > "$view_tmp/.ok-planner/audits/stories/see-data.md" <<FIXTURE
---
audit: see-data
artifact: story:see-data
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:${story_hash}
---

# Does the code serve a request?

## Claims

Honored.

- cite-span: src/served.py :: "def serve(request):" +3 sha256:${span_hash}
- cite-file: src/served.py @ sha256:${file_hash}
FIXTURE

cat > "$view_tmp/.ok-planner/design/decisions/loopback-ports.md" <<'FIXTURE'
---
decision: loopback-ports
---

# The port is bound on loopback only

## Choice

The service binds 7777 on loopback, never on a routable interface.

## Rationale

A local reader's page is not a network service; binding wider buys
nothing and exposes the corpus.

## Alternatives

- Bind all interfaces — reachable from another machine, at the cost of
  exposing the corpus to it.
FIXTURE

printf '# Ports collide when two projects browse at once\n' \
  > "$view_tmp/.ok-planner/issues/2026-07-28-000000-ports-collide.md"

decision_hash=$(python3 -c '
import hashlib, sys
print(hashlib.sha256(open(sys.argv[1],"rb").read()).hexdigest()[:12])' \
  "$view_tmp/.ok-planner/design/decisions/loopback-ports.md")

cat > "$view_tmp/.ok-planner/audits/decisions/loopback-ports.md" <<FIXTURE
---
audit: loopback-ports
artifact: decision:loopback-ports
determination: violated
issue: 2026-07-28-000000-ports-collide.md
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:${decision_hash}
---

# Is the port bound on loopback only?

## Claims

The bind is hard-coded, but it happens twice and only one site was
reviewed when the choice was taken.

- cite: src/reg.py :: "bind_port(7777)"
FIXTURE

view_bin="$family/scripts/corpus-view"
view_port=$(python3 -c '
import socket
s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()')
python3 "$view_bin" --root "$view_tmp" --port "$view_port" \
  > "$view_tmp/serve.log" 2>&1 &
view_pid=$!
python3 - "$view_port" <<'PY'
import socket, sys, time
for _ in range(100):
    try:
        socket.create_connection(("127.0.0.1", int(sys.argv[1])), 0.2).close()
        break
    except OSError:
        time.sleep(0.05)
PY

fetch() { python3 -c '
import sys, urllib.request
print(urllib.request.urlopen(sys.argv[1]).read().decode())' "$1"; }
base="http://127.0.0.1:${view_port}"

# The story, opened: the code its audit cites, excerpted in place.
detail=$(fetch "$base/api/artifact/story/see-data")
if printf '%s' "$detail" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/served.py"][0]
span = [c for c in g["lines"] if c["form"] == "cite-span"][0]
cited = [l["text"] for ex in span["excerpts"] for l in ex["lines"] if l["cited"]]
sys.exit(0 if (span["status"] == "current" and span["start"] == 1
               and span["regions"] == [[1, 3]]
               and "def serve(request):" in cited[0] and len(cited) == 3
               and len(g["file"]) == 1) else 1)'; then
  ok "trace-corpus-to-code: opening a story excerpts the code its audit cites"
else
  bad "trace-corpus-to-code: the story's cited code was not excerpted: $detail"
fi

# Every live story AND decision, each with the determination its audit
# recorded — the listing is the view's front door and both kinds have to
# be in it, or half the corpus is invisible from the start.
arts=$(fetch "$base/api/artifacts")
if printf '%s' "$arts" | python3 -c '
import json, sys
rows = {(a["kind"], a["slug"]): a for a in json.load(sys.stdin)["artifacts"]}
story = rows.get(("story", "see-data"))
decision = rows.get(("decision", "loopback-ports"))
sys.exit(0 if (story and decision
               and story["determination"] == "satisfied"
               and decision["determination"] == "violated"
               and story["has_audit"] and decision["has_audit"]) else 1)'; then
  ok "trace-corpus-to-code: the listing carries every live story and decision with its audit determination"
else
  bad "trace-corpus-to-code: the artifact listing lost a kind or a determination: $arts"
fi

# A multi-hit plain anchor is legal — the checker enforces uniqueness only
# for spans — so every occurrence it reaches is a claimed region, and the
# two directions have to say the same thing about them: the artifact page
# excerpts each occurrence, and the source view marks each. Claiming only
# the first would show code a citation demonstrably reaches as claimed by
# nothing, while the page said all of them were marked.
fetch "$base/api/artifact/decision/loopback-ports" > "$view_tmp/dec.json"
fetch "$base/api/source?path=src/reg.py" > "$view_tmp/reg.json"
if python3 - "$view_tmp/dec.json" "$view_tmp/reg.json" <<'PY'
import json, sys
d = json.load(open(sys.argv[1]))
s = json.load(open(sys.argv[2]))
g = [x for x in d["groups"] if x["target"] == "src/reg.py"][0]
c = [x for x in g["lines"] if x["form"] == "cite"][0]
marked = sorted(l["n"] for l in s["lines"] if l["marks"])
excerpted = sorted(ex["start"] for ex in c["excerpts"])
sys.exit(0 if (c["regions"] == [[2, 2], [8, 8]]
               and "all are marked" in c["detail"]
               and marked == [2, 8] and excerpted == [2, 8]
               and all(m["slug"] == "loopback-ports"
                       for l in s["lines"] for m in l["marks"])) else 1)
PY
then
  ok "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed — excerpted on the artifact and marked in the code"
else
  bad "trace-corpus-to-code: a multi-hit anchor claimed only some of the lines it reaches: $(cat "$view_tmp/dec.json")"
fi

# Following it into the file: the same story claiming that region, a region
# nothing claims beside it, and the whole-file pin kept as a file-level
# claim rather than smeared over every line.
src=$(fetch "$base/api/source?path=src/served.py")
if printf '%s' "$src" | python3 -c '
import json, sys
d = json.load(sys.stdin)
marked = [l for l in d["lines"] if l["marks"]]
unmarked = [l for l in d["lines"] if not l["marks"]]
claimants = {m["artifact"] for l in marked for m in l["marks"]}
pop = d["population"]
sys.exit(0 if (claimants == {"story:see-data"}
               and len(marked) == 3 and len(unmarked) > 0
               and len(pop) == 1 and pop[0]["form"] == "cite-file"
               and len(marked) < len(d["lines"])) else 1)'; then
  ok "trace-corpus-to-code: the file shows the claiming story, an unclaimed region, and the whole-file claim as file-level"
else
  bad "trace-corpus-to-code: the file view conflated or lost a claim: $src"
fi

# The sources nothing claims, reachable as their own view.
srcs=$(fetch "$base/api/sources")
if printf '%s' "$srcs" | python3 -c '
import json, sys
rows = json.load(sys.stdin)["sources"]
by = {r["path"]: r for r in rows}
orphan = by.get("src/orphan.py")
sys.exit(0 if (orphan and not orphan["line_claims"]
               and not orphan["file_claims"]
               and by["src/served.py"]["line_claims"] == 1) else 1)'; then
  ok "trace-corpus-to-code: a source nothing claims is listed as its own row, not left implicit"
else
  bad "trace-corpus-to-code: the uncited source is invisible: $srcs"
fi

# With a committed graph present, the graph is the population — the same
# map the audits cite, so coverage is reported over what the corpus can
# actually reach rather than over whatever happens to be on disk.
(cd "$view_tmp" && python3 "$family/scripts/source-graph" build) >/dev/null 2>&1
# The same long-lived server process, asked again with no hint that
# anything moved: every request is a fresh read of the tree, so a view
# left running cannot go on serving the answer it gave before the graph
# existed.
graphed=$(fetch "$base/api/meta")
if printf '%s' "$graphed" | python3 -c '
import json, sys
sys.exit(0 if json.load(sys.stdin)["population_source"] == "graph" else 1)'; then
  ok "trace-corpus-to-code: coverage is reported over the committed graph once one exists"
else
  bad "trace-corpus-to-code: the committed graph was not used as the population: $graphed"
fi

# A deliberately broken citation: the view's verdict has to be the
# checker's verdict, because the view calls the checker rather than
# reimplementing it.
python3 - "$view_tmp" <<'PY'
import os, sys
p = os.path.join(sys.argv[1], "src/served.py")
text = open(p).read().replace("handler = route(request)",
                              "handler = route(request, strict=True)")
open(p, "w").write(text)
PY
broken=$(fetch "$base/api/artifact/story/see-data")
checker_says=$(cd "$view_tmp" && python3 "$family/scripts/audit-check" . 2>&1 | \
  grep -c 'audit-stale-citation' || true)
if printf '%s' "$broken" | python3 -c '
import json, sys
d = json.load(sys.stdin)
g = [x for x in d["groups"] if x["target"] == "src/served.py"][0]
span = [c for c in g["lines"] if c["form"] == "cite-span"][0]
sys.exit(0 if span["status"] == "stale" else 1)' && [ "$checker_says" -ge 1 ]; then
  ok "trace-corpus-to-code: a broken citation reads stale in the view exactly as the project's own checker reports it"
else
  bad "trace-corpus-to-code: view and checker disagreed on a broken citation (checker findings: $checker_says): $broken"
fi

kill "$view_pid" 2>/dev/null || true
wait "$view_pid" 2>/dev/null || true
rm -rf "$view_tmp"

# --- corpus-audit: the pure in-context reporter ------------------------------
section corpus-audit
# The seeded-corpus run is agentic (four subagent passes reading a
# planted compliance violation, an uncovered claim, and a cross-artifact
# contradiction back to the caller, tree — intake included — unchanged);
# that demo is prompt-realized in skills/audit/SKILL.md, step 7's report
# contract. What is checkable — and what a regression would silently
# drop — is that the verb a project actually runs still promises exactly
# that: four real passes, every finding classified, nothing written.
audit_copy_check() {
  local copy=$1 label=$2
  if [ ! -f "$copy" ]; then
    bad "corpus-audit: $label missing at $copy"
    return
  fi
  if grep -qF "Pass 1 — compliance" "$copy" \
     && grep -qF "Pass 2 — coverage" "$copy" \
     && grep -qF "Pass 3 — cross-artifact consistency" "$copy" \
     && grep -qF "Pass 4 — surface inventory" "$copy"; then
    ok "corpus-audit: $label — the check behind the findings is real (all four passes present)"
  else
    bad "corpus-audit: $label — the check behind the findings has lost a pass"
  fi
  if grep -qF "advisory mechanical/judgment class" "$copy" \
     && grep -qF 'classifies every finding `mechanical` or `judgment`' "$copy"; then
    ok "corpus-audit: $label — the report contract classifies every finding mechanical or judgment"
  else
    bad "corpus-audit: $label — the report contract lost the mechanical/judgment classification"
  fi
  if grep -qF "returns everything in-context, and writes nothing" "$copy" \
     && grep -qF "Create nothing." "$copy" \
     && grep -qF "Does not touch the issue intake — no filing, no editing, no closing." "$copy" \
     && grep -qF "Does not execute proofs" "$copy"; then
    ok "corpus-audit: $label — the read-only stance stands verbatim: in-context report, no intake writes, no proof execution"
  else
    bad "corpus-audit: $label — the read-only stance has drifted"
  fi
}
audit_copy_check "$family/skills/audit/SKILL.md" "the family source"
audit_copy_check "$suite_repo/.claude/skills/ok-planner-audit/SKILL.md" "the vendored verb this project runs"

# One conjunct beyond presence: each pass dispatches an assembled prompt,
# and a dispatch is only real if every block it transcludes exists. Every
# {{TOKEN}} the verb uses is resolved here against the shared directory —
# a pass pointing at a block nobody defines is a stub with a subagent
# around it, and this is what catches it.
token_report=$(python3 - "$family/skills/audit/SKILL.md" "$family/skills/_shared" <<'PY'
import glob, os, re, sys
skill, shared = sys.argv[1], sys.argv[2]
defined = {}
for path in sorted(glob.glob(os.path.join(shared, "*.md"))):
    for m in re.finditer(r"(?m)^###\s+\{\{([A-Z][A-Z0-9-]*)\}\}\s*$", open(path).read()):
        defined.setdefault(m.group(1), []).append(os.path.basename(path))
used = set()
for line in open(skill).read().split("\n"):
    if re.match(r"^###\s+\{\{", line):
        continue
    used.update(re.findall(r"\{\{([A-Z][A-Z0-9-]*)\}\}", line))
bad = ["%s -> %d headings" % (t, len(defined.get(t, []))) for t in sorted(used)
       if len(defined.get(t, [])) != 1]
print(("BAD " + ", ".join(bad)) if bad else
      ("EMPTY" if not used else "OK %d tokens" % len(used)))
PY
)
case "$token_report" in
  OK*)  ok "corpus-audit: every block the four passes transclude resolves to exactly one canonical heading (${token_report#OK })" ;;
  BAD*) bad "corpus-audit: a dispatched pass transcludes a block that resolves to no single canonical heading — ${token_report#BAD }" ;;
  *)    bad "corpus-audit: the verb transcludes nothing — its passes no longer assemble canonical prompts" ;;
esac

exit $fail
