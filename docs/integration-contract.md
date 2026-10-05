# The ok Suite Integration Contract

Normative. The suite vendors one family, ok-planner, into every
consumer project, and the front door — the `ok` plugin, the suite's
sole administrator — administers that family by driving the
conventional administration files this contract defines. Family
knowledge lives in the family's own directory at those files, so a
change to what the family vendors is a change to the family, never to
the administrator. A family the front door cannot administer through
these conventions has conformed wrong. The user-scoped plugins — the
front door itself and the personal conduct — never integrate; this
contract does not govern their presence on a machine.

## The vendored family

Everything the suite vendors into a project comes from one **skill
family**, ok-planner: a self-contained directory of skills, agent
profiles, templates, standards, support scripts, hooks, and
administration files, carried whole as payload inside the front-door
plugin at `plugins/ok/families/ok-planner` and delivered into consumer
projects as committed, vendored files. A family is not a plugin:
nothing family-scoped installs machine-globally, the family is not
separately installable, and consumers meet it only through its vendored
presence in their project. The front door that carries the family is
a user-scoped plugin, and so is the personal conduct.

The family carries the design corpus and its audit, the issue intake,
the sprint and the review loop, the coding standards and their lint,
the run tag and the port reader, and the two periodic verbs `/audit`
and `/document`. Each vendored skill carries its own instructions
whole; no skill reads a per-family contribution.

## The layers

The family's presence in a project consists of these layers, all
committed to the project:

1. **The estate: `.ok-planner/` at the project root.** The family's
   committed project-side estate: the owner's configuration (the lint
   config at `.ok-planner/config.json`, the review loop's `config.json`
   and `project.md`), the design corpus, the subjects and practices,
   the intake, the records, the materialized standards, support
   scripts, and hook implementations, and the machine-written
   determination records. Its existence is the discovery marker —
   "does this project use the suite?" is a filesystem check, never an
   inference. The family's `LICENSE` is materialized at the estate
   root, so the license text rides with every vendored copy of the
   family — under the scope preamble described below.
2. **The suite-owned rules files under `.claude/rules/`.** The small,
   stable, always-in-context rules layer: the planner cheatsheet
   (`ok-planner-cheatsheet.md`), the suite cheatsheet
   (`ok-cheatsheet.md`), the coding standards (`plumbline-cheatsheet.md`
   and `plumbline-coding.md`), and the import file `ok-concepts.md`,
   whose one fixed line makes the harness load the concept index into
   every session. Each is wholly owned and overwritten on converge;
   drift is corrected by overwrite, never by merge.
3. **The vendored skills: the family's user-facing verbs, materialized
   into `.claude/skills/`.** Version-stamped whole files rendered from
   the carried payload, sibling references rewritten to the
   materialized names, under the collision rule below. `/audit` and
   `/document` vendor here beside the family's other verbs. Each
   vendored folder also carries the family's `LICENSE`, under the same
   scope preamble — never inside `SKILL.md`, whose body is context an
   agent pays for on every read. A converged project is
   self-contained: cloning it yields the working suite with nothing
   installed; only converging to a newer version needs the front door.

   The family also vendors **agent profiles** into `.claude/agents/`:
   version-stamped `ok-<profile>.md` files whose frontmatter pins a
   subagent's model and effort, beside the family's `LICENSE` under the
   same scope preamble.

**Every materialized `LICENSE` opens with a scope preamble** — the
licensor (Fall Guy LLC) and, in plain sentences, which files in that
directory the grant covers. Every destination sits among content the
project owns: the estate root holds the project's configuration and
records, `.claude/skills/` holds skills the project wrote itself, and
`.claude/agents/` holds the project's own agents. A bare license file
in any of those places reads as a grant over the project's own work,
which is why the preamble is part of the contract and not a nicety.
The Apache text below it is verbatim and never edited.

4. **The hook wiring: consented entries in `.claude/settings.json`.**
   Hooks execute from the project's materialized copies, reached
   through entries in the project's committed harness settings: the
   session-start hook, the lint's edit hook, the subagent-model hook,
   and the subagent-batching hook — see "Hooks" below.

