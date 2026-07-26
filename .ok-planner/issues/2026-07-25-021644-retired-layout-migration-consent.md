---
issue: retired-layout-migration-consent
kind: discover
category: conflicting
artifacts:
  - concept:true-up
  - decision:whole-file-ownership
status: verified
opened: 2026-07-25T02:16:44Z
---

# Three surfaces disagree on consent for retired-layout migration

## Problem

The contract says the migration happens 'with consent', the index-skill row says it 'proposes the migration for the owner's consent', while the executing true-up text says 'no consent prompt' and the dispatcher says 'running /ok is that permission'.

## Candidates

- Amend concept:true-up Invariants to state one canonical consent rule for retired-layout migration
- Amend decision:whole-file-ownership Choice to carve out retired-layout migration explicitly as silent-converge territory

## Discussion

The question: does retired-layout migration (pre-4.0 kinds, backlogs/specs → sprints, issues.jsonl → issue files) require an explicit owner consent step, or is invoking the lifecycle verb itself sufficient permission?

Where it comes from: filed against concept:true-up and decision:whole-file-ownership. Re-verified against current code: `plugins/ok-planner/skills/true-up/SKILL.md` §3 states "Run the migration for whatever the script reported — no consent prompt" (only a genuine old/new-location collision stops for the owner, per that section's closing paragraph). `plugins/ok/skills/ok/SKILL.md` line 39 says each plugin's true-up "diagnoses, proposes any migration or conflict resolution for the owner's consent, and reports" — the index-skill row cited in the Problem. Line 42 of the same file states plainly: "A true-up should never stop to ask permission to migrate its own retired layout — running `/ok` is that permission." `plugins/ok/CLAUDE.md` still frames every plugin's cycle generically as "diagnose → consent → converge". So even within the `ok` front-door plugin alone, one line calls migration a consent-bearing act and another says invoking the front door already is the consent — the disagreement the issue reports is confirmed, unchanged since filing.

What the corpus says: concept:true-up's What-it-is names three phases — "diagnose ..., consent (only when something not plugin-owned needs migrating or resolving), and converge" — read narrowly, this puts retired-layout migration on the no-consent path only if it counts as plugin-owned content; a genuine old/new collision (not a plugin-owned resolution) would be the consent case. That reading lines up with current code. But decision:whole-file-ownership's Choice is more specific and cuts the other way: "plugin-owned files converge silently; anything else at a path the plugin cares about — earlier-version estates, hand-written overlaps, preexisting guidance the plugin would now govern — is presented for the owner's decision." It names "earlier-version estates" explicitly as something presented for a decision — exactly what retired-layout migration touches — and reads as requiring an active presentation step, not implicit permission via invocation. The two cited artifacts do not agree with each other, independent of code.

What the code does today: no consent prompt for the migration itself; the front door's own invocation is treated as sufficient permission; only a genuine collision between old and new locations stops for the owner (true-up SKILL.md §3, §3a's final paragraph).

Candidates as filed: amend concept:true-up's Invariants to state one canonical consent rule; or amend decision:whole-file-ownership's Choice to carve out retired-layout migration explicitly as silent-converge territory. A third shape: leave concept:true-up's phase model as the canonical statement and instead narrow decision:whole-file-ownership's "earlier-version estates" example so it no longer reads as covering retired-layout migration specifically — restricting that clause to overlaps and preexisting guidance, the cases that do still stop the skill today. Each shape is text-only; the code is already internally consistent (no prompt, "/ok is permission") and would not need to change under any of them.

What the ruling must decide: whether retired-layout migration is silent-converge territory (matching current code) or an owner-consent step (matching whole-file-ownership's literal text and the `/ok` skill's index-row framing) — and which cited artifact's wording yields to the other.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
