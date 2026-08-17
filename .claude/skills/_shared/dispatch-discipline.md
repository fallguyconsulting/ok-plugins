# Dispatch discipline

Rules for how ok-planner skills dispatch subagents and how those subagents behave. Three tiers: the **leaf rule** for dispatches whose scope is known at dispatch time, the **worker-pool rule** for long streams of same-shaped items fed by message, and **guidance** for open-ended dispatches. Transclusion follows `artifact-definitions.md`: replace each `{{TOKEN}}` with the body of the matching block. When a skill body cites a token from this file, name the file (`{{LEAF-AGENT-RULE}} from ../_shared/dispatch-discipline.md`).

---

### {{LEAF-AGENT-RULE}}

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

---

### {{READ-ONLY-REVIEWER-RULE}}

You are a reader and a judge. Your evidence is the files and records as they stand. Your execution surface is read-only commands: searches (`rg`) and git inspection (`git log` / `diff` / `status`). Never run tests, builds, deployments, experiments, or the project's stack; execution belongs to the gate that dispatched you. If a judgment requires something to be run, report that need as a line in your findings and judge the rest without it.

---

### {{WORKER-POOL-RULE}}

How a ceremony runs a long stream of same-shaped items where the harness supports cross-agent messaging (spawn an agent, send it follow-up messages, read its task notifications). Where it does not, fall back to bounded batches per `{{DISPATCH-DISCIPLINE}}`: five to ten related items per dispatch, splitting any batch whose shared reading set exceeds what one agent can hold.

- **Spawn once, feed by message.** Start N workers per instrument, each with its full working prompt and an item list reading "items arrive one at a time by message; stand by". Feed one item per message. The worker completes it, writes its output, reports one line, and stands by.
- **Route for locality.** Send consecutive items to the worker already holding the relevant code or surface elements, so shared context is read once.
- **Retire by measured context.** Each task notification carries the worker's token count (`subagent_tokens`): the context it carries now, not a running tally. It can dip between rounds; read the current number each time. Retire a worker when it finishes an item and its last round exceeded ~300k tokens, and spawn a replacement so N holds. The threshold assumes a 1M-token window; scale it on smaller windows.
- **Quiet is not finished.** A worker that stops responding is a liveness problem: stop it and redispatch its item to another worker. Retirement follows only a completed item.
- **The pool never judges.** Workers produce. Whatever needs a second opinion goes to the one terminal judge the consuming ceremony dispatches outside the pool.

---

### {{DISPATCH-DISCIPLINE}}

Rules for dispatching subagents, and for open-ended agents that may need to:

- **Batch per-item work.** Never one agent per item. Group ~10 related items per agent; the agent reads shared context once and reuses it.
- **Dispatch subagents only when scope demands it.** Every agent has a 1M-token context; a large reading set is not a reason to fan out. Fan out for parallel work across independent surfaces, or work that exceeds one context.
- **Shared context travels once.** The dispatcher pastes it into the prompt, or the agent reads it once up front.
- **Every dispatch names its model, and model follows the job.** Investigation, relevance, and compliance-reading jobs: sonnet. Coding, fixing, writing, and code-review jobs: opus. Mechanical single-shot lookups: haiku. The session model is never a subagent model: an omitted `model` inherits it and a fork always does, so neither is used. Do not upgrade reads or downgrade fixes.
- **Leaf dispatches carry the leaf rule.** Any agent you dispatch whose scope is known gets `{{LEAF-AGENT-RULE}}` in its prompt.

<!-- Materialized by ok-planner v18.6.2 — suite-owned; overwritten on converge; do not hand-edit. -->
