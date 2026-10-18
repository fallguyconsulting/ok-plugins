---
decision: documentation-claim-ledger
---

# A claim ledger per docspec decides which claims a run checks again

## Choice

Each docspec's run state holds a claim ledger: each claim its
documentation makes that held at the stamp, the files it rests on, and
how it was checked. A documentation sprint checks every claim in a
file it changes, in a file changed since the stamp, and in every file
of a docspec planned as new. In any other file it checks again only
the ledger claims whose files changed since the stamp. A ledger claim
that should have been checked and was not leaves the ledger, so the
ledger never holds a claim no checker confirmed at its stamp.

## Rationale

The ledger keeps the reader's text clean of citations, and it spends a
run's checks on the claims a change could have made false instead of
on every claim in every reached file. Dropping an unconfirmed claim
keeps the ledger's one promise true: every claim in it held at the
stamp.

## Alternatives

- Record each claim's source as a link in the document — the reader
  sees the evidence, and a document for users fills with source paths.
- Record no sources, and check every claim of every reached file each
  run — nothing to keep current, and every run pays for every claim.
