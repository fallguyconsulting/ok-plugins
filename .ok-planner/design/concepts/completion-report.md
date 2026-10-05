---
concept: completion-report
---

# Completion report

## What it is

The completion report is a sprint execution's durable record: the work
done, every divergence, every call made where the sprint was silent,
every fork the build met and could not settle, and the return of the certification that closes the
execution. It is a record of one execution rather than a plan document.

## Purpose

The report gives the close of a sprint an artifact instead of a
memory. It lets the close's material survive the session that produced
it, and gives the completion contract an inspectable term (see also:
sprint-goal-read-from-the-repository under decisions). It also carries the
build's account of its calls and forks to sprint certification.

## Boundaries

The report owns the record of one execution: what was done, what
diverged, what was decided in the owner's absence, which forks the
build met, and the certification's return.
It does not own the work's definition (see also: sprint), the
derivation of certification outcomes (see also: certify-completion
under stories), or the audit record (see also:
adversarial-implementation-audits under decisions). It is a project
record (see also: estate, task-tracker; records-stay-out-of-context,
team-execution-cold-gate, task-tools-mirror-the-report under
decisions).
