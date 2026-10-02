# The ok Suite Integration Contract

Normative. Every skill family in this suite meets a consumer project the
same way; the front door — the `ok` plugin, the suite's sole
administrator — administers every family by driving the conventional
contributions this contract defines, and the suite's ceremonies cover every
family by driving theirs. Family knowledge lives in the family's own
directory at those contributions, so adding a family means adding a
conforming directory, never rewriting the administrator and never
editing a ceremony. One named exception stands: ok-planner's
`/plan-sprint` is one self-contained planning session that runs the
ok-plumbline and ok-workspaces planning steps itself wherever those
estates exist, and reads no family contribution. A family that needs
a planning step adds it to that skill. A family the front door cannot administer, or a
ceremony cannot reach, through these conventions has conformed wrong.
The user-scoped plugins — the front door itself and the personal
conduct — never integrate; this contract does not govern their presence
on a machine.

## Skill families

The suite's unit of project-scoped distribution is the **skill
family**: a self-contained directory of skills, templates, support
scripts, administration files, and ceremony contributions, carried whole as payload inside
the front-door plugin at `plugins/ok/families/<name>` and delivered
into consumer projects as committed, vendored files. A family is not a
plugin: nothing family-scoped installs machine-globally, no family is
separately installable, and consumers meet a family only through its
vendored presence in their project. The plugin system carries exactly
two user-scoped plugins — the front door that carries the families,
and the personal conduct.

## The layers

A family's presence in a project consists of these layers, all
committed to the project:

1. **The dot-directory: `.ok-<name>/` at the project root.** The family's
   committed project-side estate: declared configuration (including any
   stack profile), the full corpus, materialized support scripts, hook
   implementations, and ceremony contributions, and any machine-written
   determination records.
   Its existence is the discovery marker — "which suite families does
   this project use?" is a filesystem check, never an inference. The
   family's `LICENSE` is materialized at the estate root, so the
   license text rides with every vendored copy of the family — under
   the scope preamble described below.
2. **The cheatsheet: one suite-owned file under `.claude/rules/`.** The
   small, stable, always-in-context rules layer. Wholly owned and
   overwritten on converge; drift is corrected by overwrite, never by
   merge.
3. **The vendored skills: the family's user-facing verbs, materialized
   into `.claude/skills/`.** Version-stamped whole files rendered from
   the carried payload, sibling references rewritten to the
   materialized names, under the collision rule below. Each vendored
   folder also carries the family's `LICENSE`, under the same scope
   preamble — never inside `SKILL.md`, whose body is context an agent
   pays for on every read. A converged project is self-contained:
   cloning it yields the working suite with nothing installed; only
   converging to a newer version needs the front door.

   A family may also vendor **agent profiles** into `.claude/agents/`:
   version-stamped `ok-<profile>.md` files whose frontmatter pins a
   subagent's model and effort, beside the family's `LICENSE` under the
   same scope preamble. A profile path already holding a file whose
   last line is not the suite's stamp is the project's own and is never
   written over; converge reports it as a collision.

**Every materialized `LICENSE` opens with a scope preamble** — the
licensor (Fall Guy LLC) and, in plain sentences, which files in that
directory the grant covers. Every destination sits among content the
project owns: the estate root holds the project's configuration and
records, `.claude/skills/` holds skills the project wrote itself, and
`.claude/agents/` holds the project's own agents.
A bare license file in either place reads as a grant over the
project's own work, which is why the preamble is part of the contract
and not a nicety. The Apache text below it is verbatim and never
edited.
4. **The hook wiring: consented entries in `.claude/settings.json`.**
   Hooks execute from the project's materialized copies inside the
   estate, reached through entries in the project's committed harness
   settings — see "Hooks" below.

## The administration files

Every family exposes exactly two conventional administration files,
and the front door administers the family by driving them — never by
improvising:

- **The converge core: `admin/converge`.** Executable and
  deterministic. Modes: `diagnose` (read-only comparison of reality
  against declaration — project drift and version drift — writing
  nothing; it exits 0 when clean, 1 on drift, and 3 when its only
  findings are cleanup offers awaiting the owner; missing hook wiring
  is drift), converge (the default:
  materialization of the suite-owned layer from committed declarations
  and the payload's canonical copies), `wire-hooks` (only where the
  family declares hooks — the consent-transcription path, the ONLY
  path that writes `.claude/settings.json`), and `resolve <id>` (the
  consented cleanup path, below). Converge is an idempotent
  installer: it materializes a missing presence the same way it repairs
  a drifted one, and a compliant project is a silent no-op.
