---
decision: planned-tests-name-their-waits
---

# Each planned test names what it waits on, and a missing time control joins the code plan

## Choice

For each planned test, the sprint's test plan names what the test
waits on: an event the product emits, a time control that forces the
event, or a clock the test moves. Execution plans the tests ahead of
the build (see also: tests-planned-in-execution), and each time
control the plan finds the product lacks joins the code plan as an
addendum: a code stage of its own, with its gate setting where it
forces an event or moves the product's time, recorded as a call the
completion report lists for the owner's veto. A code stage builds it
before the test stages that use it, each that forces an event or
moves time as a gated element (see also:
every-timer-has-a-time-control, gated-elements-stay-internal). Test
stages change no product code. What a fix may change in the product
is the test loop's rule (see also: test-loop-fixes-code-never-tests).

## Rationale

A test whose outcome waits on a timer the product cannot force can
only wait, so a plan that may not add a time control writes slow
tests. A code stage builds each missing time control as any product
code, under the same certification. Building it before the test stages
means no test is written to wait, and one time control serves every
test that meets its timer. A time control that forces an event or
moves time is built as a gated element, which stays internal until a
sprint's surface intent delta names it, so the addendum changes no
surface the owner declared, and the owner's veto at the close still
reaches it.

## Alternatives

- Test stages change no product code, and no plan adds a time
  control: tests wait out every timer.
- Each missing time control a work item the owner approves with the
  sprint: the owner waits through the detailed test plan to approve
  it.
- Fixers add time controls as fixes: a verifier cannot tell a time
  control from a hack without a plan that names it.
- A test task builds the time control its test needs beside the test:
  product code lands in a test stage, outside the code stages'
  certification as code.
- The missing time control waits for a later sprint, and its test
  with it: the story stays untested a sprint longer.
