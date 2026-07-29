---
issue: acceptance-clauses-must-be-deterministically-decidable
kind: human
category: unspecified
artifacts:
  - story:explain-lint-rules
status: open
opened: 2026-07-29T00:59:07Z
---

# Should the story authoring rules forbid Acceptance clauses whose truth requires qualitative judgment?

## Problem

The corpus's verification machinery — deterministic proofs, adversarial
implementation audits, the certification review-fix loop — can discharge
only mechanically decidable claims. Nothing in the canonical story
authoring rules forbids an Acceptance clause whose truth is a quality
judgment, and the sign-off compliance review checks form (story line
shape, benefit clause, no mechanism), not verifiability-class. A story
that commits the corpus to a qualitative property therefore passes
planning and then hands certification an undischargeable debt.

Observed: `story:explain-lint-rules`'s Acceptance commits to "that
rule's canonical definition and worked examples ... so the explanation
matches the rules that project actually enforces." "Canonical,"
"matches," and "worked" have no deterministic decision procedure over
free prose. During this sprint's certification the review-fix loop ran
six fix/re-audit rounds against that story without converging: each
auditor could always exhibit one more sense in which the explanation's
truth might silently diverge from the lint, and each was right by the
story's own text. The mechanical remainder of the story (the verb
answers, the listing covers every emittable code, the text comes from
the committed lint) was green from the first cycle; everything that
cycled was the quality rim. The owner's assessment at the time: the
correctness of documentation content is an editorial quality concern
that this process cannot underwrite.

## Candidates

- Amend the story-form rules in the canonical artifact definitions:
  every Acceptance clause must be deterministically decidable — a proof
  can settle it mechanically — and qualitative properties (correct,
  canonical, clear, useful) may live only in the story's benefit
  clause, which carries intent without becoming a test obligation. Add
  the corresponding check to the design-doc compliance reviewer's
  story-form enforcement so sign-off catches it.
- Amend the rules to permit qualitative Acceptance clauses but mark
  them audit-advisory: the proof obligation extends only to the
  mechanical clauses, and auditors record qualitative observations as
  characterisation, never as grounds for a violated determination.
- Leave the authoring rules unchanged and handle each case at planning
  time by owner vigilance.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29).
The resolution taken differs from the candidates as filed: the
authoring rules do NOT forbid qualitative Acceptance clauses — a
story may legitimately say correct, clear, helpful, anywhere in its
body — and the process instead reads past them. A canonical
decidability-boundary rule was added to the plugin source
(`{{DECIDABILITY-BOUNDARY}}` in `skills/_shared/artifact-definitions.md`)
and wired through the auditor, prove, fixer, architect, code
reviewer, compliance reviewer, plan-sprint, and the two
always-in-context templates: proofs, determinations, and findings
attach only to a story's mechanical core; qualitative clauses ground
no verdict and no fix cycle, and are recorded in the audit's
parseable `## Referrals` section — the promised thing verified to
exist in form, suitability explicitly not opined, the owning
discipline named — surfaced in certification's presentation. This
issue stays open so the next sprint picks it up and ratifies the
change; the work is already done in plugin source and ships with the
next release/re-vendor.
