---
decision: records-stay-out-of-context
---

# Records are committed and versioned, and stay out of agent context by default

## Choice

The estate's records — sprints, documentation sprints, each
docspec's run state, the scenario list, the closed-record ledger, the
closed-issue file, the test-plan folder, sketches, discoveries, the
notes an earlier release's discovery run left, the archive, and the
review runs' records — are committed and versioned, and stay out of
agent context by default. The one live exception is the sprint or
documentation sprint being executed, and a skill that reads a record
it names. The archive is the one record with a stricter rule of its
own (see also: archive-read-by-nothing). An agent reads or touches any other record
only when the owner or a skill directs it, and then does exactly what
was asked.

## Rationale

A record describes a past moment. An agent that reads one to
understand the project pulls that moment into its present reasoning,
and drift between the record and the code is expected, so the agent
reasons from a state the project has left. The design corpus and the
code are the source of truth, and they describe the project as it
stands. Committing the records keeps the project's history versioned
and available to the owner, and keeps the live records available to
the skills that need them. Keeping records out of context by default
keeps that history from competing with the source of truth.

## Alternatives

- Records read freely as context — an agent sees the project's history
  whole, and reasons from states the code has since left.
- Records not committed — nothing stale reaches an agent, and the
  project loses its versioned history of sprints, sketches, and runs.
