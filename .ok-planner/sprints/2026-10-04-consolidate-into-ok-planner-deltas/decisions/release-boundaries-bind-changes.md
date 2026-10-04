---
decision: release-boundaries-bind-changes
---

# Declared release boundaries bind every planned change and every fix

## Choice

A project declares its release boundaries in one file, each with who
is across it, what crosses it, and where in the tree to look; stored
state is a boundary every project has without declaring it. Every
planned change and every fix keeps each user across a boundary working
unless a ruling allows otherwise. A sprint's implementation notes give
each behavior change one ruling: rewrite, preserve, migrate, or, on the
owner's word alone, rewrite across a boundary. A fix keeps every user
across a boundary working unless a ruling of the sprint in scope allows
the change, and a fix that would break one is declined with a question.
The owner is asked only where a change breaks a user across a boundary
and no compatible form of it reaches the outcome.

## Rationale

A user across a boundary does not update when the code does. A change
that reads well in the tree can break a deployed part, an installed
copy, or a project an earlier release converged, and nothing in the
tree shows it. One declared list lets the planner, the fixer, and the
verifier check the same users. Asking only on a break no compatible
form avoids keeps the owner out of every change the rules settle: a
change that adds beside the old behavior, or migrates its users, needs
no ruling from them.

## Alternatives

- A semantic-versioning policy alone — says how a break is announced,
  and says nothing about which users a change breaks or whether a fix
  may break one.
- Ask the owner about every behavior change across a boundary —
  safest, and it turns every planning session and every fix into an
  interruption the rules could have settled.
