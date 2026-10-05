---
decision: triage-answers-owner-messages
---

# Triage answers the owner's messages in its next run

## Choice

An owner's comment or ruling on an issue waits for the next
`/triage-issues` run. That run reads each message it has not seen,
replies where the message asks something, revises the issue where the
message shows it wrong or thin, and marks the message seen only after
acting on it. It may revise a ruled issue's analysis; the issue stays
ruled, and the revision reaches the owner as new analysis. It never
rewrites the owner's ruling.

## Rationale

Triage already reads the code and the corpus an issue cites, so it
is the reader able to answer. Answering in a batch run keeps model
calls out of the dashboard's service and keeps every analysis of an
issue in one verb. Marking a message seen only after acting leaves it
for the next run when a run dies midway.

## Alternatives

- The service calls a model live — the service needs credentials and an agent loop of its own.
- The owner asks in a session — the answer never reaches the issue, and the next reader misses it.
