---
decision: analysis-hunts-until-converged
---

# Analysis hunts each area independently until a hunt adds almost nothing

## Choice

`/converge` in analysis mode cuts the code into file areas by directory
and the public entry points into flow areas. It hunts each area
independently several times: a file area through one lens of the accept
list per hunt, a flow area along each entry point's path. Hunters never
see each other's reports or the defect list. Each area gets at least a
minimum and at most a maximum number of hunts, and between the two it
stops once the latest hunt adds no more new defects than a threshold
allows. For each area the run reports a Chapman capture-recapture
estimate, drawn from the first two hunts, of the defects no hunt has
found yet. A run hunts one slice of the areas whole, and the next run
takes the next slice: areas never hunted first, then areas whose files
changed since their last hunt, then areas hunted longest ago.

## Rationale

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
