---
concept: concept-artifact
status: as-is
aliases:
  - concept
---

# Concept (artifact kind)

## What it is

A concept is the design-corpus artifact kind that defines a load-bearing noun the system traffics in — general and abstract. The bar for existence is that a reviewer reading code which mentions the noun needs a stable definition to know what it means. A concept names what kind of thing exists, never the specific instances that exist now.

## Purpose

Concepts give a project a fixed vocabulary: every agent and reviewer resolves a term to the same definition instead of paraphrasing from prior context. They prevent the drift that occurs when the same noun quietly means different things in different sessions or subsystems.

## Boundaries

A concept owns a definition, its purpose, its boundary against neighboring concepts, its invariants, and its live aliases. It does NOT own instance enumerations — the specific artifacts that satisfy a concept live in decisions (see also: decision-artifact) or in code. It carries no proof; enforcement of its invariants is cited from code via annotations (see also: annotation). Concepts sit beside stories and decisions inside the design corpus (see also: design-corpus, story-artifact).

## Invariants

- One concept per file; one noun per concept.
- A body that enumerates current implementations has descended below concept altitude and fails compliance.
- Aliases list only names that appear live in code or prose; multiple live names for one concept is itself an issue candidate.
- The concept catalog has session-level standing: its table of contents is injected into every session so terms are read before use (see also: catalog-toc).
