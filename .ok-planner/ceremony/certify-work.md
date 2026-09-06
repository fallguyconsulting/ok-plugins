# ok-planner — certification ceremony contribution

What the suite's certification gate does about this family's estate. The ceremony owns the spine — scope, the review-fix loop, the presentation, the close-out; this file owns everything ok-planner contributes to it. Materialized into consumer projects at `.ok-planner/ceremony/certify-work.md`; the ceremony reads it there when `.ok-planner/` exists.

## Requires

`.ok-planner/` at the project root. This family owns the sprint, the completion report, and the issue intake.

## Layout

`mkdir -p .ok-planner/issues .ok-planner/history/issues`. Estate convergence is the front door's administration (`/ok`), not this gate's.

## Scope

**The touched set** this family adds to the ceremony's changed-file scope: **touched artifacts** — design files changed directly, plus every artifact a sprint-in-scope's deltas and work items name. Code annotations play no part in this derivation.

**The release documents** this family removes from the scope: every file at a target a declared document type under `.ok-planner/surface/documents/` names (a folder target covers the folder), and everything under `.ok-planner/documentation/`. `/document` regenerates them whole at the next release, per `decision:placed-documents-are-records`. No producer reads one, no fixer edits one, and a sentence in one that describes what the change removed is not a finding. The gate names them in `[REVIEW SCOPE]` under its out-of-scope line, and every prompt in `.claude/skills/_shared/certification-core.md` that touches the tree carries `{{RELEASE-DOCUMENTS-RULE}}` from the same file.

A sprint named as an argument is the alignment target. A bare invocation adopts no sprint from `.ok-planner/sprints/`, however many are in flight, and raises no advisory about them.

## Producers

Three, each at change scope.

### Sprint alignment (only with a sprint in scope)

The corpus-change judge. The `alignment` prompt is `{{SPRINT-ALIGNMENT-PROMPT}}` from `.claude/skills/_shared/certification-core.md` with `[SPRINT PATH]` filled; the gate files it as a task under `ok-opus`: deltas applied verbatim (from the sprint's sidecar where a heading points there), every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus. Mid-round corpus edits by the fixer or architect are checked here too.

### The mechanical floor (exec tasks)

**Annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact, per `{{ANNOTATION-INTEGRITY-RULE}}` in `.claude/skills/_shared/artifact-definitions.md`.

Check nothing else here. Consistency of the changed corpus rides the alignment producer; delta compliance was paid at planning sign-off; whether the corpus's claims still hold belongs to `/audit`.

### Code review

The ceremony files it; this family adds one check: the reviewer opens every file a sprint's deltas affect under `.ok-planner/design/` and verifies each delta landed correctly. Every delta is due here. The gate reviews the finished work; the build runs no review of its own.

## Routing

Findings from every producer — this family's and every other family's — drain through the ceremony's review-fix loop. The issue intake at `.ok-planner/issues/` is this family's contribution to routing, and a certification run reaches it by exactly two paths: the architect's confirmed forks, and the remainders escalated at the cap. Both write per `{{ISSUE-FILE-FORMAT}}`. A defect the review finds never reaches it: the loop fixes every defect, the ones the change did not introduce included.

## Verify

If the architect promoted any fork or the cap escalation filed any remainder, invoke `verify-issues`; it makes everything filed this run ruling-ready and skips the already-verified intake. Zero filings → skip, silently.

## Present

Write the composed presentation into the sprint's completion report — the file beside the sprint, same filename with `-completion`, that the executing session rendered from the run during the work; create it if the executor did not. Then walk it with the owner. This family's per-producer "Findings fixed" lines: alignment (the corpus-change judge) and the mechanical floor.

## Close-out

With a sprint in scope and everything certified clean, the standing offer this family contributes: **archive the sprint** — move it to `.ok-planner/history/sprints/`, together with its completion report, its run file (`<sprint-name>-run.jsonl`), its delta sidecar folder where it has one, and every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names it (promoted receipts, moving to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word. The sprint stays at its `sprints/` path until then; where the file sits is no term of the completion contract's goal rule. An uncertified sprint gets no offer. On the yes, after the archive commit lands, stamp the archived sprint with `closed: <sha of the archive commit>` in YAML frontmatter, one small follow-on commit.

## Boundaries

- Does not audit. It writes nothing under `.ok-planner/audits/` or `.ok-planner/experiments/`, reads no determination, runs or repairs no experiment, and forms no finding about whether an artifact is still supported.
- Does not widen its reading mid-run. The reviewers read the change and what it reaches, never the whole tree; every defect they meet there is fixed here, the ones the change did not introduce included, and none is filed to the intake.

<!-- Materialized by ok-planner v20.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
