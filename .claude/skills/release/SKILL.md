---
name: release
description: "ONLY activated by the explicit /release slash command. Never auto-triggered by conversation content. Project-local maintenance skill for releasing the ok-plugins monorepo: survey every plugin's changes since the last tag, pick one suite-wide semver bump, stamp it into every plugin manifest, commit, tag, and push."
---

# /release — cut an ok-plugins suite release

Releases **the whole monorepo, as one suite, at one version**. It surveys what changed across every plugin since the last tag, decides a single semver bump from the union of those changes, writes that version into *every* `plugins/*/.claude-plugin/plugin.json`, commits the pending work as a release commit, tags it `vX.Y.Z`, and pushes the branch and the tag to `origin`.

**One version for the suite.** The plugins are installable à la carte, but they are designed and released as a set: `ok` declares the others as dependencies, they share the integration contract, and a change in one routinely implies a change in another. So they carry the same number, always. A plugin with no changes in a given release still gets the bump — the version is Claude Code's update key, and a consumer re-fetching identical files costs nothing. The alternative (four drifting numbers) makes "which versions work together" a question nobody can answer.

This is a repo-maintenance tool for the suite author. It is **not** part of any distributed plugin — that is why it lives in the repo-root `.claude/skills/`, not in a plugin's `skills/`. Do not add it to any user-facing skill table, and do not copy it into a plugin directory: per-plugin release skills are what this one replaced.

## What "release" means here

**Release the repo as it stands right now, capturing and committing everything in it.** The working tree *is* the release: staged, unstaged, and untracked changes all go in, whoever made them and whenever. That is the intended semantics, not a compromise — the author cuts a release when the repo is where they want it, so uncommitted work is finished work that simply has not been committed yet.

Concretely, this means:

- **Do not curate the commit.** No cherry-picking paths, no "this looks unrelated", no splitting into multiple commits. One release commit, whole tree, `git add -A`.
- **Do not treat uncommitted work as suspect.** A dirty tree is the normal starting state for this skill, not a warning sign. Do not describe it as in-flight, unfinished, or unreviewed, and do not hedge the report with caveats about work you did not personally write.
- **Do not stop to ask** whether some subset should be excluded. If the author wanted less in the release, they would not have run `/release`.
- **Do report what went in** — the file count and which plugins were touched — so the author can see the shape of what they just shipped. Reporting is not the same as second-guessing.

The one thing worth surfacing is a genuine defect found along the way (a broken manifest, a failing test suite the repo ships, a conflict marker). Fix nothing silently; say what you found and continue.

This skill commits and pushes. The user invoking `/release` **is** the authorization to do so — run end to end without pausing for confirmation. Only stop on a genuine preflight failure (below). Do not generate release notes.

## A release is not done until it is installable

The point of a release is that consumers can get it. Claude Code resolves a marketplace source to the repository's **default branch** unless the consumer pinned a `ref` — `ref` is documented as "Git branch or tag (defaults to repository default branch)", and `/plugin marketplace update` follows the same rule. A release commit sitting on a non-default branch is invisible to everyone who added the marketplace normally, however correctly it was versioned and tagged.

So the finish line is: **the release commit is on the default branch at `origin`, the tag points at it, and both are pushed.** Step 8 lands it there and step 8b verifies it. Never report a release as done without that verification passing.

Determine the default branch from the remote itself — never assume `main`:

```bash
default_branch=$(git ls-remote --symref origin HEAD | awk '/^ref:/ {sub("refs/heads/","",$2); print $2}')
```

## Preflight — abort with a clear message if any fail

- Inside a git repo, on a branch (not detached HEAD): `git rev-parse --abbrev-ref HEAD` must not be `HEAD`.
- An `origin` remote exists: `git remote get-url origin`.
- The remote reports a default branch (the command above yields a non-empty name).
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

If `plugins/ok-conduct/output-styles/ok-conduct.md` is among the changed files **but** its `Conduct version:` body line is unchanged versus the baseline, print a prominent warning: the conduct body changed without a conduct-version bump, which `plugins/ok-conduct/CLAUDE.md` requires (advance the semver and the animal codename when the conduct body changes). Surface it and continue — this skill manages the **suite** version only and never edits the conduct version.

