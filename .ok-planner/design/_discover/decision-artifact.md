---
topic: decision-artifact
kind: concept
---

# Decision / TD (design artifact kind)

## Description

Per `{{DECISION-DEFINITION}}`: "A **decision** (TD = 'technical decision') is a real architectural or technical choice the project has made — one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is: a reasonable engineer can identify both the choice and a plausible different choice ... and the rationale is a tradeoff (not a default with no real alternative)." One decision per choice; don't lump unrelated choices.

Decisions occupy a deliberate altitude between concept and spec. **They MAY name the specific artifact picked** — "the library, the protocol, the format, the cron string, the threshold value — because the *artifact identity* is often what carries the tradeoff. ... Naming Postgres in the Choice section is honest; abstracting it to 'use a relational store' hides the tradeoff that was actually made." This is the codified exemption to self-containment ("Same word, different altitude"). But **decisions are NOT specs** (no implementation steps, file structure, schema details, call sequences) and **NOT designs** ("A decision records the choice point, not the inner workings of the chosen artifact").

**Decisions are provable.** Each carries a mandatory `Proof:` field: "the mechanical check that **fails if the choice is silently violated**. For most decisions this is a static gate — a dependency-boundary lint rule, an import restriction, a conformance test, a config assertion — and the artifact enforcing it carries a `@decision:<slug>` annotation." The proof is the demarcation criterion: "a 'decision' for which no violation-detecting check can be named is either really a default (delete it) or an unenforced intention (file an issue)." The "silently violated" clause is the check's falsifier and "must be concretely producible: there must be a mutation ... that turns the check red. A check nothing could redden does not enforce the choice; it is vacuous, and `/prove` treats it so."

File shape (`{{DECISION-TEMPLATE}}`): `decisions/<slug>.md` with **Choice** (concrete, may name the artifact), **Rationale** (the tradeoff; sourced from code/comments/ADRs or flagged as most-plausible-reading; "If the rationale is genuinely unclear, file an issue rather than fabricating one"), **Alternatives** (one bullet each; "If no plausible alternative existed, this isn't a decision; it's a default"), **Proof** ("Name what the check enforces, not where it lives"). Reviewers additionally require that an as-is extraction never *invents* an enforcing check: a decision with no existing check is written without one plus an issue row, category `proof`.

## Code surface

- `artifact-definitions.md` `{{DECISION-DEFINITION}}` / `{{DECISION-TEMPLATE}}`; the Decision-exemption paragraph in `{{SELF-CONTAINMENT-RULE}}`; decision-form enforcement in the shared compliance reviewer ("a Proof that no check could ever fail — or that merely restates the choice — is a violation; ... a decision with no plausible alternative is a default, flag it for retirement").
- Coverage/cardinality checks in audit pass 2 (each member a Proof field enumerates must resolve in code); falsifier exhibition in prove step 4.

## Prose surface

- `scripts/ok-planner-CLAUDE.md` summary ("each carries a proof: the mechanical check that fails if the choice is silently violated").

## Adjacent topics

- `story-artifact`, `proof-and-falsifier`, `self-containment-rule` (the exemption), `annotation-convention`, `audit-verb`, `prove-verb`, `issue-queue` (category `proof`).

## Observations

- "Decision" and "TD" are both live spellings; sprint delta headings use "decision" (`### Retire decision: <slug>`), while the definition text and story definition use "TD" conversationally.
- The population/cardinality discipline (a Proof quantifying over "every X" must enumerate the members) appears in three places — proof-protection rule, audit pass 2, prove step 4 — each phrased for its consumer; the canonical statement is in `{{PROOF-PROTECTION-RULE}}`.
