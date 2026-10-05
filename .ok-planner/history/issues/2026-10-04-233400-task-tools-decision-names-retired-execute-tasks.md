---
issue: task-tools-decision-names-retired-execute-tasks
kind: audit
category: design
artifacts:
  - decision:task-tools-mirror-the-report
status: retired
triage: corpus
opened: 2026-10-04T23:34:00Z
---

# A live decision still says the retired `/execute-tasks` skill marks the harness checklist

The decision that governs the harness checklist names a skill the suite no longer ships. The Choice of decision:task-tools-mirror-the-report says: "The `execute-tasks` drain marks the entry for a task's key as it dispatches and closes the task, where the caller keeps one." Design docs describe the current state only, so a live decision must name the mechanism that exists.

The suite retired `/execute-tasks` when it consolidated into ok-planner. The payload carries no `execute-tasks` skill, and the front door and the administration document list `execute-tasks` among the retired names. In its place is the drain loop: process text that `/audit`, `/converge`, `/triage-issues`, and sprint execution each read by path, as decision:slash-only-activation and decision:no-execution-engine already say. The drain loop now does the marking: where the caller keeps a progress checklist in the harness task tools, it marks the entry for a task's key in progress when the task's agent claims it, and done when the task closes `done`.

No consolidation delta amended this decision, and it is the only live corpus artifact that still names `execute-tasks`. A reader who follows it looks for a skill that does not exist, and reads moments ("as it dispatches and closes") the loop does not use. The fix is one sentence of corpus text. Sprint certification run converge-2026-10-04T060800 spent no fix round on it, because no agent of a run may edit the design corpus.

## Options

The one compliant change: decision:task-tools-mirror-the-report names the drain loop in place of the `execute-tasks` drain, with the moments the loop uses. The rule that forces it is that design docs are current-state only, applied to the consolidation that decision:one-vendored-family records.

The ruling decides the wording of that one sentence.

## Ruling

Retired by the owner on 2026-10-04: fixed by hand with the generated wording. decision:task-tools-mirror-the-report's Choice now reads "The drain loop marks the entry for a task's key in progress when the task's agent claims it and done when the task closes `done`, where the caller keeps one." No live corpus artifact names `execute-tasks`.
