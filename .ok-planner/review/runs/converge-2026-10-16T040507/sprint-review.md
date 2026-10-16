## Read a sprint's change and cut the passes

You are a **forking agent**: you read once and fork per item, and every fork owns a task of its own. Read the material every item in your brief shares — the code the refs cite, the catalogs, the rule files — once, up front. Then file one task per item, on your own profile and forked from your task (`tasks file ... --agent <your profile> --fork-of <task>`); the tracker marks it issued for your fork, and the drain leaves it alone while your fork holds it. Close your task with the item tasks in its result. Then fork one agent per item task, every fork in one message: the `Agent` tool with `subagent_type` set to `fork` and no other type, its prompt saying it is a fork, saying that everything you read stands in its context, and naming its task on its last line. A fork inherits everything you read, so it reads nothing shared again; it claims its item task, does its item, writes the item's file, and closes that task with the item's report line as the result. A fork never forks, and you spawn nothing but forks. A fork that returns nothing is the drain's: it reissues the item task to a fresh agent of your profile, and the prompt tells that agent what to read. A brief with one item needs no fork and no task: do it yourself and close your task with its line.

Fork every pass, however few: the session drives the review by the pass tasks you filed, and a pass you ran yourself would be one it cannot see. The fork-per-item rule's one-item clause does not apply to you. You file no report yourself.

You are a reader and a judge. Your evidence is the files and records as they stand. Your execution surface is read-only commands: searches (`rg`) and git inspection (`git log` / `diff` / `status`). Never run tests, builds, deployments, experiments, or the project's stack; execution belongs to whoever dispatched you. The task tracker's own verbs — `claim`, `item add`, `item set`, `item list`, `round show`, `close` — are your record, not execution: run them. If a judgment requires something to be run, report that need as a line in your findings and judge the rest without it.

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
tooling, its configuration, its review facts, its release boundaries,
its surface intent, and its document types, with prose other than
skill text in review only as the prose scope rule allows. A fix to
the review facts keeps every limit its `## What no agent of this loop
ever runs` section sets. The run leaves five kinds of file alone, and
no agent of the run edits one:

- the design corpus and the coding standards (`corpus`): they change
  only through a sprint's deltas, so a defect whose fix lies there
  goes to the intake as a judgment issue. There is one exception: in
  sprint certification, a defect of class C3 lands the certified
  sprint's own delta. Its fixer copies the delta's body verbatim into
  the artifact, or deletes the retired file, and regenerates the
  collection's catalog TOC with `python3 .ok-planner/bin/catalog-toc`.
  That copy and that TOC are the one corpus write a review run makes;
  every other corpus fix still goes to the intake as a judgment issue;
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

This run certifies the sprint at .ok-planner/sprints/2026-10-15-stack-helpers.md. Its change runs from the base commit eda17da5746b61d1a1528c452b67fff6f73ddfb6 to the working tree. Leave the sprint's completion report and its build run file, where it has one, to the alignment pass: the other passes judge the code blind to the executor's account of it, so a divergence the executor did not record surfaces as a report.

### Read once

`<base>` below is the base commit, and `<sprint>` the sprint's path,
both named above.

1. The sprint, whole: intent, deltas and their sidecar, work items,
   implementation notes. Every artifact under `.ok-planner/design/` a
   delta names or a work item cites, in full.
   `.ok-planner/release-boundaries.md` where it exists.
2. The change: `.ok-planner/bin/review changed --base <base> --sprint <sprint>`
   lists every file the sprint added, changed, or deleted, relative to
   the project root, less the files `.ok-planner/bin/review owner`
   classes as anything but `project` and the paths
   `.ok-planner/review/config.json` excludes. A changed harness
   settings file, corpus file, or record is not on the list; step 1
   reads each artifact a delta names. It includes the files under each
   folder the sprint lists under `## Paths outside the project root`,
   as paths starting `../`. Read each file's diff with
   `git diff <base> -- <path>`, run from the project root, and each
   added file whole.
3. Every changed file in full, as it stands now, and each changed
   file's base version where the diff alone does not show a changed
   definition whole (`git show <base>:./<path>`, the `./` making the
   path relative to the project root).
