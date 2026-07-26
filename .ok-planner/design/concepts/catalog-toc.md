---
concept: catalog-toc
status: as-is
aliases:
  - catalog
  - TOC
---

# Catalog table of contents

## What it is

A catalog table of contents is the generated one-file index beside each durable catalog: an alphabetical list of slugs with one-line self-contained summaries drawn from each artifact's leading line, plus alias parentheticals. It is generated, never hand-edited, and declares so in its own header.

## Purpose

The TOCs are the one-shot-readable form of the corpus: skills and agents learn what artifacts exist without reading every full file, then follow a slug to the full body or grep for its annotation. The concept TOC has extra standing — it is injected into every session so agents read a term's definition before using it.

## Boundaries

A TOC owns discovery of what exists; the artifacts own their definitions (see also: design-corpus). Where an artifact is load-bearing is the annotation's job (see also: annotation). TOC consistency — every bullet matching a live artifact and vice versa, one-liners obeying self-containment — is checked by the corpus audit (see also: corpus-audit under stories). Session delivery belongs to the materialized session hook (see also: session-awareness under stories).

## Invariants

- Generated content only: hand edits are overwritten.
- Summaries obey self-containment: no paths, no external-document references.
- Entries are alphabetical, slug plus a bounded one-sentence summary.
