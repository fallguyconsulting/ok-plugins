---
decision: converge-finds-then-fixes
---

# A defect run finds first, then fixes each defect once and verifies only the fix

## Choice

`/converge` runs two loops, one after the other. The find loop collects
every report its mode produces, and merge agents check each report
against the code and the accept list and fold the real ones into one
defect list. The fix loop has fixers work through that list once. A
verifier then reads only the change each fixer made, against the
defect, the accept list, and the release boundaries, and a fix it sends
back is fixed again. Neither loop re-hunts code a fix changed: the
verifier checks the new code a fix adds, and the next run's hunt reads
it as ordinary code. A defect that reaches the run's limit of
send-backs is stuck, and in every mode its change is restored with
care. A restorer returns the code to the behavior it had before the
stuck defect's fixes: it reads every change made since and keeps each
one another defect needs, by judgment, not by removing lines. A
verifier checks that the prior behavior is back, that every other
accepted fix still works, and that the project's checks pass on the
changed files. A restoration the verifier sends back gets the run's
limit of send-backs; at that limit, the defect's intake issue names
the state the code was left in. The run files the stuck defect as a
judgment issue carrying each fix tried and each verifier's reason. In
sprint certification, a defect whose source is the suite has no limit
of send-backs and never goes stuck: its one way out without a pass is
the promise path (see also: test-loop-fixes-code-never-tests). Every
other defect keeps the limit and its restoration. The run never
waits on the owner while it finds and fixes; how its close takes the
owner's vetoes is a decision of its own (see also:
converge-close-takes-vetoes).

## Rationale

A loop that re-read every file a fix touched found something new in
each round, in the code the last fix had added, so it ran to its cap.
Splitting find from fix makes each loop finite: the find loop ends on
its mode's own terms, and the fix loop ends because each send-back
raises a count that has a ceiling, save for a defect the suite found,
which ends when its test passes or a verifier agrees that only a
promise change meets it. A verifier that reads only the
change costs a fraction of a re-hunt, and it asks the one question a
fix raises: did the change remove the harm without adding one. A defect
whose fixes a verifier rejected up to the limit is no longer mechanical,
because what fixes it is a judgment. A restoration its verifier
accepts returns the code to behavior a verifier accepted before the
stuck defect's fixes, and the owner gets the question with each
attempt and each rejection recorded. Another defect's accepted change
may share lines with the stuck defect's fixes, so a restorer that
reads every change since keeps that change where a mechanical removal
would undo it or fail to apply. A restoration that cannot settle
leaves the tree in a state the owner did not choose, so the intake
issue names that state.

## Alternatives

- Re-read every file a fix touched each round, until a round finds
  nothing — catches a defect a fix causes beyond its own lines, and in
  practice never converges: each round's fixes hand the next round new
  code to fault.
- A cycle cap that stops the run and waits for the owner's direction —
  bounds the loop, and leaves a run or a sprint open on the owner's
  attention instead of ending at a state they can read.
- Keep a stuck defect's last change in the tree, flagged — saves the
  restoration, and leaves code a verifier rejected in the tree the owner
  commits.
- Back a stuck defect's change out mechanically, removing the lines
  its fixes changed — no judgment, and another defect's change may
  share the lines, so the removal undoes that change too or cannot
  apply.
