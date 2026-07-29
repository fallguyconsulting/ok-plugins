---
inspection-registry: v1
inspected: 2026-07-29T14:09:28Z
---

# Inspection registry

- node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
  class: adjudicated
  audit: decision:vendored-skills
  note: new `build_finding` helper and its call sites are additional
    fixture plumbing inside a file vendored-skills already cites whole;
    no citation moved because the pinned (masked) hash already matches
    this content.
  adjudication: dismissed — `build_finding` drives diagnose's four DRIFT
    findings over the placed corpus-view build at `.ok-planner/browser/`,
    which is deliberately generated, gitignored content and never
    committed; vendored-skills' determination rests on the committed,
    version-stamped vendored layer, the collision rule and the consented
    hook entry, none of which this helper touches. The territory is
    audited by decision:built-bundle-fetched-at-pin, which cites the
    helper's call site directly.

- node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807
  class: adjudicated
  audit: decision:vendored-skills
  note: new cases (`claiming_families`, `run_payload_fallback_announcement_case`,
    `run_retired_layout_conflict_case`, `run_retired_layout_migration_case`,
    `skill_fallback_note`, `vendored_skill_file`) sit beside the
    `run_vendored_name_collision_case` / `run_clone_self_containment_case`
    functions vendored-skills already cites in this same file.
  adjudication: promoted — cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807

- node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
  class: adjudicated
  audit: decision:per-project-pinning
  note: new helpers (`estate_manifest`, `prop`, `proposed`, `sandbox`) are
    fixture plumbing inside a file per-project-pinning already cites
    whole for this family's own advisory-fallback and self-containment
    cases.
  adjudication: promoted — cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666

- node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
  class: adjudicated
  audit: decision:two-layer-invalidation
  note: new `add_adjudicated_entry` helper builds inspection-registry
    fixtures for the "re-audit set" / "inspection: mechanical account"
    cases two-layer-invalidation already cites whole in this file.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: adjudicated entries close the floor as residue does""

- node: .claude/skills/release/SKILL.md @ sha256:ac354a0affa8
  class: adjudicated
  audit: decision:lockstep-suite-version
  note: new "5d. Rebuild the committed source graph — do not skip" step
    keeps the committed graph in lockstep with the re-stamp 5c performs,
    inside a file lockstep-suite-version already cites whole.
  adjudication: promoted — cite-node: .claude/skills/release/SKILL.md#release-cut-an-ok-plugins-suite-release.procedure.5d-rebuild-the-committed-source-graph-do-not-skip @ sha256:4c2f502805c4

- node: checks/vendored-layer @ sha256:32ecd23819c3
  class: adjudicated
  audit: decision:vendored-skills
  note: the vendored-layer check is claimed territory of vendored-skills,
    which cites this exact node whole already at its current content.
  adjudication: promoted — cite-node: checks/vendored-layer @ sha256:32ecd23819c3

- node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:db0409f030c9
  class: adjudicated
  audit: story:deterministic-source-graph
  note: the extractor/checker implementation is claimed territory of
    deterministic-source-graph, which cites this exact node whole already
    at its current content.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:db0409f030c9

- node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
  class: adjudicated
  audit: decision:built-bundle-fetched-at-pin
  note: the story-level integration suite is claimed territory of the
    many audits citing this file whole; built-bundle-fetched-at-pin's
    own whole-file citation already matches this content exactly.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc

- node: plugins/ok/families/ok-planner/test/stories.sh#fetch @ sha256:2e266fabcf69
  class: adjudicated
  audit: decision:resolution-through-pinned-checker
  note: the base HTTP-fetch helper directly drives that audit's own
    provenance and cite-node-resolution assertions against the pinned
    checker.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: a cite-node resolves through the committed graph to the declared unit's own lines"

- node: plugins/ok/families/ok-planner/test/stories.sh#fetch.probe @ sha256:f8eed88228f9
  class: adjudicated
  audit: decision:local-web-surface
  note: probe's own comment ("the page half needs the status line and
    the content type ... so the guard cases can be asserted at all")
    names exactly local-web-surface's territory; it drives that audit's
    escaping-path-refused guard case directly.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: a path escaping the bundle is refused, not served"

- node: plugins/ok/families/ok-planner/test/stories.sh#fetch.tree_manifest @ sha256:e0b4b7f8c5e7
  class: adjudicated
  audit: decision:built-bundle-fetched-at-pin
  note: the before/after content-hash manifest is the mechanism behind
    that audit's "nothing is retrieved when a reader opens the page"
    confirmation bullet.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: driving every route leaves the project byte-for-byte as it was — the view is a process, not an artifact"
