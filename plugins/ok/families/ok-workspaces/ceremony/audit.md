# ok-workspaces — audit ceremony surface

What the suite's periodic audit does about this family's estate.
Materialized into consumer projects at `.ok-workspaces/ceremony/audit.md`;
the ceremony reads it there when `.ok-workspaces/` exists.

## Requires

`.ok-workspaces/config.json` — the committed stack profile. It decides
which checks apply, so without it this surface contributes nothing and
says so in one line.

## Enumerate

This family holds no catalog of durable artifacts, so it contributes no
per-artifact determinations and writes no audit files. What it
contributes is a **discipline sweep**: a read-only pass over the
project against the mechanical rules the discipline admits, reported
in-context.

## Sweep

Read `.ok-workspaces/config.json` first — the profile decides which
checks apply — then run each applicable check and report findings with
`file:line` evidence. Fix nothing; the caller fixes and re-runs.

1. **No mutable tags in verification paths** (all profiles with
   `docker` in `stacks`). Search test code, harnesses, CI config, and
   compose files used by tests for image references pinned to mutable
   tags: `rg -n ':latest|:dev\b|:main\b|:stable\b' <test/harness/CI paths>`.
   A mutable tag in an interactive-dev path is fine; in anything a test
   resolves, it is a finding — verification must go through the src-tag
   derivation (or an explicit env override), with a loud failure when
   the tag is missing. Judge each hit's path honestly; do not flag
   dev-only compose files.
2. **Runtime isolation is parameterized** (profile
   `runtime: "docker-compose"`). Compose files must not pin identity or
   endpoints that two concurrent workspaces would fight over:
   `container_name:` with a fixed value, fixed host-port mappings
   (`"8080:80"` with no env var), fixed named volumes not derived from
   the project name. Each is a finding — the fix is env-parameterization
   so `COMPOSE_PROJECT_NAME` (and per-workspace env) namespaces
   everything. (Profile `runtime: "dev-server"`: instead grep code and
   scripts for hardcoded listen ports that ignore the profile's
   `portEnvVars`.)
3. **Worktree naming** — `git worktree list` +
   `git branch --list 'wt/*'` (per the profile's prefixes): every live
   worktree's directory and branch match the profile's naming rule; a
   worktree on a mismatched branch, or a prefixed branch with no
   worktree and unmerged commits, is a finding.
4. **src-tag consumption** — the src-tag script exists at the profile
   path and something real consumes it: grep build files and harnesses
   for the script's path or its tag shape. A materialized script nothing
   consumes means the cheatsheet's third rule is decorative — finding,
   with the suggestion to wire it into the project's verification path.

Every finding carries a remediation class, so the caller can see at a
glance what a sweep can fix and what needs the owner's judgment:

- **mechanical** — the compliant end state is fully determined by the
  committed profile and the discipline's rules, and reaching it changes
  no decision: a worktree or branch that does not match the profile's
  naming (check 3), a `container_name:` or fixed host-port mapping that
  simply needs env-parameterizing (check 2), a prefixed branch with no
  worktree and no unmerged commits (check 3).
- **judgment** — the fix would decide something the profile does not:
  whether a given path is a verification path at all (check 1), whether
  a mutable tag there is a deliberate dev-only choice, whether an
  unconsumed src-tag script should be wired into the build or the
  profile should stop declaring it (check 4), and any finding whose
  resolution implies a profile change.

Classify every finding; when the class is genuinely unclear, call it
judgment.

## Present

```
## ok-workspaces

Status: clean | findings

### Findings
#### <check> — <file>:<line> — [mechanical | judgment]
<quoted evidence, why it violates the rule, the concrete fix>

### Remediation
- Mechanical (fixable in-cycle, on the caller's authorization): <one line per finding>
- Judgment (needs the owner's call): <one line per finding, stating the question>
```

## Boundaries

- Writes no audit files: this family has no durable artifacts to hold a
  determination about.
- Files nothing. Its findings reach the human who ran the audit; what
  they judge fork-worthy, they file.
- Never edits a file, never tears down a worktree, and never re-runs
  after fixes unless asked — the caller drives that loop.
