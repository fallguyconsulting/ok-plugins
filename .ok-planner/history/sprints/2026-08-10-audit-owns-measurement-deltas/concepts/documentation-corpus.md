---
concept: documentation-corpus
---

# Documentation corpus

## What it is

The documentation corpus is the publishable artifact set the
documentation ceremony produces at a release: catalog rows over the
ruled public surface, assessments, traps, and a small router of
published concepts — all stamped with the release commit they
describe. It is a project's user-facing documentation, produced as a
measured release product rather than as maintained prose, and it
speaks entirely in the user's vocabulary. The ceremony that produces
it measures nothing: the corpus is constructed from the audit's
records — catalog rows projected from the ruling's public side,
assessments from the story and assumption determinations, the trap
registry from the assumption dispositions.

## Purpose

The corpus gives a consuming agent documentation whose claims are
backed by measurement: structure enumerated from the same release the
claims describe, behavior warranted by runs driven through the public
surface, silence that means "your assumption was checked and holds."
Producing it fresh at each release, stamped, replaces the unwinnable
job of keeping standing prose true.

## Boundaries

The documentation corpus is a snapshot, never a source of truth: it
describes the release it is stamped with, and the moving tree is
expected to leave it behind. It is a record in the estate's sense —
out of agent context by default, never consulted to understand the
current tree, never reconciled or refreshed by day-to-day sessions.
It is the publishable side of a vantage split: the verification-layer
records that make it honest — the audit's determinations, the surface
ruling, the experiment archive and evidence sets — stay internal and
cite the tree freely, while the corpus itself is shipped through a
separate publisher that is not part of the ceremony. It is distinct
from the design corpus (the project's durable model, which feeds it).
See also: `design-corpus`, `assessment`, `trap`, `experiment`,
`surface-declaration`, `surface-ruling`.

## Invariants

- Every record is a statement about the named release commit; nothing
  tracks staleness and nothing invalidates anything.
- The corpus speaks in the shipped vocabulary — concepts, stories, and
  public surface elements — and no record names source paths, tests,
  or internal entry points.
- Silence about an assumption means it was measured and held — honest
  only because assessment records attest the measurement.
- Citations resolve to catalog rows at the stamp, serve the reader,
  and are never process inputs.
- The corpus is fully re-derived at every release; the prior published
  corpus is an input to synthesis, never a cache of conclusions.
