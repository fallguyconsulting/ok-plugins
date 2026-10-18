---
decision: docspec-stamp-opens-the-window
---

# Each docspec's stamp opens the next documentation sprint's window

## Choice

Each docspec carries a stamp, the commit at which its documentation
last passed a documentation sprint. Planning takes each docspec whose
own text, references, listed classes, or documentation changed since
its stamp, and reads the sprints closed since then for what each
change meant. It asks the owner about a change no sprint explains,
and the owner either has the documentation describe it or holds the
docspec back for a sprint to settle. A docspec with no stamp, or with
a stamp the repository no longer holds, is planned as new: its
missing files are written whole, and every claim in its existing files
is checked. The stamp, the claim ledger, and the owner's worked example
are run state, kept apart from the docspec and written only by the
documentation sprint's tool.

## Rationale

The stamp turns "which documentation is behind" into a git question
per docspec, so a run reads only what moved, whether a sprint moved it
or work out of band did. Reading the closed sprints gives the writer
the intent behind a change, and asking the owner about a change no
sprint explains keeps the run from guessing what out-of-band work
meant. Keeping run state out of the docspec leaves the docspec owner
intent, so a run never edits what only a sprint may change.

## Alternatives

- One stamp for all documentation, like a sprint's closing commit —
  one value to keep, and every docspec is reread when any one is
  behind.
- Keep the stamp in the docspec's own frontmatter — one file per
  docspec, and owner intent then carries run state that every run
  rewrites.
- No stamp; each run rereads every docspec's documentation — nothing
  to keep, and every run pays for the whole documentation.
