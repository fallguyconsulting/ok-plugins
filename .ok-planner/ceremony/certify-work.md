# ok-planner — certification ceremony contribution

What the suite's certification gate does about this family's estate.
The ceremony owns the spine — scope, the review-fix loop, the
presentation, the close-out; this file owns everything ok-planner
contributes to it. Materialized into consumer projects at
`.ok-planner/ceremony/certify-work.md`; the ceremony reads it there
when `.ok-planner/` exists.

## Requires

`.ok-planner/` at the project root. This family owns the sprint, the
completion report, and the issue intake — the artifacts the gate aligns
against, writes into, and routes forks to.

## Layout

`mkdir -p .ok-planner/issues .ok-planner/history/issues` so the intake
exists. Estate convergence is the front door's administration (`/ok`),
not this gate's.

## Scope

**The touched set** this family adds to the ceremony's changed-file
scope: **touched artifacts** — design files changed directly, plus
every artifact a sprint-in-scope's deltas and work items name. Code
annotations play no part in this derivation; navigation is their only
job.

If a sprint is named as an argument — the invocation the sprint's own
closing step makes — that is the alignment target. A bare invocation
never adopts a sprint from `.ok-planner/sprints/`, however many are in
flight, and raises no advisory about them.

## Producers

Three, each at change scope.

### Sprint alignment (only with a sprint in scope)

The corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from
`.claude/skills/_shared/certification-core.md` with `[SPRINT PATH]`
filled: deltas applied verbatim (from the sprint's sidecar where a
heading points there), every work item's
outcome realized (an undershoot is a **blocking** finding), and the
changed corpus coherent with the live corpus — mid-cycle corpus edits
by the fixer or architect are checked here too.

### The mechanical floor (inline, no subagent)

**Annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'`
over the changed files, every (kind, slug) pair resolving to a live
artifact.

Consistency of the changed corpus rides the alignment producer above;
delta compliance was paid at planning sign-off; whether the corpus's
claims still hold belongs to the periodic `/audit` run.

### Code review

The ceremony dispatches it; this family adds one line to its source of
truth: the sprint's corpus deltas are directed work, so the reviewer
opens the affected files under `.ok-planner/design/` and verifies each
landed correctly.

## Routing

Findings from every producer — this family's and every other family's —
drain through the ceremony's review-fix loop. The issue intake at
`.ok-planner/issues/` is this family's contribution to routing, and it
is reached by exactly two paths from a certification run: the
architect's confirmed forks, and the remainders escalated at the cycle
cap. Both write per `{{ISSUE-FILE-FORMAT}}`.

## Verify

If the architect promoted any or the cap escalation filed any, invoke
`verify-issues`; it makes everything filed this run ruling-ready (and
skips the already-verified intake). Zero filings → skip, silently.

## Present

The composed presentation is written into the sprint's completion
report — the file beside the sprint (same filename with `-completion`)
that the executor kept during the work; create it if the executor did
not — finishing that record, and then walked with the owner. This
family's per-producer "Findings fixed" lines: alignment (the
corpus-change judge) and the mechanical floor.

## Close-out

With a sprint in scope and everything certified clean, the standing
offer this family contributes: **archive the sprint** — move it to
`.ok-planner/history/sprints/`, together with its completion report,
its delta sidecar folder where it has one, and
every issue file under `.ok-planner/issues/` whose frontmatter `sprint:`
names it (promoted receipts, moving to `.ok-planner/history/issues/`) —
and **commit the work**. Both are owner acts, performed only on the
owner's word. The sprint stays at its `sprints/` path until then,
because the owner moves it and the run does not. Where the file sits
is no term of the completion contract's goal rule. An uncertified
sprint gets no offer at all. On the yes, after the archive
commit lands, stamp the archived sprint with the closing commit —
`closed: <sha of the archive commit>` in YAML frontmatter, one small
follow-on commit — the baseline the planning ceremony's out-of-band
reconciliation reads.

## Boundaries

- Does not audit. It writes nothing under `.ok-planner/audits/`, reads
  no determination, and forms no finding about whether an artifact is
  still supported — that is `/audit`, on the owner's cadence.
- Does not widen scope mid-run. A finding outside the change's
  footprint that isn't caused or depended on by the change is not this
  gate's finding; if it matters, a human files it to the intake.

<!-- Materialized by ok-planner v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