**The collision rule.** A path the family vendors to that already
holds a file whose suite stamp is missing is the project's own, and
converge never writes over it. Converge reports it as a `collision:`
cleanup offer instead, whose fix deletes only the files its block
lists. Sibling-invocation references inside vendored skill bodies are
rewritten to the materialized names at vendoring time — and the
rewrite matches slash-command references only, never support-script
paths.

## The administration files

The family exposes exactly two conventional administration files, and
the front door administers the family by driving them — never by
improvising:

- **The converge core: `admin/converge`.** Executable and
  deterministic. Modes: `diagnose` (read-only comparison of reality
  against declaration — project drift and version drift — writing
  nothing; it exits 0 when clean, 1 on drift, and 3 when its only
  findings are cleanup offers awaiting the owner; missing hook wiring
  is drift), converge (the default: materialization of the suite-owned
  layer from committed declarations and the payload's canonical
  copies), `wire-hooks <group>` (the consented transcription of one
  hook group — `session-start`, `subagents`, or `lint`), `wire-env`
  (the consented transcription of the task-tools env entry), and
  `resolve <id>` (the consented cleanup path, below). `wire-hooks`,
  `wire-env`, and the `settings:` offer's `resolve` are the ONLY paths
  that write `.claude/settings.json`. Converge is an idempotent
  installer: it materializes a missing presence the same way it
  repairs a drifted one, and a compliant project is a silent no-op.
- **Cleanup offers and `resolve`.** Every item the core cannot settle
  alone — a collision, a project-owned file the suite now covers, a
  two-location conflict, an owner file whose words must change — is
  printed by diagnose and converge as a `CLEANUP OFFERED (<layer>): <id>`
  block: what is there (`What:`), the fix (`Fix:`, or one
  `Choice <name>:` line per choice), the recommended answer, an
  optional `Show:` command, an optional `Draft:` line saying what an
  owner-approved draft must hold, and the exact consent command. An id
  is `<kind>:<path from the project root>`, stable across runs, and
  the consent command quotes it. The core offers a collision under the
  collision rule above, and the project's own files inside a retired
  verb's folder as `retired-verb:`; each fix deletes only the files
  its block lists. A block may carry an `Uncommitted:` line, naming
  paths with uncommitted or staged-only changes, or a
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
  deletes it. The front door presents every block in one question,
  writes each draft to a scratch path outside the project, runs the
  command for each accepted item, and converges again; a declined item
  is recorded as declined, not as drift. The core leaves no item for
  the owner to fix by hand.
- **The administration document: `admin/ADMINISTRATION.md`.** The
  judgment the core cannot encode, written for the administrator to
  follow: the cleanup offers and how to draft each one that needs the
  owner's words, the retired-layout migrations, the retired-verb
  table, overlapping-context conversion proposals, and the lint-config
  declaration walkthrough. Migration and repair judgment comes from
  this document, never improvised by the administrator.

The family exposes no administration verbs of its own: administration
is what the front door does, not a skill a project carries, and it is
always a user (or user-directed) action — nothing in the suite runs it
from a hook. Invoking the administrator is itself the authorization to
migrate the suite's own retired layouts; consent is reserved for
genuine collisions, for content the suite does not own, and for
transcription into owner-declared configuration.

## Discovery markers

Every marker the front door honors is documented here — the contract,
not the administrator's prompt, is where the convention lives:

- `.ok-planner/` at the project root — the planner's estate.
- Pre-migration markers an earlier release laid out: `.ok-plumbline/`
  or `.ok-workspaces/` at the project root, a root-level
  `.plumbline.json`, or `.claude/rules/plumbline-cheatsheet.md`. A
  project carrying only one of these is integrated, and converge
  migrates its retired layout into `.ok-planner/`.

**The project root is marker-defined, never git-defined.** It is the
nearest ancestor of the working directory (the working directory
included) carrying any of the markers above; where none exists, it is
the working directory itself — a fresh install roots exactly where the
agent is operating. `.git` plays no part in the resolution: a project
may be a subfolder, submodule, or subproject of a repository whose own
root wants no estate.

Absence of every marker is a meaningful state — a bootstrap candidate
or a recorded decline — not an error.

## The ownership rule

