---
concept: issue
status: as-is
aliases:
  - issue row
---

# Issue

## What it is

An issue is anything about the design corpus that requires human judgment to resolve — sloppy, unspecified, unclear, overloaded, conflicting, or vestigial design, a proof whose intent has drifted, or a question deferred during planning. Issues live as rows in the intake queue; an issue's current state is the fold of its rows by stable id, and an open row with no later terminal row is open.

## Purpose

The issue separates judgment from mechanics: anything mechanically fixable is fixed in-cycle by whoever found it and never filed, so a row means "requires owner calibration" by construction. The queue turns scattered design muddiness into a single owner-facing agenda that planning can drain deliberately.

## Boundaries

An issue is a question waiting to reach a sprint — the queue is intake, not a work tracker; nothing is worked or tracked to completion in it. An issue leaves exactly two ways, both owner acts inside the planning ceremony: promoted into a sprint or retired with a reason. After promotion the sprint alone carries the resolution (see also: sprint, plan-a-sprint under stories). The nature of a row is its category; the identity of its writer is its kind — two orthogonal labelings. Mechanical findings are the neighbor that never becomes an issue (see also: finding). The queue's storage shape is a decision (see also: append-only-issue-queue under decisions).

## Invariants

- Only judgment items become issues.
- Ids are stable fingerprints of artifact plus nature — writers fold first and append only genuinely new ids, so re-observation appends nothing.
- Many writers may open; only the planning ceremony terminates.
- Settled means settled: a later sprint never re-opens a promoted issue; a wrong resolution becomes a new issue with its own id.
- Resolution candidates in a row are durable corpus mutations, never file or symbol citations.
