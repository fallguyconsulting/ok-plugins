---
name: sketch
description: "ONLY activated by explicit /sketch slash command. Never auto-triggered by conversation content. Single-pass pre-commitment design sketch to .ok-planner/sketches/ — externalizes an idea to think about, sit on, or share; assumptions noted, no review loop, and no authorization to build."
---

# Design Sketch

Produce a single-pass design sketch for a new feature or change. A sketch is **pre-commitment**: it captures an idea in enough detail to think about, share, or come back to — one pass, one document, no review loop, no dialogue, and no authorization to build. A sketch can be wrong, incomplete, or speculative.

**Save sketches to:** `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`

The alternative is `/plan-sprint`: the user wants to plan something they intend to build, with intake dialogue, corpus deltas, issue resolution, and sign-off. If it becomes clear mid-sketch that the work needs the full planning treatment, finish the sketch, then suggest `/plan-sprint` as the next step; never silently upgrade, and never invoke `/plan-sprint` or any implementation skill from a sketch. When the idea is taken up through `/plan-sprint`, or abandoned, the sketch file moves to `history/sketches/` — per file, not wholesale.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/sketches`; estate convergence is the front door's administration (`/ok`), not this skill's.

2. **Establish the topic.** If the invocation names it, proceed. If not, ask once: "What do you want me to sketch?" — the one question this skill asks. If the topic is too vague to write anything about, say so and suggest a `/plan-sprint` intake dialogue instead.

3. **Light context check.** Read the codebase only as much as needed to ground the sketch (existing patterns, relevant files). If `.ok-planner/design/` exists, skim the catalog filenames under `design/concepts/`, grep `rg '@concept:'` in code you skim, and read a full `concepts/<slug>.md` only for concepts the idea touches. Use the catalog's terms and respect stated boundaries. Open questions about a concept's boundary go in the sketch's `## Open questions` section — never as silent assumptions, and never into the issue intake (a sketch is speculative; it files no design issues). If the directory does not exist, skip.

4. **Write the sketch** to `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md` using the template below, with today's date (`date +%Y-%m-%d`).

5. **Report.** Give the user the path and a one-paragraph summary of what the sketch covers and what you assumed. End the turn; chain into nothing.

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
<What the agent had to assume or guess, one bullet each, so the user
can see what a sprint would need to resolve.>

## Risks / unknowns
<What could make this hard, surprising, or wrong. Sketches are for
thinking, not for selling.>

## What this is not
<Optional. What the sketch deliberately leaves out — adjacent
features, edge cases, migration paths — so the user knows they were
considered and skipped.>
```

## Single-pass behavior

Make reasonable assumptions as you write and record them under Open questions instead of stopping to ask. The one exception is the topic question in step 2.

## What sketch does NOT do

- Does not invoke `/plan-sprint` or any implementation skill
- Does not write to `design/` or file into `.ok-planner/issues/`
- Does not produce phased rollouts, commit plans, or PR strategies
- Does not edit code

<!-- Materialized by ok-planner v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
