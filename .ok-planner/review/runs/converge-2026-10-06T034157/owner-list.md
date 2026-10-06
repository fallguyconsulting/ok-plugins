## Write what the run leaves for the owner

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

The run is over. Everything it fixed is fixed. What it could not settle, and what it found outside its scope, sits in the run's ledger as items, and a ledger is a record nobody reads. You move those items to the places someone does read, you close the intake issues the run resolved, and you fix nothing.

### Read

- `tasks item list --pool calls --key gate --json`. The kinds that concern you: `proposal`, `question`, `noticed`, and `session-note`. The kind `unlisted` is a record for the sprint's completion report, not for you.
- `tasks item list --pool defects --key gate --json`: the defects `stuck`, the defects still `open` or `fixed` where the run ended before they were verified, and every defect with an `issue` field.
- `tasks item list --pool reports --key gate --json`: the reports at state `backlog`, the reports at states `judgment` and `upstream`, and the rejected reports with an `issue` field.
- `tasks item list --pool failures --key gate --state backlog --json`: the drive failures a merge agent found real and outside the sprint's scope.
- `tasks item list --pool failures --key gate --state judgment --json` and `--state upstream`: the drive failures whose fix lies in a file the run leaves alone.
- `tasks item list --pool failures --key gate --json`: the failures at `environment`, and those at `not-owed` whose note says the corpus does not decide.
- The intake, through its module `.ok-planner/bin/issues` and nothing else: `.ok-planner/bin/issues list --json` prints every open issue, `issues list --category <category> --json` the open issues of one category, and `issues show <id>` one issue whole, its discussion included.
- The `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md` (open that file and read the block): the record each issue is, its fields, and the verbs that write it.
- The accept list and the catalogs under `.ok-planner/review/catalog/`, to check whether a proposal's harm or a session note's question is already answered there.
- the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md`, which says what a `category: defect` issue is and how it closes.
- The fix line rule's five kinds of file a run leaves alone: the design corpus and the coding standards, a file the suite owns, an owner's declaration, a record, and a document the release regenerates. `.ok-planner/bin/review owner <path>...` prints `project`, `suite`, `corpus`, `declaration`, or `record` for each path. It does not detect a document the release regenerates: a file at a target a declared document type under `.ok-planner/surface/documents/` names (a folder target covers the folder), or a file that opens with the provenance stamp `/document` writes.

### Three destinations, all in the intake

**A defect outside the run's reach** goes to the intake as a `category: defect` issue, for the next `/converge` to fix: a `backlog` report or drive failure (real, outside the sprint's scope), a `noticed` call (a defect a fixer saw outside its brief, not yet checked), and a defect the run did not finish. File each with `.ok-planner/bin/issues file --from -`, one JSON object in the format of the `{{ISSUE-FILE-FORMAT}}` block, kind `audit`, `category: defect`: the `problem` names the site as path:function, the accept-list entry or sprint class, the trigger, the harm, and the evidence, quoted, and says whether a merge agent confirmed it or a fixer only noticed it; the one option is to fix the site so the harm no longer follows. A `noticed` call was not checked against the fix line, so run `.ok-planner/bin/review owner <its file>` first. A `project` file that is not a document the release regenerates takes this route. A `corpus`, `declaration`, or `suite` file takes the route "A defect in a file the run leaves alone" gives. A `record`, or a document the release regenerates, changes only through the act that owns it: file nothing, and settle the call with `--state promoted --note "left alone: <record or release document>; nothing filed"`. First read `issues list --category defect --json` for an open issue at the same site; where one stands, add nothing and name its id in your close. Then settle the item: `tasks item set <id> --state promoted --note "<the issue id>"`, or for a report or a failure, `--note` on its `backlog` state.

**An upstream issue** goes to the intake as `category: upstream`, for the next `/plan-sprint` to walk with the owner. Its fix lies in a part the project does not own, so no run fixes it in place. It is:

- every report and drive failure at `upstream`, and every `noticed` call in a `suite` file, as "A defect in a file the run leaves alone" says;
- every `proposal` call, a harm the accept list does not name, at a named site: the accept list is suite-owned;
- every `session-note` call whose change lies in a file the suite owns: the accept list, the catalogs, a vendored skill or prompt, a cheatsheet, or a tool under `.ok-planner/bin/` (run `.ok-planner/bin/review owner <the file>`; `suite` decides it);
- every drive failure at `environment` whose cause lies in a library the project depends on or in an outside tool or service.

First read `issues list --json` for an open issue on the same harm; where one stands, write nothing and name its id in your close. Fold items that name one harm into one issue. Otherwise file one issue with `issues file --from -`, in the format of the `{{ISSUE-FILE-FORMAT}}` block, kind `audit`, `category: upstream`: the `problem` names the foreign part as the project sees it (the package and its version, the tool, or the file's path as it sits in the project, never a path to a local checkout of the suite or of any other part), the site, the harm, the evidence, quoted, and the run and item ids it rests on; the `options` are a workaround in the project, a filing upstream, or both; and the `upstream` field holds the draft ready to file, in the shape that block gives. Call the suite "the ok suite". An issue written from `proposal` calls ends its `problem` with a section, `## Proposed entry`: each site the calls name, as path:function, with its trigger and harm, and the entry wording the calls propose, quoted. Then `tasks item set <id> --state promoted --note "<the issue id>"` for a call, or `--note "<the issue id>"` on a report's or a failure's state.

