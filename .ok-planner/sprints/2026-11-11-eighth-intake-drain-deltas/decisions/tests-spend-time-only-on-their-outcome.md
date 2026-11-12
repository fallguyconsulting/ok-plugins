---
decision: tests-spend-time-only-on-their-outcome
---

# A test spends time only on proving its outcome

## Choice

The suite keeps a testing standard beside its events and writing
standards. The always-loaded rules carry its condensed copy in their
Tests section, and the test-writing, verify, and speed prompts
cite it. Its principle: a test spends time only on proving its
outcome.

A test's verdict never waits on elapsed time. A test waits on an event
the product emits, a time control that forces the event, or a clock
the test moves (see also: every-timer-has-a-time-control). The product
takes its clock from outside and emits the events a test waits on.

The standard names the other ways a test wastes time, and the test
plan's review, the test verifier, and the speed reviewer read for
each:

- A costlier reach than the outcome needs. An outcome inside one
  service is tested through that service's own entry point, its
  command, its route, or its exported function, with its clock
  injected. An outcome that crosses services
  is tested on the shared test stack. Only an outcome about bringing
  up a deployment brings one up. A cheaper reach drops the services
  the outcome does not cross, and fakes none it checks.
- Setup a test repeats that it could share safely, such as a sign-in
  or a stack per test, or, where the project has a seed, data the test
  only reads that the seed could hold (see also:
  seed-recommended-never-required).
- A shared resource declared where a cheaper design keeps the test
  isolated (see also: tests-isolated-unless-declared).
- Work the outcome does not need, such as extra devices, records, or
  steps.

When a reader reads a written test for these wastes is a decision of
its own (see also: speed-read-at-three-points).

## Rationale

Each named waste is a finding a reader can confirm. On one project
the first test plan held 505 tests, 224 of them told to poll or wait
under a deadline and about 434 sent through the full stack. Its suite
took three and a half hours per round, and tests on an injected clock
ran eight in four seconds. The wait rules bind product code as much as
tests, and only the always-loaded rules reach the agents that write
product code.

## Alternatives

- A mechanical scan of each test for sleeps and deadline reads:
  patterns per language, and false hits on sleeps against a fake
  clock.
- The wait rules in the test-writing prompts alone: the rules that
  bind product code reach no agent that writes it.
