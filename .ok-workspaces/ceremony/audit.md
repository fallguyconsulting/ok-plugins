# ok-workspaces — audit ceremony contribution

What the suite's periodic audit does about this family's estate.
Materialized into consumer projects at `.ok-workspaces/ceremony/audit.md`;
the ceremony reads it there when `.ok-workspaces/` exists.

## Requires

`.ok-workspaces/config.json` — the committed stack profile. It decides
which checks apply, so without it this contribution offers nothing and
says so in one line.

## Enumerate

This family holds no catalog of durable artifacts, so it contributes no
per-artifact determinations and writes no audit files. What it
contributes is a **discipline pass**: a read-only check of the
project against the mechanical rules the discipline admits, run with
the Determine stage, its findings routed to the run report and — for
the judgment class — to the ceremony's judge.

## Determine

Read `.ok-workspaces/config.json` first — the profile decides which
checks apply — then run each applicable check and record findings with
`file:line` evidence. Fix nothing.

1. **No mutable tags in verification paths** (all profiles with
   `docker` in `stacks`). Search test code, harnesses, CI config, and
   compose files used by tests for image references pinned to mutable
   tags: `rg -n ':latest|:dev\b|:main\b|:stable\b' <test/harness/CI paths>`.
   A mutable tag in an interactive-dev path is fine; in anything a test
   resolves, it is a finding — verification must go through the tag the
   run minted, carried in the project's declared environment variable,
   with a loud failure when the variable is unset or no artifact carries
   the tag. Judge each hit's path honestly; do not flag dev-only compose
   files.
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
4. **run-tag consumption** — the run-tag script exists at the profile
   path and something real consumes it: grep build files and harnesses
   for the script's path, its tag shape, or the environment variable the
   project hands the tag to its tests in. One verification run mints the
   tag once, builds under it, and verifies under that same value; a
   second invocation inside one run mints a second tag and is a finding.
   A materialized script nothing consumes means the cheatsheet's third
   rule is decorative — finding, with the suggestion to wire it into the
   project's verification path.

Every finding carries a remediation class, so a reader can see at a
glance what a later pass can fix and what needs the owner's judgment:

- **mechanical** — the compliant end state is fully determined by the
  committed profile and the discipline's rules, and reaching it changes
  no decision: a worktree or branch that does not match the profile's
  naming (check 3), a `container_name:` or fixed host-port mapping that
  simply needs env-parameterizing (check 2), a prefixed branch with no
  worktree and no unmerged commits (check 3).
- **judgment** — the fix would decide something the profile does not:
  whether a given path is a verification path at all (check 1), whether
  a mutable tag there is a deliberate dev-only choice, whether an
  unconsumed run-tag script should be wired into the build or the
  profile should stop declaring it (check 4), and any finding whose
  resolution implies a profile change.

Classify every finding; when the class is genuinely unclear, call it
judgment. The mechanical class is recorded in the run report; each
judgment-class finding joins the orchestrator's escalations to the
ceremony's judge, which files what it confirms.

## Report

What this estate contributes to the run report:

```
## ok-workspaces

Status: clean | findings

### Findings
#### <check> — <file>:<line> — [mechanical | judgment]
<quoted evidence, why it violates the rule, the concrete fix>

### Remediation
- Mechanical (work for a future pass): <one line per finding>
- Judgment (the judge's outcome per finding): <one line each, stating
  the question and whether the judge filed or refuted it>
```

## Boundaries

- Writes no audit files: this family has no durable artifacts to hold a
  determination about.
- Files nothing of its own motion. Its findings reach the owner through
  the run report, and the judgment class through the ceremony's judge —
  the run's one gated filing path.
- Never edits a file, never tears down a worktree, and never re-runs
  after fixes unless asked.

<!-- Materialized by ok-workspaces v19.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
