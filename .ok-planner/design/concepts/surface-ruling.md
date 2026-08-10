---
concept: surface-ruling
---

# Surface ruling

## What it is

The surface ruling is the derived, stamped record of a project's
public/private partition: every element the declared enumerators
produced, each classified public or private by applying the surface
guidance, kept together with the cached extraction it was computed
from. It is written only by the audit run, never by hand, and it is a
statement about two anchors — the commit it describes and the guidance
state it was derived from.

## Purpose

The ruling is what makes the partition total and the classification
inspectable: enumeration minus classification must be empty, so an
element nobody ruled is a loud failure rather than an invisible
addition — and the cached extraction lets the next run see what
changed since the last stamp instead of re-judging the whole world.
The two anchors make staleness and ratification pure git questions:
how far has the tree moved, and does the guidance still match what the
ruling applied.

## Boundaries

The ruling is a machinery record: internal, never shipped, and never a
source of truth about intent — intent lives in the guidance. It is not
the documentation catalog, which is produced over the ruling's public
side. See also: `surface-guidance`, `surface-declaration`,
`documentation-corpus`.

## Invariants

- The partition is total: every enumerated element is classified
  public or private, no default exists, and an unclassified element is
  a failure — never "private by omission".
- The ruling carries both anchors — the commit it describes and the
  guidance state it applied — and is regenerated whole by each run;
  nothing edits it in place.
- A classification the guidance does not determine never enters the
  ruling silently: it reaches the owner, and the answer returns as
  guidance.
