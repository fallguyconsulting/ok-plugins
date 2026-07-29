---
audit: one-command-suite-upkeep
artifact: story:one-command-suite-upkeep
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:48a8a47e5807
---

# Is the project's whole suite presence brought current in one consolidated act?

## Confirmation

Satisfied. `/ok` is a single skill that is the entire administration
process — update the installed user-scoped plugins, discover integrated
families by filesystem marker, ask once whether to bootstrap the rest,
administer each family in one pass, present all hook wiring together for
consent, close with a per-family table — and it holds no family
knowledge: every family-specific act is delegated to the family's two
conventional surfaces.

- The uniformity that makes "no per-family knowledge" true is
  mechanically enforced: `checks/vendored-layer` enumerates the carried
  families from `plugins/ok/families/` and fails unless each exposes an
  executable `admin/converge` and an `admin/ADMINISTRATION.md`; it runs
  in the ordinary suite via `checks/run`.
- The consolidated act's effects on disk are exercised end-to-end in
  `plugins/ok/test/administration.sh` against a project carrying one
  integrated family and two carried-but-unintegrated ones: marker
  discovery splits them (integrated is exactly `ok-planner`, candidates
  exactly `ok-plumbline ok-workspaces`), the consented candidate is
  administered in the same pass (its estate and cheatsheet
  materialized), the declined one is left with nothing on disk, the
  closing table's cells are read back off the filesystem with carried
  and project-stamped versions agreeing, and the personal conduct is
  never vendored.
- The act is one command with no per-family branch: the skill resolves
  every path against `<payload>/<family>` and drives `admin/converge`
  plus `admin/ADMINISTRATION.md` only.

## Referrals

- referral: the one consent question, the recorded decline, and the closing per-family table read as one consolidated act to the owner
  clause: "brought current in one consolidated act, so that suite upkeep requires no per-family knowledge from me"
  delivered: the dialogue is prompt-realized in the `/ok` skill's steps 3, 5 and 6 — one bootstrap question naming the candidates, declines recorded as `not integrated (declined)`, and the carried/vendored/outcome table — with the run's disk effects asserted in `administration.sh`
  discipline: ux

## Citations

- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.1-update-the-installed-user-scoped-plugins @ sha256:cae6aa7510f2
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.3-offer-to-bootstrap-the-rest @ sha256:dff13c1afdb4
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.4-administer-each-family-one-pass @ sha256:df8c63c2063c
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.5-wire-the-hooks-by-consented-transcription-only-once @ sha256:bddbd80fe3fd
- cite-node: plugins/ok/skills/ok/SKILL.md#ok-suite-front-door.process.6-report @ sha256:cc5fb9e89c2f
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-administration-surfaces @ sha256:bdc1c5438957
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-front-door @ sha256:2c99591a32b3
- cite-node: checks/vendored-layer @ sha256:32ecd23819c3
- cite-node: checks/run @ sha256:e827e4abcc44
- cite-node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
