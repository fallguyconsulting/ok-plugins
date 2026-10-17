---
decision: intake-reads-past-stray-lines
---

# The intake module reads past lines it cannot use and keeps them

## Choice

The intake module skips each line that is no record at all (a line
that is not JSON, or a line with no id) and each line that repeats an
id already read (in the archive, an id and opened time), keeps it in
its file, and names how many such lines each file holds. It drops a
live line whose record the archive already holds, which finishes a
close that stopped between its two writes. A schema fault a record
already carried never blocks a write. A field the schema no longer
uses stays in its record as written, and no verb acts on it.

## Rationale

One stray line or one old fault should not stop every verb: the owner can still work the intake while the line stays. Keeping a stray line in its file loses nothing a writer put there, and the note the module prints names where it sits. A close writes the archive before the live file, so
a live line the archive already holds is the trace of a close that
stopped partway, and dropping it completes that close. Keeping a field
the schema no longer uses leaves each record as its writer left it, so
a schema change rewrites no line.

## Alternatives

- Refuse every verb while any line breaks the schema — one stray line stops every reader and writer until the line is gone.
- Drop or repair stray lines on read — the module destroys or rewrites a line before anyone reads what it held.
- Keep a live line the archive already holds — the issue shows as open and closed at once.
- Strip a field the schema no longer uses from every record — one schema change rewrites every line, the archive's closed records among them.
