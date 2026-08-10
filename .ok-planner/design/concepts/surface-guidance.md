---
concept: surface-guidance
---

# Surface guidance

## What it is

The surface guidance is a project's owner-maintained prose document
stating how to rule any user-facing element public or private: general
rules at whatever altitude the owner actually thinks — whole modules,
"all REST APIs" — narrowed by specific exceptions down to named
elements. It is the judgment layer of the surface partition, applied
mechanically to every enumerated element, and the one place
classification rationale lives.

## Purpose

An owner cannot sustainably classify elements one by one, and a
classification without recorded rationale decays into folklore.
Guidance prose scales the way the owner thinks — rules first,
exceptions where the rules run out — and makes every derived
classification reproducible: a ruling is legitimate only as an
application of the guidance, so a disagreement is settled by reading
the guidance, never by asking who classified what.

## Boundaries

The guidance says how to rule; the surface declaration's enumerators
say what exists to be ruled; the surface ruling records the result.
The guidance is owner-owned like the declaration, but unlike the
design corpus it legally changes outside sprints: a sprint may change
it deliberately (exposing something previously private), the owner may
edit it when a run opens, and ad hoc edits are legal but stand
unratified until the next run that reads the guidance walks them with
the owner. See also: `surface-declaration`, `surface-ruling`,
`documentation-corpus`.

## Invariants

- Every classification in the ruling is derivable from the guidance;
  an element the guidance cannot settle is walked with the owner, and
  the answer lands in the guidance, never only in the ruling.
- Guidance changes are ratified: a change is either carried by an
  approved sprint or confirmed with the owner at the next run that
  applies the guidance — detected by comparing anchors, never by
  tracked state.
- The guidance is prose for judgment, never an element inventory:
  member lists belong to the enumerators and the ruling.
