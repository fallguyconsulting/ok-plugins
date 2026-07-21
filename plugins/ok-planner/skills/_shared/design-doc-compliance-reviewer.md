# Design-doc compliance reviewer prompt

Canonical prompt body for the design-doc compliance reviewer subagent. Used by `review-work` (cycle 2, focused scope) and `review-design` (whole-corpus scope). Both invocations dispatch the same reviewer; only the audit scope differs.

## How consumers use this file

Two consumers, two scopes, one prompt:

- `review-work` cycle 2 computes a **focused audit set** from the current uncommitted change (files directly modified under `.ok-planner/design/{concepts,stories,decisions,tensions}/`, plus artifacts whose slug is mentioned in changed code annotations or in any in-flight spec/plan). It substitutes that set for `[AUDIT SCOPE]` in the prompt below.
- `review-design` is invoked explicitly by the user for the **whole-corpus sweep**. It substitutes the whole-corpus glob result for `[AUDIT SCOPE]`.

The prompt body below is shared verbatim between the two invocations. Drift between focused and full audits cannot happen.

**Two-file transclusion.** The prompt body uses both `[AUDIT SCOPE]` (per-call value, filled by the consumer) AND `{{SELF-CONTAINMENT-RULE}}` / `{{TENSION-SURFACE-RULE}}` / `{{CURRENT-STATE-ONLY-RULE}}` (static blocks defined in `skills/_shared/artifact-definitions.md`). When assembling the dispatched prompt, substitute each `{{...}}` placeholder with the body of the matching `###` block in `artifact-definitions.md` — same convention as every other transcluded prompt in the skill set.

## How to substitute `[AUDIT SCOPE]`

The `[AUDIT SCOPE]` placeholder is one or more lines listing the artifact files the reviewer must audit, with a one-line note above explaining the mode. Examples:

**Focused mode (`review-work` cycle 2):**

```
Audit the following artifact files (focused scope from the current uncommitted change). Files were selected because they were directly modified, are referenced by an `@concept:` / `@story:` / `@decision:` annotation in a changed code file, or are named by slug in an in-flight spec or plan:

- .ok-planner/design/concepts/claim-handle.md
- .ok-planner/design/stories/claim-co-holder.md
- .ok-planner/design/decisions/persistence.md
- .ok-planner/design/tensions/cache-invalidation.md
```

**Whole-corpus mode (`review-design`):**

```
Audit every live artifact file in the project's design corpus:

- All `.md` files directly under `.ok-planner/design/concepts/` (skip `_retired/`)
- All `.md` files directly under `.ok-planner/design/stories/`
- All `.md` files directly under `.ok-planner/design/decisions/`
- All `.md` files directly under `.ok-planner/design/tensions/` (skip `_resolved/` and `_rejected/`)
- `.ok-planner/design/concepts.md`, `stories.md`, and `decisions.md` (the auto-generated TOCs)
```

## The prompt

The token block below is the full dispatched prompt. Replace `[AUDIT SCOPE]` per the above; everything else is invariant.

### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}

```
Agent (general-purpose):
  ## Design-doc compliance review

  ### Your job

  Audit the project's design docs for compliance with the
  canonical artifact rules: self-containment (concepts /
  stories / decisions), tension surface, and current-state-only.
  All three are canonically stated in
  `skills/_shared/artifact-definitions.md` and reproduced in
  full under "Rules to enforce" below. Surface every violation
  as an issue; a fixer will rewrite. Do not triage.
  Pre-existing violations in files within scope below are still
  in scope — the "Fix Every Bug You Find" rule applies.

  ### Scope

  [AUDIT SCOPE]

  Out of scope (do NOT flag content here):
  - `.ok-planner/design/_discover/` — phase 1 scaffolding is
    allowed to cite code paths freely.
  - `.ok-planner/design/concepts/_retired/`,
    `tensions/_resolved/`, `tensions/_rejected/` — terminal
    state, historical record.
  - `.ok-planner/design/review-notes.md` and any dated
    rotations (`review-notes-YYYY-MM-DD.md`) — workflow
    scratch.

  ### Rules to enforce

  This reviewer runs as its own dispatch and does not see the
  shared file, so the rules are reproduced here in full.

  {{SELF-CONTAINMENT-RULE}}

  {{TENSION-SURFACE-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  Apply the self-containment rule to every live concept, story,
  and decision body. Apply the tension surface rule to every
  live tension body. Apply the current-state-only rule to all
  four kinds of artifact body.

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
  - Every in-scope tension's `affects:` frontmatter slug
    resolves to a live concept.

  ### How to scan

  Walk every in-scope file. For each violation record:
  - File path
  - Line number or section heading
  - The offending text (quote it)
  - Which rule it violates
  - How to fix (rewrite as path-free prose, move the content
    to `_discover/`, file a tension if the concept genuinely
    can't say what it needs to without naming a path, etc.)

  ### Output format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found, one entry per violation:)

  ### <file>:<line-or-section> — <one-line summary>
  <Quoted offending text, which rule it violates, how to
  rewrite.>

  (if Approved:)

  (empty Findings section)
  ```

  ### Anti-padding

  - Don't flag content under `_discover/`, `_retired/`,
    `_resolved/`, `_rejected/`, or `review-notes*.md`.
  - Don't flag content outside the audit scope. The scope
    above is exhaustive — if a file isn't listed, it isn't
    being audited this run.
  - Don't flag prose style. The rule is structural — which
    kinds of citations and sections are present — not whether
    the prose reads well.
  - Don't flag a concept for missing content the rule doesn't
    require.
  - Don't grade severity. Every violation is in scope; pass
    them all to the fixer.
```
