---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering. Its portable dispatch rule is injected into the writing agent's context whenever any agent in the session writes a markdown file — a consented PreToolUse hook on Write and Edit, firing for the main session and dispatched subagents alike — and the family cheatsheet carries the same rule ambiently, pointing at the full standard materialized in the estate. No prose lint exists: the plumbline lint's charter stays comments and citations.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot see elegant variation, a broken metaphor, or a decorative example; it can only match phrases, and a phrase list catches too little while flagging legitimate prose. Steering acts where the failure happens — at generation: an ambient rule competes with a full context for salience, but a rule injected at the moment of the write is the freshest instruction the model holds. The subagent coverage the Choice commits to is what the ambient channels cannot give: a dispatched writer whose prompt omits the rule still receives it at the moment of writing.

## Alternatives

- A prose lint in the plumbline binary — the decidable subset (a banned-phrase list, sentence-length caps) is a poor proxy for the standard, and false positives would teach agents to ignore the lint. Rejected as too rigid, and it would widen the lint's charter from comments to prose.
- Cheatsheet only — reaches every agent, but relies on ambient salience alone with nothing at the moment of writing.
- The dispatch rule pasted into every skill prompt — depends on every skill author remembering it; the standard would erode one forgotten prompt at a time.
