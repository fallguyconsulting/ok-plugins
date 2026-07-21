---
name: open
description: "ONLY activated by explicit /open slash command (or by an orchestrator starting a defined job). Never auto-triggered by conversation content."
---

# Open a Workspace

Create an isolated workspace for one job: sibling worktree, own branch, namespaced runtime. Requires a committed profile (`.ok-workspaces/config.json`) — if absent, run `ok-workspaces:affirm` first and stop at its proposal step.

Takes one argument: the job slug (kebab-case; derive one from the job description if the user didn't give one, and say which you chose).

## Steps

1. **Read the profile.** Worktree naming (`worktrees.dirPrefix`, default `../wt-`; `worktrees.branchPrefix`, default `wt/`), runtime mode, and its settings.
2. **Create the worktree.** From the main checkout's repo root:
   ```bash
   git worktree add <dirPrefix><job> -b <branchPrefix><job>
   ```
   Branch from the current HEAD unless the user names a different base. If the directory or branch already exists, stop and report — never reuse or clobber an existing workspace.
3. **Carry over ephemeral local config.** Copy untracked local-env files the stack needs from the main checkout into the worktree: `.env`, `.env.*`, and `.claude/settings.local.json` if present. Copy only files that are gitignored (tracked files came with the worktree); list what you copied.
4. **Provision the namespaced runtime.**
   - `runtime: "docker-compose"`: append `COMPOSE_PROJECT_NAME=<compose.projectPrefix>-<job>` to the worktree's `.env` (create it if absent). If the copied env pins host ports, re-allocate them for this workspace (pick free ports; note the changes).
   - `runtime: "dev-server"`: allocate this workspace's port block per the profile (`basePort + N × portsPerWorkspace`, where N = 1 + the count of existing `<dirPrefix>*` worktrees) and write each of `devServer.portEnvVars` into the worktree's `.env`.
   - `runtime: "none"`: nothing to provision.
5. **Report.** Workspace path, branch, runtime namespace (compose project name or port block), and the reminder that work happens *in the worktree* — this session's checkout stays on its own branch.

## What this skill does NOT do

- Does not start the stack — the workspace's own session does that (with images resolved via the src-tag discipline).
- Does not modify the main checkout, beyond `git worktree add`'s bookkeeping.
- Does not create a workspace over uncommitted intent: if the *job* is supposed to include current uncommitted changes, stop and ask — moving work between trees is the owner's call.
