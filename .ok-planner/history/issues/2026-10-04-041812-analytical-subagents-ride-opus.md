---
issue: analytical-subagents-ride-opus
kind: human
category: design
artifacts:
  - decision:subagent-model-follows-job
status: promoted
sprint: 2026-10-04-consolidate-into-ok-planner.md
opened: 2026-10-04T04:18:12Z
---

# Investigation, relevance, and enumeration subagents ride Sonnet, and the owner wants Opus for all analytical work

## Problem

The suite sends every analytical job to Sonnet. The rule appears in several places:

- `plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md` reads: "Investigation, relevance, and enumeration jobs — an issue investigator, a relevance pass, a discoverer, the surface extractor: sonnet." The same bullet ends: "Do not upgrade reads or downgrade fixes."
- `plugins/ok/rules/ok-cheatsheet.md` reads: "Investigation, relevance, and enumeration jobs ride `sonnet`".
- Prompt blocks name the model directly:
  - `Agent (general-purpose, model: sonnet)` at `plugins/ok/families/ok-planner/skills/plan-sprint/core.md:130`;
  - the same at `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md:99` and `:607`;
  - the surface extractor at `plugins/ok/families/ok-planner/ceremony/audit.md:45`;
  - the Method leaf agents at `plugins/ok/families/ok-planner/ceremony/document.md:174`.
- The `ok-sonnet` profile at `plugins/ok/families/ok-planner/agents/ok-sonnet.md` describes itself as "investigation, relevance, and compliance-reading jobs".
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md:85` and `plugins/ok/admin/ADMINISTRATION.md:20` restate the split.

The consumer project linescout found the split wrong for its work. An investigation or enumeration result is what a planning session builds on. A missed artifact or a wrong reading becomes a corpus delta or a work item that contradicts the code, and nothing later re-reads the source to catch it. On 2026-10-03, twice in one `/plan-sprint` session, the owner stopped a Sonnet investigation and had it rerun on Opus:

- an investigation of which cross-formation references the platform supports;
- an enumeration of every concept, story, and decision a sprint must amend, retire, or add.

The second time, the owner asked why the session kept using Sonnet. The session answered that the cheatsheet told it to. "Do not upgrade reads" blocks the session from following the owner's earlier instruction.

## Candidate

Send every analytical job to Opus: investigation, relevance, enumeration, discovery, classification, compliance reading, the surface extractor, and the document Method's leaf agents. Keep Haiku for mechanical single-shot lookups.

- Change the dispatch-discipline bullet and the cheatsheet paragraph to say so, and drop "Do not upgrade reads".
- Change each `model: sonnet` prompt block above to `model: opus`.
- Retire the `ok-sonnet` profile, or repoint every task filed for it to `ok-opus`. Remove `sonnet` from `ALLOWED` in `plugins/ok/hooks/agent-model` once nothing names it, or leave it allowed for a project that opts back in.
- Update `ok-planner-CLAUDE.md` and `ADMINISTRATION.md` to match.

A project setting for the analytical model, defaulting to `opus`, would let a project that wants Sonnet's cost choose it without editing suite-owned files.

## Ruling

Send every analytical job to `opus`: investigation, relevance, enumeration, discovery, classification, compliance reading, the surface extractor, and the document Method's leaf agents. `haiku` keeps mechanical single-shot lookups. Change the prompt instructions alone: the shared dispatch discipline, the ok cheatsheet, every prompt block that names `sonnet`, the planner's embedded rules, and the administration text; drop "Do not upgrade reads"; retire the `ok-sonnet` profile and file its tasks for `ok-opus`. The agent-model hook keeps allowing `sonnet`, because the hook enforces only that a dispatch names one of the models, and the instructions decide which one. An investigation or enumeration result is what a planning session builds on, and nothing later re-reads the source to catch a miss, so the cheaper read costs more than it saves. Rewrite the model decision's choice and rationale to match.
