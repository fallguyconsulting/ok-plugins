---
decision: tests-isolated-unless-declared
---

# A test is isolated unless it declares a lock on a shared thing

## Choice

A test is isolated by default: it touches only state it created and
named, and it may run beside any other test. A test that sets up,
checks, or changes a shared thing declares `locks`: each a name from
the project's lock list (see also: locks-named-from-a-project-list)
with a mode, `exclusive` or `shared`. Two tests may run at the same
time unless they hold the same lock name and at least one of them
holds it `exclusive`. How the suite command starts a test under its
locks is a decision of its own (see also:
project-owns-its-suite-command).

A test that sets up or checks a shared thing holds its lock
`exclusive`. A test that only changes it, and does not care what
other changers do, holds it `shared`. The tests that watch a
deployment-wide notice hold the notice's lock exclusive, and the
tests that raise the notice hold it shared, so the raisers run side
by side and only the watchers run apart from them.

A test support file may declare locks, and every test that lists the
file as its test support takes them. Where a test and its test
support declare one name, the test holds it exclusive where either
declares it exclusive. The scenario list records each test's locks
and each test support file's locks (see also:
scenario-list-decided-once). Which locks a writer declares up front,
and how the rest are added, is a decision of its own (see also:
locks-grow-from-observed-failures).

## Rationale

Unique names keep one test's data apart from another's, and do
nothing for a thing every test can see, such as a notice the whole
deployment shows. A lock names that thing, and its mode says whether
the test cares what other tests do to it. Two modes let the tests that
only raise a notice share it while the tests that watch it run apart.
Declarations of what a test changes and what it reads sort a test by
what it does to a thing, not by whether its verdict depends on what
others do: on one project of 1,088 tests on 8 workers, `reads` lists
grew from 49 tests to 870, with a median of 21 entries, and two tests
that watch a deployment-wide page notice still failed, since only
about 500 more `reads` entries would have kept the tests that raise it
apart from them. A declaration on a test support file covers every
test that calls its helper, so the helper that applies a formation
declares once what every caller takes.

## Alternatives

- Declare the shared resources a test changes and those it reads, and
  run two tests apart where one changes what the other changes or
  reads: a test that watches an outcome needs a `reads` entry against
  every test that can cause it.
- Group the tests that share a changed resource, and run the groups
  by a schedule form the project records: a group runs its tests one
  after another on one worker, whatever each test cares about.
- Run every test one after another: nothing to declare, and about
  three times the wall time of a round on a suite of a thousand tests.
- Derive each test's reads from what it contacts during a run: a
  measurement to build and keep, and a test that watches a
  deployment-wide output still needs every changer to declare against
  it.
- One full stack per test: isolated, and every test pays a stack's
  start.
- Fixed phases of tests, such as shared, deployment, and disruptive:
  mixes what breaks other tests with what costs memory, and runs every
  disruptive test alone.
- Each project works out isolation for itself: every project meets the
  same failures under its first parallel run.
- Locks declared on each test alone: every test that calls a shared
  helper repeats the helper's declaration, and one that forgets runs
  beside a test it disturbs.
