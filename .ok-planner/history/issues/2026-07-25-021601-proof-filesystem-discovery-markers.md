---
issue: proof-filesystem-discovery-markers
kind: discover
category: proof
artifacts:
  - decision:filesystem-discovery-markers
status: promoted
opened: 2026-07-25T02:16:01Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# The discovery-markers decision has no proof; the owner's precedent already prescribes its shape

`decision:filesystem-discovery-markers` — whether a project uses a plugin is a filesystem check against documented markers, never an inference — carries no enforcing check. Its Proof field says so itself: "No enforcing check exists today... Filed to the intake queue for owner calibration." The discipline lives entirely in the front door's prompt text, and nothing but an agent reading two documents side by side could ever compare the dispatcher's marker list against the contract's.

This is a question the owner has already ruled on in kind. The ruling in `prompt-executed-checks-as-proofs` (this intake, 2026-07-25) settled the pattern: prompt-realized discipline cannot get a behavior-level proof; a decision of this shape may instead carry a **declared text-presence proof** — the rule still stands, greppably, in the governing prompt or contract text; the falsifier is that line deleted or reworded; and the Proof field must say it checks presence, not behavior. This decision is one of the cases that ruling was made about: the markers are consulted at runtime by an agent following the dispatcher's prose, which no independent tool can observe. The only open work in the neighborhood — one marker the dispatcher honors but the contract doesn't document — is the sibling issue `plumbline-discovery-marker-undocumented`, ruled separately; this issue concerns only the Proof field's shape.

## Options

- **Apply the precedent** — rewrite the decision's Proof as a declared text-presence check: the marker rules stated in the dispatcher's skill text and the contract's current-conformance section; falsifier = a marker referenced anywhere that the contract does not document; declared as presence-not-behavior. Forced by the standing ruling.
- **Leave the gap open** — precluded; the ruling exists precisely to close this fork.

## Ruling

> Generated ruling (/verify-issues): apply the prompt-executed-checks precedent — the sprint rewrites `decision:filesystem-discovery-markers`' Proof field as a declared text-presence check (marker rules present in the dispatcher text and contract, falsifier = an honored-but-undocumented marker, declared presence-not-behavior), replacing the "filed to the intake queue" placeholder. Rule in the same batch as `proof-prove-audit-audience-split` and `proof-relevance-scoped-queue-gate`, which take the identical shape.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
