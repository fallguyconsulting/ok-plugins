---
issue: index-skill-drift-unchecked
kind: discover
category: inconsistent
artifacts:
  - concept:skill
  - story:session-awareness
status: verified
opened: 2026-07-25T02:17:33Z
---

# Injected index briefings restate other skills and drift with no reconciliation mechanism

## Problem

The planner's index table currently disagrees with the executing texts in several rows (retired directory names, consent phrasing for migration, a retired artifact noun, pre-hardening certify phrasing) and the injected banner understates the documented non-slash activators; nothing checks the briefing against the skills it summarizes.

## Candidates

- Amend concept:skill Boundaries to make index briefings generated or checked content rather than hand-maintained prose
- Add the index-vs-skills consistency check to the audit's scope via a sprint

## Discussion

**The question.** `plugins/ok-planner/skills/ok-planner/SKILL.md`'s index table (injected into every session via the materialized `session-start` hook) hand-restates what each skill does; nothing mechanically checks it against the skill files it summarizes. Should the index become generated/checked content, should audit's scope grow to catch this drift, or is hand-maintained prose with periodic manual correction acceptable?

**Evidence, re-verified — mixed rot.** Some of the originally-flagged disagreements have since been fixed and no longer hold: the index row for `ok-planner:verify-issues` now exists and matches the skill's current behavior (`SKILL.md:40`), and the `ok-planner:certify` row (`SKILL.md:39`, "filed to the issue intake, never asked live") now matches `certify/SKILL.md`'s current hardened behavior (commit `a01a3de`, "certify: fix by default, file only the truly unclear, never ask live") — the "pre-hardening certify phrasing" and the verify-issues-coverage gap named in the Problem are stale as of today. Two other claims are still live: (1) a retired artifact noun — `SKILL.md:35`'s `ok-planner:sketch` row still says "the path to building is sketch → `/plan-sprint` → spec," but `true-up/SKILL.md:41` states plainly "the artifact this ceremony produces is now the **sprint**" (the noun "spec" was retired in the backlog→sprint rename); and (2) the injected banner still understates non-slash activation — the materialized `scripts/hooks/session-start:29` banner reads "Skills are invoked only when the user types a slash command," while `SKILL.md`'s own "When Skills Activate" section documents a second activator: "A running skill or an executing sprint's completion contract directs the invocation." The "consent phrasing for migration" claim did not reproduce under re-verification — `true-up/SKILL.md:35,37` is internally consistent today ("no consent prompt" except for a genuine directory collision), and the index row doesn't contradict it.

**What the corpus says.** `concept:skill`'s Boundaries names the index as "a briefing, not a verb" injected at session start, cross-referencing `story:session-awareness`, but says nothing about how the briefing's accuracy is maintained or checked — it documents the mechanism, not its integrity. `story:session-awareness`'s Acceptance requires the injected briefing to "reflect the installed plugin" but is silent on whether "reflect" means byte-generated-from or merely kept-in-sync-by-hand. `concept:catalog-toc` is the corpus's one precedent for a generated, checked summary index — its Invariants require "generated content only: hand edits are overwritten," and its consistency is explicitly assigned to the corpus audit ("TOC consistency ... is checked by the corpus audit"). The skill index is architecturally the same shape (a one-line-per-item summary table meant to stay truthful to full source files) but currently has neither the catalog-toc's generation discipline nor its audit coverage.

**What the code does today.** The index table is hand-written prose inside `ok-planner/SKILL.md`, materialized verbatim (via `cp`, not a template substitution) into each project's `.ok-planner/context/skills-index.md` by `scripts/true-up`, then injected by the session-start hook every session. Nothing generates it from the individual `SKILL.md` files' frontmatter `description` fields (which do carry a full statement of each skill's behavior), and audit's three passes (compliance, coverage/drift, cross-artifact consistency) are scoped to the design corpus (`design/`), not to skill-vs-index consistency — this check doesn't exist anywhere today.

**Candidates, and what each means.** Candidate 1 (generated/checked index) would mean either deriving the table mechanically from each skill's frontmatter `description` (removing the drift vector entirely, at the cost of losing the table's currently richer per-row prose) or keeping hand-written rows but adding a mechanical diff check — a real engineering change to `true-up`'s materialization step. Candidate 2 (add the check to audit's scope) keeps the index hand-maintained but makes staleness a mechanical finding audit surfaces each run, closer to how `catalog-toc` consistency already works — smaller change, but leaves the index a manually-edited artifact that can drift again between audit runs. A shape not filed: leave the index entirely hand-maintained with no mechanical check, accepting periodic drift as a cost of prose that's allowed to say more than a generated one-liner could — cheapest, matches today's status quo, but is the shape the filer flagged as the actual defect.

**What the ruling must decide.** Whether the injected skill index should become generated or mechanically checked content (and if checked, whether that check belongs to `/audit`'s scope or to `true-up`'s materialization step), or whether hand-maintained prose with no reconciliation mechanism is acceptable given the richer-than-generated content it currently carries.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
