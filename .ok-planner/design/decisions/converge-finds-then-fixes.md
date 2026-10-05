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
send-backs is stuck: an agent backs its change out of the tree, and the
run files it as a judgment issue carrying each fix tried and each
verifier's reason. The run never waits on the owner.

## Rationale

A loop that re-read every file a fix touched found something new in
each round, in the code the last fix had added, so it ran to its cap.
Splitting find from fix makes each loop finite: the find loop ends on
its mode's own terms, and the fix loop ends because each send-back
raises a count that has a ceiling. A verifier that reads only the
change costs a fraction of a re-hunt, and it asks the one question a
fix raises: did the change remove the harm without adding one. A defect
whose fixes a verifier rejected up to the limit is no longer mechanical,
because what fixes it is a judgment. Backing its change out keeps the
tree at a state every verifier accepted, and the owner gets the
question with each attempt and each rejection recorded.

## Alternatives

- Re-read every file a fix touched each round, until a round finds
  nothing — catches a defect a fix causes beyond its own lines, and in
  practice never converges: each round's fixes hand the next round new
  code to fault.
- A cycle cap that stops the run and waits for the owner's direction —
  bounds the loop, and leaves a run or a sprint open on the owner's
  attention instead of ending at a state they can read.
- Keep a stuck defect's last change in the tree, flagged — saves the
  backout, and leaves code a verifier rejected in the tree the owner
  commits.
