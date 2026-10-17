---
decision: sprint-goal-read-from-the-repository
---

# A sprint's goal is decided from the repository, never from the session

## Choice

Every sprint carries a goal rule for whatever checker verifies its
completion contract, and that rule reads the repository as it stands
rather than the session's account of the work. One command,
`review certified`, checks the contract's items in the repository and
prints `SPRINT COMPLETE` or `SPRINT NOT COMPLETE` with each failing
item. A checker that runs commands runs it. A checker that reads only
the session decides from the command's latest output there: the
executing session runs the command after it writes the certification's
return into the completion report, and states that stop condition in
its first message. An archived sprint carrying its closing commit
stamp is terminal, and the command says so without checking further.
Where the sprint file sits is no term of the rule: its working path
and the archive satisfy it alike. A sprint whose completion report is
missing or lacks sprint certification's return block is not done. A
stuck defect the return lists, a check that still fails among them, is
the owner's to take up, and holds no term of the contract open.

## Rationale

An earlier session may have done the work, and a term no message
claimed may hold on disk, so a checker that judges the session's prose
reports not-done on a finished sprint and re-runs work that already
landed. The repository is the one place every executor and every
checker sees the same thing. A checker that cannot open a file still
reads a command's output, so one command that reads the repository and
prints a fixed verdict gives every kind of checker the same answer.
A checker handed only the sprint's path guesses the stop condition on
each check, and one guess demands the archive; the session's first
message and the command's verdict name the condition in words it
reads. A stuck defect does not hold the goal open because
certification has already backed out its change, where it had one,
and sent it to the intake: nothing is left in flight for the run to
finish, and a checker that waited on it would wait on the owner's next
planning session. Excluding the file's location keeps archival an
owner act, since a rule that named the archive would press the run to
perform it.

## Alternatives

- Verify completion from the session's prose — the checker sees the
  work as it happened, guesses the stop condition on each check, and
  reports not-done on every sprint finished in an earlier session.
- Hand the checker the whole goal rule in the goal line — the owner
  pastes a long line, and the rule still names no output the checker
  can read.
- Hold the goal open while any stuck defect stands — a definite signal
  to the owner, and the checker then keeps a sprint open whose
  remaining work already waits in the intake.
- Make archival a term of the goal — one condition covers the whole
  close, and the checker then presses the run to perform an act
  reserved for the owner.
