---
issue: front-door-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:integration-contract
  - concept:plugin
status: verified
opened: 2026-07-25T02:26:48Z
---

# Decide whether the front door / dispatcher deserves its own concept

## Problem

'Front door' and 'deliberately ignorant dispatcher' recur as a load-bearing role in concept:plugin, concept:integration-contract, and story:one-command-suite-upkeep — the estate-less plugin whose ignorance the contract exists to preserve — but the extractor folded the role into the contract's Purpose and the story rather than promoting it.

## Candidates

- Promote a front-door concept owning the dispatcher role and its ignorance property
- Amend concept:integration-contract to explicitly own the dispatcher-role definition as the canonical fold

## Discussion

**The question.** The "front door" / "deliberately ignorant dispatcher" role recurs as load-bearing across several artifacts without ever being its own concept. Should it be promoted to a first-class concept, or is folding it into `concept:integration-contract` (with the other two artifacts pointing there) the canonical, intended shape?

**Where the role recurs, re-verified:**
- `concept:plugin` Boundaries: "the front door deliberately has no estate and is never integrated."
- `concept:integration-contract` Purpose: "The contract is what makes the suite composable by a deliberately ignorant dispatcher: the front door knows the contract's two conventions — discovery markers and the uniform lifecycle verb — and nothing about any plugin's internals. A plugin needing special-casing has integrated wrong, not the dispatcher." Its Boundaries add: "The front door's own conduct is its consumer-side realization (see also: one-command-suite-upkeep under stories)."
- `decision:filesystem-discovery-markers` Rationale: "exactly what lets the front door stay deliberately dumb."
- `story:one-command-suite-upkeep` is written entirely from the front door's perspective — a single command that updates, discovers, bootstraps by consent, and relays each plugin's own verb output "uninterpreted."

That's four artifacts across all three catalogs (concept, decision, story) treating "front door" as a stable, load-bearing noun, more than most promoted concepts get named from.

**What the corpus says about whether this is intentional.** Nothing states the fold is deliberate. `concept:integration-contract`'s Boundaries says its layers "are realized by neighboring concepts: estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile" — a fold list that conspicuously does *not* include a "front door" entry, even though the same section immediately names the front door's story as its "consumer-side realization." That's suggestive but not a ruling: it could mean the front door was deliberately treated as *integration-contract's own subject* (the contract exists largely to keep the dispatcher ignorant, so a separate concept would just restate the contract's Purpose), or it could mean the extractor simply hadn't yet promoted a genuinely distinct noun. `concept:plugin`'s Boundaries treat "the front door" as a special plugin instance (no estate, never integrated) rather than as a role with its own definition — which is itself evidence the noun is currently *plugin-shaped* in the corpus's own vocabulary, not dispatcher-shaped.

**What a promoted concept would versus wouldn't own, if created.** A `front-door` (or `dispatcher`) concept would give one place to state: what the front door is (the one plugin with no estate, consuming every other plugin's manifest dependency), the ignorance property (it knows only the two contract conventions — discovery markers and the lifecycle verb — never plugin internals), and the "a plugin needing special-casing has integrated wrong" invariant, which currently lives inside `concept:integration-contract`'s Purpose as a statement about *plugins*, not about *the front door itself*. What it would still not own: the contract's layers themselves (estate, cheatsheet, skill, etc.) or the update/bootstrap mechanics (those stay with `story:one-command-suite-upkeep`).

**Candidates and their tradeoffs, undecided:**
- *Promote a front-door concept.* Gives the recurring noun a stable definition and an addressable slug for future code annotations (`@concept:front-door`) instead of code citing `@concept:integration-contract` for a narrower claim about the dispatcher specifically. Risks a thin concept if, once written, its "What it is" and "Purpose" sections end up largely restating `integration-contract`'s existing Purpose paragraph — the two are extremely close in altitude and audience.
- *Amend `concept:integration-contract` to explicitly own the dispatcher-role definition as the canonical fold.* No new artifact, and matches the current shape where the contract's Purpose already carries the ignorance property in full. Leaves the fold implicit rather than stated — a future reader (or extractor) hitting the same four artifacts may re-raise this exact question, since nothing would then say "this is intentionally folded here, not promoted."

**What the ruling must decide.** Whether "front door" / "deliberately ignorant dispatcher" earns its own concept file, or whether `concept:integration-contract` should be amended to state explicitly that it is the fold's canonical home.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
