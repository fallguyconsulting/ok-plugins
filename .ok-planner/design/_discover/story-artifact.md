---
topic: story-artifact
kind: concept
---

# Story (design artifact kind)

## Description

Per `{{STORY-DEFINITION}}`: "A **story** is a **durable user expectation** — what the product owes its users on an ongoing basis. It is not a build record, not a one-time change, not a development task. The test: years from now, would a regression of this capability be a defect a reasonable user would notice and complain about?" Canonical form: `As <role>, I want <capability>, so that <benefit>`, with the **"so that" clause mandatory** — "a story that cannot say why the user wants the capability has not identified a need, only an activity, and fails compliance." Equally, a body that prescribes mechanism (libraries, data shapes, algorithms, storage, protocols) "has crossed into decision or spec territory and fails compliance. The story owns the need; decisions own the how."

A story is user-observable by driving the assembled product. **The delivery surface is not part of the story**: "Which surface a user reaches through — CLI verb, HTTP route, wire message, scheduled job, UI — is a technical choice and lives in `decisions/` ... Two stories that describe the same user-outcome through different surfaces are one story." Non-stories are enumerated: "Added support for X library," migrations, new fields, renames — "capture the persistent expectation as a story; capture the choice as a TD; let the change live in git."

The file shape (`{{STORY-TEMPLATE}}`): `stories/<slug>.md` with **Story** (the As/I want/so that line), **Acceptance** (user action → observable outcome; "the component that delivers the value is real (not stubbed) — name it"), **Falsifier** ("the user-observable absence that would prove this story is NOT delivered" — no result, unrelated result, or synthetic state from a stubbed value-delivering component), and **Proof** (form — demo/example/proof/all — plus "what the proof must exhibit to a third party so they would conclude the story is delivered"). The `Proof:` field "IS the canonical statement of the story's intent"; annotated proof artifacts in the codebase are examples of that intent.

Discovery sources are listed (public surfaces, e2e tests, README/docs, sprint history). The stated purpose of the catalog: "prevent high-level feature loss when individual tests don't catch end-to-end regression; provide a single place a third party can read to know what the product is *for*."

## Code surface

- `artifact-definitions.md` `{{STORY-DEFINITION}}` / `{{STORY-TEMPLATE}}`; enforcement text in the shared compliance reviewer ("Story form": circular "so that it works" is a violation; no pinned surface); discover-design phase-2 reviewer story checks ("As-is, not aspirational" — a story the product does not yet ship is dropped).
- `@story:` annotation checks in audit pass 2 and prove's collection step.

## Prose surface

- `scripts/ok-planner-CLAUDE.md` and cheatsheet summaries; design-note `2026-06-06-completeness-contract.md` — the historical origin (the "42 spec'd-marked-done-never-shipped features" audit that motivated stories as a total user-outcome contract; pre-4.0 vocabulary `S-<slug>`, floor-and-ceiling framing that survives in ok-conduct's completeness rule).

## Adjacent topics

- `decision-artifact` (owns the surface/mechanism), `proof-and-falsifier`, `design-corpus`, `self-containment-rule`, `current-state-only-rule`, `ok-conduct` (completeness-is-the-floor is the execution-side twin).

## Observations

- The story kind carries a `Falsifier` section in-template; decisions do not (their falsifier is the "silently violated" clause of `Proof:`) — an asymmetry both `/prove` and the proof-protection rule handle explicitly ("derive it from the Proof intent if the artifact predates an explicit statement").
- "TD" is used as a synonym for decision inside the story definition ("capture the choice as a TD") — the abbreviation is defined only in the decision definition ("TD = 'technical decision'").
