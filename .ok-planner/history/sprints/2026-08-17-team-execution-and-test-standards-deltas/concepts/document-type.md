---
concept: document-type
---

# Document type

## What it is

A document type is the owner's order for one document a release
ships: what the document is, whom it is for, how to write it, and the
path in the tree where the documentation ceremony places it. One file
per type, prose, committed to the estate. The set of document types is the project's
generative corpus for documentation — the declaration of what to
produce, never the produced text — and it sits beside the surface
intent because both express owner intent about the user's field of
view.

## Purpose

A document type separates what a release documents from the words that
document it. The type is durable and the owner's; the document is
regenerated whole from it at every release, so a reference or a guide
is a stamped snapshot rather than maintained prose. Binding each type
to surface classes is what lets the documentation walk compute its
questions instead of asking the owner to think from a blank page: a
public class no type covers, a type whose classes came back empty, or
a document in the tree no type covers, is a delta the owner rules on;
agreement passes in silence.

## Boundaries

A document type is not a document: it carries no generated text and
no citations. It is not the surface intent, which classifies elements
public or internal; a type reads that classification through the
extraction and says which classes one document covers, at the vantage
its audience names. It is not a documentation-corpus record: records
are the audit's measurements, and a type's writer reads them for
orientation while writing something self-contained. Which types exist
is decided in the documentation walk. See also: `surface-intent`,
`surface-extraction`, `documentation-corpus`.

## Invariants

- **The owner is the authority.** The documentation walk co-authors
  the type set with the owner and lands what they approve; between
  runs the owner edits the files freely. No autonomous stage writes a
  type.
- **One file per type, in the estate,** carrying what the
  document is for, its audience, its target path — a file, or a
  folder when the path ends in `/` — and whatever the owner writes
  about how to produce it: the classes of surface it covers, an
  outline, prose to carry verbatim, a Method to run first. The writer
  honors all of it.
- **Audience is the vantage.** `public`, the default when the field
  is absent, is the user's: the document names only elements the
  extraction records public and speaks the shipped vocabulary.
  `developer` is the contributor's or operator's: the document may
  name internal elements — repository scripts, service entry points,
  internal ports and keys, the layout of the tree — and its Covers
  may name internal classes. The audience changes only what the
  writer may name; an element named in a developer document is no
  more public for being named there.
- **Covers names classes.** "The CLI verbs" is a class the walk can
  check against the extraction; a hand-listed set of verbs is the
  owner's to keep current.
- **All documentation is typed.** A document in the tree no type's
  target covers is a delta in the walk: the owner keeps it as a type
  or drops the file as not documentation.
- **A type is a declaration, not a warrant.** Nothing about a type
  asserts that its document's claims were measured; the document its
  writer produces is self-contained and carries no held or unverified
  state.
- **Read at the stamp.** Generation reads the type set at the commit
  the release names, like every other owner-intent artifact.
