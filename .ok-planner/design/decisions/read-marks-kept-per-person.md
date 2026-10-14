---
decision: read-marks-kept-per-person
---

# Each person's reading lives in a ledger of their own that git ignores

## Choice

Each person's read marks live in a per-person ledger inside the
project's working copy, in a place git ignores: which issues the
person has read, and how far into each discussion. Reading an issue
changes no committed file, and each person's unread counts come from
that person's ledger alone. A fresh ledger, in a new clone or on a
person's first run, starts with everything that exists counted as
read. Triage's seen mark on a person's message stays in the committed
record.

## Rationale

A per-person ledger keeps one person's reading from clearing another
person's unread marks, and keeps reading out of git's history. Triage's
seen mark stays committed because every clone must agree on which
messages triage has answered. A fresh ledger that starts with
everything read keeps a new clone, or a person's first run, from
showing the whole intake as new.

## Alternatives

- Read marks in the committed record, one per message — opening an issue changes a committed file, and once committed it clears the unread marks of every person who pulls it.
- Read marks in the committed record, kept per person by name — opening an issue still changes a committed file, and every person's reading lands in every clone's history.
- A fresh ledger that starts empty — a new clone shows every issue in the intake as new.
- Triage's seen mark in each person's ledger — clones disagree on which messages triage has answered.
