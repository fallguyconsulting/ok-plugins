---
decision: scenario-list-decided-once
---

# The scenario list is committed, and a test's support is decided once

## Choice

The scenario list lives in `.ok-planner/test-state.json`, which only
the test sprint's tool, `.ok-planner/bin/tests`, writes: each
scenario with its source, its outcome, its test's path and name, its
support files, and each shared resource its test declares it changes,
each gap, each program the owner left unguarded, the open issue a
failing scenario waits on, and the stamp. The stamp is the commit the
last test sprint closed with, and it opens the next window. A test
file carries no tag: the list maps each scenario to its test, so the
comment rule stays whole.

The project owns its suite run end to end. It declares one suite
command as `testing.run` in its configuration: the command takes a
list of tests, each with its path, its name, and the shared resources
it declares, and a path for a results stream, and runs them however
the project's tools allow, deciding batching and setup and running the
number of workers the test plan names. It
writes one result line per test to the stream as each test finishes.
Each line names its test by the path and name the scenario list
records, and a planned test the stream never reports reads as failed.
The tests tool appends each line to the round as it lands, so an
interrupted round keeps every result it saw. A fixer runs its own test
through the same command, with a list of one.

`/plan-tests` proposes the list. Before any planner runs, the owner
sets the scope the plan covers and decides each program no story
serves, and every planner works inside those answers. A plan with no
stamp to start from plans every story. After the first plan, a plan
plans only the stories its run touches: a story that changed, a story
an annotation in a changed file cites, a story whose recorded test
failed in the planning run, and a story whose recorded test the
planning run lists among its slowest. Every other story's scenarios stand
as recorded. Planners read each story they plan, the code that
carries it, and what changed since the stamp, and sort every recorded
scenario of that story. The rules decide a scenario whose story
dropped it, a new one code supports, a gap, and a test that only
reaches the code a new way. The owner decides each scenario whose
outcome changed or whose code is gone, and approves the whole list
once. A fix to the proposed list changes only the scenarios it names,
so each scenario no fix names keeps its id and its outcome
until the owner approves.

A widen run reopens stories on the owner's request, on any run, one
where nothing changed included. The owner names stories, or asks for
every story an earlier plan's calls left a path out of; a call is a
choice a planner recorded for the owner's veto. The run counts each
such story as touched. Its planner reads the story's recorded
scenarios and the earlier plan's calls for it, and adds the scenarios
the code supports. Every other scenario stands as recorded.

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
it already uses; a tool that started one process per test, one after
another, ran shared setup for every test and was on course to take about
three hours for a round of 496 tests on one project, and that round,
stopped early, recorded nothing. A result stream read as it lands keeps what an
interrupted round ran. Declaring the runtime parts in
the list the owner approves keeps one approval for what the tests must
cover. Planning only the stories a run touches keeps a later plan's
cost in line with its change, and a recorded test that fails marks
its story touched, so a regression still reaches a planner. Taking
the owner's scope and program answers before planning puts each
answer in front of the planner that would otherwise plan against it.
A widen run reopens an approved call only when the owner asks, so
each call stands as the owner's acceptance of the path it left out
until the owner names its story.

## Alternatives

- Generate the list from the stories on every run: nothing to keep,
  and support is re-judged each time.
- A citation tag in each test file naming its scenario: the lint
  could resolve it, and every test carries a comment the comment rule
  otherwise forbids.
- A corpus kind for runtime parts, changed through sprint deltas: a
  second approval path for one list.
- Plan every story on every run: also reaches a story whose
  unannotated code changed, and pays for a whole plan on every change.
- Every planner rereads its story's earlier calls on every run: widens
  with no request, and reopens every call the owner approved.
- A command that runs one test, which the tests tool runs several at
  a time: every test still pays its own setup, and the suite, not the
  project, owns the loop.
- A suite command that writes a standard report the tool parses after
  it exits: a round records nothing until the whole suite exits.
