---
decision: single-source-transclusion
---

# Canonical rule text lives once and is transcluded into prompts

## Choice

Every canonical definition, template, and rule the planner's skills share is defined exactly once, in one of a small set of shared files — the artifact definitions, the design-doc compliance reviewer prompt, the dispatch discipline, the implementation-auditor prompt, the sprint's shared blocks, and the converge coding rules — and skill prompts pull each block in by named double-braced token. The running model replaces each token when it assembles a dispatch; `/converge`'s review tool replaces them when it writes a run's prompts. Skills running in the main loop reference the shared files directly instead of restating them. Definitions are never restated inline in a skill, and no block is defined in more than one place.

## Rationale

The writer, the checker, and the mutator of the same artifact kind each see only their own dispatched prompt; defining the rules once and transcluding keeps the wording from drifting between the agent that writes and the agent that checks. Editorially, one place per block is what keeps canonical wording canonical: a second definition of the same block is a second thing to remember to edit, and the copy nobody remembers is the one that ships.

## Alternatives

- Restate rules per skill — guaranteeing drift between authoring and reviewing prompts.
- Build-time template assembly — requires a build step in a plugin family that deliberately ships none.
- One monolithic definitions file — makes the file-count claim trivially checkable at the cost of folding the sprint's blocks, the coding rules, and the auditor prompts into the definitions file, buying nothing the per-block uniqueness check does not already guarantee.
