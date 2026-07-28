---
audit: converge-project-estate
artifact: story:converge-project-estate
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:f28e3dbddfd5
---

# Does administering a family bootstrap an empty project, repair a drifted one to the carried version, migrate retired layouts body-untouched, no-op on a compliant one, and surface owner territory for consent?

## Claims

The design artifact is unchanged from the previous cycle (hash identical), so
prior determinations bind absent moved reality. Two things moved, both outside
the converge core itself. First, this repo's maintenance check
`checks/vendored-layer` was rewritten: its first conjunct is now a
`git status --porcelain` cleanliness gate over the pinned suite-owned paths,
replacing the old conjunct that ran the planner family's diagnose against this
repo's working tree. Second, this repo's vendored planner layer was restored to
its pinned HEAD state, so it legitimately lags the family source until the
owner's next release → update → `/ok` converge — that lag is
`decision:per-project-pinning` working, never a violation. One prior claim
leaned on the removed conjunct and is re-verified against what now holds; the
carried note below is restated verbatim with its adjudication intact, and every
claim was re-run against the tree.

**Title + Story — "each family's project-side estate bootstrapped or repaired to
match the suite version my machine carries — migrating retired layouts and
asking before touching anything that is mine."** The front door administers by
driving each family's two conventional surfaces from the payload — diagnose,
consult the administration document, converge, hold the wiring — and the core
states that it is an idempotent installer, so it never needs to know whether it
is bootstrapping or repairing. Honored.

**Acceptance conjunct 1 — "on an empty project the estate is materialized
whole."** The planner core creates the estate subtree, renders the guide and
cheatsheet from templates, materializes the hook and the three helper scripts
(`scripts/surface-corpus`, `bin/audit-check`, and `bin/source-graph`), and
vendors the skill set. Exercised: the harness initialises a bare git repo, runs
the core once, and asserts the estate layout, the version-stamped guide, the
cheatsheet, an executable session hook, and a ten-file vendored skill set all
appear.

The harness's bootstrap assertions name specific artifacts and do not name
`bin/source-graph` — but "whole" is not left to that list. Diagnose enumerates
the same materialize set it writes, and a missing member is a `missing:` finding
that exits non-zero; the harness asserts diagnose is clean on the converged
estate, so an unmaterialized `bin/source-graph` would turn that assertion red.
Re-verified this cycle against the changed reality: the corroboration the prior
pass drew from `checks/vendored-layer` running the same diagnose over this
repo's own estate is gone, because that check no longer runs diagnose at all —
it now gates on the pinned layer being byte-identical to HEAD, and fidelity
against the canonical rendering is the administration act's job (`/ok` drives
the family's own diagnose at converge time), not the maintenance check's. The
family's diagnose is untouched by that rewrite and consumers still reach it
through `/ok`; what carried the conjunct all along is the harness's
`diagnose clean on the converged estate` assertion, which drives the real
diagnose over a real converged estate on a fixture tree, independent of this
repo's own lag. That assertion is now cited directly. Re-run this cycle: green,
with the whole harness at twenty-five assertions, exit 0. Honored — and honored
for the new member specifically, not just for the members the harness happens
to name.

**Acceptance conjunct 2 — "on a drifted project the suite-owned layer is
overwritten to match the carried version."** Diagnose compares each materialized
file against the carried rendering at the suite version — a `sed` render piped
to `cmp -s`, byte-for-byte — and exits non-zero on any mismatch; converge
rewrites it. `bin/source-graph` goes through the same `check_rendered`
function as its siblings, so it is drift-checked on the same terms. Exercised:
the harness appends a hand edit to a suite-owned file, asserts diagnose reports
drift read-only and non-zero, then converges and asserts the edit is gone.
Honored.

Worth separating for a later reader, because this cycle is exactly the case
that confuses the two: *drift* in this conjunct's sense is a project's estate
diverging from the rendering at the version that project was converged to. It
is not the gap between a project's converged estate and a family source that
has since moved ahead — that gap is per-project pinning, and closing it is the
owner's deliberate act, not something converge does mid-flight. This repo's
vendored layer currently sits in the second state and in none of the first.

