# This project, for the review loop

The owner writes this file. The review loop pastes it into every prompt that reads or runs the tree. It holds the facts a general loop cannot know. Replace each instruction line below with this project's facts, and leave a section empty where the project has nothing to say.

## The root and what is out of scope

The project root is the ok-plugins monorepo root, the folder that holds `.claude-plugin/marketplace.json`. The shipped product is `plugins/` (`plugins/ok`, `plugins/ok-conduct`, `plugins/ok-web`) and the families the front door carries at `plugins/ok/families/`. No agent edits the vendored suite layer this repo dogfoods: `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, `.claude/rules/`, and the materialized files under `.ok-planner/`, `.ok-plumbline/`, and `.ok-workspaces/`; only `/ok` rewrites them. No agent reads `.ok-planner/sprints/`, `.ok-planner/sketches/`, `.ok-planner/documentation/`, or `.ok-planner/history/` unless a skill directs it. A sprint lists no folders outside the root.

## What no agent of this loop ever runs

- `/release` (`.claude/skills/release/`): it commits, tags, and pushes to `origin`.
- `git push`, and any `git tag` pushed to `origin`.
- `claude plugin update`, `claude plugin install`, and `claude plugin marketplace update`: they change the operator's own installed plugins.
- `/ok`: it rewrites the vendored suite layer and `.claude/settings.json`, and stays an owner act.

## The helpers the catalogs name

The tree has no event emitter, no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/hub-rows`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/oscillation`: each takes no inputs and is run by `checks/run`.
- `plugins/ok/admin/converge` and `plugins/ok/families/<family>/admin/converge`: take a mode (`diagnose`, none for converge, `resolve <id> [choice] [--from <draft>]`, `wire-hooks`, and `wire-env` on the front door's own core).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand.
- `plugins/ok/families/ok-plumbline/bin/plumbline`: takes a path to lint.

## Drive commands

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the converge cores' command lines, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-plumbline/bin/plumbline`, `.ok-workspaces/bin/run-tag`), and the hooks the plugins and the vendored layer wire. No surface signs a user in.

## Resources a driver starts

A driver that needs a consumer project makes a scratch folder with `mktemp -d`, runs `git init` in it, drives the converge cores from `plugins/ok/` against it, and deletes the folder when done.

## Stories that drive alone

## Stories that drive on an instance of their own
