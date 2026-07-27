# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-workspaces` canonizes workspace hygiene for parallel agent work as three rules that travel together: one worktree per job, one isolated runtime stack per worktree, content-addressed artifacts (never a mutable tag in a verification path). The rules are stack-invariant; realization is tailored by each consumer project's committed profile at `.ok-workspaces/config.json` via detect → declare → materialize: `scripts/detect.js` proposes, the committed config decides, `scripts/true-up.js` (the write core of the true-up verb) materializes the src-tag script, the cheatsheet, and the dot-directory `.gitignore` from it.

**Worktrees default to inside the project root** (`.ok-workspaces/worktrees/<job>`), not a sibling directory: a job's checkout should never escape the project it belongs to. Because a checkout inside the repo must never become content of the repo, true-up writes `.ok-workspaces/.gitignore` covering wherever the profile puts them — scoped to the plugin's own dot-directory, since the ownership rule forbids touching the project's root `.gitignore`. A project that genuinely wants worktrees elsewhere declares `worktrees.dirPrefix` in its profile; that is a declaration, not drift, and diagnose reports it as such.

## Layout

```
.claude-plugin/plugin.json   # Plugin manifest; version stamps every materialized artifact
skills/<skill>/SKILL.md      # true-up, audit, open, close + the index skill (vendored into consumer projects by true-up)
scripts/detect.js            # Read-only stack detection; prints proposed profile JSON
scripts/true-up.js           # true-up write core: materializes src-tag + port-block + cheatsheet + .ok-workspaces/.gitignore + vendored skills from committed config
scripts/diagnose.js          # true-up diagnose: detection vs declaration, artifact fidelity incl. vendored skills; exit 2 on drift
scripts/vendored-skills.js   # The one derivation of the vendored-skill renderings (write and diagnose share it)
scripts/true-up-skill.md     # The merged project-local lifecycle verb's template (byte-identical across integrable plugins; checked)
scripts/src-tag              # Canonical POSIX-sh content-addressed tag script ({{OK_WORKSPACES_VERSION}} stamped on materialize)
scripts/port-block           # Canonical dev-server port allocator — the one statement of the port arithmetic
```

There are no plugin hooks and no session-start injection: the cheatsheet is the awareness surface, and the user-facing skills are vendored into each consumer's `.claude/skills/` (audit prefixed as `ok-workspaces-audit` under the contract's collision rule).

## Constraints

- `scripts/src-tag` must stay POSIX sh with no dependencies beyond git — it runs in build and CI environments where node may be absent, and it must stay byte-identical in derivation across all consumers (same tree → same `src-<12 hex>` everywhere). Never change its derivation without a major version bump.
- `open`/`close` are safety-first: close's gates (clean tree, merged branch) are load-bearing — a worktree is the only record of its uncommitted work. Never add `--force`/`-D` paths.
- Plugin-owned files in consumer projects (cheatsheet, materialized src-tag) are overwritten wholesale by true-up; the committed profile is owner-*decided*, and true-up writes `config.json` only as transcription of the owner's explicit in-conversation answers — never a field they didn't confirm, never silently (`config.proposed.json` remains the fallback for owners who prefer hand-editing).
- No build, no test runner; scripts are plain node (checked with `node --check`) and bash.
