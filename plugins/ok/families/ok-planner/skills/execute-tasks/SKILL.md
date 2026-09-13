---
name: execute-tasks
description: "ONLY activated by explicit /execute-tasks slash command, or by a ceremony draining the run it filed. Never auto-triggered by conversation content. Drains the task tracker's selected run: calls next, starts as many agents of each profile as the count it prints, up to the concurrency cap, every agent under one identical message that names no task, runs each exec task itself, stamps usage on each task as its agent returns, and stops at done, at waiting, or at a task nobody claimed. Files nothing and judges nothing."
---

# Execute tasks (drain the tracker)

The drain loop over the task tracker at `.ok-planner/bin/tasks`. The tracker is the record of one run: tasks an orchestrator filed, items agents filed into keyed pools, and the events between them. This skill runs what the tracker holds and files nothing into it. Whoever filed the tasks decides what runs; this skill decides nothing. Until a ceremony files runs of its own, a run is built by hand with the tracker's verbs: `init`, `agent register`, `prompt register`, `file`, and `item add`.

**The reason this loop exists is the prompt cache.** Every agent this loop dispatches is one of the vendored profiles under `.claude/agents/` (`ok-opus`, `ok-sonnet`, `ok-haiku`, `ok-audit`, `ok-review`). A profile's frontmatter pins the model and the effort, and its body is the claim protocol: the agent runs `tasks claim --agent <profile>`, which takes the oldest issued task filed for its profile under the run's lock and hands it that task's id, its registered prompt, its brief, and the pool items it consumes, and refuses a task filed for another profile. Every agent of one profile receives one identical first message that names no task, so the whole first request, the system prompt and the message together, is one cached prefix per profile per run: the first agent writes it and every later agent of the profile reads it. A message that differed by a task id would sit before the cache checkpoint and make every agent rewrite the prefix. The id reaches the agent through the claim's output instead, after the prefix. The claim is atomic, so two agents started together never take one task.

**The concurrency cap** is the number of agents this loop runs at once, across every profile: **8** unless the caller names another when it invokes the loop. Every dispatch and every tool call an agent makes is a permission request the harness classifies one at a time, and a larger batch overloads it.

## Preconditions

- `.ok-planner/bin/tasks` exists, and so do the profiles under `.claude/agents/`. Without either, say so and stop; materialization is the front door's administration (`/ok`).
- A run is selected. `tasks status` prints the run's name and file; if it fails with "no run selected", the caller names the file with `tasks use <path>` before invoking this skill. This skill never runs `tasks init`.

## The loop

Repeat until `next` prints `done` or `waiting`:

1. Run `.ok-planner/bin/tasks next`. It issues every task whose dependencies are closed and prints one line per profile that has issued tasks waiting for an agent, plus one line per ready exec task. A task already issued and not yet claimed is listed again with no second issue; it waits for a free slot. A running task never appears; the tracker leaves it to the agent that claimed it.
2. Act on the lines printed:
   - `run <profile> model=… effort=… count=N tasks=…` — start `N` fresh agents of the profile, or fewer where the cap leaves fewer slots: `subagent_type` set to the profile's name, `model` set to the `model=` value, and the fixed message below as the whole prompt of every one, no task id anywhere in it. The profile's frontmatter carries the effort. Fill the slots across profiles in the order the lines were printed. Where the cap is smaller than the sum of the counts, the tasks left over wait; the next call lists them again. When an agent returns, its final message is one line, `closed <task> <outcome>`; read the task id from it and run `tasks task set <task> --usage <subagent_tokens>` with the token count the harness reported for that agent.
   - `exec <task> <command>` — run `.ok-planner/bin/tasks exec <task>`. It runs the command from the project root with the tracker unlocked, then closes the task with the exit code and the output tail, and prints both. No usage is stamped; no agent ran.
   - `waiting <tasks…> [fork-of <task>=<root> …]` — every open task is running under an agent or waiting on a dependency. A task listed under `fork-of` is a pass task a running root filed for a fork of itself; `next` never issues one and `claim --agent` never takes one, since the fork claims it by id. When no agent this loop dispatched is still running, every task listed under `fork-of` is an orphan its fork never closed: run `tasks retry <task>` on each, which clears the mark, and call `next` again; it issues the task to a fresh agent of the profile, which claims it like any other. Otherwise nothing here is this loop's to run: stop and report the list; the caller decides. A task whose agent died while running is released with `tasks retry <task>`.
   - `done` — no open task remains. Stop.
3. Dispatch every agent of one call in one message so they run concurrently; the caller filed the tasks so that no two ready at once hold one file, and readers run beside anything. Stamp each task's usage as its agent returns. Call `next` again only after every agent has returned. An agent that returned without a `closed` line claimed nothing or died: where the next call lists a task that as many agents as tasks were started for and no agent claimed, stop and report it; the only move is `tasks retry <task>` on a task left running, then this skill again. Where the caller keeps a progress checklist in the harness task tools, mark the entry for a task's key in progress when its agent claims it and done when it closes `done`.
4. `tasks item count --pool <pool> [--key K] [--state S]` prints the count and exits 1 when it is zero. A caller's shell loop tests a pool with it; this loop never calls it.

**Every dispatch names its model and its profile.** The model comes from the `model=` field on the line, never from the session, and it equals the profile's own frontmatter, so the harness's precedence rule changes nothing. The profile's claim names the same profile, so an agent can take only a task filed for it. A missing profile file makes `next` fail with the file's path; report that and stop rather than guess.

## The fixed message

Dispatch every agent with exactly this message and nothing else. Do not add the task id, the role, the brief, or any context; the profile's system prompt carries the claim protocol, and the claim prints the rest. One character of difference between two agents' messages is a second cached prefix.

```
Claim your task and finish it.
```

## What this skill does NOT do

- Does not file tasks or items, start rounds, batch, or triage. Those are the caller's calls, made with the tracker's own verbs before or between drains.
- Does not read a task's brief, prompt, or items. The agent that claims the task reads them.
- Does not choose which task an agent takes. The claim takes the oldest issued task for the profile; the caller orders the run by filing order and `--after`.
- Does not judge an outcome. A `partial`, `blocked`, or `disputed` close is recorded for the caller to read from `tasks status` and `tasks report`; the loop moves to the next task.
- Does not retry a task on its own, except an orphaned `fork-of` task per the `waiting` line above. Otherwise it stops and reports.
- Does not initialize, snapshot, or archive a run. The run file belongs to the ceremony that created it.
- Does not converge an estate or materialize the tracker. That is `/ok`, always a user action.
