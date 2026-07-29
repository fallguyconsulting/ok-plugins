---
audit: corpus-audit
artifact: story:corpus-audit
determination: satisfied
audited: 2026-07-29T13:15:00Z
artifact-hash: sha256:f666a997d6c6
---

# A whole-corpus check covering compliance, audit-corpus health, annotation integrity and cross-artifact conflict, every finding classed

## Confirmation

Satisfied. The audit verb is vendored into this project as
`.claude/skills/ok-planner-audit/SKILL.md` and is invocable on demand by
its slash command (and by the whole-corpus certification gate as a
producer); it is a pure reporter that writes nothing and returns findings
in-context.

- **Whole design corpus.** The verb's scope is the durable design docs under
  `design/`; Pass 1 dispatches the shared compliance reviewer in
  whole-corpus mode, and Pass 3 reads every live concept, story and decision.
- **Compliance** is Pass 1, the shared design-doc compliance reviewer.
- **Audit-corpus health** is Pass 2's mechanical floor, which runs the
  project's vendored `audit-check` and folds its findings in verbatim rather
  than re-deriving them. That floor is code and the checker suite exercises
  it end to end over fixture corpora: a clean corpus, a live artifact with
  no audit, a design artifact whose hash moved, a citation whose anchor no
  longer anchors, an audit whose artifact is not live, a standing violation
  with and without an intake link, and the machine-readable re-audit set.
- **Annotation integrity** is Pass 2's second half: every
  `@concept:`/`@story:`/`@decision:` pair found by grep must resolve to a
  live artifact file, with dangling and kind-mismatched tags reported.
- **Cross-artifact conflict** is Pass 3, the pass no per-artifact check can
  perform — contradictions *between* live artifacts.
- **Every finding classified mechanical or judgment.** The classification
  rule is stated once and transcluded into each dispatch; the compliance
  reviewer's per-finding output format carries a `Class:` field, and Passes
  2, 3 and 4 each classify in their own output instructions. The verb's
  report format returns every finding from every pass verbatim with its
  class under a single status line.

## Referrals

- referral: whether the judgment passes actually surface the rot that is
    there — real compliance defects, real contradictions between artifacts,
    real corpus holes
  clause: "so that design rot surfaces the moment I ask instead of
    accumulating silently"
  delivered: four dispatched passes exist with stated scopes, per-pass
    output formats and anti-padding rules; the mechanical half of Pass 2 is
    the deterministic checker, cited below
  discipline: human-review

## Citations

- cite-node: .claude/skills/ok-planner-audit/SKILL.md @ sha256:4315217a0153
- cite-node: .claude/skills/ok-planner-audit/SKILL.md#audit-the-design-corpus.process @ sha256:73dd205a8487
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "**Pass 1 — compliance.**"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "**Pass 2 — coverage + intent-drift + annotation integrity.**"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "### Audit-corpus health (mechanical floor)"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "### Annotation integrity (mechanical)"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "**Pass 3 — cross-artifact consistency.**"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "**Pass 4 — surface inventory.**"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "Status: clean | findings"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "Class: `mechanical` or `judgment`. The line is intent, not"
- cite-file: .ok-planner/bin/audit-check @ sha256:f8a269917b2e
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "clean corpus""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "missing audit""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "orphaned audit""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "violated without issue""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
