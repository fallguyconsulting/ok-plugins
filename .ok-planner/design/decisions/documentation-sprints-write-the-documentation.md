---
decision: documentation-sprints-write-the-documentation
---

# A documentation sprint alone writes the documentation, after the code settles

## Choice

Of the suite's runs, only a documentation sprint writes a project's
documentation, its doc comments included. The owner starts its
planning on their own schedule, usually before a release, and the
plan runs unattended to completion. Sprints declare the docspecs and
the surface intent; their builders write no documentation and no doc
comment, and sprint certification and every other review run check
none. Separate agents write each file, never the agent that wrote the
code it describes. Which documentation a run takes is a decision of
its own (see also: docspec-stamp-opens-the-window). A person's direct
edit to documentation is reconciled at sprint planning (see also:
out-of-band-documentation-reconciled), and the administrator's one
exception is true-up's removal of a provenance stamp a retired verb
wrote (see also: whole-file-ownership).

A docspec is owner intent, like a corpus artifact: it changes only
through a sprint's approved delta, in final form, save the
administrator's migrations, which change no commitment (see also:
final-form-deltas).

## Rationale

Sprints change and redo code, several in a day, so documentation
written with each one is rewritten as often, and checking every
document every sprint spends the most where it buys the least.
Writing it once the code settles, on the owner's schedule, writes each
fact once for the code that ships. A builder who wrote the code reads
past what it already knows; a separate writer reads the code as the
documentation's reader will.

## Alternatives

- A sprint's builders write the documentation its work touches — a
  change and its documentation land together, and every sprint pays
  for documentation the next sprint rewrites.
- Write the documentation at the end of every `/converge` run — the
  documentation follows every fix, and an audit run grows a writing
  job whose cost tracks the whole corpus.
- Generate the documentation whole at each release from declared
  types — nothing to plan, and prose a type cannot express is lost.
