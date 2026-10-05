---
issue: retire-the-worktrees-keep-run-tag-and-port-block
kind: human
category: design
artifacts:
  - concept:workspace
  - concept:stack-profile
  - concept:run-tag
  - story:isolated-parallel-workspaces
  - story:safe-workspace-teardown
  - story:fresh-artifacts-per-run
  - decision:worktrees-inside-project-root
  - decision:open-refuses-an-occupied-workspace
  - decision:teardown-gates-in-git-flags
  - decision:declared-stack-profile
  - decision:per-run-artifact-tag
status: promoted
sprint: 2026-10-04-consolidate-into-ok-planner.md
opened: 2026-10-04T04:48:06Z
---

# The suite ships worktree verbs nobody uses, and its port allocator works only through them

## Problem

ok-workspaces gives each job its own git worktree through `/open` and `/close`. The owner never used them, in this project or in a consumer project. The owner does use isolated, ad hoc stacks for testing, and two of the family's utilities serve that work:

- `scripts/run-tag` prints a fresh `run-<12 hex>` tag on every call. A verification run builds and resolves its artifacts by that tag, so concurrent runs do not collide. It does not depend on worktrees.
- `scripts/port-block <job>` prints `PORT=<n>` lines for a job's stack. It runs `git worktree list --porcelain`, keeps the worktrees under `.ok-workspaces/worktrees/`, and finds the job's position `n` in that list. It then picks ports from `basePort + n × portsPerWorkspace`. Without worktrees, every job gets `n = 1`, and two stacks get the same ports.

Any allocator in which one program picks a port and a different program binds it later races: another process can take the port in between. Hashing the run tag to a port block, or claiming a block with a lock file, narrows that race but does not close it. Only the program that binds the port closes it.

`/converge` already starts its test stacks without ok-workspaces. `review drive-command` runs the commands the owner writes for the `stack-start`, `stack-stop`, `instance-create`, and `instance-destroy` roles in `.ok-planner/review/project.md`. No line of that file mints a run tag or reads `.ok-workspaces/`.

`issue:run-tag-can-print-an-empty-tag` names a defect in `run-tag` that travels with it.

## Candidates

- Retire the worktrees, keep `run-tag`, and rework `port-block` so the stack binds ports the OS assigns and `port-block` reads them back by run tag.
- Hash the run tag to a port block, and claim the block with an exclusive-create lock file the stack's stop command deletes.
- Keep ok-workspaces whole.

## Ruling

Retire the worktrees: remove the `/open`, `/close`, and `/ok-workspaces` verbs, the worktree naming, and the workspace teardown gates, because no one uses them and isolated stacks do not need them. Keep `run-tag` and its per-run artifact rule. Keep `port-block`, reworked so the stack asks the OS for free host ports when it binds, and `port-block` reads back the ports that stack got, keyed by the run tag, and prints them as it does today. This closes the race, because the OS picks the port at the moment the stack binds it. The cost is that a project's stack must bind this way: a container stack publishes container ports with no host port given, and a dev server accepts port 0 and reports the port it got. If a project's stack cannot bind that way, its own stack commands handle isolation, and `port-block` refuses with a message saying so. The concepts, stories, and decisions that describe workspaces are retired or rewritten to match. `run-tag` and `port-block` move into ok-planner under `issue:consolidate-the-suite-into-ok-planner`.
