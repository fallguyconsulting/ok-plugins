---
issue: tasks-item-add-accepts-a-task-the-run-lacks
kind: audit
category: defect
artifacts:
  - story:veto-calls-made-in-my-absence
status: promoted
triage: defect
opened: 2026-10-04T23:34:00Z
sprint: 2026-10-05-drain-the-intake.md
---

# `tasks item add` records an item against a task the run does not hold

## Problem

The site is `plugins/ok/families/ok-planner/scripts/tasks:add_item`, reached from `tasks:cmd_item`. The accept-list entry is A3: an end user can break the product. `scripts/tasks` is a script `.ok-planner/review/project.md` lists for developers and operators, and a wrong value gives a wrong result with no error that tells the user what they did wrong.

Trigger: an agent passes a mistyped or stale task id to `tasks item add --task`.

The command stores the `--task` value as given and exits 0. Evidence, at `tasks:959`, `rec = add_item(run, args.pool, args.key, read_body(args.body), args.fingerprint, args.task,`, and at `tasks:625`, `"producer": producer, "task": task, "fields": fields or {},`, with no lookup of the task between them. The sibling `tasks:cmd_close` looks the id up through `Run.task`, which fails with `no task <id>`.

Re-verified at this tree in a scratch run: `tasks item add --pool divergences --key x --body y --task t99` printed `i1` and exited 0; `tasks close t99 ...` printed `tasks: no task t99` and exited 2; `tasks render` listed `i1 (call, x, open) — y` under `## Divergences`.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/scripts/tasks:add_item` so a `--task` naming no task in the run no longer records an item and exits 0.
