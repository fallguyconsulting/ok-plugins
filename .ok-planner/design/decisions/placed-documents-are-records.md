---
decision: placed-documents-are-records
---

# Placed documents are records: out of context by default, and staleness files nothing

## Choice

A document the ceremony places in the tree is a **record** in the
estate's sense, though it lives outside the estate: out of agent
context by default, never read to understand the current tree, never
reconciled with the code by a working session, consulted only when the
owner directs an agent there. Its provenance stamp is its only
staleness marker — how far `HEAD` has moved past it is a git question
— and an agent that finds a placed document behind the tree files
nothing and marks nothing; the next `/document` regenerates the set
whole. The one filing-worthy discovery is a document wrong at its own
stamp, which is a construction defect filed as such. The rule is
carried at every place an agent could meet the documents:
`docs/CLAUDE.md`, the provenance stamp each document opens with, and
the ok-planner cheatsheet in the project's rules layer.

## Rationale

The documents are granular and prose, so they can drift on every
commit; treated as inputs they would pull agents toward the last
release while the owner is trying to move past it. Record discipline
is what keeps them from working against change: a document that is
never an input to a change cannot mislead one, whatever its
granularity. Filing on staleness would flood the intake once per
sprint with questions that need no judgment — the stamp already says
what the document describes — and marking a document stale edits a
record. Carrying the rule at three sites is what makes it hold: an
agent that lands in `docs/`, opens the README, or reads the rules layer
meets the same sentence.

## Alternatives

- Instruct agents to ignore the placed documents entirely: no drift
  risk, and no way for the owner to direct an agent at a past
  release's documents.
- Treat them as historical reference agents may consult freely:
  standing input, standing drift.
- File an issue and mark the document stale when an agent finds it
  behind the tree: bookkeeping that grows the intake with unjudgeable
  questions and edits records.
- Hold placed documents to the design corpus's regime (change only
  through a sprint, reconciled each planning ceremony): too granular
  to reconcile, and a document is a snapshot by construction.
