---
concept: story-artifact
status: as-is
aliases:
  - story
---

# Story (artifact kind)

## What it is

A story is the design-corpus artifact kind that records a durable user expectation — what the product owes its users on an ongoing basis, stated as who needs what and why. The test for story status: years from now, a regression of the capability would be a defect a reasonable user would notice and complain about. Build records, migrations, and one-time changes are not stories.

## Purpose

Stories prevent high-level feature loss when individual tests miss end-to-end regression, and give a third party a single place to read what the product is for. They outlive specs, refactors, and library swaps because they describe the need, never the mechanism.

## Boundaries

A story owns the need, the user-observable acceptance, its falsifier, and the canonical statement of what its proof must exhibit. It does NOT own the delivery surface or any mechanism — those are decision territory (see also: decision-artifact). Two stories describing the same user outcome through different surfaces are one story. Its proof artifacts live in code, linked back by annotation (see also: proof, annotation, falsifier).

## Invariants

- The benefit clause ("so that") is mandatory; a story without one has identified an activity, not a need, and fails compliance.
- A body that prescribes mechanism — libraries, data shapes, algorithms, storage, protocols — fails compliance.
- The value-delivering component named in acceptance is real, never stubbed.
- The proof-intent statement in the story is the protected thing; proof files may change freely while they still satisfy it.