### 5. Apply the bump

Edit the `version` field in **every** `plugins/*/.claude-plugin/plugin.json` to the new version — including plugins with no changes in this release. Use the Edit tool per file for a precise single-line change so formatting is preserved. Touch no other field. The marketplace manifest carries no versions and is not edited here.

### 5b. Assert the manifests agree — do not skip

Equality at release time is the property consumers depend on. Before committing or tagging, run this verbatim (with `X.Y.Z` replaced by the new version) and stop on any failure — never tag a mixed set:

```bash
# @decision: lockstep-suite-version
new="X.Y.Z"
mismatch=0
for f in plugins/*/.claude-plugin/plugin.json; do
  v=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$f" | head -1)
  if [ "$v" != "$new" ]; then
    echo "MIXED VERSION: $f carries ${v:-<none>}, expected $new"
    mismatch=1
  fi
done
[ "$mismatch" -eq 0 ] && echo "all manifests at v$new" || exit 1
```

### 6. Commit

```bash
git add -A
```

The release commit is the whole tree, per "What 'release' means here" above — everything staged, unstaged, and untracked, in one commit. Then commit with body `Release vX.Y.Z`, ending with the trailer this environment requires:

```
Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>
```

### 7. Land the release commit on the default branch

The tag must point at a commit that is on the default branch, so do this **before** tagging.

- **Already on the default branch** (the normal case) — nothing to do; the release commit is where it belongs.
- **On another branch** — integrate it:

  ```bash
  git checkout "$default_branch"
  git merge --ff-only -           # the release branch; fast-forward when possible
  ```

  If the fast-forward is refused because the default branch has commits of its own, make an ordinary merge commit instead (`git merge <release-branch>`) — that merge commit is then the release commit for tagging purposes. On a merge conflict, **stop**: report the conflicting paths and leave the repo for the author. Never force, never rebase published history.

### 8. Tag

Annotated, repo-wide, on the commit that is now the tip of the default branch:

```bash
git tag -a "vX.Y.Z" -m "Release vX.Y.Z"
```

One tag for the suite. Do not create per-plugin tags — the tag is the baseline the next release diffs against, and a per-plugin scheme would give `git describe` an ambiguous answer.

### 9. Push

Push the default branch and the new tag to `origin`:

```bash
git push origin "$default_branch"
git push origin "vX.Y.Z"
```

If the release was cut on another branch, push that branch too so it isn't left behind the release.

### 9b. Verify it is installable — do not skip

Confirm at the remote, not locally, that a fresh consumer would get this version:

```bash
git ls-remote --symref origin HEAD | head -1                    # default branch, as the remote reports it
git ls-remote origin "refs/heads/$default_branch" "refs/tags/vX.Y.Z"
git branch -r --contains "vX.Y.Z" | grep "origin/$default_branch"
```

All three must agree: the tag exists at `origin`, the default branch at `origin` is at (or ahead of, containing) the tagged commit, and the manifests at that commit carry the new version. If any check fails, say so plainly in the report — a pushed tag on an unreachable commit is not a release.

### 10. Report

Print: previous suite version → new version, the bump level and its one-line rationale, which plugins changed (and which were bumped without changes), the file count in the release commit, the commit SHA, the tag name, the default branch the release landed on, and the result of the step 9b verification — stated as the plain fact that the new version is now installable. Include the conduct warning from step 4 if it fired.

## Notes

- This skill never reads or writes `.ok-planner/`, `.ok-plumbline/`, or any other consumer-side estate.
- It bumps only plugin `version` fields. The conduct version in `ok-conduct.md` is hand-managed when the conduct body changes.
- À la carte installation still works exactly as before — a shared version number is not a bundle requirement, just a coordinated one.
- The first release after unification will jump the lower-numbered plugins forward to meet the highest. That is expected and safe: versions only ever move up.
- This repo's default branch is whatever `origin` reports — currently `develop`, not `main`. Read it, don't assume it, and don't "helpfully" merge into a branch the remote doesn't treat as default.
- Consumers who pinned a `ref` (`/plugin marketplace add owner/repo@v5.0.0`, or a `ref` in their settings) stay on that pin and are unaffected by a new release until they change it. That is their choice, not a problem to solve here.
