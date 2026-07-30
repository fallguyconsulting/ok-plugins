---
inspection-registry: v1
inspected: 2026-07-30T00:41:10Z
---

# Inspection registry

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

- node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:db0409f030c9
  class: adjudicated
  audit: story:deterministic-source-graph
  note: the extractor/checker implementation is claimed territory of
    deterministic-source-graph, which cites this exact node whole already
    at its current content.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:db0409f030c9

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

- node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43
  class: adjudicated
  audit: decision:local-web-surface
  note: lapsed and re-judged — a later fix cycle added the `reused_or_gone`
    helper and malformed-run-record handling (the "malformed run record
    removed" branches in `up()` and `down()`) to the same up/down lifecycle
    this audit's "Started and closed by the owner" bullet already claims
    wholesale for this file.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43

- node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43
  class: adjudicated
  audit: decision:per-project-pinning
  note: lapsed and re-judged — `sibling_view()` (already cited) is untouched
    by the fix cycle; the new `reused_or_gone` helper and malformed-record
    handling in `up()`/`down()` sit inside the same file this audit already
    claims whole for the estate-copy resolution behavior.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/scripts/browse :: "def sibling_view():"

- node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43
  class: adjudicated
  audit: story:trace-corpus-to-code
  note: lapsed and re-judged — the fix cycle's `reused_or_gone` helper and
    malformed-record handling live inside `up()`/`down()`, the same two
    functions this story's audit already cites as "a way to reach it."
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43

- node: checks/vendored-layer @ sha256:3c48f248e796
  class: adjudicated
  audit: decision:vendored-skills
  note: the `PINNED` tuple dropped `.claude/skills/browse` (the retired
    skill; its lifecycle now lives in the estate's own `bin/browse`
    script) — inside the same enumeration vendored-skills already cites
    whole in this file.
  adjudication: promoted — cite-node: checks/vendored-layer @ sha256:3c48f248e796

- node: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md @ sha256:d66a8e7f0cbe
  class: adjudicated
  audit: decision:whole-file-ownership
  note: the converge-materializes list and the "does not write outside the
    owned set" list both gained `bin/browse` alongside the other pinned
    scripts — inside the file whole-file-ownership already cites whole
    (covers the `#ok-planner-administration`, `.the-core-s-modes` and
    `.what-the-administration-does-not-do-here` sections by containment).
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md @ sha256:d66a8e7f0cbe

- node: plugins/ok/families/ok-planner/admin/converge @ sha256:541131a0bdf2
  class: adjudicated
  audit: decision:whole-file-ownership
  note: diagnose/materialize gained the `BROWSE` stamp check and
    placement, `SKILLS`/`UNPREFIXED` dropped the retired `browse` skill
    entry, and `RETIRED_VENDORED` now removes the stale vendored `browse`
    copy — inside the file (and `#vendor_layer`, covered by containment)
    whole-file-ownership already cites whole and by node.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:541131a0bdf2

- node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:d1eeb56156a6
  class: adjudicated
  audit: decision:local-web-surface
  note: '`corpus_now`''s docstring was reworded from "`/browse` leaves it
    running" to "the browse script leaves it running until its `down`" —
    inside the file local-web-surface already cites whole for the
    long-lived-process claim.'
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:d1eeb56156a6

- node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:1957abde8932
  class: adjudicated
  audit: decision:local-web-surface
  note: gained the `run/` ignore entry for the browse script's pid/port
    record — inside the file local-web-surface already cites whole for
    the "process, not a committed artifact" claim.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:1957abde8932

- node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
  class: adjudicated
  audit: decision:per-project-pinning
  note: re-judged at the fix cycle's content — the "browse helper" test
    section (converge materializes `bin/browse` executable and stamped,
    and the estate's `.gitignore` covers `run/`) is the exact lines
    per-project-pinning already cites by quote in this file, and the
    cycle's rewrite of the vendored-set completeness check in the same
    file is separately cited by vendored-skills.
  adjudication: promoted — cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50

- node: plugins/ok/families/ok-planner/CLAUDE.md#claude-md @ sha256:23d2e8818506
  class: adjudicated
  audit: decision:no-execution-engine
  note: the family-purpose paragraph's skill/script enumeration changed
    (browse is no longer a listed skill; the corpus view is now
    "started and stopped by the estate's own bin/browse script, not by
    a skill") — this decision is realized in prose and already cites
    this same file's sibling Layout section on the identical
    enumeration; no citation reaches the family-purpose section or the
    file's own top-level node directly.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/CLAUDE.md#claude-md.family-purpose @ sha256:adaf6e896721

- node: README.md#ok-plugins @ sha256:67e07b84eb36
  class: adjudicated
  audit: decision:built-bundle-fetched-at-pin
  note: the top-level node's hash moves only because its cited child
    section ("verification-audits-over-ordinary-tests") changed wording
    from "/browse starts" to ".ok-planner/bin/browse up starts"; same
    text, no citation reaches the containing top-level identity itself.
  adjudication: dismissed — every changed byte lies inside the child
    section this audit already cites by its own narrower identity
    (README.md#ok-plugins.verification-audits-over-ordinary-tests, re-pinned
    at sha256:7c9e43db4ebf); the containing top-level node adds no evidence
    the audit does not already pin, and citing it would tie the audit to
    every unrelated edit anywhere in the README.

- node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md#ok-planner-the-planner-s-directory @ sha256:7e9d42f77e43
  class: residue
  note: the estate guide template gained a paragraph documenting
    `.ok-planner/bin/browse up`/`down`; this is internal onboarding
    prose no audit cites as evidence — the mechanism it describes is
    separately covered by the new `scripts/browse` node and the
    existing local-web-surface/per-project-pinning code citations.

- node: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md#the-verbs @ sha256:1b6f70ef68ed
  class: adjudicated
  audit: decision:slash-only-activation
  note: the router table dropped its `/browse` row (the verb retired to
    the estate's own `bin/browse` script) — inside the same file
    slash-only-activation already cites whole as one member of its
    twenty-three-skill activation-guard population; no other audit's
    territory reaches this table.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md @ sha256:2e5c077dfc8f

- node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
  class: adjudicated
  audit: decision:per-project-pinning
  note: the header comment's "resolution-through-pinned-checker /
    per-project-pinning" paragraph was reworded to narrate the estate's
    own browse script being run for real (sibling `up`/gitignored run
    state/reuse/`down`/tolerated stale records) in place of the old
    unpinned-advisory-block description — top-level prose inside the
    file per-project-pinning already cites whole, restating that
    audit's own sibling-resolution claim rather than any new one.
  adjudication: promoted — cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e

- node: plugins/ok/families/ok-planner/test/stories.sh#fetch @ sha256:e12b163b1a7e
  class: adjudicated
  audit: decision:local-web-surface
  note: the rewritten browse test section (replacing the old
    per-project-pinning advisory-block case with the full estate
    `bin/browse up`/`down` lifecycle — reuse, stale/wedged/recycled-pid
    and malformed-record handling) sits inside this heading-bounded
    node, whose new assertion strings are already the exact quotes
    local-web-surface cites in this same file.
  adjudication: promoted — cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: browse down stops the recorded process and removes the run record"