**A judgment issue** goes to the intake as an issue in any category but `defect` and `upstream`, for the next `/plan-sprint`; `/triage-issues` routes it next. It is anything else that needs the owner to choose:

- every `question` call, and any other item whose answer is a decision about what the product owes;
- every `session-note` call about the project's own tooling or environment;
- every other drive failure at `environment`: what stopped the drive, and what the owner would change so a later drive gets through;
- every report and drive failure at `judgment`, and every `noticed` call in a `corpus` or `declaration` file, as "A defect in a file the run leaves alone" says;
- every `stuck` defect, as the next section says.

First read `issues list --json` for an open issue on the same question; where one stands, write nothing and name its id in your close. Fold items that ask one question into one issue. Otherwise file one issue with `issues file --from -`, kind `audit`. For a question about the product, `category: product-intent`: the `problem` says what the product does, at which site, and what someone would expect; the `options` are what the corpus could commit to, never a patch. For a question about the project's own tooling or environment, `category: tooling`: the `problem` names the skill, prompt, rule, or tool, the run and the item ids it rests on, and what went wrong or cost more than it should; the `options` are changes to that tooling or to the environment. Then `tasks item set <id> --state promoted --note "<the issue id>"`.

### A stuck defect is a judgment issue

A `stuck` defect was fixed up to the run's limit of send-backs, and a verifier sent every fix back. The session backed its change out of the tree before you ran; a sprint check that failed after the loop has no change of its own and stands as it is. How to fix it is now the owner's choice, for the next `/plan-sprint`. Fold into it every `question` call a fixer recorded about the same defect.

- **With an `issue` field**, turn that issue into a judgment issue with one `issues revise <the issue id> --from -`: `category` set to `design` where the corpus decides the end state and only the way to reach it is open, or to `product-intent` where the answer changes what the product owes; `route` set to `null`, so `/triage-issues` routes it again; `recommendation` set to `null`, dropping the generated ruling; and `problem` set to its `problem` as `issues show <the issue id> --json` gives it, followed by a section, `## Stuck in <the run's name>`: each fix the run tried, in order, from the fixer's note; each verifier's reason, quoted; the backout task's result; and each folded `question` call, quoted. The owner's ruling, where one stands, is the owner's: the module never lets you change it.
- **With no `issue` field**, file a new issue with `issues file --from -`, kind `audit`, in the category above, with the `problem` the defect's body gives, followed by the same `## Stuck in <the run's name>` section.

Then `tasks item set <id> --state stuck --note "<the issue id>"`, and `promoted` on each folded call.

### A defect in a file the run leaves alone is a judgment or an upstream issue

A report or drive failure at `judgment` or `upstream`, or a `noticed` call in a `corpus`, `declaration`, or `suite` file, is a real defect whose fix lies in a file no agent of the run may edit, so the run spent no fix round on it. Its note names the file, the defect, and the file's kind. The kind decides the issue's category:

- `corpus`, a design-corpus artifact, a subject, or a practice: `category: design`, for the next `/plan-sprint` to change through a sprint's deltas.
- `declaration`, an owner's configuration, harness settings, review facts, release boundaries, surface intent, or document type: `category: tooling`, for the owner to change.
- `suite`, a file the suite owns, at state `upstream`: `category: upstream`, naming the file as it sits in the project, with the `upstream` draft "An upstream issue" gives.

First read `issues list --json` for an open issue on the same defect; where one stands, write nothing and name its id in your close. Fold items that name one defect into one issue.

- **With an `issue` field**, the item came from a defect issue the backlog took up: turn that issue into a judgment or an upstream issue with one `issues revise <the issue id> --from -`: `category` set to the category above; `route` set to `null`, so `/triage-issues` routes it again; `recommendation` set to `null`, dropping the generated ruling; and `problem` set to its `problem` as `issues show <the issue id> --json` gives it, followed by a section, `## Left alone in <the run's name>`: the file, its kind, and why no agent of the run may edit it. For a `suite` file, set `upstream` to the draft too.
- **With no `issue` field**, file one issue with `issues file --from -`, kind `audit`. The `problem` names the file, the site in it, the defect, the evidence, quoted, the run and, in sprint mode, the sprint, and the item ids it rests on; the `options` are changes to that file, or, for a `suite` file, a workaround in the project, a filing upstream, or both, with the `upstream` draft.

