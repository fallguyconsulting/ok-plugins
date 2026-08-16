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
must follow to use it. The finished document is written into the
estate's documentation corpus under `documents/` and **placed** at the
type's target path in the tree — under `docs/`, or the root
`README.md` — opening with a provenance stamp naming the release commit
and the ceremony that wrote it. Only declared types' targets are
written; a project that keeps a hand-written README declares no type
targeting it. `docs/CLAUDE.md` is written in the same step, carrying
the record rule and the pointer into the estate. Publishing outside
the repository stays a separate act the ceremony never performs.

## Rationale

Readers expect documents under `docs/` and a root README, and a corpus
that stops at records inside the estate never reaches them; making
placement a projection into the tree the ceremony already commits
closes that gap without a second verb. Self-containment keeps the
documents usable by humans and agents alike and keeps the records
tier's citation and warrant regime where it belongs — on measurements
— instead of leaking record links into a reference someone reads on a
hosting site. Per-type targets are what make placement safe: nothing
is overwritten that no type claims. The provenance stamp is what lets
a reader compute staleness themselves, which is the whole of the
corpus's staleness policy.

## Alternatives

- Leave placement to a separate publisher verb: keeps the ceremony's
  "does not publish" line absolute, at the cost of an empty `docs/`
  until someone remembers a second verb.
- Generate documents that cite the records: every claim traceable, at
  the cost of documents that are not self-contained and a citation
  regime to keep honest across placement.
- Warrant every generated sentence with a passing experiment: the
  records tier's discipline extended to prose; priced out for
  references and guides.
- Place all documents unconditionally at fixed paths: simpler, but
  overwrites hand-kept files a project never asked to generate.
