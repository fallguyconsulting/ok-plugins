---
name: execute-sprint
description: "ONLY activated by explicit /execute-sprint slash command. Never auto-triggered by conversation content. Executes a sprint to completion by setting the unsupervised work-to-completion framing and firing the native `goal` mechanism at the sprint, closing with `/certify`."
---

# Execute a Sprint

Drive a sprint to a certified done. This skill is a **thin launcher**, not the builder: it resolves the sprint, assembles the execution framing, and fires the native `goal` mechanism pointed at that framing. The building — staging, applying deltas, writing code and proofs — happens inside the goal-driven loop, where the Stop hook keeps the executing agent working until the goal is met. The agent is free to dispatch subagents to preserve its own context.

This is ok-planner's return to an **agent-with-subagents** orchestrator, working directly from the one sprint document — no spec-plus-plan split, no `Workflow` engine. The sprint is the whole brief; `goal` is the completion enforcer; `/certify` is the closing gate.

## What this skill is NOT

- Not the builder. It fires `goal` and stops; it does not stage, edit code, apply deltas, or write proofs itself. Those happen under the goal.
- Not a planner. It never rewrites the sprint into a plan document — ok-planner has no plan artifact.
- Not `Workflow`-driven. The control flow is an ordinary agent working under a goal, dispatching subagents as the work warrants.

## Process

1. **Resolve the sprint.** The argument names a file under `.ok-planner/sprints/`. If omitted and exactly one sprint is in flight there, use it (say which). If none or several and none named, ask which — this is the one blocking question; everything downstream depends on it.

2. **Read the sprint whole.** Deltas, work items, completion contract — all of it — before assembling the prompt. If the sprint is malformed or empty, stop and report; there is nothing to execute.

3. **Assemble the goal prompt.** The prompt is the execution framing below with the sprint path substituted. It is the entire brief the goal-driven agent runs on.

4. **Fire `goal` with that prompt.** Invoke the native `goal` mechanism (the same one `/goal` uses) with the assembled prompt, so its Stop hook drives the agent to completion. If this session cannot self-invoke `goal` — it is a harness command, not an ok-planner skill — fall back to presenting the assembled prompt to the user and instructing them to run `/goal <prompt>` themselves. Either way, the assembled prompt is the deliverable this skill produces.

5. **Stop.** Firing the goal is this skill's terminal act. The goal owns completion from here; `/certify` (named as the goal's last step) owns certification and archival. Do not begin building in this skill.

## The execution framing (the goal prompt body)

Substitute `<SPRINT PATH>` and fire this as the goal:

```
Execute sprint <SPRINT PATH> to completion, then certify it.

You are the executor. Work unsupervised to a defensible done — do not
pause for approval, confirmation, or a progress check. Stop only on a
genuine blocker: a credential or access you lack and cannot obtain, a
step literally impossible in the current state, or a destructive/
irreversible action not clearly authorized. Ambiguity is not a
blocker — pick the most plausible reading and continue, surfacing the
choice at the end.

1. Read the sprint whole first — deltas, work items, completion
   contract. It is self-sufficient by construction: do not go looking
   for context behind it (not in issues.jsonl, not in history/). A
   genuine gap is raised with the owner, never filled by inference.

2. Stage the work yourself. The work items are a flat, unordered list;
   group them by theme, file surface, or dependency and order the
   groups so nothing is built on something not yet there. Keep the
   staging in your working state (a task list) — never write a plan
   document; the sprint is never rewritten into one.

3. Apply each corpus delta as part of the work that realizes it — copy
   the final-form body into design/ verbatim, or delete the file for a
   retirement. A delta no work item implements (a clarification, a
   retirement) is applied on its own.

4. Build stage by stage. Every new or amended story and decision gets
   its proof: present, carrying its @story:/@decision: annotation, and
   able to actually fail under a producible falsifier. Write the proof
   with the work, not at the end.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a TODO in place of a promised outcome. A capability the
   sprint's deltas or work items promise is delivered in full, or the
   blocker that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as you finish each
   stage (git add -A) so a stray revert cannot reach it. Never run
   git checkout/restore/reset/stash/clean on your own initiative; fix
   a bad edit forward by editing again.

7. Use subagents freely to preserve your context. Dispatch independent
   or large stages to subagents and keep the synthesis; you own
   completion regardless of how the work is divided.

When the build is complete, run /certify to bring the work into
alignment with this sprint, drive every fixable finding to clean,
present the outcomes and any divergences, and archive the sprint.
The goal is not met until /certify reports the implementation
certified.
```

## Relationship to the completion contract

The sprint's completion contract (corpus matches deltas → `/prove` clean → `/audit` last) is not bypassed — it is realized inside `/certify`, which the goal prompt names as its terminal step. `execute-sprint` sets the frame and the enforcer; `/certify` discharges the contract and archives. A sprint executed this way is done exactly when `/certify` certifies it.
