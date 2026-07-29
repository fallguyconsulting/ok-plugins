---
audit: audit-audience-split
artifact: decision:audit-audience-split
determination: satisfied
audited: 2026-07-29T12:22:57Z
artifact-hash: sha256:bc558154009b
---

# Does the corpus-checking verb only report in-context, with certification reaching the intake through exactly two gated writers?

## Confirmation

Satisfied. The split is realized entirely in the skill prompts, and every
part of it is stated where it binds.

- **The audit verb writes nothing.** `/audit` is declared a pure reporter in
  its own frontmatter and body: it creates nothing, does not even ensure its
  own layout, and its boundaries state it does not touch the issue intake —
  no filing, no editing, no closing. Its report goes to its caller, the human
  who invoked it or the `/certify-all` gate consuming it as a producer.
- **Every finding carries a class.** Enumerated from the verb's own passes —
  compliance, audit-corpus health plus annotation integrity, cross-artifact
  consistency, surface inventory — each pass is instructed to classify its
  findings `mechanical` or `judgment`, and the report format carries the
  class through verbatim as advisory context.
- **Test runs are findings in context.** Both gates discover the project's own
  run commands from its docs and treat every failure as a finding for the
  review-fix loop; no producer files.
- **Exactly two gated paths reach the intake from certification.** Enumerated
  from the certification machinery itself: the architect, which writes an
  issue file only on a kickback it confirms after adversarially testing it,
  and the cycle cap's escalation, which files the remainders a bounded loop
  failed to fix — reachable only at the cap, taken only on the owner's word,
  with the run stopping and waiting rather than choosing for them. Nothing
  else in the loop writes to `.ok-planner/issues/`: the fixer, the change
  inspector, the auditor, and the reporting verb are all explicitly
  non-filers.
- **The ungated writers sit outside the repeating cycle.** The planning
  ceremony transcribes a postponed question directly, and the one-time corpus
  bootstrap files its judgment questions ungated but aborts rather than run
  again over a populated corpus — a non-empty `concepts/`, `stories/`, or
  `decisions/` stops it.
- **Dedup is every writer's discipline.** Enumerated from reality — the
  skills that write into `.ok-planner/issues/` are the certification core
  (architect and cap escalation), `/discover-design`, `/plan-sprint`, and
  `/verify-issues`'s legacy conversion. Each files per the canonical issue
  file format, whose first rule makes `issue:` a stable fingerprint and
  requires checking the slugs already present before filing; the architect
  and the bootstrap restate the check at their own filing sites.

Everything above is realized in prose — skill prompts and shared definition
blocks — so the evidence is the governing text, cited narrowly. No part of
this decision is implemented in code, and no test is owed.

## Referrals

- referral: the intake stays an owner-calibrated worklist rather than an agent-grown queue
  clause: "the owner's queue must stay an owner-calibrated worklist"
  delivered: two gated writers, one bounded by adversarial confirmation and one by loop exhaustion plus the owner's explicit word, with every other certification producer forbidden to file
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md#audit-the-design-corpus.process @ sha256:9b8e74e514ac
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md#audit-the-design-corpus.what-this-skill-does-not-do @ sha256:2c0cd2551adb
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing."
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:89f4f12cc0e9
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:b8ccf0f4689d
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-architect-prompt @ sha256:6ac606973af0
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "escalate the remainders"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Two paths reach the intake, and the owner is never asked live mid-cycle."
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.issue-file-format @ sha256:9c3133c7c24b
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:c803f8b9f4e6
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Non-empty `concepts/`, `stories/`, or `decisions/` → abort."
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md @ sha256:6abe2b109e9c
- cite-node: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md @ sha256:e08c536483bf
