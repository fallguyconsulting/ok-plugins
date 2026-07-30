# Design-doc compliance reviewer prompt

Canonical prompt body for the design-doc compliance reviewer subagent. Used by `audit` (whole-corpus scope) and `plan-sprint` (draft scope — the corpus deltas of a sprint under sign-off review). Both invocations dispatch the same reviewer; only the audit scope differs.

The reviewer checks two things: that an artifact body has the right *shape*, and that the claims it makes are *grounded*. The second exists because nothing else checks it — a sprint's deltas are the instrument every certification gate measures against, so a false claim written into one is invisible from then on; and the implementation audit reads a Choice against the code, never a Rationale. Draft scope is the last moment a fabricated justification costs nothing to remove.

## How consumers use this file

Two consumers, two scopes, one prompt:

- `audit` substitutes the whole-corpus glob result for `[AUDIT SCOPE]`.
- `plan-sprint` computes a **draft scope** — the final-form artifact bodies drafted as corpus deltas in the sprint under review, plus any live artifact a delta amends — and substitutes that set.

The prompt body below is shared verbatim between the two invocations. Drift between draft-time and corpus-time review cannot happen.

**Multi-file transclusion.** The prompt body uses `[AUDIT SCOPE]` (per-call value, filled by the consumer), `{{SELF-CONTAINMENT-RULE}}` / `{{CURRENT-STATE-ONLY-RULE}}` / `{{STORY-DEFINITION}}` / `{{DECISION-DEFINITION}}` (static blocks from `../_shared/artifact-definitions.md`), and `{{LEAF-AGENT-RULE}}` / `{{READ-ONLY-REVIEWER-RULE}}` (from `../_shared/dispatch-discipline.md`). When assembling the dispatched prompt, substitute each `{{...}}` placeholder with the body of the matching `###` block in `artifact-definitions.md` — same convention as every other transcluded prompt in the skill set.

## How to substitute `[AUDIT SCOPE]`

The `[AUDIT SCOPE]` placeholder is one or more lines listing the artifact files (or in-sprint delta blocks) the reviewer must audit, with a one-line note above explaining the mode. Examples:

**Whole-corpus mode (`audit`):**

