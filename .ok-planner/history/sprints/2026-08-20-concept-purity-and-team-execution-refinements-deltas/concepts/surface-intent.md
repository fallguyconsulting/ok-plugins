---
concept: surface-intent
---

# Surface intent

## What it is

The surface intent is a project's single prose document that captures
what its user-facing surface is meant to be. It speaks in the terms an
owner uses when they think about the product: which modules, services,
or paths are user-facing at all; which classes of element are public
by default; and which specific elements depart from the general rules.
Prose, with named exceptions where they exist. It is the source of
truth for the public surface, produced and maintained in the audit's
**interactive intent stage** at the top of each run and freely edited
by the owner between audits.

## Purpose

The surface intent is the one place the project declares what belongs
to the user's field of view. Every downstream question about the
public surface — what the audit's story track drives the released
product through, what the documentation ceremony ships against, which
elements a code reader is meant to treat as part of the contract —
routes back to this document. Its shape earns its keep because it
matches how owners actually think: a small set of general rules with
a small set of specific carve-outs, edited when intent moves, not
per-release.

## Boundaries

The surface intent describes intent, not the element inventory. It
does not list individual elements — those are the extraction's job,
freshly walked each audit (see also: surface-extraction). The document
does not enumerate "kinds" as a taxonomy either — the extraction
discovers what the codebase actually exposes and groups elements by
their natural kind. The intent covers the exceptions worth naming and
the general rules that account for everything else.
