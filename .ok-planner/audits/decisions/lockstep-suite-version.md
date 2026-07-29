---
audit: lockstep-suite-version
artifact: decision:lockstep-suite-version
determination: satisfied
audited: 2026-07-29T18:40:00Z
artifact-hash: sha256:c26653630fb0
---

# Do all plugin manifests carry one suite version, stamped through the payload, released mechanically under one tag?

## Confirmation

Satisfied.

- **One version across every manifest.** The repo carries exactly two
  plugin manifests — `plugins/ok` and `plugins/ok-conduct`, the families
  carrying none — and both read `"version": "12.0.0"`. The release act
  writes the new number into every `plugins/*/.claude-plugin/plugin.json`
  and, before committing or tagging, runs a verbatim loop that prints
  `MIXED VERSION` and exits non-zero unless all of them equal the new
  version.
- **Stamped through the payload wherever it materializes.** Each family's
  converge derives its stamp from the front-door manifest and from
  nothing else: the planner's core resolves
  `admin/../../../.claude-plugin/plugin.json`, `ok-plumbline`'s does the
  same and its `pluginVersion()` reads that manifest for the vendored
  renderings, and `ok-workspaces`' `converge.js` parses it directly.
  Exercised end to end: `administration.sh` reads the suite version out
  of the front-door manifest and requires the planner's estate guide and
  the workspaces cheatsheet to carry exactly it; the plumbline harness
  requires a freshly converged estate to diagnose clean, and that
  diagnosis compares every vendored skill against the rendering built
  from `pluginVersion()`.
- **Mechanical, with deterministic assertions only.** The release changes
  the two `version` fields, the stamps its step 5c re-converge rewrites,
  and the committed source graph its step 5d rebuilds wholesale over
  those re-stamped bytes — each a deterministic consequence of the
  version change, none a judgment, and it dispatches no auditor. The
  property that makes this safe is exercised: the planner's checker masks
  release-mutable metadata before hashing, so a fixture whose every stamp
  and manifest version sits two releases ahead of the audit citing it
  passes clean, while an edit beside a stamp — in a hook banner, in a
  script header, or under a non-manifest pin — still trips
  `audit-stale-citation`; the same holds for graph-node pins, whose
  recorded hashes the extractor masks byte-compatibly with the checker,
  so a version-only rebuild moves no cited node hash.
- **One annotated repo-wide tag per release, done only when reachable.**
  Every tag in the repo is an annotated tag object, one per release, and
  `v12.0.0` is present at the current manifest version. The release
  finishes only after confirming at the remote that the tag exists there
  and the default branch contains the tagged commit.
- **The carve-outs hold.** Mid-cycle manifest drift is resolved by taking
  the highest and converging them, and the conduct's own body stamp
  (`Conduct version: 1.11.0 (Koala)`) is hand-managed — the release only
  warns when the conduct body changed without a bump.

## Citations

- cite-node: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-node: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
- cite-node: plugins/ok-conduct/output-styles/ok-conduct.md @ sha256:af9d74cdcba7
- cite-file: .claude/skills/release/SKILL.md @ sha256:ac354a0affa8
- cite-node: .claude/skills/release/SKILL.md#release-cut-an-ok-plugins-suite-release.procedure.5d-rebuild-the-committed-source-graph-do-not-skip @ sha256:4c2f502805c4
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:7200bf002ec9
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node stamp bump masked""
