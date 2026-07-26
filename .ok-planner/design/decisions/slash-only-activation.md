---
decision: slash-only-activation
status: as-is
---

# User-facing skills activate only on explicit command

## Choice

Every user-facing skill declares in its description that it is activated only by its explicit slash command and never auto-triggered by conversation content — some naming one additional legitimate non-human activator, such as whoever executes a sprint's completion contract — while plumbing skills deliberately drop the restriction so the front door and sibling skills can drive them through the skill tool.

## Rationale

The activation phrase is load-bearing prompt engineering: it prevents the model from invoking consequential ceremonies inferentially because a conversation resembled one. The two-class split preserves composability — machinery can still drive the plumbing layer — without opening user-facing verbs to inference.

## Alternatives

- Let skills trigger on inferred intent — consequential verbs (planning, certification, teardown) fire on resemblance rather than instruction.
- Restrict every skill to slash commands — the front door could no longer drive lifecycle verbs, breaking suite composition.

## Proof

No enforcing check exists today: nothing verifies a new user-facing skill carries the phrase, and the class membership rule itself is stated nowhere. Filed to the intake queue for owner calibration.
