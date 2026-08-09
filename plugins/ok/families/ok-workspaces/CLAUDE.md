# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Family purpose

`ok-workspaces` canonizes workspace hygiene for parallel agent work as three rules that travel together: one worktree per job, one isolated runtime stack per worktree, content-addressed artifacts (never a mutable tag in a verification path). The rules are stack-invariant; realization is tailored by each consumer project's committed profile at `.ok-workspaces/config.json` via detect → declare → materialize: `scripts/detect.js` proposes, the committed config decides, `scripts/converge.js` (the converge core's write half) materializes the src-tag script, the cheatsheet, and the dot-directory `.gitignore` from it.

This is a **skill family**, not a plugin: it lives at `plugins/ok/families/ok-workspaces/` as payload inside the front-door plugin, carries no manifest of its own (every version stamp derives from the front door's manifest), and reaches consumer projects only by vendoring. Administration — install, converge, repair — is the front door's (`/ok`), driven through this family's two conventional surfaces under `admin/`: the converge core wraps `diagnose.js`/`converge.js`, and `admin/ADMINISTRATION.md` carries the profile-declaration walkthrough and drift resolution the core cannot encode.

**Worktrees default to inside the project root** (`.ok-workspaces/worktrees/<job>`), not a sibling directory: a job's checkout should never escape the project it belongs to. Because a checkout inside the repo must never become content of the repo, converge writes the ignore file that covers wherever the profile puts them: `.ok-workspaces/.gitignore` for the default location, and — because a `.gitignore` governs only its own directory — a suite-owned `.gitignore` at the declared prefix itself when the profile points worktrees at another in-repo path. The project's root `.gitignore` is never touched either way, per the ownership rule. A project that genuinely wants worktrees elsewhere declares `worktrees.dirPrefix` in its profile; that is a declaration, not drift, and diagnose reports it as such — asking `git check-ignore` itself whether a checkout there would be offered as repo content.

## Layout

```
admin/converge               # Deterministic converge core (diagnose|converge) — the surface /ok drives
admin/ADMINISTRATION.md      # Profile-declaration walkthrough and drift resolution — the judgment the core cannot encode
skills/<skill>/SKILL.md      # audit, open, close + the index skill (vendored into consumer projects on converge)
scripts/detect.js            # Read-only stack detection; prints proposed profile JSON
scripts/converge.js          # Converge write core: materializes src-tag + port-block + cheatsheet + .ok-workspaces/.gitignore + vendored skills from committed config
scripts/diagnose.js          # Converge diagnose: detection vs declaration, artifact fidelity incl. vendored skills; exit 2 on drift
scripts/vendored-skills.js   # The one derivation of the vendored-skill renderings (write and diagnose share it)
scripts/src-tag              # Canonical POSIX-sh content-addressed tag script ({{OK_WORKSPACES_VERSION}} stamped on materialize)
scripts/port-block           # Canonical dev-server port allocator — the one statement of the port arithmetic
ceremony/<verb>.md           # What this family contributes to each suite ceremony; materialized into .ok-workspaces/ceremony/
```

There are no family hooks and no session-start injection: the cheatsheet is the awareness surface, and the user-facing skills (`open`, `close`, and the index) are vendored into each consumer's `.claude/skills/` under their bare names. The discipline sweep is no longer a verb of this family's: planning, certification, audit, and documentation are suite-owned ceremonies, and what this family contributes to each lives in `ceremony/{plan-sprint,certify-work,audit,document}.md`, materialized into `.ok-workspaces/ceremony/`.

**The port arithmetic, stated once in prose so the allocator can stay
comment-free.** A job's index is its position among the profile-prefixed
worktrees in `git worktree list` order (1-based; the next free index for a
job whose worktree does not exist yet). Its block is
`[basePort + index*span, basePort + index*span + span - 1]`, and the
profile's declared port env vars take consecutive ports from the block's
start. `scripts/port-block` is the only place that computes this; the open
skill and the cheatsheet point at it rather than restating it.

## Constraints

- `scripts/src-tag` must stay POSIX sh with no dependencies beyond git — it runs in build and CI environments where node may be absent, and it must stay byte-identical in derivation across all consumers (same tree → same `src-<12 hex>` everywhere). Never change its derivation without a major version bump.
- `open`/`close` are safety-first: close's gates (clean tree, merged branch) are load-bearing — a worktree is the only record of its uncommitted work. Never add `--force`/`-D` paths.
- Suite-owned files in consumer projects (cheatsheet, materialized src-tag) are overwritten wholesale on converge; the committed profile is owner-*decided*, and the administration writes `config.json` only as transcription of the owner's explicit in-conversation answers — never a field they didn't confirm, never silently (`config.proposed.json` remains the fallback for owners who prefer hand-editing).
- No build, no test runner; scripts are plain node (checked with `node --check`) and bash.
- Changing what this family's verification costs is performance engineering, not test work: profile first (`.ok-planner/bin/proof-timings show` reads the last run's record without re-running anything), justify the change by what the profile names, re-measure. `test/demo.sh` and `test/tags.sh` report per-story cost so that profile exists to be read.
