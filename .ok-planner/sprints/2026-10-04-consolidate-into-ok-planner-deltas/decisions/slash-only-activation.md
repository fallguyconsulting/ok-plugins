---
decision: slash-only-activation
---

# Skills activate only on explicit command

## Choice

Every skill is user-facing and declares in its description that it is activated only by its explicit slash command and never auto-triggered by conversation content. A skill that other suite machinery also starts keeps that guard and names the caller as its one additional activator: sprint execution closes with `/converge`, `/converge`'s owner list runs `/triage-issues`, and `/document` runs `/audit`. Process text the machinery shares — such as the loop that drains the task tracker, which `/audit`, `/converge`, `/triage-issues`, and sprint execution each follow — is read by path, is not a skill, and carries no activation phrase.

## Rationale

The activation phrase is load-bearing prompt engineering: it prevents the model from invoking consequential ceremonies inferentially because a conversation resembled one. Keeping shared process text out of the skills directory means no skill ever drops the guard, so no verb can fire on resemblance, while the machinery still shares one body by reading it by path. Naming a machine caller instead of dropping the guard keeps a consequential verb guarded whoever starts it.

## Alternatives

- Let skills trigger on inferred intent — consequential verbs (planning, certification, audit) fire on resemblance rather than instruction.
- A plumbing class of skills that drop the guard so machinery can drive them through the skill tool — composable, but a guard-free skill can fire on resemblance, and the class needs a membership rule to stay testable.
- Classify per skill with no stated rule — invites divergent same-named skills.
