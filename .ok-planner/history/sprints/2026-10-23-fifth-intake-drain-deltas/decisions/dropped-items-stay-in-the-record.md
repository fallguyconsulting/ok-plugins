---
decision: dropped-items-stay-in-the-record
---

# An orchestrator drops an item, and the record keeps it with its removal

## Choice

An orchestrator removes an item an agent filed into a task tracker's
pool by dropping it. The drop appends a removal to the record, naming
who dropped the item and why. Every read the tracker serves leaves a
dropped item out, save a dump of the whole record, and the record
keeps both the item and its removal.

## Rationale

A later reader learns what each task produced from the record alone
(see also: task-tracker). A removal kept beside its item keeps that
true: the record shows what the agent filed, that someone removed it,
who, and why. The tracker's own reads leave the item out, so one place
decides what a dropped item is, and a reader added later cannot read a
dropped item by mistake. The tracker judges nothing: the orchestrator
decides to drop, and the tracker records that act as it records a
filing (see also: decision:no-execution-engine). Without a drop, the
only removal is a rerun of the agent that filed the item. On one project that rerun
would have cost about 280,000 tokens for five mistaken items, so the
owner edited a run file by hand instead.

## Alternatives

- A dropped state each pool declares: every reader of a pool must skip the state, and a reader that does not reads a dropped item.
- No drop, so only a rerun of the filing agent replaces its items: the record never shows an orchestrator's judgment, and a small removal costs a whole agent run.
- Delete the item's lines from the run file: the record no longer shows what the task produced.
