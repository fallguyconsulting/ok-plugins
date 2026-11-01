---
decision: test-sprints-build-approved-time-controls
---

# A test sprint builds the time controls the owner approves, before its tests

## Choice

For each planned test, the test plan names what the test waits on: an
event the product emits, a time control that forces the event, or a
clock the test moves. A time control the product lacks becomes a time
control item in the plan, with its gate setting where it forces an
event or moves the product's time, and the owner approves the items
with the plan, in its one approval. The test sprint builds every time
control item as product code before any test task runs, each that
forces an event or moves time as a gated element (see also: every-timer-has-a-time-control,
gated-elements-stay-internal). Outside a time control item, a test
never changes product code to cause its condition, and a fix changes
code only so it does what the scenario says.

## Rationale

A test whose outcome waits on a timer the product cannot force can
only wait, so a test sprint that may not add a time control writes
slow tests. Listing each time control in the plan puts the product
change in front of the owner before it lands. Building them first
means no test is written to wait, and one time control serves every
test that meets its timer. Building each that forces an event or moves time as a gated element
keeps the
owner's surface decisions with the planning session.

## Alternatives

- A test sprint changes no product code: its tests wait out every
  timer.
- Fixers add time controls as fixes: a verifier cannot tell a time
  control from a hack without the owner's approval.
- Each missing time control goes to a regular sprint first: the test
  sprint waits on another planning session.
