---
issue: toc-retired-section-shape
kind: discover
category: inconsistent
artifacts:
  - concept:catalog-toc
status: verified
opened: 2026-07-25T02:16:44Z
---

# Reviewer expects a Retired TOC section the generator never emits

## Problem

The compliance reviewer checks that retired-only entries sit under a Retired heading, but the TOC generation template defines no Retired section — the two shapes of the same file disagree at the edges.

## Candidates

- Amend concept:catalog-toc Invariants to fix one canonical TOC shape covering retired entries

## Discussion

The question: does the canonical TOC shape include a "Retired" section, and if so, what does it look like — since the compliance reviewer checks for one but the TOC generation template never produces one?

Where it comes from: filed against concept:catalog-toc. This issue is closely related to retirement-mechanics-diverge (filed against concept:corpus-delta and concept:catalog-toc), which asks the broader question of whether retirement means deletion or archival at all; this issue is the narrower follow-on — assuming some artifacts do end up retired-but-present, what their TOC entry should look like. Re-verified against current code: `plugins/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` lines 112-114 instruct the reviewer to check "Every TOC bullet's slug matches a live artifact file in the matching directory. (Retired-only entries belong in the 'Retired' section, not the live list.)" — a positive claim that a "Retired" section is the canonical home for such entries. But `plugins/ok-planner/skills/discover-design/SKILL.md` step 7 (lines 190-217), the only place in the codebase that defines the TOC's generation format, specifies entries as "slug, optional aliases, first sentence of `## What it is`" (concepts) etc., with a literal markdown template (lines 208-217) that has no Retired heading, no retired-entry format, and no instruction to skip or separately list `_retired/` content — it only says "read every file (skipping `_merged/` subdirectories if present)", not `_retired/`. The disagreement is confirmed unchanged: the checker enforces a section shape the generator does not know how to produce.

What the corpus says: concept:catalog-toc's own body — What it is, Purpose, Boundaries, Invariants — never mentions a Retired section, `_retired/`, or retired-artifact handling of any kind; its Invariants are "Generated content only," "Summaries obey self-containment," and "Entries are alphabetical, slug plus a bounded one-sentence summary." The concept the reviewer is supposedly enforcing compliance with says nothing about the very section the reviewer checks for.

What the code does today: `discover-design` (the only generator) produces TOCs with no Retired section; the compliance reviewer (used by both `/audit` and `/plan-sprint`'s draft review) checks for one anyway — meaning either every corpus in the suite currently fails this specific check the moment any artifact is retired, or the check has simply never fired because no project has retired an artifact yet through the current delta-deletes mechanic (in which case there would be nothing to move to `_retired/` in the first place, per retirement-mechanics-diverge).

Candidates as filed: amend concept:catalog-toc's Invariants to fix one canonical TOC shape covering retired entries. This issue's resolution is downstream of retirement-mechanics-diverge's: if that issue is ruled "retirement means deletion," a Retired section becomes moot and the fix here is to strip the reviewer's Retired-section check instead of adding generation logic for it; if ruled "retirement means archival under `_retired/`," this issue's fix is to add the missing Retired-section format to both concept:catalog-toc's Invariants and `discover-design`'s step-7 generation template so the two surfaces match.

What the ruling must decide: whether the TOC's canonical shape ever includes a Retired section, or the compliance reviewer's check for one is stale and should be removed — a question this issue cannot settle on its own without first knowing (from retirement-mechanics-diverge) whether retired artifacts are archived or deleted.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
