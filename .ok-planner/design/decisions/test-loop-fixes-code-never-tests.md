---
decision: test-loop-fixes-code-never-tests
---

# A test sprint's loop fixes the code until every test passes, and never edits a test to pass

## Choice

A test sprint runs unattended under `/goal`. Test tasks write,
rewrite, and retire the tests the plan names, from the scenario's
text and the public surface. Then one loop runs: the tool runs every
test, one fix task per failing test changes the code, a verifier reads
each fix, and the whole suite runs again. The agent that writes a test
is never the agent that fixes code for it. A fix never changes a test,
a support file, or a fixture. The verifier sends a fix back where it
checks whether a test runs, reads a test-only setting, treats the
test's data as a special case, hides a failure behind a swallowing
catch, a longer timeout, or a blind retry, fakes the effect the test
looks for, or touches a test path. A fix it sends back is backed out
of the tree before the next attempt starts, so a rejected change never
passes as the tree the next fixer finds. Fixers and verifiers run one
at a time, and each verifier reads its fixer's change from snapshots
taken before and after it.

The loop has no cap. It ends when every test passes, or when a
failing test needs a promise changed: the code can meet it only by
changing what the design corpus commits to. A verifier that agrees
files an issue for the next `/plan-sprint`, and that test stays
failing. `.ok-planner/bin/tests complete` prints `TESTS COMPLETE` when
every task closed done, no test file stands unclaimed, the latest
round ran after the last change, and every test passed or its failure
has an issue.

## Rationale

A test that passed once can pass again, because the scenario it
checks still stands in the corpus, so a loop with no cap has a way to
finish. A cap with a backout, as `/converge` uses, would leave a
regression in place to save a round. A fixer that could edit the test
would make the test agree with the bug. Each stop condition is a count
or a pass, so the tool decides completion without a model.

## Alternatives

- A send-back limit with a backout, as `/converge` runs: bounded
  rounds, and a regression the run cannot fix goes back to the owner
  instead of being fixed.
- Fixers may edit a test they judge wrong: every hard regression
  becomes a test edit.
- Stop at the first failing test and ask the owner: the run needs the
  owner, and a test sprint never stops to ask.
