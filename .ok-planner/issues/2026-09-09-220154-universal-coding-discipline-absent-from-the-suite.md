---
issue: universal-coding-discipline-absent-from-the-suite
kind: human
category: unspecified
artifacts:
  - concept:cheatsheet
  - story:certify-completion
  - decision:test-quality-by-review
status: open
opened: 2026-09-09T22:01:54Z
---

# The suite states no universal coding discipline, so a builder writes the happy path and the gate finds the rest

## Problem

No suite text tells a builder to write for concurrent callers, a crash
between two writes, a failed I/O call, or a shutdown that overlaps
live work, and a builder on opus at high effort does not do so on its
own. The plumbline cheatsheet's Errors section says to return errors
explicitly and to catch specific exception types, and nothing more.
`{{BUILD-TASK-PROMPT}}` in
`plugins/ok/families/ok-planner/skills/_shared/certification-core.md`
tells a stage to write the code, write story tests, run the tests
that cover what it built, and deliver every promised outcome. Neither
names a hazard the code must survive. The owner assumed this
discipline was the model's default. It is not.

The GridIQ platform's scripted-simulation sprint of 2026-09-08 shows
the cost. Eleven build stages on `ok-opus` produced a change the gate
took eight rounds to certify. The post-mortem checked each of the
gate's 149 findings against the pre-sprint commit: 114 arose from
code the sprint wrote, and 51 of those were bugs in product code.
The 51 split by class:

| Class | Count |
| --- | --- |
| Registry write paths that are not one transaction, or read-then-write with no row lock | 12 |
| Thread and shutdown races in the fleet runner and the Kafka log spine | 10 |
| I/O paths with no handler, or cleanup that runs on one failure path and not another | 10 |
| Duplicated code | 6 |
| File writes that are not crash-safe | 4 |
| Input and CLI semantics | 4 |
| Existing tests the stage did not run | 4 |
| Overly broad logic scope | 1 |

The first three classes are 32 of the 51. None is a wrong expression
or a misread requirement. Each is a place where the writer handled
the sequential case and stopped. The registry class is the clearest.
The same file already held a locked, row-count-checked transition
with a concurrency test, but that idiom was the minority: 125
connection blocks against 26 lock or row-count sites. The builder
imitated the majority pattern. The fix loop repeated the failure: the
round-one fixer added row locks to the roster writes and left the
pause and resume transitions unlocked, and applied a reviewer's
suggested SQL verbatim, which mixed the database clock with the
application clock; round two filed both.

The discipline is universal, not project-specific. A transaction
policy, atomic file replacement, a handler on every I/O call, and
ordered shutdown belong to every codebase, so they do not belong in a
project's own subjects and practices, which the cheatsheet reserves
for what one codebase does. The suite has one ambient layer every
builder reads, the cheatsheet, and one prompt every build stage
follows, and neither carries the discipline. The gate's review, on
sonnet, found every one of these defects, so the suite's only
enforcement of the discipline today is the most expensive stage,
after the code is written.

## Candidates

- A `Hazards` section in the plumbline cheatsheet beside `Errors`,
  stating the universal discipline: a multi-statement write is one
  transaction; a state transition locks its row and checks the row
  count; a file that must survive a crash is written to a sibling and
  replaced; every I/O call has a handler that reports; a shutdown
  drains work already admitted before it stops the thread that serves
  it; a resource opened on a failure path is closed on that path.
- A hazard walk in `{{BUILD-TASK-PROMPT}}`, run over the stage's own
  diff before close: for each write and each I/O call, the builder
  names what happens with two callers, with a kill between
  statements, with a failed call, and with a shutdown during work,
  and fixes what it finds.
- A hazard pass in `{{CODE-REVIEW-BRIEF}}`, so the gate's
  `correctness` fork enumerates write paths and I/O calls as a
  population and reports its count, as the `references` pass does for
  deleted names.
- A statement in the build prompt that a stage runs the full fast
  suite before close, not only the tests that cover what it built,
  so an existing test the change breaks fails in the stage and not in
  the gate.
