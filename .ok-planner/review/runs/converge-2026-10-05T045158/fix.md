## Fix a group of defects

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

The documents the release regenerates are out of scope. They are
every file at a target a declared document type names under
`.ok-planner/surface/documents/` (a folder target covers the folder)
and everything under `.ok-planner/documentation/`. `/document`
rewrites them whole at the next release. Do not edit one, do not read
one to learn the tree, and do not file a finding on a sentence in one:
a sentence there that describes what the change removed is not a
defect. Rule files under `.claude/rules/` and infrastructure files
are not such documents.

Skill text is code. Skill text is a prompt an agent session runs in
the project, whether the product ships it or the project keeps it for
its own work: a skill, a rule, or an agent profile, with the prompts
and shared blocks it reads and the scripts and tools it calls. Review
skill text and fix it as code, under the same rules: the fixer picks
the wording; where the code and the design corpus do not decide the
fix, it builds the reading it judges best and records a question; it
declines a fix that changes what a user across a release boundary
observes. Other prose, such as documentation, a README, or a guide,
is in review only where the sprint this run certifies added or
changed it (`.ok-planner/bin/review changed` lists it); there it is
reviewed and fixed as skill text is. Anywhere else, and in a run
that certifies no sprint, file no finding on it and edit none of it.

The run fixes a clear defect in every file the project owns, wherever
the file sits, under `.claude/` and `.ok-planner/` too: its code, and
its own scripts, skills, rules, agent profiles, hooks, and other
tooling, with prose other than skill text in review only as the prose
scope rule allows. It leaves five kinds of file alone, and no agent
of the run edits one:

- the design corpus and the coding standards (`corpus`): they change
  only through a sprint's deltas, so a defect whose fix lies there
  goes to the intake as a judgment issue;
- a file the suite owns (`suite`): the next `/ok` overwrites a local
  edit, so its harm goes to the intake as an upstream issue;
- an owner's declaration (`declaration`): the project's
  configuration, its harness settings, its review facts, its release
  boundaries, its surface intent, and its document types; a defect
  whose fix lies there goes to the intake as a judgment issue;
- a record (`record`): a sprint, an issue, an audit, an experiment, a
  run ledger, or anything archived; it changes only through the act
  that owns it, and the run files nothing about it;
- a document the release regenerates: a file at a target a declared
  document type under `.ok-planner/surface/documents/` names (a
  folder target covers the folder), or a file that opens with the
  provenance stamp `/document` writes; it is left to `/document`, and
  the run files nothing about it.

`.ok-planner/bin/review owner <path>...` prints one kind per path:
`project`, `suite`, `corpus`, `declaration`, or `record`. A `project`
file is the run's to fix, unless it is a document the release
regenerates, which the command does not detect.

Your brief lists defects from the run's defect list, grouped because their fixes touch the same files. You fix each one at its root, in every file the fix reaches, in this task. A verifier reads your change next, against each defect and against the accept list; so make each fix complete and make it change nothing else.

You do not hunt. The defects in your brief are your whole job.

### Read

1. Each defect in your brief: `tasks item list --pool defects --key gate --state fixing --json`, the items your brief names. Where a defect has a `note` from a verifier, a fix of yours was sent back: the note says why, and your fix answers it.
2. The code at each site, whole functions, and every caller or reader your fix will reach: `rg` for the symbol and every literal that restates it; the LSP (`ToolSearch("select:LSP")`) for references.

### Fix

For each defect:

1. Confirm it is real and covered by the accept list, pasted below, or, for a defect whose `source` is `sprint`, by the sprint class its `entry` names. A defect from a skill surface is fixed by making the skill text, or the script or tool it calls, deliver what the story promises. A defect from a `stuck` story is fixed only by making the message or the help text at the place the defect names tell the user what went wrong or what to do next; a change to what a page or a verb offers is not yours: decline it and record a question. A defect you find is not real, or whose harm the list leaves standing, is declined: `tasks item set <id> --state declined --note "<why, with the code that shows it>"`. A defect that is the same flaw as another in your brief, or as another on the list, is a duplicate: `tasks item set <id> --state duplicate --note "<the defect id it duplicates>"`.
2. Fix it where the flaw is, not where it shows. Where the fix changes what a function takes, returns, or raises, bring every caller along in this task. Where the fix reaches a file another open task holds (`.ok-planner/bin/review held --task <your task> <paths>` exits 2), add those paths to the defect's files so the next round groups it with them (`tasks item set <id> --field 'files=[<its files and the new paths>]'`), finish every other defect, then close `partial` with a result that starts `outside files: <the paths>`.
3. Change nothing the defect does not need: no rename, no reshaping, no fix of something you happened to notice.
4. `tasks item set <id> --state fixed --note "<what you changed, where, and why that removes the harm; every file you changed>"`.

