---
decision: legacy-suites-sorted-automatically
---

# A legacy suite is sorted test by test with no question per test

## Choice

A project's first test sprint sorts every test no scenario claims,
however many there are, without asking the owner about any one test.
Sort agents read the tests in batches, and the rules decide each:

- A test that checks a scenario the plan names, as the scenario
  states it, is adopted and stays as written. A planned new scenario
  a legacy test already checks adopts that test in place of a new one.
  Where two legacy tests check one scenario, the first is adopted and
  the second deleted as a duplicate.
- A test that checks a way a story gives its benefit that no planner
  named becomes a new scenario, and is adopted.
- A test that enforces a written rule on the code's shape, such as a
  module boundary, is ported: a port task rewrites it as a project
  check outside the test paths, adds it to the review loop's `checks`,
  and deletes the test.
- A test that checks the code against itself, or a behavior no story
  or rule names, is an orphan, and is deleted. So is a fixture or a
  data file no kept test uses.

The plan lists every test with its sort, and the owner approves it
once, as any plan. The completion report lists each deletion and each
port for the owner's veto, and git history keeps every deleted test.

## Rationale

A legacy suite can hold thousands of tests, and a question per test
makes the owner do the sort the rules can do. The sort's rules are the
scenario rules every test answers to, so a legacy test faces the same
bar as a new one. A rule a fitness check enforced still needs a check
after the test goes, and the review loop's checks run on every
review, where a test runs only in a test sprint.

## Alternatives

- The owner sorts each test: exact, and impossible at the size of a
  real suite.
- Keep every legacy suite in place, unread: a kept suite blocks a
  removal its tests import, and its fitness checks never run.
- True-up deletes every legacy suite under the owner's one consent:
  the tests that guard a promise go with the rest, and true-up takes on
  judgment about test content.
