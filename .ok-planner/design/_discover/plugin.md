---
topic: plugin
kind: concept
---

# Plugin (the unit of distribution)

## Description

A **plugin** is the unit this repo ships: a directory under `plugins/` containing a `.claude-plugin/plugin.json` manifest (name, description, version, author, license, optionally dependencies), a `skills/` tree of SKILL.md prompt files, and optionally `hooks/`, `scripts/`, `docs/`, `output-styles/`, a CLAUDE.md for contributors, and a LICENSE. There is no application runtime anywhere in the suite: "the deliverable is markdown `SKILL.md` files, the plugin manifest, an output style (`ok-conduct`), and bash hooks. There is no build and no test runner" (ok-planner CLAUDE.md); ok-workspaces says the same modulo "scripts are plain node (checked with `node --check`) and bash"; ok-plumbline is the one plugin with a real executable (the `bin/plumbline` Node lint binary) and a bash test suite (`test/run.sh` over fixtures).

Each plugin owns one concern, and the README table states the division: **ok-planner** — *what to build* (the design corpus: concepts, provable stories and decisions; the issue queue; the sprint planning ceremony). **ok-plumbline** — *how code reads* (the Plumbline methodology: comment hygiene, DRY, idiom lint). **ok-workspaces** — *where work happens* (worktree-per-job, isolated runtime stacks, content-addressed artifacts). **ok** — the *suite front door* (installs the others as manifest dependencies; `/ok` updates, bootstraps by consent, and drives each plugin's true-up).

`ok` is the only plugin with a `dependencies` field (`["ok-planner", "ok-plumbline", "ok-workspaces"]`), which is what makes `install ok@ok-plugins` pull the whole suite; the plugins otherwise install à la carte. `ok` is also deliberately the smallest: "this plugin is a single SKILL.md plus its dependency manifest by design. Resist adding machinery" (ok CLAUDE.md). `ok` is never "integrated" into a project — it has no dot-directory and materializes nothing.

Three of the four plugins are "integrable": they materialize a project-side estate and conform to the integration contract (dot-directory, cheatsheet, verbs). Per-plugin CLAUDE.md files exist for ok, ok-planner, and ok-workspaces (contributor guidance: purpose, layout, constraints); ok-plumbline has a README plus four docs instead and no CLAUDE.md.

## Code surface

- `plugins/*/.claude-plugin/plugin.json` — four manifests, all at version 8.0.0.
- `plugins/ok/CLAUDE.md`, `plugins/ok-planner/CLAUDE.md`, `plugins/ok-workspaces/CLAUDE.md` — contributor guidance with Constraints sections.
- `plugins/ok-plumbline/README.md`, `plugins/ok-plumbline/docs/*.md` — plumbline's prose surface (no CLAUDE.md).
- `plugins/ok-plumbline/bin/plumbline`, `plugins/ok-plumbline/test/run.sh` — the one binary and one test suite in the suite.

## Prose surface

- `README.md` "Plugins" table — the concern-per-plugin division.
- `docs/integration-contract.md` — what an integrable plugin must provide; "The ok plugin" section for the front door's special (non-integrated) status.

## Adjacent topics

- `marketplace-monorepo`, `integration-contract`, `ok-dispatcher`, `suite-versioning`, `skill`.

## Observations

- The suite's plugins are asymmetric in contributor-doc convention: three have CLAUDE.md, plumbline has README+docs. Plumbline is also the only plugin with automated tests.
- ok-planner CLAUDE.md's constraint "No Node tooling; skills are markdown, hooks are bash" sits beside `plugins/ok-planner/scripts/surface-corpus`, which is a Python 3 script — not Node, but also neither markdown nor bash; the constraint's letter and the tree disagree.
- ok-planner CLAUDE.md's Layout block is stale in two spots: it describes `hooks/session-start` as "Injects skills/ok-planner/SKILL.md as context" (that behavior now lives in the materialized `scripts/hooks/session-start`; the plugin-root file is a shim), and it lists neither `scripts/surface-corpus` nor `scripts/hooks/`.
