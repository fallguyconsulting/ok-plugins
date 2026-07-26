---
issue: surface-corpus-materialization-gap
kind: discover
category: conflicting
artifacts:
  - concept:materialized-artifact
  - decision:per-project-pinning
status: repaired
opened: 2026-07-25T02:16:44Z
---

# A ceremony helper script runs from the plugin copy at use time

## Repair

Question: should `surface-corpus` — the helper `/plan-sprint` and
`/verify-issues` invoke to find corpus artifacts bearing on an issue — run
from the plugin's own copy at ceremony time, or from a materialized,
project-side copy like every other support script?

Rule that determined the fix: `decision:per-project-pinning`'s Choice states
the rule exceptionlessly — "only the lifecycle verb's entry point and
pre-estate bootstrap verbs legitimately run from the plugin root" — and
`concept:materialized-artifact`'s Boundaries says the same. `surface-corpus`
is neither; the corpus, as written, forbids the code's current placement
with no carved-out exception, so compliance is achieved by bringing the code
in line rather than by weakening the rule.

What changed:
- `plugins/ok-planner/scripts/true-up` now materializes `scripts/surface-corpus`
  into `.ok-planner/scripts/surface-corpus` (copied, `chmod 755`), alongside
  the existing hooks/context/cheatsheet materialization.
- `plugins/ok-planner/skills/true-up/SKILL.md` documents the new
  materialization step.
- `plugins/ok-planner/skills/verify-issues/SKILL.md` and
  `plugins/ok-planner/skills/plan-sprint/SKILL.md` now invoke
  `.ok-planner/scripts/surface-corpus` (the project-side copy) instead of
  `${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus`.

How verified: `bash -n` on `scripts/true-up`; `python3 -m py_compile` on
`surface-corpus`; ran `true-up` in this repo (dogfooding), confirmed
`.ok-planner/scripts/surface-corpus` was written and executable, and ran it
against a live issue file to confirm it still surfaces bearing artifacts
correctly from the materialized location.
