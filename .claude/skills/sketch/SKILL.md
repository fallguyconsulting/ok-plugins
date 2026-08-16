---
name: sketch
description: "ONLY activated by explicit /sketch slash command. Never auto-triggered by conversation content. Single-pass pre-commitment design sketch to .ok-planner/sketches/ — externalizes an idea to think about, sit on, or share; assumptions noted, no review loop, and no authorization to build."
---

# Design Sketch

Produce a quick, single-pass design sketch for a new feature or change.
A sketch is **pre-commitment**: it captures an idea in enough detail to
think about it, share it, or come back to it — without committing to the
full planning ceremony.

**Save sketches to:** `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`

## When to use sketch vs. sprint

- **Sketch** — the user has an idea and wants it written down so they can
  think about it, sit on it, share it with a teammate, or decide whether
  to plan it properly. One pass, one document, no review loop, no
  dialogue. The agent makes reasonable assumptions and notes them.

- **Sprint** (`/plan-sprint`) — the user wants to plan something they intend
  to build. Intake dialogue, corpus deltas, resolution of the open
  issues that bear on the work, sign-off review; output is an approved
  sprint, ready to be executed inline or by an orchestrator.

If the user invokes `/sketch` and partway through it becomes clear the
work needs the full planning treatment, finish the sketch first, then
suggest `/plan-sprint` as the next step. Do not silently upgrade.

## A sketch is not a sprint

A sketch can be wrong, incomplete, or speculative. It exists to externalize
thinking, not to authorize implementation. Do not invoke `/plan-sprint` or any
implementation skill from a sketch — sketches do not produce sprints or
plans. If the user wants to build what's in the sketch, the path is
sketch → `/plan-sprint` → sprint.

Sketches live in `sketches/` for as long as the idea is open. When the
idea is taken up for real (via `/plan-sprint`) or abandoned, the sketch file
moves to `history/sketches/` — per file, not wholesale.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/sketches` so the
   sketch home exists — estate convergence is the front door's
   administration (`/ok`), not this skill's.

2. **Establish the topic.** If the user's `/sketch` invocation already
   names what they want sketched, proceed. If not, ask once: "What do
   you want me to sketch?" Then proceed with the answer. No further
   clarifying questions — sketches are single-pass by design. If the
   topic is genuinely too vague to write anything about, say so and
   suggest a `/plan-sprint` intake dialogue instead.

3. **Light context check.** Glance at the codebase only as much as
   needed to ground the sketch in reality (existing patterns, relevant
   files). Do not exhaustively explore. If `.ok-planner/design/`
   exists, skim the catalog filenames under `design/concepts/` and
   grep for `@concept:` annotations in any code you skim
   (`rg '@concept:' <path>`); read full `concepts/<slug>.md` files
   only for concepts the sketched idea touches. Use the catalog's
   terms; respect stated boundaries. Open questions about a
   concept's boundary go in the sketch's `## Open questions`
   section, not as silent assumptions — and not into the issue
   intake at `.ok-planner/issues/` (a sketch is speculative; it
   does not file design issues). If the
   directory doesn't exist, skip.

4. **Write the sketch** to
   `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md` using the
   template below. Use today's date (`date +%Y-%m-%d`).

5. **Report.** Tell the user the path and give a one-paragraph summary
   of what the sketch covers and what assumptions you made. Then end the
   turn. Do not chain into other skills.

## Sketch template

```markdown
# <Topic> — Design Sketch

**Date:** YYYY-MM-DD
**Status:** Sketch (not a sprint; not authorization to build)

## Idea
<One paragraph: what is being proposed and why.>

## Shape
<Free-form description of the design. Use whatever structure fits the
idea — components, data flow, sequence, file layout, API surface,
schema, UX outline. Diagrams in ASCII are fine. No prescribed sections.>

## Open questions
<Things the agent had to assume or guess. List them so the user can see
what would need to be resolved if this reaches a sprint. One bullet each.>

## Risks / unknowns
<What could make this hard, surprising, or wrong. Be honest — sketches
are for thinking, not for selling.>

## What this is not
<Optional. If the sketch deliberately leaves something out — adjacent
features, edge cases, migration paths — name them so the user knows
they were considered and skipped, not forgotten.>
```

## Single-pass behavior

This skill runs single-pass. Make reasonable assumptions as you write,
and record them in the **Open questions** section rather than stopping
to ask. The one exception is step 2 above: if the topic was not
provided in the invocation, ask once for the topic, then proceed.

## What sketch does NOT do

- Does not invoke `/plan-sprint` or any implementation skill
- Does not write to `design/` or file into `.ok-planner/issues/`
- Does not produce phased rollouts, commit plans, or PR strategies
- Does not edit code

<!-- Materialized by ok-planner v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