Then settle the item: `--note "<the issue id>"` on its `judgment` or `upstream` state, or `--state promoted --note "<the issue id>"` for a call.

### Close the issues the run resolved

Closing an issue moves its record to the archive, `.ok-planner/history/issues.jsonl`. For every defect with an `issue` field that stands `verified`, close its issue as fixed: `issues close <the issue id> --as fixed --fixed-by <the run's name>`. For every report with an `issue` field that the merge rejected as `gone`, close its issue as answered, with a reason that says what the run found: `issues close <the issue id> --as answered --reason "<the site, and what the code does now>"`. For every report with an `issue` field that the merge rejected as `left alone`, close its issue the same way, `--as answered`, with a reason that names the file, its kind, and the act that owns it: for a record, the act that writes it, such as a sprint's execution for a sprint, `/audit` for an audit or an experiment, or `/plan-sprint` and `/triage-issues` for an issue; for a document the release regenerates, `/document`.

### Rules

Write the intake through `.ok-planner/bin/issues` alone, and nothing else: never edit `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl` by hand. Each issue's id is a short slug naming its harm or question, unique among the open issues; the module refuses an id already open, so pick another. Where the module refuses a write, its message says why: fix the input and run the verb again. Stage the two store files by name where you changed them. Do not commit. Write under the technical writing standard in your project rules.

### Close

`tasks close <task> --outcome done --staged <the store files you changed> --result "intake: <n> defect issues written, <n> product issues written, <n> tooling issues written, <n> upstream issues written, <n> left-alone issues written or turned (<n> design, <n> declaration, <n> suite), <n> stuck issues turned or written, <n> already stood; nothing filed for <n> records and release documents; closed: <n> fixed, <n> gone, <n> left alone"`.

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
- The converge core at `plugins/ok/families/ok-planner/admin/converge`, run at the project root: it rewrites the vendored suite layer and the estate this repository dogfoods. A driver runs it only against a scratch project, as "Resources a driver starts" says.

## The helpers the catalogs name

The tree has no event emitter, no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/oscillation`: each takes no inputs and is run by `checks/run`.
- `plugins/ok/families/ok-planner/admin/converge`: takes a mode (`diagnose`, none for converge, `resolve <id> [choice] [--from <draft>]`, `amend <config path> --from <draft>` with the config path `.ok-planner/config.json` or `.ok-planner/review/config.json`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, and `wire-env`).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand. The tracker's `item add --from <path|->` reads JSON Lines, one item per line with `body` and `fields` and optionally `fingerprint` and `state`, and adds every item in one write or none.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand. `file`, `revise <id>`, `respond <id>`, and `import` each read one JSON object (records, for `import`) from `--from <path|->`, and `import` also takes `--over-event-log`, `--over-archived-event-log`, and `--dry-run`, which checks the import under the lock, prints what it would write, and writes nothing. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, one line saying what changed, and needs both on a routed or ruled issue unless the change is link-only. `close <id>` takes `--from <path|->`, or `--as`, `--reason`, and `--fixed-by` in its place. `rule <id>` and `comment <id>` take `--text <text|->`. `edit <id> <n> --text <text|->` rewrites, and `remove <id> <n>` removes, the owner's own message number `n`. `unrule <id>` withdraws the owner's ruling. `flag <id>` and `unflag <id>` set and clear the discussion flag. `read <id> [--opened <time>]` marks every agent message read. `promote <id> --sprint <file>` stamps a sprint. `linked <id>` records that triage checked an issue's links. The readers are `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, `--flagged`, `--json`), `show <id> [--opened <time>] [--json]`, `links` (`--broken`, `--pending`, `--json`), and `history [--json]`. `--opened` names one record among several closed records under the same id, by its opened time. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one) and `--open` (opens the page in the default browser once the service listens). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input:
  - `GET /api/meta`; `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`); `GET /api/closed` (query `category`); `GET /api/issue/<id>` (query `opened`); `GET /api/file` (query `path`, a path relative to the project root; it refuses a path outside the root, under `.git`, or one git ignores).
  - `POST /api/issue/<id>/rule` and `/comment`, each with a JSON body `{"text": ...}`; `POST /api/issue/<id>/read` (query `opened`); `POST /api/issue/<id>/unrule`, `/flag`, and `/unflag`; `POST /api/issue/<id>/message/<n>/edit` with a JSON body `{"text": ...}`, and `POST /api/issue/<id>/message/<n>/remove`.
  - Every request carries a `Host` of `127.0.0.1:<port>` or `localhost:<port>`, and every POST `Content-Type: application/json`.
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

