---
topic: marketplace-monorepo
kind: concept
---

# The ok-plugins marketplace monorepo

## Description

The repository is itself the distribution mechanism: a Claude Code plugin **marketplace** whose catalog lives at `.claude-plugin/marketplace.json` (marketplace name `ok-plugins`, owner Fall Guy Consulting). Consumers add the repo as a marketplace (`/plugin marketplace add <this-repo>`) and install plugins from it (`/plugin install ok@ok-plugins`). Claude Code resolves the marketplace source to the repository's **default branch** unless the consumer pinned a `ref` — the repo's default branch is currently `develop`, not `main`, and the release skill treats "the release commit is reachable from the remote default branch" as the definition of "installable."

The monorepo carries exactly four plugins under `plugins/<name>/`, each with its own `.claude-plugin/plugin.json` manifest, skills, license, and (where applicable) hooks, scripts, docs, and output styles. The marketplace manifest lists each plugin with a `source` path, display name, description, keywords, and category; it carries **no versions** (versions live only in the per-plugin manifests). The repo README declares the suite's identity: "the public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's project-agnostic development-methodology plugins. Internal-only tooling lives in a separate marketplace; nothing here may assume a specific consumer."

There is a firm repo-root vs in-plugin boundary. Repo-root machinery — the marketplace manifest, `docs/integration-contract.md`, the `/release` skill at `.claude/skills/release/`, the root README — is maintenance and contract material for the suite author, **not** part of any distributed plugin. The release skill states this explicitly: "It is maintenance tooling, not part of any distributed plugin ... Do not add it to any user-facing skill table, and do not copy it into a plugin directory: per-plugin release skills are what this one replaced." Conversely, everything a consumer receives lives inside a `plugins/<name>/` directory.

The repo also dogfoods parts of the suite on itself: `.claude/settings.json` enables all four plugins, `.ok-planner/` exists at the root (materialized at v8.0.0), and `.claude/rules/ok-planner-cheatsheet.md` is present. The other two integrable plugins have no estate here (`.ok-plumbline/` and `.ok-workspaces/` are absent), though ok-plumbline's plugin directory carries its own root-level `.plumbline.json` self-config in the retired pre-migration location.

## Code surface

- `.claude-plugin/marketplace.json` — the catalog (4 plugin entries).
- `plugins/ok/`, `plugins/ok-planner/`, `plugins/ok-plumbline/`, `plugins/ok-workspaces/` — the four plugin directories.
- `.claude/skills/release/SKILL.md` — repo-root release skill (see `suite-versioning`).
- `docs/integration-contract.md` — the normative contract (see `integration-contract`).
- `.claude/settings.json` — `enabledPlugins` for all four plugins.
- `.gitignore` — `.DS_Store`, `*.swp`, `**/.claude/settings.local.json`.

## Prose surface

- `README.md` — install instructions, plugin table, layout, versioning, license (Apache-2.0 suite-wide).
- `.claude/skills/release/SKILL.md` — "A release is not done until it is installable" section documents the default-branch resolution rule and that the default branch is `develop`.
- `plugins/ok-planner/CLAUDE.md` — "This plugin lives at `plugins/ok-planner/` inside the `ok-plugins` marketplace monorepo; the marketplace manifest is at the repo root."
- `plugins/ok-plumbline/README.md` — **disagrees with the repo README**: it still describes ok-plumbline as "its own single-plugin marketplace (the catalog lives at `.claude-plugin/marketplace.json` under the marketplace name `fallguy`)" with install instructions `/plugin marketplace add fallguyconsulting/plumbline` and `/plugin install plumbline@fallguy`, from before the migration into this monorepo.

## Adjacent topics

- `plugin` — what each entry in the catalog is.
- `suite-versioning` — one version across the manifests, cut by `/release`.
- `integration-contract` — the normative doc at `docs/`.
- `ok-dispatcher` — the suite front door installed from this marketplace.

## Observations

- `plugins/ok-plumbline/README.md` install section is stale relative to the monorepo (names a `fallguy` marketplace and `plumbline@fallguy` install), while its skill-invocation examples use the current `/ok-plumbline:*` namespace — the file is half-migrated.
- The marketplace manifest's ok-planner description names only "audit, prove" as corpus verbs; the plugin now also ships certify, sketch, discover-design, plan-sprint, true-up, ok-version.
- The release skill hardcodes a commit trailer "Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>" as "the trailer this environment requires" — an environment-specific literal baked into a skill.
- Git history shows the marketplace was created by migrating in two preexisting plugins (commit c330c4d "Create the ok-plugins marketplace: ok-planner and ok-standards (Plumbline) migrated in").
