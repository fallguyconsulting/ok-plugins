---
decision: single-source-transclusion
---

# Canonical rule text lives once and is transcluded into prompts

## Choice

Every canonical definition, template, and rule the planner's skills share is defined exactly once, in one shared directory of canonical files — the artifact definitions, the shared reviewer prompt, the certification core, the dispatch discipline, the implementation-auditor prompt — and skill prompts pull each block in by named double-braced token, replaced at dispatch-assembly time by the running model; skills running in the main loop reference the shared files directly instead of restating them. Definitions are never restated inline in a skill, and no block is defined in more than one place.

## Rationale

The writer, the checker, and the mutator of the same artifact kind each see only their own dispatched prompt; defining the rules once and transcluding keeps the wording from drifting between the agent that writes and the agent that checks. Editorially, one place per block is what keeps canonical wording canonical: a second definition of the same block is a second thing to remember to edit, and the copy nobody remembers is the one that ships.

## Alternatives

- Restate rules per skill — guaranteeing drift between authoring and reviewing prompts.
- Build-time template assembly — requires a build step in a plugin family that deliberately ships none.
- One monolithic definitions file — makes the file-count claim trivially checkable at the cost of folding a certification prompt library into the definitions file, buying nothing the per-block uniqueness check does not already guarantee.
