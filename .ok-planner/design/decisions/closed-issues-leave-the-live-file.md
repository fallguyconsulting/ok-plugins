---
decision: closed-issues-leave-the-live-file
---

# A closed issue's record moves to the closed-issue file

## Choice

When an issue closes, its writer moves the record from the live
intake file to the closed-issue file, a file of the same form among
the estate's live bookkeeping, outside the archive. The live file
holds open issues only. A tool that needs a closed issue, such as the
veto list or the closed history, reads the closed-issue file.

## Rationale

The live file stays as small as the open intake, so every reader that
needs open issues reads only those. Keeping closed records outside the
archive lets a tool that needs one read it without opening the archive
(see also: archive-read-by-nothing). The closed-issue file stays a
record, out of agent context by default (see also:
records-stay-out-of-context).

## Alternatives

- Keep closed records in the live file, marked closed — one file to read, but it grows without bound and every reader skips closed lines.
- Move closed records into the archive — the live file stays small, and every tool that needs a closed issue reads the archive.
