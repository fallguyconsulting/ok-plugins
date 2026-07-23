# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology plugins. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

The whole suite, one command — the `ok` plugin declares the others as
dependencies, so installing it pulls them all in:

```
/plugin marketplace add <this-repo>
/plugin install ok@ok-plugins
```

Then `/ok` in any project updates the installed plugins, trues up every
integrated estate, and offers to bootstrap the estates of installed
plugins the project doesn't use yet (each plugin's true-up is an
idempotent installer). À la carte installs still work:

```
/plugin install ok-planner@ok-plugins
/plugin install ok-plumbline@ok-plugins
/plugin install ok-workspaces@ok-plugins
```

## Plugins

| Plugin | Concern | Status |
| --- | --- | --- |
| `ok-planner` | What to build — the design corpus (concepts, provable stories and decisions), the issue queue, and the sprint planning ceremony | here |
| `ok-plumbline` | How code reads — the Plumbline methodology: comment hygiene, DRY, idiom lint | here |
| `ok-workspaces` | Where work happens — worktree-per-job, isolated runtime stacks, content-addressed artifacts | here |
| `ok` | Suite front door — installs the suite as dependencies; `/ok` updates installed plugins, offers to bootstrap unintegrated ones, and drives each plugin's true-up verb | here |

`ok-plumbline` is the plugin packaging of the Plumbline methodology; the
methodology keeps its name (the lint binary, the `@plumbline:allow-docstrings`
marker, and `.plumbline.json` are unchanged), so existing Plumbline
projects remain compatible. Skill invocations use the plugin namespace:
`/ok-plumbline:true-up`, `/ok-plumbline:audit`, etc.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest.
- `plugins/<name>/` — one directory per plugin, each with its own
  `.claude-plugin/plugin.json`, skills, and license.
- `docs/integration-contract.md` — the normative contract every ok-plugin
  follows to integrate into a consumer project. New plugins must conform;
  the `ok` plugin depends on it.

## Versioning

**One version for the suite.** Every plugin manifest carries the same
`version`, bumped together and tagged once per release (`vX.Y.Z`) — at the
highest level any plugin's changes warrant. The plugins install à la carte,
but they are designed as a set: `ok` declares the others as dependencies,
they share the integration contract, and a change in one routinely implies a
change in another. A shared number is what makes "which versions work
together" answerable. A plugin with no changes in a release still gets the
bump; the version is Claude Code's update key, so re-fetching identical
files costs nothing.

Releases are cut by the repo-local `/release` skill
(`.claude/skills/release/`), which surveys the whole monorepo, stamps the new
version into every plugin manifest, commits, tags, and pushes. It is
maintenance tooling, not part of any distributed plugin.

The `ok-conduct` output style shipped by `ok-planner` keeps its own
independent conduct version, hand-managed, untouched by a release.

## License

Apache-2.0, suite-wide. Each plugin carries its own `LICENSE` file.
