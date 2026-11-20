---
decision: tests-run-in-a-new-random-order
---

# Tests run in a new random order every round, and the round records the seed

## Choice

Every run of the tests tool that is given no seed draws a new one, lists the tests for the
suite command in the order of a key the seed gives each test, and
records the seed in the round. The suite command starts the tests in
the order the list gives, as their locks allow (see also:
project-owns-its-suite-command). A run given a recorded seed orders its
tests by the same keys, so a run over any subset of a round's tests
keeps their order in that round.

## Rationale

A race between two tests shows only in an order that exposes it. A
fixed order hides it in every round. A new order each round makes it
more likely to fail over time, and each failure brings a window the
flaky fixer reads (see also:
flaky-tests-traced-through-the-round-window). A recorded seed lets a
fixer replay the order that failed, and a key per test keeps that
order when the fixer runs only the failing test and its window. The
tests tool draws and records the seed, so every project's rounds
shuffle the same way, and every runner gets one recorded replay,
whatever runner its suite command drives.

## Alternatives

- A fixed order, the same every round: a race that order hides stays
  hidden.
- The suite command shuffles with its runner's own option: each runner
  records its seed its own way, or not at all, and the tests tool
  cannot replay a failing order.
- A seed that shuffles the whole list as one: a run over a subset gets
  another order, so a fixer's run of a few tests does not replay the
  round's order.
