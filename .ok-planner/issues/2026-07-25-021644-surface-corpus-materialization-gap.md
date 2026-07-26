---
issue: surface-corpus-materialization-gap
kind: discover
category: conflicting
artifacts:
  - concept:materialized-artifact
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:16:44Z
---

# A ceremony helper script runs from the plugin copy at use time

## Problem

The contract says every support script materializes project-side and only the lifecycle entry point runs from the plugin copy, yet the planning ceremony's corpus-surfacing helper is invoked from the plugin root at use time and is never materialized.

## Candidates

- Amend decision:per-project-pinning Choice to carve out ceremony-time helpers explicitly
- Bring the helper under the materialization rule via a sprint work item and leave the decision as is

## Discussion

The question: should the `surface-corpus` helper script — invoked by `/plan-sprint` and `/verify-issues` to find corpus artifacts bearing on an issue — run from the plugin's own copy at ceremony time (as it does today), or does the materialization rule require it to run from a project-side, version-stamped copy like every other support script?

Where it comes from: filed against concept:materialized-artifact and decision:per-project-pinning. Re-verified against current code, including the note that the script "recently gained an issue-file path mode": `plugins/ok-planner/scripts/surface-corpus` now accepts either an issue markdown file path (`argv[1]`) or a legacy issue-queue JSON row on stdin — a real capability change since filing, but one that doesn't touch materialization. Both call sites remain unchanged: `plugins/ok-planner/skills/verify-issues/SKILL.md` line 40 and `plugins/ok-planner/skills/plan-sprint/SKILL.md` line 239 both invoke it as `python3 "${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus" .ok-planner/issues/<file>.md` — directly from the plugin root, at ceremony time, not from a materialized project-side copy. `plugins/ok-planner/scripts/true-up` (the script that performs all project-side materialization) never copies or stamps `surface-corpus` — its only file-copy line materializes `context/skills-index.md`. The gap the issue reports is unchanged and confirmed.

What the corpus says: concept:materialized-artifact's Boundaries state "the only thing that legitimately runs from the plugin copy is the lifecycle verb's own entry point, plus bootstrap verbs that by definition run before anything is vendored" — `surface-corpus` is neither: `/plan-sprint` and `/verify-issues` are ordinary ceremony skills that run in an already-converged project, not the lifecycle verb (`true-up`) and not a pre-estate bootstrap verb. decision:per-project-pinning's Choice states the same rule as a decision: "only the lifecycle verb's entry point and pre-estate bootstrap verbs legitimately run from the plugin root," with its Proof claiming "Each plugin's diagnose phase fails on divergence between project copies and the installed plugin's canonicals" — a proof that, by construction, cannot see `surface-corpus` at all, since it is never materialized and so has no project copy to diverge from. Both cited artifacts, read literally, forbid exactly what the code does; neither carves out an exception for a ceremony-time helper, and neither is silent — they squarely disallow the current placement.

What the code does today: `surface-corpus` runs unmaterialized, straight from `${CLAUDE_PLUGIN_ROOT}/scripts/`, every time `/plan-sprint` or `/verify-issues` walks an issue — its behavior can change the instant the installed plugin is updated, mid-project, without any converge step, which is exactly the reproducibility property decision:per-project-pinning's Rationale is written to guarantee for everything else.

Candidates as filed: amend decision:per-project-pinning's Choice to carve out ceremony-time helpers explicitly (matching current code, changing the corpus); bring the helper under the materialization rule via a sprint work item and leave the decision as is (changing the code, matching the corpus as written — true-up would gain a step stamping and copying `surface-corpus` into the estate, and the two call sites would invoke the project-side copy instead).

What the ruling must decide: whether `surface-corpus` is materialized like every other support script (making per-project-pinning's rule exceptionless in practice, not just in wording), or whether ceremony-time helpers are a legitimate, named exception to that rule.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
