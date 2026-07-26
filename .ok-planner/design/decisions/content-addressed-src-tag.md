---
decision: content-addressed-src-tag
---

# Artifact tags are a 12-hex git tree hash of the working tree, derivation frozen

## Choice

The artifact tag is derived by hashing the entire working tree — uncommitted changes included — through a temporary index into a git tree object, printed as a fixed prefix plus the first 12 hex of the tree hash. The script stays POSIX shell with no dependency beyond git, and its derivation never changes without a major version bump, so every consumer derives byte-identical tags for identical trees.

## Rationale

Deriving from a tree object gives content identity without requiring a commit and without touching the real index; POSIX-plus-git-only lets the script run in build and CI environments where node is absent; freezing the derivation is what lets independent tools on different machines trust tag equality.

## Alternatives

- Tag by commit hash — misses uncommitted changes, forcing commits just to build.
- Tag by timestamp or counter — mutable identity, reintroducing representable staleness.
- A checksum tool outside git — adds a dependency and re-implements tree semantics git already has.

## Proof

The plugin's diagnose phase compares the materialized script byte-for-byte against the version-substituted canonical; any edit to the materialized copy — including to the derivation lines — turns diagnosis red.
