---
name: ok-workspaces
description: "ONLY activated by explicit slash command (/open, /close, /true-up, /audit). Never auto-triggered by conversation content."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## What ok-workspaces is

Workspace hygiene for parallel agent work, as three rules that travel together — **one worktree per job**, **one isolated runtime stack per worktree**, **content-addressed artifacts** (never a mutable tag in a verification path). The rules are stack-invariant; their realization is tailored by the project's committed stack profile at `.ok-workspaces/config.json` (detection proposes, the committed file decides). The always-in-context rules live in `.claude/rules/ok-workspaces-cheatsheet.md`, materialized from the profile.

## Available Skills

Invoke via the `Skill` tool with the `ok-workspaces:` prefix.

| Skill | When to use |
|-------|-------------|
| `ok-workspaces:true-up` | Plumbing — normally driven by `/ok`; also user-invokable as `/true-up` (or another skill needs the estate). Diagnoses first (fresh detection vs the declared profile — the "docker got introduced" case — materialized-script fidelity, cheatsheet version stamp), then converges. No committed profile: runs detection and declares it with the owner in conversation — one yes/no for the whole profile when detection is confident (clear signals are not judgment calls), targeted questions only for fields the repo genuinely leaves open — transcribes the declaration to `config.json`, then materializes in the same pass. Stacks/runtime drifted: presents the disagreement for the owner to resolve in conversation, transcribes the resolution. Otherwise: materializes the canonical src-tag script at the profile-declared path and the cheatsheet at `.claude/rules/ok-workspaces-cheatsheet.md`, both version-stamped. Idempotent. |
| `ok-workspaces:audit` | User types `/audit`. Read-only compliance sweep of the discipline's mechanical rules: no mutable tags (`:latest` etc.) in verification paths, runtime isolation parameterized per workspace, worktree branches matching the naming rule. Reports findings; fixes nothing. |
| `ok-workspaces:open` | User types `/open <job>`. Creates the job's worktree on its own branch (per the profile's naming — by default `.ok-workspaces/worktrees/<job>`, inside the project root), carries over ephemeral local config, and provisions the workspace's namespaced runtime (compose project name or port block per the profile). |
| `ok-workspaces:close` | User types `/close <job>`. Safety-gated teardown: refuses on uncommitted work, refuses on an unmerged branch (with instructions), then tears down the workspace's runtime stack, removes the worktree, and deletes the branch. |

## The estate

- `.ok-workspaces/config.json` — the committed, authoritative stack profile. The discovery marker `/ok` keys on.
- `.ok-workspaces/bin/src-tag` (path profile-configurable) — the canonical content-addressed tag script: prints `src-<12 hex>`, a git tree-object hash of the working tree including uncommitted changes. Byte-identical across every consumer so cooperating tools always agree on the tag.
- `.ok-workspaces/worktrees/` — where job worktrees live by default, inside the project root so nothing escapes it. Checkouts, not repo content: `.ok-workspaces/.gitignore` (plugin-owned, written by true-up) keeps them untracked. A project may point `worktrees.dirPrefix` elsewhere; the committed profile decides.
- `.claude/rules/ok-workspaces-cheatsheet.md` — the always-in-context rules, rendered from the profile, wholly plugin-owned.

## When Skills Activate

**ok-workspaces skills are NOT auto-triggered.** They activate only when the user types a slash command, or when an orchestrator executing defined work invokes `open`/`close` around a job. Do NOT invoke skills based on inference about what the user might want.
