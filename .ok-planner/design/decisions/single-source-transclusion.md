---
decision: single-source-transclusion
---

# Canonical rule text lives once and is transcluded into prompts

## Choice

Every canonical definition, template, and rule the planner's skills share lives in one shared definitions file (plus one shared reviewer prompt), and skill prompts pull them in by named double-braced token blocks replaced at dispatch-assembly time by the running model; skills running in the main loop reference the file directly instead of restating it. Definitions are never restated inline in a skill.

## Rationale

The writer, the checker, and the mutator of the same artifact kind each see only their own dispatched prompt; defining the rules once and transcluding keeps the wording from drifting between the agent that writes and the agent that checks. Editorially, one file to change is what keeps canonical wording canonical.

## Alternatives

- Restate rules per skill — guaranteeing drift between authoring and reviewing prompts.
- Build-time template assembly — requires a build step in a plugin family that deliberately ships none.
