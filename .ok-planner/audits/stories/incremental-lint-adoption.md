---
audit: incremental-lint-adoption
artifact: story:incremental-lint-adoption
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:70bd328bf4a6
---

# A legacy backlog is surveyed, clustered, planned into passes, and held behind a one-way ratchet

## Confirmation

Satisfied. All four steps the story asks for exist as verbs over the project's
own pinned binary, and each is exercised end to end against a seeded legacy
backlog in the plumbline harness's adoption run.

- **Surveyed** — the `audit` verb runs the lint over the whole project and
  reports the total, the breakdown by check code, and the worst files. The
  harness runs the verb's own `## Run` block over a repo seeded with five
  violations across `.py` and `.js` files and asserts the category and file
  groupings name the seeded defects.
- **Clustered by shape** — `plumbline patterns` buckets each violation by a
  computed signature (`divider`, `license-fragment`, `todo-marker`,
  `commented-out-code`, `doc-residue`, `disallowed-prose`; citation violations
  by tag), printing counts and up to three sample sites. The harness asserts the
  seeded backlog surfaces as clusters including `todo-marker` and
  `disallowed-prose`.
- **Planned into passes** — the `port` verb emits a phase-by-phase plan
  (Adopt / per-check passes / Maintain) built from `diagnose`, the lint counts
  and the cluster report. The harness runs the verb's `## Run` block, asserts
  the plan enumerates the passes down to the Maintain steady state, asserts the
  verb is read-only by default (nothing written into the project), and asserts
  an explicitly named output path is honored.
- **Held behind a one-way ratchet** — `budget save` records the count and
  per-check breakdown in `.ok-plumbline/budget.json`, and `budget check` exits 2
  when the count rises and 0 when it holds or falls; `save` refuses (exit 2) to
  raise a recorded baseline. The harness exercises all four directions —
  baseline recorded, added violation fails, holding change passes, reducing
  change passes and is reported below baseline, and a raise is refused — plus a
  second sandbox covering the pre-migration baseline location.

## Referrals

- referral: whether the emitted port plan is a plan an owner would actually want
    to execute — its pass ordering, its per-cluster advice, its stopping points
  clause: "surveyed, clustered by shape, planned into passes"
  delivered: a generated plan with a fixed phase structure, the live cluster
    report embedded, and per-shape remediation guidance — cited below
  discipline: human-review

## Citations

- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function patternsCmd(target) {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function commentHygieneShape(v, fileCache) {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "          `plumbline budget: refusing to raise the baseline — ${count} violation(s) exceeds the recorded ` +"
- cite-node: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md#ok-plumbline-audit.run @ sha256:b608d4655b00
- cite-node: plugins/ok/families/ok-plumbline/skills/port/SKILL.md#ok-plumbline-port.run @ sha256:47cf7f77b37d
- cite-node: plugins/ok/families/ok-plumbline/skills/budget/SKILL.md#ok-plumbline-budget.run @ sha256:27bed9eba9c3
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_adoption_proof @ sha256:74f88c33a7bd
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_ratchet_case @ sha256:a075f0238ab9
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#skill_run_block @ sha256:920cc884266d
