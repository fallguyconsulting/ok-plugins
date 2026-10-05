## Back out a stuck defect's change

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

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

A defect reached its limit of send-backs, so the run gives up on it. Its fixes still stand in the tree, and a verifier found each of them wrong. You remove that change and keep every other change. The defect goes to the intake as a judgment issue after you; you fix nothing.

Your brief names the defect, every fix task that set it `fixed`, and for each file those tasks staged, its content before the first of them as a git blob.

### Read

1. The defect: `tasks item list --pool defects --key gate --json`, the item your brief names, with its note.
2. Every other defect whose `files` field names a file in your brief, and its state. A `verified` defect's change stays. So does the change of any defect still being fixed.
3. The change: for each file, `git diff <before blob> $(git hash-object -w <path>)`.

### Back out

For each file in your brief:

- Where no other defect's fix touched the file after the before blob, write the file back to the before blob's content: `git cat-file -p <before blob> > <path>`.
- Otherwise, remove each hunk the stuck defect's fixes made and keep each hunk the other defects' fixes made. Where one hunk mixes both, keep the other defect's lines and restore the rest from the before blob.

Then walk every caller of anything whose signature, return, or raise the backout changed back (`rg`, or the LSP via `ToolSearch("select:LSP")`). A caller that the stuck defect's fixes brought along goes back with them. A caller that another defect's verified fix needs stays.

Run the project's checks on every file you changed, in the foreground. Each file passes, or fails only where it failed at the before blob.

Stage every file you changed, by name.

### Rules

Edit only the files your brief names and the callers the walk above reaches. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`: other defects' work in the same files has no commit to come back from. A file your brief names is one the stuck defect's fixes changed, so you back it out as above even where the fix line rule above leaves that file alone: the backout undoes the run's own edit and makes none of its own. Edit no other file the fix line rule leaves alone; a caller the walk reaches in such a file stays as it is, and you name it in your close.
Edit no test.
Commit nothing. Run nothing that starts the product.

### Close

`tasks close <task> --outcome done --staged <the paths you staged> --result "backed out <defect id>: <n> files restored whole, <n> files by hunk; kept: <the other defect ids whose hunks stayed>"`. Where you cannot separate the stuck defect's lines from another defect's, restore nothing in that file and close `--outcome partial --result "tangled: <path>: <the defect ids>"`.

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

