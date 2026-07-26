---
topic: proof-and-falsifier
kind: invariant
---

# Proofs, falsifiers, non-vacuity, and the proof-protection rule

## Description

A **proof** is a codebase artifact (demo, example, executable proof, enforcing check) that exhibits a story or decision holding, linked to its artifact by an `@story:<slug>` / `@decision:<slug>` annotation ("without it, the proof is anonymous and the coverage audit cannot find it. A proof file without the annotation is, for coverage purposes, not a proof of anything"). The artifact's `Proof:` field is the canonical intent; proof files are examples of that intent. "Proofs are not tests in the regression-protection sense. They are exhibitions of intent that happen to live as runnable code."

**Non-vacuity is demonstrated, not judged.** "A proof earns its name only if it can fail, and 'can fail' is established by *exhibiting* the failure, never by reading the source and forming an opinion (the read is the foolable step)." Every proof has a **declared falsifier** — "the concrete mutation to the code under proof that must turn it red — the value-delivering component stubbed, the enforced boundary crossed, the choice silently violated." A proof is non-vacuous "**only when applying its falsifier actually reddens it and reverting restores green**." A proof whose falsifier cannot be produced, or that stays green under it, is vacuous by construction. Quantified proofs must enumerate their population: "'every' over a singleton is vacuously true ... This is the exact seam through which a corpus claim outruns the code: a decision amended to assert two implementations, applied as text, proved green against the one that exists."

**The protection is on intent, not byte shape.** Multiple proofs per story are welcome; adding one is unrestricted. Updates that keep the proof satisfying its `Proof:` field are **ambient** (ordinary code change: renamed API, refactor, hardened setup). A change that makes a proof exhibit "something different, less, or nothing" is an **artifact mutation** — "It must be carried in the sprint's corpus deltas as a Proof-field rewrite ... The proof modification follows the artifact mutation; never the reverse." **Removals require explicit user direction** ("the agent never proposes removal"), recorded as artifact retirement or explicit decommissioning naming a replacement. The **sprint dialogue gate** surfaces intent-affecting deltas with exactly three options — preserve the intent / shift the intent / remove the artifact — "The agent never picks; the user does."

**Where drift is caught**: `/prove` executes every live proof and exhibits its falsifier (apply mutation → confirm red → restore → confirm green), reporting missing/failing/vacuous; `/audit` runs the coverage check (every live story and decision has ≥1 annotated proof; every enumerated population member present in code) plus judgment-based intent-drift. The rationale for bright lines rather than stricter ones is explicit: "Treating them as immutable would mean either an unmaintainable codebase or constant friction over routine refactors. ... Most changes pass through ambient; only intent shifts and removals trip the gate."

## Code surface

- `artifact-definitions.md` `{{PROOF-PROTECTION-RULE}}` (the canonical statement, ~9 paragraphs).
- `plugins/ok-planner/skills/prove/SKILL.md` — the exhibition procedure (steps 1–5), fix-forward restoration discipline, verdict taxonomy (pass / missing / failing / vacuous / unrunnable / uncertain).
- `plugins/ok-planner/skills/audit/SKILL.md` pass 2 — coverage + cardinality + intent-drift + the structural catch for foolable Proof fields ("a `Proof:` field that quantifies over a population ... without the artifact enumerating that population").
- `plugins/ok-planner/skills/plan-sprint/SKILL.md` §2 — the dialogue gate invocation.

## Prose surface

- Design-note `2026-06-05-flip-gated-execution.md` — the ancestor discipline ("RED when the work is absent, GREEN when the work is present ... An eager agent can rubber-stamp 'looks fine'; it cannot make a command flip that doesn't flip"), from which falsifier-exhibition descends.

## Adjacent topics

- `story-artifact`, `decision-artifact`, `prove-verb`, `audit-verb`, `annotation-convention`, `sprint` (deltas carry intent changes), `completion-contract`.

## Observations

- The falsifier asymmetry: stories declare falsifiers in a dedicated `Falsifier` field; decisions embed theirs in `Proof:`'s "silently violated" clause, with `/prove` told to "derive it from the Proof intent if the artifact predates an explicit statement" — a compatibility shim inside a current-state rule.
- The word "proof" does triple duty in live prose: the artifact file's `Proof:` field (intent statement), the annotated codebase file (the proof artifact), and the issue category `proof`. The texts stay careful about it, but the noun is genuinely overloaded.
- `/prove`'s `uncertain` verdict (falsifier unapplicable without unsafe destructive side effects) is the one sanctioned read-only escape, required to name "the exact mutation you could not run."