Where you notice a defect that is not in your brief, leave it and record it once: `tasks item add --pool calls --key gate --field kind=noticed --field file=<the file> --body "<the site; the harm, in an accept entry's terms>" --task <task>`. The next run's hunt reads code, not this note; the note reaches the owner.

Where the code and the design corpus do not decide what the fix should be, and reasonable owners would choose differently, build the reading you judge best and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=<the file> --body "<the site; the choice; the readings, and the one you built>" --task <task>`.

### Release boundaries and a sprint's rulings

A fix keeps every user across a release boundary working. Read `.ok-planner/release-boundaries.md` where it exists.

A release boundary separates code that ships in one release from a
user that does not update in the same step. The project declares its
boundaries in `.ok-planner/release-boundaries.md`, each with who is
across it, what crosses it, and where in the tree to look. A boundary
need not be part of the declared public surface.

One boundary applies to every project and is never declared:

  Stored state. Data an earlier release wrote and a later release
  reads or writes: database rows and columns, files and objects,
  configuration files a running deployment holds, messages waiting in
  a queue. The data does not update when the code does.

A behavior change is something a user outside the changed code can
observe: the inputs it accepts or refuses, what it returns, what it
raises, the rows, files, messages, or events it writes, their order,
the state it leaves, and the format of its output. A change no user
can observe is not a behavior change.

A user is a site that depends on the behavior: a caller or reference,
code that reads the same stored data or configuration, or a user
across a release boundary. A user that passes the change on to its
own users is a behavior change in turn; follow it until the change
stops spreading.

This run certifies the sprint at .ok-planner/sprints/2026-10-05-issue-dashboard.md, or no sprint where that reads `none`. Where it names one, read its implementation notes: a fix keeps every `preserve` behavior unchanged for its users across the boundary and every `migrate` behavior's migration, as the rulings below define them.

Each behavior change in a sprint's implementation notes carries one
ruling:

- `rewrite`: every user ships in the same release, and the sprint
  changes each user that must change. The code planner sets it.
- `preserve`: users across the boundary observe no change. The change
  adds beside the behavior and alters nothing they reach.
- `migrate: <how>`: the behavior changes, and `<how>` states how old
  users keep working or the refusal they get: both shapes accepted,
  stored data converted, a minimum version named and refused below it.
- `rewrite across <boundary>: <reason>`: the owner accepts that users
  across the boundary break, for the reason given.

The code planner sets `rewrite`, and sets `preserve` or `migrate:
<how>` where the rules, the corpus, or a ruling the owner already gave
determine it, marking it `(call)` after the ruling. Within a major
version a change across a boundary is `preserve` or `migrate` with both
shapes accepted; a migration that refuses an older part is a break. A
behavior change that meets the owner question test above is written
`owner (<boundary>)` until the owner rules. Only the owner sets
`rewrite across <boundary>`.

A fix that must change a behavior a user across a boundary observes, where no ruling allows it, is declined with a question recorded: that change is the owner's to rule on.

### The coding rules

Follow `.claude/rules/plumbline-coding.md` rules 1, 3, 4, 6, 7, and
9, and rule 5 before you delete anything, together with
`.claude/rules/plumbline-cheatsheet.md` and
`.ok-planner/docs/events.md`, on every line you write: enumerate
before you edit, walk every exit of a function that holds state,
one state change in one transaction, import never copy, and before
you delete a route, verb, column writer, helper, or branch, list
what it alone provides and record a fork where the deletion
removes the only writer or the only site that realizes something
the corpus still claims. Rule 2, copy the sibling's shape, does not
bind you, and rule 9.4's sibling citation is void with it, so your
note carries the enumeration alone. The standard fixes the shape of
a handler, an emission, a teardown, a lock, or a retry; where the
standard leaves a choice open, keep the shape the file you are
editing already uses for that job, or choose and record a call
where it has none. Never read a sibling file to decide a shape. The
rules govern what you write; they do not send you sweeping for
anything your brief marks as another loop's. To learn what a shell
construct does, test the construct alone, with throwaway functions,
in the foreground.

Add no test, edit no test, run no test, and read no test as evidence.
Run the project's checks on every file you changed, in the foreground, and close with no process of your own still running. Leave the tree runnable.

### Rules

- Never destroy uncommitted work. Stage every path whose content you changed, by name (`git add <paths>`). Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Fix a bad edit forward by editing again. Do not commit.
- Edit prose only where the prose scope rule above puts it in review. Edit no file the fix line rule above leaves alone, per the project's facts below. Where a defect's fix lies only in such a file, decline the defect with a note naming the file and the kind `.ok-planner/bin/review owner` prints for it, and record it once as `noticed` with that file, so the owner list routes it.

### Close

`tasks close <task> --outcome done --staged <every path you changed> --sites <every site you changed, path[:locator]> --result "<n> fixed, <n> declined, <n> duplicate: <defect ids by outcome>"`. A group you could not finish closes `partial` with where you stopped and what is staged.

### The accept list

#### .ok-planner/review/catalog/accept.md

# The accept list

The bug families fix a site only when an entry below covers it. Every row of the `failure-paths` and `input-state` catalogs, and every unit a bug-family agent records, is read through this list. A site the list does not cover is not a defect for this run, whatever a row's plain reading says: list it `=standing` in your close and record nothing for it.

Each entry names a harm and the sites that can cause it. Judge the harm, never the shape: a site that has a row's shape and cannot cause an entry's harm stands.

| # | Accept when | The sites that can cause it |
|---|---|---|
| A1 | **Stored state can end half-changed.** A crash, an error, or a second writer acting between two steps of one change leaves stored state that no complete run would produce. | Every operation that changes stored state (database rows, files, queue positions, remote resources) in more than one step. Every check-then-write. |
| A2 | **A write lands on the wrong target.** A delete, an overwrite, or a write reaches something it should not, because of input (hostile or not), because a read could not tell "missing" from "unreadable", or because cleanup reaches something it did not create. A value that only builds a link, a read, or a message is not this entry's. | Every delete, overwrite, and write, and each value that picks its target. |
| A3 | **An end user can break the product.** On a system deployed and configured correctly, an action a user can take through the public surface (a page, a form, a CLI verb, an API route), or a developer or operator can take through a script the project ships for its developers or operators, as `.ok-planner/review/project.md` lists them, gives a wrong result, a stall, a crash, or an error that does not tell the user what they did wrong, or leaves the product in a state where later use fails. A user's mistakes count: a wrong value, a missing field, a repeated click, steps out of order, two sessions at once. A dependency down for a moment (a network blip, a 503 reply, a broker restart) is part of a system running correctly; the disk, a permission, or the operating system failing underneath is not, and a failure that needs one of those first is not this entry's unless another entry also holds. | Every element of the public surface and every input it takes, as the project's surface record lists them; every script the project ships for its developers or operators, as `.ok-planner/review/project.md` lists them, and every input it takes; and every failure the drive records. |
| A4 | **A unit of work can end with no record.** A request, a command, a job, a message handler, or a process can end without recording how it ended and why. | Every entry point that starts a unit of work. |
| A5 | **Ongoing work stops or wears down while the system still looks healthy.** Work the system relies on happening again and again (a background loop, a scheduled job, a queue consumer, a watcher) stops for good, stops making progress, or stops recording its state: one error ends the loop, one bad item blocks the queue forever, a wait never returns. A long-running process that holds a file, a connection, or a thread on a routine path and never releases it is the same harm. | Every piece of work that repeats or runs without end, and every acquire on a routine path of a long-running process. |
| A6 | **Access is wrong.** A check that decides who a caller is, or what the caller may do, admits a caller it should refuse; or a removal of access fails to take effect. A certificate or token check that accepts a foreign one, a permission check skipped on one path, and a revocation that never runs are this entry's. | Every authentication, authorization, certificate, and token check, and every place that grants or revokes access. |
| A7 | **Accepted data is lost, skipped, or doubled.** Data the system has accepted from a sender never reaches its place of rest, or reaches it twice, however rare the trigger. A temporary failure treated as permanent that drops the item, and a failed commit or rewind read as a success that skips items, are this entry's. | Every step between accepting data and storing it: acknowledgments, retry decisions, position commits and rewinds, and duplicate checks. |
| A8 | **The code breaks a rule the project states, and the rule decides the fix.** A rule from one of five sources leaves one compliant form for the site, and the code has another: a rule in `.claude/rules/plumbline-coding.md`, where the project carries it; a rule in a code-rule file that `.ok-planner/review/project.md` lists under `## Code rules`; a commitment of a live artifact under `.ok-planner/design/`; a rule of the events standard at `.ok-planner/docs/events.md`; or a ruled practice under `.ok-planner/practices/` whose condition covers the site. A site where two compliant forms remain is a question, not this entry's. | Every site a rule in `plumbline-coding.md`, a rule in a listed code-rule file, a design commitment, a rule of the events standard, or a ruled practice governs. |
| A9 | **The system reports something false that someone acts on.** A status, a result, a count, a health or readiness check, an exit code, or a message tells an operator, a user, or a calling program something that is not so: success over a failure, failure over a success, healthy over broken, done over not started, a number that does not match what happened. A unit of work that ends with no report is A4's; this entry is a report that says the wrong thing. | Every exit code, reply status, printed result, count, health or readiness check, and status field that a person or program reads to decide what to do next. |

