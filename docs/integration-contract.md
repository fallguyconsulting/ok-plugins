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
projects as committed, vendored files, apart from the dashboard's
placed build (see Support scripts). A family is not a plugin:
nothing family-scoped installs machine-globally, the family is not
separately installable, and consumers meet it only through its vendored
presence in their project. The front door that carries the family is
a user-scoped plugin, and so is the personal conduct.

The family carries the design corpus, the docspecs and the surface
intent, the issue intake, the sprint and the review loop, the coding
standards and their lint, and the stack helpers and the reference
stack tool built from them. Each vendored skill carries its own
instructions whole; no skill reads a per-family contribution.

## The layers

The family's presence in a project consists of these layers, all
committed to the project:

1. **The estate: `.ok-planner/` at the project root.** The family's
   committed project-side estate: the project's configuration (the
   lint config at `.ok-planner/config.json` and the review loop's
   `config.json`) and review facts (`project.md`), the design corpus,
   the subjects and practices, the docspecs, the surface intent, the
   intake, the records, and the materialized standards, support
   scripts, and hook implementations. Its existence is the discovery marker —
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
   every session. Each is wholly owned and overwritten on true-up;
   drift is corrected by overwrite, never by merge.
3. **The vendored skills: the family's user-facing verbs, materialized
   into `.claude/skills/`.** Version-stamped whole files rendered from
   the carried payload, sibling references rewritten to the
   materialized names, under the collision rule below. Each
   vendored folder also carries the family's `LICENSE`, under the same
   scope preamble — never inside `SKILL.md`, whose body is context an
   agent pays for on every read. A trued-up project is
   self-contained: cloning it yields the working suite with nothing
   installed; only truing up to a newer version needs the front door.

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
true-up never writes over it in place. Its plan archives the
project's files under `.ok-planner/history/` first, then writes the
suite's copy: a destructive step, under the one consent below, that
takes only the files at the vendored paths. Sibling-invocation
references inside vendored skill bodies are rewritten to the materialized names at vendoring time — and the
rewrite matches slash-command references only, never support-script
paths.

## The administration files

The family exposes exactly two conventional administration files, and
the front door administers the family by driving them — never by
improvising:

