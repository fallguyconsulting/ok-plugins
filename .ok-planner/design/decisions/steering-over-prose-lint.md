---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering, through two channels.
The family cheatsheet carries the standard's portable dispatch rule
ambiently, pointing at the full standard materialized in the estate,
so the standard is in context for every write. The personal conduct's
output style carries the same rule as session-wide governance, binding
everything a session writes and says — replies, reports, issue files,
commit messages, authored skill prose — where no cheatsheet is in
context. No hook detects prose and no hook reviews it: the plumbline
hooks lint comments and citations after an edit and do nothing else.
No prose lint exists: the plumbline lint's charter stays comments and
citations.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot
see elegant variation, a broken metaphor, or a decorative example; it
can only match phrases, and a phrase list catches too little while
flagging legitimate prose. Steering acts where the failure happens:
at generation. The ambient channels shape what the agent is about to
write, and the conduct channel covers the session's own voice, since
spoken replies and reports go through no file write and the conduct
is the one layer present in every session the owner works in, project
or not. A review pass after the write was measured and dropped: a
Stop hook that continued the turn once to have the agent reread its
prose cost a visible extra turn after every turn that wrote prose,
each continuation call re-reading the session's whole context, and
the rewrites it produced did not read better than the first draft.

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
- Cheatsheet and hooks, no conduct channel — files are steered but
  the session's own replies and reports are governed by nothing, and
  the standard stops at the terminal.
- Injecting the standard at the moment of each write through a
  PreToolUse hook — the freshest instruction the model holds at the
  write, but it shapes prose before it exists and leaves a long turn's
  drift unread.
- A PostToolUse prose detector with a Stop hook review — one review
  per turn of every file the turn wrote, at the price of a visible
  extra turn after every turn that wrote prose, each continuation
  re-reading the whole context, for rewrites no better than the draft.
- Reviewing after every write — one review per edit, re-reading a
  file edited many times in one turn.
