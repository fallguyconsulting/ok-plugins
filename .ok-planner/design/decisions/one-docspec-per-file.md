---
decision: one-docspec-per-file
---

# Each docspec is its own file, with a generated index beside them

## Choice

Each docspec is one file in the estate, and one generated index beside
them lists each docspec's location and references. The lint reads the index to learn which files may carry documentation comments (see also: generated-catalog-tocs).

## Rationale

A sprint delta carries the whole file it changes, in final form. One
file holding every docspec makes a change to one entry carry every
entry, and two sprints that change different entries collide on the
same file. One file per docspec keeps each delta the size of its
change and lets two sprints change two docspecs apart. The index lets
a reader learn every docspec's location and references in one read. Generating it from the docspecs keeps it a projection of them,
never a second copy that drifts.

## Alternatives

- One file holding every docspec — one read for every reader, and every
  delta to any entry carries them all and collides with any other
  sprint's change to the file.
- One file per docspec with no index — nothing to generate, and
  each reader reads every docspec whole to learn which ones a change
  touches.
