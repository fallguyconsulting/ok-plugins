---
issue: falsifier-field-asymmetry
kind: discover
category: inconsistent
artifacts:
  - concept:falsifier
  - concept:decision-artifact
  - concept:story-artifact
status: verified
opened: 2026-07-25T02:17:33Z
---

# Stories carry a dedicated falsifier field; decisions embed theirs in the proof clause

## Problem

Stories declare falsifiers in a dedicated template section while decisions embed theirs in the proof field's silently-violated clause, with the proof run told to derive it 'if the artifact predates an explicit statement' — a compatibility shim living inside a current-state rule.

## Candidates

- Amend concept:decision-artifact and the decision template to carry an explicit falsifier field matching stories
- Amend concept:falsifier to record the asymmetry as the canonical design and drop the derive-shim wording

## Discussion

**The question.** Stories and decisions both carry a falsifier, but the artifact shape differs: should decisions get their own dedicated `Falsifier:` field to match stories, or is the current split (dedicated field for stories, embedded clause for decisions) the design and the derive-shim wording just needs cleaning up?

**Evidence, re-verified.** `plugins/ok-planner/skills/_shared/artifact-definitions.md`'s `{{STORY-TEMPLATE}}` (lines 115–142) carries a standalone `## Falsifier` section distinct from `## Proof`. The `{{DECISION-TEMPLATE}}` (lines 173–200) has no `Falsifier` section at all — the falsifier lives inside `## Proof`, expressed as "the mechanical check that fails if this choice is silently violated." `plugins/ok-planner/skills/prove/SKILL.md:26` still carries the compatibility clause verbatim: "...for a decision the 'silently violated' mutation its `Proof:` field names (**derive it from the Proof intent if the artifact predates an explicit statement**)." The parenthetical is live text, not rot — it still governs how `/prove` reads older decisions today.

**What the corpus says.** `concept:falsifier`'s Boundaries section states the asymmetry as current fact, matter-of-factly: "For stories it is stated as the user-observable absence proving the story undelivered; for decisions it is the silent-violation clause of the proof field." This is an as-is description of what exists, not a ruling on whether the asymmetry is the intended permanent shape or an artifact of history that should be squared away — it takes no position on the derive-shim clause at all. `concept:decision-artifact`'s Invariants require the proof field to name a concretely producible falsifier but say nothing about field structure. `concept:story-artifact` requires "the value-delivering component named in acceptance is real" and treats the falsifier as the story's own protected clause, again without commenting on decisions. None of the three squarely says whether the asymmetry should persist.

**What the code does today.** `/prove` (the only consumer that reads falsifiers programmatically) already handles both shapes uniformly at read time — it pulls a story's `Falsifier:` field or derives a decision's from its `Proof:` field's silent-violation clause. The derive-shim wording exists because some decisions predate the current template and might lack an explicit clause; nothing in the codebase currently enforces that every live decision's `Proof:` field actually states a derivable falsifier explicitly.

**Candidates, and what each means.** Filing candidate 1 (give decisions an explicit `Falsifier:` field) means editing `{{DECISION-TEMPLATE}}` to add the section, editing `concept:decision-artifact`'s Boundaries/Invariants to require it, and a migration pass rewriting every live decision's `Proof:` field to split out the falsifier — real corpus churn across every decision file. Filing candidate 2 (keep the asymmetry, drop the shim) means amending `concept:falsifier` to state plainly that the asymmetry is deliberate (stories separate intent from falsifier because a story's acceptance can be satisfied multiple ways; a decision's proof and falsifier are the same mechanical check by construction) and removing the "derive it if predates" hedge from `prove/SKILL.md`, which then requires auditing that every live decision's `Proof:` field already states its falsifier explicitly — smaller corpus footprint but still an audit pass. A third shape not filed: leave both the template asymmetry and the shim wording untouched, on the theory that the shim is honest compatibility language for pre-hardening decisions and not itself a defect — this costs nothing but leaves the asymmetry unexplained in the corpus.

**What the ruling must decide.** Whether decisions should get a dedicated `Falsifier:` field structurally matching stories, or whether the current embedded-in-Proof shape is the intended design (in which case `concept:falsifier` should say so explicitly and the prove-skill's derive-shim wording should be resolved one way or the other rather than left as a silent hedge).

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
