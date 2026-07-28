---
audit: vendored-skills
artifact: decision:vendored-skills
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:042d89fc84f6
---

# Does everything project-scoped reach a consumer as committed, version-stamped vendored files with the harness pointed at them project-side — and does a cloned converged project actually yield working skills with nothing installed?

## Claims

**Choice clause 1 — "Everything project-scoped the suite delivers — skill files,
hook implementations, support scripts, context payloads, cheatsheets — reaches a
consumer project as committed, version-stamped files materialized from the
front-door plugin's carried family payload by its administration."** The
population is every file the three families' converge cores write into a
consumer, enumerated by reading each core. ok-planner writes the estate guide,
the cheatsheet, the session-start hook, two support scripts, and the skill set —
each rendered from a payload template with the suite version substituted or
appended. ok-plumbline writes the cheatsheet, the estate's module marker, the
vendored binary (its version constant rewritten), the edit hook, and the skill
set. ok-workspaces writes the src-tag script, the port-block allocator when the
profile declares that runtime, the cheatsheet, the worktree ignore files, and the
skill set — all through a single stamping helper. Retired payloads from earlier
versions are removed by the same cores, so nothing project-scoped reaches a
consumer outside this path. Honored, with one boundary case carried forward and
recorded in the Determination: the module marker is materialized and suite-owned
but, being JSON, carries no version stamp; diagnose checks its exact content
instead.