The suite's machinery — the front door's administration and the
family's converge core — owns whole files and never edits a file a
human also edits. In particular: nothing in the suite touches
`.claude/rules/rules.md` or `CLAUDE.md`. Humans may reference the
suite's rules files from their own files; nothing in the suite depends
on it. Anything long-lived the suite maintains must live in a file it
can deterministically regenerate in full.

A few named migrations are the exception, each rewriting only the
stale paths the suite's own moves left, as the family's administration
document lists:

- The move of `.ok-review/` to `.ok-planner/review/` rewrites the stale
  path values in the owner's `review/config.json` and
  `review/project.md`.
- The move of the `.ok-plumbline/` estate into `.ok-planner/` rewrites
  the `standards` and `checks` entries of the owner's
  `review/config.json` that name a moved path, the two citation
  `file_template` values of the owner's `.ok-planner/config.json` that
  name `.ok-plumbline/subjects/` or `.ok-plumbline/practices/`, and the
  fixed boilerplate lines of a live sprint that name a moved path.

Nothing else in those files changes.

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
explicit answers**: the lint-config fields an owner confirmed in
conversation, and the settings entries an owner consented to in
`.claude/settings.json`. Writing a field or an entry the owner didn't
confirm breaches the rule; transcribing their answer does not.

The same consent rule covers **preexisting project context that
overlaps the family's territory**: guidance the project already carries
where the family would now govern (an alternate coding-style document
where the coding standards rule, an ad-hoc planning directory beside
`.ok-planner/`). The administration identifies such context and
**proposes a conversion plan** — fold it into the family's declared
config, keep it as project-specific rules alongside the suite's rules
files, or retire it — for the owner to decide. Nothing overlapping is
ignored, and nothing is converted silently.

## Version stamps

Every materialized artifact records the suite version that wrote it —
read from the front-door plugin's manifest, the only manifest the suite
carries besides the conduct's — so version drift is mechanically
checkable by the core's diagnose mode. Diagnosis verifies fidelity
against the canonical copy for the carried version: stamp comparison as
the norm, byte-identity as the stricter check where exact derivation is
itself the guarantee. The gap between the carried version and a
project's stamps is the useful signal, not an error: projects run what
they were converged to, and updating the front door changes nothing
anywhere until each owner converges deliberately.

## Support scripts

The family owns the canonical copy of every script it gives a project
and **materializes** it project-side — every script, not just the leaf
utilities: the lint, hook implementations, and diagnostic tools all
count. Exactly one class legitimately runs from the carried payload:
the administration process itself (diagnosis, bootstrap, and converge
run before or while the project copies are being written). The scripts live in the estate: the task tracker at
`.ok-planner/bin/tasks`, the review loop's mechanics at
`.ok-planner/bin/review`, the lint at `.ok-planner/bin/plumbline`, the
catalog TOC generator at `.ok-planner/bin/catalog-toc`, the run tag at
`.ok-planner/bin/run-tag`, the port reader at
`.ok-planner/bin/port-block`, and the surface helper at
`.ok-planner/scripts/surface-corpus`. Materialized scripts are
suite-owned whole files — version-stamped, executable, overwritten
wholesale on converge, never hand-edited. A vendored executable is
verified to run at materialization time; one that cannot run is worse
than none.

## Hooks: materialized implementations, consented wiring

The family ships **no family-root hooks**. A hook's implementation is
materialized into the project like any other support script —
version-stamped, suite-owned, overwritten on converge — and the harness
reaches it through an entry in the project's committed
`.claude/settings.json` pointing at the materialized copy (via
`$CLAUDE_PROJECT_DIR`). The session-start hook and the lint's edit hook
live at `.ok-planner/hooks/session-start` and
`.ok-planner/hooks/post-edit.js`; the subagent-model hook and the
subagent-batching hook live at `.claude/hooks/ok-agent-model` and
`.claude/hooks/ok-subagent-batching`. Three properties follow, and each
is the point:

- **Per-project versions.** A project runs the hook it was converged
  to. Updating the front door changes nothing anywhere until each owner
  converges deliberately.
- **Development is safe.** Editing the payload cannot disturb a session
  running in another project, because no project session executes
  anything from the payload copy.
