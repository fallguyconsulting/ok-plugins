---
name: release
description: "ONLY activated by the explicit /release slash command. Never auto-triggered by conversation content. Project-local maintenance skill for releasing the ok-plugins monorepo: survey every plugin's changes since the last tag, pick one suite-wide semver bump, stamp it into every plugin manifest, commit, tag, and push."
---

# /release — cut an ok-plugins suite release

Releases **the whole monorepo, as one suite, at one version**. It surveys what changed across every plugin since the last tag, decides a single semver bump from the union of those changes, writes that version into *every* `plugins/*/.claude-plugin/plugin.json`, commits the pending work as a release commit, tags it `vX.Y.Z`, and pushes the branch and the tag to `origin`.

**One version for the suite.** The plugins are installable à la carte, but they are designed and released as a set: `ok` declares the others as dependencies, they share the integration contract, and a change in one routinely implies a change in another. So they carry the same number, always. A plugin with no changes in a given release still gets the bump — the version is Claude Code's update key, and a consumer re-fetching identical files costs nothing. The alternative (four drifting numbers) makes "which versions work together" a question nobody can answer.

This is a repo-maintenance tool for the suite author. It is **not** part of any distributed plugin — that is why it lives in the repo-root `.claude/skills/`, not in a plugin's `skills/`. Do not add it to any user-facing skill table, and do not copy it into a plugin directory: per-plugin release skills are what this one replaced.

This skill commits and pushes. The user invoking `/release` **is** the authorization to do so — run end to end without pausing for confirmation. Only stop on a genuine preflight failure (below). Do not generate release notes.

## Preflight — abort with a clear message if any fail

- Inside a git repo, on a branch (not detached HEAD): `git rev-parse --abbrev-ref HEAD` must not be `HEAD`.
- An `origin` remote exists: `git remote get-url origin`.
- The marketplace manifest `.claude-plugin/marketplace.json` exists at the repo root.
- Every plugin directory listed in that manifest has a `.claude-plugin/plugin.json` carrying a `"version"` field.

If a check fails, report exactly what is missing and stop. Do not try to repair the repo.

## Procedure

### 1. Find the baseline and survey the changes

```bash
last_tag=$(git describe --tags --abbrev=0 2>/dev/null)
echo "last_tag: ${last_tag:-<none>}"
git status --short
for f in plugins/*/.claude-plugin/plugin.json; do
    printf '%-16s %s\n' "$(basename "$(dirname "$(dirname "$f")")")" "$(grep '"version"' "$f")"
done
```

- **A tag exists** → the change set is `git log --oneline "$last_tag"..HEAD` and `git diff "$last_tag"..HEAD`, plus everything uncommitted (`git diff HEAD`, and untracked files from `git status --short`).
- **No tag exists (first release)** → there is no baseline to diff against. Assume committed history represents the current version and the change set is the uncommitted tree (`git diff HEAD` + untracked).

Read enough of the diff to judge the bump, and attribute it per plugin — the report names which plugins changed. Changes outside `plugins/` (the marketplace manifest, `docs/`, README) are part of the release too; judge them the same way.

**Nothing to release:** a tag exists, `"$last_tag"..HEAD` is empty, and the tree is clean → report "nothing to release since `$last_tag`" and stop. With no tag and a clean tree, create and push a baseline tag at the current suite version, report it, and stop — no bump, no commit.

### 2. Read the current suite version

Read `"version"` from every `plugins/*/.claude-plugin/plugin.json`.

- **Normally they all match** — that is the current suite version.
- **If they differ** (a repo mid-unification, or a hand-edited manifest), the current suite version is the **highest** of them. Say so in the report. Never pick a lower one: a plugin's version is Claude Code's update key, and lowering it strands existing installs on the old files.

Tags are this string prefixed with `v` (e.g. `v5.0.0`); the `version` fields carry no `v`.

### 3. Decide the bump

Judge **major / minor / patch** from what the change set does to the suite's surface. These plugins ship markdown skill prompts, output styles, manifests, hooks, and support scripts materialized into consumer projects — so "surface" means the slash commands, the project-side estate (`.ok-*/` layout, cheatsheets, materialized scripts), the integration contract, and the behavior consumers depend on.

| Level | Bump | When |
|-------|------|------|
| **major** (`X`) | breaking | Any plugin removes or renames a skill or slash command; a project-side estate changes shape so existing consumers need a migration (a directory renamed, an artifact kind retired, a config relocated); the integration contract changes incompatibly; a plugin leaves the marketplace. |
| **minor** (`Y`) | feature | A new plugin, skill, command, or output style; a new backward-compatible capability inside an existing skill; a new optional field in a declared config. |
| **patch** (`Z`) | fix | Everything else: prompt tightening, doc and `CLAUDE.md` edits, hook and script fixes, internal refactors that leave every command surface and estate layout unchanged. |

The **highest level across all plugins wins** — that is the point of suite versioning. If it is genuinely ambiguous between two levels, choose the higher and say so. Print the chosen level and a one-line rationale citing the specific change that drove it, plus which plugin it came from.

### 4. Conduct-version sanity check (warn, do not abort)

If `plugins/ok-planner/output-styles/ok-conduct.md` is among the changed files **but** its `Conduct version:` body line is unchanged versus the baseline, print a prominent warning: the conduct body changed without a conduct-version bump, which `plugins/ok-planner/CLAUDE.md` requires (advance the semver and the animal codename when the conduct body changes). Surface it and continue — this skill manages the **suite** version only and never edits the conduct version.

### 5. Apply the bump

Edit the `version` field in **every** `plugins/*/.claude-plugin/plugin.json` to the new version — including plugins with no changes in this release. Use the Edit tool per file for a precise single-line change so formatting is preserved. Touch no other field. The marketplace manifest carries no versions and is not edited here.

### 6. Commit

```bash
git add -A
```

The release commit is the whole tree — this skill does not curate which work is in it. Then commit with body `Release vX.Y.Z`, ending with the trailer this environment requires:

```
Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>
```

### 7. Tag

Annotated, repo-wide, on the release commit:

```bash
git tag -a "vX.Y.Z" -m "Release vX.Y.Z"
```

One tag for the suite. Do not create per-plugin tags — the tag is the baseline the next release diffs against, and a per-plugin scheme would give `git describe` an ambiguous answer.

### 8. Push

Push the current branch and the new tag to `origin`:

```bash
git push origin "$(git rev-parse --abbrev-ref HEAD)"
git push origin "vX.Y.Z"
```

### 9. Report

Print: previous suite version → new version, the bump level and its one-line rationale, which plugins changed (and which were bumped without changes), the file count in the release commit, the commit SHA, the tag name, and confirmation that branch and tag were pushed. Include the conduct warning from step 4 if it fired.

## Notes

- This skill never reads or writes `.ok-planner/`, `.ok-plumbline/`, or any other consumer-side estate.
- It bumps only plugin `version` fields. The conduct version in `ok-conduct.md` is hand-managed when the conduct body changes.
- À la carte installation still works exactly as before — a shared version number is not a bundle requirement, just a coordinated one.
- The first release after unification will jump the lower-numbered plugins forward to meet the highest. That is expected and safe: versions only ever move up.
