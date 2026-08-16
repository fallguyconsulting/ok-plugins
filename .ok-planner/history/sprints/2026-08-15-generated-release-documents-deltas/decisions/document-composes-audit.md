---
decision: document-composes-audit
---

# The documentation ceremony composes the audit

## Choice

`/document` opens by ensuring a current audit at the release commit —
composing the audit as its own skill, never absorbing its logic. The
audit is the ceremony's entire measurement front: it lands the
surface intent and writes the surface extraction, determines story
support from the user's side,
determines decision and concept support from the technical side, and
forms and verifies the assumptions. `/document` measures nothing: it
constructs the documentation corpus from the audit's records — the
catalog projected over the extraction's public side, assessments from
the story and assumption determinations, the trap registry from the
assumption dispositions — and then generates and places one
self-contained document per declared document type
(`decision:documents-generated-per-type-and-placed`). The document
types are settled in the documentation walk, which the audit runs
right after its extractor returns when `/document` invoked it, and
which `/document` runs itself against a current audit's extraction
otherwise (`decision:documentation-walk-in-composed-audit`). An audit
already stamped is not repeated:
the audit is current for the release if the tree's movement since its
stamped commit touches only the audit's own output paths — a
path-scoped diff, no tracked state. Audit output steers construction
and reaches the orchestrator only; the synthesizer's box is the
audit's own machinery and keeps its own input rules.

## Rationale

Measurement lives in the audit — stories, decisions, concepts, and
assumptions alike — so composition is reuse: the documentation run
consumes determinations and dispositions instead of re-measuring
anything with a second instrument, and the construction that remains
is close to mechanical. Sequencing keeps the delivery criterion
honest — an unsupported story is already an intake issue, not
deliverable documentation — and composition rather than absorption
keeps one canonical audit body, so the two ceremonies cannot drift
apart on what an audit is. The à la carte audit is the owner's
pre-release health check, and the stamp-plus-path-rule is what lets
audit-then-document run without paying the measurement twice: the
audit's own committed outputs move the tree, but a path-scoped diff
sees that nothing the audit measured changed. Hooking the
documentation walk into the composed audit, rather than after it,
keeps the owner's attention in one contiguous stretch at the top of
the run and leaves construction with nothing to ask.

## Alternatives

- Embed the audit's logic in the documentation ceremony: one run, no
  composition seam — two divergent audit implementations to keep
  honest.
- Keep assumption measurement in the documentation run: the prior
  shape — the same user-vantage instrument maintained in two
  ceremonies, and traps checked only at releases.
- Require a pre-existing audit stamped at the same commit: keeps the
  ceremonies fully separate, at the cost of a manual sequencing step
  the orchestrator can trivially perform itself.
- No audit gate: document every story regardless of support — known
  gaps ship as product documentation.
- Repeat the audit unconditionally at document time: simple, but pays
  the run's dominant cost twice for a tree that has not meaningfully
  moved.
