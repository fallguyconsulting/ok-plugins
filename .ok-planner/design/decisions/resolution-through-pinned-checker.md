---
decision: resolution-through-pinned-checker
---

# Citations are resolved by the project's own checker, never by a second implementation

## Choice

The program serving the corpus view resolves every citation by calling the project's own materialized audit checker, rather than reimplementing anchor location, release-metadata masking, and span hashing inside itself.

## Rationale

The checker carries the certification gate's arithmetic, including a masking rule that deliberately ignores release-mutable metadata so that a version bump voids no audit. A second implementation of that rule would drift from it, and the drift would surface as the view calling a citation stale that the gate calls clean — worst precisely during a release, which is when someone would open the view to understand what moved. Calling the project's own copy makes that disagreement structurally impossible, and inherits each project's pinned resolution behavior without tracking it separately.

## Alternatives

- Reimplement resolution inside the serving program — no dependence on the checker's internals, at the cost of two implementations of one rule that must never disagree.
- Invoke the checker's command line per citation — the same authority, but its output reports findings rather than resolved locations, so what the view needs is not exposed.
- Read the committed source graph alone — sufficient for node citations, but blind to the anchor-based citation forms that carry most of the corpus.
