---
decision: whole-file-ownership
status: as-is
---

# Plugins own whole files and never edit human-edited files

## Choice

A plugin owns whole files only — version-stamped, deterministically regenerable, overwritten wholesale — and never edits a file a human also edits; the consumer's own rules file and memory file are categorically untouchable. Ownership decides consent: plugin-owned files converge silently; anything else at a path the plugin cares about — earlier-version estates, hand-written overlaps, preexisting guidance the plugin would now govern — is presented for the owner's decision, and owner-declared configuration is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment a plugin edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the plugin destroys or shadows guidance the project chose deliberately.

## Proof

No enforcing check exists today: diagnosis verifies the plugin-owned layer's fidelity but nothing fails if a plugin writes into a human-edited file; the boundary lives in contract prose and skill text. Filed to the intake queue for owner calibration.
