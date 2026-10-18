---
decision: test-sprints-own-the-tests
---

# Only a test sprint changes a test, and tests run only there or on a person's word

## Choice

Of the suite's runs, only a test sprint adds, edits, or deletes a
test. Every other agent adds no test, edits none, and reads none as
evidence: a sprint's builders, sprint certification, `/converge`, and
every agent outside a run. An agent runs tests only inside a test
sprint, or when a person asks for a run in their own words. Sprint
certification and `/converge` prove behavior with the type checker,
the lint, assertions with messages at the enforcement site, and the
drive, and fix code, never a test.

The lint's test check decides a violation by path and by change
alone: a file whose path matches one of the lint's test-path shapes,
or the paths the project declares, and that git reports as added or
modified against HEAD. No line of any file is read, and a committed
test is never reported. While a test sprint is open, from the base
file its run writes until its completion check writes its mark, the
check allows the edit; a run abandoned before it completes keeps the
check off until the owner archives or deletes it. The check runs in the edit hook, so a write into a test path
outside a test sprint fails in the turn that made it. A test written
with a framework into a product file is not decidable by path;
sprint certification's review reads each such addition in the change
as a breach of this decision. `review checks` refuses a project check
whose command starts a test runner, since it runs on every review
and no person asks for that run. A project may turn the test check
off; the rule then drops from the rules text its agents read.

A test sprint's commit, the one its `closed:` stamp names, is that
run's work: its fixes restore what a story promises, so sprint
planning's reconcile step reads them as work done inside a run, not
out of band.

## Rationale

Suites grew without bound under agents that wrote a test beside every
change, and each test cost more to keep than it returned: a reviewer
rewrote it whenever the function under it changed, and a review spent
rounds judging whether it proved anything. A test still earns its
place where it checks the code against a promise, because it runs the
same check on every later change, at no model cost, against code the
change never touched, where a review reads only the change. Giving
tests one owner bounds them: the test sprint writes each test from a
scenario, and nothing else touches it, so a test changes only when a
promise does. The check reads paths and the change set only, because a
check that reads lines for test-shaped names flags product code whose
names merely look like tests. The owner keeps the right to ask for a
run, so a rule enforced by a hook on every command would block a run
the owner wants.

## Alternatives

- Forbid tests outright, and leave every existing suite in place,
  unread: the earlier rule. Breaks in a change's callers go unseen,
  and a kept suite blocks a removal its tests import, with no step
  that retires it.
- A sprint's builders write the tests their change needs: the suite
  grows with every change, and every test pins the code as one change
  left it.
- A hook that refuses every command that starts a test runner:
  catches the reflex, and also refuses the run a person asks for.
