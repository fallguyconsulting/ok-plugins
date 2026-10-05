---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering, through two channels.
ok-planner's rules files carry the standard's portable dispatch rule
ambiently, pointing at the full standard materialized in the estate,
so the standard is in context for every write. The personal conduct
carries the same rule as session-wide governance, in its output style
and in the rules it restates with every prompt, binding everything a
session writes and says — replies, reports, issues, commit
messages, authored skill prose — where no rules file is in context.
No hook detects prose and no hook reviews it: ok-planner's lint edit
hook lints comments, citations, and tests after an edit and does
nothing else.
No prose lint exists: the lint's charter stays comments, citations,
and tests.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot
see elegant variation, a broken metaphor, or a decorative example; it
can only match phrases, and a phrase list catches too little while
flagging legitimate prose. Steering acts where the failure happens:
at generation. The ambient channels shape what the agent is about to
write, and the conduct channel covers the session's own voice, since
spoken replies and reports go through no file write and the conduct
is the one layer present in every session the owner works in, project
or not. The conduct restates its rules with every prompt because a
rule stated once at session start loses weight as the session grows.

## Alternatives

- A prose lint in the lint binary — the decidable subset (a
  banned-phrase list, sentence-length caps) is a poor proxy for the
  standard, and false positives would teach agents to ignore the lint.
  Rejected as too rigid, and it would widen the lint's charter from
  comments, citations, and tests to prose.
- Rules files only — reaches every agent, but relies on ambient
  salience alone with nothing at the moment of writing.
- The dispatch rule pasted into every skill prompt — depends on every
  skill author remembering it; the standard would erode one forgotten
  prompt at a time.
- Rules files and the lint hook, no conduct channel — files are
  steered but the session's own replies and reports are governed by
  nothing, and the standard stops at the terminal.
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
