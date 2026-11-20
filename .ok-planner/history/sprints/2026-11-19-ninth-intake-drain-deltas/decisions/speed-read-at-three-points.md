---
decision: speed-read-at-three-points
---

# A reader reads tests for waste at three points

## Choice

A reader reads a written test for the testing standard's wastes (see
also: tests-spend-time-only-on-their-outcome) at three points:

- At write time. The test verifier reads each new or rewritten test.
  Its brief gives the test's seconds from its test task's own run, the
  budget's workers, and the locks the test holds.
- In the sprint's test stages. Under `testing.enabled` `on`, a speed task
  reads the `testing.slowest` tests the ranking puts first that hold
  no speed acceptance at their current test file (see
  also: speed-ranked-by-median-seconds,
  speed-acceptance-outlives-support-changes). Their rewrites land
  before sprint certification starts.
- After a failed whole-suite round. Under `testing.enabled` `on`,
  before the next round runs, a speed task reads the
  `testing.slowest` tests of the failed round that the ranking puts
  first and that hold no speed acceptance at their current test file.
  Their rewrites run in the round that must run anyway. A round whose
  only failures are lock breaches or a failed setup gets no such
  read.

How a speed send-back ends is a decision of its own (see also:
failed-speed-rewrite-returns-to-its-last-passing-version). A passing
whole-suite round ends a sprint's speed work, and its seconds feed the
next sprint's ranking.

## Rationale

Reading each new test as it is written catches its waste while its
writer's brief is still open. The slowest tests no reader has accepted
catch what earlier readers missed, a few each sprint, so the suite
gets faster over the sprints the owner already runs (see also:
story:suite-gets-faster-over-time). A speed read after a failed round
rides the round the fix loop must run anyway, so it costs no
whole-suite round of its own. A lock breach or a failed setup is a
fault of the suite command or its setup, which no speed rewrite fixes:
on one project a round whose only failures were pairs of tests its
suite command ran together against their declarations filed ten speed
tasks, whose breaches took eighteen reruns to confirm.

## Alternatives

- A speed read after every failed round, whatever failed: a round that
  failed on its locks or its setup sends readers to tests the fault
  did not slow.
