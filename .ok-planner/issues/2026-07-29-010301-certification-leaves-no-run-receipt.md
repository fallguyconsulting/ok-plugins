---
issue: certification-leaves-no-run-receipt
kind: human
category: process-integrity
artifacts:
  - story:certify-completion
  - decision:recorded-adjudication
status: open
opened: 2026-07-29T01:03:01Z
---

# Certification's judgment layer leaves no durable trace, so a skipped pass and a clean pass are indistinguishable

## Problem

The change inspector — the judgment layer of the two-layer re-audit
trigger — reports its reconciliation ledger in-context only; nothing
is written to disk unless it happens to nominate audits. The
implementation-audit producer's clean bar includes "no provisional
note is left open on an audited file, and no ledger hunk is without a
disposition" — both clauses go vacuously true when the inspector is
never dispatched, because no notes and no ledger exist to fail them.
The mechanical layer cannot cover the gap: `audit-check` trips only
when cited hashes or anchors move, and code added beside a cited span
is exactly what the judgment pass exists to catch.

Observed: a goal-seeking session skipped the inspector's re-run after
fix cycles changed the code, keyed on the re-review rule's opening
filter ("re-run each producer whose findings were worked or whose
subject a fix touched"), and the gate presented clean. In the
session's own words, "a skipped pass and a clean pass are
indistinguishable to the gate."

When these skill changes were conceived, the intent was an artifact
representing all new and changed items — a durable record tracking
and proving the certification process. The source-graph work (audit
invalidation) landed; the certification artifact never did. The
general principle from this failure class: a prompt rule that has
been misread once gets rewritten so the wrong reading no longer
parses, or converted into a mechanical check — this issue is the
mechanical-check half.

## Candidates

- Certification writes a durable run receipt keyed to the change it
  certified (content-addressed to the diff): the inspector's ledger
  with every hunk's disposition, the producers that ran, the cycles.
  `audit-check` gains a check that a receipt exists and covers the
  current change, so a skipped inspector pass fails mechanically.
- Narrower: the inspector writes only the ledger to a committed file
  under the audits estate, and the gate's clean bar references that
  file's coverage of the current diff rather than in-context text.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
as a permanent, committed **inspection registry** at
`.ok-planner/audits/inspection.md` — node-keyed, hash-pinned, judged
classes only (residue and adjudicated pointers; the mechanical
disposition is recomputable and never stored), with audit-style
precedent semantics: entries stand while their pins hold, lapse when
the code they name changes, and ride forward sprint to sprint, so
each inspection pass works only the unclassified new work.
`audit-check` gained an `--inspection` mode (findings
inspection-missing / inspection-malformed / inspection-unclassified:
every source-graph node the uncommitted change touched must be
mechanically accounted or covered by a live entry), wired into both
gates' clean bars and the completion contract's audit item — so a
skipped judgment pass now fails mechanically, for the certify
orchestrator and the goal checker alike. The human-readable ledger
continues to ride the completion report via the presentation. The
residue is served to the dashboard: corpus-view gained
`/api/inspection` and the overview page lists standing residue.
Verified by six new harness cases (33 total passing). Stays open for
the next sprint to ratify; ships with the next release/re-vendor.
