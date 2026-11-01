---
decision: live-sprints-brought-current-on-true-up
---

# True-up brings every sprint not yet archived current

## Choice

True-up brings each sprint, documentation sprint, and test sprint not
yet archived to the structure and boilerplate the carried release
reads, and leaves the rest of it as written. In a sprint, it brings
the retired boilerplate current, line for line. In a documentation
sprint or a test sprint, it brings the plan's shape current, such as
filling a field the carried tools require from the project's
configuration. Each change to the shape of any of the three ships
with the true-up step that brings an approved one forward. When to
true up is the owner's choice, and the suite does not rely on the
owner truing up between runs.

## Rationale

A sprint of any kind not yet archived is the one record an executor still
acts on, and its boilerplate and plan shape are what the carried tools
read; a line naming a retired path, or a plan missing a field the
tools now require, sends the executor to something that no longer
works. Bringing it current changes no work the owner approved. The
owner decides when to true up, so the suite meets a sprint wherever it
stands.

## Alternatives

- Leave approved sprints as written: a sprint planned under an earlier
  release runs retired steps, and a test sprint's plan fails the
  carried tools.
- Ask the owner per sprint: a question every migrated project meets on
  its first true-up.
- Bring only sprints current, and have the owner true up only after a
  documentation sprint or test sprint closes: the suite constrains
  when the owner may true up, and an early true-up costs a new plan.
