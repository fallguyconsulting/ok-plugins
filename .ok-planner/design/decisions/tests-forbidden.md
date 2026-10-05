---
decision: tests-forbidden
---

# Agents add no test and ignore the existing suite, blocked at the edit

## Choice

Under the lint methodology, an agent adds no test, edits no test,
runs no test, and reads no test as evidence. An existing suite stays
where it is, never deleted and never consulted. The lint's test
check decides a violation structurally and by change alone: a file
whose path matches one of the lint's test-path shapes, or the paths
the project declares, and that git reports as added or modified
against HEAD. No line of any file is read. A committed test
is never reported, so a whole-tree run and the audit's sweep stay
silent about an existing suite. The check runs in the same binary and
the same edit hook as the comment and citation checks, so a write into
a test path fails in the turn that made it. The fix is to revert the
edit or move the new file out of the test path. Behavior is proven by
the type checker, the lint, assertions with messages at the
enforcement site, and the audit's experiments driven through the
public surface. A test written with a framework into a product file
is not decidable by path; sprint certification's review reads each
such addition in the change as a breach of this decision, a defect it
fixes. A project may turn the test check off; the rule then
drops from the rules text its agents read, and this decision does not
govern that project.

## Rationale

Suites in projects under the suite grew without constraint and cost
more to maintain than they returned: a reviewer rewrote a test
whenever the function under it changed, a story proof timed out on an
unrelated race, and a review spent rounds judging whether a test
proved anything. A test proves only what its author thought to ask, at
the moment they asked it. The audit's experiments prove what a user
can obtain, and an assertion at the enforcement site fails at the
moment the invariant breaks, in production as in development.

The rule holds for the reason the comment rule holds: an agent's
default is to write a test beside every change, and a rule with a
judgment seam is one an agent routes around. The check reads paths
and the change set only, because a check that reads lines for
test-shaped names flags product code whose names merely look like
tests, and a false positive is a seam of its own. The
existing suite is left alone because deleting it is work no sprint
promised and evidence the owner may still want; ignoring it costs
nothing. Blocking at the edit is the only moment the fix is free.

## Alternatives

- A testing standard enforced by review: review judged substance and
  verdict independence per test, and its rounds went to rewriting
  tests the change had made stale.
- Forbidding every test in the tree, existing ones included: a
  deletion backlog on every adopting project, and a sweep that
  removes evidence the owner did not ask to lose.
- Matching test declarations and framework imports by line: flags
  product code whose names look like tests, and every false positive
  is a reason to route around the check.
- A rule with no check: discipline does not compose across sessions;
  checks do.
