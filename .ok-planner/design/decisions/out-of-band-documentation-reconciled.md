---
decision: out-of-band-documentation-reconciled
---

# Planning reconciles documentation a person edited directly, as it reconciles code

## Choice

Planning's reconcile step treats a direct edit to documentation like
out-of-band code. Over the window since the last closed sprint, it
flags each edit to documentation made outside a documentation sprint,
and the owner picks one of two outcomes. The edit stands: the text
stays, and where the edit changed what the documentation covers, the
sprint carries a docspec delta that matches it; the next documentation
sprint checks its claims. Record and defer: an issue records the
edit, and the documentation stays as it is. The work a closed
documentation sprint committed is not out of band. A change to what a
docspec describes, made anywhere, is not flagged here: the next
documentation sprint's window finds it through the docspec's stamp
(see also: docspec-stamp-opens-the-window).

## Rationale

A direct edit changes what the product tells its readers without the
owner's sign-off, so it needs the owner's decision as out-of-band code
does. Keeping the edit must leave the docspec agreeing with the text,
or the next documentation sprint writes against an order the text no
longer follows. A change to what documentation describes needs no
question at planning, because the stamp turns it into the next
documentation sprint's work whether a sprint made it or not. The
closing-commit baseline makes the edit a git question (see also:
closing-commit-baseline).

## Alternatives

- Let direct documentation edits stand unflagged — no question for
  the owner, and the documentation departs from its docspec with no
  decision behind it.
- Revert every direct documentation edit — keeps the docspec
  authoritative, and discards work a person meant to keep.
- Flag every change to what a docspec describes as well — the owner
  decides each, and the question duplicates the window the stamp
  already gives the documentation sprint.
