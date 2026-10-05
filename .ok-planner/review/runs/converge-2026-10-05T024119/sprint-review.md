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

Skill text is code. A skill is a prompt the product ships for an
agent session to run: its body, the prompts and shared blocks it
reads, and the scripts and tools it calls. Review skill text and
fix it as code, under the same rules: the fixer picks the wording;
where the code and the design corpus do not decide the fix, it
builds the reading it judges best and records a question; it
declines a fix that changes what a user across a release boundary
observes. Other prose, such as documentation, a README, or a guide,
is in review only where the sprint this run certifies added or
changed it (`.ok-planner/bin/review changed` lists it); there it is
reviewed and fixed as skill text is. Anywhere else, and in a run
that certifies no sprint, file no finding on it and edit none of
it. No agent of this run edits the design corpus, an estate
(`.claude/`, `.ok-planner/`), a document the release regenerates,
or a file the suite materializes.

This run certifies the sprint at .ok-planner/sprints/2026-10-05-drain-the-intake.md. Its change runs from the base commit e32d4523520633f24cfc9659cf791d4450d7c514 to the working tree. Leave the sprint's completion report and its build run file, where it has one, to the alignment pass: the other passes judge the code blind to the executor's account of it, so a divergence the executor did not record surfaces as a report.

### Read once

1. The sprint, whole: intent, deltas and their sidecar, work items, implementation notes. Every artifact under `.ok-planner/design/` a delta names or a work item cites, in full. `.ok-planner/release-boundaries.md` where it exists.
2. The change: `.ok-planner/bin/review changed --base e32d4523520633f24cfc9659cf791d4450d7c514 --sprint .ok-planner/sprints/2026-10-05-drain-the-intake.md` lists every file the sprint added, changed, or deleted, relative to the project root and less the paths `.ok-planner/review/config.json` excludes. It includes the files under each folder the sprint lists under `## Paths outside the project root`, as paths starting `../`. Write down that list. Read each file's diff with `git diff e32d4523520633f24cfc9659cf791d4450d7c514 -- <path>`, and each added file whole.
3. Every changed file in full, as it stands now, and each changed file's base version where the diff alone does not show a changed definition whole (`git show e32d4523520633f24cfc9659cf791d4450d7c514:./<path>`, the `./` making the path relative to the project root).
4. Each work item's and each taken improvement's path: from the entry point that reaches its outcome to the outcome, reading every unchanged file the path crosses in full.
5. The users of each changed definition that existed at the base: its callers and references (load the LSP with `ToolSearch("select:LSP")`; `rg` for the rest), code that reads the same stored data or configuration, and what each release boundary's Where to look names. Read each user's calling function in full.

This reading is the whole reading, and it fixes the run's scope: the passes read nothing else.

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
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `version`).
- `plugins/ok/families/ok-planner/scripts/catalog-toc`, `plugins/ok/families/ok-planner/scripts/run-tag`, and `plugins/ok/families/ok-planner/scripts/port-block`: the catalog TOC generator (a project root, or `--check`), the run tag minter (no inputs), and the port readback (a run tag).

## Drive commands

- No stack: the product runs inside a Claude Code session; its stories are offered through skills, which drivers review, and through the converge core and the materialized scripts, which drivers run against a scratch project.

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the converge core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/port-block`), and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project makes a scratch folder with `mktemp -d`, runs `git init` in it, drives the converge core at `plugins/ok/families/ok-planner/admin/converge` against it, and deletes the folder when done.

## Stories that drive alone

## Stories that drive on an instance of their own

