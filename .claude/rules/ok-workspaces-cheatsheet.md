# ok-workspaces Cheatsheet

Materialized by ok-workspaces v19.6.0 — suite-owned; refreshed by
the front door's administration (`/ok`); do not hand-edit. Profile:
`.ok-workspaces/config.json` (stacks: none;
runtime: none).

Three rules. Each one makes the next one safe — ship any subset and the
isolation story has a hole.

1. **One worktree per job.** Every unit of work gets its own checkout
   on its own branch: directory `.ok-workspaces/worktrees/<job>`, branch
   `wt/<job>`. Never share a working tree between concurrent
   jobs; never do job work on the main checkout. Use `/open <job>`
   and `/close <job>`.

2. **One runtime stack per worktree.** This project declares no shared
runtime (`runtime: "none"`). If a dev server, container stack, or other
long-lived process is introduced, re-run detection — the front door's
administration (`/ok`) will flag the profile drift.

3. **Per-run artifacts.** Every verification run mints one fresh tag,
   builds every artifact it verifies under that tag, and hands the tag
   to its tests through the one environment variable this project
   declares. Run `.ok-workspaces/bin/run-tag` to mint the tag: it prints
   `run-<12 hex>`, a new value on every invocation. Tests resolve
   artifacts by that tag alone and fail loudly when the variable is
   unset or no artifact carries the tag. Never `:latest`, and never
   any tag that outlives the run, in a verification path. A tag unique
   to the run keeps concurrent runs and concurrent workspaces from
   colliding; building and verifying inside one run makes staleness
   unrepresentable.
