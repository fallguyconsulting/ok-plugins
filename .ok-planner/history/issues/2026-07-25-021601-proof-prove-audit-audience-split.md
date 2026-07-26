---
issue: proof-prove-audit-audience-split
kind: discover
category: proof
artifacts:
  - decision:prove-audit-audience-split
status: promoted
opened: 2026-07-25T02:16:01Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# The prove/audit channel split has no proof; the owner's precedent prescribes its shape

`decision:prove-audit-audience-split` — `/prove` returns findings in-context for the executing agent and never writes the issue intake, while `/audit` files for the human — has no enforcing check, and says so: "No enforcing check exists today... the channel discipline lives in prompt text." Whether a prove run writes the intake is a choice an agent makes while following skill prose; the plugin is markdown and bash by design, so there is no interception layer that could mechanically observe the discipline, even in principle.

The owner's ruling in `prompt-executed-checks-as-proofs` (this intake, 2026-07-25) already decided what happens to decisions of exactly this shape — it named this decision as one of its examples. Prompt-realized discipline gets a **declared text-presence proof**: the governing lines ("never writes to the issue intake" in `/prove`'s skill text, filing as the audit's only write in `/audit`'s) must stand greppably in the prompt text; the falsifier is those lines deleted or reworded; the Proof field declares it checks presence, not behavior.

## Options

- **Apply the precedent** — rewrite the Proof field as the declared text-presence check over the two skills' channel lines. Forced by the standing ruling.
- **Leave the gap open** — precluded by the same ruling.

## Ruling

> Generated ruling (/verify-issues): apply the prompt-executed-checks precedent — the sprint rewrites `decision:prove-audit-audience-split`'s Proof field as a declared text-presence check (the channel-discipline lines in `prove/SKILL.md` and `audit/SKILL.md`, falsifier = either line deleted or reworded, declared presence-not-behavior). Rule in the same batch as `proof-filesystem-discovery-markers` and `proof-relevance-scoped-queue-gate`.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
