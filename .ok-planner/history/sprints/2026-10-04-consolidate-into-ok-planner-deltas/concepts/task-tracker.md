---
concept: task-tracker
aliases:
  - tracker
  - task ledger
  - ledger
---

# Task tracker

## What it is

A task tracker is the durable record of one run of agent work: the tasks an orchestrator files, what agents record while they work, and what became of each. The record outlives the session that drove the run, so a later reader learns what ran and what each task produced from the record alone.

## Purpose

The tracker lets many fresh agents share one run without a standing agent relaying work by message: each agent takes its task from the record, and each leaves its result there. Whoever reports on the run reads the record instead of a transcript.

## Boundaries

A task tracker is not a plan: it keeps only what was filed (see also: no-execution-engine under decisions). It is not an engine: it decides nothing and judges nothing, and the agents that take its tasks do the work. It is not the issue intake (see also: issue, defect). It is not the completion report (see also: completion-report, sprint).
