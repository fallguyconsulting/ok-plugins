---
decision: retired-layout-strips-only-recoverable-files
---

# True-up strips a retired artifact layout only from a file it can recover, archiving a copy first where git cannot

## Choice

True-up removes the sections and files a retired artifact layout
defined — a story's retired falsifier, proof, and acceptance sections,
a decision's retired proof section, and the retired falsifier concept
file — from every file that holds them. Where git cannot restore the
file as it stands, because the file carries an uncommitted or
staged-only change or a symbolic link sits in its path, true-up first
copies the file as it stands into the archive. A retired file git
cannot restore moves to the archive rather than being deleted. Each
such step is a destructive step of the true-up's plan (see also:
true-up-asks-once-before-destructive-steps).

## Rationale

A retired layout's section states what the corpus no longer commits
to, so removing it changes no promise. The archived copy keeps every
word git could not restore, so an owner's unsaved text survives the
strip.

## Alternatives

- Strip every such file whatever its git state, with no copy — owner text git cannot restore is lost.
- Leave every retired section for the owner to remove — every migrated project keeps dead sections in its corpus.
- Offer each file git cannot restore to the owner — one more question per file, and a declined offer leaves a section no current skill reads.
