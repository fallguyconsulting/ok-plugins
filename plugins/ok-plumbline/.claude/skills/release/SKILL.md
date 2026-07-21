---
name: release
description: "ONLY activated by the explicit /release slash command. Never auto-triggered by conversation content. Project-local maintenance skill for releasing THIS repo (the plumbline plugin): determine the semver bump from changes since the last tag, bump the plugin version in .claude-plugin/plugin.json, commit, tag, and push."
---

# /release — cut a plumbline plugin release

Releases **this repository** (the plumbline plugin). It inspects what changed since the last git tag, decides a semver bump, applies it to the `version` field in `.claude-plugin/plugin.json`, commits the pending work as a release commit, tags it `vX.Y.Z`, and pushes the branch and the tag to `origin`.

This is a repo-maintenance tool for the plugin author. It is **not** part of the distributed plugin (that is why it lives in `.claude/skills/`, not `skills/`). Do not add it to any user-facing skill table.

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

Read the `version` field from `.claude-plugin/plugin.json` (e.g. `0.5.1`). Tags are this string prefixed with `v` (e.g. `v0.5.1`); the `version` field itself carries no `v`.

### 3. Decide the bump

Judge **major / minor / patch** from what the change set does to the plugin's surface. The surface is what consumers depend on:

- The `plumbline` CLI binary and its subcommands (lint, patterns, budget, suggest, slug, starter, doctor, explain, ci) — names, flags, exit codes, output shape.
- The PostToolUse hook (`hooks/post-edit.js`) — its stdin/stdout contract with Claude Code.
- The slash commands under `skills/` — names and behavior.
- The `.plumbline.json` schema — field names, types, accepted values.
- The lint rules themselves (comment-hygiene exemptions, citation-resolution semantics) — what previously-clean code now fails on.
- The canonical cheatsheet (`docs/plumbline-cheatsheet.md`) materialized into consuming projects by `/ok-plumbline:affirm`.

| Level | Bump | When |
|-------|------|------|
| **major** (`X`) | breaking | A CLI subcommand or slash command is removed or renamed; the lint's exit-code contract changes; the post-edit hook's stdin/stdout contract changes; `.plumbline.json` schema changes incompatibly (field removed, renamed, or repurposed); the comment-hygiene rule changes such that previously-clean projects begin failing (e.g. an exemption removed or narrowed). |
| **minor** (`Y`) | feature | A new CLI subcommand or slash command; a new lint check; a new structural exemption or citation-resolution mode; a new `.plumbline.json` field whose default preserves prior behavior; any backward-compatible capability added to an existing subcommand or skill. |
| **patch** (`Z`) | fix | Bug fixes in the lint, hook, or skills; prose tightening in docs and the cheatsheet that doesn't shift what the lint enforces; internal refactors that leave the published surface unchanged. |

Print the chosen level and a one-line rationale citing what in the change set drove it. If the change set spans more than one level, the highest level wins. If it is genuinely ambiguous between two levels, choose the **higher** and say so. Compute the new version from the current one.

### 4. Cheatsheet-drift note (informational, do not abort)

If `docs/plumbline-cheatsheet.md` is among the changed files, mention in the final report that consuming projects will need to re-run `/ok-plumbline:affirm` to pick up the new cheatsheet. This is informational only — never blocks the release.

### 5. Apply the bump

The version string is duplicated in two places — both must move together so `/ok-plumbline:version` keeps reporting the truth:

1. The `version` field in `.claude-plugin/plugin.json` (the plugin manifest, source of truth).
2. The `VERSION` constant in `bin/plumbline` (what `plumbline version` echoes; near the top of the file as `const VERSION = '...';`).

Edit both with the Edit tool — single-line, precise changes that preserve formatting. Do not touch any other field or constant. After the edits, run `node bin/plumbline version` and confirm it prints the new version; if it doesn't, fix the `VERSION` constant before continuing. Any future location that hardcodes the version also belongs in this step — grep for the previous version string to catch drift (`git grep -n "<prev>"`).

### 6. Commit

```bash
git add -A
```

Then commit. Message body is `Release vX.Y.Z`. End the commit message with the trailer this environment requires, naming the current model — e.g.:

```
Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
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

Print: previous version → new version, the bump level and its one-line rationale, the files in the release commit, the commit SHA, the tag name, and confirmation that branch and tag were pushed. Include the cheatsheet-drift note from step 4 if it fired.

## Notes

- This skill bumps only the plugin `version` in `.claude-plugin/plugin.json`. It does not touch `.claude-plugin/marketplace.json` (which carries plugin metadata, not version) or any other manifest.
- The first release (no prior tag) cannot precisely separate "already released" from "new" commits, so it treats committed history as the current version and the uncommitted tree as the new release. Every release after the first diffs cleanly against the previous tag.
- Prior commits referenced versions in their messages (e.g. `fix(v0.5.1): ...`) without tags being created. The first `/release` invocation will therefore land in the "no tag exists" branch — that is expected, and the baseline-or-bump logic in step 1 handles it.
