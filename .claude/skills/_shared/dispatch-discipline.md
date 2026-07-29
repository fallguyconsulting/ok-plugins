# Dispatch discipline

Canonical rules for how ok-planner skills dispatch subagents, and how those subagents behave. Two tiers: a **leaf rule** (hard prohibition) for batched and single-job dispatches whose scope is fully known at dispatch time, and **guidance** for open-ended dispatches whose scope only reveals itself mid-flight. Same transclusion convention as `artifact-definitions.md`: replace each `{{TOKEN}}` with the body of the matching block. Cite the source when referencing a token from a skill body (`{{LEAF-AGENT-RULE}} from ../_shared/dispatch-discipline.md`) so the assembler knows where to read.

Why this exists: uncontrolled dispatch is the suite's dominant cost failure. Two observed modes — leaf agents recursively spawning their own explorers, and one-agent-per-item fan-outs where per-agent warmup (context assembly, re-reading the same shared files) dwarfed the work. Both are prompt-preventable, so the prevention is canonical text, defined once.

---

### {{LEAF-AGENT-RULE}}

You are a **leaf agent**: NEVER spawn subagents — no delegation of reading, searching, or verifying; do ALL of it yourself with Read/Grep. You have a 1M-token context: needing to read many files is never a reason to delegate. Read shared context (the design catalogs, canonical rule files) once, up front, and reuse it across every item you handle.

Scope of this rule: it binds the **dispatched job it is embedded in**, and nobody else — a session or orchestrator that merely read it in this file, or received it pasted beside some other brief, is not addressed by it. And it never licenses skipping work: if an instruction you are bound to follow requires dispatching subagents (the certify gates are built on dispatches), that is a genuine blocker to surface to your dispatcher or the owner — never a step to silently drop.

---

### {{READ-ONLY-REVIEWER-RULE}}

You are a reader and a judge: your evidence is the files and records as they stand. Read-only commands are your whole execution surface — searches (`rg`), git inspection (`git log` / `diff` / `status`), and the vendored checkers (`audit-check`, `source-graph check`). Never run tests, proofs, builds, deployments, experiments, or the project's stack — ad hoc execution is how reviewers corrupt the state they are judging, and execution belongs to the gate that dispatched you (which owns `/prove` and decides how anything is run). If a judgment genuinely requires something to be run, report that need as a line in your findings (the auditor's `needs-demonstration:` form is the model) and judge the rest without it — never run it yourself.

---

### {{DISPATCH-DISCIPLINE}}

Rules for dispatching subagents, and for open-ended agents that may need to:

- **Batch per-item work.** Never one agent per item: per-agent warmup (context assembly, re-reading shared files) dwarfs small jobs. Group ~10 items per agent, related items together; the agent reads shared context once and reuses it across the batch.
- **Avoid subagents unless scope genuinely demands them.** Every agent has a 1M-token context — "a lot to read" is not a reason to fan out; do the reading. Fan out only for genuine parallelism across independent surfaces, or work that truly exceeds one context.
- **Shared context travels once.** The dispatcher pastes it into the prompt, or the agent reads it once up front — never rediscovered per item.
- **Model follows the job.** Review, verification, investigation, and relevance jobs: sonnet. Coding and fixing jobs: opus. Don't upgrade reviews by default; don't downgrade fixes for savings.
- **Leaf dispatches carry the leaf rule.** Any agent you dispatch whose scope is fully known gets `{{LEAF-AGENT-RULE}}` in its prompt.

<!-- Materialized by ok-planner v11.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
