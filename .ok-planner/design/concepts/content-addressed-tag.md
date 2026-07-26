---
concept: content-addressed-tag
status: as-is
aliases:
  - src-tag
---

# Content-addressed tag

## What it is

A content-addressed tag is an artifact identifier derived from the exact content of the working tree, including uncommitted changes: the same tree yields the same tag on every machine, with no commit required. It is the identity verification paths resolve artifacts by.

## Purpose

Content addressing makes staleness unrepresentable rather than avoided: a mutable tag can silently point at old bits, but a content-addressed tag cannot name anything except the tree it was derived from, and cooperating tools on different machines always agree on it.

## Boundaries

The tag names artifact identity for verification; wiring it into builds and harnesses is deliberately the project's own change, guided by the rules layer, and a materialized tag script nothing consumes is an audit finding (see also: workspace, materialized-artifact). The concrete derivation and its freeze are recorded as a decision (see also: content-addressed-src-tag under decisions).

## Invariants

- Same tree, same tag, everywhere; the derivation changes only with a major version.
- Never a mutable tag in a verification path; harnesses fail loudly when a tag is missing.
