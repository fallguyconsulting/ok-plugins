---
decision: document-composes-audit
---

# The documentation ceremony composes the audit

## Choice

`/document` opens by running `/audit` at the release commit —
composing the audit as its own skill, never absorbing its logic. The
audit is the ceremony's entire measurement front: it determines the
surface partition, story support from the user's side, and decision
and concept support from the technical side. Its determinations set
the delivery criterion — only stories the audit called supported are
documented as delivered — and its surface ruling defines the catalog
domain. An audit already stamped is not repeated: the audit is current
for the release if the tree's movement since its stamped commit
touches only the audit's own output paths — a path-scoped diff, no
tracked state. Audit output steers dispatch and reaches the
orchestrator only: it never enters the assumption synthesizer's box,
whose inputs are the delivered stories, the public surface, and the
prior published corpus.

## Rationale

Story verification lives in the audit, so composition is reuse: the
documentation run consumes determinations instead of re-measuring the
same stories with a second instrument. Sequencing keeps the delivery
criterion honest — an unsupported story is already an intake issue,
not deliverable documentation — and composition rather than absorption
keeps one canonical audit body, so the two ceremonies cannot drift
apart on what an audit is. The à la carte audit is the owner's
pre-release health check, and the stamp-plus-path-rule is what lets
audit-then-document run without paying the measurement twice: the
audit's own committed outputs move the tree, but a path-scoped diff
sees that nothing the audit measured changed.

## Alternatives

- Embed the audit's logic in the documentation ceremony: one run, no
  composition seam — two divergent audit implementations to keep
  honest.
- Require a pre-existing audit stamped at the same commit: keeps the
  ceremonies fully separate, at the cost of a manual sequencing step
  the orchestrator can trivially perform itself.
- No audit gate: document every story regardless of support — known
  gaps ship as product documentation.
- Repeat the audit unconditionally at document time: simple, but pays
  the run's dominant cost twice for a tree that has not meaningfully
  moved.
