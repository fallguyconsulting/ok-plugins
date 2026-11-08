---
decision: scenario-list-decided-once
---

# The scenario list is committed, and a test's support is decided once

## Choice

The project commits the scenario list, which only the tests tool
writes: each scenario with
its source, its outcome, its test's path and name, its support files,
each shared resource its test declares it changes and each it reads,
and its own silence where its test has no choice but a longer one;
each gap; each program the owner left unguarded; the open issue a
failing scenario waits on; each story's test stamp; each speed
acceptance; the slowest-tests ranking; each test's `reaches`; and each
test file a plan kept. A story's test stamp is the git blob id of the story's file
as a plan last planned that story's scenarios, so a planner recovers
the planned version and reads how the file differs. A test file carries no tag:
the list maps each scenario to its test, so the comment rule stays
whole. A sprint's archive step writes the list through the tests tool: it stamps each story
the sprint planned whose every planned scenario has its test written,
kept, or retired, or is a gap, and clears the stamp of each other
story the sprint
planned. It records the scenarios
whose tests the sprint wrote or kept: a planned new scenario whose test
was never written gets no record, and a scenario planned for a rewrite
or a retirement the sprint never made keeps its earlier record. It also records the
speed acceptances, the ranking, and the `reaches` lists the sprint
leaves.

The project owns its suite run end to end. It declares one suite
command as `testing.run` in its configuration: the command takes a
list of tests, each with its path, its name, and the shared resources
it declares, and a path for a results stream, and runs them however
the project's tools allow, deciding batching and setup and running the
number of workers the test plan names. It
writes one result line per test to the stream as each test finishes.
Each line names its test by the path and name the scenario list
records. In a round that runs to its end, a planned test the stream
never reports reads as failed; a round stopped early records the tests
it never reached as `not run` (see also:
fixes-rerun-the-tests-they-reach).
Each run of the tests tool gives its stream a path of its own and
prints each line as it lands. Every run that names a sprint is
recorded in the sprint's results file, a run of chosen tests included,
as a round of kind `rerun` unless it runs the whole suite. A run
appends its whole round to the results file once, at its end, under a
short lock. A second whole-suite round of one sprint refuses at once
while another is under way: it names that run and its results file,
and tells the user to run again once that run ends. A fixer runs its
own test through the same command, with a list of one.

`/plan-sprint` proposes the list for the stories a sprint takes or
must re-plan, and every other story's scenarios stand as recorded. A
sprint takes each story in an untested or stale group the owner takes
at Frame, before any planner runs (see also:
testing-runs-inside-the-sprint,
story:grow-test-coverage-a-part-at-a-time). A story is untested where
it has no recorded scenario, no test stamp, and no recorded answer
that leaves it unguarded, and stale where its file's blob id differs from its test stamp, or where
it has recorded scenarios and no stamp. A
sprint must re-plan each tested story whose behavior its work
changes, whether or not the story's text changes. The code
planner lists the tested stories whose
implementation the work items change, from the `@story:` citations in
the files they touch and from each recorded test whose `reaches` names
one of those files, and the notes review checks that list against the
sprint and the code. The owner decides each program no story serves.
Planners read each story they plan, the code that carries it, and how the story's
file differs from the one its test stamp names, and sort every recorded scenario of that
story. The rules decide a scenario whose story dropped it, a new one
code supports, a gap, and a test that only reaches the code a new way.
The owner decides each scenario whose outcome changed or whose code is
gone, and approves the whole list once, with the sprint. A fix to the
proposed list changes only the scenarios it names, so each scenario no
fix names keeps its id and its outcome until the owner approves.

A widen reopens stories on the owner's request in any sprint's
planning, one where nothing else changed included. The owner names
stories, or asks for every story an earlier plan's calls left a path
out of; a call is a choice a planner recorded for the owner's veto.
The sprint counts each such story as one it must re-plan. Its planner reads the story's
recorded scenarios and the earlier plan's calls for it, and adds the
scenarios the code supports. Every other scenario stands as recorded.

The runtime parts and the classes that apply to
each are part of the same list. Support is decided once, when the
test is written: a failing test after that is a regression, never
evidence that the scenario is unsupported.

## Rationale

A list generated afresh on every run re-decides support every time,
so a regression could turn into a gap and drop its test. A committed
list fixes each decision where the owner approved it, and git versions
it like the code it describes. Keeping the map in the list, not in the
test files, leaves the tests free of comments and lets a runner of any
language name its tests its own way. A suite command the project owns
lets the project share setup and run tests in parallel with the tools
it already uses. A tool that starts one process per test, one after
another, runs shared setup for every test: on one project such a round
of 496 tests was on course to take about three hours, and a round
stopped early records nothing. A stream read as it lands keeps what a
stopped round ran, and a stream per run keeps two runs' lines apart.
Recording every run that names a sprint, reruns included, gives each
test's standing result a record (see also:
fixes-rerun-the-tests-they-reach). Appending each round whole, at its
run's end, under a short lock, keeps runs side by side from mixing
their lines; a run that crashes loses its own lines and no other's. A
second whole-suite round would repeat the round under way, so it
refuses at once and names the run to wait for. Declaring the runtime parts in
the list the owner approves keeps one approval for what the tests must
cover. Planning only the stories a sprint takes or must re-plan keeps
each sprint's test plan in line with its work. A sprint often adds a
new way to get a story's benefit without changing the story's text, so
a required re-plan follows the code a sprint changes, not the story's
file. A test stamp per story lets the owner take stale stories a group
at a time, where one stamp for the whole list would mark every story
current or every story stale at once. A blob id names the planned
version itself, so git returns that version for the planner to read
against the current file. Writing the list at the archive step records
only the tests a closed sprint wrote or kept, and a story with a
planned test left unwritten loses its stamp, so it reads as untested or
stale, and planning offers it where `testing.enabled` is `on` and
`testing.offers` lists that kind. A plan that finds nothing to test in
a story still stamps it, so the story leaves the untested offer and
returns as stale once its file changes: the stamp answers the story
for the version the plan read, and the owner is not asked the same
question every sprint. Keeping the speed
acceptances, the ranking, and `reaches` in the list carries them from
one sprint to the next with the scenarios they describe. Taking the
owner's scope before planning puts it in front of the planner that
would otherwise plan against it. A widen reopens an approved call
only when the owner asks, so each call stands as the owner's
acceptance of the path it left out until the owner names its story.

## Alternatives

- Generate the list from the stories on every run: nothing to keep,
  and support is re-judged each time.
- A citation tag in each test file naming its scenario: the lint
  could resolve it, and every test carries a comment the comment rule
  otherwise forbids.
- A corpus kind for runtime parts, changed through sprint deltas: a
  second approval path for one list.
- Plan every story in every sprint: also reaches a story whose
  unannotated code changed, and pays for a whole plan on every change.
- Re-plan only the stories whose text changed: misses the new way to
  a story's benefit that a sprint's code adds.
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
- Every planner rereads its story's earlier calls in every sprint: widens
  with no request, and reopens every call the owner approved.
- A command that runs one test, which the tests tool runs several at
  a time: every test still pays its own setup, and the suite, not the
  project, owns the loop.
- A suite command that writes a standard report the tool parses after
  it exits: a round records nothing until the whole suite exits.
- Record only whole-suite rounds: a rerun's result reaches no record.
- Append each line to the results file as it lands: two runs side by
  side mix their lines in one file.
- A second whole-suite round waits for the first: the caller's session
  holds for a whole round to run what that round already runs.
