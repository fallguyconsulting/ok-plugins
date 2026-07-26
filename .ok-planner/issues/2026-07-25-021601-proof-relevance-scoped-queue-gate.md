---
issue: proof-relevance-scoped-queue-gate
kind: discover
category: proof
artifacts:
  - decision:relevance-scoped-queue-gate
status: verified
opened: 2026-07-25T02:16:01Z
---

# The relevance-gate decision has no proof; the owner's precedent prescribes its shape

`decision:relevance-scoped-queue-gate` — a feature-work sprint drafts first, then walks only the open issues a dedicated relevance pass says bear on the draft — has no enforcing check: "the gate lives in ceremony prompt text." The relevance pass is a single subagent dispatch inside `/plan-sprint` classifying issues by prose instruction; nothing downstream parses or gates on its verdicts. Like the prove/audit channel split, the discipline is an agent's runtime conduct while following a ceremony prompt — unobservable by any independent tool in a markdown-and-bash plugin.

The owner's ruling in `prompt-executed-checks-as-proofs` (this intake, 2026-07-25) governs this shape directly: prompt-realized discipline gets a **declared text-presence proof** — the gate's steps (draft-first ordering, the relevance dispatch, the when-in-doubt-BEARS tiebreak) must stand greppably in `plan-sprint/SKILL.md`; the falsifier is the step or tiebreak deleted or reworded; the Proof field declares presence, not behavior. The issue as filed also floated retiring the decision; that is unnecessary once the precedent's proof shape is available, and the decision records a real choice with a real rejected alternative (walking the whole queue every sprint), which the corpus's own rules say retirement is not for.

## Options

- **Apply the precedent** — Proof becomes the declared text-presence check over the plan-sprint gate text. Forced by the standing ruling.
- **Retire the decision** — unnecessary and contrary to the decision-artifact rules; the choice is real and live.

## Ruling

> Generated ruling (/verify-issues): apply the prompt-executed-checks precedent — the sprint rewrites `decision:relevance-scoped-queue-gate`'s Proof field as a declared text-presence check (the relevance-pass step and its BEARS-when-in-doubt tiebreak in `plan-sprint/SKILL.md`, falsifier = deleted or reworded, declared presence-not-behavior). Rule in the same batch as the other two precedent-shaped proof issues.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
