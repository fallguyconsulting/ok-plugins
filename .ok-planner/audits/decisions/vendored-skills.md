---
audit: vendored-skills
artifact: decision:vendored-skills
determination: satisfied
audited: 2026-07-28T22:51:36Z
artifact-hash: sha256:042d89fc84f6
---

# Does everything project-scoped reach a consumer as committed, version-stamped vendored files with the harness pointed at them project-side — and does a cloned converged project actually yield working skills with nothing installed?

Refreshed. The design artifact's hash is unchanged. The one stale citation
is the whole-file node pin on `corpus-view`, moved by the Release v11.2.0
commit's addition of `inspection_now()` and the `/api/inspection` route.
Read directly against C5's exhibition (payload resolution and bundle
search in a fresh clone): the new method is a registry/graph read added
beside `corpus_now()`, and touches neither `payload_dir()`,
`find_bundle()`, nor the tooling loader this audit's clone re-exhibition
rests on — all three are byte-identical to what this audit last read
(confirmed by diff). The exhibition therefore still stands without
re-running it. Citation regenerated; nothing else touched.

## Claims

**Why this is a rewrite, not a refresh.** The design artifact's hash is
unchanged (`sha256:042d89fc84f6`), so prior determinations would ordinarily
bind. They do not on clauses 1 and 5, because the changed bytes are exactly
what those clauses' previous verdict rested on: the corpus view's payload
resolution and bundle search were both rewritten, the whole `corpus-view` node
moved, and the planner's converge core moved. The clone exhibition that carried
the previous violation was re-run from scratch rather than reasoned about. The
previous cycle's adjudicated note on the planner core's added support script is
carried forward verbatim below, unaffected.

**Choice clause 1 (quantified) — "Everything project-scoped the suite delivers
— skill files, hook implementations, support scripts, context payloads,
cheatsheets — reaches a consumer project as committed, version-stamped files
materialized from the front-door plugin's carried family payload by its
administration."** The population is every file the three families' converge
cores write into a consumer, re-enumerated by reading each core (all three
pinned whole below). Twenty-two write targets: ok-planner eleven (the estate
guide, the cheatsheet, the session-start hook, four support scripts under
`bin/` plus `scripts/surface-corpus`, the estate's own `.gitignore`, the
eleven-verb skill set, and the placed frontend build), ok-plumbline five (the
cheatsheet, the module marker, the vendored binary, the edit hook, the
nine-verb skill set), ok-workspaces six (`src-tag`, `port-block`, the
cheatsheet, the two worktree ignore files, the skill set). Retired payloads are
still removed by the same cores, so nothing project-scoped reaches a consumer
outside this path.

Twenty-one of the twenty-two are committed and version-stamped, or (the module
marker alone) verified by true exact-content comparison. **The twenty-second,
`.ok-planner/browser/`, is version-stamped as of this cycle** — a `.build-stamp`
sidecar carrying the ordinary `Materialized by ok-planner v…` line plus a digest
over every placed byte, with converge's diagnose distinguishing missing,
unstamped, wrong-version and drifted (verified in detail under the companion
audit for `decision:per-project-pinning`). **It is not committed**, and that is
deliberate: the estate's own ignore file, which the same converge writes, keeps
it out of the repository.

Whether that member is inside this clause's population is a question of scope,
and the corpus answers it. `concept:estate` — current-state, and amended this
cycle — separates the estate's committed content from "the machine-local
content a family's own ignore file excludes from the repository (a build its
administration placed, a measurement one of its runs left), which is nobody's
source of truth and is never read as project content."
`concept:materialized-artifact` defines its subject as a project-side copy of a
family-canonical *file* — "a skill file, support script, hook implementation,
lint binary, cheatsheet, or context payload" — and a generated frontend bundle
is none of those six, just as it is none of this clause's own five named kinds.
And `decision:built-bundle-fetched-at-pin`, live and separately audited, decides
in terms for this artifact that it is placed "inside the planner's estate and
ignored by git rather than committed." Read together, the placed build is
machine-local estate content rather than vendored content, and this clause's
population is the twenty-one members that remain — every one of them committed
and stamped. **Honored,** with the scoping stated plainly under Determination
because it is the reasoning that carries it.

**Choice clause 2 — "the harness is pointed at them project-side: skills live
in the project's committed skills directory under the contract's collision
rule."** Re-verified against a live converge on a scratch repository: the core
renders eleven `.claude/skills/` entries plus the `_shared/` transclusion
sources, `browse` unprefixed (the collision rule reserves the prefix for
`audit`, the only verb more than one family claims), and all of them arrive in
a clone of that repository. The administration harness's bare-bootstrap
threshold still passes at eleven, and the renderer still does not corrupt
`bin/audit-check` into `ok-planner-audit-check`. **Honored.**

**Choice clause 3 (quantified) — "hooks are declared in the project's committed
harness settings by consented transcription…"** Unchanged population
(ok-planner's single session-start entry; ok-plumbline's PostToolUse entry;
ok-workspaces declares none), unchanged matcher, unchanged consent gate — the
scratch converge printed the wiring block and wrote nothing. **Honored.**

