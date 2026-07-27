---
decision: slash-only-activation
---

# User-facing skills activate only on explicit command

## Choice

Every user-facing skill declares in its description that it is activated only by its explicit slash command and never auto-triggered by conversation content — some naming one additional legitimate non-human activator, such as whoever executes a sprint's completion contract — while plumbing skills deliberately drop the restriction so the front door and sibling skills can drive them through the skill tool. The membership rule: a skill carries the explicit-activation guard unless another suite surface is documented to drive it through the skill-invocation tool; absence of a documented machine driver means the guard belongs.

## Rationale

The activation phrase is load-bearing prompt engineering: it prevents the model from invoking consequential ceremonies inferentially because a conversation resembled one. The two-class split preserves composability — machinery can still drive the plumbing layer — without opening user-facing verbs to inference, and the membership rule keeps the split testable as skills are added.

## Alternatives

- Let skills trigger on inferred intent — consequential verbs (planning, certification, teardown) fire on resemblance rather than instruction.
- Restrict every skill to slash commands — the front door could no longer drive lifecycle verbs, breaking suite composition.
- Classify per skill with no stated rule — invites divergent same-named skills.
