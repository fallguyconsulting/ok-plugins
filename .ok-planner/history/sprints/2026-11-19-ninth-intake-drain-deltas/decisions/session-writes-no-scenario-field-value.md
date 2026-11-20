---
decision: session-writes-no-scenario-field-value
---

# The orchestrating session writes no field value on a scenario item

## Choice

The session that runs a sprint's test planning applies a fix to a
planner's items itself only where the fix is mechanical: a rename, a
drop, a fold of named scenarios into one, or a wording fix whose new
words the failure or the finding gives (see also:
tests-planned-in-execution). It writes no field value on a scenario
item, its `locks` included, beyond the `id` a rename sets and the body
a fold or a wording fix sets, for a story in the sprint's scope or
outside it. Every lock change goes to an agent task: the test writer
or the flaky fixer makes it, and the story's planner carries it into a
re-plan (see also: locks-grow-from-observed-failures).

## Rationale

A field value such as a lock is a judgment about what a test sets up
or checks, which only an agent that reads the test or its story can
make, so the session applies a fix itself only where the fix is
mechanical, and sends every other fix to such an agent. On one project
the session set 765 declaration fields itself from a
budget task's lists, built from categories of test rather than from
each test's path, and filed 103 more as keep entries for stories
outside the sprint. The first round under them failed 22 tests,
verifiers sent 432 tests back, and about 400 test tasks with their
verifiers, some 38 million tokens, each added one or two names to a
record. A rule that names the values the session leaves alone keeps a
long run from stretching the mechanical fix to cover them.

## Alternatives

- The session applies the declaration changes a planner's note lists:
  the session writes records no agent reviews.
- A declaration task per story outside the sprint's scope, briefed by
  the budget's lists: the lists still come from a search up front,
  which no planner makes (see also: locks-grow-from-observed-failures).
