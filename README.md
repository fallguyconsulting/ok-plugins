# ok-plugins

The public Claude Code marketplace for the ok-* suite: Fall Guy Consulting's
project-agnostic development-methodology tooling. Internal-only tooling lives
in a separate marketplace; nothing here may assume a specific consumer.

## Install

The marketplace distributes exactly two user-scoped plugins. The `ok` plugin
is the suite's front door and sole administrator — it carries the suite's
skill families as payload:

```
/plugin marketplace add <this-repo>
/plugin install ok@ok-plugins
```

Then `/ok` in any project is the whole administration process — install,
converge, repair: it updates the installed plugins, discovers which families
the project integrates (a filesystem check against committed markers), offers
to bootstrap the rest in one consent question, and administers each family
from the carried payload — vendoring its skills, scripts, hooks, and
cheatsheet into the project as committed, version-stamped files. A converged
project is self-contained: cloning it yields the working suite with nothing
installed; the installed front door is only needed to converge to a newer
version.

The personal conduct is the other user-scoped plugin, deliberately outside
everything — installing the front door never installs it, and `/ok` never
offers it. If you want it, that choice is yours alone:

```
/plugin install ok-conduct@ok-plugins
```

## Skill families

The suite's unit of project-scoped distribution is the **skill family**: a
self-contained directory of skills, templates, support scripts, and
administration surfaces, carried whole inside the front-door plugin at
`plugins/ok/families/` and delivered into consumer projects by vendoring.
Families are not plugins — none is separately installable, and consumers meet
a family only through its vendored presence in their project.

| Family | Concern | Delivery |
| --- | --- | --- |
| `ok-planner` | What to build — the design corpus (concepts, stories, decisions), the periodic implementation audit, the issue intake, and the sprint planning ceremony | vendored into the project |
| `ok-plumbline` | How code reads — the Plumbline methodology: comment hygiene, citation resolution, the edit-hook lint | vendored into the project |
| `ok-workspaces` | Where work happens — worktree-per-job, isolated runtime stacks, content-addressed artifacts | vendored into the project |

| Plugin | Concern | Scope |
| --- | --- | --- |
| `ok` | Suite front door and sole administrator — carries the families as payload; `/ok` is install, converge, and repair in one process | user |
| `ok-conduct` | How the assistant delivers — the Fall Guy Consulting code of conduct as an output style, with its per-turn reminder hook | user (personal) |

**User-scoped → plugin system; project-scoped → committed project files.**
The families deliver their behavior into each project as vendored files —
skills under `.claude/skills/`, hook implementations inside each family's
estate, hook wiring as consented entries in `.claude/settings.json` — so
every project runs exactly the version it was converged to. The two plugins
stay machine-global on purpose: they belong to the user, not to any project.

`ok-plumbline` is the family packaging of the Plumbline methodology; the
methodology keeps its name (the lint binary and the
`@plumbline:allow-docstrings` marker are unchanged), so existing Plumbline
projects remain compatible. In a converged project the verbs are the vendored
skills (`/ok-plumbline-audit`, `/patterns`, `/budget`, …) — the collision
rule family-prefixes any verb name more than one family claims.

## Verification: a periodic audit, not a per-close gate

The planner family's corpus is verified by the **periodic
implementation audit** (`/verify-corpus`), run on the owner's cadence
and never at a sprint close. It re-reads every live story and decision
and records, per artifact, whether the codebase supports it at a named
commit — `supported`, `unsupported`, or `unclear` — in one sentence to
one paragraph. Every universal the artifact claims comes back as a
count plus the population it was taken from, which is the one form of
precision a reader can refute in seconds.

An audit is a statement about a commit rather than a standing verdict,
so nothing tracks staleness and nothing invalidates anything: asking
whether an audit still holds is a git question about how far the tree
has moved. Audits carry no citations, hashes, or line numbers; the
`@story:` / `@decision:` annotations in the code are what the next run
navigates by.

