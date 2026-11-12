---
decision: sprint-goal-read-from-the-repository
---

# A sprint's goal is decided from the repository, never from the session

## Choice

Every sprint carries a goal rule for whatever checker verifies its
completion contract, and that rule reads the repository as it stands
rather than the session's account of the work. One command,
`review certified`, checks the contract's items in the repository and
prints `SPRINT COMPLETE`, or `SPRINT NOT COMPLETE` with each failing
item, or, while a stop record stands, `SPRINT STOPPED`. The goal line
planning hands the owner to type carries the goal's whole condition:
the sprint to run, that command, the verdicts that meet it, and, where
the owner wants it, the opt-in to running each drain as a Workflow
script (see also: every-stop-ends-the-goal,
drain-runs-as-a-workflow-script). The executing session need not
restate the condition in any message. A checker that runs commands runs the command.
A checker that reads only the session decides from the command's
latest output there, printed after the owner set the goal: the executing
session runs the command after it writes the certification's return
into the completion report. An archived sprint carrying its closing
commit stamp is terminal, and the command says so without checking
further. Where the sprint file sits is no term of the rule: its
working path and the archive satisfy it alike. A sprint whose
completion report is missing or lacks sprint certification's return
block is not done. A stuck defect the return lists, a check that still
fails among them, is the owner's to take up, and holds no term of the
contract open.

## Rationale

An earlier session may have done the work, and a term no message
claimed may hold on disk, so a checker that judges the session's prose
reports not-done on a finished sprint and re-runs work that already
landed. The repository is the one place every executor and every
checker sees the same thing. A checker that cannot open a file still
reads a command's output, so one command that reads the repository and
prints a fixed verdict gives every kind of checker the same answer.
A checker handed only the sprint's path guesses the stop condition on
each check, and one guess demands the archive. A condition the
executor restates in its first message rests on a step nothing checks,
and a long run's compaction can drop that message: on one project the
executor never stated it, and the checker held a stopped run's goal
open. The goal line is the one text every checker holds for the whole
goal, so a condition written there reaches every check, and the
command's verdict names it in words the checker reads. The cost is a
long line for the owner to type, which planning hands over whole.
Counting only output printed after the owner set the goal keeps a run the
owner resumes in the session that stopped it from ending on the
earlier verdict. A stuck defect does not hold the goal open because
certification has already restored the code its fixes changed, where
they changed any, or named in the issue the state a stuck restoration
left, and sent it to the intake: nothing is left in flight for the run
to finish, and a checker that waited on it would wait on the owner's
next planning session. Excluding the file's location keeps archival an
owner act, since a rule that named the archive would press the run to
perform it.

## Alternatives

- Verify completion from the session's prose — the checker sees the
  work as it happened, guesses the stop condition on each check, and
  reports not-done on every sprint finished in an earlier session.
- The executing session states the condition in its first message —
  the goal line stays short, and nothing checks that the message
  stated it or that compaction kept it.
- Hold the goal open while any stuck defect stands — a definite signal
  to the owner, and the checker then keeps a sprint open whose
  remaining work already waits in the intake.
- Make archival a term of the goal — one condition covers the whole
  close, and the checker then presses the run to perform an act
  reserved for the owner.
