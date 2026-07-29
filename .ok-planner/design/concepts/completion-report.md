---
concept: completion-report
---

# Completion report

## What it is

The completion report is a sprint execution's durable record: one
file beside the sprint document, named for it, that the executor
keeps current as stages land — the work done, every divergence, and
every call made where the sprint was silent — and that the closing
certification finishes by writing its presentation into. It is a
record of one execution, never a plan document, and it archives
together with its sprint.

## Purpose

The report gives the close of a sprint an artifact instead of a
memory. Without a durable report, the end-of-sprint ceremony —
outcomes, divergences, the archive-and-commit offer — lives only in
conversation, where any upstream failure deletes it silently, and a
completion contract's final term is a claim about session history no
checker can inspect. The report lets the ceremony's material survive
the session that produced it, gives the contract an inspectable
final term, and gives a goal checker the artifact whose absence
means not-done.

## Boundaries

The report owns the record of one execution: what was done, what
diverged, what was decided in the owner's absence, and — once
certification finishes it — the presentation the owner walks. It
does NOT own the work's definition (see also: sprint), the
derivation of certification outcomes (see also: certify-completion
under stories), or the audit record (see also:
adversarial-implementation-audits under decisions). Once archived it
is a project record under the estate's record discipline (see also:
estate).

## Invariants

- Kept by the executor from the first stage, never reconstructed at
  the end.
- Finished only by the closing certification: the presentation the
  owner walks is written into the report, so the artifact a goal
  checker requires and the ceremony the owner sees are the same
  thing.
- Archives with its sprint, as one record of intent and execution.
- A sprint without its finished report is not done, whatever else
  verifies.
