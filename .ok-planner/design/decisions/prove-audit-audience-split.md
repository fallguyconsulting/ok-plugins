---
decision: prove-audit-audience-split
status: as-is
---

# Prove reports to the agent; audit files to the human

## Choice

The two corpus-checking verbs have disjoint audiences and channels: the proof run produces work items for an agent — a structured in-context report the executing agent triages, never writing the intake queue — while the audit produces work items for a human, appending judgment findings to the queue and handing mechanical ones back to the caller. A proof finding that turns out to need owner judgment reaches the owner via the next audit catching the underlying corpus problem.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an executing agent needs findings now, in context, at machine tempo; an owner needs a durable, deduplicated agenda at calibration tempo. Giving each verb one channel also makes the queue's meaning crisp — every row is an owner question, never agent chatter.

## Alternatives

- One verb doing both — every execution-time finding becomes queue noise, and owner questions get buried in agent triage.
- Both verbs writing the queue — the queue stops meaning "requires owner calibration" by construction.

## Proof

No enforcing check exists today: nothing fails if the proof run writes the queue or the audit reports judgment findings only in-context; the channel discipline lives in prompt text. Filed to the intake queue for owner calibration.
