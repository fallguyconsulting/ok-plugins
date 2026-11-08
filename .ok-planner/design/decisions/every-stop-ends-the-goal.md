---
decision: every-stop-ends-the-goal
---

# Every stop of a sprint run ends its goal through a stop record

## Choice

Every stop the executor makes before a sprint's contract holds ends
the goal: a stop before the run files its first task, a genuine
blocker the run meets, and a certification that leaves the sprint not
complete. At each, the session writes a stop record beside the sprint
that names the reason, then runs `review certified`, which, while the
record stands, prints `SPRINT STOPPED` with that reason and checks
nothing else. The goal rule names that line beside `SPRINT COMPLETE`,
and the session's first message names both (see also:
sprint-goal-read-from-the-repository). A documentation sprint's goal
follows the same rule, with its own completion command, its own stop
record, and the line `DOCS STOPPED`.

## Rationale

A checker that knows only the finishing line keeps pushing a session
that stopped, and each push spends a turn on work that cannot go on
until the owner acts. A stop record in the repository ends the goal
through the command every checker already reads, so the verdict still
comes from the repository, and the record outlasts the session that
wrote it. A documentation sprint runs under the same kind of goal and
stops the same ways, so it ends the same way.

## Alternatives

- A stop line the session prints on its own — the checker reads it,
  and the verdict no longer comes from the repository.
- End the goal only on a stop before the run starts — a blocker the
  run meets midway still keeps the checker pushing.
- The owner clears the goal by hand at every stop — each stop spends
  turns until the owner sees it.
