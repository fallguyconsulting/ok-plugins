---
issue: events-are-a-logging-discipline-enforced-by-review
kind: human
category: design
artifacts:
  - story:inventory-event-kinds
  - decision:event-kinds-as-conventioned-strings
status: open
opened: 2026-10-04T05:20:00Z
---

# The events standard reaches every review prompt, but no accept-list entry makes a breach of it a defect

## Problem

The events standard, `plugins/ok/families/ok-plumbline/docs/events.md`, says where code emits an event (every caught error, every owner frame's catch-all, every retry after the first), what an event is ("a kind plus structured fields"), and how a kind is named (`SUBSYSTEM.NOUN.VERB`, a raw string literal at the emitting site). It says "Code review enforces it."

`/converge` pastes the standard into every hunt, fix, and verify prompt through `standards` in `.ok-planner/review/config.json`. But the accept list decides what a review counts as a defect, and its entry A8 names only three sources: `.claude/rules/plumbline-coding.md`, the code-rule files `.ok-planner/review/project.md` lists under `## Code rules`, and the live design corpus. The events standard is none of the three. A hunter reads it and cannot file a breach of it, so nothing enforces it.

The standard also carries an inventory: `/events` runs `plumbline events .`, which matches every kind-shaped string literal in the tree and prints each kind with its sites. `story:inventory-event-kinds` promises the list "so that I can reuse an existing kind instead of adding a near-duplicate." Events serve someone debugging from a log with the code in hand: they grep the kind from the log line and land on the site. A tree-wide list of kinds serves no one in that work.

## Candidates

- Name the events standard as a source in A8, so review files a breach of it as a defect, and retire `/events`, `plumbline events`, and the inventory.
- Name the events standard in A8 and keep the inventory.
- Leave both as they are.

## Ruling

Events are a logging discipline, enforced by review. Name the events standard as one of A8's sources, so a site the standard decides and the code breaks is a defect that `/converge` fixes. Retire the inventory: the `/events` skill, the `events` subcommand of the lint, the standard's inventory section, the rule that an author reads the inventory before adding a kind, and the story that promises the list. A kind still names one meaning across the tree, so a grep from a log line finds every site that emits it. The decision on event kinds keeps its naming convention and drops the inventory from its choice.
