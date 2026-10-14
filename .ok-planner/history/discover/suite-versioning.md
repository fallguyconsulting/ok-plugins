---
topic: suite-versioning
kind: choice
---

# One suite version, cut by the repo-root /release skill

## Description

The suite makes a deliberate versioning choice: **every plugin manifest carries the same semver, bumped together, tagged once per release** (`vX.Y.Z`), at the highest level any plugin's changes warrant. The rationale is stated identically in the README and the release skill: the plugins install à la carte but are designed as a set (`ok` declares the others as dependencies, they share the integration contract, "a change in one routinely implies a change in another"), and "a shared number is what makes 'which versions work together' answerable. ... The alternative (four drifting numbers) makes 'which versions work together' a question nobody can answer." A plugin with no changes still gets the bump because "the version is Claude Code's update key, so re-fetching identical files costs nothing." All four manifests currently read 8.0.0; tags v5.0.0 through v8.0.0 exist.

Releases are cut by the repo-local `/release` skill (`.claude/skills/release/SKILL.md`) — maintenance tooling, not distributed. Its notable choices: the working tree **is** the release ("staged, unstaged, and untracked changes all go in ... Do not curate the commit ... Do not stop to ask"; invoking `/release` is the authorization to commit and push); bump level judged from the suite's *surface* (slash commands, project-side estate shape, integration contract, consumer-visible behavior) with a major/minor/patch table specific to a prompt-file product; "the highest level across all plugins wins"; when manifests disagree, the current version is the **highest** ("never pick a lower one ... lowering it strands existing installs"); one annotated repo-wide tag, never per-plugin tags ("a per-plugin scheme would give `git describe` an ambiguous answer"); the finish line is remote verification that the release commit is on the origin default branch and the tag points at it ("a pushed tag on an unreachable commit is not a release"); the default branch is read from the remote, never assumed (`git ls-remote --symref origin HEAD`).

A second, independent version number is explicitly carved out: the ok-conduct **conduct version** is "hand-managed, untouched by a release"; `/release` step 4 only *warns* if the conduct body changed without a conduct-version bump. Contributor rules: "Do not hand-edit it, and do not bump ok-planner alone" (ok-planner CLAUDE.md).

## Code surface

- `.claude/skills/release/SKILL.md` — the full procedure (preflight, survey, bump decision table, stamp, commit, land on default branch, tag, push, remote verification, report).
- `plugins/*/.claude-plugin/plugin.json` — the four stamped `version` fields.
- Git tags `v5.0.0`–`v8.0.0`; release commits in history.

## Prose surface

- `README.md` "Versioning" section; `plugins/ok-planner/CLAUDE.md` "Versioning and releases" (plugin version = suite version; the true-up script stamps it into consumer estates).

## Adjacent topics

- `marketplace-monorepo`, `version-stamping`, `ok-conduct` (the independent conduct version), `version-echo-verbs`.

## Observations

- The release skill's bump-table anchors ("a directory renamed, an artifact kind retired, a config relocated" = major) encode the suite's actual history (specs→backlogs→sprints, pre-4.0 kinds, `.plumbline.json` relocation) as the definition of breaking change.
- "Do not generate release notes" is an explicit negative choice.
- The skill still documents the first-release-after-unification case ("will jump the lower-numbered plugins forward to meet the highest") which has already happened; harmless but vestigial.
- The trailer line in step 6 hardcodes a specific model name; the repo's own environment reports a different one.
