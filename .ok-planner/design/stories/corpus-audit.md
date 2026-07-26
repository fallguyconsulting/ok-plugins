---
story: corpus-audit
---

# Audit the corpus and file the judgment calls

## Story

As a project owner, I want the whole design corpus periodically checked for compliance, proof coverage, intent drift, and cross-artifact conflict, with mechanical defects reported for immediate fixing and judgment questions filed to my intake queue, so that design rot surfaces as an owner-calibrated worklist instead of accumulating silently.

## Acceptance

The audit runs over a project with a corpus → the caller receives the mechanical findings to fix in-cycle and re-runs to clean; genuine judgment findings appear as deduplicated open rows in the intake queue; nothing else in the project is written. Its append to the queue is reporting, not fixing — the verb is otherwise read-only against corpus and code, and it never executes proofs. The three-pass audit (compliance, coverage-and-drift, cross-artifact consistency) is real.

## Falsifier

Corpus muddiness or a claim that outran the code passes without a finding; the audit fixes artifacts itself or writes terminal queue events; judgment findings never reach the queue; or re-observing an open issue appends a duplicate row.

## Proof

Demo — an audit over a corpus seeded with a known compliance violation, an uncovered claim, and a cross-artifact contradiction, after which a third party finds the mechanical item in the caller's report and the judgment items as open queue rows, with a second run appending nothing new.
