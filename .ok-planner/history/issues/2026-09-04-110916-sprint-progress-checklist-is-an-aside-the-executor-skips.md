---
issue: sprint-progress-checklist-is-an-aside-the-executor-skips
kind: human
category: unclear
artifacts: []
status: answered
opened: 2026-09-04T11:09:16Z
---

# The sprint's progress checklist is one aside in the boilerplate, and the executor skips it

## Problem

The owner watches a sprint's progress through the harness task list: one entry per stage, marked done as each stage closes. The v20.0.0 shape mentions that checklist in one place only: step 4 of "How to execute this sprint" in `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md`, as a trailing clause after the instruction to render the completion report ("The harness task tools, where available, mirror that list as a live checklist, one task per stage, marked done as each closes; the run file is the record and the task list is display"). `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` repeats it as a parenthetical under "Executing a sprint". Nothing else names it: `plugins/ok/families/ok-planner/skills/execute-tasks/SKILL.md`, which the session runs on every drain step, and `plugins/ok/families/ok-planner/skills/_shared/certification-core.md`, which states the per-stage fix loop, both say nothing about the checklist, and neither says when an entry is marked done (at the build task's close, or at the review's empty findings pool).

Observed on 2026-09-04 in `linescout/platform` executing `2026-09-04-remove-line-topology` under `/goal` on v20.0.0: the session opened the run, filed ten stages as build and review tasks, rendered the completion report, and dispatched the first three agents with no checklist at all. The owner asked "we're also missing the usual todo list that shows progress. is that no longer part of the sprint boilerplate?" The session created the checklist only then.

## Candidates

- Make the checklist its own numbered step in the sprint boilerplate, placed with the report rendering, stating the three moments the executor touches it: create one entry per stage when the stages are filed, mark an entry in progress when its build task is dispatched, and mark it done when its review closes with an empty findings pool. State the same in the per-stage fix loop under `{{BUILD-REVIEW-PROMPT}}` in the certification core, since that is where the stage-complete event is defined.
- Have the `execute-tasks` drain mirror the tracker into the harness task list itself, one entry per task it dispatches, so the checklist follows every run of the tracker and no ceremony has to remember it.

## Ruling

Answered on 2026-09-05: the filed gap no longer exists. the checklist is its own step with its three moments in the sprint boilerplate; see decision task-tools-mirror-the-report, Choice.
