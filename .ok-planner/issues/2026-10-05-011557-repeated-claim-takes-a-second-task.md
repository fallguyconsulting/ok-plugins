---
issue: repeated-claim-takes-a-second-task
kind: human
category: tooling
artifacts: []
status: open
opened: 2026-10-05T01:15:57Z
---

# An agent that repeats `tasks claim --agent <profile>` takes a second task and works both

## Problem

A consumer project, linescout, saw one agent hold two running tasks in one run. In run `converge-2026-10-04T024708`, round 2, an `ok-opus` drive agent claimed t22, ran the claim verb again, took t24, and drove both stories in one context. Its session note reads: "the tracker has no verb to release a claimed task, so the agent drove both." The second task ran without a fresh agent's cached prefix. An agent that had stopped instead would have left t24 running with nobody working it.

Three sites allow it:

- `plugins/ok/families/ok-planner/scripts/tasks::cmd_claim`. Without a task id, the verb takes `oldest_issued(run, args.agent)`, the oldest issued task for the profile, whatever the caller already holds. It records the profile name alone, so it has no agent identity to refuse a second claim by.
- `plugins/ok/families/ok-planner/agents/ok-opus.md` and its sibling profiles `ok-haiku.md`, `ok-audit.md`, and `ok-review.md`. The profile says "Run `.ok-planner/bin/tasks claim --agent ok-opus`". It says nothing about running the verb once, or about how to give back a task claimed by mistake.
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_retry`. The verb that releases a running task is named `retry`, and its parser, `sub.add_parser("retry")`, declares only the `task` argument and no help text, so an agent looking for a release does not find it.

## Candidate

- The agent profiles say to run the claim verb once, and name the verb that releases a task claimed by mistake.
- The tracker gains a `release` verb, or names the release in `retry`'s help, and the profiles cite it.
- The claim verb takes an agent identity and refuses a second claim while that agent holds a running task. The harness gives a subagent no identity today, so the suite would have to mint one.

## Ruling
