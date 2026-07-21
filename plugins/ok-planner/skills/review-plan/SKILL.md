---
name: review-plan
description: "ONLY activated by explicit /review-plan slash command. Never auto-triggered by conversation content."
---

# Review Plan Implementation

Help the user select a plan to review against, then dispatch a reviewer.

## Steps

1. List spec and plan files in reverse chronological order:
   - Primary location: `.ok-planner/specs/` and `.ok-planner/plans/` (current ok-planner artifact layout)
   - Also include `.ok-planner/history/specs/` and `.ok-planner/history/plans/` so completed work can be re-reviewed
   - Fallback: older projects may still have artifacts under `docs/specs/` or `docs/plans/` — include those if present
   - Present as a numbered multiple-choice list, newest first
   - Include the filename and first line (title) of each

2. Ask the user which plan/spec to review against.

3. Once selected, read the spec/plan to understand what was intended.

4. Dispatch a reviewer subagent:

```
Agent (general-purpose):
  ## Review Plan Implementation

  ### Spec/Plan
  [Path to the selected spec/plan. Read it in full.]

  ### Your Job
  Read the spec/plan, then read every file it references — including files inside git submodules. For each requirement:
  - Is it implemented?
  - Is the implementation correct?
  - Are there gaps, edge cases, or deviations?

  Also check for:
  - Code that was added but isn't in the spec (scope creep)
  - **Undershoot — a promised user-outcome story not actually
    delivered.** If the spec opens with user-outcome stories, every one
    must be really delivered: its user-outcome observable, not merely
    its mechanism present. Flag any handler/route/class registered or
    declared but doing nothing, error class or event declared but never
    emitted, config flag or field accepted but ignored, stub/no-op
    standing in for a promised outcome, or `TODO` / "out of scope" /
    "deferred" / "later pass" marker on a story's path. A story whose
    outcome is not really delivered is a finding even when every unit
    test is green — that is exactly how a spec'd feature ships unbuilt.
    (Scope creep above is the ceiling; this is the floor.)
  - Tests that don't actually verify the spec requirements. A test
    proves a behavior only if it drives the real system (the real
    handler/process/store, an end-to-end path) and asserts an
    observable outcome (a persisted row's state, a call made over the
    wire, a status returned, a terminal reached) — NOT the shape of a
    struct/proto/config, NOT a pure-helper call standing in for a
    runtime behavior, NOT an in-memory fake substituted for the system
    under test. For each behavior the spec requires, confirm such a
    test exists and that it would fail if the implementation were
    removed: if reverting the fix leaves the test green, the test is
    theater and the behavior is effectively unverified — report it as
    Broken. A test whose name implies an end-to-end outcome but whose
    body only constructs a value and asserts its fields is the
    canonical offender.
  - Load-bearing properties the spec/plan relied on that the implementation silently traded away. Name the properties the spec depends on — durability, completeness, atomicity, ordering, idempotency, no-data-loss, "this record is canonical," "this path must not block" — and verify each survives in the code, not just on the happy path. A property the spec relied on but the implementation no longer guarantees (e.g. an audit write the spec called authoritative, made async-and-droppable to save latency) is a finding even when nothing looks broken — review the property, not just the line-by-line conformance.

  ### Pre-existing issues
  If you find bugs, stale references, or inconsistencies in any file you read — even if they predate the current work — report them. "It was already broken" is not a reason to skip it. If an issue in one file points to problems in files outside the spec's scope, follow the trail and report those too.

  ### Source of truth
  The spec/plan is the source of truth for this review. Form your
  judgments against the spec/plan, not against the design docs
  under `.ok-planner/design/` — the design docs as oracle are the
  concern of `review-holistic` (read-only oracle consumer) and
  the read-only consultants (`brainstorm`, `refine-design`,
  `merge`).

  If the spec has a `## Design changes` section, open the
  affected files under `.ok-planner/design/` to verify each
  listed mutation landed correctly (concept edits, tension file
  moves to `_resolved/`, new concept or tension files). That's
  not consulting the design docs as oracle — it's verifying
  spec-directed work. If your review raises a question the
  spec/plan doesn't address, raise it as an issue against the
  spec/plan, not against the design docs.

  ### Completion report (if present)
  If the plan was executed by `ok-planner:execute-plan`, a
  completion report may exist at
  `.ok-planner/plans/<plan>-completion-report.md` (or its archived
  equivalent under `history/plans/`). If present, read it for
  context on the four-section closing walk — proofs working,
  decisions kept, decisions diverged, coverage divergences. A
  divergence by itself is
  not an issue — form your findings from the code. A divergence
  that produces working, safe code is fine; one that introduces a
  bug, regression, or invariant violation is an issue. So is one
  that silently trades away a property the spec/plan relied on
  (durability, completeness, atomicity, ordering, no-data-loss) —
  even if the code "works"; flag it and name the property that
  was spent.

  ### Output Format

  For each spec requirement, report:
  - **Implemented correctly** — the requirement is met, whether
    the code follows the plan literally or arrived at the same
    business outcome by a different shape.
  - **Missing** — the requirement was not implemented.
  - **Broken** — the requirement was attempted but the
    implementation has a bug, regression, or invariant violation.

  Deviation from the plan's literal wording is NOT a finding by
  itself — if the spec's intent is met, it's correct. Only flag
  deviations that produce broken code.

  Then list any additional issues found with file:line references.
  Do not categorize by severity. Every issue needs fixing.
```

5. If the reviewer found issues, invoke `ok-planner:review-cleanup` with the reviewer's full output. Do NOT process, filter, or triage the output yourself.
