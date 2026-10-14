---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the one fixed stop condition every
sprint's execution answers to.

## Purpose

It tells whoever executes a sprint when the work is done, identically
for every executor (see also: no-execution-engine under decisions).

## Boundaries

The contract owns the definition of "done" for a sprint, and its scope
is the change: the stories and decisions the work touched, and which
stories that reaches is a decision (see also:
drive-tries-each-story-as-a-user under decisions). How a failure
outside the change is handled is a decision (see also:
defects-outside-scope-become-defect-issues under decisions). Whether
the corpus's claims still hold against the code is a decision of its
own (see also: adversarial-implementation-audits under decisions). It
does not own how work is staged or performed (see also: sprint), and
it does not derive the record it requires (see also: completion-report,
task-tracker). See also: certify-completion under stories.