- **Wiring is owner-declared.** `.claude/settings.json` is the owner's
  file. The core's diagnose reports each hook group with a missing or
  drifted entry as a `WIRING NEEDED` block carrying the exact entries
  and the exact consent command; the entries are written only by that
  command (the core's `wire-hooks <group>` mode), on the owner's
  explicit yes — consented transcription, per the ownership rule. The
  task-tools env entry, `env.CLAUDE_CODE_ENABLE_TODO_TOOLS`, has the
  same shape: its own `WIRING NEEDED` block, written only by the core's
  `wire-env` mode. Each block is its own consent.

Matcher discipline: every `SessionStart` entry carries the
`startup|clear|compact` matcher and never fires on resume; every entry
is scoped exactly as its group's block declares — a widened matcher is
diagnosed drift. A project with no estate has no wiring and no hook
fires — the same discovery rule the rest of this contract uses.

(The user-scoped conduct plugin runs its hooks directly from the plugin
root — deliberately machine-global, because the conduct belongs to the
user, not to any project. That is the user-scoped delivery split, not
an exception to this section: this section governs the vendored
family.)

## Repo-root machinery

The marketplace catalog, this contract document, the release tooling,
and the maintenance checks are repo-root machinery of the suite's own
monorepo — maintenance material, part of no plugin or family, and never
delivered to a consumer project. Nothing in the family may assume a
specific consumer project.

## The front door

`ok` is the suite's front door, its sole administrator, and the
mechanical check on this contract. Its payload carries the family; the
marketplace distributes `ok` and the personal conduct, and the conduct
is never among anything's dependencies: installing the front door never
installs the conduct, and the front door never installs, vendors, or
offers it. `ok`'s one skill, `/ok`, is the whole administration
process: it updates the *installed* user-scoped plugins to the
marketplace's current versions, discovers whether the project
integrates ok-planner by the markers documented above, offers — one
explicit consent question, never silently — to bootstrap it where every
marker is absent, and administers it by driving its two conventional
files: run the converge core, follow the administration document for
judgment, present every cleanup offer and every wiring block once for
consent, and close with one table row of carried version,
project-stamped version, and outcome. The bootstrap offer works because
every converge is an idempotent installer: it materializes a missing
presence the same way it repairs a drifted one, so the front door needs
no install knowledge of its own. `ok` itself materializes no project
estate — it has no dot-directory and is never "integrated"; it acts on
whatever project it is run in.

| family | payload | estate | administration files |
|---|---|---|---|
| `ok-planner` | `plugins/ok/families/ok-planner` | `.ok-planner/` | `admin/converge`, `admin/ADMINISTRATION.md` |

## Current conformance

- `ok-planner` — fully conformant: estate `.ok-planner/`; rules files
  `.claude/rules/ok-planner-cheatsheet.md`, `ok-cheatsheet.md`,
  `plumbline-cheatsheet.md`, `plumbline-coding.md`, and the import file
  `ok-concepts.md`; vendored skills (`audit`, `converge`,
  `discover-design`, `document`, `ok-version`, `plan-sprint`, `sketch`,
  `triage-issues`) and agent profiles (`ok-audit`, `ok-haiku`,
  `ok-opus`, `ok-review`); the lint config at `.ok-planner/config.json`;
  the subject and practice collections at
  `.ok-planner/{subjects,practices}/` with their audits at
  `.ok-planner/audits/subjects/` and their authoring rules at
  `.ok-planner/practice-definitions.md`; the standards at
  `.ok-planner/docs/{events,technical-writing}.md`; the review estate at
  `.ok-planner/review/` (the directory note and `catalog/` suite-owned,
  `config.json` and `project.md` seeded once and the owner's after, and
  `runs/` records); the support scripts and hooks listed above, each
  hook group wired by consent; converge core at `admin/converge`
  (diagnose / converge / wire-hooks / wire-env / resolve) and
  administration document at `admin/ADMINISTRATION.md` carrying the
  cleanup offers and their drafts, the retired-verb table, the
  retired-layout migrations (pre-4.0 kinds, backlogs/specs → sprints,
  decision Proof sections, the `.ok-review/` move to
  `.ok-planner/review/`, the `.ok-plumbline/` estate's move into
  `.ok-planner/`, the `.ok-workspaces/` estate's retirement, the
  retired ceremony layer and certification verbs), and intake
  integrity.
