## Back out a stuck defect's change

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

The run fixes a clear defect in every file the project owns, wherever
the file sits, under `.claude/` and `.ok-planner/` too: its code, and
its own scripts, skills, rules, agent profiles, hooks, and other
tooling, its configuration, its review facts, its release boundaries,
its surface intent, and its document types, with prose other than
skill text in review only as the prose scope rule allows. A fix to
the review facts keeps every limit its `## What no agent of this loop
ever runs` section sets. The run leaves five kinds of file alone, and
no agent of the run edits one:

- the design corpus and the coding standards (`corpus`): they change
  only through a sprint's deltas, so a defect whose fix lies there
  goes to the intake as a judgment issue;
- a file the suite owns (`suite`): the next `/ok` overwrites a local
  edit, so its harm goes to the intake as an upstream issue;
- the harness settings (`declaration`): `.claude/settings.json`, its
  siblings under `.claude/`, and `.mcp.json`, which decide what runs
  in every session and change only by the owner's hand or the
  owner's consent; a defect whose fix lies there goes to the intake
  as a judgment issue;
- a record (`record`): a sprint, the issue intake and its archive
  (written only through `.ok-planner/bin/issues`), an audit, an
  experiment, a run ledger, or anything archived; it changes only
  through the act that owns it, and the run files nothing about it;
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

Agents keep this file current: a sprint build that adds or changes a script input updates it in the same stage, and a `/converge` fixer fixes a clear defect in it. The limits under "What no agent of this loop ever runs" bind every agent. The review loop pastes the file into every prompt that reads or runs the tree. It holds the facts a general loop cannot know.

## The root and what is out of scope

The project root is the ok-plugins monorepo root, the folder that holds `.claude-plugin/marketplace.json`. The shipped product is `plugins/` (`plugins/ok`, `plugins/ok-conduct`, `plugins/ok-web`) and the ok-planner family the front door carries at `plugins/ok/families/ok-planner/`. No agent edits the suite-owned files of the vendored suite layer this repo dogfoods: each file under `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, and `.claude/rules/` that carries the suite's `Materialized by ok-` stamp or is a suite `LICENSE`, `.claude/rules/ok-concepts.md`, and the materialized files under `.ok-planner/`; only `/ok` rewrites them. The project's own files under `.claude/`, such as `.claude/skills/release/`, are in the run like any other file the project owns. No agent reads `.ok-planner/sprints/`, `.ok-planner/sketches/`, `.ok-planner/documentation/`, or `.ok-planner/history/` unless a skill directs it. A sprint lists no folders outside the root.

## What no agent of this loop ever runs

- `/release` (`.claude/skills/release/`): it commits, tags, and pushes to `origin`.
- `git push`, and any `git tag` pushed to `origin`.
- `claude plugin update`, `claude plugin install`, and `claude plugin marketplace update`: they change the operator's own installed plugins.
- `/ok`: it rewrites the vendored suite layer and `.claude/settings.json`, and stays an owner act.
- `issues name --set` (`plugins/ok/families/ok-planner/scripts/issues`, or a scratch project's `.ok-planner/bin/issues`) with `XDG_CONFIG_HOME` unset or naming the operator's own configuration folder: it writes the operator's own name file, `~/.config/ok-planner/user.json` by default. A driver sets `XDG_CONFIG_HOME` to a scratch folder first, as the dashboard's drive steps say.
- The true-up core at `plugins/ok/families/ok-planner/admin/true-up`, run at the project root: it rewrites the vendored suite layer and the estate this repository dogfoods. A driver runs it only against a scratch project, as "Resources a driver starts" says.

## The helpers the catalogs name

The tree has no event emitter, no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/oscillation`: each takes no inputs and is run by `checks/run`.
- `plugins/ok/families/ok-planner/admin/true-up`: takes a mode (`diagnose`, none for true-up, `resolve <id> [choice] [--from <draft>]`, `amend <config path> --from <draft>` with the config path `.ok-planner/config.json` or `.ok-planner/review/config.json`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, `wire-env`, and `check-range <first> <last>`, which writes nothing).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand. The tracker's `item add --from <path|->` reads JSON Lines, one item per line with `body` and `fields` and optionally `fingerprint` and `state`, and adds every item in one write or none.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand. `file`, `revise <id>`, `respond <id>`, and `import` each read one JSON object (records, for `import`) from `--from <path|->`, and `import` also takes `--over-event-log`, `--over-archived-event-log`, and `--dry-run`, which checks the import under the lock, prints what it would write, and writes nothing. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, one line saying what changed, and needs both on a routed or ruled issue unless the change is link-only. `close <id>` takes `--from <path|->`, or `--as`, `--reason`, and `--fixed-by` in its place. `rule <id>` and `comment <id>` take `--text <text|->` and sign the message with the caller's name. `name` prints that name and its source, and `name --set <name>` writes `{"name": <name>}` to `$XDG_CONFIG_HOME/ok-planner/user.json` (`~/.config/ok-planner/user.json` where `XDG_CONFIG_HOME` is not an absolute path), outside every project; with no such file, the name is `git config user.name` in the project root. `edit <id> <n> --text <text|->` rewrites, and `remove <id> <n>` removes, your own message number `n`. `unrule <id>` withdraws your own ruling. A person's write with no name refuses with reason `unnamed`, and an edit, removal, or withdrawal of a message another name signs refuses with reason `foreign`; each exits 2. `flag <id>` and `unflag <id>` set and clear the discussion flag. `read <id> [--opened <time>]` marks the issue read in your own ledger under `.ok-planner/.cache/read/`, which git ignores, and writes no intake file; a reader with a name creates that name's ledger the first time, counting everything that exists as read. `promote <id> --sprint <file>` stamps a sprint. `linked <id>` records that triage checked an issue's links. The readers are `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, which lists issues with agent messages you have not read or that you have never read, closed ones among them, `--flagged`, `--json`), `show <id> [--opened <time>] [--json]`, `links` (`--broken`, `--pending`, `--json`), and `history [--json]`. `--opened` names one record among several closed records under the same id, by its opened time. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one) and `--open` (opens the page in the default browser once the service listens). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input:
  - `GET /api/meta`, which answers `name`, the name the service signs with, or null, and `name_hint`, the setting text where `name` is null; `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`); `GET /api/closed` (query `category`); `GET /api/issue/<id>` (query `opened`); `GET /api/file` (query `path`, a path relative to the project root; it refuses a path outside the root, under `.git`, or one git ignores).
  - `POST /api/issue/<id>/rule` and `/comment`, each with a JSON body `{"text": ...}`; `POST /api/issue/<id>/read` (query `opened`); `POST /api/issue/<id>/unrule`, `/flag`, and `/unflag`; `POST /api/issue/<id>/message/<n>/edit` with a JSON body `{"text": ...}`, and `POST /api/issue/<id>/message/<n>/remove`.
  - Every request carries a `Host` of `127.0.0.1:<port>` or `localhost:<port>`, and every POST `Content-Type: application/json`.
  - The service writes and counts unread messages under the name of the person who started it, resolved as `issues` resolves it on each request. A write with no name answers 400, and a change to a message another name signs answers 403.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `compose-ports [<path>]`, `version`). `compose-ports` prints one JSON object per host port entry of each compose file it finds under the path (the project root by default), and writes nothing.
