# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology plugins. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

The integrable suite, one command — the `ok` plugin declares the integrable
plugins as dependencies, so installing it pulls them all in:

```
/plugin marketplace add <this-repo>
/plugin install ok@ok-plugins
```

Then `/ok` in any project updates the installed plugins, offers to bootstrap
the estates of installed plugins the project doesn't use yet, and drives the
project's merged `true-up` verb — which vendors each integrated plugin's
skills, scripts, and hooks into the project as committed, version-stamped
files (each plugin's true-up is an idempotent installer). A converged
project is self-contained: cloning it yields the working suite with no
plugin installed; the installed plugins are the vendor source you converge
from. À la carte installs still work:

```
/plugin install ok-planner@ok-plugins
/plugin install ok-plumbline@ok-plugins
/plugin install ok-workspaces@ok-plugins
```

The personal conduct is its own user-scoped plugin, deliberately outside the
suite's dependencies — installing the suite never installs it, and `/ok`
never offers it. If you want it, that choice is yours alone:

```
/plugin install ok-conduct@ok-plugins
```

## Plugins

| Plugin | Concern | Scope |
| --- | --- | --- |
| `ok-planner` | What to build — the design corpus (concepts, provable stories and decisions), the issue intake, and the sprint planning ceremony | project (vendored) |
| `ok-plumbline` | How code reads — the Plumbline methodology: comment hygiene, citation resolution, the edit-hook lint | project (vendored) |
| `ok-workspaces` | Where work happens — worktree-per-job, isolated runtime stacks, content-addressed artifacts | project (vendored) |
| `ok` | Suite front door — installs the integrable suite as dependencies; `/ok` updates installed plugins, offers bootstrap, drives the project's merged true-up | user |
| `ok-conduct` | How the assistant delivers — the Fall Guy Consulting code of conduct as an output style, with its per-turn reminder hook | user (personal) |

**User-scoped → plugin system; project-scoped → committed project files.**
The integrable plugins deliver their behavior into each project as vendored
files — skills under `.claude/skills/`, hook implementations inside the
plugin's estate, hook wiring as consented entries in `.claude/settings.json`
— so every project runs exactly the version it was converged to. The two
user-scoped plugins (`ok`, `ok-conduct`) stay machine-global on purpose:
they belong to the user, not to any project.

`ok-plumbline` is the plugin packaging of the Plumbline methodology; the
methodology keeps its name (the lint binary and the
`@plumbline:allow-docstrings` marker are unchanged), so existing Plumbline
projects remain compatible. In a converged project the verbs are the
vendored skills (`/true-up`, `/ok-plumbline-audit`, `/patterns`, …); from
the installed plugin they carry the plugin namespace
(`/ok-plumbline:true-up`, `/ok-plumbline:audit`, …).

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest.
- `plugins/<name>/` — one directory per plugin, each with its own
  `.claude-plugin/plugin.json`, skills, and license. Integrable plugins
  carry no plugin-root hooks: hook implementations are materialized into
  each consumer project's estate and wired through consented settings
  entries; only the user-scoped `ok-conduct` runs hooks from the plugin
  root, deliberately machine-global.
- `docs/integration-contract.md` — the normative contract every integrable
  ok-plugin follows to meet a consumer project: estate, cheatsheet,
  vendored skills and the verb collision rule, consented hook wiring,
  discovery markers. New plugins must conform; the `ok` plugin depends
  on it.
- `checks/` — repo maintenance checks proving suite-wide design decisions
  (activation guards, transclusion token resolution, declared text-presence
  proofs, vendored-layer conformance, hub-row single-sourcing, owned-path
  discipline). Run them all with `bash checks/run`; each check is annotated
  with the decision or concept it enforces. Not part of any distributed
  plugin. Other proof harnesses: `bash plugins/ok-plumbline/test/run.sh`
  (lint fixtures, the budget ratchet, and the edit-hook invocation harness)
  and `bash plugins/ok-workspaces/test/demo.sh` (workspace isolation and
  teardown-gate demo).

This repo dogfoods the vendored mode: its own `.claude/skills/` carries the
vendored ok-planner skill set, and its `.claude/settings.json` carries the
consented session-start hook entry.

## Versioning

**One version for the suite.** Every plugin manifest carries the same
`version` — the `ok-conduct` manifest included — bumped together and tagged
once per release (`vX.Y.Z`) at the highest level any plugin's changes
warrant. The plugins install à la carte, but they are designed as a set:
`ok` declares the integrable ones as dependencies, they share the
integration contract, and a change in one routinely implies a change in
another. A shared number is what makes "which versions work together"
answerable. A plugin with no changes in a release still gets the bump; the
version is Claude Code's update key, so re-fetching identical files costs
nothing.

Releases are cut by the repo-local `/release` skill
(`.claude/skills/release/`), which surveys the whole monorepo, stamps the new
version into every plugin manifest, commits, tags, and pushes. It is
maintenance tooling, not part of any distributed plugin.

The conduct's own version stamp (`Conduct version: X.Y.Z (Animal)` in the
body of `plugins/ok-conduct/output-styles/ok-conduct.md`) is independent and
hand-managed, untouched by a release — a release only warns when the conduct
body changed without a bump.

## License

Apache-2.0, suite-wide. Each plugin carries its own `LICENSE` file.
