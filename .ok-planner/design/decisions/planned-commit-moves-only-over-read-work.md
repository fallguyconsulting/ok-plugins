---
decision: planned-commit-moves-only-over-read-work
---

# A documentation plan's commit moves past the handoff's commits only where they hold what the plan read

## Choice

A documentation sprint records the commit and the tree its plan read,
and its run's start check weighs every commit after that commit
against the plan. When planning's handoff commits the owner's
uncommitted work, it moves the recorded commit to the new head only
where those commits hold nothing the plan did not read: the head
before the first of them is the plan's commit, and no path they name
differs from the tree the plan read. Otherwise the recorded commit
stands, and the start check weighs the handoff's commits like any
other (see also: docspec-stamp-opens-the-window).

## Rationale

The handoff commits work that stood uncommitted when the plan read the
tree, so the plan already read it, and counting those commits against
the plan would stop the run and send the owner back to plan again for
work the plan covers. A commit made after the plan read the tree, or a
path changed since then, may hold product work the plan never read.
Moving the recorded commit past such work hides it from every
documentation sprint, since the stamp the run writes then opens the
next window after it. Moving the commit only over what the plan read
keeps both: the handoff's own commits never stop the run, and a change
made after the plan reaches a documentation sprint. The cost is that
every plan records the tree it read beside its commit.

## Alternatives

- Move the recorded commit to the new head after every handoff — no
  tree to record, and product work committed after the plan read the
  tree reaches no documentation sprint.
- Never move it, so the start check weighs the handoff's commits too —
  one rule with no comparison, and a handoff commit that touches what a
  planned docspec covers makes the owner plan again for work the plan
  already read.
