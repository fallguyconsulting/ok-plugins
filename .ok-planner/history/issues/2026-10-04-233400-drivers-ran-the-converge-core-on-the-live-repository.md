---
issue: drivers-ran-the-converge-core-on-the-live-repository
kind: audit
category: tooling
artifacts: []
status: promoted
triage: question
opened: 2026-10-04T23:34:00Z
sprint: 2026-10-05-drain-the-intake.md
---

# Story drivers rewrote this repository's vendored suite layer, and nothing yet stops a driver from doing it again

During sprint certification run converge-2026-10-04T060800, story drivers wanted to read the usage of the converge core, the script at `plugins/ok/families/ok-planner/admin/converge` that installs and refreshes the suite's files in a project. They ran it with `--help` from the repository root. The core took `--help` as its default mode and converged the repository itself, at 06:09:23 and again at 06:09:38. Later drivers repeated the call.

That run rewrote the vendored suite layer this repository dogfoods: skills, agents, hooks, and rules under `.claude/`, plus the live sprint, `.ok-planner/config.json`, and `.ok-planner/review/config.json`. It staged the `.ok-plumbline/` estate as moved or deleted into `.ok-planner/`, and left only `bin/` of `.ok-workspaces/`. The code that did this is the unreleased source in `plugins/`, not the released v23.0.0 the owner's `/ok` would install. `.ok-planner/review/project.md`, the owner's facts for the review loop, says only `/ok` rewrites that layer. The project's decision that administration runs only when a user asks (administration-is-a-user-act) says the same: the rewrite belongs at a moment the owner is watching.

## What the tree shows now

- The core is fixed for this trigger. `-h`, `--help`, and `help` print usage and exit 0. Any other argument that names no mode is refused with "names no mode; nothing written". A bare `converge` still converges the working directory, by design.
- The stray rewrite still stands in the working tree. The owner has not chosen to keep it or restore it, and the session went on working on top of it.
- `.claude/settings.json` still runs the edit-time lint hook from `.ok-plumbline/hooks/post-edit.js`. The stray rewrite removed that file; its replacement sits at `.ok-planner/hooks/post-edit.js`. The edit-time lint does not run in this repository.
- Nothing keeps a driver off the project root. The drive prompt (`plugins/ok/families/ok-planner/skills/converge/prompts/drive.md`) says "Edit nothing, stage nothing, commit nothing" and bars `git checkout`, `restore`, `reset`, `stash`, and `clean`. It says nothing about a script that writes when run. project.md lists `/ok` under "What no agent of this loop ever runs" but not the converge core, which makes the same rewrite. Its "Resources a driver starts" section tells a driver to point the core at a `mktemp -d` scratch folder, but does not forbid the root.
- Separately, driver t6 stalled 75 minutes on one task-tracker call. The tracker takes an exclusive file lock with no timeout (`plugins/ok/families/ok-planner/scripts/tasks`, `fcntl.flock(..., LOCK_EX)`), so a waiter blocks for as long as the holder keeps the lock. The run recorded no holder, so the cause is unknown.

The drive prompt, the core, and the tracker are product source in this repository, and project.md is the owner's own file, so every change below is this repository's own work, not an upstream request. The design corpus says a driver "uses only what a user in that role has" (drive-tries-each-story-as-a-user) and says nothing about the project root or about keeping or restoring a stray rewrite.

## Options

The issue holds two separate choices.

**The working tree** (an owner act):

- **Keep** the stray rewrite as this repository's converge to v23.0.0, review its diff, and consent to `converge wire-hooks lint`. Cost: the owner adopts a rewrite nobody reviewed, made by unreleased code, including rewrites of the live sprint and both config files.
- **Restore** the vendored layer and the estates from HEAD, then run `/ok`. Cost: the owner must keep the sprint's own work apart from the stray rewrite where both touched the same files.

**A guard** (these can combine):

- **Drive prompt.** The drive prompt tells every driver, in every project, to run a script that can write against a scratch copy or scratch project, never at the project root. Cost: a prompt change every consumer receives, and a read-only script such as `checks/run` may also move to a copy when the driver cannot tell.
- **project.md.** The owner names the converge core at the root under "What no agent of this loop ever runs", or names the root off limits under "Resources a driver starts". Cost: none to the suite; it protects this repository only.
- **Tracker timeout.** The task tracker gives up a lock wait it cannot win, with an error. Cost: a timeout to choose, and a slow lock holder now fails its waiters. This is separable from the rest.

The ruling decides what to do with the stray rewrite, and which guard keeps a driver from repeating it.

## Ruling

The working tree: kept. On 2026-10-04 the owner accepted the stray rewrite as this repository's converge, because the real converge produces the same result; the session ran the converge core, consented to `wire-hooks lint`, accepted the retired-script offer for `.ok-workspaces/bin/run-tag`, and staged the vendored layer.

The guard: both. The drive prompt states that "edit nothing" covers every write a driver's commands make in the project tree, so a driver runs any script that may write against a scratch copy or scratch project and never at the project root. This repository's `.ok-planner/review/project.md` also names the converge core at the root under "What no agent of this loop ever runs".

The tracker's lock wait is out of this ruling; file it as its own issue once a run records the lock holder.