**Choice clause 2 — "the harness is pointed at them project-side: skills live in
the project's committed skills directory under the contract's collision rule."**
All three cores render into the project's `.claude/skills/`, each mapping its
source verbs to materialized names with the `audit` verb family-prefixed because
more than one family claims it, and rewriting sibling slash-command references
to the materialized names with a hyphen guard so support-script paths survive.
Verified against a real converge this cycle: a fresh repository came back with
ten plumbline skill directories under `.claude/skills/`, the `audit` verb landing
as `ok-plumbline-audit`. Honored.

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
absent from the matcher, so the entry cannot fire on resume. (The conduct
plugin's machine-global session-start entry carries the same matcher, but it is
user-scoped and outside this clause's subject.) Honored.

**Choice clause 4 — "The plugin system delivers only the user-scoped plugins —
the front door carrying the families, and the conduct."** The marketplace catalog
is pinned below and lists exactly two entries: the conduct and the front door.
The families sit inside the front door's payload and carry no manifests. Honored.

**Choice clause 5 — "A converged project is self-contained for running the
suite: cloning it yields the working skills with nothing installed; converging
needs only the front door."** This is the clause the previous cycle found
violated, and the one this cycle's fix targets. I re-derived it from reality
rather than from the fix's description.

The population is the vendored verb set of the three families, enumerated from
each core's own vendoring map: ten planner verbs plus the shared blocks, four
workspaces verbs, ten plumbline verbs — twenty-four. Neither the planner's nor
the workspaces' vendored skills reference the payload at all: a grep for
`CLAUDE_PLUGIN_ROOT` and for a payload path over both families' source skills
and over a materialized planner skill set returns nothing (the only hits
anywhere under a materialized `.claude/skills/` in this repo are in this
project's own local `/release` maintenance skill, which is not a family verb and
is not vendored by any core).

For the ten plumbline verbs I ran the exhibit rather than reading the branches.
I converged a fresh git repository with the plumbline core, committed the
result, **cloned it**, and from the clone ran each verb's own extracted `Run`
block with `CLAUDE_PLUGIN_ROOT` unset and the working directory inside the
clone — the exact condition under which the previous cycle's `starter` and
`port` died with "module not found". All ten now run against the project's own
`.ok-plumbline/bin/plumbline`: `version`, `starter`, `port`, `patterns`, `slug`,
`suggest`, `ok-plumbline-audit` and `ci` exit 0 with real output, and `budget`
without a saved baseline exits 1 on its own "no baseline" message rather than on
a missing module. Not one of them printed its payload-fallback announcement,
which is the positive evidence that the project copy — not the payload — is what
executed. The clone's binary retained its executable mode through the clone, and
the estate's module marker came through with it.

Two residues, neither of which defeats the clause. `port` still resolves the
*porting guide document* under the payload path, but only to compose a reference
line in the printed plan, and when the payload is absent it substitutes a prose
reference instead of a dangling path — the verb runs and the plan is complete.
`version` still names the payload binary, but that is the verb's subject rather
than a dependency: with nothing installed it prints `carried payload: none — the
ok front door is not installed on this machine` and still reports the project's
pinned number. Both are read-only advisory behaviour with the fallback announced
in the output, which is exactly the carve-out the corpus's integration contract
sanctions. Honored.

**Rationale — "one installed copy serves every project, updating or editing it
changes all of them at once, and no project has a version of its own …
Committing the behavioral surface to the project makes the version a property of
the repo."** Now follows for the whole vendored surface rather than for most of
it. Each project's copies carry the version that wrote them; updating the payload
changes no project until its owner converges; diagnose detects the gap. The three
verbs that previously executed whatever payload version happened to be on the
machine now execute the repo's copy first, so for them too the version in play is
a property of the repo. Honored.

**Rationale — "the machine-shared layer shrinks to the two things that are
genuinely personal: the administrator and the conduct."** Confirmed by the
marketplace pin and by the maintenance check, which additionally asserts that no
family ships family-root hooks and that the front door ships none either.
Honored.

## Determination

**satisfied.** The previous cycle's violation is closed, and closed at the level
the decision claims rather than at the level of the diff. `starter` and `port`
now resolve the project's vendored binary first and fall back to the carried
payload only with an announcement on stderr; `version` reports the payload as
`none` instead of failing when nothing is installed. I confirmed this from a
clone of a converged repository with `CLAUDE_PLUGIN_ROOT` unset: all ten
plumbline verbs run against the project's own binary, none of them reaches for
the payload, and none of them fails for want of an installed plugin. The planner
and workspaces verbs never referenced the payload. Clauses 1–4 continue to hold,
verified against a live converge.

Two things are recorded but are not the basis of this determination:

- The module marker in the plumbline estate (`.ok-plumbline/package.json`) is a
  project-scoped, suite-owned file that carries no version stamp — JSON has no
  comment channel. It is version-invariant layout rather than behaviour, and
  diagnose checks its exact content, so the staleness detection the stamp exists
  to serve is delivered by another mechanism. Worth the owner's attention only if
  the corpus should say so explicitly.
- ok-workspaces' cores materialize the worktree ignore files, which are outside
  the clause-1 enumeration of kinds but *are* stamped, so the predicate holds
  universally.

This stops holding if: any vendored verb reintroduces an unconditional payload
path, or drops its project-first branch or its fallback announcement (the
whole-file pins on the three changed verb files break on any edit to them); a
core gains a write target that is not materialized into the project; the
marketplace begins distributing a family as its own plugin (the catalog pin
breaks); a family starts shipping plugin-root hooks; or the session-start
matcher widens to admit `resume`.

## Citations

- cite-file: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "ENTRY = {" +11 sha256:b3f47f9be607
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "const SKILLS = {" +6 sha256:c060ac5bd063
- cite-span: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "function vendoredSkills(pluginRoot, root, version) {" +9 sha256:de99e49b9cd7
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +12 sha256:404c640aa813
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "bin=".ok-plumbline/bin/plumbline""
- cite-span: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "bin=".ok-plumbline/bin/plumbline"" +9 sha256:9b6c85eb67fa
- cite-file: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md @ sha256:f11cec8e1871
- cite-span: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "plumbline_bin="$abs_target/.ok-plumbline/bin/plumbline"" +5 sha256:a75bec103b67
- cite-span: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "guide_path="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/docs/plumbline-porting-guide.md"" +6 sha256:18a12ad49c4c
- cite-file: plugins/ok/families/ok-plumbline/skills/port/SKILL.md @ sha256:c083b85d12c6
- cite-span: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "## Run" +14 sha256:addcfd9378bc
- cite-file: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "printf '{ "type": "commonjs" }\n' > .ok-plumbline/package.json"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
- cite-span: docs/integration-contract.md :: "Exactly two classes legitimately run from the carried" +4 sha256:a56e29528f94
- cite-span: checks/vendored-layer :: "hooks_dir = os.path.join(FAMILIES_DIR, family, " +6 sha256:44c1fa8fc506