4. Each work item's and each taken improvement's path: from the entry
   point that reaches its outcome to the outcome, reading every
   unchanged file the path crosses in full.
5. The users of each changed definition that existed at the base: its
   callers and references (load the LSP with
   `ToolSearch("select:LSP")`; `rg` for the rest), code that reads the
   same stored data or configuration, and what each release boundary's
   Where to look names. Read each user's calling function in full.

Write down the list of files step 2 gives. This reading is the whole reading, and it fixes the run's scope: the passes read nothing else.

### Cut the passes

- `completion`: one pass per group of work items that share code, up to five work items a group, with their improvements. Its files are the paths the group's outcomes cross.
- `regression`: one pass per group of changed definitions that share users, grouped by module. Its files are the definitions' files and their users' files.
- `alignment`: one pass over the whole sprint.

Number the passes `sprint-1`, `sprint-2`, and on; that name is the pass's area. File each on your own profile, forked from your task:

    .ok-planner/bin/tasks file --role pass --prompt sprint-pass --agent ok-review --key gate --fork-of <task> --files <the pass's paths> --brief - <<'EOF'
    area: sprint-<n>
    pass: completion | regression | alignment
    <completion: the work items and I-ids, each with its entry point and path as path::symbol steps. regression: the changed definitions, each with its B-ids where the notes list it, and its users.>
    EOF

### Close, then fork

Close your task first: `tasks close <task> --outcome done --result "<one entry per pass task: its id, its area, its pass, and its work items or definitions, with each work item's entry point; then the counts: changed files, work items, improvements, changed definitions with users, users read>"`. The return reads the entry points from this result.

Then fork one agent per pass task, every fork in one message, with `subagent_type` set to `fork`, each fork's prompt exactly this, its pass task's id in place of `<pass task>`:

    You are a fork of the review root. Everything the root read
    stands in your context; read nothing shared again. Claim your
    task and finish it.
    task: <pass task>

Wait for every fork to return. Your final message is the one line the profile defines.

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

