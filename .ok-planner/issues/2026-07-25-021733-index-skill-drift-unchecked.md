---
issue: index-skill-drift-unchecked
kind: discover
category: inconsistent
artifacts:
  - concept:skill
  - story:session-awareness
status: verified
opened: 2026-07-25T02:17:33Z
---

# The hub's skill table is hand-written, restates the skills, and drifts unchecked

ok-planner's hub skill carries a hand-written table summarizing every skill; true-up copies it verbatim into the estate as the session-start briefing; nothing generates it from the skills it describes or checks it against them. It drifts: re-verification found two of four originally-flagged mismatches already fixed by unrelated commits, but two still live — the hub's sketch row still ends "sketch → `/plan-sprint` → spec" (a noun the suite retired for "sprint"), and the materialized banner says skills are invoked "only when the user types a slash command," omitting the documented second activator (a completion-contract executor). The pattern is structural: prose that restates other prose, with no reconciliation mechanism, redrifts after every fix.

The corpus documents the index as "a briefing, not a verb" (`concept:skill`) and requires it to "reflect the installed plugin" (`story:session-awareness`) without saying whether that means generated-from or hand-kept-in-sync. The suite's one precedent for a summary index of this shape — the catalog TOCs — is generated and audit-checked; the skill index is neither. A live consideration for the same planning session: the pending context-unhobbling sketch (2026-07-25) proposes retiring the injected index entirely and shrinking the hub table to one-liners, which would shrink this issue's surface to the hub file alone — the two should be ruled together.

## Options

- **Derive the table from frontmatter** — each row generated from its skill's `description`; drift becomes impossible. Loses the richer hand-written prose (or rather, forces that richness into the descriptions, where it is single-sourced).
- **Keep hand-written rows, add an audit staleness check** — smaller change; still driftable between runs.
- **Status quo** — the state the issue exists to end.

The ruling decides: generation, checking, or neither — ideally decided alongside the context-unhobbling work that reshapes the same surface.

## Ruling

> Recommended ruling (/verify-issues): derive the table from frontmatter — the hub's per-skill rows become generated one-liners sourced from each skill's own description, and the two currently-stale rows are fixed in the same act; rule together with the context-unhobbling sketch, which independently shrinks this surface.
>
> Rationale: the drift class exists because the same facts live in two hand-maintained places; generation removes the class rather than patrolling it, matches the catalog-TOC precedent, and points the same direction as the pending unhobbling work — a checker on hand-written prose would harden exactly the duplication that work proposes to retire.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
