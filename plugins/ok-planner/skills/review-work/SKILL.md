---
name: review-work
description: "ONLY activated by explicit /review-work slash command. Never auto-triggered by conversation content."
---

# Review Uncommitted Work

Review all uncommitted changes (staged, unstaged, and untracked files). This is the "am I done?" check before committing.

For other review types, see: `/review-design` (whole-corpus design-doc audit), `/review-plan`, `/review-commits`, `/review-files`, `/review-feature`.

## Two independent cycles

`review-work` runs **two independent review/fix cycles**:

1. **Code review cycle** (always runs). The reviewer prompt below evaluates correctness, safety, state integrity, test coverage, and spec/plan conformance. Findings pass through `ok-planner:review-cleanup` and loop to clean.
2. **Design-doc compliance cycle** (runs only if `.ok-planner/design/concepts/` exists). A separate reviewer prompt audits the design docs against the concept self-containment rule. Findings pass through their own `ok-planner:review-cleanup` invocation and loop to clean.

The cycles are independent: findings do NOT mix, each has its own `review-cleanup` pass, each loops to clean independently. Run the code-review cycle first; once it reports clean, run the design-doc compliance cycle. Only report `review-work` clean to the orchestrator when BOTH cycles have reported clean. If either cycle hits the `review-cleanup` cap, surface its remaining issues grouped by cycle.

If `.ok-planner/design/concepts/` does not exist, skip the second cycle silently — the design docs are opt-in.

## Cycle 1 — Code review

## Reviewer Prompt

Dispatch a reviewer subagent:

```
Agent (general-purpose):
  ## Code Review

  ### Scope
  [Describe what to review based on the resolved scope — which files, diffs, or areas]

  ### How to find the changes

  **Working-tree first.** Run `git status` and `git diff` before
  forming any findings. Working-tree state is your subject — code
  modified or deleted in the working tree is in scope even if HEAD
  looks different. Don't form findings about code that exists in HEAD
  but has been deleted in the working tree. Don't omit code added in
  the working tree just because it's uncommitted.

  [Include the appropriate commands based on scope:]
  - Uncommitted: `git diff`, `git diff --staged`, `git status` for untracked files
  - Commit range: `git diff BASE..HEAD`
  - Plan: read the spec/plan, then read all files it touches
  - File/directory: read the files directly
  - Feature area: search for relevant files, read them
  - Submodules: if `git status` shows modified submodules, run `git diff --submodule=diff` to include submodule changes in the diff, or `git -C <submodule-path> diff` for each modified submodule. Submodule changes are part of the review scope — do not skip them.

  Read modified and new source files in their entirety for context.

  ### Review Focus
  - Correctness: bugs, edge cases, off-by-one errors
  - Safety: data loss, security issues, resource leaks, irreversible operations
  - State integrity: can we get stuck in a state? Double-execute? Skip steps?
  - Load-bearing properties upheld: name the properties the spec/plan depend on — durability, completeness, atomicity, ordering, idempotency, no-data-loss, "this record is canonical/authoritative," and the like — and verify the code actually guarantees each one. The dangerous failure is code that works on the happy path but silently trades such a property away for a local optimization (e.g. an audit write made asynchronous-and-droppable to protect request latency, quietly downgrading a record the spec called authoritative). For each property ask: does the implementation still guarantee it, or only under light load / the happy path? If the spec relied on a property the code no longer guarantees, that is an issue even when nothing appears "broken" — review the property, not just the line-by-line diff.
  - Test coverage: do tests verify real behavior? Any gaps?
  - Completeness against the spec's user-outcome stories: if the
    spec opens with user-outcome stories, every one must be actually
    delivered — its real user-outcome observable, not merely its
    mechanism present. Flag any undershoot: a handler / route / class
    registered or declared but doing nothing, an error class or event
    declared but never emitted, a config flag or field accepted but
    ignored, a stub / no-op standing in for a promised outcome, or a
    `TODO` / "out of scope" / "deferred" / "later pass" marker on a
    story's path. A promised story whose outcome is not really
    delivered is a blocking issue even when every unit test is green —
    that is the exact way a spec'd feature ships unbuilt.
  - Dead code, unused imports, stale comments
  - Anything that deviates from requirements
  - Pre-existing issues: if you find bugs, stale references, or inconsistencies in any file you read — even if they predate the current changes — report them. If an issue points to problems in files outside the initial scope, follow the trail and report those too.

  ### Source of truth
  The spec (linked from the plan's `**Spec:**` header, if any) and
  the plan itself are the source of truth for what the work was
  meant to accomplish. Form your judgments against the spec/plan,
  not against the design docs under `.ok-planner/design/` — the
  design docs as oracle are the concern of `review-holistic`
  (which uses them as the source of truth for whole-codebase
  convergence) and the read-only consultants (`brainstorm`,
  `refine-design`, `merge`).

  If the spec has a `## Design changes` section, open the affected
  files under `.ok-planner/design/` to verify each listed mutation
  landed correctly (concept file edits, tension file moves to
  `_resolved/`, new concept or tension files). That's not
  consulting the design docs as oracle — it's verifying that
  spec-directed work was carried out. If the spec doesn't address
  a question your review raises, raise it as an issue against the
  spec/plan, not against the design docs.

  ### Completion report
  If the work was produced by `ok-planner:execute-plan`, a completion
  report may exist alongside the plan (e.g.,
  `.ok-planner/plans/<plan>-completion-report.md`). If present, read
  it. The completion report has three sections — proofs walked,
  technical decisions kept, technical decisions diverged — covering
  100% of the spec. Use it as context for understanding why the code
  looks the way it does, not as a bypass of review. A divergence
  recorded there is not by itself an issue; form your findings from
  the code. A divergence that produces working, safe code is fine. A
  divergence that introduces a bug, regression, or invariant
  violation is an issue — flag it with file:line as you would any
  other. So is a divergence that silently trades away a property the
  spec or plan relied on (durability, completeness, atomicity,
  ordering, no-data-loss) — even when the code "works": flag it and
  name the property that was spent. The "necessitated" flavor of
  divergence (work the spec did not name but the necessity rule
  required) is the most common — don't dismiss it just because the
  spec never spelled out the property at stake.

  ### Output Format

  List every issue found with:
  - File:line reference
  - What's wrong
  - Why it matters
  - How to fix

  Do not categorize by severity. Every issue needs fixing.
  Report strengths briefly. Focus on problems.
