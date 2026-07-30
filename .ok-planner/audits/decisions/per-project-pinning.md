---
audit: per-project-pinning
artifact: decision:per-project-pinning
determination: satisfied
audited: 2026-07-30T00:31:21Z
artifact-hash: sha256:87246400739a
---

# Does every project run the stamped copies it was converged to, with payload execution confined to administration and announced advisory fallbacks?

## Confirmation

Satisfied. Pinning, the fixed-content exception, the downstream preference
and the announced advisory fallback are each exercised by tests in the
project's suites; the one clause with no program behind it is recorded as a
referral below.

- **Stamped, and executed from the project's copy.** Enumerated from the
  planner converge's own diagnose pass — the estate guide, the cheatsheet,
  `surface-corpus`, `bin/audit-check`, `bin/source-graph`, `bin/corpus-view`,
  `bin/browse`, the estate `.gitignore`, the session hook, the view build (a
  directory, stamped by a digest file beside it) and the vendored skill
  layer — every one is compared against the version-stamped rendering rather
  than merely for presence. `administration.sh` asserts the estate stamp
  directly, asserts `bin/browse` is materialized executable and carries this
  suite version's stamp, then requires diagnose clean on the converged estate
  and requires converge to repair a hand-drifted suite-owned file; it also
  drives the build's four stamp findings and requires converge to clear each.
  `demo.sh` converges a real sandbox repository, takes a git-blob manifest of
  every materialized file, rewrites the cheatsheet's stamp to `v0.0.1`
  alongside three other hand edits, requires the family's diagnose to name each
  drifted artifact, and requires converge to restore the manifest byte for
  byte. `stories.sh` runs a materialized hook for real and shows a project
  deliberately left behind reporting its own number rather than the carried
  one — the front door moving on changes nothing in the project until it
  converges.
- **The fixed-content exception.** `.ok-plumbline/package.json` carries no
  version; the plumbline harness converges, drifts it to a variant that still
  parses to `commonjs`, requires diagnose to report it differing "from its
  canonical content", and requires converge to restore the canonical bytes.
- **Downstream prefers the project copy.** A converged clone runs
  `ok-plumbline`'s vendored verbs with `CLAUDE_PLUGIN_ROOT` unset and fails if
  any reaches for the payload. A project carrying its own `.ok-planner/bin/`
  copies stamped with a version the payload cannot be carrying serves the
  corpus view out of those copies and reports them, by path, as the resolver —
  and `browse up`, run for real in that same project, resolves the
  `corpus-view` beside itself (`sibling_view`, never a search path) and relays
  that pinned version's announcement, which is how the assertion tells the
  estate copy from the carried one. `browse` has no payload fallback at all: a
  missing sibling is a hard error naming `/ok` as the fix.
- **The announced fallback.** With the pinned binary removed, the plumbline
  harness executes each of that family's seven read-only advisory verbs
  (`audit`, `budget`, `explain`, `patterns`, `port`, `starter`, `suggest`)
  through the verb's own `## Run` block against the carried payload, and
  requires three things per verb: the note literal declared in that skill's own
  block starts with `note: no vendored binary`, the verb produces its real
  output, and that exact note line appears in the output. `stories.sh` asserts
  the corpus view's own two fallback notes (`audit-check`, `source-graph`)
  verbatim in a project carrying neither. Enumerated from the three families'
  own `skills/` trees, that is every advisory surface in the suite that
  declares a payload fallback except `ok-planner`'s `audit`;
  `ok-plumbline`'s `version` verb declares no fallback, reporting both copies
  unconditionally instead, and `ok-workspaces`' verbs declare none.
- **Only administration and advisory reads run from the payload.** The
  administration surfaces (`admin/converge`, the administration document) are
  what the front door drives before the project copies exist; every other
  payload execution in the suite is one of the advisory verbs above.

## Referrals

- referral: `ok-planner`'s `/audit` verb announcing, before its findings,
  that it is reading the payload's checker rather than a pinned one.
  clause: "an advisory verb falling back to the payload copy announces
  the fallback in its output"
  delivered: the verb carries no program — the fallback and the verbatim
  note are instructions inside the dispatch prompt its Process section
  hands to a subagent, present in form and quoted exactly.
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:541131a0bdf2
- cite: plugins/ok/families/ok-planner/admin/converge :: "[ -f "$BROWSE" ] && check_rendered "$BROWSE" "${OK_DIR}/bin/browse" ".ok-planner/bin/browse""
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:d1eeb56156a6
- cite-node: plugins/ok/families/ok-planner/scripts/browse @ sha256:bcccb3435f43
- cite: plugins/ok/families/ok-planner/scripts/browse :: "def sibling_view():"
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "     Run the vendored checker — `.ok-planner/bin/audit-check`. If the" +6 sha256:752f7869841f
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_payload_fallback_announcement_case @ sha256:32db1a67c051
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_module_marker_fidelity_case @ sha256:9322d9d15982
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_clone_self_containment_case @ sha256:5f472a2d5f08
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: browse up starts the estate's own view on a free port and the server answers on the recorded port"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "local-web-surface: browse up relays the view's own version announcement"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: an advisory verb reading the payload's copy announces the fallback verbatim"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: the service names the project's own materialized checker as the resolver"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "see-governing-versions: the governing number is read from what this project was converged to"
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite: plugins/ok/test/administration.sh :: "estate guide stamped with the suite version (front-door manifest)"
- cite: plugins/ok/test/administration.sh :: "converge materializes the browse helper at .ok-planner/bin/browse, executable"
- cite: plugins/ok/test/administration.sh :: "the browse helper is stamped with the suite version converge derives"
- cite: plugins/ok/test/administration.sh :: "diagnose clean on the converged estate"
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.support-scripts @ sha256:5965473786a9
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.version-stamps @ sha256:a9a94ec5a856
