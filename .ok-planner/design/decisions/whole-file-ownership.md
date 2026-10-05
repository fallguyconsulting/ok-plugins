---
decision: whole-file-ownership
---

# The suite owns whole files and never edits human-edited files, save a retired family's unread state file

## Choice

The suite's machinery — the front door's administration and ok-planner's converge core — owns whole files only: version-stamped — save for a fixed-content file, whose bytes never vary across suite versions and which carries no stamp to verify by — deterministically regenerable, overwritten wholesale. It never edits a file a human also edits, save the one removal of a retired family's unread state file below; the consumer's own rules file and memory file are categorically untouchable. Records are where the ownership rule stops. The estate preserves them indefinitely, a migration moves them and never rewrites their bodies, and an archived record keeps the wording it closed with. Ownership decides consent: suite-owned files converge silently, and the suite's own retired-layout content is suite territory, migrated mechanically under the administration's own authorization. A retired family's state file, such as its profile or its baseline, is part of that content once nothing reads it after the converge, even where the owner edited it; removing it is the one removal of a human-edited file the converge makes without the owner's word. Converge removes a committed one whole, recoverable from version history, and names each removed file in its report; an uncommitted or symlinked one goes to the owner like any other estate edit, and a state file a kept script still reads stays. Anything else at a path the suite cares about — hand-written overlaps, preexisting guidance the suite would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment the machinery edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the suite's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill. A retired family's state file configured a family that no longer runs, so nothing the owner relies on reads it, and version history keeps whatever the owner added. A record states what was true when it was written, so rewriting one to match a current layout destroys the only thing it is for.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the machinery destroys or shadows guidance the project chose deliberately.
- Consent-gating the suite's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.
- Offer each retired state file before removing it — protects a hand-added key, and puts one more question on the first converge of every project that used the retired family.
