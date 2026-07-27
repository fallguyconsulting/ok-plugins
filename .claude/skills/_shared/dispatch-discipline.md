# Dispatch discipline

Canonical rules for how ok-planner skills dispatch subagents, and how those subagents behave. Two tiers: a **leaf rule** (hard prohibition) for batched and single-job dispatches whose scope is fully known at dispatch time, and **guidance** for open-ended dispatches whose scope only reveals itself mid-flight. Same transclusion convention as `artifact-definitions.md`: replace each `{{TOKEN}}` with the body of the matching block. Cite the source when referencing a token from a skill body (`{{LEAF-AGENT-RULE}} from ../_shared/dispatch-discipline.md`) so the assembler knows where to read.

Why this exists: uncontrolled dispatch is the suite's dominant cost failure. Two observed modes — leaf agents recursively spawning their own explorers, and one-agent-per-item fan-outs where per-agent warmup (context assembly, re-reading the same shared files) dwarfed the work. Both are prompt-preventable, so the prevention is canonical text, defined once.

---

### {{LEAF-AGENT-RULE}}

You are a **leaf agent**: NEVER spawn subagents — no delegation of reading, searching, or verifying; do ALL of it yourself with Read/Grep. You have a 1M-token context: needing to read many files is never a reason to delegate. Read shared context (the design catalogs, canonical rule files) once, up front, and reuse it across every item you handle.

---

### {{DISPATCH-DISCIPLINE}}

Rules for dispatching subagents, and for open-ended agents that may need to:

- **Batch per-item work.** Never one agent per item: per-agent warmup (context assembly, re-reading shared files) dwarfs small jobs. Group ~10 items per agent, related items together; the agent reads shared context once and reuses it across the batch.
- **Avoid subagents unless scope genuinely demands them.** Every agent has a 1M-token context — "a lot to read" is not a reason to fan out; do the reading. Fan out only for genuine parallelism across independent surfaces, or work that truly exceeds one context.
- **Shared context travels once.** The dispatcher pastes it into the prompt, or the agent reads it once up front — never rediscovered per item.
- **Model follows the job.** Review, verification, investigation, and relevance jobs: sonnet. Coding and fixing jobs: opus. Don't upgrade reviews by default; don't downgrade fixes for savings.
- **Leaf dispatches carry the leaf rule.** Any agent you dispatch whose scope is fully known gets `{{LEAF-AGENT-RULE}}` in its prompt.

<!-- Materialized by ok-planner v10.0.0 — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->
