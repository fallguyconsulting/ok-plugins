---
concept: annotation
---

# Annotation

## What it is

An annotation is an in-source marker linking code back to a design-corpus artifact by kind and slug — a concept enforced or expressed, a story's value-delivering site, or a decision embodied. Each annotation marks a load-bearing site, not every file that happens to touch the artifact.

## Purpose

Annotations plus the catalog tables of contents replace an external index: the catalog answers what exists, the annotation grep answers where each artifact is load-bearing. They realize the fixed direction of reference — code cites design, never the reverse — so refactors cannot orphan the model.

## Boundaries

Annotations are the code-side edge of the design corpus (see also: design-corpus). The slug stamped in code is the exact basename of the artifact; paraphrase is dangling. Under the companion lint methodology, annotations survive the no-comments rule as configured citation tags — the same physical lines governed by a second, mechanical resolver (see also: citation-tag). Rollout is incremental by rule: whoever consults an artifact to work on a file leaves the annotation at the most-specific load-bearing site; no bulk greenfield pass exists.

## Invariants

- Every annotation resolves to a live artifact of the named kind; dangling and kind-mismatched annotations are mechanical findings fixed in-cycle.
- An annotation either resolves or should not exist at all.
- The corpus bootstrap introduces no annotations; the convention begins after the durable model is stable.
