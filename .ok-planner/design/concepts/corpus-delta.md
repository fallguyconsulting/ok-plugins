---
concept: corpus-delta
aliases:
  - delta
---

# Corpus delta

## What it is

A corpus delta is one unit of change to the design corpus as carried inside a sprint: a final-form artifact body — a complete concept, story, or decision file content — under an operation heading declaring it new, an amendment, or a retirement. Applying a delta IS updating the corpus: the implementer copies the final form into place, or removes the artifact for a retirement.

## Purpose

Deltas make corpus mutation reviewable and mechanical at once. The owner signs off on exact final text during planning; the executor applies it verbatim with zero interpretive latitude, so the corpus after execution matches what was approved, not a paraphrase of it.

## Boundaries

A delta owns the complete post-change state of exactly one artifact. It is NOT a diff, a summary, or a partial edit — summarized or partial deltas are non-compliant. Deltas exist only inside sprints (see also: sprint); the corpus they mutate is the design corpus (see also: design-corpus). Verification that deltas were applied verbatim belongs to the completion contract and the certification gate (see also: completion-contract).

## Invariants

- Every delta is final-form: everything needed to apply it is in the sprint, and applying it requires no consultation of the queue or history.
- A delta that changes a proof's intent must carry the rewritten proof field; the proof modification follows the artifact mutation, never the reverse.
- Retirement via delta is the only sanctioned way an artifact leaves the live corpus.
