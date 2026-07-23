# The ok-plugin Integration Contract

Normative. Every plugin in this marketplace integrates into a consumer
project the same way. The `ok` plugin is a pure dispatcher over this
contract: it knows the discovery convention and the verb set below, and
nothing else. A plugin that needs `ok` to special-case it has integrated
wrong.

## The three layers

Each plugin's presence in a project consists of exactly three layers:

1. **The dot-directory: `.ok-<name>/` at the repo root.** The plugin's
   committed project-side estate: declared configuration (including any
   stack profile), the full corpus, and any materialized support scripts.
   Its existence is the discovery marker — "which ok-plugins does this
   project use?" is a filesystem check, never an inference. Discovery
   also matches a plugin's *documented pre-migration markers* (see current
   conformance below): a project carrying only a pre-migration estate
   must still be discovered, or its migration is never offered.
2. **The cheatsheet: one plugin-owned file under `.claude/rules/`.** The
   small, stable, always-in-context rules layer. Wholly owned and
   overwritten by the plugin's true-up; drift is corrected by overwrite,
   never by merge.
3. **The skills.** The plugin's behavior, exposed as verbs with uniform
   semantics across the suite (below).

## The ownership rule

A plugin owns whole files and never edits a file a human also edits. In
particular: no plugin touches `.claude/rules/rules.md` or `CLAUDE.md`.
Humans may reference plugin cheatsheets from their own files; nothing in
the suite depends on it. Anything long-lived a plugin maintains must live
in a file the plugin can deterministically regenerate in full.

Ownership also decides what true-up may do silently: files the plugin
owns — version-stamped, deterministically regenerable — are converged
without prompting; anything else at a path the plugin cares about (an
estate laid out by an earlier plugin version, a hand-written file where
the plugin would materialize its own) is **presented for the owner's
consent** — migrate, adopt, replace, or leave — never silently
overwritten.

The same consent rule covers **preexisting project context that
overlaps a plugin's territory**: guidance the project already carries
where the plugin would now govern (an alternate coding-style document
where ok-plumbline's cheatsheet rules, a hand-rolled worktree script
where ok-workspaces materializes its own, an ad-hoc planning directory
beside `.ok-planner/`). True-up's diagnose phase identifies such
context and **proposes a conversion plan** — fold it into the plugin's
declared config, keep it as project-specific rules alongside the
cheatsheet, or retire it — for the owner to decide. Nothing
overlapping is ignored, and nothing is converted silently.

## The verb set

Every ok-plugin exposes one lifecycle verb, plus a compliance verb where
it has rules to check:

