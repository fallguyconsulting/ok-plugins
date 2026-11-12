---
decision: legacy-suites-sorted-automatically
---

# A legacy suite is sorted test by test with no question per test

## Choice

Under `testing.enabled` `on`, where `testing.offers` lists legacy
folders, planning offers the test files no
scenario claims in groups, one group per folder, and the owner takes
any group whole (see also: testing-runs-inside-the-sprint). A sprint
sorts every test in the folders the owner takes, however many there
are, without asking the owner about any one test. Every test file
outside the taken folders stays as it stands, for a later sprint that
takes its folder. Every sprint's plan, whatever `testing.offers` lists
and under `on` or `frozen`, records as kept each test file no scenario
claims and no taken folder covers, so `review certified` never refuses
a test file the plan left alone. Sort
agents read the tests in batches, and the rules decide each:

- A test that checks a scenario the plan names, as the scenario
  states it, is an adopted test and stays as written. A planned new scenario
  a legacy test already checks adopts that test in place of a new one.
  Where two legacy tests check one scenario, the first is adopted and
  the second deleted as a duplicate.
- A test that checks a way a story gives its benefit that no planner
  named becomes a new scenario, and is adopted.
- A test that enforces a rule on the code's shape, such as a module
  boundary, is ported: a port task rewrites it as a project check
  outside the test paths, adds it to the review loop's `checks`, and
  deletes the test. A port's check never starts a test runner, since
  the review loop refuses a check that does (see also:
  test-tasks-own-the-tests). Where no project document states the
  rule, the sort names the rule it infers, and the plan lists each
  inferred rule. The next `/plan-sprint` writes each surviving
  inferred rule down as a practice, or retires it with its check.
- A helper, a fixture, or a data file a test that stays uses, adopted
  or kept, is test support, and stays.
- A test that checks the code against itself, or a behavior no story
  names and no rule on the code's shape covers, written or inferred,
  is an orphan, and is deleted. So is a fixture or a
  data file no remaining test uses.

The owner approves the folders a sprint takes, with the sprint, and
execution sorts their tests with no question to the owner (see also:
tests-planned-in-execution). The plan lists every test with its sort. The completion report lists each deletion and
each port for the owner's veto, and git history keeps every deleted
test.

## Rationale

A legacy suite can hold thousands of tests, and a question per test
makes the owner do the sort the rules can do. The sort's rules are the
scenario rules every test answers to, so a legacy test faces the same
bar as a new one. A rule a fitness check enforced still needs a check
after the test goes, and the review loop's checks run on every
review, where tests run only in a sprint's test stages and sprint
certification. A newly adopted
project has few written rules, so porting only written ones would
drop most such checks with no one deciding to; an inferred rule
listed for the owner's veto keeps its check without a question per
test. A sort over every unclaimed file deleted tests in parts of the
code the plan never read, so a sprint sorts only the folders the owner
takes. Recording a kept file in every sprint, whatever the offers, means no
sprint must sort a file to pass certification, and taking
folders as the owner chooses keeps any one sprint from having to take
on the whole suite.

## Alternatives

- The owner sorts each test: exact, and impossible at the size of a
  real suite.
- Keep every legacy suite in place, unread: a kept suite blocks a
  removal its tests import, and its fitness checks never run.
- True-up deletes every legacy suite under the owner's one consent:
  the tests that guard a promise go with the rest, and true-up takes on
  judgment about test content.
- Port only a test whose rule a document states: an old suite's
  unwritten rules lose their checks unseen.
- Hold each test with an unwritten rule until the owner writes or
  drops the rule: legacy tests outlive the sprint that sorts them and
  block the removals they import.
- Sort the whole legacy suite in the first sprint that plans tests:
  one sprint takes on every legacy file, and the sort deletes tests in
  parts of the code no plan read.
