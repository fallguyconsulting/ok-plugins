## Use the product to get what one story promises

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

You are a user of the running product. Your brief names one story from `.ok-planner/design/stories/`. Read it: "As <role>, I want <capability>, so that <benefit>." Your job is to get that benefit, the way a person in that role would, using only what such a person has. You follow no script. You decide how to do it from what the product shows you. You fix nothing: what you find is someone else's to fix, and your evidence is what they fix it from.

### What you may use

- The product's public surface, as the project's facts below describe it.
- What the product tells a user: page text and labels, `--help` output, messages, errors.
- The story itself, and the decisions it cites, to know what the product owes.

Never read the source, the database, or a container's filesystem to find out how to do something or whether it worked. A user cannot. The service logs (the `service-log` command in the facts below) may explain a failure after it happens; they never tell you how to proceed, and they never make an outcome pass. A skill surface, below, is the one exception: there the source is what you review.

### Setup

The stack is already up; do not start or stop it. Other drivers use it beside you. Where a surface runs in a browser, open a page of your own with `new_page`, `isolatedContext` set to your story's slug, and pass that page's `pageId` on every browser call; never touch another page. Sign in with the `sign-in` steps in the facts below. Build any state the story needs through the product yourself, as a user would. Name everything you create after your story's slug, so nothing you make collides with another driver's. Never rely on something another driver may have left behind.

Where your brief names an instance folder, drive on that instance, not the shared stack: create it with the `instance-create` command, sign up and sign in through it, and run the command line against it, as the facts below say. Destroy it with the `instance-destroy` command when you clean up. Where your story needs a resource of its own, start it with the `resource-start` steps under the drive name your brief gives, and stop it with the `resource-stop` command when you clean up. `.ok-planner/bin/review drive-command --role <role>`, with `--name`, `--folder`, or `--service` where the command names one, prints a role's command with your values filled in.

### Every way the story can be done

A story is often offered through more than one surface. Try each one a user in the story's role has: the primary surface the project's facts below name first, always, and then each other surface the story is offered through. Judge each surface on its own: a story achieved on one surface and failed on another is failed on the other.

### A surface that is a skill

A skill is a prompt the product ships for an agent session to run, such as a slash command, together with the prompts and shared blocks it reads and the scripts and tools it calls. You cannot run a session's skill from inside your task, so you do not drive a skill surface: you review it. Find the skill in the product's source, as the project's facts below name it, never in a copy the suite materializes. Read its body, every prompt and shared block it reads, and every script and tool it calls. Check them against the story and the decisions it cites: would a session that follows this text give the user the benefit the story promises, and every refusal it promises? You may run a script the skill calls only where it changes nothing outside a scratch folder of your own: run any script that may write against a scratch copy of the project or a scratch project, never at the project root.

Judge a skill surface `achieved` where the text delivers the benefit, and `failed` where the text, or a script or tool it calls, diverges from the story's intent. `stuck` and `blocked` do not apply to it. Record each divergence as a failure of its own, with `--field surface=skill:<the skill's name> --field file=<the file that diverges>` and the fingerprint `story-<slug>-skill:<the skill's name>-<a short slug for the divergence>`; in the body, quote the sentence or line that diverges and the story or decision text it diverges from.

### Reading pages

Read pages as text (the accessibility snapshot), not as screenshots, except to capture evidence of a failure.

### Clean up

Before you close, remove what you created, through the product, as a user would. What the product gives no way to remove, name in your close. Then close your page.

### Judge the outcome

For each surface you try, stop at the first of these:

- **achieved**: you got the benefit the "so that" clause names, and you can show it from what the product shows you.
- **failed**: the product broke, gave a wrong result, or refused something the story says it owes. Name what you did, what the story promises, and what happened.
- **stuck**: you could not find how to get the benefit from what the product shows. Name where a user would stop and why: no way forward, a message that did not say what was wrong, a step the product never offered.
- **blocked**: the stack, the machine, or a local tool failed, or the story needs something a local stack cannot give (real hardware, a hosted provider). Name the cause.

A refusal the story or a decision promises (a revoked credential is refused, a wrong role is turned away) is part of the benefit: where the story promises one, try it, and judge it the same way.

