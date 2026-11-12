---
decision: project-owns-its-suite-command
---

# The project owns its suite run end to end

## Choice

The project declares one suite command as `testing.run` in its
configuration. The command takes a list of tests, each with its path,
its name, and the shared resources it declares, and a path for a
results stream, and runs them however the project's tools allow,
deciding batching and setup and running the number of workers the
test plan names. It writes one result line per test to the stream as
each test finishes. Each line names its test by the path and name the
scenario list records, and carries the test's start and end as the
command's own clock reads them; a line without them still counts (see
also: tests-isolated-unless-declared). In a round that runs to its
end, a planned test the stream never reports reads as failed; a round
stopped early records the tests it never reached as `not run` (see
also: fixes-rerun-the-tests-they-reach). A fixer runs its own test
through the same command, with a list of one. How each run is
recorded is a decision of its own (see also:
sprint-runs-recorded-whole).

## Rationale

A suite command the project owns lets the project share setup and run
tests in parallel with the tools it already uses. A tool that starts
one process per test, one after another, runs shared setup for every
test: on one project such a round of 496 tests was on course to take
about three hours, and a round stopped early records nothing. A line
written as each test finishes lets the tests tool keep what a stopped
round ran. The command alone sees each test start and end, so the
start and the end a line carries come from one clock.

## Alternatives

- A command that runs one test, which the tests tool runs several at
  a time: every test still pays its own setup, and the suite, not the
  project, owns the loop.
- A suite command that writes a standard report the tool parses after
  it exits: a round records nothing until the whole suite exits.
