---
issue: proof-single-source-transclusion
kind: discover
category: proof
artifacts:
  - decision:single-source-transclusion
status: promoted
opened: 2026-07-25T02:16:01Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# The transclusion decision's proof splits in two — one half is genuinely checkable

`decision:single-source-transclusion` — canonical rule blocks live once in shared files and skills transclude them into dispatches via `{{TOKEN}}` placeholders — has no enforcing check. But unlike its precedent-shaped siblings, this decision bundles two separable claims, and they deserve different treatment:

- **Resolvability** — does every `{{TOKEN}}` used in any skill resolve to a live `###` block in a shared definitions file? This is a static, greppable fact about committed markdown, the same shape as the annotation-integrity sweep the suite already runs over code. Today every token resolves (re-verified), but nothing checks it — a renamed heading would silently orphan every dispatch that transcludes it.
- **Substitution correctness** — does the model actually inline the right block at dispatch time? This is prompt-execution behavior, which the owner's `prompt-executed-checks-as-proofs` ruling (this intake, 2026-07-25) says can never be proven — it is capped at a declared presence check.

The rules force the split itself: the precedent caps the second half, and the first half is an ordinary mechanical check the decision's Proof can honestly name. What makes this issue worth distinguishing from the pure-precedent cases is that the resolvability check buys a real regression guard, not a the-rule-is-still-stated tautology.

## Options

- **Split the proof accordingly** — build the token-resolution check (a script or an `/audit` pass: every `{{TOKEN}}` in `skills/**` resolves to a heading in `skills/_shared/`), and declare the substitution half presence-not-behavior per the precedent. Forced in shape; the only judgment left is where the check runs (standalone script vs. audit pass), which the sprint can decide.

## Ruling

> Generated ruling (/verify-issues): the sprint rewrites `decision:single-source-transclusion`'s Proof as two declared parts — a mechanical token-resolution check (every `{{TOKEN}}` used in skills resolves to a live shared-file heading; falsifier = rename a heading, the check goes red) plus a presence-not-behavior declaration for substitution correctness per the prompt-executed-checks precedent — and adds the resolution check itself as a work item.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