- **true-up** — the idempotent converge of the plugin's estate toward
  what the installed plugin declares. Three phases: *diagnose*
  (read-only — reality vs declaration, on two axes: project drift, where
  the repo's detected state no longer matches its committed declarations,
  and version drift, where a materialized artifact carries an older
  plugin version than the installed one); *consent* (only when something
  not plugin-owned needs migrating or resolving — per the ownership rule
  above; owner judgment is asked for, never assumed); *converge*
  (deterministic materialization of the plugin-owned layer, driven by the
  project's committed declarations, never re-inferred at use time). A
  compliant project is a silent no-op. True-up is always a user (or
  user-invoked orchestrator) action — nothing in the suite runs it from
  a hook.
- **audit** — read-only project-compliance report against the plugin's
  rules, where the plugin has rules to check (e.g. ok-plumbline's lint).

The diagnose phase's mechanics stay available standalone where CI wants
a no-writes drift gate: each plugin keeps its read-only diagnosis as a
script or CLI subcommand with a drift exit code (e.g. ok-workspaces'
`scripts/diagnose.js`, ok-plumbline's `plumbline diagnose`). That layer is
implementation, not a skill — the user-facing verb is true-up.

## Version stamps

Every materialized artifact records the version of the plugin that wrote
it, so version drift is mechanically checkable by true-up's diagnose
phase without content comparison.

## Support scripts

A plugin that gives a project executable machinery owns the canonical
script and **materializes** it project-side — every script, not just the
leaf utilities: lint binaries, hook implementations, and diagnostic tools
all count, and the only thing that legitimately runs from the plugin copy
is the true-up entry point itself, because it is what creates the project
copy. The default home is inside the plugin's dot-directory
(`.ok-<name>/bin/<script>`), and a profile or
config may declare another path so existing consumers keep working
(e.g. pointing ok-workspaces' `srcTag.path` at a script already wired
into the project's build). Materialized scripts are plugin-owned whole
files — version-stamped, executable, overwritten wholesale by true-up,
never hand-edited — and the plugin's diagnose phase checks each one is
byte-identical to the canonical version for the installed plugin. The
dot-directory (or declared path) is therefore always the answer to
"where are this plugin's helper scripts, and who maintains them":
true-up does, from the plugin's canonical copy.

## Hooks are shims; behavior is project-local

A hook command is resolved by the harness against `${CLAUDE_PLUGIN_ROOT}`, so a
plugin's hook files must physically live in the installed plugin copy. That copy
is shared by every project on the machine and changes the moment the plugin is
updated or edited — so **nothing a hook actually does may live there**.

Every ok-plugin hook is therefore a shim with one job: resolve the project root,
exec `.ok-<name>/hooks/<hook-name>`, and exit silently when that file is absent.
The real hook — and any payload it injects — is materialized project-side by
true-up and version-stamped like every other materialized artifact. Three
properties follow, and each of them is the point:

- **Per-project versions.** A project runs the hook it was trued up to.
  Updating the installed plugin changes nothing anywhere until each owner
  converges deliberately.
- **Development is safe.** Editing a plugin cannot disturb a session running in
  another project, because that session executes nothing from the plugin copy.
- **Discovery stays a filesystem check.** A project with no `.ok-<name>/` estate
  gets a silent no-op, which is the same rule the rest of this contract uses —
  no hook fires in a project that never integrated the plugin.

The shim itself is the only part that may read `${CLAUDE_PLUGIN_ROOT}`, and it
may read nothing but the path it execs. A hook that inspects plugin-root content,
or that carries logic worth versioning, has integrated wrong.

## Stack tailoring (detect → declare → materialize)

Plugins whose discipline varies by project stack (ok-workspaces) follow
this shape: a detection scan *proposes* a stack profile from repo signals
(compose files, `go.mod`, `package.json`, build targets); the committed
profile in the dot-directory is what's *authoritative*; true-up
materializes rules and scripts *from the profile*. Detection never
silently decides — a scan/declaration mismatch is diagnosed project
drift, and reconciling the profile is the owner's act; true-up stops and
asks. Asking means a **conversational walkthrough**, not a file to go
edit: true-up puts each judgment call to the owner in dialogue (a single
yes/no when detection is unambiguous) and transcribes the answers into
the committed profile verbatim — declaring is deciding, not typing.
Writing the profile as transcription of explicit answers does not breach
the ownership rule; writing any field the owner didn't confirm does. A
proposal file remains the fallback for owners who prefer hand-editing.

## The ok plugin

`ok` is the suite's front door and the mechanical check on this
contract. Its manifest declares the other ok-plugins as dependencies, so
`claude plugin install ok@ok-plugins` installs the whole suite in one
step (each plugin remains individually installable à la carte). Its one
skill, `/ok`, updates the *installed* suite plugins to the marketplace's
current versions (never installing an absent one), discovers integrated
plugins by their markers, offers — one explicit consent question, never
silently — to bootstrap any installed plugin whose markers are absent
(all of them, a subset, or none: the owner's call), and drives each
integrated or consented plugin's `true-up` sequentially — relaying any
consent questions verbatim — knowing nothing else. The bootstrap offer
works because every true-up is an idempotent installer: its converge
phase materializes a missing estate the same way it repairs a drifted
one, so `/ok` needs no per-plugin install knowledge. A plugin `/ok`
cannot drive through those two conventions has integrated wrong.
`ok` itself materializes no project estate — it has no dot-directory and
is never "integrated"; it acts on whatever project it is run in.

## Current conformance

- `ok-planner` — fully conformant: dot-directory `.ok-planner/`,
  cheatsheet at `.claude/rules/ok-planner-cheatsheet.md` (materialized
  by true-up), lifecycle verbs (true-up / audit / prove); its true-up
  detects and migrates (with consent) the retired pre-4.0 estate. The
  ok-conduct output style is an additional, optional delivery-style
  layer, not the rules layer.
- `ok-plumbline` — fully conformant: dot-directory `.ok-plumbline/`
  holding the project config at `.ok-plumbline/config.json`,
  cheatsheet at `.claude/rules/plumbline-cheatsheet.md`, true-up /
  audit. Its documented pre-migration marker is a root-level `.plumbline.json`
  (the pre-dot-directory config location); the binary honors that
  path until true-up migrates it (a mechanical relocation — contents
  untouched).
- `ok-workspaces` — fully conformant (dot-directory profile,
  materialized cheatsheet, true-up / audit, version stamps).
