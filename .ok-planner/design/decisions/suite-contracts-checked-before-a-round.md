---
decision: suite-contracts-checked-before-a-round
---

# The preflight and `/ok-setup`'s runner check run three checks of the suite run

## Choice

The sprint's preflight (see also: tests-isolated-unless-declared) and
`/ok-setup`'s runner check (see also: testing-set-up-by-its-own-verb)
each run three checks of the project's suite run, wherever each of
them runs: the preflight only in a sprint that changes the test
stack's budget, and the runner check whenever `/ok-setup` runs it.
They run the suite command over two
tests of one held group, and check that each test's result line
arrives as that test ends, in the group's order (see also:
project-owns-its-suite-command); a project whose tests declare no held
group skips this check. They run `testing.setup` twice in a row on a
running test stack, and check that the second run leaves the stack
ready. They run `testing.setup` once beside resources it did not
create, and check that it readies the stack and leaves those resources
standing.

## Rationale

Faults in the suite command and its setup fail whole-suite rounds
where neither the product nor a test is at fault, and certification
finds each one a round at a time. On one project a sprint ran seven
whole-suite rounds where its design needs two. A runner that wrote a
file's result lines together as the file ended failed the schedule
check, a setup run again re-created a running stack and cut a
container off its network, and a setup that met two containers the
owner had started on the same network stopped the run for over an
hour. Where the preflight or the runner check runs, two tests and two setups
run against the stack find each of these faults at a cost of minutes,
before a whole-suite round meets it.

## Alternatives

- Document what the suite command and its setup must do in the
  command's guide and add a
  tolerance to the schedule check: nothing checks the guide, and
  certification still meets each fault one round at a time.
- Check the contracts in certification's first round: the fault still
  costs that round.
