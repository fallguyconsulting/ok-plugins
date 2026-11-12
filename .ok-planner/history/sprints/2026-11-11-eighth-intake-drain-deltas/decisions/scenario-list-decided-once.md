---
decision: scenario-list-decided-once
---

# The scenario list is committed, and a test's support is decided once

## Choice

The project commits the scenario list, which only the tests tool
writes: each scenario with its source, its outcome, its test's path
and name, its test support files, each shared resource its test
declares it changes and each it reads, and its own silence where its
test has no choice but a longer one; each gap; each program the owner
left unguarded; the open issue a failing scenario waits on; each
story's test stamp; each speed acceptance; the slowest-tests ranking;
each test's `reaches`; and each test file a plan kept. The runtime
parts and the classes that apply to each are part of the same list. A
test file carries no tag: the list maps each scenario to its test, so
the comment rule stays whole.

A story's test stamp is the git blob id of the story's file as a plan
last planned that story's scenarios, so a planner recovers the planned
version and reads how the file differs. A sprint's archive step writes
the list through the tests tool: it stamps each story the sprint
planned whose every planned scenario has its test written, kept, or
retired, or is a gap, and clears the stamp of each other story the
sprint planned. It records the scenarios whose tests the sprint wrote
or kept: a planned new scenario whose test was never written gets no
record, and a scenario planned for a rewrite or a retirement the
sprint never made keeps its earlier record. It also records the speed
acceptances, the ranking, and the `reaches` lists the sprint leaves.

Support is decided once, when the test is written: a failing test
after that is a regression, never evidence that the scenario is
unsupported.

## Rationale

A list generated afresh on every run re-decides support every time,
so a regression could turn into a gap and drop its test. A committed
list fixes each decision where a sprint's plan settled it, and git
versions it like the code it describes. Keeping the map in the list,
not in the test files, leaves the tests free of comments and lets a
runner of any language name its tests its own way. Declaring the
runtime parts in the same list gives the tests one record of what
they must cover.

A test stamp per story lets the owner take stale stories a group at a
time, where one stamp for the whole list would mark every story
current or every story stale at once. A blob id names the planned
version itself, so git returns that version for the planner to read
against the current file. Writing the list at the archive step
records only the tests a closed sprint wrote or kept, and a story with
a planned test left unwritten loses its stamp, so it reads as untested
or stale, and planning offers it where `testing.enabled` is `on` and
`testing.offers` lists that kind. A plan that finds nothing to test in
a story still stamps it, so the story leaves the untested offer and
returns as stale once its file changes: the stamp answers the story
for the version the plan read, and the owner is not asked the same
question every sprint. Keeping the speed acceptances, the ranking, and
`reaches` in the list carries them from one sprint to the next with
the scenarios they describe.

## Alternatives

- Generate the list from the stories on every run: nothing to keep,
  and support is re-judged each time.
- A citation tag in each test file naming its scenario: the lint
  could resolve it, and every test carries a comment the comment rule
  otherwise forbids.
- A corpus kind for runtime parts, changed through sprint deltas: a
  second path that changes one list.
- One stamp for the whole list, at the last close: a sprint that plans
  some stories leaves the rest looking current.
- A digest of the story's file as its stamp: it shows that the file
  changed, and the planner cannot recover the planned version to read
  how.
- A stamped story with no recorded scenario stays untested: a story
  with nothing to test returns in every untested offer.
- Record each story a plan gave no scenario as left without a test:
  the record never clears when the story's file changes, so a changed
  story hides from every offer.
