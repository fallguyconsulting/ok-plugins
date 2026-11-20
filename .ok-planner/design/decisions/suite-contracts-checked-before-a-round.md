---
decision: suite-contracts-checked-before-a-round
---

# The preflight and `/ok-setup`'s runner check run three checks of the suite run

## Choice

The sprint's preflight (see also: test-stack-budgeted-as-one-resource)
and `/ok-setup`'s runner check (see also: testing-set-up-by-its-own-verb)
each run three checks of the project's suite run, wherever each of
them runs: the preflight only in a sprint that changes the test
stack's budget, or whose recorded budget no preflight has yet passed,
and the runner check whenever `/ok-setup` runs it.
They run the suite command over two recorded tests that hold one lock
name, at least one of them exclusive, and check that the two did not
run at the same time and that each test's result line arrives as that
test ends (see also: project-owns-its-suite-command); a project whose
recorded tests hold no such pair skips this check. They run
`testing.setup` twice in a row on a running test stack, and check that
the second run leaves the stack ready. They run `testing.setup` once
beside a scratch resource it did not create, and check that it readies
the stack and leaves that resource standing.

Each setup check proves the stack ready by passing a recorded test.
Where the scenario list records no test, both sites run setup twice
and check that each run exits 0, and run setup beside a scratch
resource and check that it exits 0 and that the resource still
stands. Each site skips only the readiness half, which needs a
recorded test to pass, and says so in one line.

## Rationale

Faults in the suite command and its setup fail whole-suite rounds
where neither the product nor a test is at fault, and certification
finds each one a round at a time. On one project a sprint ran seven
whole-suite rounds where its design needs two. A runner that wrote a
file's result lines together as the file ended failed the check of
which tests ran at the same time, a setup run again re-created a
running stack and cut a container off its network, and a setup that
met two containers the owner had started on the same network stopped
the run for over an hour. Where the preflight or the runner check
runs, two tests and two setups run against the stack find each of
these faults at a cost of minutes, before a whole-suite round meets
it. A project's first tested sprint runs its preflight before any
test task records a test. A setup that fails on its second run, or
that stops resources the owner started, is a fault that project meets
then, so both sites run the setup halves that need no test, and the
two sites keep one set of checks.

## Alternatives

- Document what the suite command and its setup must do in the
  command's guide and add a tolerance to the lock check: nothing
  checks the guide, and certification still meets each fault one round
  at a time.
- Check the contracts in certification's first round: the fault still
  costs that round.
- With no recorded test, both sites skip their setup checks whole: a
  fresh project's first sprint meets each setup fault in a whole-suite
  round.
- With no recorded test, the preflight checks setup's exit and the
  scratch resource, and `/ok-setup` skips its checks: the two sites
  drift apart, and the owner who sets testing up meets the faults
  later.
