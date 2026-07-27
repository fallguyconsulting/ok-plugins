---
story: content-addressed-artifacts
---

# Tag artifacts by exactly what the tree contains

## Story

As a project owner wiring verification, I want an artifact tag derived from the exact content of my working tree — identical on every machine, uncommitted changes included — so that a stale artifact is unrepresentable in any verification path.

## Acceptance

Anyone runs the project's materialized tag script in any tree state → the printed tag is a pure function of tree content: the same tree yields the same tag on every machine with no commit required, and any change to tracked or untracked content the repository's own ignore rules do not exclude changes it; harnesses resolving artifacts by tag fail loudly when the tag is absent. The materialized script is the real, byte-pinned component.

## Falsifier

Identical trees yield different tags across machines or runs; an uncommitted change leaves the tag unchanged; or a verification path silently resolves a mutable tag in its place.

## Proof

Demo — the same tree hashed on two checkouts producing the identical tag, one edited file producing a different tag, and a harness lookup of a missing tag failing loudly rather than falling back.