- `plugins/ok/families/ok-planner/scripts/catalog-toc`, `plugins/ok/families/ok-planner/scripts/run-tag`, and `plugins/ok/families/ok-planner/scripts/ports`: the catalog TOC generator (a project root, or `--check`), the run tag minter (no inputs), and the port allocator, taking a verb (`lease <run-tag>`, `release <run-tag>`, `cleanup`, `suggest-range`, or `check-range <first> <last>`; a run tag is `run-<12 hex>`, a bound an integer from 1025 to 65535).

## Drive commands

- No stack: the product runs inside a Claude Code session; its stories are offered through skills, which drivers review, and through the true-up core and the materialized scripts, which drivers run against a scratch project.
- The dashboard: a driver serves a page built from the working tree's source, never the committed release build true-up places. It takes these steps in order:
  1. Make a scratch project as "Resources a driver starts" says, and true it up by running `plugins/ok/families/ok-planner/admin/true-up` from the scratch project with no argument. The scratch project then holds `.ok-planner/bin/dashboard` and `.ok-planner/bin/issues`. The core prints `placed: the dashboard build at .ok-planner/dashboard/ (v<version>), …`; keep `<version>` without its `v`.
  2. Make a second folder with `mktemp -d` and copy the working tree's `plugins/ok/families/ok-planner/browser/` into it without its `node_modules/` and `dist/`: `tar -C <browser> --exclude=./node_modules --exclude=./dist -cf - . | tar -C <build folder> -xf -`.
  3. Run `npm ci` and then `npm run build` in the build folder.
  4. Remove every file under the scratch project's `.ok-planner/dashboard/` except `.gitignore`, and copy in the contents of the build folder's `dist/`. In each copied file, replace `{{OK_PLANNER_VERSION}}` with `<version>`, as true-up stamps the build it places. The page's `GET /api/meta` then reports a build version that agrees with the service.
  5. Where the drive needs a person's name, make a scratch configuration folder with `mktemp -d`, and set `XDG_CONFIG_HOME` to it for every `issues` call and for the service. Run `XDG_CONFIG_HOME=<folder> .ok-planner/bin/issues name --set <name>` from the scratch project. Never run `issues name --set` without that setting: it would write the operator's own `~/.config/ok-planner/user.json`. Two such folders give two people. Delete each folder at the end.
  6. Seed the intake with `.ok-planner/bin/issues file --from -`, one JSON object per issue, run from the scratch project. Start the service from the scratch project in the background with `python3 .ok-planner/bin/dashboard`, under the step 5 setting where there is one; it prints `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)`. Drive the page at that address, or its JSON routes with `curl`, sending `Content-Type: application/json` on every POST.
  7. Stop the service with `kill <pid>`, the pid that line names. Then delete the scratch project and the build folder.

  A missing `npm`, or a failed `npm ci` or `npm run build`, makes the drive's outcome `blocked`. Nothing under `plugins/ok/families/ok-planner/browser/` changes during a drive: the driver writes no `node_modules/` and no `dist/` there. The committed `browser/dist/` stays the release artifact that `/release` builds.

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the true-up core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/ports`), the dashboard's service at `.ok-planner/bin/dashboard`, which serves a page on loopback while a driver runs it, and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project makes a scratch folder with `mktemp -d`, runs `git init` in it, drives the true-up core at `plugins/ok/families/ok-planner/admin/true-up` against it, and deletes the folder when done.

## Stories that drive alone

## Stories that drive on an instance of their own

