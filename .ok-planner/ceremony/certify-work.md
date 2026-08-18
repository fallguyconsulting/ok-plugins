# ok-planner — certification ceremony contribution

What the suite's certification gate does about this family's estate. The ceremony owns the spine — scope, the review-fix loop, the presentation, the close-out; this file owns everything ok-planner contributes to it. Materialized into consumer projects at `.ok-planner/ceremony/certify-work.md`; the ceremony reads it there when `.ok-planner/` exists.

## Requires

`.ok-planner/` at the project root. This family owns the sprint, the completion report, and the issue intake.

## Layout

`mkdir -p .ok-planner/issues .ok-planner/history/issues`. Estate convergence is the front door's administration (`/ok`), not this gate's.

## Scope

**The touched set** this family adds to the ceremony's changed-file scope: **touched artifacts** — design files changed directly, plus every artifact a sprint-in-scope's deltas and work items name. Code annotations play no part in this derivation.

A sprint named as an argument is the alignment target. A bare invocation adopts no sprint from `.ok-planner/sprints/`, however many are in flight, and raises no advisory about them.

## Producers

Three, each at change scope.

### Sprint alignment (only with a sprint in scope)

The corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from `.claude/skills/_shared/certification-core.md` with `[SPRINT PATH]` filled: deltas applied verbatim (from the sprint's sidecar where a heading points there), every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus. Mid-round corpus edits by the fixer or architect are checked here too.

### The mechanical floor (inline, no subagent)

**Annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact.

Check nothing else here. Consistency of the changed corpus rides the alignment producer; delta compliance was paid at planning sign-off; whether the corpus's claims still hold belongs to `/audit`.

### Code review

The ceremony dispatches it; this family adds one check: the reviewer opens every file a sprint's deltas affect under `.ok-planner/design/` and verifies each delta landed correctly. Every delta is due here. The gate reviews the finished work.

## Standing producers

What the sprint's standing reviewer runs over each landed stage during the build, beside the certification code-review brief, per `{{STANDING-REVIEWER-PROMPT}}` in `.claude/skills/_shared/certification-core.md`. Read-only; hits are ledger findings the builder fixes in its own context. The terminal gate re-runs its own producers cold and reads none of this.

**Annotation integrity** — over the stage's paths, `rg -n '@(concept|story|decision):\s*\S+'`; every (kind, slug) pair resolves to a live artifact under `.ok-planner/design/`, and a slug the sprint's deltas introduce resolves once the delta has been applied. A dangling or misspelt slug is a finding.

## Routing

Findings from every producer — this family's and every other family's — drain through the ceremony's review-fix loop. The issue intake at `.ok-planner/issues/` is this family's contribution to routing, and a certification run reaches it by exactly two paths: the architect's confirmed forks, and the remainders escalated at the cap. Both write per `{{ISSUE-FILE-FORMAT}}`.

## Verify

If the architect promoted any or the cap escalation filed any, invoke `verify-issues`; it makes everything filed this run ruling-ready and skips the already-verified intake. Zero filings → skip, silently.

## Present

Write the composed presentation into the sprint's completion report — the file beside the sprint, same filename with `-completion`, that the executor kept during the work; create it if the executor did not. Then walk it with the owner. This family's per-producer "Findings fixed" lines: alignment (the corpus-change judge) and the mechanical floor.

## Close-out

With a sprint in scope and everything certified clean, the standing offer this family contributes: **archive the sprint** — move it to `.ok-planner/history/sprints/`, together with its completion report, its delta sidecar folder where it has one, and every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names it (promoted receipts, moving to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word. The sprint stays at its `sprints/` path until then; where the file sits is no term of the completion contract's goal rule. An uncertified sprint gets no offer. On the yes, after the archive commit lands, stamp the archived sprint with `closed: <sha of the archive commit>` in YAML frontmatter, one small follow-on commit.

## Boundaries

- Does not audit. It writes nothing under `.ok-planner/audits/` or `.ok-planner/experiments/`, reads no determination, runs or repairs no experiment, and forms no finding about whether an artifact is still supported.
- Does not widen scope mid-run. A finding outside the change's footprint that the change neither caused nor depends on is not this gate's finding; a human files it to the intake where it matters.

<!-- Materialized by ok-planner v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
