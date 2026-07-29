---
audit: sketch-an-idea
artifact: story:sketch-an-idea
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:62ce5b4fdb51
---

# Can an owner capture a speculative idea in one pass without triggering planning or authorizing implementation?

## Confirmation

Satisfied. `/sketch` is a skill prompt and nothing in the story is delivered by
code, so the evidence is that text, cited narrowly, and no test is owed.

- **One pass.** The skill declares itself single-pass: assumptions are made and
  recorded in the sketch's `## Open questions` rather than asked about, and the one
  permitted question is a single "What do you want me to sketch?" when the
  invocation named no topic. The context check is explicitly light — skim the
  concept catalog, read only the concepts the idea touches, do not exhaustively
  explore.
- **Without triggering planning.** The skill does not invoke `/plan-sprint` or any
  implementation skill; a topic that turns out to need the ceremony is finished as
  a sketch first and `/plan-sprint` is only suggested — "Do not silently upgrade" —
  and the skill ends its turn rather than chaining.
- **Without authorizing implementation.** The template stamps every sketch
  `Status: Sketch (not a sprint; not authorization to build)`; the skill edits no
  code, writes nothing to `design/`, files nothing into `.ok-planner/issues/`, and
  produces no phased rollouts or commit plans.
- **Externalized and revisitable.** The output is a file at
  `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`, which stays in `sketches/`
  for as long as the idea is open and moves to `history/sketches/` — per file —
  only when the idea is taken up by `/plan-sprint` or abandoned.
- **At no ceremony cost.** There is no review loop and no dialogue; the run is a
  `mkdir -p`, one write, and a one-paragraph report.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md#design-sketch @ sha256:19473026094c
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md#design-sketch.a-sketch-is-not-a-sprint @ sha256:148c31604ec0
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md#design-sketch.process @ sha256:78f5867d6a6b
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md#design-sketch.sketch-template @ sha256:c783adb4667c
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md#design-sketch.what-sketch-does-not-do @ sha256:b70c54c1f468
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "This skill runs single-pass. Make reasonable assumptions as you write,"
- cite: plugins/ok/families/ok-planner/skills/sketch/SKILL.md :: "- Does not invoke `/plan-sprint` or any implementation skill"