- **Cleanup offers and `resolve`.** Every item a core cannot settle
  alone — a collision, a project-owned file the suite now covers, a
  two-location conflict, an owner file whose words must change — is
  printed by diagnose and converge as a `CLEANUP OFFERED (<layer>): <id>`
  block: what is there (`What:`), the fix (`Fix:`, or one
  `Choice <name>:` line per choice), the recommended answer, an
  optional `Show:` command, an optional `Draft:` line saying what an
  owner-approved draft must hold, and the exact consent command. An id
  is `<kind>:<path from the project root>`, stable across runs, and
  the consent command quotes it. Every family offers a collision the
  same way (`collision:`, the project's own unstamped files at paths
  the family vendors), and every layer offers the project's own files
  inside a retired verb's folder (`retired-verb:`); each fix deletes
  only the files its block lists. A block may carry an `Uncommitted:`
  line, naming paths with uncommitted or staged-only changes, or a
  `Symbolic link:` line, naming a link the paths sit behind.
  `resolve <id> [<choice> | --from <draft>]` re-reads the core's
  offers, refuses an id diagnose would not report now, and applies
  that one fix: a deletion through `git rm` where git tracks the path,
  a move through `git mv`, or a write of the draft after checking it
  the way diagnose would. `resolve` refuses an item whose block carries
  an `Uncommitted:` or `Symbolic link:` line, changing nothing, until
  the owner commits those changes or removes the link and runs `/ok`
  again; no offer has a choice that discards changes. Converge itself
  still removes suite-stamped retired files with no offer. A draft
  changes only what its offer names and keeps every other line and
  entry as it stands. An offer for a project rule file the suite now
  carries (`rule-file:`) drafts a new, shorter project rule file
  holding only the project's own facts and repeating no sentence of
  the suite's text, then deletes the old file; an empty draft only
  deletes it. The front door presents every block in one
  question, writes each draft to a scratch path outside the project,
  runs the command for each accepted item, and converges again; a
  declined item is recorded as declined, not as drift. No core leaves
  an item for the owner to fix by hand.
- **The administration document: `admin/ADMINISTRATION.md`.** The
  judgment the core cannot encode, written for the administrator to
  follow: the cleanup offers and how to draft each one that needs the
  owner's words, overlapping-context conversion proposals, and config
  or profile declaration walkthroughs. Migration and repair judgment comes from
  this document, never improvised by the administrator.

Families expose no administration verbs of their own: administration is
what the front door does, not a skill a project carries, and it is
always a user (or user-directed) action — nothing in the suite runs it
from a hook. Invoking the administrator is itself the authorization to
migrate the suite's own retired layouts; consent is reserved for
genuine collisions, for content the suite does not own, and for
transcription into owner-declared configuration.

**The suite administers one layer of its own.** The ceremony verbs
below belong to no family, so the front-door plugin carries the same
two files at its own `admin/converge` and `admin/ADMINISTRATION.md`,
and `/ok` drives them before the families'. That layer lays out no
estate; it vendors two skill bodies, retires the verbs they replaced,
materializes the suite's rules file (`.claude/rules/ok-cheatsheet.md`)
and two hooks, the subagent-model hook (`.claude/hooks/ok-agent-model`)
and the subagent-batching hook (`.claude/hooks/ok-subagent-batching`),
wires both hooks only through its consented `wire-hooks` mode, transcribes
the task-tools env entry only through its consented `wire-env` mode,
and writes an owner-approved repair of an unreadable
`.claude/settings.json` only through its consented `resolve` mode.

## The ceremony contributions

Two verbs are **suite-owned** rather than any family's — `audit` (the
periodic run) and `document` (release documentation). Each is one
canonical body, carried at `plugins/ok/ceremonies/<verb>/SKILL.md`,
vendored into consumer projects like every other skill, and covering
whichever estates the project has.

`plan-sprint` is not a suite verb and not a ceremony. It is
ok-planner's planning session, the named exception in this contract's
introduction: it reads no family contributions, and runs the other
estates' planning steps itself where those estates exist. The sprint
loop around it — `execute-tasks`, `converge`, and `triage-issues` — is
ok-planner's too.

**Which estates those are is read at invocation, never fixed at
vendoring.** A ceremony resolves the project root, checks for each
family's dot-directory, and works with what it finds — so a project that
adopts a family later is correct immediately, with no converge in
between.

