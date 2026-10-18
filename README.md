# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology tooling. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

The marketplace distributes three user-scoped plugins. The `ok` plugin is
the suite's front door and sole administrator. It carries one skill family,
ok-planner, as payload:

```
/plugin marketplace add <this-repo>
/plugin install ok@ok-plugins
```

Then `/ok` in any project is the whole administration process: install,
true up, repair. It updates the installed plugins, discovers whether the
project carries ok-planner (a filesystem check against committed markers,
including the markers of the retired ok-plumbline and ok-workspaces families),
offers to bootstrap it in one consent question, and trues it up from the
carried payload: it vendors the family's skills, agent profiles, scripts,
hooks, and rules files into the project as committed, version-stamped files.
A project an earlier release trued up is brought to the current layout in
the same run, and everything its owner wrote is kept, in place or in the
archive under `.ok-planner/history/`. Where the run would delete a file,
move one into the archive, or rewrite a file a person edited, `/ok` shows
the whole plan first and asks once: go ahead with all of it, or abort,
which writes nothing and leaves the project on its version. A trued-up project is self-contained:
cloning it yields the working suite with nothing installed; the installed
front door is only needed to true up to a newer version.

The personal conduct is a user-scoped plugin outside the suite's
administration. Installing the front door never installs it, and `/ok`
never offers it. If you want it, that choice is yours alone:

```
/plugin install ok-conduct@ok-plugins
```

The web-setup plugin is the third. It sets up a project's agent-facing web
tooling: `/setup-web` sets up the browser MCP server, and
`/setup-dom-picker` sets up a dev-only DOM picker in the project's
frontends:

```
/plugin install ok-web@ok-plugins
```

## The vendored family

The suite's unit of project-scoped distribution is the **skill family**: a
self-contained directory of skills, agent profiles, templates, support
scripts, and administration surfaces, carried whole inside the front-door
plugin at `plugins/ok/families/` and delivered into consumer projects by
vendoring. The suite carries one family, `ok-planner`. It is not a plugin: it
is not separately installable, and consumers meet it only through its
vendored presence in their project.

| Plugin | Concern | Scope |
| --- | --- | --- |
| `ok` | Suite front door and sole administrator: carries ok-planner as payload; `/ok` is install, true up, and repair in one process | user |
| `ok-conduct` | How the assistant delivers: the Fall Guy Consulting code of conduct as an output style, with its per-turn reminder hook | user (personal) |
| `ok-web` | Web-project setup: the browser MCP server and the dev-only DOM picker | user (personal) |

ok-planner covers what to build and how the code holds up:

- **The design corpus**: concepts, stories, and decisions under
  `.ok-planner/design/`, the project's durable model.
- **The coding standards**: the Plumbline lint (comment hygiene, citation
  resolution, no tests, each switchable per project) with its edit hook, the
  coding rules and cheatsheet, the events and technical-writing standards,
  and the project's own subjects and practices.
- **The issue intake and the sprint loop**: the intake at
  `.ok-planner/issues.jsonl`, one record per open issue with its
  discussion, read and written only through `.ok-planner/bin/issues`
  and worked on a local dashboard page that `/dashboard` starts;
  `/plan-sprint`, `/converge`, `/triage-issues`, `/sketch`.
- **Documentation kept current by documentation sprints**: one docspec
  per kind of documentation the project keeps, under
  `.ok-planner/docspec/`, the surface intent at
  `.ok-planner/surface/surface.md`, and `/plan-docs`, which plans the
  run that writes and checks the documentation.
- **Per-run verification stacks**: the stack tool runs each
  verification run from start to end. `stack up` mints the run's tag,
  leases its host ports from the project's range, and starts the stack
  the project declares; `stack down` takes the run down and removes
  what it made; `stack cleanup` takes down stale runs.

**User-scoped → plugin system; project-scoped → committed project files.**
The family delivers its behavior into each project as vendored files: skills
under `.claude/skills/`, agent profiles under `.claude/agents/`, rules files
under `.claude/rules/`, hook implementations inside the estate, and hook
wiring as consented entries in `.claude/settings.json`. Every project runs
exactly the version it was trued up to. The plugins stay machine-global on
purpose: they belong to the user, not to any project.

## Planning and review: ok-planner's sprint loop

