---
issue: concept-instance-enumeration-altitude
kind: discover
category: other
artifacts:
  - concept:plugin
  - concept:skill
  - concept:conduct
status: promoted
opened: 2026-07-25T02:26:48Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# Two concept bodies enumerate current instances; two accused phrases are actually fine

The corpus's own authoring rules forbid a concept body from enumerating its current instances — "a concept body that reads as a list of 'things that currently exist' has descended below concept altitude" — because instance lists go stale silently and nothing lints them. Four phrases across three concepts were flagged; applying the rule phrase by phrase splits them cleanly:

- **Violations:** `concept:plugin`'s Purpose says "one lint binary" (a literal current count of a specific tool), and `concept:skill`'s Boundaries says "two plugins additionally ship an index skill" (a current count of which plugins do a thing). Both go stale the day a second lint tool or a third index skill ships, becoming false definitional claims with no check to catch them.
- **Not violations:** `concept:plugin`'s What-it-is lists concern *kinds* ("what to build, how code reads, where work happens, or the suite front door") — a taxonomy naming zero specific plugins; and `concept:conduct`'s rule list is the conduct's own substantive content — conduct is a singleton, so there is no instance list to descend into.

The rule decides the whole question; the only reason this file needs a ruling at all is that the fix is a corpus mutation (`design/` edits) reserved for a sprint.

## Options

- **Apply the rule** — strip the two counts, stating each property generally ("ships its lint binary…", "a plugin may ship an index skill…"); leave the taxonomy and the conduct rules untouched. Forced.

## Ruling

> Generated ruling (/verify-issues): the sprint deltas amend `concept:plugin` (Purpose loses the "one lint binary" count) and `concept:skill` (Boundaries loses the "two plugins ship an index skill" count), restating both properties generally; `concept:plugin`'s concern taxonomy and `concept:conduct`'s rule list stand as written. Forced by the concept-altitude rule in the shared artifact definitions.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
