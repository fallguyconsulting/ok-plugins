---
decision: rounds-checked-against-the-locks
---

# Each round is checked against the locks its tests hold

## Choice

After each round, the tests tool checks every pair of tests that ran
at the same time against their locks. A pair that held one lock name,
at least one of the two exclusive, is a lock breach, and fails the
round. A test support task of the test stages changes how the suite
command starts the tests. The
tool takes each test's start and end from its result line, as the
suite command's own clock reads them (see also:
project-owns-its-suite-command), and, for a line that carries neither,
takes the test's start as the line's arrival less its seconds and its
end as that arrival. It compares a pair on one clock: the command's,
where both lines carry both, and arrival otherwise.

## Rationale

The suite command starts each test, so only its results show whether
it kept apart two tests that hold one lock. The check reads the times
the results already carry, so a suite command that runs a forbidden
pair fails the round that ran it, where the pair would otherwise show
as a flaky test far from its cause. A start and an end the command
reads from one clock compare two tests on that clock alone. A start
taken as a line's arrival less its seconds subtracts a time on the
command's clock from a time on the tool's: on one project a runner
that wrote a file's result lines together as the file ended, and
overlaps of a few milliseconds, failed two rounds in which every test
passed.

## Alternatives

- Trust the suite command to honor the locks, with no check: a breach
  shows only as a test that fails now and then.
- Take every start as a line's arrival less its seconds: a runner that
  writes its lines late, or a few milliseconds of noise, fails a round
  in which every test passed.
- A tolerance of a set number of seconds on each pair: the check bends
  to fit the noise, and passes a real overlap shorter than the
  tolerance.
