---
name: execute-tasks
description: "ONLY activated by explicit /execute-tasks slash command, or by a ceremony draining the run it filed. Never auto-triggered by conversation content. Drains the task tracker's selected run: calls next, dispatches each task to a fresh agent of the vendored profile the task names under one fixed message, runs each exec task itself, stamps usage on each task as its agent returns, and stops at done, at waiting, or at a blocked task. Files nothing and judges nothing."
---

# Execute tasks (drain the tracker)

The drain loop over the task tracker at `.ok-planner/bin/tasks`. The tracker is the record of one run: tasks an orchestrator filed, items agents filed into keyed pools, and the events between them. This skill runs what the tracker holds and files nothing into it. Whoever filed the tasks decides what runs; this skill decides nothing. Until a ceremony files runs of its own, a run is built by hand with the tracker's verbs: `init`, `agent register`, `prompt register`, `file`, and `item add`.

**The reason this loop exists is the prompt cache.** Every agent this loop dispatches is one of the vendored profiles under `.claude/agents/` (`ok-opus`, `ok-sonnet`, `ok-haiku`). A profile's frontmatter pins the model and the effort, and its body is the claim protocol: the agent runs `tasks claim --agent <profile>`, which hands it the oldest issued task for that profile, the task's registered prompt, its brief, and the pool items it consumes. Every agent of one profile receives the same first message, byte for byte, so one system prompt and one message per profile per run means one cached prefix per profile per run.

## Preconditions

- `.ok-planner/bin/tasks` exists, and so do the profiles under `.claude/agents/`. Without either, say so and stop; materialization is the front door's administration (`/ok`).
- A run is selected. `tasks status` prints the run's name and file; if it fails with "no run selected", the caller names the file with `tasks use <path>` before invoking this skill. This skill never runs `tasks init`.

## The loop

Repeat until `next` prints `done`, `waiting`, or `blocked`:

1. Run `.ok-planner/bin/tasks next`. It prints one line: the oldest issued-and-unclaimed task, else the oldest ready task. For a round of independent tasks, run `tasks next --all` instead; it prints every issued-and-unclaimed task and every ready task, one line each. A running task never appears; the tracker leaves it to the agent that claimed it.
2. Act on each line printed:
   - `run <task> role=… prompt=… agent=… model=… effort=… [key=…]` — dispatch one fresh agent with `subagent_type` set to the `agent=` name, `model` set to the `model=` value, and the fixed message below as its whole prompt. The profile's frontmatter carries the effort. When the agent returns, its final message is one line, `closed <task> <outcome>`; read the task id from it and run `tasks task set <task> --usage <subagent_tokens>` with the token count the harness reported for that agent.
   - `exec <task> <command>` — run `.ok-planner/bin/tasks exec <task>`. It runs the command from the project root with the tracker unlocked, then closes the task with the exit code and the output tail, and prints both. No usage is stamped; no agent ran.
   - `waiting <tasks…>` — every open task is running under an agent or waiting on a dependency. Nothing here is this loop's to run. Stop and report the list; the caller decides. A task whose agent died while running is released with `tasks retry <task>`.
   - `blocked <task> <reason>` — `next` issued the task twice, no agent claimed it, and `next` closed it as blocked. That close is the one write `next` makes. Stop and report it. The only move is `tasks retry <task>`, then this skill again.
   - `done` — no open task remains. Stop.
3. Where several `run` lines were printed together, dispatch them in one message so they run concurrently. Stamp each task's usage as its agent returns. Call `next` again only after every agent has returned. A `blocked` line mixed into the batch is reported after the batch's agents return; the batch still runs.
4. `tasks item count --pool <pool> [--key K] [--state S]` prints the count and exits 1 when it is zero. A caller's shell loop tests a pool with it; this loop never calls it.

**Every dispatch names its model and its profile.** The model comes from the `model=` field on the line, never from the session, and it equals the profile's own frontmatter, so the harness's precedence rule changes nothing. The profile's claim names the same profile, so an agent can take only a task filed for it. A missing profile file makes `next` fail with the file's path; report that and stop rather than guess.

## The fixed message

Dispatch every task with exactly this message and nothing else. Do not add the task id, the role, the brief, or any context; the profile's system prompt carries the claim protocol, and the claim prints the rest.

```
Claim your task and finish it.
```

## What this skill does NOT do

- Does not file tasks or items, start rounds, batch, or triage. Those are the caller's calls, made with the tracker's own verbs before or between drains.
- Does not read a task's brief, prompt, or items. The agent that claims the task reads them.
- Does not judge an outcome. A `partial`, `blocked`, or `disputed` close is recorded for the caller to read from `tasks status` and `tasks report`; the loop moves to the next task.
- Does not retry a task on its own. It stops and reports.
- Does not initialize, snapshot, or archive a run. The run file belongs to the ceremony that created it.
- Does not converge an estate or materialize the tracker. That is `/ok`, always a user action.
