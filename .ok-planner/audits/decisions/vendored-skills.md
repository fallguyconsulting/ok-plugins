---
audit: vendored-skills
artifact: decision:vendored-skills
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:042d89fc84f6
---

# Does everything project-scoped reach a consumer as committed, version-stamped vendored files with the harness pointed at them project-side — and does a cloned converged project actually yield working skills with nothing installed?

## Claims

The design artifact is unchanged from the previous cycle (hash identical), so
prior determinations bind absent moved reality. What moved this cycle is the
plumbline converge core, pinned whole below as one of clause 1's enumeration
sources: its module-marker write changed mechanism, from an inline `printf` of a
literal to `node "$BIN" module-marker >`, taking its bytes from a single
canonical constant in the family binary. Clause 1's population was re-enumerated
from the three cores rather than carried. The previous cycle's adjudicated note
on the planner core's added support script is carried forward verbatim.

**Choice clause 1 (quantified) — "Everything project-scoped the suite delivers —
skill files, hook implementations, support scripts, context payloads,
cheatsheets — reaches a consumer project as committed, version-stamped files
materialized from the front-door plugin's carried family payload by its
administration."** The population is every file the three families' converge
cores write into a consumer, enumerated by reading each core (all three pinned
whole below as the enumeration source). Eighteen write targets:

- ok-planner (7): the estate guide, the cheatsheet, the session-start hook,
  **three** support scripts — `scripts/surface-corpus`, `bin/audit-check`, and
  now `bin/source-graph` — and the skill set. Each of the first six is rendered
  from a payload template with `{{OK_PLANNER_VERSION}}` substituted; the skill
  files carry an appended `Materialized by ok-planner v%s` stamp. The new
  `bin/source-graph` is materialized by the same `sed`-and-`chmod 755` shape as
  `bin/audit-check`, from a payload source that carries the placeholder — so it
  is a stamped, committed, project-side support script, squarely inside this
  clause's enumerated kinds and delivered exactly the way the clause requires.
  The family's own administration document lists it in both the materializes
  sentence and the owned-set sentence.
- ok-plumbline (5): the cheatsheet, the estate's module marker, the vendored
  binary (its version constant rewritten), the edit hook, and the skill set.
  The marker is the one that moved: its bytes now come from the binary's
  `MODULE_MARKER` constant via an emit-only `module-marker` subcommand the core
  redirects into place. It is still materialized from the carried payload into
  the project, still suite-owned, still overwritten wholesale — and still the
  one member of this population that carries no version stamp, for the reason
  recorded in the Determination.
- ok-workspaces (6): the src-tag script at the profile-declared path, the
  port-block allocator where the profile declares that runtime, the cheatsheet,
  the two worktree ignore files, and the skill set — all through a single
  stamping helper or the version-bearing ignore header.

Retired payloads from earlier versions are removed by the same cores, so nothing
project-scoped reaches a consumer outside this path. Honored, with one boundary
case carried forward and recorded in the Determination: the module marker is
materialized and suite-owned but, being JSON, carries no version stamp.

**Choice clause 2 — "the harness is pointed at them project-side: skills live in
the project's committed skills directory under the contract's collision rule."**
All three cores render into the project's `.claude/skills/`, each mapping its
source verbs to materialized names with the `audit` verb family-prefixed because
more than one family claims it, and rewriting sibling slash-command references
to the materialized names with a hyphen guard so support-script paths survive.
Exercised this cycle against a live converge: the administration harness
bootstraps a bare repo and comes back with a ten-file vendored skill set, and
asserts explicitly that the renderer did not corrupt `bin/audit-check` into
`ok-planner-audit-check`. Honored.

**Choice clause 3 (quantified) — "hooks are declared in the project's committed
harness settings by consented transcription, every session-start entry carrying
the startup-clear-compact matcher and never firing on resume."** The population
of session-start entries the suite declares into a *project's* settings is one:
ok-planner's, whose matcher is exactly `startup|clear|compact` and whose command
reaches the materialized hook through `$CLAUDE_PROJECT_DIR`. ok-plumbline's is a
`PostToolUse` entry, not a session-start entry; ok-workspaces declares no hooks
and its core has no wire-hooks mode. Both settings writes happen only in a
dedicated `wire-hooks` mode, with diagnose reporting a missing or widened matcher
as a finding carrying the exact entry and the exact consent command. `resume` is
absent from the matcher, so the entry cannot fire on resume; the harness reads
the written matcher back and asserts it verbatim. Honored.

**Choice clause 4 — "The plugin system delivers only the user-scoped plugins —
the front door carrying the families, and the conduct."** The marketplace catalog
is pinned below and lists exactly two entries: the conduct and the front door.
The families sit inside the front door's payload and carry no manifests. The
maintenance check additionally asserts that no family ships family-root hooks and
that the front door ships none either. Honored.

**Choice clause 5 — "A converged project is self-contained for running the
suite: cloning it yields the working skills with nothing installed; converging
needs only the front door."** The population is the vendored verb set of the
three families, enumerated from each core's own vendoring map: ten planner verbs
plus the shared blocks, four workspaces verbs, ten plumbline verbs. Neither the
planner's nor the workspaces' vendored skills reference the payload at all. For
the ten plumbline verbs the previous cycle ran the exhibit — converge, commit,
clone, run each verb's own `Run` block with `CLAUDE_PLUGIN_ROOT` unset — and the
family's `run_clone_self_containment_case` is the standing deterministic form of
it, cited below and unchanged.

