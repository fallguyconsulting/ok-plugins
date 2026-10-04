---
decision: sprint-goal-read-from-the-repository
---

# A sprint's goal is decided from the repository, never from the session

## Choice

Every sprint carries a goal rule for whatever checker verifies its
completion contract, and that rule reads the repository as it stands
rather than the session transcript. The goal is met when the
contract's items verify there, and an archived sprint carrying its
closing commit stamp is terminal — the checker stops. Where the sprint
file sits is no term of the rule: its working path and the archive
satisfy it alike. A sprint whose completion report is missing or
lacks sprint certification's return block is not done. A stuck defect
the return lists is the owner's to take up, and does not hold the goal
open.

## Rationale

An earlier session may have done the work, and a term the transcript
never showed may hold on disk, so a transcript-reading checker reports
not-done on a finished sprint and re-runs work that already landed.
The repository is the one place every executor and every checker sees
the same thing. A stuck defect does not hold the goal open because
certification has already backed out its change, where it had one,
and sent it to the intake: nothing is left in flight for the run to finish, and a checker
that waited on it would wait on the owner's next planning session.
Excluding the file's location keeps archival an owner act, since a
rule that named the archive would press the run to perform it.

## Alternatives

- Verify completion from the session transcript — the checker sees the
  work as it happened, and reports not-done on every sprint finished in
  an earlier session.
- Hold the goal open while any stuck defect stands — a definite signal
  to the owner, and the checker then keeps a sprint open whose
  remaining work already waits in the intake.
- Make archival a term of the goal — one condition covers the whole
  close, and the checker then presses the run to perform an act
  reserved for the owner.
