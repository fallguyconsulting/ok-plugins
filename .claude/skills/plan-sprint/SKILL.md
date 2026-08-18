---
name: plan-sprint
description: "ONLY activated by explicit /plan-sprint slash command. Never auto-triggered by conversation content. The suite's planning ceremony, covering every estate this project has: pulls ruled issues in, reconciles work done out of band since the last close, drafts final-form corpus deltas and flat work items with the owner, resolves the open issues that bear on the work, and terminates at an approved, self-sufficient sprint with a fixed completion contract — execution is a separate act."
---

# Sprint Planning

The planning ceremony: an interactive session with the project owner that produces a **sprint** — a change-order against the project's durable corpora, expressed as final-form artifact deltas plus the work items that realize them, terminated by a fixed completion contract.

This is a **suite verb**, not any one family's. One canonical body covers whichever families the project integrates, read from the filesystem when the verb runs.

**The artifact is a sprint, not a theme.** A sprint holds potentially disparate changes — a concept clarified, a new story, an unrelated decision retired — with no required unifying focus. Do not manufacture a narrative to hold unrelated items together, and do not batch, stage, or phase the work items; staging and ordering belong to execution. This session's job is to get the right items into the sprint, each stated well enough to be picked up cold.

Implementation happens elsewhere — inline in an ordinary working session, or in an orchestrator that consumes the sprint. This skill never hands off to a planning or execution pipeline.

## Resolve the estates

Every family's presence is a filesystem check at the project root — the nearest ancestor of the working directory (itself included) holding an estate directory, never derived from `.git`:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/plan-sprint.md` — the family's **ceremony contribution**. That file, not this one, says what the family contributes; this body never carries family-specific instructions and never improvises them. A contribution missing where its estate exists is a conformance defect: report it and carry on.

No estate at all → say so and stop; there is nothing to plan against.

**`.ok-planner/` is required for this verb.** It owns the sprint, the corpus deltas, and the issue intake. Without it, say so and stop.

Tell the owner which estates are in scope, in one line, before the session starts.

## The spine

Run these phases in order. At each one, follow the instructions every present contribution gives under that phase's heading — all of them, in the estate order above. A contribution silent on a phase adds nothing to it; report nothing.

1. **Layout** — each family ensures its own directories exist. Estate convergence is the front door's administration (`/ok`), never a ceremony's.
2. **Frame** — establish what kind of session this is and what is already decided.
3. **Reconcile** — bring the corpora and reality into agreement before anything is drafted on top of them.
4. **Dialogue** — discuss what this sprint takes on. Ask questions in prose; surface every tradeoff explicitly, and never resolve one silently on the owner's behalf.
5. **Draft** — write the sprint.
6. **Resolve** — settle the open questions that bear on the drafted work.
7. **Sign-off** — review the draft, then present it to the owner. It is not final until they approve.
8. **Terminal** — record what the sprint closed, and stop.

## Terminal

The approved sprint is this skill's terminal artifact. Executing it is a separate act: do not implement, do not invoke further skills, do not write plans. The sprint's own execution boilerplate describes how execution works.

At sign-off, hand the owner the line that starts execution under the native `goal` mechanism, with this sprint's filename stamped in:

    /goal .ok-planner/sprints/<sprint-name>.md — see the goal
    resolution criteria in that file's completion contract; read the
    file from disk and apply them

Hand it whole; do not shorten it to the bare path. The line is for the owner, and the sprint document does not carry it.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes from the ceremony contributions in the estates present.
- Does not implement work items or mutate code.
- Does not mutate any corpus directly — corpus changes ride the sprint's deltas and are applied by the implementer.
- Does not stage, phase, or theme the work items — sequencing is execution's job.
- Does not converge an estate, materialize a file, or repair a family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
