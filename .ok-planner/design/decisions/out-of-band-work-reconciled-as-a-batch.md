---
decision: out-of-band-work-reconciled-as-a-batch
---

# Planning reconciles work done out of band as one batch the owner reads once

## Choice

Over the window since the last closed sprint (see also:
closing-commit-baseline), planning's reconcile step flags each change
made outside a sprint that bears on the corpus. It drafts every
bearing change as corpus catches up: the sprint carries the deltas
that bring the corpus into agreement with the change. The owner sees
the whole batch in one summary at the reconcile step, apart from the
sprint's own work, one line per change with the deltas it drafts. The
owner may pull any change out of the batch and give it another
outcome. Code catches up: a work item restores the corpus's
commitment. Record and defer: an issue records the change, and the
sprint leaves what the change bears on as it is. A change that breaks
the contract of a public element stays out of the batch: the owner
picks its outcome alone, one change at a time, among the break
stands, code catches up, and record and defer (see also:
release-boundary). A direct edit to documentation joins the same batch
under a rule of its own (see also: out-of-band-documentation-reconciled).

## Rationale

Nearly every bearing change is work its author meant to keep, so a
walk that asks about each one asks the same question over and over.
Drafting each as kept and showing the batch in one summary keeps the
owner's decision and spends the owner's attention only on a change the
owner pulls out. Showing the batch apart from the sprint's own work
lets the owner read what landed out of band without sorting it from
what the sprint plans. A broken public contract stays a walk of its
own, because a break that stands breaks every caller outside the
project.

## Alternatives

- Walk each bearing change with the owner, one at a time — the owner
  weighs each change alone, and answers the same question once per
  change when nearly every answer keeps the work.
- Draft every change as kept and show no summary — no time spent at
  all, and a change the owner meant to undo lands in the corpus
  unseen.
- Put a broken public contract in the batch as well — one summary for
  everything, and a default that keeps the break reaches callers
  outside the project with no pick of the owner's behind it.
