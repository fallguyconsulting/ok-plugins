---
decision: analysis-hunts-until-converged
---

# Analysis hunts each area independently until a hunt adds almost nothing

## Choice

`/converge` in analysis mode cuts the code into file areas by
directory, and cuts flow areas on each run from the declaring files
the surface intent names: one flow area per declaring file, or per
group of its entry points. A flow hunter reads its declaring file,
finds the entry points itself, follows each request from the handler
that receives it to where its data comes to rest, and judges each path
for the accept list's harms that live on a path. Where the project has
no surface intent, or the intent names no declaring file, the run
hunts file areas only and says so in its return. The run hunts each
area independently several times: a file area through one lens of the
accept list per hunt, a flow area along each entry point's path.
Hunters never see each other's reports or the defect list. Each area
gets at least a minimum and at most a maximum number of hunts, and
between the two it stops once the latest hunt adds no more new defects
than a threshold allows. For each area the run reports a Chapman
capture-recapture estimate, drawn from the first two hunts, of the
defects no hunt has found yet. A run hunts one slice of the areas
whole, and the next run takes the next slice: areas never hunted
first, then areas whose files changed since their last hunt, then
areas hunted longest ago.

## Rationale

A file-area hunter reads one group of files in one folder and cannot
see a path that crosses folders. A flow hunter follows one request
across them, and aims at the harms that live on a path: a user's
mistake with an input, a path that skips the access check, accepted
data dropped or doubled, a failure partway that leaves stored state
half-changed, and an answer or exit code that does not match what the
path did. Cutting flow areas from the declaring files on each run
keeps no list to maintain: the hunter reads the entry points as the
tree has them (see also: surface-members-listed-at-need).

One hunt over an area finds some of its defects and says nothing about
how many it missed. Independent hunts over the same area let the merge
count how many each hunt added that no earlier hunt found, and the
first two give a capture-recapture estimate of what is still missing.
When a new hunt adds almost nothing, another would cost more than it
finds. Stopping area by area spends hunts where the defects are, not
evenly across the tree. Rotating slices bounds one run's cost while
every area is hunted in turn, changed code first.

## Alternatives

- A single pass over every file — cheapest, and its coverage is one
  reader's luck, with no measure of what it missed.
- A fixed number of hunts per area — predictable cost, and it spends
  as much on an area that converged after two hunts as on one still
  yielding defects.
- Hunt the whole tree every run — no rotation to keep, and a large
  tree's run cost grows without bound.
- Cut flow areas from a stored list of entry points — saves the hunter
  one read, and the list drifts from the tree whenever a change adds an
  entry point.
- File areas only, with no flow areas — simpler to cut, and no hunter
  sees a path that crosses folders.
