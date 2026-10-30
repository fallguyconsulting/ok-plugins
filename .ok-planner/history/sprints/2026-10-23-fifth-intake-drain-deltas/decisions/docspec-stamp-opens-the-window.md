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
is checked. A docspec retired since its stamp, or one whose location
moved since then, leaves behind the files its location named at the
stamp. Planning finds those files from the docspec as it stood at its
stamp, or, where the repository holds no such stamp, at the last
commit that holds the docspec, and plans a drop of each one no
standing docspec covers. It plans a change of each file a standing
docspec covers now and did not cover at its stamp where a rule fires
on it, and a check of each other such file, and every claim in each is
checked. The owner
approves those items with the rest of the plan. Planning runs while
any docspec's run state stands, even where no docspec does. The stamp,
the claim ledger, and the owner's worked example are run state, kept
apart from the docspec and written only by the documentation sprint's
tool. The tool removes a retired docspec's run state once a
documentation sprint has passed the files it left.

## Rationale

The stamp turns "which documentation is behind" into a git question
per docspec, so a run reads only what moved, whether a sprint moved it
or work out of band did. Reading the closed sprints gives the writer
the intent behind a change, and asking the owner about a change no
sprint explains keeps the run from guessing what out-of-band work
meant. Keeping run state out of the docspec leaves the docspec owner
intent, so a run never edits what only a sprint may change. A docspec
retired or moved since its stamp is one more change since the stamp,
so finding the files it left needs no record beyond the stamp and git,
and a documentation sprint stays the one writer of documentation. The
cost is that planning reads a retired docspec from git as it stood at
its stamp.

## Alternatives

- The sprint that retires or moves a docspec deletes the files it
  left — nothing for planning to find, and a sprint's builders become
  a second writer of documentation.
- The sprint that retires or moves a docspec records the files it left
  as a drop order for the next documentation sprint — the sprint says
  per file whether it goes, and the order repeats what the stamp and
  git already hold.

- One stamp for all documentation, like a sprint's closing commit —
  one value to keep, and every docspec is reread when any one is
  behind.
- Keep the stamp in the docspec's own frontmatter — one file per
  docspec, and owner intent then carries run state that every run
  rewrites.
- No stamp; each run rereads every docspec's documentation — nothing
  to keep, and every run pays for the whole documentation.
