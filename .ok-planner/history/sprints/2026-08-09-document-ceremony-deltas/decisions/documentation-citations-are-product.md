---
decision: documentation-citations-are-product
---

# Documentation citations are product, never process inputs

## Choice

Documentation-corpus records carry citations into the released source,
and every citation means "at the stamped commit." Citations are part of
the product — the handoff pointing an agent reader into the tagged
source for deeper understanding — and are checked once, when the corpus
is produced. No gate, carry-forward, or freshness mechanism may key on
whether a citation resolves against anything later.

## Rationale

The corpus's consumer is an agent that can check out the release tag,
so a citation is load-bearing navigation, not decoration — projection
covers the shape, warrants cover the behavior, and the citation covers
everything deeper. Pinning the meaning to the stamp is what makes this
safe: a reference frozen at a tag resolves permanently, so it can rot
against the moving tree without ever lying. The audit corpus's citation
ban is audit-local, not a family principle — an audit has no reader
whose job a citation serves, and there a citation's only possible use
is the invalidation machinery this family rejects.

## Alternatives

- Ban citations as the audit does: uniform rule across corpora, but it
  amputates the documentation reader's deep handoff for the sake of a
  symmetry no reader benefits from.
- Track citation freshness: keep citations and re-verify them against
  the moving tree — standing invalidation machinery, the cost the
  full-reassessment decision exists to avoid.