**Every family exposes one ceremony contribution per verb**, at
`ceremony/{audit,document}.md` in the family directory,
materialized into the estate at `.ok-<name>/ceremony/`. That file is
where the family says what it contributes to each phase of that
ceremony: which corpus it exposes, what its auditors measure and how
their determinations read, where its confirmed gaps route, and what it
gives the documentation records and documents. The ceremony body carries the spine and
the phase order and **never** carries family-specific instructions —
which is what stops every project from paying, on every read, for the
instructions of families it does not have.

A ceremony that finds an estate present but its contribution absent reports a
conformance defect and carries on with the rest; it never improvises
what the family would have said.

Beside the phase headings, three conventional headings are allowed in
any contribution — `Requires`, `Vocabulary`, `Boundaries`.

Families expose no ceremony verbs of their own, exactly as they expose
no administration verbs. A family's own verbs, `/plan-sprint` among
them, are not ceremony verbs.

**The collision rule.** The project's skills directory is a flat
namespace, so vendored verb names collide by rule, never by accident:
a verb name claimed by more than one integrated family materializes
family-prefixed; unclaimed-by-others names keep their bare form.
Sibling-invocation references inside vendored skill bodies are
rewritten to the materialized names at vendoring time — and the rewrite
matches slash-command references only, never support-script paths.

The rule governs verbs **more than one family claims**. The two
ceremony verbs are claimed by none, so they vendor under their bare
names in every project, and no family may introduce a verb by any of
those names. The three family-prefixed audit verbs the rule used to
produce — `ok-planner-audit`, `ok-plumbline-audit`,
`ok-workspaces-audit` — are retired, along with the separate
periodic-audit verb `verify-corpus`; the suite's converge core removes
each on sight.
The certification verb `certify-work` is retired as well; a sprint
closes with sprint certification, ok-planner's `/converge sprint`.

## Discovery markers

Every marker the front door honors is documented here — the contract,
not the administrator's prompt, is where the convention lives:

- `ok-planner` — `.ok-planner/` at the project root.
- `ok-plumbline` — `.ok-plumbline/` at the project root; pre-migration
  markers: a root-level `.plumbline.json` (the pre-dot-directory config
  location), or `.claude/rules/plumbline-cheatsheet.md` (a materialized
  cheatsheet from an integration whose config was never migrated).
- `ok-workspaces` — `.ok-workspaces/` at the project root.

**The project root is marker-defined, never git-defined.** It is the
nearest ancestor of the working directory (the working directory
included) carrying any of the markers above; where none exists, it is
the working directory itself — a fresh install roots exactly where the
agent is operating. `.git` plays no part in the resolution: a project
may be a subfolder, submodule, or subproject of a repository whose own
root wants no estate, and a family that uses git for its mechanics
(ok-workspaces) still resolves its root by markers like every other.

Pre-migration markers are honored so a project carrying only an earlier
layout is still discovered and offered its migration. Absence is a
meaningful state — a bootstrap candidate or a recorded decline — not an
error.

## The ownership rule

The suite's machinery — the front door's administration and every
family's converge core — owns whole files and never edits a file a
human also edits. In particular: nothing in the suite touches
`.claude/rules/rules.md` or `CLAUDE.md`. Humans may reference family
cheatsheets from their own files; nothing in the suite depends on it.
Anything long-lived the suite maintains must live in a file it can
deterministically regenerate in full. One migration is the named
exception: ok-planner's move of `.ok-review/` to `.ok-planner/review/`
rewrites the stale path values in the owner's `review/config.json` and
`review/project.md`, and nothing else in them, as that family's
administration document lists.

Ownership also decides what converge may do silently: files the suite
owns — version-stamped, deterministically regenerable, the vendored
skill files included — are converged without prompting, and the suite's
own retired-layout content migrates mechanically under the
administration's own authorization; anything else at a path the suite
cares about (an estate laid out by an earlier version where the current
one would collide, a hand-written file where the suite would
materialize its own) is **presented for the owner's consent** —
migrate, adopt, replace, or leave — never silently overwritten.

Owner-declared configuration is written only as **transcription of
explicit answers**: the stack profile fields an owner confirmed in
conversation, and the hook entries an owner consented to in
`.claude/settings.json`. Writing a field or an entry the owner didn't
confirm breaches the rule; transcribing their answer does not.

The same consent rule covers **preexisting project context that
overlaps a family's territory**: guidance the project already carries
where the family would now govern (an alternate coding-style document
where ok-plumbline's cheatsheet rules, a hand-rolled worktree script
where ok-workspaces materializes its own, an ad-hoc planning directory
beside `.ok-planner/`). The administration identifies such context and
**proposes a conversion plan** — fold it into the family's declared
config, keep it as project-specific rules alongside the cheatsheet, or
retire it — for the owner to decide. Nothing overlapping is ignored,
and nothing is converted silently.

