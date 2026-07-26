---
issue: design-notes-unmarked-superseded
kind: discover
category: vestigial
artifacts:
  - decision:no-execution-engine
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# Two dev-notes files describe an engine the plugin retired, with no marker saying so

`plugins/ok-planner/design-notes/` holds two files (about 500 lines) describing the pre-4.0 write-plan/execute-plan pipeline — an execution engine that no longer exists anywhere in the plugin. Neither file carries a superseded or retired marker, and nothing in the codebase references the directory. A contributor who finds them reads a detailed, confident description of architecture the project deliberately removed.

These are plugin-source scratch files, not corpus artifacts — the corpus itself is already correct (`decision:no-execution-engine` records the engine as built, rejected, and retired, at decision altitude), and the current-state-only rule that would forbid such content governs `design/`, not the plugin's own source tree. So nothing is *violated*; the question is purely editorial: do inert, misleading dev notes stay as unmarked history, get banners, or go?

## Options

- **Delete the directory** — git history and `decision:no-execution-engine` remain the record, which is exactly the pattern the suite uses everywhere else (superseded content lives in history, not beside the live tree). One `git rm`.
- **Add superseded banners in place** — keeps the notes readable without the archaeology, at the cost of maintaining prose whose only message is "don't read this."

The ruling decides: delete or banner.

## Ruling

> Recommended ruling (/verify-issues): delete — a sprint work item removes `plugins/ok-planner/design-notes/`, relying on git history and `decision:no-execution-engine` as the record.
>
> Rationale: the suite's own doctrine is that superseded material lives in history, not in the live tree wearing a warning label — a banner would preserve 500 lines whose entire function is to say they shouldn't be there. The decision artifact already carries everything durable about why the engine went away.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
