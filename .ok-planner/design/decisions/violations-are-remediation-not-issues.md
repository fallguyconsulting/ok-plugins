---
decision: violations-are-remediation-not-issues
---

# Practice violations are work; only ambiguity reaches the intake

## Choice

A site that departs from the practice governing it is remediation work
carried by ordinary planning, never an entry in the issue intake.
Three things from a coverage run become issues instead: a gap, a
collision, and a site whose governing practice could only be
established by tracing beyond the point of use. The escalation flag is
the cost of determining the violation, not the size of the fix.

## Rationale

The intake exists for questions requiring the owner's judgment. A
ruled practice has already had that judgment, so a site that departs
from it poses no question — filing it would flood a judgment queue
with work nobody needs to decide, and the queue would stop meaning
what it means.

Keying escalation to determination cost rather than fix size inverts
the usual instinct, and the inversion is the point. A large but obvious
rewrite needs a worker, not a ruling. A site whose governing practice
can only be established by tracing is a site whose intent is not
legible from the code, and illegibility is precisely what an owner has
to settle. It also asks the reviewer only for something it knows
exactly — how it reached its own conclusion — rather than for a
prediction about effort, which it estimates badly.

## Alternatives

- File every violation as an issue — durable, and it destroys the
  intake's meaning within a run or two.
- Escalate by fix size or estimated risk — matches intuition, and
  rests on an estimate the reviewer is poorly placed to make.
- Let the coverage run fix what it judges straightforward — closes the
  backlog fastest, and puts an unreviewable whole-codebase diff behind
  a judgment the run has no scope to check.
