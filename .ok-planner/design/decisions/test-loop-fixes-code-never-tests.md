---
decision: test-loop-fixes-code-never-tests
---

# A test sprint's loop fixes the code until every test passes, and never edits a test to pass

## Choice

A test sprint runs unattended under `/goal`. Test tasks write,
rewrite, and retire the tests the plan names, from the scenario's
text, through the entry point the plan's reach names. Then one loop runs. The tool runs the
whole suite and records the round. One fix task per failing test
changes the code, and a verifier reads each fix. The tool then reruns
only the tests that failed, and the fixes repeat until those pass.
The tool then runs the whole suite again as the gate: a test that
fails there is a regression a fix caused, and the loop takes it up.
The agent that writes a test is never the agent that fixes code for
it. A fix never changes a test, a support file, or a fixture.

A verifier reads each written test as well as each fix, and sends
back any test or fix whose verdict waits on elapsed time (see also:
tests-spend-time-only-on-their-outcome); a test it sends back goes to
a test task again. It sends a fix back where it checks whether a test
runs, reads a setting only a test sets, treats the test's data as a
special case, hides a failure behind a swallowing catch, a longer
wait, or a blind retry, fakes the effect the test looks for, or
touches a test path. A time control the plan approved is product code
every deployment carries, not a setting only a test sets (see also:
test-sprints-build-approved-time-controls). A fix it sends back is
backed out of the tree before the next attempt starts, so a rejected
change never passes as the tree the next fixer finds. Fixers and
verifiers run one at a time, and each verifier reads its fixer's
change from snapshots taken before and after it.

A run of the suite stops only when no result arrives for the silence
period the project declares, so a hung run ends and a slow test does
not fail on time. Each round records each test's seconds, setup and
teardown included, and lists its slowest tests; the list decides
nothing.

The loop has no cap. It ends when a whole-suite round passes, or when
each failing test needs a promise changed: the code can meet it only
by changing what the design corpus commits to. A verifier that agrees
files an issue for the next `/plan-sprint`, and that test stays
failing. `.ok-planner/bin/tests complete` prints `TESTS COMPLETE` when
every task closed done, no test file stands unclaimed, the latest
whole-suite round ran after the last change, and every test passed or
its failure has an issue.

## Rationale

A test that passed once can pass again, because the scenario it
checks still stands in the corpus, so a loop with no cap has a way to
finish. A cap with a backout, as `/converge` uses, would leave a
regression in place to save a round. A fixer that could edit the test
would make the test agree with the bug. Rerunning only the failing
tests between fixes, with the whole suite at the start and as the
gate, still catches every regression a fix causes, and spends a whole
round only where it decides something; on one project, rerunning the
whole suite after every batch of fixes took ten and a half hours over
three rounds. A test that sleeps passes a verifier that reads only
fixes, so the verifier reads tests too. A silence period stops a hung
run without making elapsed time a test's verdict. Each stop condition
is a count or a pass, so the tool decides completion without a model.

## Alternatives

- A send-back limit with a backout, as `/converge` runs: bounded
  rounds, and a regression the run cannot fix goes back to the owner
  instead of being fixed.
- Fixers may edit a test they judge wrong: every hard regression
  becomes a test edit.
- Stop at the first failing test and ask the owner: the run needs the
  owner, and a test sprint never stops to ask.
- Rerun the whole suite after every batch of fixes: catches a
  regression one batch sooner, and pays a whole round for every batch.
- A time limit per test: fails a slow test on elapsed time, the
  dependence the testing standard forbids in a verdict.
