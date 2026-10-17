---
concept: catalog-toc
aliases:
  - catalog
  - TOC
---

# Catalog table of contents

## What it is

A catalog table of contents is a one-file index beside each durable catalog, listing each artifact's slug with a one-line self-contained entry.

## Purpose

The TOCs are the one-shot-readable form of the corpus: skills and agents learn what artifacts exist without reading every full file, then follow a slug to the full body or to the artifact's annotations.

## Boundaries

A TOC owns discovery of what exists; the artifacts own their definitions (see also: design-corpus, docspec). Where an artifact is load-bearing is the annotation's job (see also: annotation). How a TOC is written and checked is a decision (see also: generated-catalog-tocs under decisions). Delivering a TOC into a session is not the TOC's job (see also: session-awareness under stories).
