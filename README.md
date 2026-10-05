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
converge, repair. It updates the installed plugins, discovers whether the
project carries ok-planner (a filesystem check against committed markers,
including the markers of the retired ok-plumbline and ok-workspaces families),
offers to bootstrap it in one consent question, and converges it from the
carried payload: it vendors the family's skills, agent profiles, scripts,
hooks, and rules files into the project as committed, version-stamped files.
A project an earlier release converged is migrated in the same run, and
everything its owner wrote is kept. A converged project is self-contained:
cloning it yields the working suite with nothing installed; the installed
front door is only needed to converge to a newer version.

The personal conduct is a user-scoped plugin outside the suite's
administration. Installing the front door never installs it, and `/ok`
never offers it. If you want it, that choice is yours alone:

```
/plugin install ok-conduct@ok-plugins
```

The web-setup plugin is the third. It sets up a project's agent-facing web
tooling: `/setup-web` converges the browser MCP server, and
`/setup-dom-picker` converges a dev-only DOM picker into the project's
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
| `ok` | Suite front door and sole administrator: carries ok-planner as payload; `/ok` is install, converge, and repair in one process | user |
| `ok-conduct` | How the assistant delivers: the Fall Guy Consulting code of conduct as an output style, with its per-turn reminder hook | user (personal) |
| `ok-web` | Web-project setup: the browser MCP server and the dev-only DOM picker | user (personal) |

ok-planner covers what to build and how the code holds up:

- **The design corpus**: concepts, stories, and decisions under
  `.ok-planner/design/`, the project's durable model.
- **The coding standards**: the Plumbline lint (comment hygiene, citation
  resolution, no tests, each switchable per project) with its edit hook, the
  coding rules and cheatsheet, the events and technical-writing standards,
  and the project's own subjects and practices.
- **The issue intake and the sprint loop**: `/plan-sprint`, `/converge`,
  `/triage-issues`, `/sketch`.
- **Verification and documentation**: `/audit` and `/document`.
- **Per-run verification stacks**: `run-tag` mints a fresh tag for each
  verification run, and `port-block` gives a run's stack its host ports.

**User-scoped → plugin system; project-scoped → committed project files.**
The family delivers its behavior into each project as vendored files: skills
under `.claude/skills/`, agent profiles under `.claude/agents/`, rules files
under `.claude/rules/`, hook implementations inside the estate, and hook
wiring as consented entries in `.claude/settings.json`. Every project runs
exactly the version it was converged to. The plugins stay machine-global on
purpose: they belong to the user, not to any project.

## Planning and review: ok-planner's sprint loop

`/plan-sprint` is ok-planner's planning session. It
produces an approved sprint: corpus deltas, work items, implementation notes
from a code-planning phase, and a fixed completion contract. Execution cuts
the sprint into stages and drains them as build tasks on the task tracker.
Sprint certification (`/converge sprint <path>`) closes the sprint: it reviews the change for
completion and regression, runs the project's checks, drives the stories the
sprint touches, and fixes what it finds. On the owner's cadence, `/converge`
in `drive`, `analysis`, or `defects` mode finds and fixes defects across the
product, and `/triage-issues` verifies the issue intake.

## Verification: a periodic audit

The design corpus is verified by the **periodic
implementation audit** (`/audit`), run on the owner's cadence and never
at a sprint close. The run makes four determinations. It opens with
the **surface**: an interactive intent stage in which the owner and
the run co-author the **surface intent** (`.ok-planner/surface/surface.md`
— prose, general rules with named exceptions: which classes of
element are public by default, which specific elements depart), then
an autonomous **surface extractor** subagent that reads the just-landed
intent, walks the code and deployment configuration, and writes the
run's **surface extraction** (`.ok-planner/audits/surface/extraction.json`
— one entry per element found, kind discovered by the walk; elements
the intent still does not settle are defaulted internal for the run
and filed as intake issues). No reconciler tool, no committed member
lists, no stamped ruling. It then measures **story support from the
user's side**, driving the released product through the public
surface the extraction records on a maintained experiment harness;
synthesizes and measures **user assumptions** on the same instrument
(each closing `held`, `trap`, or `unverified`); and reads **decision
and concept support** adversarially against the code. Each audit
records **two independent axes** per artifact: `text:` — whether the
artifact complies with its own authoring rules (`compliant` |
`noncompliant`) — and `implementation:` — whether the codebase
supports what it claims at a named commit (`supported` |
`unsupported`) — in one sentence to one paragraph. The axes come
apart, which is why both are written: a malformed artifact may be
accurately implemented, and a well-formed one may be implemented
nowhere. Every universal the artifact claims comes back as a count
plus the population it was taken from, which is the one form of
precision a reader can refute in seconds. Where an artifact names an
enumerable population and claims the whole of it, the verdict takes
the coverage shape: the count checked, the population it came from,
and the members nothing accounts for. The run also reports how far each
subject's practices reach and sweeps the lint over the project.

An audit is a statement about a commit rather than a standing verdict,
so nothing tracks staleness and nothing invalidates anything: asking
whether an audit still holds is a git question about how far the tree
has moved. Audits carry no citations, hashes, or line numbers; the
`@concept:` / `@story:` / `@decision:` annotations in the code are what
the next run navigates by.

The run is two determination stages with no loop. Auditors work in
parallel — stories and assumptions by measurement, decisions and
concepts by reading; everything they could not call `supported` goes
to one terminal judge, which confirms the gap and files an intake
issue, or overturns it to `supported`; a confirmed practice violation
becomes a defect issue for the next `/converge`. Only the `implementation:` axis
escalates: a `text:` defect is mechanical by construction, so it is
recorded in the audit file. Nothing is fixed by the run — a real gap
becomes a future sprint's work. The run runs no checker over its own
corpus: the orchestrator dispatches, collects, writes the run report,
commits, and stamps; a malformed audit is rewritten whole by the next
run.

## Documentation: generated at a release, never maintained

The documentation ceremony (`/document`) composes the audit as its
measurement front — running `/audit` when the tree has moved past its
stamp, reusing it otherwise — and measures nothing itself. Its output
has two tiers. The **records** under `.ok-planner/documentation/` are
a measured assessment split along the vantage line: a publishable
layer speaking only concepts, stories, and public surface elements
(catalog rows over the extraction's public side, assessments, traps,
a concept router), and an internal verification layer that cites the
tree freely. The **documents** are what readers open: the owner
declares **document types** at `.ok-planner/surface/documents/` — what
each document is for, the classes of public surface it covers, its
target path, and any **Method** naming how the writer produces it — settled
in a short **documentation walk** over the
extraction (inside the composed audit right after its extractor
returns, or against a reused audit's extraction), and the ceremony's
Generate step writes one self-contained document per type — oriented
by the records, verified against the tree at the release, citing
nothing — and **places** it at the type's target (`docs/...`, the root
`README.md`) with a provenance stamp, beside a `docs/CLAUDE.md`
carrying the record rule. Only declared targets are written. Placed
documents are records: out of agent context by default, read only
when directed there; staleness files nothing and marks nothing, and
the next release regenerates the set whole.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest (three
  entries: `ok-conduct`, `ok`, `ok-web`).
- `plugins/ok/` — the front door: one skill (`/ok`) plus the carried family
  at `plugins/ok/families/ok-planner/`. The family exposes the integration
  contract's two conventional administration surfaces: a deterministic
  converge core at `admin/converge` and an administration document at
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
  audit-oscillation detection). Every check verifies structure or behavior;
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
