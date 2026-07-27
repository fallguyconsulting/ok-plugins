# The ok-plugin Integration Contract

Normative. Every integrable plugin in this marketplace meets a consumer
project the same way. The `ok` plugin is a pure dispatcher over this
contract: it knows the discovery convention and the uniform lifecycle
verb below, and nothing else. A plugin that needs `ok` to special-case
it has integrated wrong. The user-scoped plugins — the front door
itself and the personal conduct plugin — never integrate; this contract
does not govern their presence on a machine.

## The layers

An integrable plugin's presence in a project consists of these layers,
all committed to the project:

1. **The dot-directory: `.ok-<name>/` at the repo root.** The plugin's
   committed project-side estate: declared configuration (including any
   stack profile), the full corpus, materialized support scripts, and
   materialized hook implementations. Its existence is the discovery
   marker — "which ok-plugins does this project use?" is a filesystem
   check, never an inference.
2. **The cheatsheet: one plugin-owned file under `.claude/rules/`.** The
   small, stable, always-in-context rules layer. Wholly owned and
   overwritten by the plugin's true-up; drift is corrected by overwrite,
   never by merge.
3. **The vendored skills: the plugin's user-facing verbs, materialized
   into `.claude/skills/`.** Version-stamped whole files rendered from
   the installed plugin copy, sibling references rewritten to the
   materialized names, under the collision rule below. A converged
   project is self-contained: cloning it yields the working suite with
   no plugin installed; only converging to a newer version needs the
   plugin.
4. **The hook wiring: consented entries in `.claude/settings.json`.**
   Hooks execute from the project's materialized copies inside the
   estate, reached through entries in the project's committed harness
   settings — see "Hooks" below.

## Discovery markers

Every marker the dispatcher honors is documented here — the contract,
not the dispatcher, is where per-plugin knowledge lives:

- `ok-planner` — `.ok-planner/` at the repo root.
- `ok-plumbline` — `.ok-plumbline/` at the repo root; pre-migration
  markers: a root-level `.plumbline.json` (the pre-dot-directory config
  location), or `.claude/rules/plumbline-cheatsheet.md` (a materialized
  cheatsheet from an integration whose config was never migrated).
- `ok-workspaces` — `.ok-workspaces/` at the repo root.

Pre-migration markers are honored so a project carrying only an earlier
layout is still discovered and offered its migration.

## The ownership rule

A plugin owns whole files and never edits a file a human also edits. In
particular: no plugin touches `.claude/rules/rules.md` or `CLAUDE.md`.
Humans may reference plugin cheatsheets from their own files; nothing in
the suite depends on it. Anything long-lived a plugin maintains must live
in a file the plugin can deterministically regenerate in full.

Ownership also decides what true-up may do silently: files the plugin
owns — version-stamped, deterministically regenerable, the vendored
skill files included — are converged without prompting; anything else at
a path the plugin cares about (an estate laid out by an earlier plugin
version, a hand-written file where the plugin would materialize its own)
is **presented for the owner's consent** — migrate, adopt, replace, or
leave — never silently overwritten.

Owner-declared configuration is written only as **transcription of
explicit answers**: the stack profile fields an owner confirmed in
conversation, and the hook entries an owner consented to in
`.claude/settings.json`. Writing a field or an entry the owner didn't
confirm breaches the rule; transcribing their answer does not.

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

Every integrable plugin exposes the uniform lifecycle verb, plus a
read-only compliance verb where it has rules to check, plus a
proof-running verb where its estate carries provable artifacts:

- **true-up** — the idempotent converge of the plugin's presence toward
  what the installed plugin declares. Three phases: *diagnose*
  (read-only — reality vs declaration, on two axes: project drift, where
  the repo's detected state no longer matches its committed declarations,
  and version drift, where a materialized artifact carries an older
  plugin version than the installed one); *consent* (only when something
  not plugin-owned needs migrating, resolving, or transcribing — per the
  ownership rule above; owner judgment is asked for, never assumed);
  *converge* (deterministic materialization of the plugin-owned layer —
  estate, cheatsheet, vendored skills — driven by the project's committed
  declarations and the installed plugin's canonical copies, never
  re-inferred at use time). A compliant project is a silent no-op.
  True-up is always a user (or user-invoked orchestrator) action —
  nothing in the suite runs it from a hook.

  **Project-locally, the lifecycle verb is one merged verb.** Each
  plugin's own true-up remains in its plugin as the vendor source and
  bootstrap entry point, but what a project's owner runs is the single
  vendored `true-up` skill at `.claude/skills/true-up/SKILL.md`, which
  converges the whole integrated set in one act — driving each
  integrated plugin's own true-up and consolidating hook-wiring consent.
  Every integrable plugin materializes the merged verb from the same
  shared template, so whichever plugin converges first provides it.
- **audit** — read-only project-compliance report against the plugin's
  rules, where the plugin has rules to check (e.g. ok-plumbline's lint).
- **prove** — executes the estate's provable artifacts, where the
  plugin's estate carries any (ok-planner's stories and decisions).

**The collision rule.** The project's skills directory is a flat
namespace, so vendored verb names collide by rule, never by accident:
the lifecycle verb materializes once, merged; any other verb name
claimed by more than one integrated plugin materializes plugin-prefixed
(`ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`);
unclaimed-by-others names keep their bare form. Sibling-invocation
references inside vendored skill bodies are rewritten to the
materialized names at vendoring time.