**Choice clause 4 — "The plugin system delivers only the user-scoped
plugins…"** The marketplace catalog is unchanged (two entries: conduct and
front door), and `checks/vendored-layer` (re-run on this tree, exits 0) still
asserts no family or the front door ships plugin-root hooks. **Honored.**

**Choice clause 5 — "A converged project is self-contained for running the
suite: cloning it yields the working skills with nothing installed; converging
needs only the front door."** This is the clause the previous cycle refuted, on
a defect that is now gone.

**Re-exhibited from scratch.** I converged a bare scratch repository under
`/tmp`, committed it, and cloned that commit into a fresh directory. The clone
carries every vendored skill file (eleven planner entries plus `_shared/`), the
cheatsheet, the session-start hook, and all four project-side scripts under
`.ok-planner/`; it does not carry `.ok-planner/browser/`, by the estate ignore
file. I then ran the vendored `corpus-view` in that clone twice.

With `CLAUDE_PLUGIN_ROOT` unset — nothing installed, the clause's own
condition — the service started, announced "running v11.1.2, the version this
project is pinned to", resolved citations through the clone's *own*
`bin/audit-check` and `bin/source-graph`, served every data route, and said in
one line that no frontend build was found in either the estate or a carried
payload and that the page therefore does not render. With `CLAUDE_PLUGIN_ROOT`
pointed at an installed front door, it announced the payload fallback in the
suite's standard wording and served the page — a real HTTP `GET /` returned the
built document.

**That second result is the defect being discharged.** The previous cycle's
finding was not that a clone lacks the build; it was that the vendored copy
could not reach a payload *at all*, because the payload directory was derived
from the running script's own location, which from `.ok-planner/bin/` resolves
to a path that can never exist. The advisory fallback the whole suite relies on
was dead code for this verb. It is now live: the family directory is derived
from `__file__` only when that genuinely lands in one (tested by the presence
of `skills/` and `admin/`), otherwise through `CLAUDE_PLUGIN_ROOT`, otherwise
`None`. So the payload copy resolves its own family as before, and the vendored
copy reaches an installed front door the same way the other ten advisory
fallbacks in the suite do.

**What remains — a clone with nothing installed has no page — is not this
clause's territory.** The build is machine-local estate content by
`concept:estate`, and `decision:built-bundle-fetched-at-pin` decides that it is
placed by administration and ignored by git; clause 5's own second half —
"converging needs only the front door" — is the route back to it, and the verb
says so in the same breath. The previous cycle's own plumbline clone case
(re-cited below, hash unchanged) still stands for the rest of the verb
population, and the family harness still passes on this tree. **Honored.**

**Rationale — "one installed copy serves every project … Committing the
behavioral surface to the project makes the version a property of the repo."**
Re-verified for the twenty-one committed members: each carries the version that
wrote it, updating the payload changes no project until its owner converges, and
diagnose detects the gap. For the placed build the version is still a property
of the repo, one step removed: converge places the build the payload that
stamped the estate carried, so the committed stamp determines which build a
convergence may place, and diagnose now says when the two have parted. In this
repository's own estate every stamped artifact reads `11.1.2`, matching the
front-door manifest. **Honored.**

## Determination

**satisfied.** The previous cycle's determination rested on two counts, and
both are discharged.

The first was that `.ok-planner/browser/` reached consumers neither stamped nor
under the sanctioned fixed-content exception. It is now stamped — a
`.build-stamp` sidecar with the suite's ordinary materialization line and a
digest over every placed byte, with a four-way diagnose check behind it
(exhibited in the companion audit).

The second, and the load-bearing one, was that `/browse` was dead in a fresh
clone in a way no fallback could rescue: the vendored copy's payload-relative
bundle search resolved through its own location and therefore hunted in a
directory the materialization layout can never produce, so the announced
advisory fallback the suite's whole pinning design depends on did not exist for
this verb even when the front door *was* installed. I reproduced the original
exhibition — converge, commit, clone, run — and the fallback now fires: with a
front door reachable the clone serves the real page, with nothing reachable it
serves every data route and states plainly why the page is absent.

**The reasoning that carries this, stated openly.** One fact from the previous
cycle is unchanged: a clone with literally nothing installed still has no page,
because the estate's ignore file keeps the build out of the repository. I read
that as outside clause 5 rather than as a breach of it, and the reading is the
corpus's own, not a convenience: `concept:estate` names machine-local,
ignore-file-excluded content — "a build its administration placed" — as a
content kind of its own, distinct from what the project commits;
`concept:materialized-artifact` enumerates six file kinds and a generated
bundle is none of them; and `decision:built-bundle-fetched-at-pin` decides in
terms that this artifact is ignored rather than committed. All three are pinned
below, so if any of them moves this reading is re-opened mechanically. What a
clone yields is the vendored surface the contract's item 3 names — the skill
files, hooks, support scripts and cheatsheet — and it yields all of it.

