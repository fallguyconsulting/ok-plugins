---
issue: root-resolution-markers-not-git
kind: filed
category: inconsistent
artifacts:
  - concept:estate
  - decision:filesystem-discovery-markers
status: open
opened: 2026-08-09T05:14:35Z
---

# Root resolution changed to estate-markers-first; the corpus still commits to nearest-`.git`-ancestor

## Problem

The owner directed a behavior change after a real failure in the field:
running the suite in a subproject of a parent repository whose root does
not want the estate, git-based root resolution escalated to the parent
and put the vendored skills where they were unwanted. The code and skill
prose now resolve the project root as: nearest ancestor of the working
directory (itself included) carrying an estate marker (current or
pre-migration), else the working directory itself — a fresh install
roots where the agent is operating. `.git` plays no part; ok-workspaces
keeps git for its worktree mechanics but resolves its root by markers
like every other family (its `src-tag` still derives the
content-addressed tag from the git tree, by that decision's own
derivation contract). The integration contract's discovery-markers
section now states this rule.

Two corpus artifacts still commit to the old rule: `concept:estate`'s
invariant says the project root "is the nearest git ancestor of the
working directory, falling back to the working directory itself," and
`decision:filesystem-discovery-markers` says roots resolve "as the
nearest git ancestor." Corpus commitments change only by an approved
sprint's deltas, so the code was changed on the owner's direct
instruction and this divergence is filed rather than repaired ad hoc.

## Candidates

- A sprint delta rewrites `concept:estate`'s resolution invariant to the
  marker-first rule (nearest ancestor carrying an estate marker, else
  the working directory; never derived from `.git`) and updates
  `decision:filesystem-discovery-markers` to match.
- Alternatively, hoist the resolution rule wholly into
  `decision:filesystem-discovery-markers` and have `concept:estate`
  reference it, so the rule has exactly one corpus home.
