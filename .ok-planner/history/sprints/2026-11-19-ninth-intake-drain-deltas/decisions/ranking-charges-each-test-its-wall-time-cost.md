---
decision: ranking-charges-each-test-its-wall-time-cost
---

# The ranking charges each test what it costs a round's wall time under the locks

## Choice

The tests tool charges each test in the slowest-tests ranking by what
it costs a round's wall time (see also:
speed-ranked-by-median-seconds). It takes a lower bound on the
round's wall time under the tests' locks, and a test's cost is how
much the bound drops when the test's seconds drop to zero. The bound
is the larger of all tests' seconds over the workers and, for each
lock name, the seconds its exclusive holders take one after another
plus the seconds its shared holders need side by side: the larger of
the longest shared holder's seconds and their total over the workers.
A round's ranking takes the workers the round's header records, and
the ranking the scenario list carries takes the budget's workers. No
rule puts a test that holds a lock first.

## Rationale

A test that holds a lock exclusive adds its whole seconds to the time
that lock is busy, and a test that holds no lock adds only a share of
its seconds over the workers, so a ranking by seconds alone misjudges
which test costs the round the most. A bound per lock charges each
holder for the time no other holder can use. The ranking the scenario
list carries serves every machine that runs the suite, so it takes the
committed budget's workers, not one machine's (see also:
workers-sized-per-machine).

## Alternatives

- Rank by seconds alone: charges a test the workers spread as if it
  ran alone.
- Rank every test that holds a lock first: charges a test that holds
  a lock shared as if it ran alone.
