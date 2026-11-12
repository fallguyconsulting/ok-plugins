---
decision: speed-ranked-by-median-seconds
---

# The slowest-tests ranking orders tests by their median seconds

## Choice

The ranking orders the tests by each test's median seconds across the
whole-suite rounds that ran it at its current test file's digest,
charged by the schedule the suite command runs (see also:
tests-isolated-unless-declared). The ranking chooses which tests a
speed reader reads (see also: speed-read-at-three-points).

## Rationale

The ranking points each sprint's speed read at the tests that cost a
round the most. Round time moves with machine load: on one project two
rounds ran about 25% slower than the round after them, so a median
moves little where one round's seconds reorder the list.

## Alternatives

- Rank by one round's seconds: machine load in that round reorders the
  list.
