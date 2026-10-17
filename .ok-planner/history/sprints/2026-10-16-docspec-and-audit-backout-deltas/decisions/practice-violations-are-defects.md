---
decision: practice-violations-are-defects
---

# Practice violations are defects; only ambiguity reaches the owner

## Choice

A site that departs from the practice governing it is a defect. The
accept list names the project's ruled practices among the rules whose
breach it counts. `/converge` fixes a violation in the run that finds
it, or files it as a `category: defect` issue when it lies outside
that run's scope. A defect issue asks for no judgment: the next
`/converge` fixes it. Three things become judgment issues instead: a
gap, a collision, and a site whose governing practice could only be
established by tracing beyond the point of use. Whichever run or
session meets one sends it to the intake as a judgment issue, through that run's gate (see also: intake-writers-are-gated). The escalation flag is
the cost of determining the violation, not the size of the fix.

## Rationale

Judgment issues exist for questions requiring the owner's judgment. A
ruled practice has already had that judgment, so a site that departs
from it poses no question. Filing it as one would flood the owner's
agenda with work nobody needs to decide, and that agenda would stop
meaning what it means. A defect issue keeps the violation on record
until a worker fixes it, and costs the owner nothing to read.

Keying escalation to determination cost rather than fix size inverts
the usual instinct, and the inversion is the point. A large but obvious
rewrite needs a worker, not a ruling. A site whose governing practice
can only be established by tracing is a site whose intent is not
legible from the code, and illegibility is precisely what an owner has
to settle. It also asks the reviewer only for something it knows
exactly — how it reached its own conclusion — rather than for a
prediction about effort, which it estimates badly.

## Alternatives

- File every violation as a judgment issue — durable, and it destroys
  the meaning of the owner's agenda within a run or two.
- Carry violations as remediation for a future sprint's planning —
  keeps the intake clear, and leaves known violations waiting on a
  planning session that has nothing to decide about them.
- Escalate by fix size or estimated risk — matches intuition, and
  rests on an estimate the reviewer is poorly placed to make.
