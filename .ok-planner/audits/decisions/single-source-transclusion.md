---
audit: single-source-transclusion
artifact: decision:single-source-transclusion
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:a7816b62a9dd
---

# Does canonical rule text live once and reach prompts by transclusion?

## Confirmation

Satisfied.

- **One shared directory, and it holds exactly the named files.** Enumerated from
  `plugins/ok/families/ok-planner/skills/_shared/` (all five pinned whole below):
  `artifact-definitions.md` (the artifact definitions),
  `design-doc-compliance-reviewer.md` (the shared reviewer prompt),
  `certification-core.md` (the certification core), `dispatch-discipline.md` (the
  dispatch discipline), `implementation-auditor.md` (the implementation-auditor
  prompt). Nothing else is in the directory.
- **Every block is defined exactly once.** Those five files carry 30 `### {{TOKEN}}`
  block headings and no token heading repeats; no `### {{TOKEN}}` heading exists
  anywhere else under `plugins/ok/families/ok-planner/skills/`, so no block is
  defined in more than one place and no definition is restated inline in a skill.
- **Prompts pull blocks in by named token, naming the source.** Skill dispatches
  carry `{{TOKEN}}` placeholders the assembling model replaces with the matching
  block body at dispatch time, and each reference names the file to read it from
  (`{{LEAF-AGENT-RULE}} from skills/_shared/dispatch-discipline.md`,
  `{{CERTIFY-CLOSE-OUT}}` from `skills/_shared/certification-core.md`,
  `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from
  `skills/_shared/implementation-auditor.md`). Every `{{TOKEN}}` occurrence under
  the skills tree resolves to one of the 30 blocks; the one exception is the
  generic `{{TOKEN}}` placeholder `discover-design` uses to describe the convention
  itself.
- **Main-loop skills reference the shared files directly.** `/plan-sprint` is told
  to read `skills/_shared/artifact-definitions.md` before authoring anything rather
  than restating it, and `/certify-work` states that everything outside its scope
  section is defined once in `skills/_shared/certification-core.md`; the family's
  own rules record the prohibition — "Never restate a definition inline in a skill
  — edit the shared file."
- **Exercised end-to-end by the repo's own suite.** `checks/token-resolution` is
  run over the real tree by `bash checks/run` and fails on both halves of the
  commitment: a `{{TOKEN}}` that resolves to no `###` heading in `skills/_shared/`,
  and a token defined more than once there.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md @ sha256:9c818730cd50
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:89f4f12cc0e9
- cite-node: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md @ sha256:6a4f80c4786f
- cite-node: plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md @ sha256:c10dd1d13279
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:7a1b8bfd01a8
- cite-node: checks/token-resolution @ sha256:0b5f17a4fab5
- cite-node: checks/run @ sha256:e827e4abcc44
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Read `skills/_shared/artifact-definitions.md` before authoring anything. Every delta this skill drafts must already comply with the canonical artifact rules — the sign-off review below checks exactly that."
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Everything that is not scope is shared verbatim with `/certify-all` and defined once in `skills/_shared/certification-core.md`: the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation. The two gates differ only in what they look at."
- cite: plugins/ok/families/ok-planner/CLAUDE.md :: "Never restate a definition inline in a skill — edit the shared file."
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md#discover-design.shared-rule-blocks-transclude-into-dispatches @ sha256:5bcf240eee06
