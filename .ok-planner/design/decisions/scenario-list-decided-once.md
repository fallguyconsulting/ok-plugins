---
decision: scenario-list-decided-once
---

# The scenario list is committed, and a test's support is decided once

## Choice

The project commits the scenario list, which only the tests tool
writes: each scenario with its source, its outcome, its test's path
and name, its test support files, each lock its test declares, with
its mode, and its own silence where its test has no choice but a longer
one; the lock list; each test support file's locks; each gap; each program the owner
left unguarded; the open issue a failing scenario waits on; each
story's test stamp; each speed acceptance; the slowest-tests ranking;
each test's `reaches`; and each test file a plan kept.

Support is decided once, when the test is written: a failing test
after that is a regression, never evidence that the scenario is
unsupported.

How the list maps a scenario to its test, whether it declares the
runtime parts, what a story's test stamp is, and when a sprint writes
the list are decisions of their own (see also:
scenario-list-maps-each-test-without-a-tag,
runtime-parts-declared-in-the-scenario-list,
story-test-stamp-is-its-planned-blob,
scenario-list-written-at-the-archive-step).

## Rationale

A list generated afresh on every run re-decides support every time,
so a regression could turn into a gap and drop its test. A committed
list fixes each decision where a sprint's plan settled it, and git
versions it like the code it describes. Keeping the speed acceptances,
the ranking, and `reaches` in the list carries them from one sprint to
the next with the scenarios they describe.

## Alternatives

- Generate the list from the stories on every run: nothing to keep,
  and support is re-judged each time.
