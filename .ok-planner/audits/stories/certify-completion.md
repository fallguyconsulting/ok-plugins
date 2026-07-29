---
audit: certify-completion
artifact: story:certify-completion
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:f1bca1d8d444
---

# Does an owner get one terminal gate that aligns work to its sprint, drives findings to zero unattended, and presents the outcome whole?

## Confirmation

Satisfied. The gate exists as a single named terminal step and each of the
story's four capabilities is delivered from a cited surface.

- **One terminal gate.** `/certify-work` is the change-scoped close, and the
  execution boilerplate every sprint carries names it as the closing step
  ("Close by running `/certify-work`"). `/certify-all` is not a second
  terminal step: it is the owner-cadence whole-corpus revisit, and no sprint
  boilerplate routes through it.
- **Aligns finished work to its sprint.** The gate dispatches a dedicated
  sprint-alignment producer with the sprint path filled: every corpus delta
  applied verbatim, every work item's outcome realized (an undershoot is
  blocking), and the changed corpus coherent with the live corpus.
- **Drives every fixable finding to zero without mid-run involvement.** The
  review-fix loop is a no-discretion cycle — producers, then fixer, then
  architect on kickbacks, then re-review — in which the orchestrator only
  moves verbatim lists and counts cycles. The gate's own boundaries forbid
  asking the owner questions mid-cycle; the cycle cap is the run's single
  stop, and the two intake paths (architect-confirmed forks, cap
  remainders) are what a finding the loop cannot fix resolves to.
- **Presents outcomes and divergences whole.** The presentation is composed
  in full into the sprint's completion report and walked with the owner:
  Outcomes delivered, Divergences (every fixer call, every corpus repair,
  every architect refutation — each named for after-the-fact veto),
  Findings fixed, Reconciliation ledger, Referrals, Issues promoted.
- **"Done" means the same thing for every piece of work.** The completion
  contract is fixed boilerplate included verbatim in every sprint the
  planning ceremony writes, and it is what `/certify-work` discharges.

The one part of the gate realized in code rather than prose is its
mechanical clean bar — `audit-check --inspection` exiting 0, so a skipped
judgment pass cannot read clean. That is exercised end-to-end by the
planner's story-level suite, which seeds a git repository, introduces a
change no citation covers, asserts the checker fails the clean bar, then
records the disposition and asserts the same tree passes; the checker
harness exercises the same floor across missing, unclassified, lapsed, and
range-scoped registries.

## Referrals

- referral: the presentation puts the run's outcomes and divergences in front of the owner "whole"
  clause: "presents outcomes and divergences to me whole"
  delivered: a fixed presentation template with named sections for outcomes, divergences, findings, ledger, referrals, and promoted issues, composed in full and written into the sprint's completion report
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:5fa3fe424650
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:b8ccf0f4689d
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.sprint-alignment-prompt @ sha256:3094f0778407
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:4b100f0fc6d5
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.3-draft-the-sprint @ sha256:d1bf6f29f761
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Close by running `/certify-work`. It brings the work into"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "sections are fixed boilerplate — include both verbatim in every sprint"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Two paths reach the intake, and the owner is never asked live mid-cycle."
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities,"
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "certify-completion: a skipped judgment pass fails the gate's clean bar mechanically instead of reading clean"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "the same tree passes once the judgment pass recorded its disposition durably"
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "inspection: missing registry"
