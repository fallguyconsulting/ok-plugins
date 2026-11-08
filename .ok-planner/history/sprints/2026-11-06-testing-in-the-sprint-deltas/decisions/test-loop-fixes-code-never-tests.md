---
decision: test-loop-fixes-code-never-tests
---

# Sprint certification fixes the code until the suite passes, and no fixer edits a test

## Choice

Sprint certification runs the project's suite as a find source, beside
the review passes, the build's noticed defects, the project's checks,
and the drive, where `testing.enabled` is `on` or `frozen` (see also:
testing-runs-inside-the-sprint). The first whole-suite round runs once
the build's stages close. Each failing test, and each leftover count
that grew, files a report, and the merge folds every report into the
one defect list (see also: converge-finds-then-fixes).

Each failing test runs alone before a fixer is filed for it. A failure
files the fixer. A pass counts as fixed only where a change since the
test's failing round reached the test. Where `testing.reaches` names
`files` or `folders`, a change reaches each test the verifier's rerun
rule reruns after that change (see also:
fixes-rerun-the-tests-they-reach). Under `none`, a pass counts as
fixed where any fix landed since the failing round. A pass with no
reaching change goes to the flaky route: a flaky test is broken until
its cause is found, and no fixer records it as passing as the tree
stands. Its fixer reads the round's window
and the tests that failed with it, reads the test stack's logs for
that window, reproduces the failure at the round's worker count, and
routes the cause: the product failing under load takes a product fix;
tests that share state or timing take a missing declaration of a
resource the test changes or reads, or the test-at-fault route below;
a test that leaves something behind takes a count the project's
leftover command prints (see also: tests-isolated-unless-declared).

A fixer starts from the test being right and follows the evidence. The
agent that writes a test is never the agent that fixes code for it. A
fix never changes a test, a support file, or a fixture. A fix may
change code to meet what its story promises, to make the code
testable, or to make tests faster, and no fix alters what the design
corpus commits to. A fixer who finds the test, its support, its
fixture, or its data at fault changes nothing and records the fault,
naming every other test that shares it. The verifier runs the test and
reads the product path. Where the product is right, it accepts the
record, and certification files a test task to rewrite each named
test (see also: test-tasks-own-the-tests). A promise the verifier
rejects because the test is at fault takes the same route, so no fixer
is filed for it again. A fixer records a promise only where the
commitment itself stands in the way.

Every fix in certification, whatever its source, passes one verifier.
It checks that the fix adds no harm the accept list names, brings
along every caller of a contract it changes, changes no behavior
across a release boundary without a ruling, and passes the project's
checks on the changed files. It sends a fix back where the fix checks
whether a test runs, reads a setting only a test sets, treats the
test's data as a special case, hides a failure behind a swallowing
catch, a longer wait, or a blind retry, fakes the effect the test
looks for, touches a test path, or waits on elapsed time (see also:
tests-spend-time-only-on-their-outcome). A time control a sprint's
work item built is product code every deployment carries, not a
setting only a test sets (see also: planned-tests-name-their-waits).
The verifier reruns the tests the fix reaches (see also:
fixes-rerun-the-tests-they-reach). A fix the verifier sends back is
fixed again in `/converge`'s shape: the next fixer starts from the code
as it stands and reads the verifier's reason, and each verifier reads
its fixer's change as `/converge`'s verifiers do (see also:
converge-finds-then-fixes). A confirm run reruns the fixed test for
each suite defect.

A defect whose source is the suite has no cap on send-backs and never
goes stuck. Its one way out without a pass is the promise path: the
code can meet the test only by changing what the design corpus
commits to. A verifier that agrees records its agreement, and the run's owner
list files the issue for the next `/plan-sprint` (see also:
intake-writers-are-gated). That test stays failing. Every other defect keeps
the run's limit of send-backs and its restoration (see also:
converge-finds-then-fixes).

