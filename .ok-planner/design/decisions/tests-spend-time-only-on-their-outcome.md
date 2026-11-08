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

The standard names the other ways a test wastes time, and the planning
reviewer, the test verifier, and the speed reviewer read for each:

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

A reader reads a written test for these wastes at three points:

- At write time. The test verifier reads each new or rewritten test.
  Its brief gives the test's seconds from its test task's own run, the
  budget's workers, and the resources the test changes and reads.
- In the build stages. Under `testing.enabled` `on`, a speed task
  reads the `testing.slowest` slowest tests of the last whole-suite
  run that hold no speed acceptance at their current test file. Their
  rewrites land before sprint certification starts.
- After a failed whole-suite round. Before the next round runs, a
  speed task reads the `testing.slowest` slowest tests of the failed
  round that hold no speed acceptance at their current test file.
  Their rewrites run in the round that must run anyway.

A speed rewrite that fails returns to its last passing version, and
its send-back stays open for the next sprint to take up. A passing
whole-suite round ends a sprint's speed work, and its seconds feed the
next sprint's ranking.

The ranking orders
the tests by each test's median seconds across the whole-suite rounds
that ran it at its current test file's digest, charged by the schedule
the suite command runs (see also: tests-isolated-unless-declared). A
speed acceptance records that a reader found no waste in a test. It
holds across sprints until the test's own file changes, and a change
to a support file the test lists does not clear it. An accepted test
counts as unreviewed again only where a support file it lists changed
since its acceptance and its median seconds rose. A send-back
settles when the verifier accepts the rewrite.

A speed reviewer may find a test slow because the product is slow. It
then records a product-slow verdict that names the site, what the site
does, how its cost grows, and the cheaper behavior. Where the test
also wastes time of its own, the reviewer records the verdict whose
fix saves more seconds.
The fix loop files a fixer for the site and a verifier, as for a
failing test. The fixer changes the product so the site does only the
work its answer uses, and runs every test that reaches the site. The
verifier sends back a fix that leaves the slow work, drops a promised
outcome, or fails a test that reaches the site. A product-slow verdict
is never a speed acceptance: it settles once its fix is accepted, and
the test then gets a fresh speed read.

The standard names no speed floor. The ranking chooses which tests a
reader reads, and the reader judges the waste. No time budget decides
a verdict.

## Rationale

A suite's speed depends on the product and on the machine it runs on,
so no target speed can be a verdict without tying a pass to the
machine. Each named waste is a finding a reader can confirm, and the
ranking points each sprint's speed task at the largest. On one project
the first test plan held 505 tests, 224 of them told to poll or wait
under a deadline and about 434 sent through the full stack. Its suite
took three and a half hours per round, and tests on an injected clock
ran eight in four seconds. The wait rules bind product code as much as
tests, and only the always-loaded rules reach the agents that write
product code.

Reading each new test as it is written catches its waste while its
writer's brief is still open. The slowest tests no reader has accepted
catch what earlier readers missed, a few each sprint, so the suite
gets faster over the sprints the owner already runs (see also:
story:suite-gets-faster-over-time). A speed read after a failed
round rides the round the fix loop must run anyway, and a failed
rewrite returns to its last passing version, so speed work never costs
a sprint an extra whole-suite round; a speed walk that reruns the whole
suite after every batch until a batch comes back clean pays one round
per batch. Round time moves with machine load: on one project two
rounds ran about 25% slower than the round after them, so a median
moves little where one round's seconds reorder the list. A support
change on that project moved the digests of 1,026 tests whose own
files had not changed, so an acceptance keyed to support files would
send each of them back to a reader; a support change that slows an
accepted test still sends that one test back. A test that is slow because the
product is slow has no cheaper form of its own; a fix to the product
site took one test from 13.4 seconds to 5.9.

## Alternatives

- A round budget the completion check enforces: completion then
  depends on the machine the round ran on.
- A mechanical scan of each test for sleeps and deadline reads:
  patterns per language, and false hits on sleeps against a fake
  clock.
- The wait rules in the test-writing prompts alone: the rules that
  bind product code reach no agent that writes it.
- A speed walk at the end of sprint certification, batch by batch
  until a batch comes back clean: each batch's rewrites cost another
  whole-suite round.
- Rank by one round's seconds: machine load in that round reorders the
  list.
- Clear an acceptance whenever a support file the test lists changes:
  one shared support change sends a thousand accepted tests back to a
  reader.
- A speed floor, such as a time under which a test passes unread:
  ties which tests a reader reads to the machine.
