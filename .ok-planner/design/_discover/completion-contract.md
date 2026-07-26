---
topic: completion-contract
kind: invariant
---

# The completion contract

## Description

Every sprint ends with the same fixed, verbatim contract — the stop condition for whoever executes it:

1. "The design corpus matches every delta above (applied verbatim)."
2. "`/prove` returns clean over all new and touched stories and decisions: every proof present, passing, and non-vacuous."
3. "`/audit` has been run last: mechanical findings fixed in-cycle; judgment findings filed to `.ok-planner/issues.jsonl` for the next sprint."

The contract's role in the architecture: ok-planner deliberately has no execution engine, so the contract is the *whole* interface between planning and execution — "Implementation planning and execution are NOT ok-planner's job: a sprint's completion contract tells whoever executes it when the work is done" (index skill). It is executor-invariant: "whoever picks it up — this session inline, a fan-out of subagents, an external orchestrator — owes the same completion contract and nothing else. ... The contract in step 5 is what does not scale away" (estate CLAUDE.md). The contract's ordering is load-bearing — audit runs *last* because its judgment findings seed the next sprint's queue, and prove must be clean before that.

`/certify` is "the realization of the completion contract plus review and presentation": it discharges the three clauses (alignment check = clause 1 verified mechanically; `ok-planner:prove` then `ok-planner:audit` = clauses 2–3), adds the code-review and design-doc-compliance cycles and the fix loop, and archives. The estate CLAUDE.md names `/certify` "the recommended way to close" while still spelling out the manual path (steps 5–6 of "Executing a sprint").

The contract also authorizes skill invocation outside slash commands: audit's and prove's frontmatter names "whoever is executing a sprint's completion contract — an inline session or an orchestrator" as a legitimate activator, and the index skill's activation rules carve out "a running skill or an executing sprint's completion contract directs the invocation."

## Code surface

- `plugins/ok-planner/skills/plan-sprint/SKILL.md` §3 (the verbatim contract block + "include both verbatim in every sprint").
- `plugins/ok-planner/skills/certify/SKILL.md` (step 4 "Run the completion-contract verbs"; the whole skill as the contract's realization).
- `scripts/ok-planner-CLAUDE.md` "Executing a sprint" step 5 ("Close on the completion contract, in its order").

## Prose surface

- Index skill (`what ok-planner is`, plan-sprint and certify rows); cheatsheet Lifecycle.

## Adjacent topics

- `sprint`, `certify-gate`, `prove-verb`, `audit-verb`, `execution-model`, `proof-and-falsifier`.

## Observations

- Clause 2's scope reads "all new and touched stories and decisions," while prove's own SKILL says "the completion-contract invocation runs whole-corpus: touched artifacts must pass, and untouched artifacts must not have regressed" — the contract text names the narrow set, the verb's text widens it; certify resolves in practice by invoking prove whole-corpus.
- The design-note `2026-06-06-completeness-contract.md` is the contract's ancestor (per-story acceptance gates, undershoot-is-illegal), though the mechanism changed entirely (flip-gated engine → prove/audit verbs); the completeness language survives in the sprint boilerplate's step 5 and ok-conduct.
