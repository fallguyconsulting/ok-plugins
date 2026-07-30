---
audit: whole-file-ownership
artifact: decision:whole-file-ownership
determination: satisfied
audited: 2026-07-30T00:31:21Z
artifact-hash: sha256:3c3d07cc3841
---

# Does the suite's machinery own whole files, never edit human-edited files, and write owner-declared configuration only by transcription?

## Confirmation

Satisfied.

- **Whole files, overwritten wholesale.** The planner's converge renders
  each owned file from a template or a canonical copy — the estate guide,
  the cheatsheet, the estate `.gitignore`, the session hook, the vendored
  skill set, and each pinned support script (`surface-corpus`,
  `bin/audit-check`, `bin/source-graph`, `bin/corpus-view`, `bin/browse`) —
  and writes it whole; `administration.sh` appends a hand-edit to
  `.ok-planner/CLAUDE.md`, requires `diagnose` to report it while writing
  nothing, and requires the next converge to overwrite it — after which a
  third pass leaves `git status` empty, so a compliant estate is a silent
  no-op. `ok-plumbline`'s harness does the same for the fixed-content
  module marker, which carries no stamp and is restored to canonical bytes.
- **Never a file a human also edits.** Write targets are confined per
  family and the confinement is enforced in the ordinary suite:
  `checks/owned-paths` walks each core's redirects, `cp`/`mv`/`rm`
  targets and program writes, allowing only the estate, the family's own
  cheatsheet, the declared vendored-skill destination and the two
  sanctioned regions (the wire-hooks consent path and the estate-rooted
  falsifier migration), and it separately anchors each family's retired
  payload deletion to a declared path. Behaviourally, `ok-workspaces`
  refuses a profile whose `worktrees.dirPrefix` resolves to the
  repository root, naming the offending field, leaving the project's
  root `.gitignore` byte-identical and materializing no estate at all;
  the contract states categorically that nothing in the suite touches
  `.claude/rules/rules.md` or `CLAUDE.md`.
- **Ownership decides consent.** Suite-owned files converge silently
  (the no-op pass above) and the suite's own retired content is migrated
  under the administration's own authorization — `administration.sh`
  seeds a retired vendored `true-up` verb and requires converge to
  remove it without asking, the same `RETIRED_VENDORED` path that sweeps
  the retired `prove` and `browse` copies, and it separately requires the
  read-only diagnose to report a pre-migration layout that converge
  itself never migrates behind the owner's back. Everything else is put
  to the owner: the administration document carries the migration,
  collision and overlapping-context procedures the core cannot encode,
  and enumerates both the set converge materializes and the boundary it
  does not write outside of.
- **Owner-declared configuration is transcription only.** Converge alone
  never creates `.claude/settings.json`; the unwired hook surfaces as a
  `WIRING NEEDED` block carrying the exact entry and the exact consent
  command, and only `wire-hooks` writes the file — asserted by reading
  the transcribed `startup|clear|compact` matcher back out. The static
  confinement check requires every settings write in the planner and
  plumbline cores to sit inside their wire-hooks regions, and requires
  `ok-workspaces`, which declares no hooks, never to mention the
  settings file at all. `ok-workspaces`' profile is likewise owner-
  decided: its core exits rather than generate one.

## Citations

- cite-node: checks/owned-paths @ sha256:3266bb91cebe
- cite-node: checks/run @ sha256:e827e4abcc44
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite: plugins/ok/test/administration.sh :: "diagnose reports drift in a suite-owned file (read-only, non-zero exit)"
- cite: plugins/ok/test/administration.sh :: "converge repairs the drifted suite-owned file by overwrite"
- cite: plugins/ok/test/administration.sh :: "third pass is a no-op: git status empty on a compliant estate"
- cite: plugins/ok/test/administration.sh :: "retired merged true-up verb removed on converge"
- cite: plugins/ok/test/administration.sh :: "pre-migration layout is reported, never migrated behind the owner's back"
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807
- cite-node: plugins/ok/families/ok-planner/admin/converge#vendor_layer @ sha256:5bf5d865a18f
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:541131a0bdf2
- cite-node: plugins/ok/families/ok-workspaces/admin/converge @ sha256:dce6458e6225
- cite-node: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md @ sha256:d66a8e7f0cbe
- cite-node: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md @ sha256:0b27683cd564
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-ownership-rule @ sha256:ff37227ce842
