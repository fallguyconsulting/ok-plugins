---
decision: scenario-list-decided-once
---

# The scenario list is committed, and a test's support is decided once

## Choice

The scenario list lives in `.ok-planner/test-state.json`, which only
the test sprint's tool, `.ok-planner/bin/tests`, writes: each
scenario with its source, its outcome, its test's path and name, and
its support files, each gap, each program the owner left unguarded,
the open issue a failing scenario waits on, and the stamp. The stamp is the commit the last test sprint closed
with, and it opens the next window. A test file carries no tag: the
list maps each scenario to its test, so the comment rule stays whole.
The project declares how one test runs as `testing.run` in its
configuration, a command holding `{path}` and, where the runner needs
it, `{name}`.

`/plan-tests` proposes the list. Planners read each story, the code
that carries it, and what changed since the stamp, and sort every
recorded scenario. The rules decide a scenario whose story dropped
it, a new one code supports, a gap, and a test that only reaches the
code a new way. The owner decides each scenario whose outcome changed
or whose code is gone, and each program no story serves, and approves
the whole list once. The runtime parts and the classes that apply to
each are part of the same list. Support is decided once, when the
test is written: a failing test after that is a regression, never
evidence that the scenario is unsupported.

## Rationale

A list generated afresh on every run re-decides support every time,
so a regression could turn into a gap and drop its test. A committed
list fixes each decision where the owner approved it, and git versions
it like the code it describes. Keeping the map in the list, not in the
test files, leaves the tests free of comments and lets a runner of any
language name its tests its own way. Declaring the runtime parts in
the list the owner approves keeps one approval for what the tests must
cover.

## Alternatives

- Generate the list from the stories on every run: nothing to keep,
  and support is re-judged each time.
- A citation tag in each test file naming its scenario: the lint
  could resolve it, and every test carries a comment the comment rule
  otherwise forbids.
- A corpus kind for runtime parts, changed through sprint deltas: a
  second approval path for one list.