**Acceptance conjunct 3 — "and retired layouts are migrated with bodies
untouched."** Two halves. The mechanical half is in the cores: retired vendored
payloads and retired estate payloads are removed on converge, and the harness
seeds a retired merged verb before pass 1 and asserts it is gone afterwards. The
judgment half is in the administration document, which states that the
migrations are mechanical — files move between directories, contents are not
rewritten, `history/` preserves the record — and instructs explicitly to leave
moved files' contents alone. Honored.

**Acceptance conjunct 4 — "on a compliant project nothing changes at the git
level."** The core documents itself as idempotent, and the harness proves it:
after committing the converged estate it runs converge a third time and asserts
`git status --porcelain` is empty, then asserts diagnose is clean. Re-run this
cycle over an estate that includes `bin/source-graph`: both pass. Honored.

**Acceptance conjunct 5 — "anything owner-declared or overlapping is surfaced
for consent rather than silently converted."** Hook wiring is owner-declared:
converge prints a `WIRING NEEDED` block and writes nothing, and only the
`wire-hooks` mode transcribes the entry. Exercised: the harness asserts the block
appears on pass 1, asserts `.claude/settings.json` does not exist after converge
alone, and then asserts `wire-hooks` writes exactly the `startup|clear|compact`
entry. Overlapping preexisting content is routed by the administration document
to a proposed conversion plan for the owner's consent, never converted silently;
the front door additionally records a declined bootstrap as a valid state rather
than drift, which the harness asserts against the front door's own body.
Honored.

**Acceptance conjunct 6 (quantified) — "Each family's diagnose-and-converge
machinery is real."** The population is the three families, enumerated from
`plugins/ok/families/`. ok-planner's core carries all three modes;
ok-plumbline's core wraps the family binary's mechanics with the same modes;
ok-workspaces' core execs its diagnose and converge scripts and declares no
`wire-hooks` because it declares no hooks. `checks/vendored-layer` asserts, per
family, that `admin/converge` exists and is executable and that
`admin/ADMINISTRATION.md` exists — that conjunct survived the rewrite unchanged
and is cited at its loop head below, with the file pinned whole as the
population source. The harness additionally drives a second family's core for
real — converging ok-workspaces from a declared profile in a project where
ok-planner is already integrated, asserting its cheatsheet materialises at the
carried version while the declined third family is left untouched. Honored;
`checks/run` passes all seven this cycle.

**Falsifier — "repeated runs churn the working tree; a hand-edited or
owner-declared file is silently overwritten; a retired layout is left
half-migrated or its archived records rewritten; or a missing estate fails to
bootstrap."** None obtains: pass 3 leaves an empty git status; the settings file
is untouched by converge; the retired verb is fully removed and the migration
procedures forbid rewriting moved bodies; and pass 1 bootstraps from nothing.

**Proof-field span.** The Proof names a demo of three consecutive administration
passes on one project — bootstrap from nothing, repair after deliberate drift in
a suite-owned file, no-op on the resulting compliant estate with git status
empty after the third. The harness (`plugins/ok/test/administration.sh`, carrying
the `@story:` annotation) is exactly that, in that order, with the git-status
assertion as its third pass, plus the consented wiring step and the two-family
consolidated act. Run this cycle: all twenty-five assertions pass, exit 0.

## Determination

**satisfied.** All three passes the Proof names are exercised for real against a
live converge core, in order, with the empty-git-status assertion at the end;
the consent boundary is exercised both negatively (converge writes no settings
file) and positively (`wire-hooks` transcribes the exact entry); retired-payload
removal is exercised and body-preserving migration is the documented procedure;
and every one of the three families exposes real diagnose-and-converge
machinery, with a second family driven end to end in the same harness. The
estate's newest artifact rides inside the guarantee rather than beside it: it
is materialized by the same stamped-and-chmod'd shape, drift-checked by the same
`check_rendered` byte comparison, and covered by the harness's
diagnose-clean assertion, which would fail if converge stopped writing it.

The determination does not move on the changed reality, and the reason is worth
recording because the same confusion will recur. This story is a claim about
what the family's converge does to *a project's* estate, so its evidence is the
family source under `plugins/ok/families/` and a harness that drives that source
against fixture projects — not this repo's own vendored copies, which
`decision:per-project-pinning` deliberately holds at the last committed
converge. The rewritten `checks/vendored-layer` moved this repo's maintenance
posture from "diagnose says the layer matches the carried rendering" to "git
says the layer matches HEAD", which is the correct posture for a pinned layer
and which says nothing about whether converge works. Nothing this conjunct
needs was lost: the diagnose it relied on still exists, still enumerates its
full materialize set, and is still exercised — by the harness, on a real
converged estate, and by `/ok` on a real consumer project.

