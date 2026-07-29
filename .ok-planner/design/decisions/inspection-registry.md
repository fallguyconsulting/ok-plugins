---
decision: inspection-registry
---

# The change inspection's state is a permanent node-keyed registry, not a per-run receipt

## Choice

The judgment layer's durable state is one committed registry file in
the audit corpus, written only by certification's change inspector:
entries keyed to source-graph node identities and pinned to the
node's recorded content hash, storing only the judged classes —
residue (changed code no audit claims) and adjudication pointers
(the audit carrying the nomination's note) — never the mechanical
disposition, which is recomputable. Entries carry audit-style
precedent semantics: an entry stands while its pin holds and lapses
when the node's content moves or its identity vanishes, so the
registry rides forward cycle to cycle and sprint to sprint, and each
inspection pass works only the unclassified new work. The vendored
checker enforces the closure floor mechanically: every source node
the change touched is accounted — by a stale citation or a live
entry — or the gate fails, and a missing registry with changed nodes
fails the same way, so a skipped judgment pass is a mechanical
failure, never a vacuous clean. Standing residue is reported to the
owner as intake material and served to the project's local corpus
view (see also: local-web-surface under decisions).

## Rationale

The gate's judgment layer used to live only in conversation: the
inspector reported its reconciliation in-context, and the clean
bar's "no note left open, no hunk without a disposition" went
vacuously true whenever the inspector never ran — a skipped pass and
a clean pass were indistinguishable, and a goal-seeking orchestrator
took the early-out. A durable record fixes that only if the checker
can tell whether the record covers the change at hand, which is what
node keys and hash pins buy: coverage is computed against the same
committed graph the citations use, unit by unit. Storing only the
judged classes keeps the registry small and honest — the mechanical
account is recomputable at any moment, so storing it would only let
it go stale — and precedent semantics make maintenance incremental:
last sprint's residue rides forward untouched until the code it
names actually changes, the same convergence property recorded
adjudications already rely on (see also: recorded-adjudication under
decisions).

## Alternatives

- A per-run receipt content-addressed to the certified diff — proves
  one run happened, but its coverage dies with that diff: the next
  change starts blind and nothing rides forward.
- Storing every disposition, mechanical ones included — a larger
  record whose mechanical rows go stale the moment anything moves,
  duplicating what the checker recomputes for free.
- In-context reporting only — leaves a clean pass and a skipped pass
  indistinguishable to the gate and to any goal checker.
