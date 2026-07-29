---
audit: converge-project-estate
artifact: story:converge-project-estate
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:da701156342a
---

# Is each family's project-side estate bootstrapped or repaired to the carried suite version, with retired layouts migrated and consent asked?

## Confirmation

Satisfied. Each of the three carried families — `ok-planner`,
`ok-plumbline`, `ok-workspaces`, enumerated from `plugins/ok/families/`,
whose membership `checks/vendored-layer` pins — exposes an idempotent
converge core that reads the front-door manifest for its stamp, and every
clause of the story is exercised end to end for every family.

- **Bootstrap.** `administration.sh` converges `ok-planner` into an empty
  git repo and asserts the estate layout, the version stamp read back off
  `.ok-planner/CLAUDE.md`, the cheatsheet, the executable hook and the
  vendored skill set; the same harness converges `ok-workspaces` from a
  transcribed profile and reads its stamp back; `run.sh` converges
  `ok-plumbline` into an empty repo and requires its own diagnose to be
  clean.
- **Repair, to the byte.** `administration.sh` hand-edits
  `.ok-planner/CLAUDE.md`, requires `diagnose` to report it non-zero,
  requires `converge` to overwrite it, and a third pass to leave
  `git status` empty. `demo.sh` drifts four `ok-workspaces` artifacts at
  once (two byte-compared scripts, the version stamp in the cheatsheet, a
  vendored skill), requires each as a named DRIFT line, and compares a
  git-blob manifest of the whole estate before and after to prove the
  repair is byte-identical, with a third pass unchanged.
  `run.sh`'s module-marker case drifts and restores `ok-plumbline`'s
  fixed-content artifact the same way.
- **Migrating retired layouts.** `ok-planner`: the four retired estate
  payloads are seeded and swept, the report naming each; `## Falsifier` /
  `## Proof` / `## Acceptance` are stripped from a story while the prose
  between them survives byte-for-byte, the retired concept file and its
  single TOC line go and the sibling TOC line stays; every
  `detect_premigration` marker is seeded at once and the whole set is
  required on converge's last line and again from diagnose, with the
  layout itself left unmigrated. `ok-plumbline`: the root config and
  budget baseline are moved (not copied) into the estate, contents
  compared, and shown still governing the lint and the ratchet from their
  new paths; the two-copies case reports `CONFLICT` for the owner with
  both copies intact and the estate's copy still governing.
  `ok-workspaces`: the retired hook, context payload and merged verb are
  seeded, diagnosed, removed with their emptied directories, and the
  estate compared back to a fresh converge.
- **Asking before touching what is the owner's.** Converge alone never
  writes `.claude/settings.json`; the unwired hook surfaces as a
  `WIRING NEEDED` block; `wire-hooks` transcribes the entry with the
  exact `startup|clear|compact` matcher, read back out of the file. On
  the `ok-workspaces` side a profile that would make converge write the
  project's root `.gitignore` is refused before any write, and that file
  is compared byte-for-byte afterwards.

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:7200bf002ec9
- cite-node: plugins/ok/families/ok-planner/admin/converge#detect_premigration @ sha256:be1a3965087b
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/families/ok-workspaces/scripts/diagnose.js @ sha256:28bef14ec895
- cite-node: checks/vendored-layer @ sha256:32ecd23819c3
- cite-node: checks/run @ sha256:e827e4abcc44
- cite-node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
- cite: plugins/ok/test/administration.sh :: "  ok "third pass is a no-op: git status empty on a compliant estate""
- cite: plugins/ok/test/administration.sh :: "  ok "## Falsifier / ## Proof / ## Acceptance stripped, the rest of the story byte-for-byte intact""
- cite: plugins/ok/test/administration.sh :: "  && ok "converge reports every pre-migration marker on its last line and points at ADMINISTRATION.md" \"
- cite: plugins/ok/test/administration.sh :: "  && ok "converge alone never touches .claude/settings.json" \"
- cite: plugins/ok/test/administration.sh :: "  && ok "wire-hooks transcribes the exact consented entry (startup|clear|compact)" \"
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge did not restore the drifted estate to the canonical bytes""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge does not report which retired payloads it removed: $removal""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge edited the project's root .gitignore — a human-owned file""
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_module_marker_fidelity_case @ sha256:9322d9d15982
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_retired_layout_migration_case @ sha256:01e3b40154e0
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_retired_layout_conflict_case @ sha256:ce834d133027
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-administration-surfaces @ sha256:bdc1c5438957
