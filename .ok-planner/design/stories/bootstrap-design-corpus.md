---
story: bootstrap-design-corpus
status: as-is
---

# Bootstrap a design corpus from an existing codebase

## Story

As a project owner adopting the suite on an existing codebase, I want the as-is design model extracted autonomously into durable catalogs plus a queue of judgment questions, so that my design attention is spent resolving genuine ambiguities instead of writing documentation from scratch.

## Acceptance

The owner invokes the corpus bootstrap on a project whose durable catalogs are empty → the run completes end-to-end without interruption, leaving populated concept, story, and decision catalogs describing the project as it is, regenerated tables of contents, judgment questions appended as open rows in the intake queue, and a single final report. The two-phase discovery-and-extraction pipeline with its produce–review–fix loops is real, not stubbed. On a project with non-empty durable catalogs the run aborts rather than risk overwriting human-approved content.

## Falsifier

The run completes but the catalogs are empty, generic, or untraceable to the codebase; the artifacts are aspirational inventions rather than as-is observations; the run stalls mid-way waiting on the owner; or a re-run silently overwrites human-edited durable artifacts.

## Proof

Demo — a bootstrap run on a real codebase after which a third party can trace every catalog artifact to observable code or prose facts, sees only judgment items in the queue, and can confirm a second invocation against the populated catalogs refuses to write.