The diagnose phase's mechanics stay available standalone where CI wants
a no-writes drift gate: each plugin keeps its read-only diagnosis as a
script or CLI subcommand with a drift exit code (e.g. ok-workspaces'
`scripts/diagnose.js`, ok-plumbline's `plumbline diagnose`). That layer is
implementation, not a skill — the user-facing verb is true-up.

## Version stamps

Every materialized artifact records the version of the plugin that wrote
it, so version drift is mechanically checkable by true-up's diagnose
phase. Vendoring fetches from the installed plugin copy, and the version
that copy carried is what the stamp records. The merged lifecycle verb
is stamped with the suite version, which lockstep versioning keeps equal
across plugins.

## Support scripts

A plugin that gives a project executable machinery owns the canonical
script and **materializes** it project-side — every script, not just the
leaf utilities: lint binaries, hook implementations, and diagnostic tools
all count. Exactly three classes legitimately run from the installed
plugin copy: the lifecycle verb's own entry point (it is what creates the
project copy), bootstrap verbs that by definition run before anything is
vendored, and read-only advisory verbs falling back with an announcement
in their output. The default home is inside the plugin's dot-directory
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

## Hooks: materialized implementations, consented wiring

Integrable plugins ship **no plugin-root hooks**. A hook's
implementation is materialized into the plugin's estate
(`.ok-<name>/hooks/<hook-name>`) like any other support script —
version-stamped, plugin-owned, overwritten by true-up — and the harness
reaches it through an entry in the project's committed
`.claude/settings.json` pointing at the materialized copy (via
`$CLAUDE_PROJECT_DIR`). Three properties follow, and each is the point:

- **Per-project versions.** A project runs the hook it was trued up to.
  Updating the installed plugin changes nothing anywhere until each owner
  converges deliberately.
- **Development is safe.** Editing a plugin cannot disturb a session
  running in another project, because no project session executes
  anything from the plugin copy.
- **Wiring is owner-declared.** `.claude/settings.json` is the owner's
  file. A plugin's diagnose reports a missing or drifted entry as a
  `WIRING NEEDED` block carrying the exact entry and the exact consent
  command; the entry is written only by that command, on the owner's
  explicit yes — consented transcription, per the ownership rule.

Matcher discipline: every `SessionStart` entry carries the
`startup|clear|compact` matcher and never fires on resume; every entry
is scoped exactly as its plugin's block declares — a widened matcher is
diagnosed drift. A project with no estate has no wiring and no hook
fires — the same discovery rule the rest of this contract uses.

(The user-scoped conduct plugin runs its hooks directly from the plugin
root — deliberately machine-global, because the conduct belongs to the
user, not to any project. That is the user-scoped delivery split, not an
exception to this section: this section governs integrable plugins.)

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

## Repo-root machinery

The marketplace catalog, this contract document, the release tooling,
and the maintenance checks are repo-root machinery of the suite's own
monorepo — maintenance material, part of no plugin, and never delivered
to a consumer project. Nothing in any plugin may assume a specific
consumer project.

## The ok plugin

`ok` is the suite's front door and the mechanical check on this
contract. Its manifest declares the integrable ok-plugins as
dependencies, so `claude plugin install ok@ok-plugins` installs the
integrable suite in one step (each plugin remains individually
installable à la carte). The personal conduct plugin is **not** among
its dependencies: installing the suite never installs the conduct, and
the front door never installs, vendors, or offers it. `ok`'s one
skill, `/ok`, updates the *installed* suite plugins to the marketplace's
current versions (never installing an absent one), discovers integrated
plugins by the markers documented above, offers — one explicit consent
question, never silently — to bootstrap any installed integrable plugin
whose markers are absent (all of them, a subset, or none: the owner's
call), and drives the project's merged `true-up` verb once — relaying
any consent questions verbatim — knowing nothing else. The bootstrap
offer works because every true-up is an idempotent installer: its
converge phase materializes a missing presence the same way it repairs
a drifted one, so `/ok` needs no per-plugin install knowledge. A plugin
`/ok` cannot drive through those two conventions has integrated wrong.
`ok` itself materializes no project estate — it has no dot-directory and
is never "integrated"; it acts on whatever project it is run in.

## Current conformance

- `ok-planner` — fully conformant: dot-directory `.ok-planner/`,
  cheatsheet at `.claude/rules/ok-planner-cheatsheet.md`, vendored
  skills with the `audit` verb prefixed as `ok-planner-audit`, the
  session-start hook materialized at `.ok-planner/hooks/session-start`
  and wired by consent, lifecycle verbs (true-up / audit / prove); its
  true-up detects and migrates the retired pre-4.0 estate.
- `ok-plumbline` — fully conformant: dot-directory `.ok-plumbline/`
  holding the project config at `.ok-plumbline/config.json`,
  cheatsheet at `.claude/rules/plumbline-cheatsheet.md`, vendored
  skills with the `audit` verb prefixed as `ok-plumbline-audit`, the
  edit hook materialized at `.ok-plumbline/hooks/post-edit.js` and
  wired by consent, true-up / audit. Its pre-migration markers are
  documented under "Discovery markers" above; the binary honors the
  root config path until true-up migrates it (a mechanical relocation —
  contents untouched).
- `ok-workspaces` — fully conformant (dot-directory profile,
  materialized cheatsheet, vendored skills with the `audit` verb
  prefixed as `ok-workspaces-audit`, no hooks, true-up / audit, version
  stamps).
