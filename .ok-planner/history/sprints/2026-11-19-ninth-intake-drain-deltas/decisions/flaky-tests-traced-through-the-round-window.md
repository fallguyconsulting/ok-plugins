---
decision: flaky-tests-traced-through-the-round-window
---

# A flaky test is traced through its round's window

## Choice

A test that fails in a round and passes alone, with no change since
that reached it, is flaky (see also: failing-tests-rerun-alone). No
fixer records a flaky test as passing as the tree stands: its fixer
looks for the cause. It reads the round's window:
`tests window` prints, for a test and a round, the tests whose run
overlapped it and the tests that ran before it, and marks each that
declares a lock name the failing test holds. The fixer also reads the
tests that failed with it and the test stack's logs for that window,
and reproduces the failure, running the test and its window at the
round's worker count and in the round's order (see also:
tests-run-in-a-new-random-order, workers-sized-per-machine). It then
routes the cause:

- A test in the window disturbed it: the fixer adds the lock to both
  tests or to their test support, with the evidence (see also:
  locks-grow-from-observed-failures).
- The machine was overloaded: the fixer lowers this machine's worker
  count, with the round as its evidence, and adds no lock (see also:
  workers-sized-per-machine).
- The product fails under load: a product fix.
- A test leaves something behind: a count the project's leftover
  command prints (see also: leftovers-counted-around-each-round).
- The test or its test support is at fault: the test-at-fault route
  (see also: fixers-never-edit-tests).

Where the fixer finds none of these, it records that it found none,
adds no lock, and the next whole-suite round runs the test again. Once
a later whole-suite round passes, certification may close with that
cause unfound (see also: whole-suite-rounds-repeat-until-one-passes).

## Rationale

A test that fails in a round and passes alone still has a cause, such
as another test, load, or a leak, and that cause can fail a later
round until it is found. A disturbing test hides among the tests that
overlapped the failing test or ran before it, so a window of them,
with each that holds a lock the failing test holds marked, starts the
fixer where the evidence lies. A race and an overload look alike from
the failing test alone. The window and the stack's logs tell them
apart, and each takes the one change that removes it: a lock for a
race, a lower count for an overload. A fixer that finds no cause adds
nothing, so the fixer adds no lock a run did not show. A race can
leave no record a fixer finds, so a found-none record lets a later
passing round close certification rather than hold it open on a cause
no run shows.

## Alternatives

- Add a lock against every test that ran beside the failing one: locks
  grow with every failure, whatever caused it.
- Record a missing lock as a fault of the test, for a test task to
  rewrite: a test task and a verifier per lock, where the lock changes
  no test file.
- Read the failing test alone, with no window: the fixer cannot tell a
  race from an overload, or name the test that disturbed it.
- Reproduce at the machine's current count: a failure that needed the
  round's load may not repeat at another count.
- Hold certification open on a found-none flaky test until its cause
  is found: a race that leaves no record keeps the sprint from
  closing.
