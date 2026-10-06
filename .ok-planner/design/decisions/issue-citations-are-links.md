---
decision: issue-citations-are-links
---

# An issue's citations link to the files they name

## Choice

Each citation of a corpus artifact or a code site in an issue is a
link to the file, and to the line where it names one. Every
`/triage-issues` run checks the links of each open issue no sprint has
taken up that it has never checked, or whose linked file moved,
vanished, or changed since its last check, and repairs them; a
citation whose file is gone becomes plain text (see also:
linked-files-open-in-place).

## Rationale

The owner rules from an issue's evidence, and a link puts that
evidence one step away. Code moves under an open issue, so a link
checked once at filing rots; checking links each run keeps them true
at the cost of one pass over the issues whose files changed.

## Alternatives

- Plain-text citations — the reader searches for each file by hand.
- Links written once at filing — they point at the wrong line once the code moves.
