---
issue: planner-tooling-constraint-vs-python
kind: discover
category: conflicting
artifacts:
  - concept:plugin
status: verified
opened: 2026-07-25T02:17:33Z
---

# The planner's contributor doc misdescribes its own script surface

`plugins/ok-planner/CLAUDE.md` tells contributors "No Node tooling; skills are markdown, hooks are bash" — but the plugin ships `scripts/surface-corpus`, which is Python. A contributor trusting the constraint gets a wrong picture of the sanctioned surface, and the sentence reads as forbidding exactly one thing (Node) while silently permitting a language it never mentions.

The corpus barely reaches this. `concept:plugin` speaks of "small scripts" without language constraints, and the concept-authoring rules *forbid* fixing it at concept altitude — a concept body must not enumerate current implementations, so "bash/markdown/python" can never appear in `concept:plugin`. The contributor CLAUDE.md sits outside `design/` entirely; the corpus's self-containment and current-state rules don't govern it. So the genuine defect is one inaccurate sentence in a contributor doc, and the only open question is whether the corpus should additionally gain a general invariant ("each plugin's tooling constraints, as stated in its contributor docs, are kept accurate") — which is a rule about doc hygiene, not about design.

## Options

- **Fix the sentence** — reword the constraint to what's true: no Node tooling; skills are markdown, hooks are bash, support scripts are bash or python. A one-line work item; no corpus delta.
- **Fix the sentence and add a corpus invariant** — the general accuracy rule in `concept:plugin`. Adds corpus weight to police one sentence per plugin; the compliance machinery that would check it doesn't read contributor docs today.

The ruling decides: doc fix alone, or doc fix plus corpus rule.

## Ruling

> Recommended ruling (/verify-issues): fix the sentence alone — a sprint work item corrects `plugins/ok-planner/CLAUDE.md`'s tooling line to name the actual sanctioned surface; no corpus delta.
>
> Rationale: the defect is a stale sentence, and the corpus's own altitude rules already (correctly) refuse to host language enumerations — adding a meta-invariant about doc accuracy would be corpus machinery for a class with one known instance. If contributor-doc drift recurs, that pattern is a new issue with real evidence.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
