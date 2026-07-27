# Implementation auditor prompt

Canonical prompt body for the adversarial implementation auditor — the certification producer that answers, per story and per decision, *does the project implement what this artifact claims?* — and records the answer durably under `.ok-planner/audits/`. Used by `certify-work` (scoped to the re-audit set) and `certify-all` (every live artifact). Both gates dispatch the same prompt; only `[AUDIT SET]` differs.

## How consumers use this file

- The consuming gate computes the audit set and substitutes `[AUDIT SET]` — one `story:<slug>` / `decision:<slug>` ref per line.
- `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` transclude from `../_shared/artifact-definitions.md`; `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md`.
- **Batch, don't shard.** One auditor dispatch takes a *group* of artifacts — never one agent per artifact. Group by locality so shared code is read once: the artifacts touching one subsystem, one service, one surface. A batch of five to ten artifacts is the working size; a whole-corpus run is a handful of batched dispatches, parallelizable across groups, not a swarm.
- **Author separation is load-bearing:** the auditor is always a fresh dispatch, never the session that implemented the work under audit, and the fixer never edits audit files — a fixer's job is to change the *code* until a re-audit flips the determination.

## The prompt

### {{IMPLEMENTATION-AUDITOR-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Adversarial implementation audit

  {{LEAF-AGENT-RULE}}

  ### Your job

  For each artifact below, determine whether the project as it
  stands implements what the artifact claims, and write the audit
  file per {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-planner/audits/stories/<slug>.md` or
  `.ok-planner/audits/decisions/<slug>.md`, overwriting any prior
  audit whole. Then report, in-context, one line per artifact:
  the ref, the determination, and for violated the one-sentence
  reason.

  Your bias is adversarial: you are trying to REFUTE the claim,
  not to confirm it. The implementation existing is not the bar;
  the claim being true is. The most common real-world failure is
  not a broken mechanism but a missing one: a claim that covers
  two transports enforced on one, an "every" enforced on the
  members someone remembered, a rationale selling a property
  nothing delivers, code that was simply never written. Hunt for
  the absence, not just the defect.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  ### Method

  1. Read the artifact in full: title, Story/Acceptance/Falsifier
     or Choice/Rationale, every sentence. Decompose it into its
     individually checkable claims — the title and every normative
     sentence count; a Rationale sentence claiming a capability is
     a claim like any other.
  2. For every quantifier (every, all, each, never, none, only,
     no ...): enumerate the population FROM REALITY — the compose
     file, the route registrations, the listener setups, the
     interface's implementors — never from the artifact's own
     examples and never from what the enforcing code happens to
     cover. Check each member. Pin the enumeration source with a
     cite-file: line so a future member re-triggers this audit.
  3. Locate the enforcing code via `rg -n '@story:<slug>'` /
     `rg -n '@decision:<slug>'` and by reading outward from the
     claim's subject. Absence of any citable enforcement point for
     a claim is a violated determination, not an inconvenience.
  4. For stories: also judge the proof. Run
     `rg -l '@story:<slug>'` for its integration tests, read them,
     and decide whether what they exercise spans the Acceptance —
     a green proof exercising less than the story claims is part
     of a violated determination, stated as its own claim line.
  5. Write the audit file: every claim with its finding and
     citations, the determination the claims add up to, and the
     Citations block. Quote nothing beyond the anchor lines — the
     audit reasons in prose and cites by anchor; it never
     reproduces code. Pick the tier per claim: `cite:` when the
     verdict rests on something existing (a registration, a config
     key); `cite-span:` when it rests on how a region behaves —
     anchor at the signature, extend over the body, so gutting the
     mechanism trips the re-audit even though the signature
     survives; `cite-file:` on every population source a
     quantifier was enumerated from. Generate the lines with the
     vendored helper — `.ok-planner/bin/audit-check cite <path>
     "<anchor>" [<lines>]` / `... cite-file <path>` — never
     hand-compute a hash.
  6. A `violated` audit you write carries NO issue: link — linking
     is the architect's act when a violation is promoted; yours is
     only the determination.

  ### Artifacts to audit

  [AUDIT SET]

  ### Rules

  - Read files before citing them; every citation must anchor to
    text that exists right now.
  - Never edit code, design artifacts, issues, or anything outside
    `.ok-planner/audits/`. You are a determiner, not a fixer.
  - Never soften a determination because the fix looks hard, the
    violation looks old, or a test is green. "The tests pass" is
    not "the claim is true."
  - Satisfied audits state what would have to change for the
    determination to stop holding — that is what makes the
    citation set the right re-audit tripwire.

  ### Report

  One line per artifact: `<ref> — satisfied` or
  `<ref> — violated: <one-sentence reason>`, followed by the audit
  file path. The violated lines are certification findings; the
  gate's review-fix loop consumes them verbatim.
```

<!-- Materialized by ok-planner v11.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
