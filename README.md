# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology plugins. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

```
/plugin marketplace add <this-repo>
/plugin install ok-planner@ok-plugins
/plugin install ok-plumbline@ok-plugins
/plugin install ok-workspaces@ok-plugins
/plugin install ok-doctor@ok-plugins
```

## Plugins

| Plugin | Concern | Status |
| --- | --- | --- |
| `ok-planner` | What to build — the design corpus (concepts, provable stories and decisions), the issue queue, and the sprint planning ceremony | here |
| `ok-plumbline` | How code reads — the Plumbline methodology: comment hygiene, DRY, idiom lint | here |
| `ok-workspaces` | Where work happens — worktree-per-job, isolated runtime stacks, content-addressed artifacts | here |
| `ok-doctor` | Suite upkeep — discovers integrated ok-plugins in a project and drives their affirm/doctor verbs | here |

`ok-plumbline` is the plugin packaging of the Plumbline methodology; the
methodology keeps its name (the lint binary, the `@plumbline:allow-docstrings`
marker, and `.plumbline.json` are unchanged), so existing Plumbline-affirmed
projects remain compatible. Skill invocations use the plugin namespace:
`/ok-plumbline:affirm`, `/ok-plumbline:audit`, etc.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest.
- `plugins/<name>/` — one directory per plugin, each with its own
  `.claude-plugin/plugin.json`, skills, and license.
- `docs/integration-contract.md` — the normative contract every ok-plugin
  follows to integrate into a consumer project. New plugins must conform;
  `ok-doctor` depends on it.

## Licenses

Per-plugin: `ok-planner` is MIT; `ok-plumbline` is Apache-2.0. See each
plugin's `LICENSE` file.
