---
decision: task-tools-mirror-the-report
---

# The harness task list mirrors the completion report's stages

## Choice

`/ok` offers, as a consented settings transcription beside the hook
entry, the project-scoped environment setting that restores the
harness's task-tracking tools on every model. The sprint's execution
shape tells the session to use the task tools where available: one
task per stage, mirroring the completion report's staged list —
itself rendered from the sprint's task run — marked done as each
stage's build task closes. The session keeps that list, so the
checklist stands in the owner's session. The report is the record;
the task list is display and is never the source of anything.

## Rationale

The Claude 5 model family omits the harness task-tracking tools by
default, and the visible checklist they fill was how an owner watched
a long run without opening the report. The report stays the record
because it survives the session and is what a replacement session
renders and reads; the checklist survives nothing. The setting is a consent
question because it changes every session's tool set.

## Alternatives

- The harness's legacy whole-list todo tool instead of the maintained
  task tools — the same widget; the maintained mechanism carries
  stage dependencies.
- The task list as the staged list itself — evaporates with the
  session, and a replacement session has nothing to read.
- Set the variable user-wide — the suite converges projects, not
  machines.
