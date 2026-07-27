# Vendored Suite — Design Sketch

**Date:** 2026-07-26
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Sidestep the plugin system for everything project-scoped. Claude Code's plugin
content is one machine-shared copy per marketplace: enablement is per-project,
but the bits, the registry, and update/reload are per-machine, so no project
has a version of its own. The suite already vendors the load-bearing runtime
(binaries, hooks, cheatsheets, context payloads) into the estate to survive
this; the sketch takes the last step and vendors the **prompt text too** — the
skills themselves — into each project's own `.claude/skills/`. The plugin
system keeps exactly the two things it is actually good at, both user-scoped:
the `ok` front door (thin, stable, deliberately ignorant) and `ok-conduct`
(a personal output style, newly split into its own plugin). Everything
project-scoped lives in the repo, converged deliberately by true-up.

The governing principle, one line: **user-scoped → plugin system;
project-scoped → committed project files.**

Long-term this is reversible: if the plugin system ever grows real
per-project content scoping, the vendored layer collapses back into it.

## Shape

**What the consumer machine carries (plugin system, global):**

- `ok` — the front door. Installed from the marketplace. Its true-up pass
  gains the vendoring step: fetch the suite at a named ref (marketplace copy
  or bare git), materialize each integrated plugin's skills into the
  project, and stamp versions.
- `ok-conduct` — new plugin, split out of ok-planner. Carries the output
  style, the conduct version stamp (X.Y.Z + animal), and the per-turn
  attention-refresher hook that exists only to serve the conduct. Installed
  by users who personally want the conduct; never project-pinned — the
  style is a preference that follows the person, not the repo.

**What the project carries (committed, converged by true-up):**

- `.claude/skills/<verb>/SKILL.md` — the vendored skill set for every
  integrated plugin, version-stamped. Project skills are a flat namespace,
  so the contract's deliberately shared verbs need mangling on
  materialization: `plan-sprint`, `prove`, … stay bare (planner owns them
  uniquely); colliding uniform verbs materialize plugin-prefixed
  (`ok-plumbline-audit`, `ok-workspaces-true-up`, …). The mangling rule
  lives in the integration contract, not in the dispatcher.
- `.claude/rules/<plugin>-cheatsheet.md` — unchanged; already the
  always-in-context layer.
- `.ok-<plugin>/` estates — unchanged: binaries, materialized hooks,
  context payloads, config, records.
- `.claude/settings.json` — gains the hook wiring that today rides the
  plugin manifests: SessionStart / UserPromptSubmit / PostToolUse entries
  point directly at the estate's materialized hooks
  (`.ok-planner/hooks/session-start`, `.ok-plumbline/hooks/post-edit.js`,
  …). **This dissolves the hook-shim layer entirely** — shims exist only
  because hooks execute from the machine-global plugin root; with project
  settings pointing at project files, there is no plugin root in the
  execution path. `decision:hook-shims` retires; its startup|clear|compact
  matcher discipline moves to the settings-wiring rule.

**Update flow:** updating the suite in a project is a deliberate act —
`/ok` (or the vendored planner true-up) pulls the new version, rewrites the
vendored skills and estate layer, and the diff lands in review like any
other change. N projects update on N schedules, which is the point.

**Adoption flow:** clone → everything works. Skills, rules, hooks, and
estates are all committed. The only machine steps are optional and
personal: install `ok` (to drive updates) and `ok-conduct` (if you want
the style). A contributor can override the project's defaults in their
`settings.local.json`; the project pins defaults, never mandates.

**Conduct split, mechanically:** ok-planner sheds
`output-styles/ok-conduct.md` and `hooks/user-prompt-submit`; both move to
the new `ok-conduct` plugin with the version-stamp discipline. The release
skill's conduct-version warning repoints. The planner's session-start
banner keeps reporting the conduct version when the conduct is present,
sourced from the installed plugin rather than a sibling directory. Conduct
rules that are project-protective rather than personal (never destroy
uncommitted work, checkpoint via staging) may additionally be stated in a
project's own rules files; the cheatsheet layer is the vehicle if any
plugin ever wants them project-side.

**Relation to the plugin-system marketplace:** the marketplace and
`plugins/` tree remain the source of truth and the distribution channel
for `ok` and `ok-conduct`, and the fetch source for vendoring. À la carte
integration is unchanged — a project vendors only the plugins whose
estates it carries.

## Open questions

- Fetch source for vendoring: the machine's installed plugin copy (simple,
  but reintroduces machine state as the version source) vs. a bare
  `git clone` at a tag (self-sufficient, needs network). Sketch assumes
  the installed copy with the ref recorded in the stamp; a sprint should
  decide.
- Verb mangling: exact rule for which names stay bare vs. plugin-prefixed,
  and whether `/true-up` survives as one project-local verb that converges
  all integrated plugins (probably yes — the front door's per-plugin
  dispatch was a workaround for plugin namespacing).
- Settings ownership: `.claude/settings.json` is a shared, hand-editable
  file — the whole-file-ownership rule forbids plugins overwriting it.
  True-up would need a managed-entries convention or a transcribe-with-
  consent step for the hook wiring; this collides with
  `decision:whole-file-ownership` and needs an owner ruling.
- Skill discovery UX: vendored skills lose the `plugin:skill` qualified
  invocation and the `/plugin` listing; confirm nothing else keys on
  plugin-qualified skill names (the sprint boilerplate's `/certify-work`
  references are bare already).
- The `ok` plugin's own scope: does the front door stay a plugin forever
  (bootstrap has to start somewhere), or does a committed update script
  eventually replace it too?
- Interaction with the context-unhobbling sketch (2026-07-25): both
  reshape session-start injection; if skills are project-local files, the
  skills-index/banner question should be settled once, jointly.

## Risks / unknowns

- **Off the paved road.** Plugins are where harness features land first
  (auto-updates, marketplace UX, future scoping fixes). Vendored skills
  won't benefit until deliberately re-adopted.
- **Sprawl in consumer repos.** The full skill set is a few hundred KB of
  markdown per project; acceptable, but the diff noise on suite updates is
  real and lands in every project's review.
- **Settings collisions.** Hook wiring in a shared settings file is the
  one place this design must write where humans also write; if the
  managed-entries convention proves fragile, hooks are the piece that
  breaks first.
- **Drift between vendored copies and the corpus.** The version stamp and
  a diagnose check (vendored skills vs. source ref) must cover the skill
  layer the same way they cover binaries, or projects will hand-edit
  vendored skills and silently fork the methodology.
- **Team consent.** A committed default output style was rejected in this
  design as an imposition; committed hooks are arguably stronger. Trust
  prompts mitigate but the adoption story should say this out loud.

## What this is not

- Not a migration plan or sequencing — that's a sprint's job, and the
  corpus deltas (retiring `decision:hook-shims`, amending
  `concept:integration-contract`, `concept:skill`,
  `concept:materialized-artifact`, splitting `concept:conduct`'s delivery)
  are deliberately not drafted here.
- Not a change to the estate model — estates, cheatsheets, stamps, and
  true-up semantics carry over unchanged; this extends them to one more
  content layer.
- Not abandonment of the plugin system — `ok` and `ok-conduct` stay on it
  by design, and the whole vendored layer is built to fold back in if the
  system gains per-project scoping.