Once no defect stands open, certification runs the whole suite once
more. Each failing test files a report, and the fix loop resumes. This
repeats until a whole-suite round passes after the last change, or
each failing test carries a verifier's recorded agreement on the
promise path. The review passes,
the checks, and the drive do not run again, so only test failures
reopen the loop. A sprint whose first whole-suite round passes runs
the suite once.

A run of the suite stops only when no result arrives for the silence
period the project declares, so a hung run ends and a slow test does
not fail on time. Each round records each test's seconds, setup and
teardown included. Which tests a reader reads for speed, and when, is
the testing standard's decision (see also:
tests-spend-time-only-on-their-outcome).

Where `testing.enabled` is `on` or `frozen`, `review certified`
refuses a sprint whose latest whole-suite round ran
before its last change, or in which a test failed with no held promise
issue, or with a speed send-back that neither settled nor returned to
its last passing version.

## Rationale

A test that passed once can pass again, because the scenario it
checks still stands in the corpus, so a loop with no cap has a way to
finish. A cap with a restoration, as certification's other defects take,
would leave a regression in place to save a round. A fixer that could
edit the test would make the test agree with the bug. A test can still
be wrong, so a fixer who finds it at fault records the fault, a
verifier checks the product path, and a test task rewrites the test
under its own verifier: the test changes only through its owner, after
a second reader agrees the product is right. On one project, fixers
filed a test at fault as a promise issue thirteen times, each a ruling
the owner did not need to make. Running a failing test alone before a
fixer is filed spends a fixer only on a failure that repeats; on that
project, 444 of the failures rerun before a fixer passed. A test that
fails in a round and passes alone still has a cause, such as load,
shared state, or a leak, and that cause fails a later round until it
is found. Rerunning only the tests a fix reaches, with the whole suite
at the start and as the final round, still catches every regression a
fix causes, and spends a whole round only where it decides something;
on one project, rerunning the whole suite after every batch of fixes
took ten and a half hours over three rounds. One verifier holds every
fix to one bar, whatever found its defect. A sent-back suite fix takes
`/converge`'s shape, so certification runs one fix loop for every
defect, and the verifier's reason carries what the rejected change got
wrong to the next fixer. The review passes, the
checks, and the drive read the change once, and running them again
would re-hunt code a fix changed. A silence period stops a
hung run without making elapsed time a test's verdict. Each stop
condition is a count or a pass, so `review certified` decides
completion without a model.

## Alternatives

- A send-back limit with a restoration for suite defects, as for the
  others: bounded rounds, and a regression the run cannot fix goes
  back to the owner instead of being fixed.
- Fixers may edit a test they judge wrong: every hard regression
  becomes a test edit.
- A test at fault becomes a promise issue: the owner rules on a
  defect in a test, and a fixer is filed again for each rejected
  promise.
- File a fixer for each failing test of the round, with no rerun: a
  fixer is spent on each failure that does not repeat.
- Count a test that passes alone as passing: a flaky test's cause
  stays in the tree and fails a later round.
- Stop at the first failing test and ask the owner: the run needs the
  owner, and certification never stops to ask.
- Rerun the whole suite after every batch of fixes: catches a
  regression one batch sooner, and pays a whole round for every batch.
- Run the review passes, the checks, and the drive again after the
  final round's fixes: re-hunts code a fix changed.
- A time limit per test: fails a slow test on elapsed time, the
  dependence the testing standard forbids in a verdict.
- Back a sent-back fix out of the tree before the next attempt starts:
  no rejected change stands in the tree the next fixer finds, and the
  suite's defects take a fix shape `/converge`'s other defects do not,
  where the verifier's reason already tells the next fixer what the
  rejected change got wrong.
- Fixers and verifiers one at a time, each verifier reading its
  fixer's change from snapshots taken before and after it: each
  verifier sees one change alone, and a round with many failing tests
  waits for every fix in turn.
