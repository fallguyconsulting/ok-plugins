---
issue: markdown-files-block-filing
kind: human
category: tooling
artifacts:
  - decision:issue-records-in-one-file
  - decision:issue-writes-through-one-module
  - story:converge-project-estate
status: open
opened: 2026-10-05T21:11:55Z
---

# The intake module refuses to file a new issue while any markdown issue file stands under `.ok-planner/issues/`

## Problem

The intake module `.ok-planner/bin/issues` (ok suite v25.0.0) refuses every verb but `import` while a markdown file stands directly under `.ok-planner/issues/`. `read_store` lists that folder before each verb and raises:

> .ok-planner/issues holds 4 markdown issue file(s), the retired intake (…); run /ok and accept its markdown-intake offer to convert them

So a project upgraded to v25 cannot file one issue until the owner converts every leftover markdown file. Every writer of the intake stops: `/converge`'s owner list, `/triage-issues`, the audit's judge, `/plan-sprint`, and a human filer. A converge run that ends with defects outside its scope has nowhere to put them. A conversion that fails also blocks filing. In the consumer project linescout, the `markdown-intake` resolve failed because an old pre-v9 event log stood at `.ok-planner/history/issues.jsonl` (filed separately as `history-event-log-blocks-intake-import`). The intake then took no new issue until the owner committed a fix by hand.

The owner's ruling on intent: lingering markdown files should not block filing new issues. Appending a record touches only `.ok-planner/issues.jsonl`, and no markdown file can collide with that write, except through a shared id.

## Candidates

- Let `file` (and the other verbs that only append or rewrite records) run while markdown files stand. Refuse only an id that a standing markdown file's `issue:` value already claims, so a later conversion cannot collide. Keep the refusal for reads that claim to show the whole intake, or have them print a warning naming the unconverted files.
- Let every verb run, and have each read print one warning line naming the unconverted files and the `/ok` offer, in place of the refusal.
- Have the intake module read standing markdown files as open records in memory, so every verb sees the whole intake, until `/ok` converts them.

## Ruling
