---
name: execute-plan-in-worktree
description: "ONLY activated by explicit /execute-plan-in-worktree slash command. Never auto-triggered by conversation content."
---

# Execute a Plan in an Isolated Git Worktree

Wraps `ok-planner:execute-plan` with isolation setup. Creates a git
worktree on a new branch, copies ephemeral local config (`.env*`) and
the target spec+plan into the worktree, provisions fresh host ports if
the project parameterizes them through docker-compose or `.env`, then
switches the session into the worktree (via the harness's native
worktree tool where available) and hands off to
`ok-planner:execute-plan`. The original checkout is left untouched —
useful when the host project already has a dev stack running and you
want plan execution to land on a side branch without colliding with it.

## When to use

The user explicitly types `/execute-plan-in-worktree`. Typical case: a
docker-compose-backed development loop where running a second instance
in the same checkout would fight the first for ports, volumes, or
working-tree state.

If the user is unsure whether they want isolation, they should use
`/execute-plan` instead — this wrapper is a deliberate choice.

## Process

1. **Identify the plan.**
   - If the user passed a plan path or slug as an argument, resolve it
     against the original project root (the CWD at skill start).
   - Otherwise list every file under `.ok-planner/plans/` and present
     them as a short prose list (A, B, C…) for the user to pick from.
     If the directory is empty or missing, stop and tell the user.
   - Read the plan's `**Spec:**` header. Resolve the spec path under
     the original root. If the header is `none`, missing, or points
     at a file that does not exist, proceed with no spec; note it in
     the end-of-skill summary.
   - Record the absolute path of the original project root
     (`ORIG_ROOT`). Every file operation in steps 4–6 uses absolute
     paths against `ORIG_ROOT` and the worktree and needs no session
     switch; the switch into the worktree happens in step 8 (on a
     harness that switches the session wholesale, do it just before
     step 7's affirm — see step 8).

2. **Preserve pending work on the current branch.** The wrapper
   always creates a new branch for the worktree (step 3 picks the
   name); the question this step answers is what that branch
   inherits. If the original checkout has uncommitted changes the
   plan will need, the worktree should see them — so the skill
   commits them on the current branch first, and the new worktree
   branches off the resulting HEAD.

   Detect the relevant state with `git symbolic-ref -q HEAD`
   (returns empty when detached) and `git status --porcelain` (any
   output = dirty). Branch on the 2×2:

   - **Clean + on branch** → proceed.
   - **Clean + detached HEAD** → proceed. The new worktree branch
     starts from the detached commit; nothing is at risk.
   - **Dirty + on branch** → stage everything (`git add -A`) and
     commit on the current branch. Use this message:
       ```
       wip: preserved by /execute-plan-in-worktree

       Pending changes auto-committed before creating worktree
       branch <branch-name> for plan <plan-basename>. Undo with
       `git reset --mixed HEAD^` on the original checkout to
       restore these as unstaged changes.
       ```
     Capture the new HEAD sha and the file count for the
     end-of-skill summary so the user can find or undo the commit
     trivially. Use `git add -A` (not `-u`) so newly-created files
     come along; `.gitignore` is what keeps secrets and build
     artifacts out. If the user's `.gitignore` is incomplete, the
     auto-commit is a symptom, not the cause — surface anything
     surprising in the summary.
   - **Dirty + detached HEAD** → stop and escalate. The skill
     cannot auto-commit without a branch to commit onto, and
     silently creating a salvage branch is the kind of "what just
     happened to my HEAD" surprise to avoid. Tell the user:
     "Detached HEAD has uncommitted changes — create a branch
     (`git switch -c <name>`) and re-run, or stash and re-run."

   After this step the original checkout is in one of three valid
   states for step 4: on a branch (originally clean or just
   auto-committed), or at a clean detached commit.

3. **Pick the worktree path and branch name.**
   - Branch name: `ok-planner/<plan-basename-without-extension>`.
   - Worktree path: sibling directory
     `<dirname(ORIG_ROOT)>/<basename(ORIG_ROOT)>-<branch-leaf>`
     resolved to an absolute path (e.g. `/Users/p/code/myapp` →
     `/Users/p/code/myapp-add-auth`).
   - If either the branch or the path already exists, append `-2`,
     `-3`, … until both are free. Surface the chosen path in the
     end-of-skill summary so the user can spot collisions.

4. **Create the worktree.**
   ```
   git -C <ORIG_ROOT> worktree add -b <branch> <worktree-path> HEAD
   ```
   If this fails, stop and surface the error — do not paper over it
   and proceed into setup with a half-built worktree.

5. **Copy ephemeral local config from the original root to the
   worktree.** These are files git ignores but the running app
   depends on. Scan `ORIG_ROOT` (not recursively — top level only is
   the common case; recurse only if the project's convention puts
   env files in a subdirectory like `apps/web/.env` and the
   user/project layout makes that obvious):
   - `.env`, `.env.local`, `.env.*` (including `.env.development`,
     `.env.test`, etc.)
   - `.envrc` (direnv)
   - Any other top-level dotfile config that git ignores AND the
     project clearly needs at runtime (use `git check-ignore -v
     <file>` to confirm a file is gitignored before copying — copying
     a tracked file is fine but copying something the user
     deliberately committed differently is rude).

   Use `cp -p` to preserve modes/timestamps. Do not follow symlinks
   blindly (`cp -P`). Do not copy `node_modules/`, build outputs,
   virtualenvs, `.git/`, or anything else regeneratable.

   Record the copied list for the end-of-skill summary.

6. **Provision fresh host ports if the project parameterizes them.**
   Heuristic:
   - Look for `docker-compose.y*ml`, `compose.y*ml`,
     `docker-compose.*.y*ml` at `ORIG_ROOT`. In each, scan `ports:`
     blocks for `${VAR_NAME[:-default]}` patterns. Collect the set
     of port-controlling env-var names plus their defaults.
   - Scan the just-copied `.env*` files in the worktree for keys
     matching `*_PORT$` or `^PORT$`. Add those to the set.
   - If the set is empty, skip this step silently — most projects
     don't need it.
   - For each port var, in a stable order:
     a. Read the current assignment (worktree `.env*` first, else
        the docker-compose default).
     b. Pick a free TCP port starting from `current + 1000` and
        probing upward. Probe with `lsof -nP -iTCP:<n> -sTCP:LISTEN`
        (preferred) or `nc -z localhost <n>` (fallback). Skip any
        port currently bound on the host or already chosen earlier
        in this run.
     c. Write or update the assignment in the worktree's
        `.env.local` (create it if absent). Prefer `.env.local` over
        `.env` so a later `git pull` cannot clobber the override
        if `.env` is tracked.
   - Record the var → port mapping for the summary.

   If neither `lsof` nor `nc` is available on this system, stop and
   surface that — port provisioning without a probe is a guess, and
   guessing port numbers in an isolation skill defeats the purpose.

7. **Copy the spec and plan into the worktree's `.ok-planner/`.**
   The local versions on the original checkout are usually ahead of
   what's committed (often not committed at all). The worktree starts
   from HEAD, so without this copy the plan files would be missing
   or stale inside the worktree.
   - Invoke `ok-planner:affirm` from the worktree to ensure
     `.ok-planner/{plans,specs,...}` exists there. Affirm must run
     against the worktree, not the original checkout. On a harness
     that switches the session wholesale (step 8's native-tool path),
     do the step-8 switch **first**, then run affirm and the copies
     below from inside the worktree. Otherwise run affirm with the
     worktree as CWD (`cd <worktree> && …`) or via any mechanism that
     targets the worktree — the mechanical detail does not matter,
     only that affirm lands in the worktree.
   - Copy `<ORIG_ROOT>/<plan-relpath>` to
     `<worktree>/<plan-relpath>` (same relative path —
     `.ok-planner/plans/<basename>`). Overwrite if present.
   - If a spec path was resolved in step 1, copy
     `<ORIG_ROOT>/<spec-relpath>` to `<worktree>/<spec-relpath>`
     similarly.
   - The originals stay in place on the original checkout. When
     `execute-plan` later archives, it archives the **worktree's**
     copies; the originals stay until the user merges the worktree
     branch back or cleans them up manually.

8. **Switch the session into the worktree.** Everything that follows
   — affirm, the plan copy, and especially `execute-plan`'s pass
   implementers — must run *inside* the worktree, not the original
   checkout. How depends on the harness:

   - **If the harness exposes a native worktree session-switch**
     (Claude Code: `EnterWorktree` with `path: <worktree>`), use it to
     adopt the worktree created in step 4 and switch the session into
     it. This is the robust path: it repoints the session's working
     directory — and every subsequent tool call and dispatched
     subagent — at the worktree. Enter the *existing* worktree by
     `path`; do **not** use the tool's create mode (it would spawn a
     second worktree with its own naming/base-ref). The user invoking
     `/execute-plan-in-worktree` is the explicit instruction such
     tools require.
   - **Otherwise**, prefix every subsequent command with
     `cd <worktree> && …` and pass the absolute worktree path into
     each dispatched subagent. A lone `cd <worktree>` is **not**
     reliable — many harnesses (Claude Code included) reset the shell
     working directory to the project root after each command, so it
     silently fails to persist and the run lands in the original
     checkout. Never depend on `cd` persistence.

   **Verify before handing off:** run `pwd` and `git rev-parse
   --show-toplevel`; both must resolve to the worktree. If they do
   not, the switch did not take — stop and fix it. The failure is
   silent, and a subagent that runs in the original checkout mutates
   the very tree this skill exists to protect.

   *Cleanup note:* a worktree entered by `path` is **not** removed by
   the session-switch tool's exit (`ExitWorktree`) — `keep` simply
   returns the session to the original directory, consistent with the
   "Do not delete or remove worktrees" rule below. Leave the session
   in the worktree through handoff; never tear it down.

9. **Surface the setup summary.** Before handing off, emit a short
   block the user can scan:
   ```
   Worktree:   <absolute path>
   Branch:     <branch name>
   Base:       <commit sha + original branch name>
   Preserved:  <sha-short> on <original-branch> (N files; `git reset --mixed HEAD^` on the original checkout to undo)   [omit this line if step 2 didn't auto-commit]
   Env files:  <comma-separated list>
   Ports:      WEB_PORT 3000 → 4000, DB_PORT 5432 → 6432  (or "none provisioned")
   Plan:       <path inside worktree>
   Spec:       <path inside worktree, or "none">
   ```

10. **Hand off to `ok-planner:execute-plan`.** Invoke the skill with
    the plan path. Because the session is now in the worktree (step
    8), the plan's original-relative path resolves against the
    worktree — the path string is identical either way. From here,
    `execute-plan` owns the run: it drives the plan pass by pass as a
    background `Workflow` (dispatching pass implementers, flip-gating
    verification, repairing defective gates, running the divergence
    audit, archiving inside the worktree). Do not shadow or replicate
    any of its behavior.

    **Worktree-locality of the workflow.** `execute-plan` executes as a
    background `Workflow` whose dispatched agents run shell commands —
    those agents MUST operate in the worktree, not the original
    checkout, or the isolation this skill exists for is lost. The step-8
    switch must still be in effect when `execute-plan` launches the
    Workflow. After the workflow starts, confirm its agents are in the
    worktree (e.g. the first agent's `git rev-parse --show-toplevel`
    resolves to the worktree path); if the harness runs background
    workflow agents from the original checkout regardless of the session
    switch, stop and surface it — do not let the run mutate the original
    tree.

## Rules

- The original checkout is read-only **except for the optional
  preservation commit in step 2** (when on a branch with pending
  changes). Everything else writes into the new worktree (or,
  indirectly, into `.git/worktrees/<name>/` via `git worktree add`).
- Do not commit anything in the worktree. `execute-plan` already
  enforces this; the wrapper does too.
- Do not delete or remove worktrees. Cleanup (`git worktree remove`)
  is the user's call — there may be in-progress build state or work
  they want to preserve.
- Do not start a worktree off `main`/`master` without explicit user
  consent. If the original checkout is on `main` or `master`, ask
  before running step 4.
- If any setup step fails, stop and surface the partial state.
  Do not advance into `execute-plan` with a half-built worktree.

## What this skill does NOT do

- Does not install dependencies in the worktree (`npm install`,
  `pip install`, etc.). The plan's first pass — or the project's
  own bootstrap — handles that. If the user wants the wrapper to
  bootstrap, they can say so and the orchestrator can run the
  obvious command after step 8 and before step 10.
- Does not start services, run migrations, seed databases, or
  otherwise touch runtime state inside the worktree. The plan is
  responsible for whatever runtime setup it needs.
- Does not merge the worktree branch back, push it, or open a PR.
  Those are user-initiated actions after the plan completes.
- Does not modify the original checkout's `.env*` or any config.
  Port overrides are written **only** to the worktree's
  `.env.local`.
