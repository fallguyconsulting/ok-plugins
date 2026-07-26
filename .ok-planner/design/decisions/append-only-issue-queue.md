---
decision: append-only-issue-queue
status: as-is
---

# The intake queue is an append-only JSONL event log

## Choice

Issues live in a single append-only JSON-lines event log: one object per line, three event shapes (open, and the terminals promote and retire), never edited or deleted in place; current state is the fold of rows by stable id, and writers append with a durable shell append. Legacy terminal shapes fold on read but are never written anew.

## Rationale

Append-only makes concurrent, session-mortal writers safe — an append survives a dying session, and re-observation appends nothing because ids are stable fingerprints. The event fold gives lifecycle enforcement for free: only the planning ceremony writes terminals, so "resolution is a calibration act" is structural, and the log doubles as its own history without a separate audit trail.

## Alternatives

- A mutable tracker file or per-issue files edited in place — loses crash-safety, invites silent rewrites of history, and needs merge logic for concurrent writers.
- An external issue tracker — puts the design-judgment agenda outside the committed project.

## Proof

The lifecycle verb's queue-integrity check fails on rows that do not parse, unknown events, missing required fields, or promote rows naming a nonexistent sprint file; corrupting a line or emitting an unknown event turns it red.
