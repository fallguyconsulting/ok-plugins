---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-29T13:15:00Z
artifact-hash: sha256:4b49aa7b6bd9
---

# Are implementation claims verified by adversarial per-artifact audits with a deterministic staleness checker, rather than by test mandates?

## Confirmation

Satisfied. The decision's choice is respected by an auditor prompt that
carries the whole charter and by a vendored checker that enforces the
mechanical half.

- **A fourth corpus collection, one determination per artifact, written by a
  non-implementing producer.** The auditor prompt is dispatched as a fresh
  agent, writes only under `.ok-planner/audits/{stories,decisions}/`, and its
  consumer rules state author separation as load-bearing; the fixer's
  instructions never touch audit files.
- **Implemented AND covered, bounded by decidable claims.** The prompt's
  method requires, for every code-implemented claim, a test in the project's
  ordinary suites exercising it end-to-end, cited; for every quantified
  claim, the population enumerated from reality with the source pinned and
  completeness computed as the difference of two lists; for every
  prose-realized claim, a narrow prose citation and no test. Qualitative
  clauses ground no determination and become `## Referrals` entries under
  the decidability boundary.
- **Citations cover both frontiers and are node pins, never reproductions.**
  The audit definition fixes four forms — `cite-node:` (declared unit or
  whole-file population pin), `cite:`, `cite-span:`, `cite-file:` — states
  that test files are cited like any evidence, and forbids line numbers and
  pasted code.
- **A deterministic checker flags what moved.** `check_audit` verifies the
  design artifact's hash against `artifact-hash` and re-verifies all four
  citation forms: a `cite:` anchor that vanished, a `cite-span:` region whose
  content hash moved or whose anchor stopped being unique, a `cite-file:`
  pin that moved, and a `cite-node:` identity that no longer resolves or
  whose graph-recorded hash moved (with a missing or tree-divergent graph
  reported as `graph-missing` / `graph-stale` rather than passed). Exit 2 on
  findings; `--list-stale` prints the machine-readable re-audit set. The
  re-audit set's second half — the change-inspection nominations the auditor
  adjudicates — is assembled by the gates as the union of the stale set and
  the inspector's nominations.
- **Release-mutable metadata is masked before anything a citation or pin
  covers is hashed.** `mask_release_metadata` neutralizes the
  `Materialized by … v<semver>` stamp, every `v<semver>` on a line naming a
  suite family (the session hook banner, vendored script headers), `VERSION`
  stamp assignments, and the `"version"` field of `.claude-plugin/plugin.json`
  manifests; it is applied to `cite:` anchors, `cite-span:` regions, and
  `cite-file:` pins, and the source-graph extractor records the same masked
  hash for `cite-node:` pins.
- **The auditor reads and judges, never executes.** The prompt embeds the
  read-only reviewer rule and states that a claim only running could settle
  is a violated determination, never a reason to run anything.
- **A violated audit stands and blocks unless linked.** `check_audit` emits
  `violated-unlinked` for a violated determination with no `issue:` link and
  `issue-link-dangling` when the link names no file in the intake or its
  archive.

The checker is the code half, and the planner's own harness exercises it
end-to-end over fixture corpora: clean, missing, orphaned, malformed, stale
artifact, stale anchor, changed span, ambiguous anchor, changed population
source (text and binary), unresolved and moved node identities, stale and
missing graphs, the `--list-stale` re-audit set, violated with and without
an issue link, and five masking cases — a two-release version bump passing
while a non-version edit on each of the same masked surfaces trips.

## Referrals

- referral: an audit reads as a terse, current-state pass/fail written for an experienced engineer with little project knowledge and little time
  clause: "written for an experienced engineer with little knowledge of the project and not a lot of time"
  delivered: a fixed audit file format with a bounded Confirmation section, plus prompt rules forbidding history, prior determinations, and hypotheticals
  discipline: editorial

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.audit-definition @ sha256:8e0d767c1a33
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.audit-file-format @ sha256:d2458c7acd70
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.decidability-boundary @ sha256:03a36ac375df
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.the-prompt @ sha256:d77b1a67b4e1
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "Author separation is load-bearing:"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md#dispatch-discipline.read-only-reviewer-rule @ sha256:bc6597067806
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs,"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def mask_release_metadata(text, target):"
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:435b82f8b39b
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "violated without issue"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "edit beside stamp trips"