The event helper is `plugins/ok/families/ok-planner/scripts/tasks::event`, `event(kind, **fields)`: it writes one JSON line with the kind and the fields on stderr, and attaches the stack trace to an event emitted while an exception is in flight. Every Python script of the family that emits an event calls it through the `tasks` module it loads. The tree has no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/sprint-boilerplate`, `checks/oscillation`: each takes no inputs and is run by `checks/run`. `checks/sprint-boilerplate` reads the `v*` tags and refuses where the clone holds none.
- `plugins/ok/families/ok-planner/admin/true-up`: takes a mode (`diagnose`, none for true-up, `resolve <id> [choice] [--from <draft>]`, `amend <config path> --from <draft>` with the config path `.ok-planner/config.json` or `.ok-planner/review/config.json`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, `wire-env`, and `check-range <first> <last>`, which writes nothing).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand. The tracker's `item add --from <path|->` reads JSON Lines, one item per line with `body` and `fields` and optionally `fingerprint` and `state`, and adds every item in one write or none. The review tool's `drive-stack` reads the `## Drive commands` section of `.ok-planner/review/project.md` and prints `stack` where the section gives a `stack-start` line, `none` where it gives a `- No stack:` line, or `unfilled` with the lines to write on a second line, and refuses a missing section or a `- No stack:` line beside a stack line. Its `drive-command --role` takes `stack-start`, `stack-stop`, `instance-create`, `instance-destroy`, `resource-start`, `resource-stop`, `service-log`, or `sign-in`, with `--name`, `--folder`, and `--service` for the placeholders the line names; it refuses a stack role under `- No stack:`, and a line that names `{tag}`, which the drive no longer fills.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand. `file`, `revise <id>`, `respond <id>`, and `import` each read one JSON object (records, for `import`) from `--from <path|->`, and `import` also takes `--over-event-log`, `--over-archived-event-log`, and `--dry-run`, which checks the import under the lock, prints what it would write, and writes nothing. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, one line saying what changed, and needs both on a routed or ruled issue unless the change is link-only. `close <id>` takes `--from <path|->`, or `--as`, `--reason`, and `--fixed-by` in its place. `rule <id>` and `comment <id>` take `--text <text|->` and sign the message with the caller's name. `name` prints that name and its source, and `name --set <name>` writes `{"name": <name>}` to `$XDG_CONFIG_HOME/ok-planner/user.json` (`~/.config/ok-planner/user.json` where `XDG_CONFIG_HOME` is not an absolute path), outside every project; with no such file, the name is `git config user.name` in the project root. `edit <id> <n> --text <text|->` rewrites, and `remove <id> <n>` removes, your own message number `n`. `unrule <id>` withdraws your own ruling. A person's write with no name refuses with reason `unnamed`, and an edit, removal, or withdrawal of a message another name signs refuses with reason `foreign`; each exits 2. `flag <id>` and `unflag <id>` set and clear the discussion flag. `read <id> [--opened <time>]` marks the issue read in your own ledger under `.ok-planner/.cache/read/`, which git ignores, and writes no intake file; a reader with a name creates that name's ledger the first time, counting everything that exists as read. `promote <id> --sprint <file>` stamps a sprint. `linked <id>` records that triage checked an issue's links. The readers are `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, which lists open issues with agent messages you have not read or that you have never read, `--flagged`, `--json`), `show <id> [--opened <time>] [--json]`, `links` (`--broken`, `--pending`, `--json`), and `history [--json]`. `--opened` names one record among several closed records under the same id, by its opened time. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one) and `--open` (opens the page in the default browser once the service listens). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input:
  - `GET /api/meta`, which answers `name`, the name the service signs with, or null, and `name_hint`, the setting text where `name` is null; `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`); `GET /api/closed` (query `category`); `GET /api/issue/<id>` (query `opened`); `GET /api/file` (query `path`, a path relative to the project root; it refuses a path outside the root, under `.git`, or one git ignores).
  - `POST /api/issue/<id>/rule` and `/comment`, each with a JSON body `{"text": ...}`; `POST /api/issue/<id>/read` (query `opened`); `POST /api/issue/<id>/unrule`, `/flag`, and `/unflag`; `POST /api/issue/<id>/message/<n>/edit` with a JSON body `{"text": ...}`, and `POST /api/issue/<id>/message/<n>/remove`.
  - Every request carries a `Host` of `127.0.0.1:<port>` or `localhost:<port>`, and every POST `Content-Type: application/json`.
  - The service writes and counts unread messages under the name of the person who started it, resolved as `issues` resolves it on each request. A write with no name answers 400, and a change to a message another name signs answers 403.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `version`).