- **The true-up core: `admin/true-up`.** Executable and
  deterministic. Modes: `diagnose` (read-only: it prints the plan, the
  input questions, and the wiring blocks, writing nothing; it exits 0
  when clean, 1 while the plan holds a step or wiring is pending, and
  3 when its only findings are input questions; missing hook wiring is
  drift), true-up (the default: it applies a plan that holds no
  destructive step, and refuses, writing nothing, where the plan holds
  one), `--go-ahead <plan id> [--drafts <dir>]` (it applies the plan
  diagnose printed under that id, on the owner's go-ahead), `show
  <path>` (the read-only diff of one rewrite the plan lists),
  `resolve <id> [--from <draft>]` (one answered input question,
  below), `amend <config path> --from <draft>` (the consented
  transcription of a check draft over `.ok-planner/config.json` or
  `.ok-planner/review/config.json`, below), `wire-hooks <group>` (the
  consented transcription of one hook group — `session-start`,
  `subagents`, or `lint`), `wire-env` (the consented transcription of
  the task-tools env entry), and `check-range <first> <last>` (a
  read-only check of a port range the owner names, writing nothing).
  `wire-hooks`, `wire-env`, and the `settings:` question's `resolve`
  are the ONLY paths that write `.claude/settings.json`, save the
  repoint of a retired script's path the ownership rule names. True-up
  is an idempotent installer: it materializes a missing presence the
  same way it repairs a drifted one, and a compliant project's plan
  holds no step.
- **The plan and the one consent.** Every true-up brings the whole
  estate to the layout the current skills read: it ports what they
  still use, archives under `.ok-planner/history/` what they no longer
  use, and removes only a file git or the suite can restore. Diagnose
  prints every step as one plan, `DRIFT: <step>` for a step that
  destroys nothing and `DESTRUCTIVE: <step>` for one that deletes a
  file, moves a file into the archive, or rewrites a file a person
  edited, with an optional `Show:` command printing what the step
  archives or the diff of its rewrite, an optional `Draft:` line naming
  a draft the step needs, and a closing `PLAN: <n> step(s), <d>
  destructive; plan <id>` line. Where the plan holds a destructive
  step, the front door shows the whole plan once and asks once: go
  ahead with all of it, or abort. Abort writes nothing, and the project
  stays on the suite version its stamps record. Go-ahead runs
  `--go-ahead <plan id>`, which recomputes the plan, refuses where its
  id differs, checks every step's refusal conditions before its first
  write, and then applies every step. A plan with no destructive step
  runs with no question. True-up never discards uncommitted work: a
  file it would remove that git cannot restore as it stands moves to
  the archive instead.
- **Input questions and `resolve`.** After the plan runs, each answer
  only the owner can give — a value such as the port range or the
  citation tags, a draft the owner approves, or a reword in a file the
  suite does not own — is printed as an `INPUT NEEDED (<layer>): <id>`
  block: what is there (`What:`), an optional `Draft:` line saying what
  an owner-approved draft must hold, the answer's effect (`Fix:`), and
  the exact command. An id is `<kind>:<path from the project root>`,
  stable across runs, and the command quotes it. `resolve <id> [--from
  <draft>]` re-reads the core's questions, refuses an id diagnose would
  not print now, and applies that one answer, checking a draft the way
  diagnose would. A draft changes only what its question names and
  keeps every other line and entry as it stands. A question for a
  project rule file the suite now carries (`rule-file:`) drafts a new,
  shorter project rule file holding only the project's own facts and
  repeating no sentence of the suite's text, then removes the old file;
  an empty draft only removes it. The front door presents every
  question and every check draft in one message, writes each draft to
  a scratch path outside the project, runs the command for each answer,
  and trues up again; a declined question is recorded as declined, not
  as drift. The core leaves no item for the owner to fix by hand.
- **The administration document: `admin/ADMINISTRATION.md`.** The
  judgment the core cannot encode, written for the administrator to
  follow: the plan and what each kind of content becomes, the drafts a
  plan step needs, the input questions and how to draft each answer,
  the retired-layout migrations, the retired-verb table,
  overlapping-context conversion proposals, the lint-config
  declaration walkthrough, and the migration check. Migration and
  repair judgment comes from this document, never improvised by the
  administrator.
- **The migration check.** After the plan runs, the front door checks
  each tracked project file the suite reads or governs (the project's
  configuration, the sprints' outside paths, the hook entries in
  `.claude/settings.json`, the project's own rules files, and every
  tracked `CLAUDE.md`) against the carried version, as the
  administration document says. It writes nothing. It sorts each
  finding by the ownership rule: the suite's retired-layout content is
  a step of the plan; a finding in the project's configuration goes to
  the owner as an `amend` draft in the same one message as the input
  questions; a finding in a rules file, a `CLAUDE.md`, or a settings
  entry outside the wiring gets a line in the report. The front door
  reports the project trued up only once the check leaves nothing
  pending.

The family exposes no administration verbs of its own: administration
is what the front door does, not a skill a project carries, and it is
always a user (or user-directed) action — nothing in the suite runs it
from a hook. Invoking the administrator is itself the authorization for
every step that destroys nothing; a plan that holds a destructive step
waits for the owner's one answer before any write, and transcription
into owner-declared configuration waits for the owner's answer to its
question.

## Discovery markers

Every marker the front door honors is documented here — the contract,
not the administrator's prompt, is where the convention lives:

- `.ok-planner/` at the project root — the planner's estate.
- Pre-migration markers an earlier release laid out: `.ok-plumbline/`
  or `.ok-workspaces/` at the project root, a root-level
  `.plumbline.json`, or `.claude/rules/plumbline-cheatsheet.md`. A
  project carrying only one of these is integrated, and true-up
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
family's true-up core — owns whole files and never edits a file a
human also edits. In particular: nothing in the suite touches
`.claude/rules/rules.md` or a `CLAUDE.md` the project wrote. Humans may reference the
suite's rules files from their own files; nothing in the suite depends
on it. Anything long-lived the suite maintains must live in a file it
can deterministically regenerate in full.

A few named migrations are the exception, each rewriting only the
stale text the suite's own changes left, as the family's administration
document lists:

- The move of `.ok-review/` to `.ok-planner/review/` rewrites the stale
  path values in the owner's `review/config.json` and
  `review/project.md`.
- The move of the `.ok-plumbline/` estate into `.ok-planner/` rewrites
  the `standards` and `checks` entries of the owner's
  `review/config.json` that name a moved path, the two citation
  `file_template` values of the owner's `.ok-planner/config.json` that
  name `.ok-plumbline/subjects/` or `.ok-plumbline/practices/`, and the
  lines of a live sprint's build prompt that name a moved path.
- The live-sprint rewrite brings current every line of a live sprint's
  "How to execute this sprint" and "Completion contract" sections
  that a released sprint template held and the carried template no
  longer holds, and leaves every other line of the sprint as written.
- The rewrite of retired estate entries repoints or removes each
  `ignore` entry of the owner's `.ok-planner/config.json` and removes
  each `exclude` entry of the owner's `review/config.json` that names
  the retired `.ok-plumbline/`, `.ok-workspaces/`, or `.ok-review/`
  estate, once that estate's migration no longer holds it.
- The repoint of retired suite scripts rewrites each line that names
  the retired lint, `catalog-toc`, or workspaces `run-tag` copy to
  name the suite's copy under `.ok-planner/bin/`, in any tracked
  project file but a record, a suite file, a rules file, and a
  `CLAUDE.md`. A line names a script behind a prefix that names the
  project root with certainty: a fixed root form, or git's top-level
  idiom (`$(git rev-parse --show-toplevel)/` or its backtick form)
  where true-up proves the project root is the repository's top. A
  line it cannot repoint, a line whose prefix may name the root but is
  not proven, and every caller of a retired `src-tag` or `port-block`,
  gets an issue in the owner's intake, filed through the intake
  module. After each retired script it removes, true-up's report says
  that a caller that builds the script's path at run time is outside
  what it sees.
- The back-out of the retired `/audit` and `/document` drops
  `hunt.extraction`, `hunt.flow_kinds`, and `hunt.flow_area_size` from
  the owner's `review/config.json`, deletes the provenance stamp line
  `/document` wrote at the top of a project document and leaves the
  rest of it, and removes the `docs/CLAUDE.md` `/document` wrote.

Each runs as a step of the plan, under the one consent. Nothing else
in those files changes.

Ownership also decides which steps wait for the owner's word. Files
the suite owns — version-stamped, deterministically regenerable, the
vendored skill files included — are trued up with no question, and so
is every other step that destroys nothing. A step that deletes a file,
moves a file into the archive, or rewrites a file a person edited (an
estate laid out by an earlier version, a hand-written file where the
suite would materialize its own, an owner file holding retired text)
appears in the plan marked destructive and waits for the **owner's one
consent** to the whole plan: go ahead with all of it, or abort. Nothing
a person wrote is silently overwritten, and nothing git cannot restore
is deleted: it moves to the archive.

The administrator writes owner-declared configuration only as
**transcription of explicit answers**: the lint-config fields an owner confirmed in
conversation, a check draft of `.ok-planner/config.json` or
`.ok-planner/review/config.json` the owner accepted, which the core's
`amend` mode writes, and the settings entries an owner consented to in
`.claude/settings.json`, save the repoint of a retired script's path
above. Writing a field or an entry the owner didn't confirm breaches
the rule; transcribing their answer does not.

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
they were trued up to, and updating the front door changes nothing
anywhere until each owner trues up deliberately.

## Support scripts

The family owns the canonical copy of every script it gives a project
and **materializes** it project-side — every script, not just the leaf
utilities: the lint, hook implementations, and diagnostic tools all
count. Exactly one class legitimately runs from the carried payload:
the administration process itself (diagnosis, bootstrap, and true-up
run before or while the project copies are being written). The scripts live in the estate: the task tracker at
`.ok-planner/bin/tasks`, the review loop's mechanics at
`.ok-planner/bin/review`, the issue intake's one module at
`.ok-planner/bin/issues`, the dashboard's service at
`.ok-planner/bin/dashboard`, the lint at `.ok-planner/bin/plumbline`, the
catalog TOC generator at `.ok-planner/bin/catalog-toc`, the stack
helpers (the tag generator at `.ok-planner/bin/run-tag`, the port
registry at `.ok-planner/bin/ports` with its block list at
`.ok-planner/bin/ports-blocklist`, the docker sweep at
`.ok-planner/bin/docker-sweep`, and the process-group helper at
`.ok-planner/bin/run-group`), the reference stack tool at
`.ok-planner/bin/stack`, and the
corpus surfacer at
`.ok-planner/scripts/surface-corpus`. Materialized scripts are
suite-owned whole files — version-stamped, executable, overwritten
wholesale on true-up, never hand-edited. A vendored executable is
verified to run at materialization time; one that cannot run is worse
than none.

The dashboard's page is the one materialized artifact git does not
track. The release builds it once and carries the bundle at the
family's `browser/dist/`. True-up places that bundle at
`.ok-planner/dashboard/`, stamped with the suite version, in the same
pass that writes the estate's other stamps, beside a suite-owned
`.ok-planner/dashboard/.gitignore` that ignores the folder. A project
serves the build its last true-up placed, so the page reads the
intake of the version the project is pinned to. Diagnose reports a
placed file that is missing or stale, and a file the carried build
does not name, as drift; true-up removes such a file.

## Hooks: materialized implementations, consented wiring

The family ships **no family-root hooks**. A hook's implementation is
materialized into the project like any other support script —
version-stamped, suite-owned, overwritten on true-up — and the harness
reaches it through an entry in the project's committed
`.claude/settings.json` pointing at the materialized copy (via
`$CLAUDE_PROJECT_DIR`). The session-start hook and the lint's edit hook
live at `.ok-planner/hooks/session-start` and
`.ok-planner/hooks/post-edit.js`; the subagent-model hook and the
subagent-batching hook live at `.claude/hooks/ok-agent-model` and
`.claude/hooks/ok-subagent-batching`. Three properties follow, and each
is the point:

- **Per-project versions.** A project runs the hook it was trued up
  to. Updating the front door changes nothing anywhere until each owner
  trues up deliberately.
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
files: run the true-up core, follow the administration document for
judgment, show the plan once and ask once to go ahead or abort where it
holds a destructive step, present every input question and every
wiring block once, and close with one table row of carried version,
project-stamped version, and outcome. The bootstrap offer works because
every true-up is an idempotent installer: it materializes a missing
presence the same way it repairs a drifted one, so the front door needs
no install knowledge of its own. `ok` itself materializes no project
estate — it has no dot-directory and is never "integrated"; it acts on
whatever project it is run in.

| family | payload | estate | administration files |
|---|---|---|---|
| `ok-planner` | `plugins/ok/families/ok-planner` | `.ok-planner/` | `admin/true-up`, `admin/ADMINISTRATION.md` |

## Current conformance

- `ok-planner` — fully conformant: estate `.ok-planner/`; rules files
  `.claude/rules/ok-planner-cheatsheet.md`, `ok-cheatsheet.md`,
  `plumbline-cheatsheet.md`, `plumbline-coding.md`, and the import file
  `ok-concepts.md`; vendored skills (`converge`, `dashboard`,
  `discover-design`, `ok-version`, `plan-sprint`, `sketch`,
  `triage-issues`) and agent profiles (`ok-haiku`, `ok-opus`,
  `ok-review`); the lint config at `.ok-planner/config.json`;
  the subject and practice collections at
  `.ok-planner/{subjects,practices}/` with their authoring rules at
  `.ok-planner/practice-definitions.md`; the docspecs at
  `.ok-planner/docspec/` with their index at `.ok-planner/docspec.md`;
  the surface intent at `.ok-planner/surface/surface.md`; the standards at
  `.ok-planner/docs/{events,technical-writing}.md`; the review estate at
  `.ok-planner/review/` (the directory note and `catalog/` suite-owned,
  `config.json` and `project.md` seeded once and the project's after, and
  `runs/` records); the issue intake at `.ok-planner/issues.jsonl` and
  its archive at `.ok-planner/history/issues.jsonl`, written only
  through `.ok-planner/bin/issues`; the support scripts and hooks
  listed above, `.ok-planner/bin/issues` and `.ok-planner/bin/dashboard`
  among them, each hook group wired by consent; the dashboard's build
  placed at `.ok-planner/dashboard/` and ignored by git through its
  suite-owned `.gitignore`; true-up core at `admin/true-up`
  (diagnose / true-up / `--go-ahead` / show / wire-hooks / wire-env /
  resolve / amend / check-range) and
  administration document at `admin/ADMINISTRATION.md` carrying the
  plan and its one consent, the input questions and their drafts, the
  retired-verb table, the retired-layout migrations (pre-4.0 kinds,
  backlogs/specs → sprints, decision Proof sections, the `.ok-review/`
  move to `.ok-planner/review/`, the `.ok-plumbline/` estate's move
  into `.ok-planner/`, the `.ok-workspaces/` estate's retirement, the
  retired ceremony layer and certification verbs, the back-out of
  `/audit` and `/document`, and the markdown intake's and the pre-v9
  event log's conversion into records), the migration check, and
  intake integrity.
