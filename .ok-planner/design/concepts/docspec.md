---
concept: docspec
---

# Docspec

## What it is

A docspec is the owner's declaration of one kind of documentation a
project keeps. It says where that documentation lives, whom it is for,
what it covers, and which parts of the project it describes. A docspec
for reference documentation also names the classes of public surface
the documentation must name in full. One kind of documentation may be
one file, or a folder of many files. A docspec carries the order,
never the text.

## Purpose

A docspec lets a documentation run find the documentation a change
reached. Each docspec names what its documentation describes, so the
run compares what changed against those names and learns which
documentation is behind. The docspec also tells the writer whom the
text is for, what to cover, what to leave out, and what shape each
file takes, so the text follows the owner's intent instead of the
writer's guess.

## Boundaries

Documentation, in a docspec's sense, is for humans, or for agents that
use a deliverable shipped without its source. An agent working with
the source reads the design corpus and the project's rules instead,
and documentation for that agent is outside a docspec's reach (see
also: design-corpus, cheatsheet). A docspec is not the documentation
it governs: the documentation is the text, and the docspec is what the
text answers to. It is owner intent, like a corpus artifact, and it is
not part of the design corpus: the corpus says what the product is and
owes, and a docspec says what one kind of documentation tells its
reader. It does not classify the surface: the surface intent says
which classes are public, and a reference docspec names the classes it
must list (see also: surface-intent). How a docspec changes, and how
its documentation changes, are decisions (see also: sprint,
corpus-delta; documentation-sprints-write-the-documentation,
docspec-stamp-opens-the-window,
documentation-edits-only-where-a-rule-fires,
documentation-style-read-once,
documentation-claims-checked-until-they-hold,
documentation-claim-ledger, docspec-copies-its-shape,
one-docspec-per-file, out-of-band-documentation-reconciled under
decisions).