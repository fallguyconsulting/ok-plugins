---
name: ok-workspaces
description: "ONLY activated by explicit slash command (/open, /close). Never auto-triggered by conversation content."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## What ok-workspaces is

Workspace hygiene for parallel agent work, as three rules that travel together — **one worktree per job**, **one isolated runtime stack per worktree**, **per-run artifacts** (never a mutable tag, and never a tag outliving the run, in a verification path). The rules are stack-invariant; their realization is tailored by the project's committed stack profile at `.ok-workspaces/config.json` (detection proposes, the committed file decides). The always-in-context rules live in `.claude/rules/ok-workspaces-cheatsheet.md`, materialized from the profile.

## The verbs

Each row below is single-sourced from that skill's own frontmatter description — a repo maintenance check asserts row-description agreement, so a change starts at the description and the row follows. Read the skill body itself before running one. Invoke by slash command, or via the Skill tool (`ok-workspaces:<name>` from the installed plugin; the materialized name in a vendored project).

| Skill | What it does |
|-------|--------------|
| `/open` | Creates one job's isolated workspace: a worktree on its own branch per the profile's naming, ephemeral local config carried over, and the namespaced runtime provisioned. |
| `/close` | Safety-gated teardown of a job's workspace: refuses on uncommitted work or an unmerged branch, then stops the runtime, removes the worktree, and deletes the branch. |

The discipline sweep is not a verb here. Planning, certification, audit, and documentation are suite-owned ceremonies covering every estate a project has; what this family contributes to each is in `.ok-workspaces/ceremony/<verb>.md`, and the sweep runs as part of `/audit`.

## The estate

- `.ok-workspaces/config.json` — the committed, authoritative stack profile. The discovery marker `/ok` keys on.
- `.ok-workspaces/bin/run-tag` (path profile-configurable) — the canonical per-run tag script: prints `run-<12 hex>`, a fresh value on every invocation. A verification run mints one tag, builds every artifact it verifies under it, and hands the tag to its tests through the one environment variable the project declares for it. POSIX sh with no dependency beyond a POSIX userland, so it runs where node and git are absent.
- `.ok-workspaces/worktrees/` — where job worktrees live by default, inside the project root so nothing escapes it. Checkouts, not repo content: `.ok-workspaces/.gitignore` (suite-owned, written on converge) keeps them untracked. A project may point `worktrees.dirPrefix` elsewhere; the committed profile decides.
- `.ok-workspaces/ceremony/` — one file per suite ceremony verb, saying what this family contributes to it. Suite-owned, overwritten on converge.
- `.claude/rules/ok-workspaces-cheatsheet.md` — the always-in-context rules, rendered from the profile, wholly plugin-owned.

<!-- Materialized by ok-workspaces v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
