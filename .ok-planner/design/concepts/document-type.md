---
concept: document-type
---

# Document type

## What it is

A document type is an owner-authored artifact naming one document a
release ships: what the document is for, which classes of public
surface it covers, and the path in the tree where the documentation
ceremony places it. One file per type at
`.ok-planner/surface/documents/<slug>.md`, prose, committed to the
estate. The set of document types is the project's generative corpus
for documentation — the declaration of what to produce, never the
produced text — and it sits beside the surface intent because both
express owner intent about the user's field of view.

## Purpose

A document type separates what a release documents from the words that
document it. The type is durable and the owner's; the document is
regenerated whole from it at every release, so a reference or a guide
is a stamped snapshot rather than maintained prose. Binding each type
to surface classes is what lets the documentation walk compute its
questions instead of asking the owner to think from a blank page: a
public class no type covers, or a type whose classes came back empty,
is a delta the owner rules on; agreement passes in silence.

## Boundaries

A document type is not a document: it carries no generated text, no
outline the writer must fill, and no citations. It is not the surface
intent, which classifies elements public or internal; a type reads
that classification through the extraction and says which public
classes one document covers. It is not a documentation-corpus record:
records are the audit's measurements, and a type's writer reads them
for orientation while writing something self-contained. Which types
exist is decided in the documentation walk. See also:
`surface-intent`, `surface-extraction`, `documentation-corpus`.

## Invariants

- **The owner is the authority.** The documentation walk co-authors
  the type set with the owner and lands what they approve; between
  runs the owner edits the files freely. No autonomous stage writes a
  type.
- **One file per type, in the estate,** at
  `.ok-planner/surface/documents/<slug>.md`, carrying three things:
  what the document is for, the classes of public surface it covers,
  and its target path — a file, or a folder when the path ends in `/`.
- **A type names classes, never elements.** "The CLI verbs" is a
  class; a list of verbs is the extraction's job and would drift.
- **A type is a declaration, not a warrant.** Nothing about a type
  asserts that its document's claims were measured; the document its
  writer produces is self-contained and carries no held or unverified
  state.
- **Read at the stamp.** Generation reads the type set at the commit
  the release names, like every other owner-intent artifact.
