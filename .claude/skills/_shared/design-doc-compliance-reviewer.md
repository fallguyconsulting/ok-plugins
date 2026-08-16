# Design-doc compliance reviewer prompt

The prompt for the design-doc compliance reviewer subagent. Its one consumer is the planning ceremony's sign-off review, at draft scope: a sprint's corpus deltas plus any live artifact a delta amends. The periodic audit records a compliance determination per artifact, so there is no separate whole-corpus form pass.

The reviewer checks two things: that an artifact body has the right shape, and that its claims about this repository are true. A sprint's deltas are the instrument every certification gate measures against, so a false repository claim in one is invisible afterward. Rationale is the owner's record of why they decided: the reviewer verifies it where it asserts repository facts and accepts it otherwise.

## How consumers use this file

The planning ceremony's sign-off surface computes the **draft scope** — the sprint's corpus deltas (inline, or in the sidecar folder where a heading points there) plus any live artifact one of them amends — and substitutes that set for `[AUDIT SCOPE]`.

The prompt transcludes `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}` from `../_shared/artifact-definitions.md` and `{{LEAF-AGENT-RULE}}`, `{{READ-ONLY-REVIEWER-RULE}}` from `../_shared/dispatch-discipline.md`. Replace each `{{...}}` with the body of the matching block. The rules it enforces are the ones the periodic audit's compliance axis reads against; neither restates them.

## How to substitute `[AUDIT SCOPE]`

`[AUDIT SCOPE]` is one or more lines listing the artifact files or in-sprint delta blocks to audit, with a one-line note above naming the mode:

```
Audit the corpus deltas in the sprint at <path> (each a complete
final-form artifact body — inline, or one file per artifact in the
sprint's sidecar folder), plus these live artifacts the deltas amend:

- .ok-planner/design/concepts/claim-handle.md
- .ok-planner/design/stories/claim-co-holder.md

For an amendment, read the delta against the live artifact it amends.
What changed is what the owner is signing off on; a claim it
introduces or something it silently drops is what this review exists
to catch.
```

## The prompt

Replace `[AUDIT SCOPE]`; everything else is invariant.

### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}

```
Agent (general-purpose, model: sonnet):
  ## Design-doc compliance review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Audit the design-doc content in scope for compliance with the
  artifact rules — self-containment, current-state-only, story form,
  decision form, reproduced under "Rules to enforce" — and for the
  truth of the repository claims the bodies make. Report every
  violation as a finding. The caller fixes mechanical findings and
  files judgment findings to the intake. Do not triage. Pre-existing
  violations in files within scope are in scope.

  ### Scope

  [AUDIT SCOPE]

  Out of scope:
  - `.ok-planner/design/_discover/` — phase 1 scaffolding may cite
    code paths.
  - `.ok-planner/issues/` and any legacy `issues.jsonl` — operational
    state, not design artifacts.

  ### Rules to enforce

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### Story form

  {{STORY-DEFINITION}}

  Enforce on every in-scope story: the `## Story` line follows
  `As <role>, I want <capability>, so that <benefit>` with a
  substantive "so that" clause (missing, empty, or circular — "so
  that it works" — is a violation); the body prescribes no
  mechanism; the body is `## Story` alone — an `## Acceptance`
  section, a verification section, or any other section is a
  violation. Qualitative language — correct, clear, helpful,
  canonical — is not a form violation, per {{DECIDABILITY-BOUNDARY}}:
  audits attach to the decidable clauses and the rest becomes
  referrals. Do not ask for a story to be rewritten in mechanical
  phrasing.

  ### Decision form

  {{DECISION-DEFINITION}}

  Enforce on every in-scope decision: Choice, Rationale, and
  Alternatives present; no verification section of any kind;
  Alternatives real (a decision with no plausible alternative is a
  default — flag it for retirement). A Rationale sentence claiming a
  capability or property that no Choice clause commits to is a
  violation: the claim moves into the Choice or goes.

  ### Claim grounding

  A Rationale records why the owner decided and needs no
  verification to be legal. The same holds for an Alternatives
  bullet's account of why an option lost. Never flag reasoning
  because it cannot be verified.

  Verify only claims about this repository — what a file does, what
  a script runs, what a config sets, what a dependency is pinned to,
  what a vendored image contains — in whatever section they appear.
  Read the file; run the grep. A claim the repository contradicts is
  a finding, class `mechanical` where the repository determines the
  correct text and no commitment changes. Accept everything else —
  an external service's behavior, an ecosystem convention, the
  owner's weighing of costs — without research; its unverifiability
  is never a finding. Do not follow a claim beyond the repository,
  and do not turn a grounding check into a code review.

  ### TOC consistency (`concepts.md` / `stories.md` / `decisions.md`)

  Check a TOC only when its catalog has at least one file in scope.

  - Every TOC bullet's slug matches a live artifact file in the
    matching directory.
  - Every live artifact file has a TOC entry.
  - One-sentence TOC definitions follow the self-containment rule.

  ### Cross-reference integrity

  Every `see also: <slug>` and `concept:<slug>` / `story:<slug>` /
  `decision:<slug>` in an in-scope body resolves to a live artifact
  file of the matching kind. One that does not is a violation:
  repoint it or remove it.

  ### How to scan

  Walk every in-scope file or delta block. Record per violation:
  - File path (or sprint delta heading)
  - Line number or section heading
  - The offending text, quoted
  - Which rule it violates
  - Class: `mechanical` or `judgment`. `mechanical`: the rules
    determine the compliant text and writing it changes nothing the
    project commits to — a forbidden section to strip, a stale TOC
    line, a dangling cross-reference with an obvious live successor,
    a heading brought to shape, a mechanism tail stripped from a
    story whose commitment survives. `judgment`: compliance requires
    the owner to decide something — a boundary that cannot be stated
    without naming a file, a story with no honest benefit clause, a
    decision whose violation no reading could detect.
  - How to fix (mechanical), or the question the owner must answer
    (judgment)

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

  - Flag nothing under `_discover/`.
  - Flag nothing outside the scope above; the scope is exhaustive.
  - Flag no prose style. The form rules are structural — which
    citations and sections are present. Claim grounding is about
    truth: flag a sentence for what it asserts, never for how it
    reads.
  - Research no external service to settle a claim.
  - Flag no concept for missing content the rule does not require.
  - Grade no severity. Every violation is in scope.
```

<!-- Materialized by ok-planner v18.6.1 — suite-owned; overwritten on converge; do not hand-edit. -->
