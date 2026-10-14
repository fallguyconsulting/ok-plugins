---
topic: workspace-lifecycle
kind: concept
---

# Workspace lifecycle: /open and /close safety gates

## Description

`/open <job>` creates one isolated workspace: read the profile (naming, runtime); `git worktree add <dirPrefix><job> -b <branchPrefix><job>` from the main checkout's repo root (branch from current HEAD unless another base is named; "If the directory or branch already exists, stop and report — never reuse or clobber an existing workspace"); carry over **gitignored-only** local env files (`.env`, `.env.*`, `.claude/settings.local.json` — "Copy only files that are gitignored (tracked files came with the worktree); list what you copied"); provision the namespaced runtime (compose: append `COMPOSE_PROJECT_NAME=<prefix>-<job>` to the worktree's `.env`, re-allocating pinned host ports; dev-server: write the workspace's port block into `portEnvVars`; none: skip); report path, branch, namespace, and "the reminder that work happens *in the worktree* — this session's checkout stays on its own branch." Preconditions ripple back to true-up: no committed profile → run true-up first; missing `.ok-workspaces/.gitignore` → run true-up "rather than leaving a checkout that `git status` offers to commit." NOT-do: doesn't start the stack ("the workspace's own session does that"); doesn't move uncommitted intent ("if the *job* is supposed to include current uncommitted changes, stop and ask — moving work between trees is the owner's call").

`/close <job>` is "safety-gated teardown. The gates exist because a worktree is the only record of its uncommitted work — closing must be incapable of destroying anything." **Gate 1 — clean tree**: `git -C <worktree> status --porcelain` empty, else stop and report the dirty paths ("the fix (commit, or explicitly discard) is the owner's act in that workspace, never this skill's"). **Gate 2 — merged branch**: fully contained in the integration branch (default branch unless named), via `git branch --merged` / `git cherry`, else stop with exactly what remains. "Never bypass a gate on your own judgment. The user saying 'close it anyway, discard the work' is the only override, and then you do exactly that and nothing broader." Teardown after both gates: stop the runtime (`docker compose -p <prefix>-<job> down --volumes` — "the project-name flag is what scopes the teardown to this workspace's stack and nothing else"; dev-server: report still-listening processes "instead of killing" them); `git worktree remove` (**never `--force`** — "a force need means gate 1 lied; stop and re-check"); `git branch -d` (**`-d`, not `-D`** — "it only succeeds because gate 2 passed"); report the merge commit the work survives in and any leftovers.

The plugin CLAUDE.md elevates the gates to a constraint: "close's gates (clean tree, merged branch) are load-bearing — a worktree is the only record of its uncommitted work. Never add `--force`/`-D` paths." Both verbs admit orchestrator invocation ("or by an orchestrator starting/finishing a defined job").

## Code surface

- `plugins/ok-workspaces/skills/open/SKILL.md`, `skills/close/SKILL.md`.
- Naming resolution from the profile (`worktrees.dirPrefix`, `worktrees.branchPrefix`); audit check 3 polices conformance after the fact.

## Prose surface

- `plugins/ok-workspaces/CLAUDE.md` Constraints; index skill table rows.

## Adjacent topics

- `workspace-discipline`, `stack-profile`, `src-tag`, `ownership-and-consent` (the only-override rule), `ok-conduct` (never-destroy-uncommitted-work is the same value on the session side).

## Observations

- The `-d`-not-`-D` and no-`--force` choices encode the gates into the git flags themselves — the teardown commands are chosen so they *can only succeed if the gates were honest*, a mechanical-check instinct applied to a prompt-driven verb.
- `/close`'s integration-branch default ("the repo's default branch unless the user names another") is determined by prompt judgment; nothing specifies how to resolve the default branch (contrast the release skill's explicit `git ls-remote --symref` recipe).
