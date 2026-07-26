---
decision: relevance-scoped-queue-gate
status: as-is
---

# The queue gates planning by relevance, not at the door

## Choice

A feature-work planning session drafts the sprint first; a dedicated relevance reviewer then splits the open issues into bearing and independent, and only the bearing ones are walked with the owner — one at a time, with the corpus artifacts relevant to each surfaced first. The open count is information, not a gate, and the reviewer's tiebreak is fixed: when it cannot tell, it answers that the issue bears. Queue-drain sessions invert this: there the queue is the agenda.

## Rationale

The justification is narrow and structural: building over a bearing issue decides it silently, while an independent issue costs the sprint nothing by staying open. A needless owner conversation costs a minute; a silently decided design question costs a rewrite — hence the tiebreak toward walking.

## Alternatives

- The queue as an entry gate — every planning session pays for the whole backlog, punishing owners for filing issues.
- Ignore the queue during feature work — bearing issues get decided silently by whatever the sprint builds over them.

## Proof

No enforcing check exists today: nothing fails if a planning session skips the relevance split or builds over a bearing open issue; the gate lives in ceremony prompt text. Filed to the intake queue for owner calibration.
