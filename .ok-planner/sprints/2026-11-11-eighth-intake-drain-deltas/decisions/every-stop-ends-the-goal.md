---
decision: every-stop-ends-the-goal
---

# Every stop of a sprint run meets its goal's condition, and is no success

## Choice

A sprint run's goal is met when the run reaches a verdict, and a stop
is a verdict. The goal's condition names three: `review certified`
printing `SPRINT COMPLETE`, the same command printing `SPRINT
STOPPED`, and the run's start check reporting missing a tool that
command needs. Every stop the executor makes before the sprint's
contract holds is such a verdict: a stop before the run files its
first task, a genuine blocker the run meets, and a certification that
leaves the sprint not complete. At each, the session writes a stop
record beside the sprint that names the reason, then runs `review
certified`, which, while the record stands, prints `SPRINT STOPPED`
with that reason, checks nothing else, and says that the goal's
condition is met. Where the start check finds a tool missing, no
command can print that line, so the check's own output is the
verdict. A stop is no success: the run stopped, and the owner takes up
the reason (see also: sprint-goal-read-from-the-repository,
stopped-run-resumes). A documentation sprint's goal follows the same
rule, with its own completion command, its own stop record, its own
start check, and the lines `DOCS COMPLETE` and `DOCS STOPPED`.

## Rationale

A goal's checker answers one question, whether the condition is met,
and the harness clears a goal only on a yes or on the owner's own
clear. A condition that names only the finishing line can never be met
by a stop, whatever the stop's own output says, so the checker sends a
stopped session back to work on every turn. On one project the checker
held a stopped sprint's goal open through ten rounds, though its first
round read the stop record as ending the goal, until the owner cleared
it by hand. A condition that counts the stop as a verdict lets the
checker say yes, and naming the stop as no success keeps a reader from
taking it for done. A stop record in the repository reaches the
checker through the command every checker already reads, so the
verdict still comes from the repository, and the record outlasts the
session that wrote it. A missing tool is the one stop no command can
report, so the start check's own output carries it. A documentation
sprint runs under the same kind of goal and stops the same ways, so it
ends the same way.

## Alternatives

- A condition that names only the completion line, with a stop said to
  end the goal unmet — the checker can judge the condition only met or
  not met, so the goal stays open after every stop.
- The stop step tells the owner to clear the goal by hand — one more
  owner act at every stop, and the session spends turns until the
  owner sees it.
- A stop line the session prints on its own — the checker reads it,
  and the verdict then comes from the session, not the repository.
- End the goal only on a stop before the run starts — a blocker the
  run meets midway still keeps the checker pushing.
