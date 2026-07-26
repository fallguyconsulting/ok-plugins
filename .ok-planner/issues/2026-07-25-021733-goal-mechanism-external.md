---
issue: goal-mechanism-external
kind: discover
category: other
artifacts:
  - decision:no-execution-engine
  - concept:sprint
status: verified
opened: 2026-07-25T02:17:33Z
---

# Load-bearing execution text names a harness mechanism the suite does not ship

## Problem

A native goal-driving mechanism is referenced in three places as a first-class sprint execution path, but it is harness functionality external to this repo — an external dependency named in load-bearing text with no fallback statement.

## Candidates

- Amend concept:sprint Boundaries to characterize executor examples as illustrative and non-normative
- Amend decision:no-execution-engine Choice to name the executor set abstractly without harness-specific mechanisms

## Discussion

**The question.** Several load-bearing execution texts name `/goal`, a harness-native "goal-driving mechanism" this plugin does not ship, as one of three named ways to execute a sprint. Should that concrete harness dependency be named in normative planner text, or generalized/removed?

**Evidence, re-verified — now more than three places.** The reference count has grown since filing, not shrunk: `plugins/ok-planner/CLAUDE.md:7` ("handed to the native `goal` mechanism"), `plugins/ok-planner/scripts/ok-planner-CLAUDE.md:192` (`/goal <path-to-sprint>`) — this is the materialized file every consumer project's `.ok-planner/CLAUDE.md` is stamped from, so the naming ships to every trued-up project — `plugins/ok-planner/skills/ok-planner/SKILL.md:23`, and `plugins/ok-planner/skills/plan-sprint/SKILL.md:82,149` (`` /goal ``, twice). That is at least five sites across four files, all still live.

**What the corpus says.** `decision:no-execution-engine`'s Choice already uses more abstract phrasing than the code: "picked up inline, handed to a goal-driving harness mechanism, or dispatched to any orchestrator unchanged" — it does not name `/goal` concretely. `concept:sprint`'s Purpose says only "any executor works from the same brief: an inline session, a fan-out of subagents, or an external orchestrator" — it doesn't mention a goal mechanism at all. So the corpus is already written at the abstraction level candidate 2 asks for; the gap is that the *code* (skills, materialized templates, the plugin's own CLAUDE.md) still names the concrete harness feature the corpus deliberately avoided naming. `concept:skill` and `concept:completion-contract` are silent on this specific question — they establish that the contract "legitimizes non-slash invocation of the checking verbs by whoever is executing it" but don't address naming external harness mechanisms.

**What the code does today.** Every live reference names `/goal` specifically and unconditionally, with no "if your harness supports X" framing and no fallback statement for harnesses that lack an equivalent — an ordinary inline session and an orchestrator are both offered as alternatives in the same sentence, but the phrasing is a flat list rather than a caveat.

**Candidates, and what each means.** Candidate 1 (amend `concept:sprint` Boundaries to flag executor examples as illustrative/non-normative) touches only the concept, leaving the code's concrete `/goal` naming untouched — cheapest, but leaves the actual inconsistency (corpus already abstract, code concrete) unresolved, since the concept doesn't currently name `/goal` to begin with. Candidate 2 (amend `decision:no-execution-engine` Choice to abstract the executor set) is largely already true of that decision's wording; the remaining work would be in the skills and materialized templates, not the decision. A candidate not filed: leave the corpus as-is (already abstract) and rewrite the code sites — `CLAUDE.md`, `ok-planner-CLAUDE.md`, `SKILL.md`, `plan-sprint/SKILL.md` — to describe the harness capability generically ("a harness feature that drives a goal to completion") with `/goal` only as a parenthetical example, which fixes the actual site of the dependency rather than a decision that doesn't have the problem.

**What the ruling must decide.** Whether naming the harness-native `/goal` mechanism concretely in the plugin's own CLAUDE.md, the materialized project template, and two skill files is acceptable as a documented convenience (since the suite's actual host is Claude Code), or whether it should be generalized to avoid coupling the planner's normative text to a specific harness feature it does not control or ship.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