- `plugins/ok/families/ok-planner/scripts/catalog-toc`: the catalog TOC generator (a project root, or `--check`).
- `plugins/ok/families/ok-planner/scripts/run-tag`: the tag generator, a POSIX shell script that takes no argument and prints `run-<12 hex>` from `/dev/urandom` on one line. `-h` or `--help` alone prints its usage line, and any other argument is refused with that line on stderr and exit 1.
- `plugins/ok/families/ok-planner/scripts/ports`: the port registry, taking a verb: `lease <run-tag>`, `release <run-tag>`, `list`, `stale`, `suggest-range`, or `check-range <first> <last>`. `lease` reads `ports` and `port_range` from `.ok-planner/config.json`, prints one `NAME=<port>` line per declared name, and prints nothing where `ports` names none. It counts a port as taken where another lease holds it, a program holds it over TCP or UDP, a docker container publishes it (read through `docker ps -aq` and `docker inspect`, and skipped with a `PORTS.DOCKER.UNCHECKED` event where docker does not answer), or the block list names it (`ports-blocklist` beside the script, and `/etc/services`). It records leases in `.ok-planner/.cache/ports.json`, `{"leases": {<tag>: {"at", "ports"}}, "next"}`, under `ports.lock`, both of which git ignores. `release` exits 0 where the tag holds no lease, and `stale` lists the leases at least an hour old none of whose ports a program holds. It finds the estate as `tasks` does; `suggest-range` and `check-range` read nothing of the project. It exits 0, or 1 on a refusal or a failure.
- `plugins/ok/families/ok-planner/scripts/docker-sweep`: the docker sweep, taking `sweep <run-tag>`, `running <run-tag>`, or `probe`. It runs the `docker` on PATH, reads nothing of the project, and needs no estate. A docker object belongs to the run where it carries `label=ok.run-tag=<run-tag>` or `label=com.docker.compose.project=<run-tag>`. `sweep` removes the run's containers (`rm -f -v`), networks, volumes, and images; `running` prints the id of each running container of the run; `probe` checks the daemon. It exits 0, 1 on a refused removal (every other removal still attempted) or a malformed argument, and 3 where docker is not on PATH or its daemon does not answer.
- `plugins/ok/families/ok-planner/scripts/run-group`: the process-group helper, taking `start <run-tag> -- <command> ...`, `stop <run-tag>`, or `members <run-tag>`. `start` starts a holder process that leads a process group of its own the first time a tag starts, records the group in `.ok-planner/.cache/run-groups.json`, `{<tag>: {"pgid", "at"}}`, under `run-groups.lock`, runs the command from the working directory in that group with the caller's input and output, and exits with the command's status; a later `start` for the tag joins the same group while its holder lives. `stop` sends SIGTERM, waits up to 10 seconds, sends SIGKILL, waits up to 2 seconds, and drops the record; it exits 0 where the tag records no group, and 1, keeping the record, where pids outlive SIGKILL or the holder is gone while pids carry the group's id. `members` prints each pid left in the group but the holder. It finds the estate as `tasks` does.
- `plugins/ok/families/ok-planner/scripts/stack`: the reference stack tool, built from the stack helpers, taking a verb: `up [--name <name>]`, which runs the start command `stack` in `.ok-planner/config.json` declares; `up [--name <name>] [--stop <command>] [--tag-variable <NAME>] -- <command> ...`, which runs that command from the project root in the declared one's place, runs the `--stop` command at `down`, and sets the variable `--tag-variable` names (else `stack.tag_variable`) to the tag; `down <run-tag>` or `down --name <name>`; `tag <name>`; `cleanup`; `list`; `suggest-range`; or `check-range <first> <last>`. `up` prints the run tag on line 1, then one `NAME=<port>` line per leased port. A run tag is `run-<12 hex>`, a name is lower-case letters, digits, and hyphens, and a bound an integer from 1025 to 65535. `--stop` and `--tag-variable` without `--` are refused. A bare `up` refuses where `stack` declares no start command. Where a run already holds the name `up --name` gives, `up` takes that run down first when nothing still uses it, and refuses when something does. `down --name` exits 0 and prints `took down: nothing` where no run holds the name; `down <run-tag>` refuses an unknown tag. `tag` refuses where no run holds the name. `list` prints each run's tag, time, ports, and folder, then `name: <name>` where the run has one, then `refused: ...` where a removal was refused. `up` reads `stack` (`start`, `stop`, and `tag_variable`, or `none`), `ports`, and `port_range` from `.ok-planner/config.json`; `down`, `tag`, `cleanup`, and `list` read no stack declaration. It loads `ports`, `docker-sweep`, and `run-group` beside it and runs `sh run-tag` beside it for each tag, leases its ports through the port registry, keeps each run's process group in `run-group`'s registry, probes docker's daemon before and after the start command, records its runs in `.ok-planner/.cache/stack.json`, which git ignores, makes each run's folder under the machine's temp folder (`ok-planner-stack/<tag>/`), and finds the estate as `tasks` does; the start command's environment drops `OK_PLANNER_PROJECT_ROOT`.

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

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the true-up core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, `.ok-planner/bin/review`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/ports`, `.ok-planner/bin/docker-sweep`, `.ok-planner/bin/run-group`, `.ok-planner/bin/stack`), the dashboard's service at `.ok-planner/bin/dashboard`, which serves a page on loopback while a driver runs it, and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project opens a run of its own from the project root, `python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c 'git init -q "$OK_RUN_FOLDER/project"'`, keeps the tag it prints on line 1, and finds the run's folder in what `python3 plugins/ok/families/ok-planner/scripts/stack list` prints for that tag. It drives the true-up core at `plugins/ok/families/ok-planner/admin/true-up` against `<folder>/project/`, and ends the run with `python3 plugins/ok/families/ok-planner/scripts/stack down <tag>` from the project root when done, which deletes the folder.

## Stories that drive alone

## Stories that drive on an instance of their own

