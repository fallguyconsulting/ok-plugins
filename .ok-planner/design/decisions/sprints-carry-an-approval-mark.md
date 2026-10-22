---
decision: sprints-carry-an-approval-mark
---

# An approved sprint carries a mark the planning session writes at approval, and every executor refuses an unmarked sprint with no base file

## Choice

The planning session writes the sprint file before the owner
approves it and refines it in place, so a sprint file alone does not
say whether the owner signed it off. The session writes an approval
mark into the sprint once the owner approves, and writes it nowhere
else. Every executor of a sprint refuses to execute one that carries
no mark, and names the missing mark in its refusal: the execution
steps the sprint carries, sprint certification, and the command that
checks the completion contract. A sprint whose base file stands
beside it is exempt: the execution steps write that file once they
start on a sprint, and sprint certification writes it only for a
sprint it does not refuse, so it marks one whose execution began
before the mark existed. The refusal of any other unmarked sprint tells the
owner how to add the mark to a sprint they approved.

## Rationale

The planning story promises a signed-off sprint so that any executor
can act on it, and the weight of the owner's sign-off rests on corpus
change arriving only through approved deltas (see also:
final-form-deltas). A draft that a session left when it died before
approval looks like an approved sprint, so an executor pointed at it
would build work the owner never approved. The mark records the
sprint's state on the file itself, as the closing commit's stamp does
for an archived sprint (see also: closing-commit-baseline). The
refusal sits at every executor, where the harm would happen.

## Alternatives

- Owe only that the session ends in a signed-off sprint, and leave a
  dead session's draft for the owner to discard: an executor pointed
  at the draft runs it, and nothing warns.
- Exempt no unmarked sprint: a sprint whose execution began before
  the mark existed stops until the owner marks it.
- Write the draft under a draft name and rename it at approval: every
  reference written during planning moves at the last step, and an
  executor handed the draft name still runs it.
