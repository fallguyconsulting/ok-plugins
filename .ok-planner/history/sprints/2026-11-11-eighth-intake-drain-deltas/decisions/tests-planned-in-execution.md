---
decision: tests-planned-in-execution
---

# Planning sets a sprint's test scope, and execution plans each test ahead of the build

## Choice

`/plan-sprint` sets the sprint's test scope: which stories get new
tests, revised tests, or retired tests, and which runtime parts the
sprint plans (see also: sprints-plan-what-their-work-reaches,
runtime-parts-planned-without-an-offer). The
sprint records the scope, and the owner approves the scope with the
sprint, not each planned test.

Execution plans each test inside that scope as its first stage, ahead
of the build. Story, runtime, sort, programs, and budget planners read
the sprint's work items and implementation notes beside the code as
it stands; a review reads each planner's items and the plan as a
whole; and the tests tool assembles the plan. Planners read each story
they plan, the code that carries it, and how the story's file differs
from the one its test stamp names, and sort every recorded scenario of
that story. The rules decide a
scenario whose story dropped it, a new one the code supports, a gap,
and a test that only reaches the code a new way. A fix to a planner's
items changes only the scenarios it names, so each scenario no fix
names keeps its id and its outcome.

No step of that stage waits on the owner. Each point at which
detailed planning needs the owner's word becomes a call or an issue:

- A scenario whose outcome the sprint's work changes is rewritten to
  the outcome the sprint states, as a call.
- A scenario whose code the sprint removes while its story still
  stands is retired and recorded as a gap, as a call (see also:
  tests-check-scenarios).
- A planned test the suite command does not run inside its silence
  period is planned in a form the command runs, or its outcome is
  recorded as untested, as a call.
- An entry point no story serves gets an issue that asks the owner
  for the story it serves, or for its record as unguarded, and the
  plan holds no test for it until a story or that record stands.

The completion report lists each call for the owner's veto, and
sprint certification's owner list files each issue for the next
`/plan-sprint` (see also: intake-writers-are-gated). Each time control
the plan finds the product lacks joins the code plan before the build
starts (see also: planned-tests-name-their-waits).

## Rationale

Detailed planning needs the owner's word at four points only: a
program no story serves, a scenario whose outcome the sprint changes,
a scenario whose code it removes, and a test the suite command cannot
run. Planning every test inside `/plan-sprint` holds the owner through
every planner, every review, and every re-plan a finding sends, so
test planning sets how long planning takes. The planners read the work
items and the implementation notes, not the built code, so they need
no session with the owner around them.

Three of the four points have a rule that decides them as the sprint's
approved work leaves them: the sprint states each outcome it changes,
the corpus's scenario rule makes a removed way a gap (see also:
tests-check-scenarios), and a test the command
cannot run is written in a form it runs or left untested. A call
leaves the owner the last word, since a vetoed call becomes an issue
at the close (see also: story:veto-calls-made-in-my-absence). A program no
story serves needs a story or a record that it stays unguarded, which
no call can give, so it becomes an issue. Running the planners ahead
of the build lets the time controls they find join the code stages,
so no test is written to wait on a timer the product cannot force, and
the planners read the tree before any build changes it.

## Alternatives

- Plan every test inside `/plan-sprint`: the owner waits through every
  planner and review for four answers.
- Plan the tests beside the build: the planners read code mid-change,
  and a time control they find lands after the code stages it needed.
- Plan the tests after the build: each time control the plan finds
  costs a second round of code stages.
- Ask the owner each question during execution: the run waits on a
  person (see also: work-items-change-the-product).
- A time-control check of its own ahead of the build, with the
  planners beside it: the check reads what the planners read again.
