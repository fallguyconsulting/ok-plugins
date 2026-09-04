---
concept: completion-report
---

# Completion report

## What it is

The completion report is a sprint execution's durable record: the file
the executing session renders from the sprint's task run as stages
land — the work done, every divergence, every call made where the
sprint was silent, and every fork a build task met and could not
settle, recorded with its options — and that the closing certification
finishes by writing its presentation into. It is a record of one
execution rather than a plan document, and it archives together with
its sprint.

## Purpose

The report gives the close of a sprint an artifact instead of a
memory. Without a durable report, the end-of-sprint ceremony —
outcomes, divergences, the archive-and-commit offer — lives only in
conversation, where any upstream failure deletes it silently, and a
completion contract's final term is a claim about session history no
checker can inspect. The report lets the ceremony's material survive
the session that produced it, gives the contract an inspectable
final term, and gives a goal checker the artifact whose absence
means not-done. It is also the channel from the build to the gate:
the certification gate reads the divergences and claimed forks
recorded here, and a replacement session renders the same report
from the run file and files the next task from where the last one
closed.

## Boundaries

The report owns the record of one execution: what was done, what
diverged, what was decided in the owner's absence, which forks were
left for the gate, and — once certification finishes it — the
presentation the owner walks. It does NOT own the work's definition
(see also: sprint), the derivation of certification outcomes (see
also: certify-completion under stories), or the audit record (see
also: adversarial-implementation-audits under decisions). The run file it is
rendered from is the working record and owns the items (see also:
team-execution-cold-gate under decisions); a harness task list may
mirror its staged list for display and owns nothing (see also:
task-tools-mirror-the-report under decisions). Once
archived it is a project record under the estate's record discipline
(see also: estate).
