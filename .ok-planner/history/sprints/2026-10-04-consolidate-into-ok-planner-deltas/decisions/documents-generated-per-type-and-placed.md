---
decision: documents-generated-per-type-and-placed
---

# Documents are generated per declared type, self-contained, and placed in the tree by the documentation ceremony

## Choice

After it constructs the records, `/document` runs a **Generate** step:
one writer per declared document type, briefed with the type, the
surface extraction's public side, the audit's records as orientation,
and the tree at the release commit. The writer verifies what it states
against the tree at the stamp and writes a self-contained document —
no citations into the records, no warrant fields, nothing a reader
must follow to use it. The writer revises the document at the type's
target path in the tree — under the documentation folder, or the root
readme — and
composes one only where the target is empty. That target is the
document's one home; the estate keeps no copy. The document opens with
a provenance stamp naming the release commit and the ceremony that
wrote it. Only declared types' targets are written; a project that
keeps a hand-written root readme declares no type targeting it. Where
any type targets a path under the documentation folder, the same step
writes a rules file there carrying the record rule and the pointer into
the estate, and removes the one it wrote once no type does. Publishing outside
the repository stays a separate act the ceremony never performs.

A type may carry a **Method**: how the writer produces the document
— research to run, sources to consult, steps to follow. The
ceremony runs the Method before the writer as opus dispatches and
hands the findings to the writer as one more input. The writer states
what the findings establish and leaves out what they do not.

## Rationale

Readers expect documents under the documentation folder and a root
readme, and a corpus
that stops at records inside the estate never reaches them; writing
each document into the tree the ceremony already commits closes that
gap without a second verb. Self-containment keeps the
documents usable by humans and agents alike and keeps the records
tier's citation and warrant regime where it belongs — on measurements
— instead of leaking record links into a reference someone reads on a
hosting site. Per-type targets are what make placement safe: nothing
is overwritten that no type claims. The provenance stamp is what lets
a reader compute staleness themselves, which is the whole of the
corpus's staleness policy.

## Alternatives

- Leave placement to a separate publisher verb: keeps the ceremony's
  "does not publish" line absolute, at the cost of an empty documentation folder
  until someone remembers a second verb.
- Generate documents that cite the records: every claim traceable, at
  the cost of documents that are not self-contained and a citation
  regime to keep honest across placement.
- Warrant every generated sentence with a passing experiment: the
  records tier's discipline extended to prose; priced out for
  references and guides.
- Place all documents unconditionally at fixed paths: simpler, but
  overwrites hand-kept files a project never asked to generate.
- Confine every document to what the tree verifies, with no Method:
  a document that needs anything else stays hand-maintained.
