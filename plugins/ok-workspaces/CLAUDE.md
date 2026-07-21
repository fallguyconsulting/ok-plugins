# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-workspaces` canonizes workspace hygiene for parallel agent work as three rules that travel together: one worktree per job, one isolated runtime stack per worktree, content-addressed artifacts (never a mutable tag in a verification path). The rules are stack-invariant; realization is tailored by each consumer project's committed profile at `.ok-workspaces/config.json` via detect → declare → materialize: `scripts/detect.js` proposes, the committed config decides, `scripts/affirm.js` materializes the src-tag script and cheatsheet from it.

## Layout

```
.claude-plugin/plugin.json   # Plugin manifest; version stamps every materialized artifact
hooks/session-start          # Injects skills/ok-workspaces/SKILL.md at session start
skills/<skill>/SKILL.md      # affirm, doctor, audit, open, close + the index skill
scripts/detect.js            # Read-only stack detection; prints proposed profile JSON
scripts/affirm.js            # Materializes src-tag + cheatsheet from committed config
scripts/doctor.js            # Drift report: detection vs declaration, artifact fidelity; exit 2 on drift
scripts/src-tag              # Canonical POSIX-sh content-addressed tag script ({{OK_WORKSPACES_VERSION}} stamped on materialize)
```

## Constraints

- `scripts/src-tag` must stay POSIX sh with no dependencies beyond git — it runs in build and CI environments where node may be absent, and it must stay byte-identical in derivation across all consumers (same tree → same `src-<12 hex>` everywhere). Never change its derivation without a major version bump.
- `open`/`close` are safety-first: close's gates (clean tree, merged branch) are load-bearing — a worktree is the only record of its uncommitted work. Never add `--force`/`-D` paths.
- Plugin-owned files in consumer projects (cheatsheet, materialized src-tag) are overwritten wholesale by affirm; the committed profile is owner-edited and never written by the plugin (the proposal file `config.proposed.json` is the only detection output).
- No build, no test runner; scripts are plain node (checked with `node --check`) and bash.
