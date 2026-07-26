---
decision: prove-audit-audience-split
---

# Prove reports to the agent; audit files to the human

## Choice

The two corpus-checking verbs have disjoint audiences and channels: the proof run produces work items for an agent — a structured in-context report the executing agent triages, never writing the issue intake — while the audit produces work items for a human, filing judgment findings to the intake and handing mechanical ones back to the caller. A proof finding that turns out to need owner judgment reaches the owner via the next audit catching the underlying corpus problem.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an executing agent needs findings now, in context, at machine tempo; an owner needs a durable, deduplicated agenda at calibration tempo. Giving each verb one channel also makes the intake's meaning crisp — every issue is an owner question, never agent chatter.

## Alternatives

- One verb doing both — every execution-time finding becomes intake noise, and owner questions get buried in agent triage.
- Both verbs writing the intake — the intake stops meaning "requires owner calibration" by construction.

## Proof

Declared text-presence check: the channel lines — the proof run's never-writes-the-intake statement and the audit's filing-as-its-only-write statement — stand verbatim in the two verbs' governing text. Falsifier: either line deleted or reworded turns the presence check red. Declared as presence, not behavior: channel conduct at runtime is prompt-realized and unprovable.
