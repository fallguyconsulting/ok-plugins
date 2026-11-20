---
decision: sign-off-finds-then-fixes-once
---

# Sign-off checks each delta body against each rule once, then fixes each finding once

## Choice

The planning session's sign-off review is a checklist, not a hunt.
Each delta body the sprint carries gets each rule of the compliance
review that binds its kind, once. The reader records one verdict for
each body and rule: the body passes, or it fails with the finding. A
pair with no verdict is a visible gap: it goes back to a reader once,
and a pair still without a verdict goes on the approval list for the
owner. Each reader takes a set of bodies small enough to read whole,
and records the verdict of every rule for every body in its set.

One merge then folds duplicate findings and sorts them into mechanical
and judgment findings. A judgment finding goes to the owner where only
the owner can decide it, and is otherwise settled as a call the rules
decide. The fixer then fixes each finding once, and each fix changes
only the passage its finding cites. The fixer then runs the same
checklist on each body it changed, and on no other body, and fixes
what that check finds in the same pass. What the fixer's check cannot
settle goes on the approval list. The checklist never runs over the
whole sprint a second time, and no step stops on a cap or a
threshold: the review ends when every pair holds a verdict and every finding is
fixed, settled, or on the approval list.

A delta amended after sign-off, on a kickback or at approval, gets the
checklist for its body and for each body that cites it, then the
merge, the fix, and the fixer's check for what that checklist finds.

## Rationale

On one sprint, sign-off reran one reader over the whole scope after
each fix pass. It ran nine rounds over 46 deltas, and most findings of
rounds six to eight sat in text present since the first draft. On the
next sprint, two open-ended hunts read the same text with no fix
between them: the first raised 59 findings, and the second still
raised 51. The text did not change, so the problems leaked through
the finding, not through the fixing. A hunt has no list of what to
check, so it ends when its reader stops finding, and a reader stops
before the text runs out of problems.

A checklist makes "find every problem once" a finite job that can be
checked. The bodies and the rules are both listed, so the pairs are
too, and a pair with no verdict shows. A reader that must record a
verdict for each pair cannot skip a rule by not thinking of it. One
reader for every rule of a set reads each body once, and the verdict
for each pair, not a split of the rules across readers, shows what
each rule covered. A set small enough to read whole keeps each
reader's attention on its own bodies.

A fix that changes only the passage its finding cites leaves the rest
of its body as the checklist found it. The fixer's check reads every
body a fix changed, the one place a new problem can enter, so the fix
pass needs no second round. The cost: a problem a fix causes in a
body it did not change, such as a body that cites the fixed passage,
meets no reader before the owner's approval. The owner reads what the
fixer's check leaves unsettled before approving, and sprint
certification later compares each applied artifact with its delta
(see also: final-form-deltas). Finding first and fixing after makes
the review finite, as it does for a defect run (see also:
converge-finds-then-fixes).

## Alternatives

- Hunts over each cluster of related deltas, one reader per kind of problem, each hunt told what the earlier hunts found, until a hunt adds few new findings or the cluster reaches a cap on hunts — more readers where the problems are, and each hunt still ends when its reader stops finding, so it needs a cap and a threshold to stop.
- One reader over the whole scope, rerun after each fix pass until a round is clean — one dispatch per round, and on a large sprint the rounds do not end.
- The rules of one set split by kind of problem across several readers — each reader holds fewer rules, and each body and the artifacts it cites are read once per reader.
- A verifier that reads each fix and sends it back until it holds — a second reader on each fix, and a loop that can run without end.