If the owner reads clause 1's "everything project-scoped the suite delivers …
as committed" as unqualified over generated content too, then the corpus holds
two live artifacts that cannot both be true, and the remedy is a narrowing of
this Choice's wording — an intent change only a sprint may make, and a
cross-artifact consistency question for the corpus-hygiene gate rather than an
implementation defect. Nothing in the code is what would need fixing: the
project implements the corpus's decided intent on every member.

Recorded, and still not the basis of this determination: the plumbline module
marker remains a project-scoped, suite-owned, unstamped file, and remains the
Choice's one sanctioned fixed-content exception, its exact-content check
re-verified by the companion audit.

**What would have to change for this to stop holding.** The vendored copy's
payload resolution reverting to a location-derived path, or dropping the
`CLAUDE_PLUGIN_ROOT` route, so the advisory fallback goes dead again; the
bundle search losing its estate-first ordering; the estate ignore file, the
estate concept's machine-local carve-out, the materialized-artifact concept's
kind list, or `decision:built-bundle-fetched-at-pin` changing, any of which
re-opens the scoping this determination rests on; a converge core gaining a
project-scoped write target that is neither committed-and-stamped nor covered
by that carve-out (the three cores are pinned whole, so that trips
mechanically); the collision rule or the vendoring map changing such that a
clone no longer carries every verb; a family or the front door shipping
plugin-root hooks; or the marketplace catalog growing an entry that is not the
front door or the conduct.

## Notes

- note: admin/converge and admin/ADMINISTRATION.md (source-graph-certification sprint) add materialization of a new vendored support script, `bin/source-graph` (stamped, chmod 755, fallback-to-payload pattern mirroring `bin/audit-check`) — squarely "support scripts" in this decision's Choice clause ("skill files, hook implementations, support scripts, context payloads, cheatsheets"). The added block sits outside the cited `SKILLS = {` / `ENTRY = {` spans (those govern `.claude/skills/` vendoring specifically), so citation staleness did not trip even though the population of materialized project-scoped artifacts gained a member.
  adjudication: promoted — the nomination is correct on the substance: `bin/source-graph` is a support script, it is inside clause 1's enumerated kinds, and it was invisible to every citation this audit carried. Citations now carried: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4` over the new materialize block, `cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""` for the stamp the clause requires, `cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (\`scripts/surface-corpus\`, \`bin/audit-check\`,"` for the administration document's materializes list, and `cite-file:` whole-file pins on all three converge cores as the population source for clause 1's quantifier — so the next materialized artifact added to any core trips staleness mechanically. One correction to the note's wording, recorded so a later reader does not inherit it: the new script has **no** fallback-to-payload pattern. The certify gates name `.ok-planner/bin/source-graph` and no payload path, which is stricter than `bin/audit-check`'s handling, not a mirror of it.

## Citations

- cite-node: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: ".ok-planner/bin/source-graph build"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "helper scripts (`scripts/surface-corpus`, `bin/audit-check`,"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:8aa7cd5969fb
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "ENTRY = {" +11 sha256:b3f47f9be607
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6 sha256:c060ac5bd063
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "function vendoredSkills(pluginRoot, root, version) {" +9 sha256:de99e49b9cd7
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +12 sha256:0adcba870cfa
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function vendorSkillsCmd(target) {" +14 sha256:e3cdc45c479e
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "bin=".ok-plumbline/bin/plumbline""
- cite-node: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md @ sha256:f11cec8e1871
- cite-node: plugins/ok/families/ok-plumbline/skills/port/SKILL.md @ sha256:c083b85d12c6
- cite-node: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 1: bootstrap from nothing" +28 sha256:d8158f669cf6
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: docs/integration-contract.md :: "Exactly two classes legitimately run from the carried" +4 sha256:a56e29528f94
- cite-span: checks/vendored-layer :: "hooks_dir = os.path.join(FAMILIES_DIR, family, " +6 sha256:44c1fa8fc506
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def payload_dir():" +22 sha256:673ca59935a9
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def looks_like_family(d):" +5 sha256:0944ec6a3571
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "root = os.environ.get("CLAUDE_PLUGIN_ROOT")"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def find_bundle(root, override):" +10 sha256:9851185cbd73
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "out.append("note: no build in this project's estate — serving the ""
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "out.append("note: no frontend build found — neither this project's ""
- cite-span: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "bin=".ok-planner/bin/corpus-view"" +7 sha256:b5438fff43c8
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "to the front door's carried build and says so, the same announced fallback"
- cite-file: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:6e2b32d8b092
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "browser/"
- cite-file: .ok-planner/design/concepts/estate.md @ sha256:afc2da6d39e9
- cite: .ok-planner/design/concepts/estate.md :: "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)"
- cite-file: .ok-planner/design/concepts/materialized-artifact.md @ sha256:21cfe38a4de1
- cite-file: .ok-planner/design/decisions/built-bundle-fetched-at-pin.md @ sha256:8882717e6d56
- cite: .claude/skills/release/SKILL.md :: "The corpus view's page is a **release artifact**. It is built exactly"
