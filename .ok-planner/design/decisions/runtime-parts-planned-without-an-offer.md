---
decision: runtime-parts-planned-without-an-offer
---

# A sprint plans the runtime parts its work reaches, with no offer to the owner

## Choice

Under `testing.enabled` `on`, a sprint plans every runtime part its
work adds, changes, or removes, and every runtime part with no
recorded scenario, and asks the owner nothing about them. Under
`frozen`, it plans the rewrites and retirements each runtime part its
work changes or removes needs. The code planner lists the runtime
parts each work item adds, changes, or removes, and the notes review
checks that list as it checks the tested stories (see also:
sprints-plan-what-their-work-reaches). No standing offer names the
runtime parts (see also: testing-runs-inside-the-sprint).

## Rationale

A sprint's work breaks the runtime tests of a part it changes as it
breaks a story's tests. On one project a sprint moved a client's
sign-ins and removed its stack verbs, and three recorded runtime tests
checked that code. Left unplanned, such tests fail at certification,
whose fixers start from the test being right and work to restore the
behavior the sprint removed. So the runtime parts a sprint's work
reaches are planned as its tested stories are, with no offer the
owner could decline. Planning every part with no recorded scenario
under `on` covers every part in the first sprint after testing turns
on, and each later sprint plans the parts its work reaches and each
new part.

## Alternatives

- Runtime scenarios as an offer the owner takes at Frame: a declined
  offer leaves the runtime tests of a changed part to fail at
  certification.
- Re-plan the runtime parts a sprint changes, and leave the parts with
  no scenario to an offer: a project's uncovered parts wait for the
  owner to ask.
- Name the runtime parts a sprint changes beside the offer: the owner
  still answers a question the sprint's own work settles.