## What the list leaves standing

These stand even where a row's shape fits, unless an entry above also holds:

- A library's error that reaches the owner frame, however it is named. The owner frame records it with its stack trace.
- A malformed value from inside the system (a reply from the project's own service, the operator's configuration, a file the program itself wrote) that ends in a raise the owner frame records. A malformed value from an end user never stands on this ground: under A3 it is refused with a message the user can act on.
- A value from the operator's own configuration that is grossly wrong, where the program stops with an error.
- The machine failing underneath the program: a file it may not read, a close or a removal that fails, a spawn that fails.
- Cleanup skipped on the error exit of a process that is ending anyway.
- A wait on foreign code in an interactive command the user can interrupt.
- A change that alters no behavior, and an event added where nothing else changes.

## Where a site is unclear

Where you cannot tell whether an entry covers a site, it stands. Before recording a proposal, test the site against A8: where a rule from one of A8's sources decides the fix, it is a defect under A8, not a proposal. Where you see a harm of the same weight as the entries (wrong or lost data, a destroyed resource, access gained or kept that should not be, a stuck service) that no entry names, leave the code and record a proposal: `tasks item add --pool calls --key gate --field kind=proposal --body "<the site; the harm; the entry wording that would cover it>" --task <task>`.

### This project

#### .ok-planner/review/project.md

