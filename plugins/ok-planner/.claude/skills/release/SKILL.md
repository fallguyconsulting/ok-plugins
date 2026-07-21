---
name: release
description: "ONLY activated by the explicit /release slash command. Never auto-triggered by conversation content. Project-local maintenance skill for releasing THIS repo (the ok-planner plugin): determine the semver bump from changes since the last tag, bump the plugin version in .claude-plugin/plugin.json, commit, tag, and push."
---

# /release — cut an ok-planner plugin release

Releases **this repository** (the ok-planner plugin). It inspects what changed since the last git tag, decides a semver bump, applies it to the `version` field in `.claude-plugin/plugin.json`, commits the pending work as a release commit, tags it `vX.Y.Z`, and pushes the branch and the tag to `origin`.

This is a repo-maintenance tool for the plugin author. It is **not** part of the distributed plugin (that is why it lives in `.claude/skills/`, not `skills/`). Do not add it to the session-start skill table in `skills/ok-planner/SKILL.md`.

This skill commits and pushes. The user invoking `/release` **is** the authorization to do so — run end to end without pausing for confirmation. Only stop on a genuine preflight failure (below). Do not generate release notes.

## Preflight — abort with a clear message if any fail

- Inside a git repo, on a branch (not detached HEAD): `git rev-parse --abbrev-ref HEAD` must not be `HEAD`.
- An `origin` remote exists: `git remote get-url origin`.
- `.claude-plugin/plugin.json` exists and has a `"version"` field.

If a check fails, report exactly what is missing and stop. Do not try to repair the repo.

## Procedure

### 1. Find the baseline and survey the changes

```bash
last_tag=$(git describe --tags --abbrev=0 2>/dev/null)
echo "last_tag: ${last_tag:-<none>}"
git status --short
```

- **A tag exists** → the changes being released are `git log --oneline "$last_tag"..HEAD` and `git diff "$last_tag"..HEAD`, plus any uncommitted changes (`git diff HEAD`, and untracked files from `git status --short`). Read enough of the diff to judge the bump.
- **No tag exists (first release)** → there is no baseline to diff against. Assume everything already committed represents the current `version`, and the changes being released are the uncommitted ones (`git diff HEAD` + untracked). Read those.

**Nothing to release:**
- No tag **and** a clean working tree → nothing has changed since the current version was set. Create and push a baseline tag at the current version (`v<current>`), report that you established the baseline, and stop. No bump, no commit.
- A tag exists, `"$last_tag"..HEAD` is empty, **and** the tree is clean → report "nothing to release since `$last_tag`" and stop.

### 2. Read the current version

Read the `version` field from `.claude-plugin/plugin.json` (e.g. `2.0.0`). Tags are this string prefixed with `v` (e.g. `v2.0.0`); the `version` field itself carries no `v`.

### 3. Decide the bump

Judge **major / minor / patch** from what the change set does to the plugin's surface. This repo ships markdown skill prompts, an output style, manifests, and a bash hook — so "surface" means the set of slash commands, the output style, and the behavior consumers depend on.

| Level | Bump | When |
|-------|------|------|
| **major** (`X`) | breaking | A skill or slash command is removed or renamed; the output style is removed; a skill's contract changes incompatibly; any change that breaks how an existing install is invoked or behaves. |
| **minor** (`Y`) | feature | A new skill / command / output style is added, or a new backward-compatible capability within an existing skill. |
| **patch** (`Z`) | fix | Everything else: bug fixes and prose tightening in skill prompts, doc / `CLAUDE.md` edits, hook fixes, internal refactors that leave the command surface unchanged. |

Print the chosen level and a one-line rationale citing what in the change set drove it. If the change set spans more than one level, the highest level wins. If it is genuinely ambiguous between two levels, choose the **higher** and say so. Compute the new version from the current one.

### 4. Conduct-version sanity check (warn, do not abort)

If `output-styles/ok-conduct.md` is among the changed files **but** its `Conduct version:` body line is unchanged versus the baseline, print a prominent warning: the conduct body changed without a conduct-version bump, which `CLAUDE.md` requires (advance the semver and the animal codename when the conduct body changes). Surface it and continue — this skill manages the **plugin** version only and never edits the conduct version.

### 5. Apply the bump

Edit the `version` field in `.claude-plugin/plugin.json` to the new version. Use the Edit tool for a precise single-line change so the file's formatting is preserved. Do not touch any other field.

### 6. Commit

```bash
git add -A
```

Then commit. Message body is `Release vX.Y.Z`. End the commit message with the trailer this environment requires:

```
Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>
```

### 7. Tag

Annotated tag on the release commit:

```bash
git tag -a "vX.Y.Z" -m "Release vX.Y.Z"
```

### 8. Push

Push the current branch and the new tag to `origin`:

```bash
git push origin "$(git rev-parse --abbrev-ref HEAD)"
git push origin "vX.Y.Z"
```

### 9. Report

Print: previous version → new version, the bump level and its one-line rationale, the files in the release commit, the commit SHA, the tag name, and confirmation that branch and tag were pushed. Include the conduct warning from step 4 if it fired.

## Notes

- This skill never reads or writes `.ok-planner/`.
- It bumps only the plugin `version`. The conduct version in `output-styles/ok-conduct.md` is managed by hand when the conduct body changes.
- The first release (no prior tag) cannot precisely separate "already released" from "new" commits, so it treats committed history as the current version and the uncommitted tree as the new release. Every release after the first diffs cleanly against the previous tag.
