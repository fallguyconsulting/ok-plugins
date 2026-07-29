---
issue: cap-remainders-leave-no-durable-record
kind: human
category: unspecified
artifacts:
  - story:certify-completion
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
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

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29).
At the cap there are exactly two process steps, and the gate
encourages the owner to take one: run another cycle, or escalate the
remainders as issues and continue to /verify-issues. On escalation,
each remaining finding is filed to the intake (kind audit, the
finding verbatim, the attempted fixes as evidence), each violated
audit gets its issue: link stamped, and the run then presents the
sprint and offers archive-and-commit like any other — the cap
changes nothing about the ceremony. Unattended runs escalate by
default. No new artifact kind: the issues are the durable record.
The former terminal state — NOT certified, no offer, "finished out
manually" — is removed. Implemented in plugin source
(certification-core's exit rule, intake-paths paragraph, and
presentation template; both certify gates' verify step, close-out,
and touchpoint bullet). This issue stays open so the next sprint
ratifies; the work ships with the next release/re-vendor.
