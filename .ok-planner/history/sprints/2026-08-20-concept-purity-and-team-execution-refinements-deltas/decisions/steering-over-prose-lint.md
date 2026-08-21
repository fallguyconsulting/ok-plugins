---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering, through three channels
and one backstop. The family cheatsheet carries the standard's
portable dispatch rule ambiently, pointing at the full standard
materialized in the estate. The personal conduct's output style
carries the same rule as session-wide governance, binding everything
a session writes and says — replies, reports, issue files, commit
messages, authored skill prose — where no cheatsheet is in context.
And a consented PostToolUse hook on every tool call, firing for the
main session and dispatched subagents alike, detects prose a call
wrote to a file under the project root and keeps the turn's list of
such files. While the list stands, the hook reminds the agent on
every later call, as silent additional context, to review every
sentence it wrote in those files against the standard at the end of
its work — after the last edit, before the final message — rewrite
what fails, and clear the list by a command the hook recognizes. A
consented Stop and SubagentStop hook is the backstop: a list still
standing at the stop continues the turn once with the same
instruction, delivered as non-error feedback, and the retry stops
cleanly. The agent judges its
own prose in its own context; no second model is called. No prose
lint exists: the plumbline lint's charter stays comments and
citations.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot
see elegant variation, a broken metaphor, or a decorative example; it
can only match phrases, and a phrase list catches too little while
flagging legitimate prose. Steering acts where the failure happens —
at generation and right after it. The ambient channels shape what the
agent is about to write; the review channel reads what it wrote. The
review comes at the end of the work because a long turn drifts, and
the agent can fix drift it reads in the same turn; a review after each
write would re-read a file edited many times in one turn, and a
review at write time cannot read a sentence that does not yet exist.
Reminding on every call keeps the instruction fresh across a
tool-heavy turn at the price of one short line per call, and the
reminder renders nowhere, so the owner's conversation stays clean. The
Stop hook is the backstop rather than the path because it costs a
visible extra turn after every turn that wrote prose; a turn that
cleared its list costs nothing. The conduct channel covers the
session's own voice: spoken replies and reports go through no file
write, and the conduct is the one layer present in every session the
owner works in, project or not.

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
- Injecting the standard at the moment of each write through a
  PreToolUse hook — an earlier shape: the freshest instruction the
  model holds at the write, but it shapes prose before it exists and
  leaves a long turn's drift unread.
- The Stop hook as the review path — the prior shape: one guaranteed
  review per turn, at the price of a visible extra turn after every
  turn that wrote prose, and a detector that also flagged the command
  text of a Bash call and so reached the agent's conversational
  output.
- Reviewing after every write — one review per edit, re-reading a
  file edited many times in one turn.
