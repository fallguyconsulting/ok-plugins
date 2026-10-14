---
topic: true-up-verb
kind: concept
---

# The true-up verb (diagnose → consent → converge)

## Description

**true-up** is the suite's uniform lifecycle verb: "the idempotent converge of the plugin's estate toward what the installed plugin declares." The contract fixes its three phases: *diagnose* (read-only; reality vs declaration on two axes — project drift and version drift), *consent* (only when something not plugin-owned needs migrating or resolving), *converge* (deterministic materialization of the plugin-owned layer, "driven by the project's committed declarations, never re-inferred at use time"). "A compliant project is a silent no-op." Two hard rules ride it: true-up is **always a user (or user-invoked orchestrator) action — nothing in the suite runs it from a hook**; and every true-up is an **idempotent installer** — "its converge phase materializes a missing estate the same way it repairs a drifted one, so `/ok` needs no per-plugin install knowledge."

Per-plugin realizations. **ok-planner**: the SKILL runs the deterministic bash core `scripts/true-up` (mkdir the tree; create empty `issues.jsonl` if absent; overwrite `.ok-planner/CLAUDE.md` and the cheatsheet from templates with the version stamped; materialize hooks + context payload into `.ok-planner/hooks/` and `.ok-planner/context/`; detect and report retired layout on the last line), then checks issue-queue integrity (every line parses; known events; required fields; promote rows must name an existing sprint file), then performs any reported layout migration (see `backlog-sprint-rename`, `pre-4-0-kinds`). **ok-workspaces**: `diagnose.js` (exit 2 on drift) → conversational profile declaration when config is absent or stacks/runtime drifted (opinionated: "one yes/no when detection is confident; field questions only for genuinely ambiguous signals") → `true-up.js` materializes src-tag, cheatsheet, `.ok-workspaces/.gitignore`, hook + context. **ok-plumbline**: `plumbline diagnose` (deliberately the plugin's copy — "true-up is the one entry point that legitimately executes from the plugin root") → overlap scan → mkdir + `.plumbline.json` migration → cheatsheet copy → vendor the binary and hook (VERSION stamped during copy, then prove it executes) → conversational config declaration via the starter.

Other skills lean on true-up as plumbing: `/plan-sprint`, `/certify`, `/audit`, `/sketch`, and `/discover-design` all invoke `ok-planner:true-up` first "so the layout and the issue queue exist."

## Code surface

- `docs/integration-contract.md` "The verb set".
- `plugins/ok-planner/skills/true-up/SKILL.md` + `scripts/true-up` (134-line bash core).
- `plugins/ok-workspaces/skills/true-up/SKILL.md` + `scripts/{detect,diagnose,true-up}.js`.
- `plugins/ok-plumbline/skills/true-up/SKILL.md` (§1–§5 with embedded bash) + `bin/plumbline` `diagnose`/`starter` subcommands.
- Callers: `plugins/ok/skills/ok/SKILL.md` §4; step 0/1 of plan-sprint, certify, audit, sketch, discover-design SKILL.mds.

## Prose surface

- Contract verb-set section; each true-up SKILL's "Why this skill exists" / "What this skill does NOT do"; `.ok-planner/CLAUDE.md` template and cheatsheet ("Nothing in the suite runs true-up from a hook; it is always a user action").

## Adjacent topics

- `integration-contract`, `ownership-and-consent`, `version-stamping`, `script-materialization`, `hook-shim`, `stack-profile`, `ok-dispatcher`, `backlog-sprint-rename`, `pre-4-0-kinds`.

## Observations

- The ok-planner index skill's table row for `true-up` is stale on two counts: it says the script "creates `.ok-planner/{specs,sketches,history/specs,history/sketches}/`" (the script creates `sprints/`, not `specs/` — specs is the *retired* name), and it says a pre-4.0 layout detection "proposes the migration for the owner's consent, then performs it," while the true-up SKILL itself says "Run the migration ... — no consent prompt."
- The contract's "diagnose... stays available standalone" is realized for ok-workspaces (`diagnose.js`) and ok-plumbline (`plumbline diagnose`) but not for ok-planner, whose bash script mixes diagnose and converge in one pass (it writes CLAUDE.md unconditionally and only *reports* retired layout).
- ok-planner true-up's queue-integrity check declares malformed lines "a finding to report ... for the human to repair" — the one place in the suite where a detected defect is deliberately left for a human mid-plumbing.
