---
decision: drive-merge-sorts-each-failure
---

# A merge sorts each drive failure three ways

## Choice

A merge agent sorts each failure a driver reports as a defect the
story or a decision owes, as something the corpus does not promise, or
as a failure of the environment (see also:
drive-tries-each-story-as-a-user). It folds only the failures it sorts
as defects into the defect list.

## Rationale

Not every failure a driver meets is the product's. The three-way sort
keeps a failure of the environment out of the fix loop, so a fixer is
spent only where a story or a decision owes the fix.

## Alternatives

- A merge that keeps every failure as a defect: a fixer is spent on a
  failure of the environment or on a promise the corpus never made.