```
Audit every live artifact file in the project's design corpus:

- All `.md` files directly under `.ok-planner/design/concepts/`
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

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Audit design-doc content for compliance with the canonical
  artifact rules: self-containment, current-state-only, story
  form, and decision form — all canonically stated in
  `../_shared/artifact-definitions.md` and reproduced in
  full under "Rules to enforce" below — and for the grounding
  of the claims the bodies make. Surface every violation
  as a finding; the caller fixes mechanical findings and files
  judgment findings to the issue intake. Do not triage.
  Pre-existing violations in files within scope below are still
  in scope.

  ### Scope

  [AUDIT SCOPE]

  Out of scope (do NOT flag content here):
  - `.ok-planner/design/_discover/` — phase 1 scaffolding is
    allowed to cite code paths freely.
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
  prescribes no mechanism; the body is `## Story` alone — an
  `## Acceptance` section, a verification section, or any other
  section is a violation, because a story is a pure expression of
  business value whose only acceptance is that the user has a way
  to do the capability and accomplish the benefit, and
  verification lives in the implementation audit, not in the
  story.
  Qualitative language — correct, clear, helpful, canonical — is
  NOT a form violation anywhere in a story, per
  {{DECIDABILITY-BOUNDARY}}: it is legal intent the verification
  machinery reads past (audits attach to the decidable
  clauses; the rim becomes audit referrals). Never demand a story
  be rewritten to purely mechanical phrasing.

  ### Decision form

  {{DECISION-DEFINITION}}

  Enforce on every in-scope decision: Choice / Rationale /
  Alternatives sections present; a verification section of any
  kind is a violation — a decision's verification is
  the implementation audit under `.ok-planner/audits/`;
  Alternatives are real (a decision with no plausible
  alternative is a default, flag it for retirement). The
  Rationale is non-normative by definition: a Rationale
  sentence claiming a capability or property that no Choice
  clause commits to is a violation — the claim moves into the
  Choice, where the implementation audit will check it, or it
  goes.

  ### Claim grounding

  Every other rule here asks where a sentence belongs. This one
  asks whether it is true.

  An artifact body asserts facts — about the codebase, its
  tooling, its dependencies, the services it runs against. A
  Rationale explaining why an option won, an Alternatives bullet
  saying why one lost, a Boundaries clause describing what a
  neighbour does: each rests on a claim that either holds or does
  not. Nothing downstream checks them. The implementation audit
  reads a Choice against the code, not a Rationale, so a
  fabricated reason survives every gate and is read for years as
  though someone had verified it.

  So verify what you can, and mark what you cannot:

  - **A claim about this repository** — what a file does, what a
    script runs, what a config sets, what a dependency is pinned
    to, what a vendored image contains — you check. Read the file.
    Run the grep. A claim contradicted by the repository is a
    finding, class `mechanical` where the repository determines
    the correct text and no commitment changes by writing it.
  - **A claim about an external service, product, or vendor** —
    pricing, quotas, what a hosted API supports, how a third-party
    tool behaves — you do NOT research. Report it as unverified,
    class `judgment`, so the owner decides whether it needs
    checking. Say plainly that you could not check it rather than
    passing it in silence.
  - **A claim with no discernible basis** — a capability nothing
    in the repository provides, a constraint nothing enforces, a
    justification that reads as invented — is a finding whether or
    not you can positively disprove it. The bar for a rationale is
    that someone could check it, not that no one has.

  Effort scales with scope, and that is intended: at draft scope
  this is a handful of claims at the moment they are cheapest to
  correct, which is the point of checking here rather than later.
  Do not follow a claim beyond the repository, and do not turn a
  grounding check into a code review.

  ### TOC consistency (`concepts.md` / `stories.md` / `decisions.md`)

  Check TOC consistency only for the TOCs whose catalog has at
  least one file in the audit scope. Skip TOCs whose catalog
  is entirely out of scope.

  - Every TOC bullet's slug matches a live artifact file in the
    matching directory.
  - Every live artifact file has a TOC entry in its catalog's
    TOC.
  - One-sentence TOC definitions follow the same
    self-containment rule — no paths, no external-doc refs.

  ### Cross-reference integrity

  - Every `see also: <slug>` and `concept:<slug>` / `story:<slug>`
    / `decision:<slug>` referenced from an artifact body in
    scope resolves to a live artifact file of the matching
    kind. A reference that does not resolve is a violation —
    either repoint it to the live artifact meant or remove it.

  ### How to scan

  Walk every in-scope file (or delta block). For each violation
  record:
  - File path (or sprint delta heading)
  - Line number or section heading
  - The offending text (quote it)
  - Which rule it violates
  - Class: `mechanical` or `judgment`. The line is intent, not
    file surface: `mechanical` means the rules determine the
    compliant text and writing it changes nothing the project
    commits to — a forbidden section to strip, a stale TOC
    line, a dangling cross-reference with an obvious live
    successor, a heading brought to canonical shape, a
    mechanism tail stripped from a story body whose commitment
    survives intact. `judgment` means compliance cannot be
    reached without the owner deciding something — a boundary
    that can't be stated without naming a file, a story with no
    honest benefit clause, a decision whose violation no
    reading could detect: cases where the compliant text would
    itself be a new or changed commitment.
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

  - Don't flag content under `_discover/`.
  - Don't flag content outside the audit scope. The scope
    above is exhaustive — if a file isn't listed, it isn't
    being audited this run.
  - Don't flag prose style. The form rules are structural —
    which kinds of citations and sections are present — not
    whether the prose reads well. Claim grounding is the one
    exception, and it is about truth, not style: flag a sentence
    for what it asserts, never for how it reads.
  - Don't research external services to settle a claim. Report
    what you could not check and move on.
  - Don't flag a concept for missing content the rule doesn't
    require.
  - Don't grade severity. Every violation is in scope.
```

<!-- Materialized by ok-planner v14.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
