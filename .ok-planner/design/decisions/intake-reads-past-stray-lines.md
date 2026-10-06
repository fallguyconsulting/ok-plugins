---
decision: intake-reads-past-stray-lines
---

# The intake module reads past lines it cannot use and keeps them

## Choice

The intake module skips each line that holds no usable record, or
repeats an id already read (in the archive, an id and opened time),
keeps it in its file, and names how many such lines each file holds.
It drops a live line whose record the archive already holds, which
finishes a close that stopped between its two writes. A schema fault a
record already carried never blocks a write.

## Rationale

One stray line or one old fault should not stop every verb: the owner
can still work the intake while the front door's offer to convert the
line waits. Keeping a stray line in its file loses nothing an earlier
layout wrote before a migration reads it. A close writes the archive
before the live file, so a live line the archive already holds is the
trace of a close that stopped partway, and dropping it completes that
close.

## Alternatives

- Refuse every verb while any line breaks the schema — one stray line stops every reader and writer until someone repairs it by hand.
- Drop or repair stray lines on read — a line an earlier layout wrote is lost before any migration reads it.
- Keep a live line the archive already holds — the issue shows as open and closed at once.
