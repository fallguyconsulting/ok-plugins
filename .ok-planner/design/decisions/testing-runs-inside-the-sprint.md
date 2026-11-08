---
decision: testing-runs-inside-the-sprint
---

# Testing runs inside every sprint, under one setting the owner sets

## Choice

Testing is part of every sprint, as far as one required setting asks,
and no ceremony of its own plans or runs tests. `/plan-sprint` plans
the tests the sprint's work needs, and the owner approves them with
the sprint, once. Execution writes the planned tests in test stages
after the code stages they test (see also: test-tasks-own-the-tests).
Sprint certification runs the suite as one of its find sources (see
also: test-loop-fixes-code-never-tests).

The setting, `testing.enabled`, takes one of three states:

- `on`: every sprint plans, writes, and maintains tests. Planning
  re-plans each tested story the sprint's work changes, and proposes
  scenarios for each story the sprint's deltas add; the owner may decline them, and
  the story joins the untested stories. Planning also offers, in
  groups, the kinds of work `testing.offers` lists: stale stories,
  untested stories, legacy test folders, and runtime scenarios. The
  owner takes any group whole, or none (see also:
  scenario-list-decided-once, legacy-suites-sorted-automatically).
- `frozen`: certification runs the existing suite as a find source,
  and its fixers fix what the suite finds. Planning makes no offer, and
  plans only the rewrites and retirements each changed story needs. A
  story the sprint's deltas add gets no tests and joins the untested
  stories for a later sprint under `on`.
- `off`: certification skips the suite. The tests stay in the tree,
  unmaintained.

True-up writes `testing.enabled` into every project, at the project's
former behavior: `on` where an earlier test sprint wrote the scenario
list, `off` everywhere else. A tool that finds the key missing refuses
and names it (see also: settings-have-no-code-defaults). The owner
sets the key through a verb of its own (see also:
testing-set-up-by-its-own-verb). What true-up does with a test sprint
an earlier release left open is a decision of its own (see also:
live-sprints-brought-current-on-true-up).

## Rationale

Tests planned apart from the sprint, on the owner's schedule, fall
behind every sprint that changes a story's behavior. Certification
then runs an old test against new code, and a fixer that may not edit
a test either undoes the sprint's feature or files a false promise
issue. Planning a
story's tests in the sprint that changes the story keeps each test in
step with its promise, and the owner approves the change and its tests
in one sign-off. Offers in groups let a project with many untested
stories reach full coverage one group at a time, in the sprints the
owner chooses, so no single sprint takes it all on. `frozen` gives a
project the suite's guard without the cost of keeping the tests
current.

## Alternatives

- A separate test planning session and test sprint on the owner's
  schedule: tests lag every sprint that changes a story, and a sprint's
  certification meets tests its change already broke.
- Every sprint takes on every untested story: a project's first sprint
  under testing carries the whole suite.
- Two states, `on` and `off`: a project that wants its suite as a
  guard must also pay to keep it current.
