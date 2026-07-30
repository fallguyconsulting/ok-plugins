---
audit: no-execution-engine
artifact: decision:no-execution-engine
determination: satisfied
audited: 2026-07-29T23:58:17Z
artifact-hash: sha256:7fae3b9ff48e
---

# Does the planner ship no execution machinery and define no plan artifact, with every sprint carrying its own execution shape and contract?

## Confirmation

Satisfied.

- **No execution machinery, no plan artifact.** Enumerated from the family's
  own surfaces as its guide records them: the skills are `audit`,
  `certify-all`, `certify-work`, `discover-design`, `ok-planner`, `ok-version`,
  `plan-sprint`, `sketch`, `verify-issues`, plus the shared definition blocks;
  the scripts are the audit-corpus checker, the source-graph extractor, the
  corpus view's service, the corpus view's up/down helper, the estate ignore
  file, the ceremony helper, the session hook, and two materialized templates.
  None sequences, schedules, or drives work — the up/down helper starts and
  stops a read-only viewer, nothing else — and no skill defines or writes a
  plan artifact: the artifact kinds are concepts, stories, decisions, issues,
  sprints, sketches, and audits.
- **A sprint is never rewritten into a plan.** The family's own verb summary
  states it outright, the family guide states it as a standing property, and
  the execution boilerplate tells the executor that staging is never rewritten
  into a plan document and that the completion report is a record of the
  execution, never a plan document.
- **Staging happens at execution time, in the executor's working state.** The
  boilerplate directs the executor to group and order the flat work-item list
  itself, in the harness's task tracking or an orchestrator's own graph.
- **Every sprint bakes the execution-shape section plus the completion
  contract.** Both sections are fixed boilerplate in the planning ceremony's
  sprint template, required verbatim in every sprint, and the ceremony is
  terminal at the approved sprint — it starts no execution and writes no plan.
  Enumerated against the sprints this project has produced: all nine — eight
  archived plus the one live in `sprints/` — carry both the "How to execute
  this sprint" and "Completion contract" sections.
- **One brief for every executor.** The same boilerplate names the three
  executors it serves unchanged — an inline working session, the native `goal`
  mechanism, or an orchestrator that does its own planning — and the contract is
  what each discharges, through `/certify-work`.
- **The verification burden lives in the suites and the gates.** The contract's
  items are the project's own test suites, the design corpus matching every
  delta, the audit corpus current with `audit-check --inspection` exiting 0, and
  a finished completion report — no engine-side verification exists to carry it.

The decision is realized in prose — the ceremony's template, the family guide,
and the family's verb definitions — so the evidence is that text, cited
narrowly; the contract's one mechanical item is the vendored checker, which the
planner's own harnesses exercise.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.3-draft-the-sprint @ sha256:28d74a6ee343
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "sections are fixed boilerplate — include both verbatim in every sprint"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "   document: this sprint is the whole brief."
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.6-terminal @ sha256:ab1b99517d5b
- cite-node: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md#what-ok-planner-is @ sha256:ab66c183e848
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "Never turn a sprint into a plan document."
- cite-node: plugins/ok/families/ok-planner/CLAUDE.md#claude-md.family-purpose @ sha256:adaf6e896721
- cite-node: plugins/ok/families/ok-planner/CLAUDE.md#claude-md.layout @ sha256:1a70383556c5
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:435b82f8b39b
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
