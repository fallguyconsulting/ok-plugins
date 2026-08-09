---
decision: document-composes-audit
---

# The documentation ceremony composes the audit

## Choice

`/document` opens by invoking `/audit` at the release commit as its
first phase — composing the audit as its own skill, never absorbing its
logic. The audit's support determinations set the delivery criterion:
only stories the audit called supported are documented as delivered.
Audit output steers dispatch — which stories are assessed, which are
pre-excluded — and reaches the orchestrator only: it never enters the
assumption synthesizer's context, and assessors form their positions
from their own reading.

## Rationale

The two instruments are the two sides of the knowledge gap the
documentation design is built on: the audit is the corpus-soaked pass
that reads source and rules on support; the documentation run forms
user expectations cold and warrants outcomes against the release.
Sequencing them keeps each on its own side, and the delivery criterion
prevents the corpus from documenting a known gap as product — an
unsupported story is already an intake issue, not deliverable
documentation. Composition rather than absorption keeps one canonical
audit body, so the two ceremonies cannot drift apart on what an audit
is.

## Alternatives

- Embed the audit's logic in the documentation ceremony: one run, no
  composition seam — two divergent audit implementations to keep
  honest.
- Require a pre-existing audit stamped at the same commit: keeps the
  ceremonies fully separate, at the cost of a manual sequencing step
  the orchestrator can trivially perform itself.
- No audit gate: document every story regardless of support — known
  gaps ship as product documentation.
