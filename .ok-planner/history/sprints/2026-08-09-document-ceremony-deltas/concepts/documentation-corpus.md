---
concept: documentation-corpus
---

# Documentation corpus

## What it is

The documentation corpus is the artifact set the documentation ceremony
produces at a release: catalog rows over the declared surface,
assessments, traps, archived experiments, and a small router of
published concepts — all stamped with the release commit they describe.
It is a project's user-facing documentation, produced as a diagnostic
release product rather than as maintained prose.

## Purpose

The corpus gives a consuming agent documentation whose claims are
backed by measurement: structure derived from the same source the code
compiles against, behavior warranted by runs and evidence, silence that
means "your assumption was checked and holds." Producing it fresh at
each release, stamped, replaces the unwinnable job of keeping standing
prose true.

## Boundaries

The documentation corpus is a snapshot, never a source of truth: it
describes the release it is stamped with, and the moving tree is
expected to leave it behind. It is a record in the estate's sense —
out of agent context by default, never consulted to understand the
current tree, never reconciled or refreshed by day-to-day sessions. It
is distinct from the design corpus (the project's durable model, which
feeds it) and from the audit corpus (determinations about support,
which gate it), and unlike either it is also shipped — through a
separate publisher that is not part of the ceremony. See also:
`design-corpus`, `assessment`, `trap`, `experiment`,
`surface-declaration`.

## Invariants

- Every record is a statement about the named release commit; nothing
  tracks staleness and nothing invalidates anything.
- Silence about an assumption means it was measured and held — honest
  only because assessment records attest the measurement.
- Citations resolve at the stamp, serve the reader, and are never
  process inputs.
- The corpus is fully re-derived at every release; the prior published
  corpus is an input to synthesis, never a cache of conclusions.
