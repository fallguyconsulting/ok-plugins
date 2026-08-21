---
decision: generated-catalog-tocs
---

# Catalog tables of contents are generated, never authored

## Choice

Every durable catalog in an estate carries a table of contents beside
it, and a generator writes that file from the catalog's own artifacts.
Nobody edits a table of contents by hand; the next generation
overwrites any hand edit. Whoever applies a corpus delta that touches a
catalog regenerates that catalog's table of contents in the same act,
never as a later chore. The periodic audit and the certification gate
check each table of contents against the catalog it indexes and report
a stale one as a mechanical finding; neither is the generator.

## Rationale

A table of contents is a projection of the catalog, so a second
authored copy of the same content drifts from the first. Generating it
turns staleness into a defect of the last delta rather than a standing
risk. Regenerating inside the delta's own act closes the window: a
refresh deferred to a later step leaves the index wrong for as long as
the corpus has moved. The checks stay backstops because a checker that
also generated would repair the omission it exists to report. It would
also leave every session between two deltas reading an index the corpus
contradicts.

## Alternatives

- Hand-authored tables of contents — an author tunes each summary, at
  the cost of a second place the same fact lives with nothing to notice
  when the two diverge.
- Regeneration only at the audit or the certification gate — cheaper
  per delta, and every session between a delta and the next run reads
  an index missing the artifact just added.
- No table of contents, with every consumer listing the catalog
  directory — always current, and it costs each reader the full body of
  every artifact to learn what exists.
