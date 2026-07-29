---
inspection-registry: v1
inspected: 2026-07-29T08:40:59Z
---

# Inspection registry

- node: plugins/ok/families/ok-plumbline/test/run.sh#example_block @ sha256:30a60c3ee84a
  class: adjudicated
  audit: story:explain-lint-rules
  note: new helper — extracts a worked example's whole block so the other new helpers can read its starting state out of the topic text.
- node: plugins/ok/families/ok-plumbline/test/run.sh#example_config_entry @ sha256:d0a911a0698c
  class: adjudicated
  audit: story:explain-lint-rules
  note: new helper — reads a worked example's config-entry JSON out of its own block instead of the harness reproducing it verbatim.
- node: plugins/ok/families/ok-plumbline/test/run.sh#example_source_content @ sha256:3c0657bb009f
  class: adjudicated
  audit: story:explain-lint-rules
  note: new helper — reads a worked example's source-file body out of its own block instead of the harness reproducing it verbatim.
- node: plugins/ok/families/ok-plumbline/test/run.sh#example_source_file @ sha256:e963d98cdf79
  class: adjudicated
  audit: story:explain-lint-rules
  note: new helper — reads the path of a worked example's source file out of its own block.
- node: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md#the-verbs @ sha256:ad6902123767
  class: residue
  note: hub-row repair syncing the `/certify-work` row to its own (unchanged) frontmatter description per the router's single-sourcing rule, enforced by `checks/hub-rows` (which passes) — no story or decision audit claims the router's per-verb summary table as its territory: the two audits that cite this file (decision:no-execution-engine, on "Never turn a sprint into a plan document" / "Executing a sprint needs no orchestrator" in the prose above the table) and decision:slash-only-activation (which pins certify-work's *guard sentence* and the gates' *producer-list invocations* of prove/audit, both untouched here) claim narrower, disjoint territory. The changed text is the scope-description clause only, not the guard clause.
- node: checks/text-presence @ sha256:3f0942864be5
  class: adjudicated
  audit: decision:no-execution-engine
  note: whole-file node; this run's assertion-text edits (the prove-audit-audience-split and no-execution-engine assert_present bodies) are the exact repair decision:no-execution-engine's own Notes narrate this cycle ("the fixer did exactly what the prior pass's tripwire called for"), and its Citations pin the file whole at this hash.
- node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: whole-file node; the new `check_inspection`/`parse_inspection_registry`/`identity_contains`/`outside_units_moved` spans this run added are cited by decision:two-layer-invalidation at these exact span hashes, and its whole-file citation pins the current bytes.
- node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:e293c0d31163
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: whole-file node; the new `declared_units`/`declared_unit_spans` extraction this run added (imported by the inspection floor to excise declared-unit spans) is cited by decision:two-layer-invalidation at the current span hash, and its whole-file citation pins the current bytes.
- node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md#ok-planner-the-planner-s-directory @ sha256:6ad9d8cab6c3
  class: adjudicated
  audit: decision:prove-audit-audience-split
  note: top-section node (covers `.executing-a-sprint`, `.the-audit-corpus-and-the-source-graph-audits-graph`, `.the-issue-intake-issues-questions-awaiting-judgment`); this run's two edits — the cycle-cap-escalation clause in the issue-intake section and the "issue intake is reached only by the two gated paths" clause in the executing-a-sprint section — are both quoted verbatim in decision:prove-audit-audience-split's Citations at the current hash.
- node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md#ok-planner-cheatsheet @ sha256:1d1d41e12b03
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: top-section node (covers `.lifecycle`, `.proofs-audits-and-the-source-graph`); decision:two-layer-invalidation cites this file's "What triggers a re-audit is two layers, never annotations" sentence (in the proofs/audits section) and pins the file whole at the current hash, which covers this run's Lifecycle-section rewording of the two-gated-paths clause too.
- node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions @ sha256:4d1c78ea8291
  class: adjudicated
  audit: decision:adversarial-implementation-audits
  note: top-section node (covers `.token-catalog` and its `audit-definition`/`audit-file-format`/`decidability-boundary`/`inspection-registry-format`/`issue-file-format`/`mechanical-vs-judgment-rule`/`proof-protection-rule`/`story-definition` children); decision:adversarial-implementation-audits cites the whole file and several of these token entries by node hash at current values (the inspection-registry-format entry's own new sentence — "The judged population is every node whose recorded hash moved" — is separately quoted by decision:inspection-registry and decision:two-layer-invalidation).
- node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core @ sha256:7384a8b0aa2d
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: top-section node (covers `.how-consumers-use-this-file` and its seven prompt-section children); this run's edit — the change-inspector prompt's step 4/4b now covering a commit-range base ref — falls inside spans decision:two-layer-invalidation cites verbatim ("3. Disposition the hunk:", "4. Record each nomination...", "4b. Update the inspection registry...") at current hashes, and its whole-file citation pins the rest.
- node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:bf7abd501b40
  class: adjudicated
  audit: decision:prove-audit-audience-split
  note: whole-file node (covers `#audit-the-design-corpus` and `.process`); this run's "two gated paths" rewording of the routing sentence is quoted verbatim in decision:prove-audit-audience-split's Citations, which also pins the file whole at this hash.
- node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:159d3ec5e21f
  class: adjudicated
  audit: decision:prove-audit-audience-split
  note: whole-file node (covers `#certify-everything-the-full-gate`, `.process`, `.what-certify-orchestrates`, `.what-this-skill-does-not-do`); this run's "two gated paths" rewording under "What this skill does NOT do" is quoted verbatim in decision:prove-audit-audience-split's Citations, which also pins the file whole at this hash.
- node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:545c0291b717
  class: adjudicated
  audit: decision:prove-audit-audience-split
  note: whole-file node (covers `#certify-the-work-the-change-scoped-gate`, `.process`, `.what-this-skill-does-not-do`); this run's two edits — the implementation-audit producer's `--inspection=<base>` clean-bar clause and the "What this skill does NOT do" two-gated-paths rewording — are both quoted verbatim across decision:prove-audit-audience-split's and decision:inspection-registry's Citations at the current hash; prove-audit-audience-split's whole-file pin covers the node.
- node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: whole-file node (covers the new `add_node_entry`/`edit_util_in_unit`/`edit_util_module_level`/`mk_committed_util`/`mk_git_fixture`/`reset_registry`/`sub_in_file` harness helpers this run added for the inspection-floor test cases); decision:two-layer-invalidation cites this file's `run_case "inspection: ..."` cases by name and pins the file whole at the current hash.
- node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:0c4a64e5255e
  class: adjudicated
  audit: story:explain-lint-rules
  note: whole-file node (covers the `brief`/`example_config_path`/`example_reported_line`/`run_explain_proof` harness helpers this run added or reworked for the explain-verb worked examples); story:explain-lint-rules pins the file whole at the current hash.
