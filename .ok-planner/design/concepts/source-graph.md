---
concept: source-graph
---

# Source graph

## What it is

A source graph is a project's committed, mechanically derived map of
its own sources: one node per file and per declared unit within a
file — a function, a type, a method, a heading-bounded section of
prose — each node carrying a structural identity derived from declared
names and a content hash over its exact span, with edges recording
syntactic reference and containment. A deterministic extractor
generates it wholesale; the same source tree always yields the
byte-identical graph.

## Purpose

The graph gives certification a computable answer to "what does this
change put in question?". Claims point into it from outside — an audit
cites the node frontier that delivers a claim, and the claim's
territory is that frontier's downward closure — so invalidation,
candidacy, and residue become topology: a changed node either breaks a
cited hash, lies inside some claimed closure, or lies in no closure at
all. Without the graph, that mapping is re-derived from prose at every
close, which is where over-sweeping and oscillation live.

## Boundaries

The graph is syntax, never semantics: it records what references what
as written and claims nothing about what executes — choosing which
nodes cover a dataflow is the auditor's judgment, expressed by citing
a higher frontier (see also: adversarial-implementation-audits under
decisions). It carries no audit content, no annotations, and nothing
hand-written; whatever points into it lives with the pointer's owner.
Annotations are a neighbor, not an input: they keep navigation and
proof registration and play no role in the graph or in invalidation
(see also: annotation). Prose sources are first-class — heading-bounded
sections are the declared units of a markdown file. The extractor and
checker are vendored, materialized tooling (see also:
materialized-artifact); the graph itself is generated project state
committed within the planner's estate (see also: estate,
design-corpus).

## Invariants

- The graph is a pure function of the source tree: identical trees
  yield byte-identical graphs, and regenerating it is always safe
  because nothing hand-written lives in it.
- Node identity derives from declared structure — the file's place in
  the tree plus the declaration or heading chain — never from line
  positions; a rename or move is an identity change by design.
- Every node's content hash covers its exact span bytes; any edit
  inside the span moves the hash.
- The graph never contains judgment: claims, adjudications, and
  citations point into it from their own records.
