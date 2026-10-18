---
decision: release-boundaries-bind-changes
---

# Release boundaries bind every planned change and every fix

## Choice

A project declares its release boundaries in one file, each with who
is across it, what crosses it, and where in the tree to look. Stored
state and the public surface are boundaries every project has without
declaring them: the public surface is every element the surface intent
classes as public, with its callers outside the project across it. Every
planned change and every fix keeps each user across a boundary working
unless a ruling allows otherwise. A sprint's implementation notes give
each behavior change one ruling: rewrite, preserve, migrate, or, on the
owner's word alone, rewrite across a boundary. A fix keeps every user
across a boundary working unless a ruling of the sprint in scope allows
the change, and a fix that would break one is declined with a question.
A fix that removes only the harm a defect names keeps a public
element's contract, because no caller may rely on the harm.
The owner is asked only where a change breaks a user across a boundary
and no compatible form of it reaches the outcome.

## Rationale

A user across a boundary does not update when the code does. A change
that reads well in the tree can break a deployed part, an installed
copy, or a project an earlier release trued up, and nothing in the
tree shows it. One list of boundaries lets the planner, the fixer,
and the verifier check the same users. Counting every public element
as a boundary protects its callers outside the project, whatever else
the project declared. Asking only on a break no compatible
form avoids keeps the owner out of every change the rules settle: a
change that adds beside the old behavior, or migrates its users, needs
no ruling from them.

## Alternatives

- A semantic-versioning policy alone — says how a break is announced,
  and says nothing about which users a change breaks or whether a fix
  may break one.
- Count the public surface as a boundary only where the project
  declares it one — leaves a public element's outside callers
  unprotected wherever the owner did not think to declare them.
- Ask the owner about every behavior change across a boundary —
  safest, and it turns every planning session and every fix into an
  interruption the rules could have settled.
