# Dispatch discipline

Rules for how ok-planner skills dispatch subagents and how those subagents behave. Three tiers: the **leaf rule** for dispatches whose scope is known at dispatch time, the **fork-per-item rule** for a profile agent that reads once and forks per item, and **guidance** for open-ended dispatches. A long stream of same-shaped items is never fed to a standing agent by message: it is filed as tasks in the task tracker and drained, one fresh agent per task. Transclusion follows `artifact-definitions.md`: replace each `{{TOKEN}}` with the body of the matching block. When a skill body cites a token from this file, name the file (`{{LEAF-AGENT-RULE}} from skills/_shared/dispatch-discipline.md`).

---

### {{LEAF-AGENT-RULE}}

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

---

### {{FORK-PER-ITEM-RULE}}

You are a **forking agent**: you read once and fork per item, and every fork owns a task of its own. Read the material every item in your brief shares — the code the refs cite, the catalogs, the rule files — once, up front. Then file one task per item, on your own profile and forked from your task (`tasks file ... --agent <your profile> --fork-of <task>`); the tracker marks it issued for your fork, and the drain leaves it alone while your fork holds it. Close your task with the item tasks in its result. Then fork one agent per item task, every fork in one message: the `Agent` tool with `subagent_type` set to `fork` and no other type, its prompt saying it is a fork, saying that everything you read stands in its context, and naming its task on its last line. A fork inherits everything you read, so it reads nothing shared again; it claims its item task, does its item, writes the item's file, and closes that task with the item's report line as the result. A fork never forks, and you spawn nothing but forks. A fork that returns nothing is the drain's: it reissues the item task to a fresh agent of your profile, and the prompt tells that agent what to read. A brief with one item needs no fork and no task: do it yourself and close your task with its line.

---

### {{READ-ONLY-REVIEWER-RULE}}

You are a reader and a judge. Your evidence is the files and records as they stand. Your execution surface is read-only commands: searches (`rg`) and git inspection (`git log` / `diff` / `status`). Never run tests, builds, deployments, experiments, or the project's stack; execution belongs to whoever dispatched you. The task tracker's own verbs — `claim`, `item add`, `item set`, `item list`, `round show`, `close` — are your record, not execution: run them. If a judgment requires something to be run, report that need as a line in your findings and judge the rest without it.

---

### {{DISPATCH-DISCIPLINE}}

Rules for dispatching subagents, and for open-ended agents that may need to:

- **Batch per-item work.** Never one agent per item. Group ~10 related items per agent; the agent reads shared context once and reuses it.
- **Dispatch subagents only when scope demands it.** Every agent has a 1M-token context; a large reading set is not a reason to fan out. Fan out for parallel work across independent surfaces, or work that exceeds one context.
- **Shared context travels once.** The dispatcher pastes it into the prompt, or the agent reads it once up front.
- **Every dispatch names its model, and model follows the job.** Investigation, relevance, and enumeration jobs — an issue investigator, a relevance pass, a discoverer, the surface extractor: sonnet. Review, coding, fixing, writing, and architectural-ruling jobs — the gate's review root with its pass tasks, every reviewer a skill dispatches, a sprint's build tasks, the gate's fixer, and its architect: opus. Mechanical single-shot lookups: haiku. The session model is never a subagent model: an omitted `model` inherits it, so no dispatch omits one; a fork inherits its caller's model, so only a profile agent pinned to one of the three forks, per the fork-per-item rule. Do not upgrade reads or downgrade fixes.
- **Leaf dispatches carry the leaf rule.** Any agent you dispatch whose scope is known gets `{{LEAF-AGENT-RULE}}` in its prompt.
