---
issue: verb-set-omits-prove
kind: discover
category: unspecified
artifacts:
  - concept:integration-contract
status: verified
opened: 2026-07-25T02:16:44Z
---

# Contract verb set never defines the prove verb it elsewhere lists

## Problem

The verb-set section defines the lifecycle verb plus a compliance verb, but the conformance section lists 'true-up / audit / prove' for the planner — a third verb the verb-set section itself never defines.

## Candidates

- Amend concept:integration-contract Invariants to define the full verb taxonomy including proof-running verbs

## Discussion

The question: does the integration contract's verb taxonomy account for `/prove` as a distinct verb, given that current code (the plugin manifest description, the plugin's own CLAUDE.md, and decision:prove-audit-audience-split's existence) treats it as a first-class corpus-checking verb alongside `/audit`?

Where it comes from: filed against concept:integration-contract. Re-verified against current code: `plugins/ok-planner/.claude-plugin/plugin.json`'s description reads "...plus the sprint planning ceremony and corpus verbs (audit, prove)" — naming both as peer "corpus verbs" in the plugin's own self-description, independent of the lifecycle verb (`true-up`). `plugins/ok-planner/CLAUDE.md` also names "`/audit`, `/prove`" as separate corpus verbs alongside the lifecycle verb, `/sketch`, `/verify-issues`, and `/certify`. This confirms current code still treats `/prove` as a named, distinct verb, not folded into `/audit`.

What the corpus says: concept:integration-contract's What-it-is names "the ownership rule, the verb set, version stamps, support-script materialization, hook shims, and stack tailoring" as the contract's parts, and its Invariants state only: "Every integrable plugin exposes the lifecycle verb; plugins with rules to check also expose a read-only compliance verb." That is a two-verb taxonomy — one lifecycle verb, one compliance verb (singular) — with no mention of a proof-running verb. decision:prove-audit-audience-split (surfaced as a bearing artifact for this batch) is explicit that `/prove` and `/audit` are not the same verb wearing two names: "The two corpus-checking verbs have disjoint audiences and channels: the proof run produces work items for an agent... while the audit produces work items for a human." That decision treats them as two distinct, deliberately separated verbs, which the integration-contract concept's stated taxonomy has no room for, since it defines only one "compliance verb." decision:no-execution-engine's text doesn't mention `/prove` either.

What the code does today: `/prove` is a real, separately invoked skill (`plugins/ok-planner/skills/prove/`) with its own audience and channel per prove-audit-audience-split, distinct from `/audit`; the plugin manifest and top-level CLAUDE.md both name it as a peer corpus verb.

Candidates as filed: amend concept:integration-contract's Invariants to define the full verb taxonomy including proof-running verbs. A second shape: rather than adding a third verb category to the contract's general taxonomy (which governs every integrable plugin, most of which have no proof concept at all — ok-plumbline and ok-workspaces don't ship a `/prove`), the fix could instead scope the taxonomy addition to plugins that have provable artifacts, e.g. "plugins with provable artifacts also expose a proof-running verb with a disjoint audience from the compliance verb" as a conditional third category, so the general contract stays applicable to plugins with no proofs to run.

What the ruling must decide: whether the integration contract's verb-set Invariants should name a third, conditional verb category for proof-running (matching what ok-planner already ships and self-describes), and if so, whether that addition is stated generally or scoped to plugins that have provable artifacts.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
