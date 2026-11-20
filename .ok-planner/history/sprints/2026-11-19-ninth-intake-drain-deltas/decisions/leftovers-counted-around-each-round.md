---
decision: leftovers-counted-around-each-round
---

# Leftovers are counted before and after each round

## Choice

The project declares a command that prints one count per kind of
resource a test may leave behind. The tests tool runs it before and
after each recorded round, and a count that grew fails the round (see
also: round-failure-cleared-by-a-later-round).

## Rationale

On one project tests left hundreds of records behind that slowed the
rest. Counting leftovers around each round catches a leak in the round
that made it, and the count names the kind left behind, so its fixer
knows what to look for. A test removes what it creates (see also:
tests-remove-what-they-create), and the count shows where a
teardown missed something.

## Alternatives

- No count: a leak shows only as later tests that slow down or fail.
- A count around every test: the command runs once per test, and the
  round pays for every run.
