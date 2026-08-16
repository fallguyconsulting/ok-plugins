# Dispatch discipline

Canonical rules for how ok-planner skills dispatch subagents, and how those subagents behave. Three tiers: a **leaf rule** (hard prohibition) for batched and single-job dispatches whose scope is fully known at dispatch time, a **worker-pool rule** for long streams of same-shaped items fed over cross-agent messaging, and **guidance** for open-ended dispatches whose scope only reveals itself mid-flight. Same transclusion convention as `artifact-definitions.md`: replace each `{{TOKEN}}` with the body of the matching block. Cite the source when referencing a token from a skill body (`{{LEAF-AGENT-RULE}} from ../_shared/dispatch-discipline.md`) so the assembler knows where to read.

---

### {{LEAF-AGENT-RULE}}

You are a **leaf agent**: NEVER spawn subagents — no delegation of reading, searching, or verifying; do ALL of it yourself with Read/Grep. You have a 1M-token context: needing to read many files is never a reason to delegate. Read shared context (the design catalogs, canonical rule files) once, up front, and reuse it across every item you handle.

This rule binds the **dispatched job it is embedded in**, and nobody else. It never licenses skipping work: if an instruction you are bound to follow requires dispatching subagents, surface the conflict to your dispatcher — never silently drop the step.

---

### {{READ-ONLY-REVIEWER-RULE}}

You are a reader and a judge: your evidence is the files and records as they stand. Read-only commands are your whole execution surface — searches (`rg`) and git inspection (`git log` / `diff` / `status`). Never run tests, builds, deployments, experiments, or the project's stack — ad hoc execution is how reviewers corrupt the state they are judging, and execution belongs to the gate that dispatched you (which decides how anything is run). If a judgment genuinely requires something to be run, report that need as a line in your findings and judge the rest without it — never run it yourself.

---

### {{WORKER-POOL-RULE}}

How a ceremony runs a long stream of same-shaped items — audit
determinations are the canonical case — where the harness supports
cross-agent messaging (spawning an agent, sending it follow-up
messages, and reading its task notifications). Where it does not,
fall back to bounded batches per `{{DISPATCH-DISCIPLINE}}`: five to
ten related items per dispatch, splitting any batch whose shared
reading set is too large for one agent to genuinely hold and read.

- **Spawn once, feed by message.** Start N workers per instrument,
  each with its full working prompt and an item list reading "items
  arrive one at a time by message; stand by". Feed each worker one
  item per message; it completes the item, writes its output, reports
  one line, and stands by.
- **Route for locality.** Send consecutive items to the worker
  already holding the relevant code or surface elements — the pool's
  entire economy is that shared context is read once and reused
  across the stream.
- **Retire by measured context.** Each task notification carries the
  worker's token count (`subagent_tokens`): a per-request measure of
  the context the worker is carrying now, not a running tally — it
  can dip between rounds, so read the current number each time, no
  trend. Retire a worker when it finishes an item and its last round
  exceeded ~300k tokens, and spawn a replacement so N holds. The
  threshold assumes a 1M-token window (~30%); scale it
  proportionally on smaller windows.
- **Quiet is not finished.** A worker that stops responding is a
  liveness problem: stop it and redispatch its item to another
  worker. Retirement only ever follows a completed item.
- **The pool never judges.** Workers produce; whatever needs a second
  opinion goes to the single terminal judge the consuming ceremony
  dispatches, outside the pool.

---

### {{DISPATCH-DISCIPLINE}}

Rules for dispatching subagents, and for open-ended agents that may need to:

- **Batch per-item work.** Never one agent per item: per-agent warmup (context assembly, re-reading shared files) dwarfs small jobs. Group ~10 items per agent, related items together; the agent reads shared context once and reuses it across the batch.
- **Avoid subagents unless scope genuinely demands them.** Every agent has a 1M-token context — "a lot to read" is not a reason to fan out; do the reading. Fan out only for genuine parallelism across independent surfaces, or work that truly exceeds one context.
- **Shared context travels once.** The dispatcher pastes it into the prompt, or the agent reads it once up front — never rediscovered per item.
- **Model follows the job.** Review, verification, investigation, and relevance jobs: sonnet. Coding and fixing jobs: opus. Don't upgrade reviews by default; don't downgrade fixes for savings.
- **Leaf dispatches carry the leaf rule.** Any agent you dispatch whose scope is fully known gets `{{LEAF-AGENT-RULE}}` in its prompt.

<!-- Materialized by ok-planner v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
