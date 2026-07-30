---
audit: filesystem-discovery-markers
artifact: decision:filesystem-discovery-markers
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:72b9c42f6459
---

# Is family integration answered solely by filesystem markers at the git-resolved root, with absence a meaningful state?

## Confirmation

Satisfied.

- **The rule and its markers live in the contract**, which documents one
  current marker per carried family (`.ok-planner/`, `.ok-plumbline/`,
  `.ok-workspaces/` at the repo root) and the pre-migration markers
  honored so an un-migrated project is still discovered and offered
  migration (a root `.plumbline.json`, or
  `.claude/rules/plumbline-cheatsheet.md`). The front door's step 2
  states integration as a filesystem check and never an inference, names
  the contract as the authority on markers, and repeats the currently
  documented pre-migration markers.
- **The root is the nearest git ancestor.** Each converge core resolves
  it by walking up for a `.git` entry and falling back to `$PWD`.
- **Discovery by marker alone is exercised.** In `administration.sh` a
  fresh project has no `.ok-planner/` and is therefore a bootstrap
  candidate; after one family's core runs, a loop over the three carried
  families splits them by directory existence into exactly `ok-planner`
  integrated and exactly `ok-plumbline ok-workspaces` as candidates, and
  the declined family is asserted to have nothing on disk — absence
  recorded as a decline, not an error.
- **Hooks decide the same way.** The planner's session hook exists only
  inside the estate and is reached only through the settings entry the
  estate's converge proposes; `stories.sh` asserts that an unintegrated
  project has neither the hook nor the wiring, so nothing is injected.
  `ok-plumbline`'s edit hook resolves the project root the same way and
  exits silently when the estate's binary is absent; `ok-workspaces`
  declares no hooks.

## Citations

- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.discovery-markers @ sha256:31922be73840
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-layers @ sha256:3a4fac20616c
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.2-discover @ sha256:fbbba2064470
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.3-offer-to-bootstrap-the-rest @ sha256:dff13c1afdb4
- cite-node: plugins/ok/families/ok-planner/admin/converge#resolve_root @ sha256:5558ae1af080
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-node: plugins/ok/families/ok-workspaces/admin/converge @ sha256:dce6458e6225
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
