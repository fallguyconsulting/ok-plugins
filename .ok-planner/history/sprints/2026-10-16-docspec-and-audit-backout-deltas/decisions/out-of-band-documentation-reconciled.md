---
decision: out-of-band-documentation-reconciled
---

# Planning reconciles documentation changed out of band as it reconciles code

## Choice

Planning's reconcile step treats documentation like code. Over the
window since the last closed sprint, it flags two kinds of change made
outside a sprint, and the owner decides each.

- Documentation edited outside a sprint. The owner picks one of three.
  The edit stands: the sprint keeps the text, and where the edit
  changed what the documentation covers, the sprint carries a docspec
  delta that matches it. The documentation goes back to its docspec: a
  work item rewrites it per the docspec. Record and defer: an issue
  records the edit, and the documentation stays as it is.
- Code or corpus a docspec references, changed outside a sprint. A
  work item updates the documentation, or the owner defers it with an
  issue.

## Rationale

From the out-of-band view, documentation is like code: an edit outside
a sprint changes what the product tells its readers without the
owner's sign-off, so it needs the owner's decision as out-of-band code
does. Keeping the edit must leave the docspec agreeing with the text,
or the next builder rewrites the edit away. A change to what a docspec
references, made outside a sprint, leaves its documentation behind the
product, and no sprint names it, so nothing would update it. The
closing-commit baseline makes both kinds a git question (see also:
closing-commit-baseline).

## Alternatives

- Let out-of-band documentation edits stand unflagged — no question
  for the owner, and the documentation departs from its docspec until a
  builder rewrites the edit away unseen.
- Revert every out-of-band documentation edit — keeps the docspec
  authoritative, and discards work a person meant to keep.
- Flag only documentation edits, never reference changes — a smaller
  reconcile, and documentation stays behind code changed out of band
  until some later sprint happens to name its docspec.
