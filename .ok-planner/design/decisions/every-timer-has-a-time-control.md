---
decision: every-timer-has-a-time-control
---

# Every timer has a time control

## Choice

Every timer, schedule, and threshold-driven event the product runs has
a time control: a product interface that makes the event happen now,
sets the time the product sees, or sets how long the product waits. A time control takes one of three
forms. A manual trigger runs a timed job at once, such as a refresh or
a maintenance pass. An injectable clock gives the product its time
from outside, so a caller can move it forward. An exposed setting
gives a timer's length or a threshold from configuration (see also:
settings-have-no-code-defaults). A time control is product code that
every deployment carries.

A time control that forces an event or moves the product's time is a
gated element, exposed only while its gate setting is on (see also:
gated-elements-stay-internal). Production configuration sets the gate
off, and a test stack's configuration sets it on. Where a sprint makes
a time control public, the planning session decides that through the
surface intent, as for any element.

The rule binds all code, existing code included, as a coding rule.
The planning session's code planner names the time control for each
timer, schedule, or threshold a work item adds, and the time control
joins that work item. Code that changes behavior because a test is
running stays a defect: a time control passes because every
deployment carries it and an operator decides whether its gate is on.

## Rationale

A test that meets a timer with no time control can only wait it out,
and a suite of such tests spends most of its time waiting. On one
project, tests waited on a 30-second refresh, a 300-second key cache,
and a 180-second silence window, and held 223 sleeps. Once the product
gained manual triggers and an injectable clock, the sleeps fell to 18
and many tests ran three to ten times faster. A time control also
serves an operator who needs a timed job run now. Building each one
when its timer is written costs less than finding it missing when a
test needs it. Gating the forms that force events or move time keeps
them out of reach in production.

## Alternatives

- Shorter timers for tests: the shorter values reach production, or
  differ from it in a way no test exercises.
- Test-only hooks compiled or registered only under test: the product
  under test is not the product that ships.
- Time controls built only when a test sprint needs one: every later
  test sprint pays for the timers earlier sprints wrote.
