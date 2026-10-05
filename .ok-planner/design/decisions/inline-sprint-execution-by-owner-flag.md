---
decision: inline-sprint-execution-by-owner-flag
---

# A project may opt its sprints into inline execution by a flag the owner sets by hand

## Choice

A project's planner configuration may set `sprint_execution` to `inline`. Where it does, every sprint the planning session writes from then on carries the inline execution boilerplate in place of the task-run shape: the session builds the sprint itself, then runs rounds of review and fix, each round a fresh review agent over the change from the sprint's base commit, judged by the sprint catalog and the accept list, until a round finds nothing in the sprint's scope or three rounds have run. The inline path files no build tasks, drives no stories, and runs no sprint certification; its completion contract asks for the review rounds in the completion report in place of certification's return block. A defect still open after the last round, a defect outside the sprint's scope, and a question only the owner can decide reach the intake as they do from certification. The flag is the owner's alone: nothing in the suite proposes it, offers it, or writes it, and a project without it keeps the task-run shape.

## Rationale

The task-run shape and the story drive fit a product with code and a running stack, where per-stage agents keep the context small and drivers find what reading misses. A product made of skill text gains little from either: its drivers cannot reach the slash commands that start agents, its fixers may not edit its prose, and its defects surface in a review of the text. For such a project, a session that builds inline and reviews in rounds reaches the same completion contract with fewer moving parts. Keeping it an opt-in escape hatch leaves every other project on the shape that serves it, and keeping it out of the administration's proposals stops the suite from steering a project off that shape.

## Alternatives

- Inline execution for every project — drops the per-stage agents and the drive where they do find defects.
- A story list in the review facts naming the stories a driver cannot reach — one more list to keep, and something still has to decide which stories go on it.
- Drivers that start a headless session to reach agent-dispatching commands — reaches the commands, but cannot answer an interactive ceremony's questions and costs a whole ceremony per story.
