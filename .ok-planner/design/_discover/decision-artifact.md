---
topic: decision-artifact
kind: concept
---

# Decision / TD (design artifact kind)

## Description

Per `{{DECISION-DEFINITION}}`: "A **decision** (TD = 'technical decision') is a real architectural or technical choice the project has made — one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is: a reasonable engineer can identify both the choice and a plausible different choice ... and the rationale is a tradeoff (not a default with no real alternative)." One decision per choice; don't lump unrelated choices.

Decisions occupy a deliberate altitude between concept and spec. **They MAY name the specific artifact picked** — "the library, the protocol, the format, the cron string, the threshold value — because the *artifact identity* is often what carries the tradeoff. ... Naming Postgres in the Choice section is honest; abstracting it to 'use a relational store' hides the tradeoff that was actually made." This is the codified exemption to self-containment ("Same word, different altitude"). But **decisions are NOT specs** (no implementation steps, file structure, schema details, call sequences) and **NOT designs** ("A decision records the choice point, not the inner workings of the chosen artifact").

**Decisions were once proof-mandated.** In the layout this discovery observed, each carried a mandatory `Proof:` field naming a mechanical check, with the check's sensitivity itself part of the mandate. That model is retired: decisions carry no proofs and no test obligation — whether an implementation honors a Choice is the implementation audit's adversarial determination.

File shape (`{{DECISION-TEMPLATE}}`): `decisions/<slug>.md` with **Choice** (concrete, may name the artifact), **Rationale** (the tradeoff; sourced from code/comments/ADRs or flagged as most-plausible-reading; "If the rationale is genuinely unclear, file an issue rather than fabricating one"), **Alternatives** (one bullet each; "If no plausible alternative existed, this isn't a decision; it's a default"). The observed template's Proof item is retired with the proof-mandate model. Reviewers additionally require that an as-is extraction never *invents* an enforcing check.

## Code surface

- `artifact-definitions.md` `{{DECISION-DEFINITION}}` / `{{DECISION-TEMPLATE}}`; the Decision-exemption paragraph in `{{SELF-CONTAINMENT-RULE}}`; decision-form enforcement in the shared compliance reviewer ("a decision with no plausible alternative is a default, flag it for retirement").
- Coverage/cardinality checks in audit pass 2 (each member a quantified claim enumerates must resolve in code).

## Prose surface

- `scripts/ok-planner-CLAUDE.md` summary (the estate rules as materialized).

## Adjacent topics

- `story-artifact`, `self-containment-rule` (the exemption), `annotation-convention`, `audit-verb`, `issue-queue` (category `test`).

## Observations

- "Decision" and "TD" are both live spellings; sprint delta headings use "decision" (`### Retire decision: <slug>`), while the definition text and story definition use "TD" conversationally.
- The population/cardinality discipline (a claim quantifying over "every X" must enumerate the members) lives canonically in the audit definition's coverage charter.
