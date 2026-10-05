---
decision: issue-records-in-one-file
---

# The intake is one JSON Lines file, one record per issue

## Choice

The intake is one JSON Lines file with one mutable record per open
issue. A record holds the issue's fields, the owner's ruling apart
from any marked generated or recommended ruling, and its whole discussion, and a writer
changes an issue by rewriting its line.

## Rationale

Structured fields let a page list, filter, and thread issues without
parsing prose, and they keep the owner's ruling and triage's
marked ruling apart. One
line per issue keeps a change to one issue a change to one line in
version control. A long discussion makes that line long, and the diff
shows the whole line.

## Alternatives

- One markdown file per issue — readable and hand-editable, but a threaded discussion has no structure and every reader parses prose.
- An append-only event log — every reader replays the log to learn an issue's current state.
- An embedded database — a binary file version control cannot diff or merge.
