---
decision: taken-defects-fixed-by-certification
---

# A defect the owner takes into a sprint is fixed by the sprint's certification

## Choice

At planning, the owner picks which open defect issues a sprint takes.
A taken defect gets no work item, no code planning, and no test scope:
the sprint lists it apart from its work items, and the planning
session leaves its issue open and unpromoted. Sprint certification
adds each listed issue to its defect list as a report, as a defect run
takes up the intake's defect issues (see also:
defects-outside-scope-become-defect-issues), counts it within the sprint's
scope wherever its site lies, and fixes and verifies it with the
sprint's other defects. The certification's owner list closes the
issue of each taken defect it verified as fixed, and routes every
other taken defect as it routes any defect issue a run takes up (see
also: intake-writers-are-gated, converge-finds-then-fixes). A defect issue the
owner does not pick stays open for the next defect run or a later
sprint.

## Rationale

The rules already decide a defect's fix. A work item, code planning,
and a build stage spend planning on a fix that certification's fix
loop makes with no planning, and certification already runs a fixer
and a verifier over every defect it finds. Taking a defect into
certification lets the owner have it fixed when the sprint closes,
with no second fix cycle after the sprint, and with no defects run
that also takes up the defects the owner means to hold for later work.
Counting a taken defect within the sprint's scope keeps the merge from
sending it back to the intake as a defect outside the sprint's change.
Leaving its issue unpromoted keeps the issue on the intake's ordinary
path: where the certification cannot fix it, the issue stays open in
the state the run's routes give it, for the next run or sprint. The
cost: the certification's fix loop grows by the taken defects, and a
taken defect's fix is read only by its verifier, not by the sprint's
review.

## Alternatives

- Each taken defect becomes a work item the build lands — the sprint's
  review reads the fix, and every taken defect costs code planning and
  a build stage for a fix the rules already decide.
- Certification takes up every open defect issue — no pick at
  planning, and the owner loses the choice of which defects a sprint's
  certification touches.
- A hold mark on a defect issue, set by the owner, that keeps every
  run and every planning offer off it — holds a defect for later work,
  and adds a state and a verb to every defect issue.
- Promote each taken defect into the sprint — no other run or planning
  session takes it up while the sprint runs, and a defect the
  certification leaves open waits under the sprint's mark and closes as
  promoted when the sprint is archived.