# This project, for the review loop

The owner writes this file. The review loop pastes it into every prompt that reads or runs the tree. It holds the facts a general loop cannot know. Replace each instruction line below with this project's facts, and leave a section empty where the project has nothing to say.

## The root and what is out of scope

The project root is the ok-plugins monorepo root, the folder that holds `.claude-plugin/marketplace.json`. The shipped product is `plugins/` (`plugins/ok`, `plugins/ok-conduct`, `plugins/ok-web`) and the ok-planner family the front door carries at `plugins/ok/families/ok-planner/`. No agent edits the suite-owned files of the vendored suite layer this repo dogfoods: each file under `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, and `.claude/rules/` that carries the suite's `Materialized by ok-` stamp or is a suite `LICENSE`, `.claude/rules/ok-concepts.md`, and the materialized files under `.ok-planner/`; only `/ok` rewrites them. The project's own files under `.claude/`, such as `.claude/skills/release/`, are in the run like any other file the project owns. No agent reads `.ok-planner/sprints/`, `.ok-planner/sketches/`, `.ok-planner/documentation/`, or `.ok-planner/history/` unless a skill directs it. A sprint lists no folders outside the root.

## What no agent of this loop ever runs

- `/release` (`.claude/skills/release/`): it commits, tags, and pushes to `origin`.
- `git push`, and any `git tag` pushed to `origin`.
- `claude plugin update`, `claude plugin install`, and `claude plugin marketplace update`: they change the operator's own installed plugins.
- `/ok`: it rewrites the vendored suite layer and `.claude/settings.json`, and stays an owner act.
- The converge core at `plugins/ok/families/ok-planner/admin/converge`, run at the project root: it rewrites the vendored suite layer and the estate this repository dogfoods. A driver runs it only against a scratch project, as "Resources a driver starts" says.

## The helpers the catalogs name

The tree has no event emitter, no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/oscillation`: each takes no inputs and is run by `checks/run`.
- `plugins/ok/families/ok-planner/admin/converge`: takes a mode (`diagnose`, none for converge, `resolve <id> [choice] [--from <draft>]`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, and `wire-env`).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand: `file`, `revise <id>`, `respond <id>`, `close <id>`, and `import`, each reading one JSON object (records, for `import`) from `--from <path|->`; `close <id>` also takes `--as`, `--reason`, and `--fixed-by` in place of `--from`; `rule <id>` and `comment <id>` with `--text <text|->`; `read <id>`; `promote <id> --sprint <file>`; and the readers `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, `--json`), `show <id> [--json]`, and `history [--json]`. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input: `GET /api/meta`, `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`), `GET /api/issue/<id>`, `GET /api/closed` (query `category`), and `POST /api/issue/<id>/rule`, `/comment` (a JSON body `{"text": ...}`), and `/read`, every request carrying a `Host` of `127.0.0.1:<port>` or `localhost:<port>` and every POST `Content-Type: application/json`.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `version`).
- `plugins/ok/families/ok-planner/scripts/catalog-toc`, `plugins/ok/families/ok-planner/scripts/run-tag`, and `plugins/ok/families/ok-planner/scripts/port-block`: the catalog TOC generator (a project root, or `--check`), the run tag minter (no inputs), and the port readback (a run tag).

## Drive commands

- No stack: the product runs inside a Claude Code session; its stories are offered through skills, which drivers review, and through the converge core and the materialized scripts, which drivers run against a scratch project.
- The dashboard: make a scratch project as "Resources a driver starts" says and converge it with the converge core, so it holds `.ok-planner/bin/dashboard`, `.ok-planner/bin/issues`, and the placed build at `.ok-planner/dashboard/`. Seed the intake with `.ok-planner/bin/issues file --from -`, one JSON object per issue, run from the scratch project. Start the service from the scratch project in the background with `python3 .ok-planner/bin/dashboard`; it prints `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)`. Drive the page at that address, or its JSON routes with `curl`, sending `Content-Type: application/json` on every POST. Stop it with `kill <pid>`, the pid that line names, before deleting the folder.

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the converge core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/port-block`), the dashboard's service at `.ok-planner/bin/dashboard`, which serves a page on loopback while a driver runs it, and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project makes a scratch folder with `mktemp -d`, runs `git init` in it, drives the converge core at `plugins/ok/families/ok-planner/admin/converge` against it, and deletes the folder when done.

