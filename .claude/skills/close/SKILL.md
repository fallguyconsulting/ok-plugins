---
name: close
description: "ONLY activated by explicit /close slash command (or by an orchestrator finishing a defined job). Never auto-triggered by conversation content. Safety-gated teardown of a job's workspace: refuses on uncommitted work or an unmerged branch, then stops the runtime, removes the worktree, and deletes the branch."
---

# Close a Workspace

Safety-gated teardown of a job's workspace. A worktree is the only record of its uncommitted work: destroy nothing.

Takes one argument: the job slug. Resolve the worktree directory and branch from the profile's naming (`<dirPrefix><job>`, `<branchPrefix><job>`); confirm both exist via `git worktree list` and stop with a report if not.

## Gates — all must pass before any teardown

1. **Clean tree.** `git -C <worktree> status --porcelain` must be empty. Anything uncommitted → **stop**. Report the dirty paths and do nothing else: the fix (commit, or explicitly discard) is the owner's act in that workspace, never this skill's.
2. **Merged branch.** The job branch must be fully contained in the integration branch — the branch the remote actually treats as the integration branch, never a guess, unless the user names another. Resolve it from the remote itself:

   ```bash
   integration=$(git ls-remote --symref origin HEAD | awk '/^ref:/ {sub("refs/heads/","",$2); print $2}')
   ```

   (No `origin` remote → fall back to the local default branch, and say so in the report.) Then `git branch --merged <integration>` lists the job branch, or `git cherry <integration> <branch>` shows no unmerged commits. Not merged → **stop** and say exactly what remains: merge the branch (or explicitly abandon it by name), then re-run `/close`.

Never bypass a gate on your own judgment. The user saying "close it anyway, discard the work" is the only override, and then you do exactly that and nothing broader.

## Teardown — only after both gates pass

1. **Stop the runtime.** `runtime: "docker-compose"`: `docker compose -p <compose.projectPrefix>-<job> down --volumes` (the project-name flag scopes the teardown to this workspace's stack). `dev-server`: nothing persistent to stop (report any still-listening dev-server process on the workspace's port block instead of killing it). `none`: skip.
2. **Remove the worktree.** `git worktree remove <dirPrefix><job>` (never `--force` — a force need means gate 1 lied; stop and re-check).
3. **Delete the branch.** `git branch -d <branchPrefix><job>` (`-d`, not `-D`; it succeeds only where gate 2 passed).
4. **Report.** What was torn down, the merge commit the work survives in, and any leftovers (volumes kept, ports still listening) the owner should know about.

<!-- Materialized by ok-workspaces v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
