---
decision: live-sprints-brought-current-on-true-up
---

# True-up brings every sprint and documentation sprint not yet archived current

## Choice

True-up brings each sprint and documentation sprint not yet archived
to the structure and boilerplate the carried release reads, and leaves
the rest of it as written. In a sprint, it brings the retired
boilerplate current, line for line. In a documentation sprint, it
brings the plan's shape current, such as filling a field the carried
tools require from the project's configuration. Each change to the
shape of either ships with the true-up step that brings an approved
one forward. A test sprint an earlier release left open is no kind
the carried release runs, so true-up moves it to the archive as it
stands instead, and files one intake issue naming it. True-up's
conversion clears the test stamp of each story the abandoned run
planned, so each such story returns as untested or stale, and planning
offers it where `testing.enabled` is `on` and `testing.offers` lists
that kind (see also:
testing-runs-inside-the-sprint, scenario-list-decided-once). When to
true up is the owner's choice, and the suite does not rely on the
owner truing up between runs.

## Rationale

A sprint or documentation sprint not yet archived is the one record an
executor still acts on, and its boilerplate and plan shape are what
the carried tools read; a line naming a retired path, or a plan
missing a field the tools now require, sends the executor to
something that no longer works. Bringing it current changes no work
the owner approved. The owner decides when to true up, so the suite
meets a sprint wherever it stands. A test sprint left open has no
executor in the carried release. Archiving it as it stands keeps its
record whole, the intake issue puts the unfinished run in front of the
owner, and the untested and stale offers bring its unwritten work back
through the sprints the owner already runs.

## Alternatives

- Leave approved sprints as written: a sprint planned under an earlier
  release runs retired steps, and a documentation sprint's plan fails
  the carried tools.
- Ask the owner per sprint: a question every migrated project meets on
  its first true-up.
- Bring only sprints current, and have the owner true up only after a
  documentation sprint closes: the suite constrains when the owner may
  true up, and an early true-up costs a new plan.
- Run an open test sprint to its end under the retired boilerplate:
  the carried release keeps tools and prompts alive for one record.
- Convert an open test sprint into a sprint: its plan was approved
  without the sprint's deltas and work items, so the conversion writes
  approved intent the owner never saw.