The run is two stages with no loop. Auditors read in parallel batches;
everything they could not call `supported` goes to one second-opinion
judge, which confirms the gap and files an intake issue, overturns it
to `supported`, or calls it undecidable and files an issue for the
owner to settle. Nothing is fixed by the run — a real gap becomes a
future sprint's work. `.ok-planner/bin/audit-check` enforces the one
mechanical invariant: no non-supported determination stands without its
issue.

## Layout

- `.claude-plugin/marketplace.json` — the marketplace manifest (two entries:
  `ok-conduct`, `ok`).
- `plugins/ok/` — the front door: one skill (`/ok`) plus the carried
  families at `plugins/ok/families/{ok-planner,ok-plumbline,ok-workspaces}`.
  Each family exposes the integration contract's two conventional
  administration surfaces: a deterministic converge core at `admin/converge`
  and an administration document at `admin/ADMINISTRATION.md`. Families
  carry no manifests and no family-root hooks: hook implementations are
  materialized into each consumer project's estate and wired through
  consented settings entries.
- `plugins/ok-conduct/` — the personal conduct plugin; the one plugin that
  runs hooks from the plugin root, deliberately machine-global.
- `docs/integration-contract.md` — the normative contract every family
  follows to meet a consumer project: the layers, the administration
  surfaces, the verb collision rule, consented hook wiring, discovery
  markers. New families must conform; the front door depends on it.
- `checks/` — repo maintenance checks for suite-wide structural
  conformance (transclusion token resolution, vendored-layer and
  administration-surface conformance, hub-row single-sourcing, owned-path
  discipline, audit-oscillation detection). Every check verifies
  structure or behavior — none asserts the presence of static text; a
  prose-realized commitment is verified by its implementation audit. Run
  them all with `bash checks/run`; each check is annotated with the
  decision or concept it enforces. Not part of any distributed plugin.
  Other test harnesses:
  `bash plugins/ok/families/ok-planner/test/run.sh` (audit-check's
  coverage, shape, brevity, and issue-link cases),
  `bash plugins/ok/families/ok-planner/test/stories.sh` (the planner's
  story-level integration tests: session injection, governing-version
  drift, and the issue-walk surfacer),
  `bash plugins/ok/test/administration.sh`
  (family discovery, the bootstrap → repair → no-op converge demo, and the
  two-family consolidated administration run),
  `bash plugins/ok/families/ok-plumbline/test/run.sh` (lint fixtures, the
  budget ratchet, the edit-hook invocation harness, and the family's
  story-level tests: in-turn blocking with the violation message, the
  adoption ratchet in both directions, and the compliance report),
  `bash plugins/ok/families/ok-workspaces/test/demo.sh` (workspace isolation
  and teardown-gate demo), and
  `bash plugins/ok/families/ok-workspaces/test/tags.sh` (the
  content-addressed tag: machine invariance, edit sensitivity, and a
  missing-tag lookup failing loudly).

This repo dogfoods the vendored mode: its own `.claude/skills/` carries the
vendored ok-planner skill set, and its `.claude/settings.json` carries the
consented session-start hook entry.

## Versioning

**One version for the suite.** Both plugin manifests carry the same
`version`, bumped together and tagged once per release (`vX.Y.Z`) at the
highest level any change warrants — and a change anywhere under the front
door's carried payload is a suite change: the families ship inside the `ok`
plugin, whose version is Claude Code's update key. Every stamp the family
machinery writes into a consumer project derives from the front-door
manifest, so "which versions work together" is always answerable.

Releases are cut by the repo-local `/release` skill
(`.claude/skills/release/`), which surveys the whole monorepo, stamps the new
version into both plugin manifests, commits, tags, and pushes. It is
maintenance tooling, not part of any distributed plugin.

The conduct's own version stamp (`Conduct version: X.Y.Z (Animal)` in the
body of `plugins/ok-conduct/output-styles/ok-conduct.md`) is independent and
hand-managed, untouched by a release — a release only warns when the conduct
body changed without a bump.

## License

Apache-2.0, suite-wide. Each plugin and family carries its own `LICENSE`
file.
