# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology plugins. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

```
/plugin marketplace add <this-repo>
/plugin install ok-planner@ok-plugins
/plugin install ok-standards@ok-plugins
```

## Plugins

| Plugin | Concern | Status |
| --- | --- | --- |
| `ok-planner` | What to build — specs, plans, design corpus, review skills | here |
| `ok-standards` | How code reads — the Plumbline methodology: comment hygiene, DRY, idiom lint | here |
| `ok-workspaces` | Where work happens — worktree-per-job, isolated runtime stacks, content-addressed artifacts | planned |
| `ok-doctor` | Suite upkeep — discovers integrated ok-plugins in a project and drives their affirm/doctor verbs | planned |

`ok-standards` is the plugin packaging of the Plumbline methodology; the
methodology keeps its name (the lint binary, the `@plumbline:allow-docstrings`
marker, and `.plumbline.json` are unchanged), so existing Plumbline-affirmed
projects remain compatible. Skill invocations use the plugin namespace:
`/ok-standards:affirm`, `/ok-standards:audit`, etc.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest.
- `plugins/<name>/` — one directory per plugin, each with its own
  `.claude-plugin/plugin.json`, skills, and license.
- `docs/integration-contract.md` — the normative contract every ok-plugin
  follows to integrate into a consumer project. New plugins must conform;
  `ok-doctor` depends on it.

## Licenses

Per-plugin: `ok-planner` is MIT; `ok-standards` is Apache-2.0. See each
plugin's `LICENSE` file.
