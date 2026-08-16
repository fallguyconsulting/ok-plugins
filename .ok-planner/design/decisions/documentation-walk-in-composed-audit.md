---
decision: documentation-walk-in-composed-audit
---

# The documentation walk runs inside the audit when `/document` composes it, and inside `/document` against a current audit otherwise

## Choice

The set of document types is settled in a **documentation walk**: a
short owner conversation that reads the run's surface extraction
against the declared types under `.ok-planner/surface/documents/`,
raises only the deltas — a public class no type covers, a type whose
classes the extraction returned empty — and lands the types the owner
approves. On a project with no types the walk proposes a starter set
from the extraction (one reference per public kind found, and a
leading document for the whole) for the owner to keep, drop, or
rename. A type the owner leaves unsettled is left out for the run and
filed as an intake issue. The walk is one body, defined in ok-planner's
documentation contribution, with exactly two call sites: inside the
audit, immediately after the extractor returns and before the
autonomous determinations, **only when `/document` invoked the
audit**; and inside `/document` itself, against the current audit's
extraction, when `/document` reuses an audit it did not run. An à la
carte `/audit` never runs it.

## Rationale

The gaps are only visible once the extraction exists, so the walk
cannot ride the surface-intent stage that precedes it; and putting the
walk after the audit's whole determination stage would make the owner
sit through the run's longest part to answer a question the extraction
already made answerable. Running it inside the composed audit, right
after extraction, keeps the run's owner attention contiguous — surface
intent, extract, documentation, then hands-free — and leaves
`/document`'s construction with nothing to ask. Confining it to the
composed audit keeps an à la carte audit what it is, the owner's health
check on their own cadence, rather than a documentation conversation on
every run. The second call site exists because `/document` reuses a
current audit rather than repeating one, and a reused audit had no
walk; defining the walk once and calling it from both places is what
keeps the two paths from drifting on what the walk asks.

## Alternatives

- Run the walk in every audit, asking only on a delta: one call site,
  at the cost of a documentation conversation in a ceremony that may
  run with no release in view.
- Give `/document` its own interactive stage after the audit
  completes: one call site, but the owner waits through the audit's
  determination stage to answer a question available at extraction.
- Force a fresh audit whenever `/document` runs, so the walk always
  happens inside the audit: one call site, at the cost of the
  "current audit is reused" rule and a full re-measurement to ask a
  question.
- Fold the documentation questions into the surface-intent stage: one
  conversation, but blind — the extraction that reveals the gaps does
  not exist yet.
