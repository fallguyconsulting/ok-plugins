---
audit: converge-project-estate
artifact: story:converge-project-estate
determination: satisfied
audited: 2026-07-27T13:40:00Z
artifact-hash: sha256:f28e3dbddfd5
---

# Does administering a family bootstrap an empty project, repair a drifted one to the carried version, migrate retired layouts body-untouched, no-op on a compliant one, and surface owner territory for consent?

## Claims

**Title + Story — "each family's project-side estate bootstrapped or repaired
to match the suite version my machine carries — migrating retired layouts and
asking before touching anything that is mine."** The front door administers by
driving each family's two conventional surfaces from the payload — diagnose,
consult the administration document, converge, hold the wiring — and states
that every converge is an idempotent installer, so it never needs to know
whether it is bootstrapping or repairing. Honored.

**Acceptance conjunct 1 — "on an empty project the estate is materialized
whole."** The planner core creates the estate subtree, renders the guide and
cheatsheet from templates, materializes the hook and helper scripts, and
vendors the skill set. Exercised: the harness initialises a bare git repo, runs
the core once, and asserts the estate layout, the version-stamped guide, the
cheatsheet, an executable session hook, and a ten-file vendored skill set all
appear. Honored.

**Acceptance conjunct 2 — "on a drifted project the suite-owned layer is
overwritten to match the carried version."** Diagnose compares each
materialized file against the carried rendering at the suite version and exits
non-zero on any mismatch; converge rewrites it. Exercised: the harness appends
a hand edit to a suite-owned file, asserts diagnose reports drift read-only and
non-zero, then converges and asserts the edit is gone. Honored.

**Acceptance conjunct 3 — "and retired layouts are migrated with bodies
untouched."** Two halves. The mechanical half is in the cores: retired vendored
payloads and retired estate payloads are removed on converge, and the harness
seeds a retired merged verb before pass 1 and asserts it is gone afterwards.
The judgment half is in the administration document, which states that the
migrations are mechanical — files move between directories, contents are not
rewritten, `history/` preserves the record — and instructs explicitly to leave
moved files' contents alone, an archived record that calls itself by its old
name being a record of what it was. Honored.

**Acceptance conjunct 4 — "on a compliant project nothing changes at the git
level."** The core documents itself as idempotent, and the harness proves it:
after committing the converged estate it runs converge a third time and asserts
`git status --porcelain` is empty, then asserts diagnose is clean. Honored.

**Acceptance conjunct 5 — "anything owner-declared or overlapping is surfaced
for consent rather than silently converted."** Hook wiring is owner-declared:
converge prints a `WIRING NEEDED` block and writes nothing, and only the
`wire-hooks` mode transcribes the entry. Exercised: the harness asserts the
block appears on pass 1, asserts `.claude/settings.json` does not exist after
converge alone, and then asserts `wire-hooks` writes exactly the
`startup|clear|compact` entry. Overlapping preexisting content is routed by the
administration document to a proposed conversion plan for the owner's consent,
never converted silently; the front door additionally records a declined
bootstrap as a valid state rather than drift, which the harness asserts against
the front door's own body. Honored.

**Acceptance conjunct 6 — "Each family's diagnose-and-converge machinery is
real."** The population is the three families, enumerated from
`plugins/ok/families/`. ok-planner's core carries all three modes;
ok-plumbline's core wraps the family binary's mechanics with the same modes;
ok-workspaces' core execs its diagnose and converge scripts and declares no
`wire-hooks` because it declares no hooks. The maintenance check `vendored-layer`
asserts, per family, that `admin/converge` exists and is executable and that
`admin/ADMINISTRATION.md` exists. The harness additionally drives a second
family's core for real — converging ok-workspaces from a declared profile in a
project where ok-planner is already integrated, and asserting its cheatsheet
materialises at the carried version while the declined third family is left
untouched. Honored.

**Falsifier — "repeated runs churn the working tree; a hand-edited or
owner-declared file is silently overwritten; a retired layout is left
half-migrated or its archived records rewritten; or a missing estate fails to
bootstrap."** None obtains: pass 3 leaves an empty git status; the settings
file is untouched by converge; the retired verb is fully removed and the
migration procedures forbid rewriting moved bodies; and pass 1 bootstraps from
nothing.

**Proof-field span.** The Proof names a demo of three consecutive
administration passes on one project — bootstrap from nothing, repair after
deliberate drift in a suite-owned file, no-op on the resulting compliant estate
with git status empty after the third. The harness is exactly that, in that
order, with the git-status assertion as its third pass, plus the consented
wiring step and the two-family consolidated act.

## Determination

**Satisfied.** All three passes the Proof names are exercised for real against
a live converge core, in order, with the empty-git-status assertion at the end;
the consent boundary is exercised both negatively (converge writes no settings
file) and positively (`wire-hooks` transcribes the exact entry); retired-payload
removal is exercised and body-preserving migration is the documented procedure;
and every one of the three families exposes real diagnose-and-converge
machinery, with a second family driven end to end in the same harness.

This stops holding if: converge stops being idempotent (pass 3's git-status
assertion goes red); diagnose stops reporting drift in a suite-owned file or
stops being read-only; the retired-payload sweep is dropped; converge acquires
a path to `.claude/settings.json` outside `wire-hooks`, or the matcher is
widened; a family loses its converge core or administration document; or the
migration procedures stop forbidding rewrites of moved file bodies.

## Citations

- cite: plugins/ok/test/administration.sh :: "# @story: converge-project-estate"
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 1: bootstrap from nothing" +28 sha256:1ad7f894fe98
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 2: repair after deliberate drift in a suite-owned file" +11 sha256:d54b241833e6
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 3: no-op on a compliant estate" +12 sha256:7cf01fea76ad
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "check_rendered() {" +10 sha256:2fd5f3e4dc75
- cite: plugins/ok/families/ok-planner/admin/converge :: "Idempotent. Re-running converge on a project already in compliance"
- cite: plugins/ok/families/ok-planner/admin/converge :: "for retired in context/skills-index.md hooks/user-prompt-submit; do"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "migrations below are mechanical: files move between directories,"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Leave the moved files' contents alone."
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "propose a conversion plan for the owner's consent"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "BIN="${FAMILY}/bin/plumbline""
- cite: plugins/ok/families/ok-workspaces/admin/converge :: "diagnose) exec node "
- cite: plugins/ok/skills/ok/SKILL.md :: "the read-only report: layout, materialized-artifact fidelity and stamps"
- cite: plugins/ok/skills/ok/SKILL.md :: "the deterministic materialization of the suite-owned layer"
- cite-file: checks/vendored-layer @ sha256:b4b8667046f8
