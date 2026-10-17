---
concept: completion-report
---

# Completion report

## What it is

The completion report is a sprint execution's durable record: the work
done, every call, and the return of the certification that closes the
execution. A call is any judgment an agent made without the owner, in
the build or in the certification; a fork the build met and could not
settle is a call too. It is a record of one execution rather than a
plan document.

## Purpose

The report gives the close of a sprint an artifact instead of a
memory. It lets the close's material survive the session that produced
it, and gives the completion contract an inspectable term (see also:
sprint-goal-read-from-the-repository under decisions). It also carries the
build's account of its calls to sprint certification. At the close, it
puts every call before the owner at once, so the owner can veto any
call they disagree with (see also: veto-calls-made-in-my-absence under
stories).

## Boundaries

The report owns the record of one execution: what was done, what was
decided in the owner's absence, and the certification's return.
It does not own the work's definition (see also: sprint) or the
derivation of certification outcomes (see also: certify-completion
under stories). It is a project
record (see also: estate, task-tracker; records-stay-out-of-context,
team-execution-cold-gate, task-tools-mirror-the-report under
decisions).
