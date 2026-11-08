---
decision: stopped-run-resumes
---

# A sprint or documentation sprint run that stopped resumes where it stopped

## Choice

A sprint or documentation sprint run that stopped resumes when the
owner starts it again. The new session keeps the base commit the run
recorded, and takes up the run's task record where it stopped: the
tasks that closed `done` stay closed, and every other task runs, a
task that closed `blocked`, `partial`, or `disputed` among them (see
also: every-stop-ends-the-goal, sprint-goal-read-from-the-repository).

## Rationale

A run stops on a blocker the owner must clear, such as a credential or
a task that closed blocked twice, and by then the tree holds the run's
own uncommitted work. A run that started over would read that work as
foreign and refuse, or would build again what already landed. Keeping
the recorded base keeps certification reading the whole change from
the commit the run started at, and keeping the task record keeps every
finished task's work and calls. The owner clears the blocker and
starts the same goal again, with no step of their own.

## Alternatives

- A run that stopped starts over from a fresh base: the run's own
  uncommitted work stops it at once, and the owner must commit or
  discard work certification has not judged.
- A run that stopped stays stopped, and the owner archives or deletes
  it: every blocker costs the whole run.
