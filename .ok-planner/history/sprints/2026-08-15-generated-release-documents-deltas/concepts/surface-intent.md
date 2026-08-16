---
concept: surface-intent
---

# Surface intent

## What it is

The surface intent is a project's single prose document that captures
what its user-facing surface is meant to be. It sits at
`.ok-planner/surface/surface.md`, and it speaks in the terms an owner
uses when they think about the product: which modules, services, or
paths are user-facing at all; which classes of element are public by
default (the CLI verbs, the HTTP routes, the published env vars, the
config keys under a named prefix, the ports the deployment exposes);
and which specific elements depart from the general rules (the two
CLI verbs that stay internal, the one route bound loopback-only).
Prose, with named exceptions where they exist. It is the source of
truth for the public surface, produced and maintained in the audit's
**interactive intent stage** at the top of each run — the place
`/audit` walks the owner, and the reason the ceremony is interactive
at all — and freely edited by the owner between audits.

## Purpose

The surface intent is the one place the project declares what belongs
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

- **The owner is the authority.** The audit's interactive intent
  stage co-authors the document with the owner in-session — start
  at classes of element ("every CLI verb is public", "the foobar
  module is user-facing"), name specific exceptions where they
  exist, get more specific only where a class does not have a clean
  rule — and lands what the owner approves. Between audits the
  owner edits the file freely; nothing else writes it.
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
- **The interactive intent stage is the audit's owner walk.** An à
  la carte audit walks the owner nowhere else; when `/document`
  composes the audit, the documentation walk (see also:
  `document-type`) follows the extraction and settles the document
  types before the run goes hands-free. Everything downstream —
  measurement, judging — is autonomous. Elements the extractor still
  finds unclassified after the intent has been landed default to
  internal for the run and are filed as intake issues asking the
  owner to amend the intent; the safety net catches residual drift,
  never substitutes for the interactive stage.
