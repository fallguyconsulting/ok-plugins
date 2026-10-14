---
decision: retired-layout-strips-only-recoverable-files
---

# True-up strips a retired artifact layout only from files git can recover

## Choice

True-up removes the sections and files a retired artifact layout
defined — a story's retired falsifier, proof, and acceptance sections,
a decision's retired proof section, and the retired falsifier concept
file — only from a file git tracks with no uncommitted or staged-only
change and no symbolic link in its path. Every other such file goes to
the owner as an estate edit offer.

## Rationale

A retired layout's section states what the corpus no longer commits
to, so removing it changes no promise, and limiting the removal to
text git can recover keeps an owner's unsaved words out of its reach.

## Alternatives

- Strip every such file whatever its git state — owner text git cannot recover is lost.
- Leave every retired section for the owner to remove — every migrated project keeps dead sections in its corpus.
