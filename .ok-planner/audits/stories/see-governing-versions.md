---
audit: see-governing-versions
artifact: story:see-governing-versions
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:9476f862ea4e
---

# Can a consumer see the version governing this session or project alongside what is installed?

## Confirmation

Satisfied. Three surfaces deliver the governing number and the carried
one side by side, and the governing number always comes from the
project's own materialized copy rather than from anything installed.

- **The session.** The materialized `.ok-planner/hooks/session-start`
  emits a `SessionStart` payload whose banner names the version stamped
  into that hook when the project was converged. `stories.sh` runs the
  real hook in a converged sandbox, asserts the banner names the carried
  version, then rewrites that project's hook to a deliberately behind
  version and asserts the number read back is the project's stamp and
  disagrees with the carried plugin's — the drift is visible as two
  disagreeing numbers.
- **The project, alongside what is installed.** `/ok`'s closing table
  has a row per family with the carried version (the front-door
  manifest, updated in step 1 from `claude plugin list`) beside the
  version the project's stamps record, and states the gap as the useful
  signal rather than an error. `administration.sh` builds exactly those
  cells off the filesystem a real converge leaves behind, for
  `ok-planner` and `ok-workspaces`.
- **The verbs.** `/ok-version` recites the plugin version this session
  is running (from the injected banner line) and the conduct version
  actually governing (from the active output style's `Conduct version:`
  line), reading nothing from disk. `ok-plumbline`'s `/version` prints
  the project's vendored binary version and the carried payload's on
  two lines; its run block is executed end-to-end in a converged clone
  with nothing installed in `run.sh`'s self-containment case.
- **Convergence stays deliberate.** Nothing in these surfaces converges:
  each reports and stops, and the front door only converges when run.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite-node: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md @ sha256:163265bfea1d
- cite-node: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.6-report @ sha256:cc5fb9e89c2f
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.1-update-the-installed-user-scoped-plugins @ sha256:cae6aa7510f2
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite-node: plugins/ok-conduct/hooks/session-start @ sha256:35d02f0b4c9f
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.version-stamps @ sha256:a9a94ec5a856
