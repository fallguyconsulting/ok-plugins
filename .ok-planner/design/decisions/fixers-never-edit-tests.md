---
decision: fixers-never-edit-tests
---

# No certification fixer edits a test, and a test at fault goes to a test task

## Choice

A fixer starts from the test being right and follows the evidence. The
agent that writes a test is never the agent that fixes code for it. A
fix never changes a test, a test support file, or a fixture. A lock a
fixer adds changes the scenario list's record of a test, not the test
(see also: locks-grow-from-observed-failures). A fix may change code
to meet what its story promises, to make the code testable, or to make
tests faster, and no fix alters what the design corpus commits to. A
fixer who finds the test, its test support, its fixture, or its data
at fault changes nothing and records the fault, naming every other
test that shares it. The verifier runs the test and reads the product
path. Where the product is right, it accepts the record, and
certification files a test task to rewrite each named test (see also:
test-tasks-own-the-tests). A promise the verifier rejects because the
test is at fault takes the same route, so no fixer is filed for it
again. A fixer records a promise only where the commitment itself
stands in the way (see also: suite-defects-take-no-send-back-limit).

## Rationale

A fixer that could edit the test would make the test agree with the
bug. A test can still be wrong, so a fixer who finds it at fault
records the fault, a verifier checks the product path, and a test task
rewrites the test under its own verifier: the test changes only
through its owner, after a second reader agrees the product is right.
On one project, fixers filed a test at fault as a promise issue
thirteen times, each a ruling the owner did not need to make.

## Alternatives

- Fixers may edit a test they judge wrong: every hard regression
  becomes a test edit.
- A test at fault becomes a promise issue: the owner rules on a
  defect in a test, and a fixer is filed again for each rejected
  promise.
