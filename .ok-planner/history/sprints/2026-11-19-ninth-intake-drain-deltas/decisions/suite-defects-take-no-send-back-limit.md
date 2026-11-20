---
decision: suite-defects-take-no-send-back-limit
---

# A defect the suite found takes no limit of send-backs

## Choice

A defect whose source is the suite has no cap on send-backs and never
goes stuck. Its one way out without a pass is the promise path: the
code can meet the test only by changing what the design corpus
commits to. A verifier that agrees records its agreement, and the
run's owner list files the issue for the next `/plan-sprint` (see
also: intake-writers-are-gated). That test stays failing. Every other
defect keeps the run's limit of send-backs and its restoration (see
also: converge-finds-then-fixes).

## Rationale

A test that passed once can pass again, because the scenario it
checks still stands in the corpus, so a loop with no cap has a way to
finish. A cap with a restoration, as certification's other defects
take, would leave a regression in place to save a round.

## Alternatives

- A send-back limit with a restoration for suite defects, as for the
  others: bounded rounds, and a regression the run cannot fix goes
  back to the owner instead of being fixed.
