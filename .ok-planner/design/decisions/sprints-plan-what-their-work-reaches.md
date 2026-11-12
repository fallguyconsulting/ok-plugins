---
decision: sprints-plan-what-their-work-reaches
---

# A sprint plans only the stories it takes and the stories its work reaches

## Choice

A sprint plans the tests of each story it takes or must re-plan, and
of each story its deltas add under `testing.enabled` `on`; every other
story's scenarios stand as recorded. Which runtime parts a sprint
plans is a decision of its own (see also:
runtime-parts-planned-without-an-offer).

A sprint takes each story in an untested or stale group the owner
takes at Frame, before any planner runs (see also:
testing-runs-inside-the-sprint,
story:grow-test-coverage-a-part-at-a-time). A story is untested where
it has no recorded scenario, no test stamp, and no recorded answer
that leaves it unguarded, and stale where its file's blob id differs
from its test stamp, or where it has recorded scenarios and no stamp
(see also: scenario-list-decided-once).

A sprint must re-plan each tested story whose behavior its work
changes, whether or not the story's text changes. The code planner
lists the tested stories whose implementation the work items change,
from the `@story:` citations in the files they touch and from each
recorded test whose `reaches` names one of those files, and the notes
review checks that list against the sprint and the code.

A widen reopens stories on the owner's request in any sprint's
planning, one where nothing else changed included. The owner names
stories, or asks for every story an earlier plan's calls left a path
out of; a call is a choice a planner recorded for the owner's veto.
The sprint counts each such story as one it must re-plan. Its planner
reads the story's recorded scenarios and the earlier plan's calls for
it, and adds the scenarios the code supports. Every other scenario
stands as recorded.

## Rationale

Planning only the stories a sprint takes or must re-plan
keeps each sprint's test plan in line with its work. A sprint often
adds a new way to get a story's benefit without changing the story's
text, so a required re-plan follows the code a sprint changes, not
the story's file. Taking the owner's scope before planning puts it in
front of the planner that would otherwise plan against it.

A widen reopens a call only when the owner asks, so each call stands
as the owner's acceptance of the path it left out until the owner
names its story.

## Alternatives

- Plan every story in every sprint: also reaches a story whose
  unannotated code changed, and pays for a whole plan on every change.
- Re-plan only the stories whose text changed: misses the new way to
  a story's benefit that a sprint's code adds.
- Every planner rereads its story's earlier calls in every sprint:
  widens with no request, and reopens every call the owner let stand.
