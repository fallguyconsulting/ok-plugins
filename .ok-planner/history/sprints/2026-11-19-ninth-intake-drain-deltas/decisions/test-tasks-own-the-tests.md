---
decision: test-tasks-own-the-tests
---

# Only test tasks change a test, and tests run only in a sprint or on a person's word

## Choice

Only the tasks of a sprint's test stages, and the test tasks sprint
certification files, add, edit, or delete a test. Every other
agent adds no test, edits none, and deletes none: a sprint's code
stages, sprint certification's fixers, `/converge` in every other mode,
and every agent outside a run. An agent runs tests only inside a
sprint's test stages and sprint certification, or when a person asks
for a run in their own words, and reads a test as evidence only there.
Outside them, `/converge` proves behavior with the type checker, the
lint, assertions with messages at the enforcement site, and the drive,
and fixes code, never a test. Inside certification, a test a verifier
finds at fault goes to a test task (see also:
fixers-never-edit-tests).

The lint's test check decides a violation by path and by change
alone: a file whose path matches one of the test paths the project
declares in the lint's configuration, and that git reports as added or
modified against HEAD. No line of any file is read, and a committed
test is never reported. Where `testing.enabled` is `on` or `frozen`,
the check allows the edit from a sprint's base file until
`review certified` passes for that sprint; a sprint abandoned before then keeps the
check off until the owner archives or deletes it. True-up closes the
window of each sprint an earlier release left open whose completion
report holds sprint certification's return (see also:
earlier-release-windows-closed-without-a-verdict). The check runs in
the edit hook, so a write into a test path outside a sprint fails in
the turn that made it. Inside the window, `review certified` refuses
a sprint where a code task, a build stage that is no test stage or a
certification fixer, staged a test path, and where a test file stands
that no planned test claims and no plan kept. A test written with a
framework into a product file is not decidable by path; sprint
certification's review reads each such addition in the change as a
breach of this decision. `review checks` refuses a project check
whose command starts a test runner, since it runs on every review and
no person asks for that run. A project may turn the test check off;
the rule then drops from the rules text its agents read.

How sprint planning reads the closing commit of a test sprint an
earlier release closed is a decision of its own (see also:
closing-commit-baseline).

## Rationale

A suite grows without bound under agents that write a test beside
every change, and each such test costs more to keep than it returns: a
reviewer rewrites it whenever the function under it changes, and a
review spends rounds judging whether it proves anything. A test still earns its
place where it checks the code against a promise, because it runs the
same check on every later change, at no model cost, against code the
change never touched, where a review reads only the change. Giving
tests one owner bounds them: a test task writes each test from a scenario its
sprint's test plan names, inside the test scope the owner approved
with the sprint, and nothing else touches it, so a test changes only when a promise or its plan does. The lint
cannot tell a test task from a code task, since both write inside the
sprint's window, so `review certified` reads which task staged each
test path. The check reads paths and the change set only, because a
check that reads lines for test-shaped names flags product code whose
names merely look like tests. The owner keeps the right to ask for a
run, so a rule enforced by a hook on every command would block a run
the owner wants.

## Alternatives

- Forbid tests outright, and leave every existing suite in place,
  unread: breaks in a change's callers go unseen, and a kept suite blocks a removal its tests import, with no step
  that retires it.
- A sprint's builders write the tests their change needs, with no
  plan: the suite grows with every change, and every test pins the
  code as one change left it.
- Only a separate test sprint changes a test: tests lag every sprint
  that changes a story until the owner plans the next test sprint.
- Certification's fixers edit a test they find at fault: no second
  reader checks the product path before the test changes, and every
  hard regression becomes a test edit.
- A hook that refuses every command that starts a test runner:
  catches the reflex, and also refuses the run a person asks for.