## Version stamps

Every materialized artifact records the suite version that wrote it —
read from the front-door plugin's manifest, the only manifest the suite
carries besides the conduct's — so version drift is mechanically
checkable by each core's diagnose mode. Diagnosis verifies fidelity
against the canonical copy for the carried version: stamp comparison as
the norm, byte-identity as the stricter check where exact derivation is
itself the guarantee. The gap between the carried version and a
project's stamps is the useful signal, not an error: projects run what
they were converged to, and updating the front door changes nothing
anywhere until each owner converges deliberately.

## Support scripts

A family that gives a project executable machinery owns the canonical
script and **materializes** it project-side — every script, not just
the leaf utilities: lint binaries, hook implementations, and diagnostic
tools all count. Exactly two classes legitimately run from the carried
payload: the administration process itself (diagnosis, bootstrap, and
converge run before or while the project copies are being written), and
read-only advisory verbs falling back with an announcement in their
output. The default home is inside the family's dot-directory
(`.ok-<name>/bin/<script>`), and a profile or config may declare
another path so existing consumers keep working (e.g. pointing
ok-workspaces' `runTag.path` at a script already wired into the
project's build). Materialized scripts are suite-owned whole files —
version-stamped, executable, overwritten wholesale on converge, never
hand-edited. A vendored executable is verified to run at materialization
time; one that cannot run is worse than none.

## Hooks: materialized implementations, consented wiring

Families ship **no family-root hooks**. A hook's implementation is
materialized into the family's estate (`.ok-<name>/hooks/<hook-name>`)
like any other support script — version-stamped, suite-owned,
overwritten on converge — and the harness reaches it through an entry
in the project's committed `.claude/settings.json` pointing at the
materialized copy (via `$CLAUDE_PROJECT_DIR`). Three properties follow,
and each is the point:

- **Per-project versions.** A project runs the hook it was converged
  to. Updating the front door changes nothing anywhere until each owner
  converges deliberately.
- **Development is safe.** Editing the payload cannot disturb a session
  running in another project, because no project session executes
  anything from the payload copy.
- **Wiring is owner-declared.** `.claude/settings.json` is the owner's
  file. A core's diagnose reports a missing or drifted entry as a
  `WIRING NEEDED` block carrying the exact entry and the exact consent
  command; the entry is written only by that command (the core's
  `wire-hooks` mode), on the owner's explicit yes — consented
  transcription, per the ownership rule. The front door carries one
  more consented entry of the same shape: `env.CLAUDE_CODE_ENABLE_TODO_TOOLS`,
  reported as its own `WIRING NEEDED` block and written only by its
  `wire-env` mode. Each block is its own consent.

Matcher discipline: every `SessionStart` entry carries the
`startup|clear|compact` matcher and never fires on resume; every entry
is scoped exactly as its family's block declares — a widened matcher is
diagnosed drift. A project with no estate has no wiring and no hook
fires — the same discovery rule the rest of this contract uses.

(The user-scoped conduct plugin runs its hooks directly from the plugin
root — deliberately machine-global, because the conduct belongs to the
user, not to any project. That is the user-scoped delivery split, not
an exception to this section: this section governs skill families.)

## Stack tailoring (detect → declare → materialize)

Families whose discipline varies by project stack (ok-workspaces)
follow this shape: a detection scan *proposes* a stack profile from
repo signals (compose files, `go.mod`, `package.json`, build targets);
the committed profile in the dot-directory is what's *authoritative*;
converge materializes rules and scripts *from the profile*. Detection
never silently decides — a scan/declaration mismatch is diagnosed
project drift, and reconciling the profile is the owner's act; the
administration stops and asks. Asking means a **conversational
walkthrough** per the family's administration document, not a file to
go edit: each judgment call is put to the owner in dialogue (a single
yes/no when detection is unambiguous) and the answers transcribed into
the committed profile verbatim — declaring is deciding, not typing.
Writing the profile as transcription of explicit answers does not
breach the ownership rule; writing any field the owner didn't confirm
does. A proposal file remains the fallback for owners who prefer
hand-editing.

## Repo-root machinery

The marketplace catalog, this contract document, the release tooling,
and the maintenance checks are repo-root machinery of the suite's own
monorepo — maintenance material, part of no plugin or family, and never
delivered to a consumer project. Nothing in any family may assume a
specific consumer project.

## The front door

`ok` is the suite's front door, its sole administrator, and the
mechanical check on this contract. Its payload carries every family;
the marketplace distributes only `ok` and the personal conduct, and the
conduct is never among anything's dependencies: installing the front
door never installs the conduct, and the front door never installs,
vendors, or offers it. `ok`'s one skill, `/ok`, is the whole
administration process: it updates the *installed* user-scoped plugins
to the marketplace's current versions, discovers integrated families by
the markers documented above, offers — one explicit consent question,
never silently — to bootstrap any carried family whose markers are
absent (all of them, a subset, or none: the owner's call), and
administers each integrated or consented family by driving its two
conventional files: run the converge core, follow the administration
document for judgment, present all hook wiring once for consent, and
close with the per-family table of carried version, project-stamped
version, and outcome. The bootstrap offer works because every converge
is an idempotent installer: it materializes a missing presence the same
way it repairs a drifted one, so the front door needs no per-family
install knowledge. `ok` itself materializes no project estate — it has
no dot-directory and is never "integrated"; it acts on whatever project
it is run in.

## Current conformance

- The **ceremony layer** — suite-owned, no family: two canonical
  bodies at `plugins/ok/ceremonies/{audit,document}/`,
  vendored under their bare names into every project, converge core at
  `plugins/ok/admin/converge` (diagnose / converge / wire-hooks /
  wire-env / resolve) and administration document at
  `plugins/ok/admin/ADMINISTRATION.md` carrying the retired-verb table,
  the task-tools env entry, and the missing-contribution remedy.
- `ok-planner` — fully conformant: dot-directory `.ok-planner/`,
  cheatsheet at `.claude/rules/ok-planner-cheatsheet.md`, vendored
  skills (`converge`, `discover-design`, `execute-tasks`, `ok-planner`,
  `ok-version`, `plan-sprint`, `sketch`, `triage-issues`), ceremony
  contributions at `.ok-planner/ceremony/`, the review estate at
  `.ok-planner/review/` (the directory note and `catalog/` suite-owned,
  `config.json` and `project.md` seeded once and the owner's after, and
  `runs/` records) with its mechanics at `.ok-planner/bin/review`, the
  session-start hook materialized at `.ok-planner/hooks/session-start`
  and wired by consent, converge core at `admin/converge`
  (diagnose / converge / wire-hooks / resolve) and administration document at
  `admin/ADMINISTRATION.md` carrying the cleanup offers and their
  drafts, the retired-layout migrations (pre-4.0 kinds,
  backlogs/specs → sprints, decision Proof sections, the `.ok-review/`
  move to `.ok-planner/review/`, the retired certification and
  project-owned sprint skills), and intake integrity.
- `ok-plumbline` — fully conformant: dot-directory `.ok-plumbline/`
  holding the project config at `.ok-plumbline/config.json`, the
  subject and practice collections at `.ok-plumbline/{subjects,practices}/`
  with their audits at `.ok-plumbline/audits/subjects/`, the authoring
  rules at `.ok-plumbline/practice-definitions.md`, cheatsheet
  at `.claude/rules/plumbline-cheatsheet.md`, vendored skills
  (`budget`, `events`, `explain`, `patterns`, `port`, `starter`,
  `suggest`, `version`), ceremony contributions at `.ok-plumbline/ceremony/`, the
  edit hook materialized at `.ok-plumbline/hooks/post-edit.js` and
  wired by consent (`PostToolUse` on every tool; the retired
  `pre-write`, `stop-review`, and `stop-instructions` hooks are removed
  on converge, and `wire-hooks` removes their entries), converge core at `admin/converge` (wrapping the family
  binary's diagnose / vendor / wire-hooks / resolve mechanics) and administration
  document at `admin/ADMINISTRATION.md` carrying the config-declaration
  walkthrough, overlap proposals, and collision handling. Its
  pre-migration markers are documented under "Discovery markers" above;
  the binary honors the root config path until converge migrates it (a
  mechanical relocation — contents untouched).
- `ok-workspaces` — fully conformant: dot-directory profile,
  materialized cheatsheet, vendored skills (`open`, `close`,
  `ok-workspaces`), ceremony contributions at `.ok-workspaces/ceremony/`, no
  hooks, converge core at `admin/converge` (diagnose / converge /
  resolve) and
  administration document at `admin/ADMINISTRATION.md` carrying the
  profile-declaration walkthrough and drift resolution, version stamps.
