---
concept: surface-extraction
---

# Surface extraction

## What it is

The surface extraction is the enumerated index of user-facing
elements the audit produces per run: one entry per element the walk
found, each naming the element's kind, its identifier, its location,
and the rule from the intent that placed it public or internal. Kinds
are discovered by the walk rather than pre-declared. The extraction is
stamped with the commit the audit describes.

## Purpose

The extraction is the audit's operational surface — the version of
"the public surface at this commit" that the story auditor drives
experiments through, that the documentation ceremony ships against,
and that a reader can inspect after the fact to see exactly what was
treated as public when the audit ran. Keeping the extraction a per-run
artifact means the answer is always current with the tree the audit
describes: nothing carries between runs, no cached partition can
drift, and freshness is a version-control question anyone can answer without a
validator. Element inventory changes as the code moves; intent changes
only when the owner edits it; the extraction is the run's join of the
two.

## Boundaries

The extraction is not the intent, and it is not a verdict. It states
what the walk found and how the intent classified it — nothing else.
An element the intent cannot settle does not get a placeholder
verdict: the extraction records it as internal for this run, with a
note that the classification was defaulted. Whether a story is
actually supported by what the extraction lists as public is the
story auditor's question, not this record's — the extraction is the
input to that audit, never a substitute for it. The extraction is not
consulted to understand the project; it is a run's snapshot, and
readers doing project comprehension read the intent instead.