For every outcome but `achieved`, record it with evidence: the commands and their output and exit status, the page text or a screenshot, the browser console's errors, and the log lines that name the error, each quoted. `tasks item add --pool failures --key gate --fingerprint "story-<slug>-<surface>" --field story=<slug> --field surface=<the surface, by the name the project's facts give it> --field result=<failed|stuck|blocked> --body "<what you did, in order>; the story promises: <the benefit, or the refusal>; saw: <what happened>; evidence: <quoted>" --task <task>`.

### Confirm, where your brief says so

Where your brief starts `confirm:`, a fixer changed the product to remove a defect an earlier driver found on your story, and a verifier accepted the change. Your brief names the defect, its `kickbacks` count, and what the earlier driver saw. Try the story again on the surface the defect names; on a skill surface, review the skill again. The rules below bind a confirm drive as they bind any drive: run any command that may write against a scratch copy of the project or a scratch project, never at the project root. Record nothing in the `failures` pool.

- **achieved**: leave the defect as it stands.
- Any other outcome: send the defect back with your evidence: `tasks item set <defect id> --state open --field kickbacks=<its count plus one> --note "confirm drive: <what you did>; saw: <what happened>; evidence: <quoted>"`.

### Rules

- Edit nothing, stage nothing, commit nothing. "Edit nothing" covers every write your commands make in the project tree, not only the files you open. Run any command that may write against a scratch copy of the project or a scratch project of your own, never at the project root. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`.
- Leave the stack up and leave no other process of your own running.

### Close

`tasks close <task> --outcome done --result "<story slug>: <per surface: achieved|failed|stuck|blocked>; left behind: <what you could not remove, or nothing>"`.

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
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/sprint-boilerplate`, `checks/oscillation`: each takes no inputs and is run by `checks/run`. `checks/sprint-boilerplate` reads the `v*` tags and refuses where the clone holds none.
- `plugins/ok/families/ok-planner/admin/true-up`: takes a mode (`diagnose`, none for true-up, `resolve <id> [choice] [--from <draft>]`, `amend <config path> --from <draft>` with the config path `.ok-planner/config.json` or `.ok-planner/review/config.json`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, `wire-env`, and `check-range <first> <last>`, which writes nothing).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand. The tracker's `item add --from <path|->` reads JSON Lines, one item per line with `body` and `fields` and optionally `fingerprint` and `state`, and adds every item in one write or none. The review tool's `drive-stack` reads `stack` from `.ok-planner/config.json` and prints `stack`, `none`, or `unfilled` with the reason on a second line, and its `drive-command --role` takes `instance-create`, `instance-destroy`, `resource-start`, `resource-stop`, `service-log`, or `sign-in`.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand. `file`, `revise <id>`, `respond <id>`, and `import` each read one JSON object (records, for `import`) from `--from <path|->`, and `import` also takes `--over-event-log`, `--over-archived-event-log`, and `--dry-run`, which checks the import under the lock, prints what it would write, and writes nothing. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, one line saying what changed, and needs both on a routed or ruled issue unless the change is link-only. `close <id>` takes `--from <path|->`, or `--as`, `--reason`, and `--fixed-by` in its place. `rule <id>` and `comment <id>` take `--text <text|->` and sign the message with the caller's name. `name` prints that name and its source, and `name --set <name>` writes `{"name": <name>}` to `$XDG_CONFIG_HOME/ok-planner/user.json` (`~/.config/ok-planner/user.json` where `XDG_CONFIG_HOME` is not an absolute path), outside every project; with no such file, the name is `git config user.name` in the project root. `edit <id> <n> --text <text|->` rewrites, and `remove <id> <n>` removes, your own message number `n`. `unrule <id>` withdraws your own ruling. A person's write with no name refuses with reason `unnamed`, and an edit, removal, or withdrawal of a message another name signs refuses with reason `foreign`; each exits 2. `flag <id>` and `unflag <id>` set and clear the discussion flag. `read <id> [--opened <time>]` marks the issue read in your own ledger under `.ok-planner/.cache/read/`, which git ignores, and writes no intake file; a reader with a name creates that name's ledger the first time, counting everything that exists as read. `promote <id> --sprint <file>` stamps a sprint. `linked <id>` records that triage checked an issue's links. The readers are `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, which lists open issues with agent messages you have not read or that you have never read, `--flagged`, `--json`), `show <id> [--opened <time>] [--json]`, `links` (`--broken`, `--pending`, `--json`), and `history [--json]`. `--opened` names one record among several closed records under the same id, by its opened time. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one) and `--open` (opens the page in the default browser once the service listens). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input:
  - `GET /api/meta`, which answers `name`, the name the service signs with, or null, and `name_hint`, the setting text where `name` is null; `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`); `GET /api/closed` (query `category`); `GET /api/issue/<id>` (query `opened`); `GET /api/file` (query `path`, a path relative to the project root; it refuses a path outside the root, under `.git`, or one git ignores).
  - `POST /api/issue/<id>/rule` and `/comment`, each with a JSON body `{"text": ...}`; `POST /api/issue/<id>/read` (query `opened`); `POST /api/issue/<id>/unrule`, `/flag`, and `/unflag`; `POST /api/issue/<id>/message/<n>/edit` with a JSON body `{"text": ...}`, and `POST /api/issue/<id>/message/<n>/remove`.
  - Every request carries a `Host` of `127.0.0.1:<port>` or `localhost:<port>`, and every POST `Content-Type: application/json`.
  - The service writes and counts unread messages under the name of the person who started it, resolved as `issues` resolves it on each request. A write with no name answers 400, and a change to a message another name signs answers 403.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `compose-ports [<path>]`, `version`). `compose-ports` prints one JSON object per host port entry of each compose file it finds under the path (the project root by default), and writes nothing.
