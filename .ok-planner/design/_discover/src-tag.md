---
topic: src-tag
kind: concept
---

# src-tag: content-addressed artifact tags

## Description

`src-tag` is the canonical script realizing workspace rule 3: it "prints a content-addressed tag for the current working tree (including uncommitted changes): `src-<first 12 hex of a git tree-object hash>`. Same tree -> same tag, on every machine." Implementation: copy the real index to a temp file, `GIT_INDEX_FILE="$tmp" git add -A`, `git write-tree` against the temp index, print `src-%.12s` of the tree SHA — the working tree is hashed without touching the real index or requiring a commit. Tests and harnesses "resolve artifacts by that tag and fail loudly when it is missing. Never `:latest` or any mutable tag in a verification path — staleness must be unrepresentable, not avoided" (cheatsheet).

Hard constraints (plugin CLAUDE.md): "`scripts/src-tag` must stay POSIX sh with no dependencies beyond git — it runs in build and CI environments where node may be absent, and it must stay byte-identical in derivation across all consumers (same tree → same `src-<12 hex>` everywhere). **Never change its derivation without a major version bump.**" The byte-identity requirement is enforced by diagnose.js comparing the materialized copy against the version-substituted canonical.

Materialization: true-up writes it to the profile's `srcTag.path` (default `.ok-workspaces/bin/src-tag`), executable, version-stamped — the path is profile-configurable precisely so "existing consumers keep working (e.g. pointing ok-workspaces' `srcTag.path` at a script already wired into the project's build)" (contract). Wiring it into builds/harnesses is deliberately the project's own change ("guided by the cheatsheet"), never true-up's; the audit's check 4 then flags a materialized script nothing consumes ("means rule 3 of the cheatsheet is decorative").

## Code surface

- `plugins/ok-workspaces/scripts/src-tag` (17 lines POSIX sh).
- `plugins/ok-workspaces/scripts/true-up.js` (materialization + chmod 755), `scripts/diagnose.js` (byte-identity check), `skills/audit/SKILL.md` check 4 (consumption grep for the path or the `src-` tag shape).

## Prose surface

- `plugins/ok-workspaces/CLAUDE.md` Constraints (the POSIX/derivation invariants); the cheatsheet's rule 3 text; index skill "The estate" ("Byte-identical across every consumer so cooperating tools always agree on the tag").

## Adjacent topics

- `workspace-discipline`, `script-materialization`, `version-stamping`, `stack-profile` (srcTag.path), `suite-versioning` (the major-bump trigger).

## Observations

- src-tag's tree derivation (`git add -A` into a temp index + `write-tree`) is the same mechanism the retired flip-gated engine used for its S0 snapshots and that ok-conduct recommends for checkpointing (`git add -A`) — one git idiom recurring across three generations of the suite's designs.
- The version stamp inside the script sits in a comment; the byte-identity check therefore makes the *stamp itself* part of the compared bytes — materializations from different plugin versions are automatically "divergent" even if the derivation lines are identical, which is exactly the drift signal diagnose wants.
