---
issue: workspaces-audit-story-home
kind: discover
category: other
artifacts:
  - story:isolated-parallel-workspaces
  - story:rules-compliance-report
status: verified
opened: 2026-07-25T02:26:48Z
---

# One audit verb is claimed by two stories, and only one of them can actually fail

ok-workspaces' read-only `/audit` (worktree naming, runtime isolation, mutable-tag residue) is claimed as an outcome by two story files at once. `story:isolated-parallel-workspaces`' Acceptance ends with "a read-only audit verb separately reports discipline residue… for the owner to direct" — but its Falsifier covers only open/collision mechanics, so an audit regression would never falsify it by its own stated test. `story:rules-compliance-report` claims the same outcome at full generality ("each rules-bearing plugin delivers this over its own rulebook") and its Falsifier ("real drift goes unreported") genuinely covers a workspaces-audit regression. Same verb, two claimants, one working guard.

The corpus's own rule decides this: `story-artifact`'s invariant says "two stories describing the same user outcome through different surfaces are one story" — and here it isn't even different surfaces, it's the identical verb. The rule forces consolidation; picking the survivor is the only judgment, and it is thin: `rules-compliance-report` already covers the outcome correctly with zero changes, while keeping the clause in the isolation story would require building new falsifier machinery to fix a gap consolidation makes moot.

## Options

- **Consolidate into `rules-compliance-report`** — trim the audit clause from `isolated-parallel-workspaces`' Acceptance; the receiving story needs no edit. Cost: a reader of the isolation story must follow the pointer for the audit outcome.
- **Keep both, grow the isolation story a falsifier and carve out workspaces from the general story** — new machinery plus an unusual carve-out in a story whose point is generality, to preserve a duplication the invariant forbids.

## Ruling

> Generated ruling (/verify-issues): consolidate — the sprint delta trims the audit-verb clause from `story:isolated-parallel-workspaces`' Acceptance (a see-also pointer to `story:rules-compliance-report` is fine), leaving the general story as the outcome's sole owner. Forced by `story-artifact`'s one-outcome-one-story invariant; the survivor choice follows from which story's falsifier already protects the outcome.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
