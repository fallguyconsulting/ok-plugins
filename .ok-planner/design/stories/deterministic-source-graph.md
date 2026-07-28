---
story: deterministic-source-graph
---

# The source graph regenerates identically and catches its own drift

## Story

As a project owner, I want my project's sources mapped into a
committed graph that regenerates identically from the same tree and
flags its own drift, so that what a change invalidates is computed
from recorded structure instead of re-guessed at every close.

## Acceptance

The owner (or a certifying session) runs the vendored graph tooling →
the committed graph appears or refreshes, byte-identical across
repeated runs on an unchanged tree; after an edit inside one declared
unit, that unit's recorded hash moves and unrelated hashes do not;
with the committed graph out of date, the checker reports drift and
exits non-zero. The extractor and checker are real vendored tools
operating on the real source tree — not stubs.

## Falsifier

Two runs on an identical tree produce differing graphs; an edit inside
a declared unit leaves its recorded hash unchanged, or moves unrelated
hashes; a stale committed graph passes the checker silently.

## Proof

Proof — a deterministic harness case that builds the graph twice on an
unchanged fixture and byte-compares the results, edits one declared
unit and observes exactly that node's hash move, and corrupts the
committed graph to observe the checker exit non-zero.