`/plan-sprint` is ok-planner's planning session. It
produces an approved sprint: corpus deltas, work items, implementation notes
from a code-planning phase, and a fixed completion contract. Execution cuts
the sprint into stages and drains them as build tasks on the task tracker.
Sprint certification (`/converge sprint <path>`) closes the sprint: it reviews the change for
completion and regression, runs the project's checks, drives every
story, and fixes what it finds. On the owner's cadence, `/converge`
in `drive`, `analysis`, or `defects` mode finds and fixes defects across the
product, and `/triage-issues` verifies the issue intake and answers the
owner's comments on its issues.

## Documentation: docspecs and documentation sprints

The owner declares each kind of documentation the project keeps in one
**docspec** at `.ok-planner/docspec/<slug>.md`: where the documentation
lives (a file, a folder and how its files are laid out, or the source
files whose doc comments are the documentation), whom it is for, what
it covers, the corpus artifacts and code paths it describes (its
references), for reference documentation the classes of public surface
it lists in full, and the shape of one file, copied from a template.
A docspec carries the order, never the text, and changes only through
a sprint's approved delta. `catalog-toc` writes an index of every
docspec's location and references beside them.

Only a documentation sprint writes documentation. On the owner's
schedule, usually before a release, `/plan-docs` finds each docspec
whose references, listed classes, or documentation changed since its
stamp, and plans one item per file to write, change, or drop, each
with the rules that fire on it. The owner approves each docspec's
first worked example and the plan once. The documentation sprint then
runs unattended under `/goal`: separate agents write each file, a cold
style pass reads each changed file once, and a fact loop checks every
claim against the tree, running examples where it can, until every
claim holds or is cut. A claim ledger and a stamp per docspec let the
next run check again only what changed. Sprints write no
documentation, and planning flags documentation a person edited
directly for the owner to decide.

The **surface intent** at `.ok-planner/surface/surface.md` is one prose
document of class rules with named exceptions: which classes of
element are public, and for each class of entry point the files that
declare its members. Nothing is public until the owner declares it,
through a sprint, and every public class has a reference docspec. No
stored list of surface members exists. A documentation sprint writing
and checking reference documentation, and `/converge`'s analysis mode
cutting its flow areas, each list the members from the declaring files
as the tree stands.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest (three
  entries: `ok-conduct`, `ok`, `ok-web`).
- `plugins/ok/` — the front door: one skill (`/ok`) plus the carried family
  at `plugins/ok/families/ok-planner/`. The family exposes the integration
  contract's two conventional administration surfaces: a deterministic
  true-up core at `admin/true-up` and an administration document at
  `admin/ADMINISTRATION.md`. The family carries no manifest and no
  family-root hooks: hook implementations are materialized into each
  consumer project's estate and wired through consented settings entries.
- `plugins/ok-conduct/` — the personal conduct plugin; it runs hooks from the
  plugin root, deliberately machine-global.
- `plugins/ok-web/` — the web-setup plugin and its two skills.
- `docs/integration-contract.md` — the normative contract the vendored family
  follows to meet a consumer project: the layers, the administration
  surfaces, consented hook wiring, discovery markers. The front door depends
  on it.
- `checks/` — repo maintenance checks for suite-wide structural conformance
  (transclusion token resolution, vendored-layer and administration-surface
  conformance, owned-path discipline, standalone materialized files,
  section-churn detection). Every check verifies structure or behavior;
  none asserts the presence of static text. Run them all with
  `bash checks/run`; each check is annotated with the decision or concept it
  enforces. Not part of any distributed plugin.

This repo dogfoods the vendored mode: its own `.claude/skills/` carries the
vendored ok-planner skill set, and its `.claude/settings.json` carries the
consented hook entries.

## Versioning

**One version for the suite.** Every plugin manifest carries the same
`version`, bumped together and tagged once per release (`vX.Y.Z`) at the
highest level any change warrants — and a change anywhere under the front
door's carried payload is a suite change: the family ships inside the `ok`
plugin, whose version is Claude Code's update key. Every stamp the family
machinery writes into a consumer project derives from the front-door
manifest, so "which versions work together" is always answerable.

Releases are cut by the repo-local `/release` skill
(`.claude/skills/release/`), which surveys the whole monorepo, stamps the new
version into every plugin manifest, commits, tags, and pushes. It is
maintenance tooling, not part of any distributed plugin.

The conduct's own version stamp (`Conduct version: X.Y.Z (Animal)` in the
body of `plugins/ok-conduct/output-styles/ok-conduct.md`) is independent of
the suite version. A release advances its minor version and its animal when
the conduct's body changed and the stamp did not move; a conduct major is its
author's to land with the change.

## License

Apache-2.0, suite-wide. Each plugin and the family carry their own `LICENSE`
file.
