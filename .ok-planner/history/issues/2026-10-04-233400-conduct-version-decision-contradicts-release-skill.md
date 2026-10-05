---
issue: conduct-version-decision-contradicts-release-skill
kind: audit
category: design
artifacts:
  - decision:lockstep-suite-version
status: retired
triage: question
opened: 2026-10-04T23:34:00Z
---

# The design corpus says a release never touches the conduct version, and the release skill bumps it every time the conduct changes

The suite ships a personal conduct, an output style whose first body line carries its own version stamp, `Conduct version: X.Y.Z (Animal)`. That number is separate from the suite version every plugin manifest shares. Two of the project's own sources disagree on who sets it.

The design corpus says the author sets it. decision:lockstep-suite-version ends its Choice with "The conduct's version is the one carve-out: hand-managed and untouched by a release, which warns when the conduct's body changed without a bump and does nothing further". Its Rationale adds "A warning keeps the conduct's number its author's to set".

The release skill says the release sets it. `.claude/skills/release/SKILL.md`, step 4, "Bump the conduct version when the conduct body changed", says "the release owns it, exactly as it owns the plugin manifests. Nobody hand-edits the stamp." The step finds the last commit that moved the stamp line. Where the conduct body changed since then and the stamp did not, it advances the minor by one, resets the patch, and moves the animal one letter along a fixed alphabet. It never makes a major bump; it leaves that to the author and respects a stamp that already moved. The skill also lists the conduct stamp among the release-mutable metadata. `plugins/ok-conduct/CLAUDE.md` agrees with the skill: the stamp is "owned by the repo-root /release skill ... Never hand-edit it".

## How the two came apart

The carve-out sentence entered the decision at release v9.0.0. Release v18.5.1 (2026-08-15) changed the release skill to own the stamp. The decision was edited twice after that, once on 2026-08-21 and once by sprint 2026-10-04-consolidate-into-ok-planner, and both edits kept the carve-out. Every release since v18.5.1 has bumped the stamp mechanically. The discovery notes under `design/_discover/` still describe the older warn-only behavior.

The release skill is project-local tooling. It carries no suite stamp and ships in no plugin, so changing it is the project's own call. The decision is a live corpus commitment. One of the two must change. Sprint certification run converge-2026-10-04T060800 could fix neither, because sprint agents may edit neither a corpus artifact nor a skill under `.claude/`.

A reader who trusts the corpus expects `/release` to leave the conduct stamp alone and only warn. `/release` rewrites it. No accept-list entry covers the gap. concept:conduct says nothing about who sets the number.

## Options

1. Amend decision:lockstep-suite-version to say a release bumps the conduct stamp when the conduct body changed and the stamp did not move, and that the author lands a conduct-major with the change. This matches the release skill, `plugins/ok-conduct/CLAUDE.md`, and every release since v18.5.1. Cost: the Choice's list of release-mutable metadata, "the manifest version fields and the stamps a re-converge rewrites", must also name the conduct stamp, and the Rationale's warning sentence goes.
2. Change release step 4 to warn on a changed conduct body under an unchanged stamp and leave the stamp alone, and change `plugins/ok-conduct/CLAUDE.md` to match. Cost: the author must remember to bump by hand, which is the burden the v18.5.1 change removed.

The ruling decides whether a release or the conduct's author advances the conduct's minor version.

## Ruling

Retired by the owner on 2026-10-04: fixed by hand with option 1. decision:lockstep-suite-version now names the conduct's version stamp among the release-mutable metadata and says the release advances the conduct's minor version and animal where the body changed and the stamp did not move, leaves a stamp that already moved as it is, and leaves a conduct major to its author. The Rationale's warning sentences are replaced, and the warn-only path is recorded as a rejected alternative. The release skill and plugins/ok-conduct/CLAUDE.md stay as they are.
