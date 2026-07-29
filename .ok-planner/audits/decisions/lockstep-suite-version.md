---
audit: lockstep-suite-version
artifact: decision:lockstep-suite-version
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:c26653630fb0
---

# Does every plugin manifest carry one suite version per release, cut as one annotated repo-wide tag by a mechanical release act, with the family payload stamped from it and the conduct version carved out?

Amended a third time, this pass by a refresh dispatch. The design artifact
is unchanged (hash identical to last cycle). Staleness is again the
whole-file pin on the *ok-planner* converge core, and again it is squarely
clause 4's territory, so it is re-checked rather than waved through: the
core gained a fourth stamped site since the last amendment,
`browser_stamp()`, which writes `.build-stamp` beside the placed corpus-view
build with a first line of the same `Materialized by ok-planner v<semver>.
…` shape the estate guide and every vendored skill already carry (`STAMP_MASK`,
already in this decision's population). It is one more instance of a shape
already enumerated, not a new shape — read directly at its `print(...)`
call rather than inferred from the function's name — so clause 4's
population count and Determination are unchanged; only the citation is
regenerated. Every other clause stands on the prior amendment's evidence.

Amended, not rewritten (second re-audit in a row). The design artifact is
unchanged (hash identical to last cycle). This cycle's staleness is again the
whole-file pin on the *ok-planner* converge core, which gained real new
substitution sites: the corpus-view feature added `PROOF_TIMINGS` and
`CORPUS_VIEW` as materialized scripts stamped by the identical
`sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g"` shape already used for
`source-graph`, plus `ESTATE_GITIGNORE` stamped the same way, and the core
now also places the corpus view's pre-built frontend
(`.ok-planner/browser/`, copied verbatim rather than sed-stamped). This is
squarely clause 4's territory — new payload materialization — not a
tangential edit, so it is re-verified below rather than merely re-pinned.
Every other clause is unchanged from the prior audit and stands on that
audit's evidence; only clause 4's population and its citation were touched.

**Title + Choice clause 1 (quantified) — "Every plugin manifest carries the same
semantic version at every release."** The population is the set of plugin
manifests, enumerated from reality rather than from the decision's wording: the
marketplace manifest (pinned below) lists exactly two plugin sources,
`./plugins/ok-conduct` and `./plugins/ok`, and `plugins/*/.claude-plugin/plugin.json`
yields exactly those two files — both pinned below, both reading
`"version": "11.0.0"`. A tree-wide search for `.claude-plugin/plugin.json`
returns those two plus the two the audit checker's masking fixtures carry, which
are fixtures and not plugins; the three carried families still add no members.
The release skill states the same count in its own words ("exactly two
manifests: `ok` and `ok-conduct` — the families carry none") and directs the
bump into *every* manifest, explicitly including one with no changes in the
release. Equality is asserted mechanically before any commit or tag: the
verbatim, do-not-skip block carrying this decision's `@decision:` annotation
loops the same glob, prints `MIXED VERSION`, and exits non-zero on any
disagreement. Honored.

**Choice clause 2 — "bumped together at the highest level any change in the
suite warrants."** The bump table classifies major / minor / patch by what the
change does to the suite's surface, and the governing sentence is explicit that
the highest level across all plugins wins, with genuine ambiguity resolved
upward and said out loud. The survey step attributes changes per plugin *and per
family*, declaring a change under the front door's payload a suite change like
any other. Honored.

**Choice clause 3 — "with one annotated repo-wide tag per release cut by the
repo-local release skill."** The tag step is annotated (`git tag -a`), taken on
the commit that is the tip of the default branch, and immediately followed by the
prohibition on per-plugin tags with its stated reason. "Repo-local" holds of the
skill itself: it lives at the repo-root `.claude/skills/release/`, outside every
plugin, and its own body says that is why and forbids copying it into a plugin
directory. Honored.

**Choice clause 4 (quantified) — "the carried family payload is stamped with
that same suite version wherever it materializes."** Re-enumerated this cycle
across the whole population under `plugins/ok/families/` — all three carried
families, every version-substitution site in each converge core, with all three
cores pinned whole below as the enumeration source.

ok-planner's core resolves `SUITE_MANIFEST` three levels up to the front-door
manifest and reads `SUITE_VERSION` out of it, substituting it into the estate
guide, the cheatsheet, `surface-corpus`, `audit-check`, `source-graph`
(whose payload source carries the `{{OK_PLANNER_VERSION}}` placeholder and whose
materialize block is the same `sed`-and-`chmod` shape as `audit-check`'s), the
session-start hook, and the trailing stamp of every vendored skill. This
cycle adds three more sites of the identical shape, read directly in their
payload sources rather than assumed to match: **`proof-timings`** and
**`corpus-view`** each declare `VERSION = "{{OK_PLANNER_VERSION}}"` — the
same literal pattern `source-graph` and `audit-check` already carry, matched
by the checker's existing `VERSION_STAMP_MASK` — and the core's new
materialize block for each is the same `sed .../ chmod` shape at
`PROOF_TIMINGS`/`CORPUS_VIEW`. **`ok-planner-gitignore`** carries the other
existing shape, `# Materialized by ok-planner v{{OK_PLANNER_VERSION}}.`, the
same `STAMP_MASK` pattern the estate guide and every vendored skill already
use, stamped by its own new `sed` block at `ESTATE_GITIGNORE`. The one
non-sed addition — the corpus view's built frontend, placed at
`.ok-planner/browser/` by a verbatim `cp -R` from the release-built
`browser/dist/` — carries no version string of its own to stamp; the running
page instead reads its version from the corpus-view backend it talks to
(`server_version = "corpus-view/" + VERSION`), so the payload that answers
"what version is this" is the already-stamped backend script, not the
static build. No family reads any other version source and none has a
manifest of its own to read. ok-plumbline's core resolves the identical path
the same way and stamps the cheatsheet, the vendored binary (replacing its
`0.0.0-unvendored` placeholder), and the post-edit hook — three substitution
sites, unchanged in count this cycle. ok-workspaces' `converge.js` reads
`'..', '..', '.claude-plugin', 'plugin.json'` and stamps src-tag, the port
allocator, the worktree ignore header, the cheatsheet, and its vendored skills.

This checkout does not corroborate the three new sites directly: this
project's vendored layer deliberately lags mid-cycle (`.ok-planner/bin/`,
`.ok-planner/browser/`, and `.ok-planner/proof-timings.json` are absent here
by design, per `checks/vendored-layer`), so there is no materialized
`proof-timings`/`corpus-view`/`.gitignore` in this checkout to read a live
stamp from. The claim rests instead on the payload sources read directly
(above) and on the pre-existing, unmoved corroboration for the sites that
were already stamped last cycle: the estate guide, cheatsheet,
`surface-corpus`, `audit-check`'s `VERSION`, `source-graph`'s `VERSION`, the
session-start hook, and every vendored planner skill file all still read
`11.0.0`, matching the manifests exactly, and the administration harness
still independently asserts the estate guide's stamp equals the version read
straight from the front-door manifest. Honored, with the new sites' evidence
being payload-source shape-matching rather than a live materialized read.

Carried forward and re-examined against the changed mechanism, not charged:
`.ok-plumbline/package.json`, a fixed `{ "type": "commonjs" }` module marker,
carries no version at all. Read as "every materialized file bears a stamp", that
would be an unstamped member. That reading is not the one this clause makes —
its subject is "the carried family payload", and the marker is a literal the
payload generates, with no version to carry and no second version source
introduced. This cycle strengthens rather than weakens the ground for not
charging it: the literal is now a single named constant (`MODULE_MARKER`) the
core reaches through an emit-only subcommand, so there is exactly one place the
bytes are written and demonstrably no version interpolation in it. The corpus
rules the fixed-content exception explicitly into
`concept:materialized-artifact`, so the ground is the corpus's rather than this
auditor's. If the Choice were tightened to "every materialized artifact carries
the suite-version stamp", this member would flip the determination.

**Choice clause 5 — "The release act itself is mechanical … verifies itself with
deterministic assertions alone … and neither runs nor re-derives implementation
audits; the sole judgment a release holds is the semver level."** Honored clause
by clause against the procedure as it stands. The skill carries a dedicated,
`@decision:`-annotated section stating exactly this, and the steps match it: the
only edits the act authors are step 5's manifest `version` fields ("Touch no
other field") and step 5c's delegated re-converge, described as "a deterministic
re-stamp, nothing more"; step 6's `git add -A` records the pre-existing tree
rather than authoring content; step 8 tags. Verification is manifest equality,
three remote queries that must agree, and the preflight — all deterministic; no
step invokes `audit-check`, dispatches an agent, or touches `.ok-planner/audits/`.

The supporting claim the skill leans on — that the vendored checker masks
release-mutable metadata so "no implementation audit goes stale" — was
re-checked against the new member rather than carried: `audit-check`'s
`VERSION_STAMP_MASK` matches a bare `VERSION = "<semver>"` assignment, which is
exactly the form `source-graph` carries, so a version-only release moves that
file's masked hash not at all. The new materialized artifact adds nothing for a
release to void. Honored.

**Choice clause 6 — "A release is done only when the release commit is reachable
from the remote default branch and the tag points at it."** The finish-line
sentence states exactly that. The landing step precedes tagging, the default
branch is derived from the remote via `git ls-remote --symref` rather than
assumed, and the closing verification queries `origin` for the tag, the branch
head, and containment, with the instruction never to report a release done
without it. Honored.

**Choice clause 7 — "Between releases manifests may drift while work is in
flight; the release converges them."** The read-current-version step anticipates
differing manifests, takes the highest as the current suite version, requires
saying so in the report, and forbids picking a lower one because lowering
strands existing installs. Honored.

**Choice clause 8 — "The conduct's version is the one carve-out: hand-managed
and untouched by a release."** The carve-out is the conduct document's own body
stamp — `Conduct version: 1.11.0 (Koala)` — not the conduct *plugin manifest*,
which is one of the two bumped in lockstep and currently at 11.0.0 like its
sibling. The release skill only warns when the conduct body changed without a
bump, and states that it bumps plugin `version` fields only. The conduct stamp
is unchanged at 1.11.0 across the 10.0.0 → 11.0.0 suite bump — the carve-out
exhibited rather than asserted. Honored.

**Rationale — "A shared number is what makes 'which versions work together'
answerable"; "Correctness is established where it belongs, at certification."**
The first follows from clauses 1 and 4: two manifests at one number, every
project-side stamp in every family derived from one of them. The second is
honored as a description of the procedure: the mechanical-release section opens
with the same premise and the procedure carries no gate, reviewer, or auditor.

**Alternatives — independent semver, rejecting drift, per-plugin tags, a
re-auditing release gate.** All four are genuine roads not taken; the third and
fourth are explicitly negated in the procedure.

## Determination

**satisfied.** Both manifests in the enumerated population carry 11.0.0, and no
third manifest exists anywhere in the tree outside the checker's masking
fixtures. The release procedure writes one version into every manifest, asserts
equality with a verbatim guard that blocks tagging a mixed set, cuts one
annotated repo-wide tag while forbidding per-plugin tags, converges mid-cycle
drift upward, and verifies remote reachability as the finish line. All three
families derive their stamps from the front-door manifest and from nothing else,
so the payload is stamped with the suite version wherever it materializes —
`source-graph`, and now `proof-timings` and `corpus-view` alongside it, take
their stamp from the same `SUITE_VERSION` substitution, and `ok-planner-gitignore`
takes the sibling `STAMP_MASK` shape already used estate-wide; the plumbline
core's three substitution sites are untouched by this cycle's edit. The
mechanical clause holds for the right reason: the act edits only manifest
versions and delegated stamps, dispatches no agent, runs no audit, and every
new payload site's stamp shape — `VERSION = "..."` or `Materialized by ... v...`
— falls inside the checker's existing masks, so a version-only release still
voids nothing there either. The conduct's hand-managed document version
stayed at 1.11.0 through the suite bump.

This stops holding if: a third plugin appears in the marketplace manifest with a
version that does not track the other two, or either manifest's version moves
alone (all three pins break); the equality-assertion block is deleted, weakened,
or moved out of its pre-commit position; the mechanical-release section is
deleted or an audit/review/gate step is added; a family gains a manifest of its
own or reads a version from anywhere but the front-door manifest (the whole-file
pins on all three converge cores break); a materialized artifact appears whose
stamp is not derived from `SUITE_VERSION`; per-plugin tags are introduced; the
release skill is copied into a plugin directory; the administration harness stops
asserting stamp-equals-manifest; or the remote-reachability verification stops
being the finish line. It would also re-open if the checker's masking regressed,
and it would flip to violated if clause 4 were reworded to require a
suite-version stamp on every materialized artifact, since
`.ok-plumbline/package.json` carries none.

## Citations

- cite-node: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-node: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-node: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite: plugins/ok/families/ok-planner/admin/converge :: "print("Materialized by ok-planner v%s. Suite-owned: overwritten wholesale by""
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-span: .claude/skills/release/SKILL.md :: "## The release is mechanical" +4 sha256:7264e587adf2
- cite-span: .claude/skills/release/SKILL.md :: "# @decision: lockstep-suite-version" +12 sha256:420a532dd477
- cite: .claude/skills/release/SKILL.md :: "exactly two manifests"
- cite: .claude/skills/release/SKILL.md :: "writes that version into *every*"
- cite: .claude/skills/release/SKILL.md :: "Touch no other field"
- cite: .claude/skills/release/SKILL.md :: "The **highest level across all plugins wins**"
- cite: .claude/skills/release/SKILL.md :: "Annotated, repo-wide, on the commit that is now the tip of the default branch"
- cite: .claude/skills/release/SKILL.md :: "Do not create per-plugin tags"
- cite: .claude/skills/release/SKILL.md :: "it lives in the repo-root"
- cite: .claude/skills/release/SKILL.md :: "the release commit is on the default branch at"
- cite: .claude/skills/release/SKILL.md :: "the current suite version is the **highest** of them"
- cite: .claude/skills/release/SKILL.md :: "This is a deterministic re-stamp, nothing more"
- cite: .claude/skills/release/SKILL.md :: "No implementation audit goes stale — the vendored checker masks exactly these stamps"
- cite: .claude/skills/release/SKILL.md :: "The conduct version in"
- cite: plugins/ok/families/ok-planner/admin/converge :: "SUITE_MANIFEST="
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "# Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned:"
- cite: plugins/ok/families/ok-planner/admin/converge :: "PROOF_TIMINGS="${SCRIPTS}/proof-timings""
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "SUITE_MANIFEST="
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "sed "s/^const VERSION = '0" +3 sha256:0a0c85b9699c
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "'..', '..', '.claude-plugin', 'plugin.json'"
- cite: plugins/ok/test/administration.sh :: "Materialized by ok-planner v${suite_version}"
- cite: plugins/ok-conduct/output-styles/ok-conduct.md :: "Conduct version: 1.11.0 (Koala)"
