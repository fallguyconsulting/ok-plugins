---
name: audit
description: "ONLY activated by explicit /audit slash command. Never auto-triggered by conversation content. Read-only compliance sweep of the discipline's mechanical rules — mutable tags in verification paths, unparameterized runtime isolation, worktree naming, src-tag consumption; reports findings with evidence and fixes nothing."
---

# Audit — Workspace-Discipline Compliance

Read-only sweep of the project against the mechanical rules the discipline admits. Reports findings with file:line evidence; fixes nothing (the caller fixes and re-runs). Read `.ok-workspaces/config.json` first — the profile decides which checks apply.

## Checks

1. **No mutable tags in verification paths** (all profiles with `docker` in `stacks`). Search test code, harnesses, CI config, and compose files used by tests for image references pinned to mutable tags: `rg -n ':latest|:dev\b|:main\b|:stable\b' <test/harness/CI paths>`. A mutable tag in an interactive-dev path is fine; in anything a test resolves, it's a finding — verification must go through the src-tag derivation (or an explicit env override), with a loud failure when the tag is missing. Judge each hit's path honestly; don't flag dev-only compose files.
2. **Runtime isolation is parameterized** (profile `runtime: "docker-compose"`). Compose files must not pin identity or endpoints that two concurrent workspaces would fight over: `container_name:` with a fixed value, fixed host-port mappings (`"8080:80"` with no env var), fixed named volumes not derived from the project name. Each is a finding — the fix is env-parameterization so `COMPOSE_PROJECT_NAME` (and per-workspace env) namespaces everything. (Profile `runtime: "dev-server"`: instead grep code and scripts for hardcoded listen ports that ignore the profile's `portEnvVars`.)
3. **Worktree naming** — `git worktree list` + `git branch --list 'wt/*'` (per the profile's prefixes): every live worktree's directory and branch match the profile's naming rule; a worktree on a mismatched branch, or a `wt/`-prefixed branch with no worktree and unmerged commits, is a finding.
4. **src-tag consumption** — the src-tag script exists at the profile path and something real consumes it: grep build files and harnesses for the script's path or its `src-` tag shape. A materialized script nothing consumes means rule 3 of the cheatsheet is decorative — finding, with the suggestion to wire it into the project's verification path.

## Output

Every finding carries a remediation class, so the caller can see at a
glance what a sweep can fix and what needs the owner's judgment:

- **mechanical** — the compliant end state is fully determined by the
  committed profile and the discipline's rules, and reaching it changes
  no decision: a worktree or branch that does not match the profile's
  naming (check 3), a `container_name:` or fixed host-port mapping that
  simply needs env-parameterizing (check 2), a `wt/`-prefixed branch
  with no worktree and no unmerged commits (check 3).
- **judgment** — the fix would decide something the profile does not:
  whether a given path is a verification path at all (check 1), whether
  a mutable tag there is a deliberate dev-only choice, whether an
  unconsumed src-tag script should be wired into the build or the
  profile should stop declaring it (check 4), and any finding whose
  resolution implies a profile change.

```
Status: clean | findings

## Findings
### <check> — <file>:<line> — [mechanical | judgment]
<quoted evidence, why it violates the rule, the concrete fix>

## Remediation
- Mechanical (fixable in-cycle, on the caller's authorization): <one line per finding>
- Judgment (needs the owner's call): <one line per finding, stating the question>
```

Classify every finding; when the class is genuinely unclear, call it
judgment. Read-only: report and stop. Do not edit files, do not re-run
after fixes unless asked — the caller drives the loop.
