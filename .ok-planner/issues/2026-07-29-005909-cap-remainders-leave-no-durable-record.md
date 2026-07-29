---
issue: cap-remainders-leave-no-durable-record
kind: human
category: unspecified
artifacts:
  - story:certify-completion
status: open
opened: 2026-07-29T00:59:09Z
---

# Should a violation still standing when the review-fix loop hits its cap terminate in an intake issue?

## Problem

When the certification review-fix loop reaches its cycle cap with a
violated determination still standing, the gate's prescribed terminal
state is a presentation reporting NOT certified, with the remainder
listed as "a stubborn defect list for the owner to direct manually,
never a promotion." The intake is reached only by the architect
promoting a fixer kickback — a confirmed intent fork. An inadequate fix
is not a fork ("inability is never grounds"), so a violation that
simply resists fixing never reaches the architect and never becomes an
issue. Its only durable trace is the violated audit file itself, which
`audit-check` flags as `violated-unlinked` — a state that blocks
certification but points at no record of the owner's pending decision.
If the session ends after a capped run, nothing in the estate's intake
tracks the unresolved defect; it lives only in the conversation's
presentation text.

Observed this sprint: `story:explain-lint-rules` stood violated at the
cap after multiple cycles; the presentation reported it; the owner then
had to direct the remainder from the chat transcript, with no issue
holding the question.

## Candidates

- Amend the certification gate so that, at the cap, each standing
  violated determination is filed to the intake as an issue (kind
  `audit`), stamped as the `issue:` link on the violated audit —
  satisfying `violated-unlinked` — and the presentation's Not certified
  section cites the filed issues. Promotion stays the architect's act
  for intent forks; this adds a second, mechanical filing path scoped
  to cap-remainders only.
- Keep the gate as written (cap-remainders are the owner's manual
  defect list) and rely on the violated audit file plus the goal/sprint
  staying in flight as the durable signal.
- File nothing automatically, but require the presentation's close to
  offer filing as an owner act, alongside archive-and-commit.
