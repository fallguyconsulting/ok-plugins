# .ok-planner/review — the review loop's estate

`/converge` reads and writes here, and `/triage-issues` reads the accept list. The suite's administration (`/ok`) materializes this directory note and `catalog/`, and seeds `config.json` and `project.md` once.

- `catalog/` — suite-owned: `accept.md`, the accept list that decides which sites the run fixes, and one file per bug family, `failure-paths.md` and `input-state.md`, which the hunt prompts paste as the defect shapes to look for. `/ok` overwrites them on every converge, so a change to a catalog is a change to the suite, made upstream in the ok suite. A proposed entry reaches the intake as an upstream issue, with a draft ready to file there.
- `config.json` — the project's: the tool's settings, seeded once and never overwritten. It holds the bug families, the paths out of scope, the project's checks under `checks` (the one source of the checks every agent and the completion contract run), the Python the tool runs under, the prompts and the block sources they draw on, and the settings of `/converge`'s two loops (`hunt`, `fix`).
- `project.md` — the project's: the facts a general loop cannot know, seeded once as a skeleton and never overwritten. Agents keep it current: a sprint build that adds or changes a script input updates it in the same stage, and a `/converge` fixer fixes a clear defect in it, keeping every limit its `## What no agent of this loop ever runs` section sets. It holds the root, what is out of scope, what no agent runs, the helpers the catalogs name, the code-rule files under `## Code rules` (each `.claude/rules/` file whose rules about the shape of code accept-list entry A8 enforces), the scripts the project ships for its developers and operators, the drive commands, and how to run the product and sign in. `/converge` pastes it into every prompt.
- `rotation.json` — the record of which analysis areas were hunted when, written by `review rotate`.
- `runs/` — one ledger and one folder of assembled prompts and snapshots per run. Records, out of context by default: read one only when the owner asks.

The loop's mechanical steps are `.ok-planner/bin/review`; `.ok-planner/bin/review --help` lists the verbs.

No agent of any other skill reads this estate to understand the project, and no code file cites it.
