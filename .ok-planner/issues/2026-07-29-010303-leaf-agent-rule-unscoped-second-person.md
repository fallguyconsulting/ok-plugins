---
issue: leaf-agent-rule-unscoped-second-person
kind: human
category: dispatch-discipline
artifacts:
  - concept:skill
  - story:plan-a-sprint
status: open
opened: 2026-07-29T01:03:03Z
---

# The leaf-agent rule's unscoped "you" lets executors adopt it and skip the dispatch-built certify step

## Problem

The canonical leaf rule reads "You are a leaf agent: NEVER spawn
subagents…" — second person, unconditional, with nothing in the
block saying who "you" is. It is designed for transclusion into
dispatched prompts, but any agent that reads the shared file while
assembling context (or receives it pasted alongside a sprint) can
bind the "you" to itself.

Observed: a sprint executor adopted the prohibition and skipped the
/certify-work close entirely, because that skill's process is built
on dispatches (fixer, architect, inspector, code reviewer). The
collision has no written resolution: the boilerplate's blocker list
(credential, impossible step, unauthorized destructive action) does
not name "cannot run the terminal ceremony," and the leaf rule has
no surface-don't-skip clause. The executor picked the wrong
resolution of an unresolved conflict, and nothing caught it because
contract discharge is self-reported.

## Candidates

- Add a scope sentence to the leaf rule: it governs the dispatched
  job it is embedded in, and an instruction that requires dispatching
  (such as the terminal certify step) is a blocker to surface, never
  a step to skip.
- Add "unable to run the sprint's terminal certification" to the
  execution boilerplate's genuine-blocker list.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
taking both candidates: the leaf rule now carries a scope paragraph
(it binds only the dispatched job it is embedded in — a session that
merely read the file is not addressed — and an instruction requiring
dispatches is a blocker to surface, never a step to drop), and the
sprint boilerplate's blocker list names the closing certification
being unrunnable as a genuine blocker, with "never skip the ceremony
and call the work done" stated. Stays open for the next sprint to
ratify; ships with the next release/re-vendor.