Re-derived for the new member: the two certify gates reach the source-graph tool
as `.ok-planner/bin/source-graph build` and name no payload path for it at all,
so it does not weaken this clause — a cloned converged project carries the tool
its gates invoke. Honored.

**Rationale — "one installed copy serves every project … Committing the
behavioral surface to the project makes the version a property of the repo."**
Each project's copies carry the version that wrote them; updating the payload
changes no project until its owner converges; diagnose detects the gap. In this
repo's own estate every stamped artifact — guide, cheatsheet, `surface-corpus`,
`audit-check`, `source-graph`, hook, and all vendored skill files — reads
`11.0.0`, matching the front-door manifest, and the planner's diagnose exits 0.
Honored.

## Determination

**satisfied.** Everything project-scoped the three cores deliver arrives as a
committed, version-stamped file materialized from the carried payload —
eighteen write targets re-enumerated from the cores themselves this cycle,
including `.ok-planner/bin/source-graph`, which is materialized and stamped by
the same shape as its sibling support script and is named in the family's
administration document as part of the materialized set. The harness is
pointed project-side in all three families; the one session-start entry the suite
declares into a project carries the exact `startup|clear|compact` matcher and is
written only by the consent-transcription mode; the marketplace distributes only
the two user-scoped plugins; and a converged project runs its verbs from its own
copies, exhibited by the plumbline family's clone case rather than inferred.

Recorded, and not the basis of this determination: the module marker in the
plumbline estate (`.ok-plumbline/package.json`) is a project-scoped, suite-owned
file that carries no version stamp — JSON has no comment channel. It is
version-invariant layout rather than behaviour, and the corpus rules the
fixed-content exception explicitly into `concept:materialized-artifact` and into
two decisions, so the boundary case is sanctioned rather than merely tolerated.
(Whether the exception's *promised* substitute — verification by exact content —
is delivered is a separate claim, charged under `decision:per-project-pinning`.
This cycle's fix supplied it: the marker's canonical bytes are a single constant
and diagnose compares the file to it byte for byte at fail level, so that audit
now finds it satisfied. Nothing in this decision's Choice claims it either way.)

This stops holding if: a core gains a write target that is not materialized into
the project, or one that is materialized without a stamp and is not fixed content
(the whole-file pins on all three cores break on any core edit); any vendored
verb reintroduces an unconditional payload path or drops its project-first branch
or its fallback announcement; the marketplace begins distributing a family as its
own plugin (the catalog pin breaks); a family starts shipping plugin-root hooks;
or the session-start matcher widens to admit `resume`.

## Notes

- note: admin/converge and admin/ADMINISTRATION.md (source-graph-certification sprint) add materialization of a new vendored support script, `bin/source-graph` (stamped, chmod 755, fallback-to-payload pattern mirroring `bin/audit-check`) — squarely "support scripts" in this decision's Choice clause ("skill files, hook implementations, support scripts, context payloads, cheatsheets"). The added block sits outside the cited `SKILLS = {` / `ENTRY = {` spans (those govern `.claude/skills/` vendoring specifically), so citation staleness did not trip even though the population of materialized project-scoped artifacts gained a member.
  adjudication: promoted — the nomination is correct on the substance: `bin/source-graph` is a support script, it is inside clause 1's enumerated kinds, and it was invisible to every citation this audit carried. Citations now carried: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4` over the new materialize block, `cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""` for the stamp the clause requires, `cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (\`scripts/surface-corpus\`, \`bin/audit-check\`,"` for the administration document's materializes list, and `cite-file:` whole-file pins on all three converge cores as the population source for clause 1's quantifier — so the next materialized artifact added to any core trips staleness mechanically. One correction to the note's wording, recorded so a later reader does not inherit it: the new script has **no** fallback-to-payload pattern. The certify gates name `.ok-planner/bin/source-graph` and no payload path, which is stricter than `bin/audit-check`'s handling, not a mirror of it.

## Citations

- cite-node: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: ".ok-planner/bin/source-graph build"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (`scripts/surface-corpus`, `bin/audit-check`,"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "ENTRY = {" +11 sha256:b3f47f9be607
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6 sha256:c060ac5bd063
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "function vendoredSkills(pluginRoot, root, version) {" +9 sha256:de99e49b9cd7
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +12 sha256:404c640aa813
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function vendorSkillsCmd(target) {" +14 sha256:e9c8a483dfde
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "bin=".ok-plumbline/bin/plumbline""
- cite-node: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md @ sha256:f11cec8e1871
- cite-node: plugins/ok/families/ok-plumbline/skills/port/SKILL.md @ sha256:c083b85d12c6
- cite-node: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 1: bootstrap from nothing" +28 sha256:1ad7f894fe98
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: docs/integration-contract.md :: "Exactly two classes legitimately run from the carried" +4 sha256:a56e29528f94
- cite-span: checks/vendored-layer :: "hooks_dir = os.path.join(FAMILIES_DIR, family, " +6 sha256:44c1fa8fc506
