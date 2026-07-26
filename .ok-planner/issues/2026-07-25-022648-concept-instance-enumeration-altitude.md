---
issue: concept-instance-enumeration-altitude
kind: discover
category: other
artifacts:
  - concept:plugin
  - concept:skill
  - concept:conduct
status: verified
opened: 2026-07-25T02:26:48Z
---

# Sanity-check roster-level enumerations left in concept bodies

## Problem

concept:plugin enumerates the current concern roster ('what to build, how code reads, where work happens, or the suite front door') and counts 'one lint binary'; concept:skill counts 'Two plugins additionally ship an index skill'; concept:conduct enumerates the conduct's current rule list. Each phrase goes stale when the roster changes; the extractor judged them definitional substance rather than instance enumeration under the no-current-instances rule.

## Candidates

- Amend the three concepts to state the properties without current-roster counts
- Record roster illustrations as sanctioned at concept altitude in the artifact-kind rules

## Discussion

**The question.** Do the roster-flavored phrases inside `concept:plugin`, `concept:skill`, and `concept:conduct` count as forbidden "instance enumeration" under the self-containment rule, or as legitimate definitional substance?

**Where it comes from and what's actually in the live text, re-verified:**
- `concept:plugin`'s What-it-is: "each plugin owns exactly one concern: what to build, how code reads, where work happens, or the suite front door." This reads as a taxonomy of concern *kinds*, but with exactly one live plugin per kind today (ok-planner / ok-plumbline / ok-workspaces / ok), it is also, in effect, today's plugin roster described by role. Its Purpose section separately states "the executable substance is prompt text, small scripts, and one lint binary" — "one" is a literal current count (ok-plumbline's binary), not a kind.
- `concept:skill`'s Boundaries: "Two plugins additionally ship an index skill — a briefing, not a verb — injected into sessions at start." "Two" is a literal current count of which plugins happen to ship this.
- `concept:conduct`'s What-it-is lists the conduct's current rules verbatim: "brevity, no time estimates, prose questions, grounded claims, one-concept-per-turn delivery, tight lists, running unsupervised, completeness as the floor with overshoot the only legal divergence, never destroying uncommitted work, and staying out of the planner's estate unless directed there." This is the conduct's present rule set spelled out in full, not a general statement of "conduct governs behavioral rules."

**What the corpus says the rule is.** `concept:concept-artifact`'s Invariants state it plainly: "A body that enumerates current implementations has descended below concept altitude and fails compliance," and its Boundaries: a concept "does NOT own instance enumerations — the specific artifacts that satisfy a concept live in decisions or in code." The shared `{{SELF-CONTAINMENT-RULE}}` sharpens this further: "A concept body must not enumerate the current instances of itself (CLI verbs, library names, file extensions, route paths, wire-format identifiers, license names, command-line flags, environment variable names)." Neither passage, however, says whether a *count* ("one lint binary," "two plugins") or a *taxonomy phrased using current members* ("what to build, how code reads, where work happens, or the suite front door") falls on the enumeration side of the line — the rule names concrete instance *kinds* (CLI verbs, library names, etc.) that don't obviously cover "how many plugins currently do X." That gap is exactly what the extractor's judgment call, and this issue, turn on.

**The distinction the candidates turn on.** There's a real difference between the four phrases that the ruling should separate out rather than treat as one lump:
1. "one lint binary" and "two plugins additionally ship an index skill" are literal current counts — unambiguous instance enumeration by the rule's own spirit (a fifth plugin or a third index skill makes the sentence wrong without changing what a plugin or a skill *is*).
2. "what to build, how code reads, where work happens, or the suite front door" is a taxonomy of concern-kinds that, coincidentally, has a 1:1 mapping to today's four plugins — arguably definitional (it's asserting *one concern per plugin* is the shape, illustrated by kind) rather than an instance list, but it will read as stale roster if a fifth concern/plugin appears.
3. The conduct's rule list is different in kind again: it's not naming *instances of a concept* (like "plugin names" or "library names") but stating the *literal current content* of a single artifact's governing rules — arguably conduct's What-it-is *is* its rule list (there is no more general property to abstract it to without becoming vacuous), which pushes toward this being definitional substance rather than instance enumeration at all.

**Candidates and their tradeoffs, undecided:**
- *Amend all three concepts to state the properties without current-roster counts.* Removes the staleness risk everywhere uniformly, but for `concept:conduct` may leave the body abstract to the point of uselessness ("the conduct governs behavioral rules" says nothing a reader couldn't guess), and for `concept:plugin`'s concern taxonomy may lose real information (the four concern-kinds *are* the product's current shape, and a fully general rewrite risks inventing false generality where none exists yet).
- *Record roster illustrations as sanctioned at concept altitude, via an addition to the artifact-kind rules.* Avoids rewriting text that may not actually be wrong, but requires drawing the count-vs-taxonomy-vs-full-rule-list line precisely enough that future concept authors can apply it consistently — imprecision here just relocates the judgment call from this issue to every future compliance review.

**What the ruling must decide.** Whether these three passages (or some subset of them) cross the self-containment rule's instance-enumeration line and need rewriting, or whether the rule itself needs a stated exception for roster-shaped definitional content — and if so, where exactly that exception's boundary sits.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