This stops holding if: converge stops being idempotent (pass 3's git-status
assertion goes red); diagnose stops reporting drift in a suite-owned file, stops
being read-only, or drops a member from its materialize-and-check set (the pins
on `check_rendered`, on the source-graph diagnose call, and on the materialize
block break); the retired-payload sweep is dropped; converge acquires a path to
`.claude/settings.json` outside `wire-hooks`, or the matcher is widened; a family
loses its converge core or administration document (the `cite-file` on
`checks/vendored-layer` is the population source and the pinned loop head is
where that conjunct lives); the harness loses its `diagnose clean on the
converged estate` assertion, which is now the only place the real diagnose is
run over a real converged estate; or the migration procedures stop forbidding
rewrites of moved file bodies.

## Notes

- note: admin/converge and admin/ADMINISTRATION.md (source-graph-certification sprint) add a new materialize-and-diagnose pair for `bin/source-graph` — a new `[ -f "$SOURCE_GRAPH" ] && check_rendered ...` diagnose call and a new stamp/chmod materialize block, mirroring the existing `bin/audit-check` handling — plus the owned-set prose gains `bin/source-graph`. The cited `check_rendered() {` span pins the function's own body, not each call site, and the cited "Idempotent"/"for retired in..." lines are untouched, so citation staleness did not catch this new artifact even though this story's claim ("each family's project-side estate bootstrapped or repaired to match the suite version my machine carries") plausibly extends to it.
  adjudication: promoted — the note is right that the claim extends to the new artifact and right that no citation covered it. Citations now carried: `cite: plugins/ok/families/ok-planner/admin/converge :: "    [ -f "$SOURCE_GRAPH" ] && check_rendered "$SOURCE_GRAPH" "${OK_DIR}/bin/source-graph" ".ok-planner/bin/source-graph""` (the diagnose call site the function-body span could not see), `cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4` (the materialize block), and `cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (\`scripts/surface-corpus\`, \`bin/audit-check\`,"` (the administration document's materializes list). The substantive finding the promotion produced, recorded so it is not re-derived: the estate's wholeness is not carried by the harness's named-artifact assertions — which do not name the new member — but by the harness's `diagnose clean on the converged estate` assertion over a diagnose that enumerates the full materialize set, which is why a dropped member still turns the proof red.

## Citations

- cite: plugins/ok/test/administration.sh :: "# @story: converge-project-estate"
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 1: bootstrap from nothing" +28 sha256:1ad7f894fe98
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 2: repair after deliberate drift in a suite-owned file" +11 sha256:d54b241833e6
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 3: no-op on a compliant estate" +12 sha256:7cf01fea76ad
- cite: plugins/ok/test/administration.sh :: "diagnose clean on the converged estate"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "check_rendered() {" +10 sha256:2fd5f3e4dc75
- cite: plugins/ok/families/ok-planner/admin/converge :: "    [ -f "$SOURCE_GRAPH" ] && check_rendered "$SOURCE_GRAPH" "${OK_DIR}/bin/source-graph" ".ok-planner/bin/source-graph""
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite: plugins/ok/families/ok-planner/admin/converge :: "Idempotent. Re-running converge on a project already in compliance"
- cite: plugins/ok/families/ok-planner/admin/converge :: "for retired in context/skills-index.md hooks/user-prompt-submit; do"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (`scripts/surface-corpus`, `bin/audit-check`,"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "migrations below are mechanical: files move between directories,"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Leave the moved files' contents alone."
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "propose a conversion plan for the owner's consent"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "BIN="${FAMILY}/bin/plumbline""
- cite: plugins/ok/families/ok-workspaces/admin/converge :: "diagnose) exec node "
- cite: plugins/ok/skills/ok/SKILL.md :: "the read-only report: layout, materialized-artifact fidelity and stamps"
- cite: plugins/ok/skills/ok/SKILL.md :: "the deterministic materialization of the suite-owned layer"
- cite: checks/vendored-layer :: "    core = os.path.join(FAMILIES_DIR, family, "admin", "converge")"
- cite-node: checks/vendored-layer @ sha256:c6e96ed8f08c
