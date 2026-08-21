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
unfinished is not done. A run parked at the review-fix loop's cycle
cap awaiting the owner's direction is a legal in-flight state: not
done, not failed, and never grounds for the run to take a cap step on
its own.

## Rationale

An earlier session may have done the work, and a term the transcript
never showed may hold on disk, so a transcript-reading checker reports
not-done on a finished sprint and re-runs work that already landed.
The repository is the one place every executor and every checker sees
the same thing. Naming the parked state keeps the rule from forcing a
verdict it has no basis for: a checker facing a capped run would
otherwise declare failure or invent the owner's decision, and either
destroys the pause the cap exists to create. Excluding the file's
location keeps archival an owner act, since a rule that named the
archive would press the run to perform it.

## Alternatives

- Verify completion from the session transcript — the checker sees the
  work as it happened, and reports not-done on every sprint finished in
  an earlier session.
- Treat a capped run as failed — a definite verdict, at the price of
  discarding an in-flight sprint whose only defect is that it waits for
  its owner.
- Make archival a term of the goal — one condition covers the whole
  close, and the checker then presses the run to perform an act
  reserved for the owner.
