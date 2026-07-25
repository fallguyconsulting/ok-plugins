# Design-doc compliance reviewer prompt

Canonical prompt body for the design-doc compliance reviewer subagent. Used by `audit` (whole-corpus scope) and `plan-sprint` (draft scope — the corpus deltas of a sprint under sign-off review). Both invocations dispatch the same reviewer; only the audit scope differs.

## How consumers use this file

Two consumers, two scopes, one prompt:

- `audit` substitutes the whole-corpus glob result for `[AUDIT SCOPE]`.
- `plan-sprint` computes a **draft scope** — the final-form artifact bodies drafted as corpus deltas in the sprint under review, plus any live artifact a delta amends — and substitutes that set.

The prompt body below is shared verbatim between the two invocations. Drift between draft-time and corpus-time review cannot happen.

**Two-file transclusion.** The prompt body uses both `[AUDIT SCOPE]` (per-call value, filled by the consumer) AND `{{SELF-CONTAINMENT-RULE}}` / `{{CURRENT-STATE-ONLY-RULE}}` / `{{STORY-DEFINITION}}` / `{{DECISION-DEFINITION}}` (static blocks defined in `skills/_shared/artifact-definitions.md`). When assembling the dispatched prompt, substitute each `{{...}}` placeholder with the body of the matching `###` block in `artifact-definitions.md` — same convention as every other transcluded prompt in the skill set.

## How to substitute `[AUDIT SCOPE]`

The `[AUDIT SCOPE]` placeholder is one or more lines listing the artifact files (or in-sprint delta blocks) the reviewer must audit, with a one-line note above explaining the mode. Examples:

**Whole-corpus mode (`audit`):**

```
Audit every live artifact file in the project's design corpus:

- All `.md` files directly under `.ok-planner/design/concepts/` (skip `_retired/`)
- All `.md` files directly under `.ok-planner/design/stories/`
- All `.md` files directly under `.ok-planner/design/decisions/`
- `.ok-planner/design/concepts.md`, `stories.md`, and `decisions.md` (the auto-generated TOCs)
```

**Draft mode (`plan-sprint` sign-off review):**

```
Audit the corpus deltas in the sprint at <path> (each delta is a final-form artifact body), plus these live artifacts the deltas amend:

- .ok-planner/design/concepts/claim-handle.md
- .ok-planner/design/stories/claim-co-holder.md
```

## The prompt

The token block below is the full dispatched prompt. Replace `[AUDIT SCOPE]` per the above; everything else is invariant.

### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}

```
Agent (general-purpose, model: sonnet-5):
  ## Design-doc compliance review

  ### Your job

  Audit design-doc content for compliance with the canonical
  artifact rules: self-containment, current-state-only, story
  form, and decision form. All are canonically stated in
  `skills/_shared/artifact-definitions.md` and reproduced in
  full under "Rules to enforce" below. Surface every violation
  as a finding; the caller fixes mechanical findings and files
  judgment findings to the issue intake. Do not triage.
  Pre-existing violations in files within scope below are still
  in scope.

  ### Scope

  [AUDIT SCOPE]

  Out of scope (do NOT flag content here):
  - `.ok-planner/design/_discover/` — phase 1 scaffolding is
    allowed to cite code paths freely.
  - `.ok-planner/design/concepts/_retired/` (and `_retired/`
    under any catalog) — terminal state, historical record.
  - `.ok-planner/issues/` (and any legacy `issues.jsonl`) — the
    issue intake is operational state, not a design artifact.

  ### Rules to enforce

  This reviewer runs as its own dispatch and does not see the
  shared file, so the rules are reproduced here in full.

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### Story form

  {{STORY-DEFINITION}}

  Enforce on every in-scope story: the `## Story` line follows
  `As <role>, I want <capability>, so that <benefit>` with a
  substantive "so that" clause (a missing, empty, or circular
  benefit — "so that it works" — is a violation); the body
  prescribes no mechanism; the `## Proof` field is present and
  states what a third party must observe.

  ### Decision form

  {{DECISION-DEFINITION}}

  Enforce on every in-scope decision: Choice / Rationale /
  Alternatives / Proof sections present; the `## Proof` field
  names a check that would fail if the choice were violated
  (a Proof that no check could ever fail — or that merely
  restates the choice — is a violation); Alternatives are
  real (a decision with no plausible alternative is a default,
  flag it for retirement).

  ### TOC consistency (`concepts.md` / `stories.md` / `decisions.md`)

  Check TOC consistency only for the TOCs whose catalog has at
  least one file in the audit scope. Skip TOCs whose catalog
  is entirely out of scope.

  - Every TOC bullet's slug matches a live artifact file in the
    matching directory. (Retired-only entries belong in the
    "Retired" section, not the live list.)
  - Every live artifact file (non-retired) has a TOC entry in
    its catalog's TOC.
  - One-sentence TOC definitions follow the same
    self-containment rule — no paths, no external-doc refs.

  ### Cross-reference integrity

  - Every `see also: <slug>` and `concept:<slug>` / `story:<slug>`
    / `decision:<slug>` referenced from an artifact body in
    scope resolves to a live artifact file of the matching
    kind. A reference to a retired-only target is a violation —
    either repoint to the live successor or remove.

  ### How to scan

  Walk every in-scope file (or delta block). For each violation
  record:
  - File path (or sprint delta heading)
  - Line number or section heading
  - The offending text (quote it)
  - Which rule it violates
  - Class: `mechanical` (fixable without owner judgment — a
    forbidden section to strip, a stale TOC line, a dangling
    cross-reference with an obvious live successor) or
    `judgment` (requires owner calibration — a boundary that
    can't be stated without naming a file, a story with no
    honest benefit clause, a decision with no expressible
    proof)
  - How to fix (mechanical), or the question the owner must
    answer (judgment)

  ### Output format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found, one entry per violation:)

  ### <file>:<line-or-section> — <one-line summary>
  Class: mechanical | judgment
  <Quoted offending text, which rule it violates, how to fix
  or what the owner must decide.>

  (if Approved:)

  (empty Findings section)
  ```

  ### Anti-padding

  - Don't flag content under `_discover/` or `_retired/`.
  - Don't flag content outside the audit scope. The scope
    above is exhaustive — if a file isn't listed, it isn't
    being audited this run.
  - Don't flag prose style. The rule is structural — which
    kinds of citations and sections are present — not whether
    the prose reads well.
  - Don't flag a concept for missing content the rule doesn't
    require.
  - Don't grade severity. Every violation is in scope.
```
