---
decision: task-tools-mirror-the-report
---

# The harness task list mirrors the completion report's stages

## Choice

`/ok` offers, as a consented settings transcription beside the hook
entry, the project-scoped environment setting that restores the
harness's task-tracking tools on every model. The sprint's execution
shape names the checklist as a step of its own and tells the session
when to touch it: create one entry per stage when the build tasks are
filed, mark an entry in progress when the drain that runs its build task
starts, or, where the session runs the drain itself, when the task's
agent claims it, mark it done when that task closes `done`, and add
one entry for the certification when every stage's build task has
closed `done`. Where a Workflow script runs the drain, the session marks each entry
from the closed tasks the script returns, each time it returns. The list mirrors the completion report's
staged list — itself rendered from the sprint's task run — so the
checklist stands in the owner's session. The report is the record;
the task list is display and is never the source of anything.

## Rationale

The Claude 5 model family omits the harness task-tracking tools by
default, and the visible checklist they fill was how an owner watched
a long run without opening the report. The report stays the record
because it survives the session and is what a replacement session
renders and reads; the checklist survives nothing. The setting is a
consent question because it changes every session's tool set. The
checklist is its own numbered step, with its three moments named,
because an executor skips a checklist written as a trailing clause
after the report-rendering step: a measured execution under that form
ran its first three agents with no checklist, and the owner asked
where it was.

## Alternatives

- The harness's legacy whole-list todo tool instead of the maintained
  task tools — the same widget; the maintained mechanism carries
  stage dependencies.
- The task list as the staged list itself — evaporates with the
  session, and a replacement session has nothing to read.
- Set the variable user-wide — the suite trues up projects, not
  machines.
- The checklist as an aside in the report step — the measured run
  skipped it.
