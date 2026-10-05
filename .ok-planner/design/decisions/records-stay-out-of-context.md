---
decision: records-stay-out-of-context
---

# Records are committed and versioned, and stay out of agent context by default

## Choice

The estate's records — sprints, sketches, the archive, the review
runs' records, and the audit corpus outside a running audit — are
committed and versioned, and stay out of agent context by default. The
one live exception is the sprint being executed. An agent reads or
touches a record only when the owner or a skill directs it, and then
does exactly what was asked.

## Rationale

A record describes a past moment. An agent that reads one to
understand the project pulls that moment into its present reasoning,
and drift between the record and the code is expected, so the agent
reasons from a state the project has left. The design corpus and the
code are the source of truth, and they describe the project as it
stands. Committing the records keeps the project's history versioned
and available to the owner and to the skills that need it. Keeping
them out of context by default keeps that history from competing with
the source of truth.

## Alternatives

- Records read freely as context — an agent sees the project's history
  whole, and reasons from states the code has since left.
- Records not committed — nothing stale reaches an agent, and the
  project loses its versioned history of sprints, sketches, runs, and
  audits.
