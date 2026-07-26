---
issue: proof-no-execution-engine
kind: discover
category: proof
artifacts:
  - decision:no-execution-engine
status: verified
opened: 2026-07-25T02:16:01Z
---

# "No execution engine" is enforced only by absence

`decision:no-execution-engine` — ok-planner ships no plan artifact and no execution pipeline; sprints are executed by ordinary sessions against the sprint document itself — is currently true by absence: no plan-artifact schema or execute-style skill exists anywhere in the tree. Nothing would notice reintroduction. The decision retired a real engine (the pre-4.0 write-plan/execute-plan pipeline), so the risk isn't hypothetical drift but regrowth of something the project deliberately removed.

Two honest proof shapes exist, and they differ in kind. The commitment *is stated* in checkable text — "never turn a sprint into a plan document" and its variants stand in the planning ceremony, the hub, and the materialized estate CLAUDE.md — so a declared text-presence proof (per the owner's prompt-executed-checks precedent) is available and cheap. A stronger structural sweep (an audit pass flagging plan-artifact schemas or execute-skill shapes) is buildable in principle, but nobody has specified what shapes it would flag, and a sweep for "things that look like an engine" is exactly the kind of vague check that ends up vacuous or noisy. The decision-artifact rules accept either; they just don't accept the current "filed to the intake" placeholder forever.

## Options

- **Declared text-presence proof** — the no-plan-artifact commitment's statements in the ceremony and estate texts; falsifier = the lines deleted or reworded. Cheap, honest, consistent with the precedent family.
- **Structural sweep** — a real reintroduction detector, if its target shapes can ever be specified concretely. Speculative until then.
- **Drop the placeholder, accept absence** — leaves the decision unproven, the state the corpus rules disallow as permanent.

## Ruling

> Recommended ruling (/verify-issues): declared text-presence proof — the sprint rewrites `decision:no-execution-engine`'s Proof to name the no-plan-artifact statements in the planning ceremony and materialized estate text (falsifier = those lines removed), declared presence-not-behavior, with a structural sweep noted as the upgrade path if reintroduction pressure ever materializes.
>
> Rationale: the precedent already legitimizes this shape for commitments realized in prompt text, and a reintroduction detector without specified targets would be a vacuous check wearing a rigorous costume — the corpus is better served by an honest presence proof than an unbuildable strong one.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
