---
decision: relevance-scoped-queue-gate
---

# The intake gates planning by relevance, not at the door

## Choice

A feature-work planning session drafts the sprint first; a dedicated relevance reviewer then splits the unruled open issues into bearing and independent, and only the bearing ones are walked with the owner — one at a time, with the corpus artifacts relevant to each surfaced first. The open count is information, not a gate, and the reviewer's tiebreak is fixed: when it cannot tell, it answers that the issue bears. A promoted issue is settled: the sprint carrying it is the source of truth from then on, no later sprint re-opens it, and a wrong outcome is a new issue. Intake-drain sessions invert this: there the intake is the agenda.

## Rationale

The justification is narrow and structural: building over a bearing issue decides it silently, while an independent issue costs the sprint nothing by staying open. A needless owner conversation costs a minute; a silently decided design question costs a rewrite — hence the tiebreak toward walking. Settling promotion once keeps an approved sprint out of debate at the moment it is being built, and the intake already carries the cheaper way to say the outcome was wrong.

## Alternatives

- The intake as an entry gate — every planning session pays for the whole backlog, punishing owners for filing issues.
- Ignore the intake during feature work — bearing issues get decided silently by whatever the sprint builds over them.
