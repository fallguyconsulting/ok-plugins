---
concept: trap
---

# Trap

## What it is

A trap is an assumption a user would reasonably hold, contradicted by
the product's actual behavior at a release — recorded as the
assumption, the actual behavior, and the evidence that warrants the
contradiction. It is the documentation corpus's statement "your
reasonable expectation is wrong here, and here is what is true
instead."

## Purpose

Traps are the creative core of documentation-as-assessment: the
divergence set between user expectation and product behavior is
precisely the content a user cannot derive from the product's surface
and the content that tests, written from the developer's side, do not
cover. A trap also doubles as a test-gap report — behavior no test
reaches, surfaced with the evidence in hand — making the trap registry
a standing critique of the project's suite.

## Boundaries

A trap is a contradicted *assumption*; a contradicted *promise* (a
story that does not work) is a defect and reaches the issue intake
instead. A trap's warrant is an evidence set produced by reading —
never a failed run, which cannot distinguish a wrong assumption from a
broken probe. A reproduction is corroboration and may honestly be
absent. See also: `assumption`, `assessment`, `experiment`,
`documentation-corpus`.

## Invariants

- Every trap is warranted by an evidence set frozen at the release it
  is stamped with.
- Traps are re-measured at every release: one still contradicted
  reappears; one fixed dissolves into attested silence.
- A trap never rests on a failed run alone.
