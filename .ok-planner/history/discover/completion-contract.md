---
topic: completion-contract
kind: invariant
---

# The completion contract

## Description

Every sprint ends with the same fixed, verbatim contract — the stop condition for whoever executes it:

1. "The design corpus matches every delta above (applied verbatim)."
2. The project's own test suites pass over the new and touched work (the retired layout this discovery observed phrased this as a proof-run clause).
3. "`/audit` has been run last: mechanical findings fixed in-cycle; judgment findings filed to `.ok-planner/issues.jsonl` for the next sprint."

The contract's role in the architecture: ok-planner deliberately has no execution engine, so the contract is the *whole* interface between planning and execution — "Implementation planning and execution are NOT ok-planner's job: a sprint's completion contract tells whoever executes it when the work is done" (index skill). It is executor-invariant: "whoever picks it up — this session inline, a fan-out of subagents, an external orchestrator — owes the same completion contract and nothing else. ... The contract in step 5 is what does not scale away" (estate CLAUDE.md). The contract's ordering is load-bearing — audit runs *last* because its judgment findings seed the next sprint's queue, and the test suites must be clean before that.

`/certify` is "the realization of the completion contract plus review and presentation": it discharges the three clauses (alignment check = clause 1 verified mechanically; the test suites then `ok-planner:audit` = clauses 2–3), adds the code-review and design-doc-compliance cycles and the fix loop, and archives. The estate CLAUDE.md names `/certify` "the recommended way to close" while still spelling out the manual path (steps 5–6 of "Executing a sprint").

The contract also authorizes skill invocation outside slash commands: audit's frontmatter names "whoever is executing a sprint's completion contract — an inline session or an orchestrator" as a legitimate activator, and the index skill's activation rules carve out "a running skill or an executing sprint's completion contract directs the invocation."

## Code surface

- `plugins/ok-planner/skills/plan-sprint/SKILL.md` §3 (the verbatim contract block + "include both verbatim in every sprint").
- `plugins/ok-planner/skills/certify/SKILL.md` (step 4 "Run the completion-contract verbs"; the whole skill as the contract's realization).
- `scripts/ok-planner-CLAUDE.md` "Executing a sprint" step 5 ("Close on the completion contract, in its order").

## Prose surface

- Index skill (`what ok-planner is`, plan-sprint and certify rows); cheatsheet Lifecycle.

## Adjacent topics

- `sprint`, `certify-gate`, `audit-verb`, `execution-model`.

## Observations

- The retired pre-4.0 execution engine is the contract's ancestor (per-story acceptance gates, undershoot-is-illegal), though the mechanism changed entirely (engine → prove/audit verbs); the completeness language survives in the sprint boilerplate's step 5 and ok-conduct.
