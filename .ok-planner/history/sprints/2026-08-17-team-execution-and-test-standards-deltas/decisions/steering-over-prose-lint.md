---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering, through four channels.
Its portable dispatch rule is injected into the writing agent's
context whenever any agent in the session writes a markdown file — a
consented PreToolUse hook on every tool call, firing for the main
session and dispatched subagents alike. The family cheatsheet carries
the same rule ambiently, pointing at the full standard materialized in
the estate. And the personal conduct's output style carries the same
portable rule as session-wide governance, binding everything a
session writes and says — replies, reports, issue files, commit
messages, authored skill prose — where no Write fires and no
cheatsheet is in context. And a consented Stop and SubagentStop hook
reads a flag the edit hook sets when the turn wrote prose under the
project root, and blocks the stop once with one instruction: review
every sentence written this turn against the standard, rewrite what
fails, then stop; the retry stops cleanly. The agent judges its own
prose in its own context; no second model is called. No prose lint
exists: the plumbline lint's charter stays comments and citations.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot
see elegant variation, a broken metaphor, or a decorative example; it
can only match phrases, and a phrase list catches too little while
flagging legitimate prose. Steering acts where the failure happens —
at generation: an ambient rule competes with a full context for
salience, but a rule injected at the moment of the write is the
freshest instruction the model holds. The subagent coverage the Choice
commits to is what the ambient channels cannot give: a dispatched
writer whose prompt omits the rule still receives it at the moment of
writing. The conduct channel covers the remaining gap — the session's
own voice: spoken replies and reports go through no Write hook, and
the conduct is the one layer present in every session the owner
works in, project or not. The stop-time review is the one channel
that acts after the sentence exists: write-time steering shapes what
the agent is about to write, and a long turn still drifts; a review
of the whole turn's prose at its end catches that drift while the
agent can still fix it in the same turn.

## Alternatives

- A prose lint in the plumbline binary — the decidable subset (a
  banned-phrase list, sentence-length caps) is a poor proxy for the
  standard, and false positives would teach agents to ignore the lint.
  Rejected as too rigid, and it would widen the lint's charter from
  comments to prose.
- Cheatsheet only — reaches every agent, but relies on ambient
  salience alone with nothing at the moment of writing.
- The dispatch rule pasted into every skill prompt — depends on every
  skill author remembering it; the standard would erode one forgotten
  prompt at a time.
- Hook and cheatsheet only, no conduct channel — an earlier shape:
  files are steered but the session's own replies and reports are
  governed by nothing, and the standard stops at the terminal.
- Three channels, no stop-time review — the prior shape: prose is
  steered before it is written and never re-read after, so the drift
  a long turn accumulates ships uncorrected.
