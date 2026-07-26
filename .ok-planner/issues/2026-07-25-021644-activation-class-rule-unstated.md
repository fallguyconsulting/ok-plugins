---
issue: activation-class-rule-unstated
kind: discover
category: unspecified
artifacts:
  - decision:slash-only-activation
  - concept:skill
status: verified
opened: 2026-07-25T02:16:44Z
---

# Which skills must carry the slash-only guard? The rule is unwritten

Most skills in the suite open their frontmatter description with "ONLY activated by explicit slash command" — a guard that stops the model from invoking them just because the conversation sounded relevant. Some skills deliberately omit it so other machinery can drive them. But no artifact states which class a new skill belongs to, and the suite already has one instance the unwritten rule can't explain: `ok-plumbline:audit` omits the guard while its two same-named siblings in ok-planner and ok-workspaces carry it.

The mechanics: the guard lives in each skill's frontmatter description, which the harness reads when deciding whether a skill applies. The corpus's one recorded rationale for dropping it (`decision:slash-only-activation`) is "so the front door and sibling skills can drive them through the Skill tool." That rationale holds cleanly for the plumbing verb — all three `true-up` skills omit the guard, and all three are genuinely machine-driven by `/ok` and by sibling skills. It does not hold for `ok-plumbline:audit`: the front door explicitly never invokes work verbs ("`/ok` never invokes work-driving verbs (`audit`, `prove`, `open`, …)"), and a repo-wide search finds nothing invoking `ok-plumbline:audit` through the Skill tool. So the only divergent instance is unjustified by the only stated rationale.

The corpus knows about this gap: `decision:slash-only-activation`'s own Proof section says "the class membership rule itself is stated nowhere. Filed to the intake queue" — this issue is that filing. `concept:skill`'s Boundaries restates the split with the same missing criterion.

## Options

- **Machine-drivenness as the criterion** — a skill omits the guard if and only if another suite surface is documented to drive it via the Skill tool. Sharpest fit to the existing rationale; consequence: `ok-plumbline:audit` reclassifies as user-facing and gains the guard (a one-line code-side fix).
- **"Read-only reporting verb" as its own qualifying category** — legitimizes `ok-plumbline:audit` as-is, but read-only-ness has nothing to do with activation risk, which is what the guard controls.
- **Forward-looking allowance** — a skill may stay guard-free if machinery is *meant* to drive it later. Preserves the status quo at the cost of an untestable criterion.

The ruling decides: what is the membership criterion, where is it written (the decision, the concept, or both), and does `ok-plumbline:audit` gain the guard?

## Ruling

> Recommended ruling (/verify-issues): amend `decision:slash-only-activation` to state the membership rule — every skill carries the slash-only guard unless another suite surface is documented to drive it via the Skill tool — and mirror one sentence in `concept:skill` Boundaries. Add the guard to `ok-plumbline:audit` as the code-side realization.
>
> Rationale: this is the criterion the decision's recorded rationale already implies — the guard is dropped *to permit machine driving*, so where no machine driver exists the guard belongs. It resolves the only divergent instance without inventing a new category, and it is testable (grep for documented callers). Rule together with `audit-verb-overload`, which turns on the same skill.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