## Stories that drive alone

## Stories that drive on an instance of their own

### The standards, verbatim

#### .ok-planner/docs/events.md

# Events: the standard

This standard governs the structured events the code emits: where it
emits, what an event is, and how a kind is named. Code review enforces
it: entry A8 of the accept list counts a breach of it as a defect. No
lint checks it.

## Where the code emits

The code emits an event at each of these sites:

- every error caught: a catch that stands under the Errors section of
  the plumbline cheatsheet emits on the caught path, or ends in a bare
  `raise` and leaves the emission to the owner frame above it;
- every owner frame: its catch-all emits one event for each raise it
  disposes;
- every retry: each attempt after the first.

Each site is a construct a grep lists: a catch block, an owner frame's
catch-all, a loop that calls the failing operation again. A state
transition and a branch taken on external input are not sites: neither
names a construct, and an event added on such a judgment is one
reader's, not the code's.

A boundary crossing — I/O, RPC, a process spawned or exited — is not a
site of its own. A failed crossing raises the library's error, and the
error propagates to the owner frame. The owner frame's event is the
event for the failed crossing. The project's event helper attaches the
stack trace to every caught-error event emitted while an exception is
in flight, so that event names the library, the type, and the line
that failed. The project names that helper in its own rules. A wrapper
emits on a crossing only where its catch stands under the Errors
section.

Internal pure computation that touches no state, no boundary, and no
error emits nothing. A caught error that neither emits nor re-raises is
a defect.

## What an event is

An event is a kind plus structured fields. Prose lives in a field,
never in the kind. A field carries one value under one name; a reader
filters on the kind and on any field without parsing text.

## How a kind is named

- A kind is a raw string literal at the site that emits it. It is
  declared nowhere else: no enum, no constant, no registry.
- A kind is a dotted namespace in one case, `SUBSYSTEM.NOUN.VERB` —
  for example `QUEUE.JOB.RETRIED`. Each segment starts with an
  upper-case letter and continues with upper-case letters and digits.
  The segments join with a dot.
- A kind is unique in meaning across the tree.

## What stays the project's

Library, transport, levels, sampling, and wire format are the
project's own choices. The standard governs the sites, the shape, and
the naming.