```

## After the code-review cycle

If the reviewer found issues, invoke `ok-planner:review-cleanup` with the reviewer's full output. Do NOT process, filter, or triage the output yourself. Pass it through verbatim and let the cleanup skill drive the fix cycle.

Once `review-cleanup` reports clean (or hits its cap), proceed to the design-doc compliance cycle below.

## Cycle 2 — Design-doc compliance (focused)

This cycle is independent of the code review above. It audits the design docs under `.ok-planner/design/` for compliance with the canonical artifact rules (concept / story / decision self-containment, tension surface, current-state-only — canonically stated in `skills/_shared/artifact-definitions.md`). Drift in those files isn't a code defect, so the code-review cycle wouldn't surface it; it needs its own reviewer and its own fix loop.

**Cycle 2 is focused, not whole-corpus.** The assumption: if the design docs are maintained, drift only enters at change points. The cycle audits artifacts that the current uncommitted change plausibly touched — directly modified design files, plus artifacts whose slug is referenced from changed code or from an in-flight spec/plan. The whole-corpus sweep is a separate skill (`ok-planner:review-design`); invoke it explicitly when accumulated drift needs checking (after a `/discover-design` re-run, after a long quiet period, on demand, or when the focused cycle is suspect).

If `.ok-planner/design/concepts/` does not exist, skip the entire cycle silently.

### Compute the audit set

Run these steps to compute the focused audit set:

1. **Directly modified design files.** Run `git status --porcelain` and `git diff --name-only` (also `git diff --staged --name-only`). Collect every changed file matching `.ok-planner/design/{concepts,stories,decisions,tensions}/*.md` (live artifacts; skip `_retired/`, `_resolved/`, `_rejected/` subpaths).

2. **Slugs referenced in changed code.** From the same git change list, collect every non-design file. For each, grep for `@concept:\s*<slug>`, `@story:\s*<slug>`, `@decision:\s*<slug>` annotations. Collect the slugs. For each slug, the matching design file is `.ok-planner/design/{concepts,stories,decisions}/<slug>.md` (whichever kind matches the annotation prefix).

3. **Slugs referenced in in-flight specs/plans.** From the git change list, collect every changed file matching `.ok-planner/specs/*.md` or `.ok-planner/plans/*.md`. Read each. Extract every artifact slug mentioned by any of these patterns:
   - `STORY-<slug>` (spec manifest entries)
   - `TD-<slug>` (spec manifest entries)
   - `concept:<slug>`, `story:<slug>`, `decision:<slug>`, `tension:<slug>` (citation grammar references)
   - Bullet lines under `## Design changes` referencing `<kind>/<slug>.md` paths
   For each slug, the matching design file is `.ok-planner/design/<kind>s/<slug>.md`.

4. **Union the three sets.** Deduplicate. Filter to files that actually exist (a slug citation pointing at a not-yet-created artifact is fine — it'll exist after the spec runs; don't audit a missing file).

5. **If the audit set is empty, skip cycle 2 silently.** No spec/plan in flight, no design files modified, no annotated code changes → nothing to audit at change points. The whole-corpus path remains available via `/review-design`.

### Dispatch the reviewer

Read `skills/_shared/design-doc-compliance-reviewer.md` and dispatch the `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` block as a subagent. Substitute `[AUDIT SCOPE]` with:

```
Audit the following artifact files (focused scope from the current uncommitted change). Files were selected because they were directly modified, are referenced by an `@concept:` / `@story:` / `@decision:` annotation in a changed code file, or are named by slug in an in-flight spec or plan:

- <file 1>
- <file 2>
- ...
```

The reviewer prompt itself is invariant — only the scope changes between focused (cycle 2) and full (`review-design`).

### After the compliance reviewer

If the reviewer found issues, invoke `ok-planner:review-cleanup` with the reviewer's full output. Do NOT mix with code-review findings — this is a separate invocation with its own loop. Pass the compliance reviewer's output verbatim.

Once the compliance `review-cleanup` reports clean (or hits its cap), the cycle is done.

## Final report

When both cycles have reported clean, report `review-work` clean. If either cycle hit `review-cleanup`'s cap, surface remaining issues grouped by cycle (code-review remaining vs. compliance remaining); the user decides what to do.