- `plugins/ok/families/ok-planner/scripts/catalog-toc`: the catalog TOC generator (a project root, or `--check`).
- `plugins/ok/families/ok-planner/scripts/stack`: the stack tool, taking a verb: `up`, or `up -- <command> ...`, which runs that command from the project root in place of the start command `stack` in `.ok-planner/config.json` declares and prints the run tag on line 1, then one `NAME=<port>` line per leased port; `down <run-tag>`; `cleanup`; `list`; `suggest-range`; or `check-range <first> <last>`. A run tag is `run-<12 hex>`, and a bound an integer from 1025 to 65535. `up` reads `stack` (`start`, `stop`, and `tag_variable`, or `none`), `ports`, and `port_range` from `.ok-planner/config.json`; `down`, `cleanup`, and `list` read no stack declaration. It records its runs in `.ok-planner/.cache/stack.json`, which git ignores, makes each run's folder under the machine's temp folder (`ok-planner-stack/<tag>/`), and finds the estate as `tasks` does; the start command's environment drops `OK_PLANNER_PROJECT_ROOT`.

## Drive commands

- No stack: the product runs inside a Claude Code session; its stories are offered through skills, which drivers review, and through the true-up core and the materialized scripts, which drivers run against a scratch project.
- The dashboard: a driver serves a page built from the working tree's source, never the committed release build true-up places. It runs the page under the working tree's stack tool, `python3 plugins/ok/families/ok-planner/scripts/stack`, from the project root, and takes these steps in order:
  1. Open the run. Its command works in the run folder, `$OK_RUN_FOLDER`. It makes the scratch project `project/` with `git init` and trues it up by running the root's `plugins/ok/families/ok-planner/admin/true-up` from `project/` with no argument. It copies the working tree's `plugins/ok/families/ok-planner/browser/` into `build/` without its `node_modules/` and `dist/`, and runs `npm ci` and then `npm run build` there. It replaces every file under `project/.ok-planner/dashboard/` but `.gitignore` with the contents of `build/dist/`, and in each copied file replaces `{{OK_PLANNER_VERSION}}` with the version the core's `placed: the dashboard build at .ok-planner/dashboard/ (v<version>), …` line names, as true-up stamps the build it places, so the page's `GET /api/meta` reports a build version that agrees with the service. It makes the configuration folders `config-a/` and `config-b/`, and starts the service from `project/` in the background with `XDG_CONFIG_HOME` set to `config-a/`:

     ```
     python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c '
       set -e
       root="$PWD" f="$OK_RUN_FOLDER"
       mkdir "$f/project" "$f/build" "$f/config-a" "$f/config-b"
       git -C "$f/project" init -q
       (cd "$f/project" && bash "$root/plugins/ok/families/ok-planner/admin/true-up") > "$f/true-up.log"
       version=$(sed -n "s|^placed: the dashboard build at \.ok-planner/dashboard/ (v\([^)]*\)).*|\1|p" "$f/true-up.log")
       test -n "$version"
       tar -C "$root/plugins/ok/families/ok-planner/browser" --exclude=./node_modules --exclude=./dist -cf - . | tar -C "$f/build" -xf -
       (cd "$f/build" && npm ci && npm run build)
       find "$f/project/.ok-planner/dashboard" -mindepth 1 -maxdepth 1 ! -name .gitignore -exec rm -rf {} +
       cp -R "$f/build/dist/." "$f/project/.ok-planner/dashboard/"
       find "$f/project/.ok-planner/dashboard" -type f ! -name .gitignore -exec perl -pi -e "s/\{\{OK_PLANNER_VERSION\}\}/$version/g" {} +
       (cd "$f/project" && XDG_CONFIG_HOME="$f/config-a" exec python3 .ok-planner/bin/dashboard) &
       i=0
       until grep -q "^dashboard: serving" "$f/stack-start.log"; do i=$((i + 1)); test "$i" -le 100; sleep 0.1; done'
     ```

     `stack up` prints the run's tag on line 1; keep it. `python3 plugins/ok/families/ok-planner/scripts/stack list` prints the run's folder after its tag; below, `<folder>` names it. The service's line, `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)`, is in `<folder>/stack-start.log`, with the output of every step before it. A failed `stack up` has already taken its run down and printed the start command's output on stderr, and makes the drive's outcome `blocked`: a missing `npm`, or a failed `npm ci` or `npm run build`, fails it.
  2. Where the drive needs a person's name, run `XDG_CONFIG_HOME=<folder>/config-a .ok-planner/bin/issues name --set <name>` from `<folder>/project/`, and the same with `<folder>/config-b` for a second person. Set `XDG_CONFIG_HOME` to one of those folders for every `issues` call. Never run `issues name --set` without that setting: it would write the operator's own `~/.config/ok-planner/user.json`. The service from step 1 signs as the `config-a/` person. To serve the page as the `config-b/` person too, open a second run from the project root, which starts a second service and writes its serving line to that run's own `stack-start.log`:

     ```
     python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c '
       (cd "<folder>/project" && XDG_CONFIG_HOME="<folder>/config-b" exec python3 .ok-planner/bin/dashboard) &
       i=0
       until grep -q "^dashboard: serving" "$OK_RUN_FOLDER/stack-start.log"; do i=$((i + 1)); test "$i" -le 100; sleep 0.1; done'
     ```

  3. Seed the intake with `.ok-planner/bin/issues file --from -`, one JSON object per issue, run from `<folder>/project/`. Drive the page at the service's address, or its JSON routes with `curl`, sending `Content-Type: application/json` on every POST.
  4. End each run with `python3 plugins/ok/families/ok-planner/scripts/stack down <tag>` from the project root, pass or fail, a second run's tag before the first's. It stops the run's service and deletes its folder: the first run's takes the scratch project, the build folder, and both configuration folders with it.

  Nothing under `plugins/ok/families/ok-planner/browser/` changes during a drive: the driver writes no `node_modules/` and no `dist/` there. The committed `browser/dist/` stays the release artifact that `/release` builds.

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the true-up core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/stack`), the dashboard's service at `.ok-planner/bin/dashboard`, which serves a page on loopback while a driver runs it, and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project opens a run of its own from the project root, `python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c 'git init -q "$OK_RUN_FOLDER/project"'`, keeps the tag it prints on line 1, and finds the run's folder in what `python3 plugins/ok/families/ok-planner/scripts/stack list` prints for that tag. It drives the true-up core at `plugins/ok/families/ok-planner/admin/true-up` against `<folder>/project/`, and ends the run with `python3 plugins/ok/families/ok-planner/scripts/stack down <tag>` from the project root when done, which deletes the folder.

## Stories that drive alone

## Stories that drive on an instance of their own

