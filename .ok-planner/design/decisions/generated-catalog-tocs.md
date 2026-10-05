---
decision: generated-catalog-tocs
---

# Catalog tables of contents are generated, never authored

## Choice

Every durable catalog in an estate carries a table of contents beside
it, and one generator script writes every one of those files from its
catalog's own artifacts, the design catalogs and the coding-standard
catalogs alike, and the same script checks every one for staleness.
Nobody edits a table of contents by hand; the next
generation overwrites any hand edit. Whoever applies a corpus delta
that touches a catalog regenerates that catalog's table of contents in
the same act, never as a later chore, and the completion contract names
the regeneration as part of applying the delta.

## Rationale

A table of contents is a projection of the catalog, so a second
authored copy of the same content drifts from the first. Generating it
turns staleness into a defect of the last delta rather than a standing
risk. One script for every catalog means one summary rule and one check,
and no catalog whose index rests on an agent's care. Regenerating inside
the delta's own act closes the window: a refresh deferred to a later
step leaves the index wrong for as long as the corpus has moved, and
every session between two deltas reads an index the corpus contradicts.

## Alternatives

- Hand-authored tables of contents — an author tunes each summary, at
  the cost of a second place the same fact lives with nothing to notice
  when the two diverge.
- An agent following a fixed procedure writes the design tables of
  contents — no script to extend, and the index drifts with only a
  periodic reader to notice.
- Regeneration only at a periodic run — cheaper per delta, and every
  session between a delta and the next run reads an index missing the
  artifact just added.
- No table of contents, with every consumer listing the catalog
  directory — always current, and it costs each reader the full body of
  every artifact to learn what exists.
