---
decision: documentation-citations-are-product
---

# Documentation citations are product, and the shipped layer cites only its catalog

## Choice

Documentation-corpus records carry citations, and every citation means
"at the stamped commit" — but the shipped layer cites only its own
vocabulary: a publishable record points at catalog rows over the
extraction's public side, never at source paths, tests, or internal
entry points. Verification-layer records — the surface extraction,
evidence sets, the experiment archive — cite the tree freely. The
generated documents are outside this rule: they are self-contained and
carry no citations at all
(`decision:documents-generated-per-type-and-placed`). All citations are
checked once, when their record is produced; no gate, carry-forward,
or freshness mechanism may key on whether a citation resolves against
anything later.

## Rationale

The corpus's consumer reads from the user's vantage, and a source-path
citation in a shipped record hands the reader the very internals the
shipped vocabulary excludes — an invitation to form expectations from
implementation, which is the contamination the whole design guards
against. A catalog row resolves at the stamp exactly as a path did, so
the reader keeps a load-bearing handoff: projection covers the shape,
warrants cover the behavior, and the catalog covers everything
navigable. The verification layer keeps tree citations because its
reader is the process itself, checking claims at production time. The
audit corpus's citation ban is audit-local, not a family principle —
an audit has no reader whose job a citation serves.

## Alternatives

- Source-path citations in shipped records: the previous shape — the
  deep handoff into the tagged tree, at the cost of leaking internal
  vocabulary into the user-facing layer.
- Ban citations everywhere as the audit does: uniform, but it
  amputates the reader's navigation for the sake of a symmetry no
  reader benefits from.
- Track citation freshness: keep citations and re-verify them against
  the moving tree — standing invalidation machinery, the cost the
  full-reassessment decision exists to avoid.
