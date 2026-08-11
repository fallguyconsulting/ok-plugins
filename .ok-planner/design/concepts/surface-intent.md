---
concept: surface-intent
---

# Surface intent

## What it is

The surface intent is a project's single owner-authored document that
captures what its user-facing surface is meant to be. It sits at
`.ok-planner/surface/surface.md`, and it speaks in the terms an owner
uses when they think about the product: which modules, services, or
paths are user-facing at all; which classes of element are public by
default (the CLI verbs, the HTTP routes, the published env vars, the
config keys under a named prefix, the ports the deployment exposes);
and which specific elements depart from the general rules (the two
CLI verbs that stay internal, the one route bound loopback-only).
Prose, with named exceptions where they exist. It is a long-term
artifact: it changes only when the owner edits it, and it never
enumerates specific elements the general rules already cover.

## Purpose

The surface intent is the one place the owner declares what belongs
to the user's field of view. Every downstream question about the
public surface — what the audit's story track drives the released
product through, what the documentation ceremony ships against, which
elements a code reader is meant to treat as part of the contract —
routes back to this document. Its shape earns its keep because it
matches how owners actually think: a small set of general rules with
a small set of specific carve-outs, edited when intent moves, not
per-release. It replaces the earlier declaration-plus-guidance
apparatus that tried to keep intent, taxonomy, and per-kind member
lists on separate ledgers; a single prose document holds all three
and none of them drift against each other.

## Boundaries

The surface intent describes intent, not the element inventory. It
never lists the individual CLI verbs, the individual routes, or the
individual env vars — those are the extraction's job, freshly walked
each audit and named in `surface-extraction`. A rule like "every CLI
verb under `plugins/*/skills/` is public except the `_shared/` bodies"
is intent; a bullet listing 47 verb names by hand is not, and it
would drift the moment a verb is added. The document does not enumerate
"kinds" as a taxonomy either — the extraction discovers what the
codebase actually exposes and groups elements by their natural kind.
The intent covers the exceptions worth naming and the general rules
that account for everything else.

## Invariants

- **Owner-authored.** Only the project owner edits the document. An
  agent proposing a change files an intake issue for the owner to
  rule on and does not touch the file itself.
- **One file per project, in the estate.** The document is committed
  at `.ok-planner/surface/surface.md`. There are no per-kind side
  files, no committed member lists, and no accompanying declaration
  or guidance file — the earlier three-artifact machinery is retired.
- **Prose, general with named exceptions.** The document reads as
  intent: the general rules that cover most elements, and the
  specific carve-outs that depart from them. Enumerating what a rule
  already covers is a form defect, and so is naming an element the
  rules do not settle without ruling it explicitly.
- **Read at the audit's stamped commit, like every other design
  artifact.** The extraction reads the version of the document at
  the commit the audit describes. Nothing tracks staleness against
  the tree.
- **No mid-run walk with the owner.** An extraction that finds
  elements the current document cannot settle files intake issues
  and treats those elements as internal for the run. The owner
  responds on their own time by editing the document; a future run
  reads the edited version. Nothing about the audit blocks on the
  owner's turnaround.
