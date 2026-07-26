---
concept: design-corpus
aliases:
  - design docs
  - durable design docs
  - the corpus
---

# Design corpus

## What it is

The design corpus is a project's durable, committed model of what it is and what it owes its users, held at a fixed altitude: a catalog of load-bearing nouns (concepts), a catalog of durable user expectations (stories), and a catalog of technical tradeoffs (decisions), plus generated tables of contents over each catalog and a point-in-time discovery scaffold that feeds the initial extraction. It is a source of truth with the same weight as code: it describes the project as it stands, and it is read freely.

## Purpose

The corpus gives every agent and human one stable place to learn a project's identity, vocabulary, and obligations, so that identity does not live in transient conversation, stale specifications, or individual memory. Because code links back to it rather than the reverse, refactors that move files never invalidate the model, and a code path that diverges from a stated boundary is a defect rather than an ambiguity.

## Boundaries

The corpus holds only the general framing: what kinds of things exist, what the product owes users, and which tradeoffs were chosen. Specific interface designs, schemas, grammars, and implementation diagrams are NOT corpus material — they live in code and in sprints (see also: sprint). Open questions about the corpus live in the intake queue, not in artifact bodies (see also: issue). The discovery scaffold inside the corpus directory is point-in-time and exempt from the durable rules. Neighbors: concept-artifact, story-artifact, decision-artifact, catalog-toc, corpus-delta, annotation, proof.

## Invariants

- After bootstrap, the corpus changes only by applying an approved sprint's corpus deltas — never ad hoc.
- The direction of reference is fixed: code cites the corpus via annotations; corpus bodies never cite code locations.
- Artifact bodies are self-contained and current-state only: no journals, no roadmaps, no path citations.
- The presence of the corpus is the gate other planning verbs key on; a project without one is directed to bootstrap first.
- The literal directory name is not load-bearing; the bright line is the altitude of the contents.
