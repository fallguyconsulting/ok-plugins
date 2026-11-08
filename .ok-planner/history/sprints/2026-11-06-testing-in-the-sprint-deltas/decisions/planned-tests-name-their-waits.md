---
decision: planned-tests-name-their-waits
---

# Each planned test names what it waits on, and a missing time control becomes a code work item

## Choice

For each planned test, the sprint's test plan names what the test
waits on: an event the product emits, a time control that forces the
event, or a clock the test moves. A time control the product lacks
becomes an ordinary work item of the sprint, with its gate setting
where it forces an event or moves the product's time, and the owner
approves it with the sprint, in its one approval. A code stage builds
it before the test stages that use it, each that forces an event or
moves time as a gated element (see also:
every-timer-has-a-time-control, gated-elements-stay-internal). Test
stages change no product code. What a fix may change in the product
is the test loop's rule (see also: test-loop-fixes-code-never-tests).

## Rationale

A test whose outcome waits on a timer the product cannot force can
only wait, so a plan that may not add a time control writes slow
tests. Making each missing time control a work item puts the product
change in front of the owner before it lands, and a code stage builds
it as any product code, under the same certification. Building it
before the test stages means no test is written to wait, and one time
control serves every test that meets its timer. Building each that
forces an event or moves time as a gated element keeps the owner's
surface decisions with the planning session.

## Alternatives

- Test stages change no product code, and no plan adds a time
  control: tests wait out every timer.
- Fixers add time controls as fixes: a verifier cannot tell a time
  control from a hack without the owner's approval.
- A test task builds the time control its test needs beside the test:
  product code lands in a test stage, outside the code stages'
  certification as code.
- The missing time control waits for a later sprint, and its test
  with it: the story stays untested a sprint longer.
