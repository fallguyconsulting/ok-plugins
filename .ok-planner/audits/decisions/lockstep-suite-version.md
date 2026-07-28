---
audit: lockstep-suite-version
artifact: decision:lockstep-suite-version
determination: satisfied
audited: 2026-07-27T23:40:39Z
artifact-hash: sha256:c26653630fb0
---

# Does every plugin manifest carry one suite version per release, cut as one annotated repo-wide tag by a mechanical release act, with the family payload stamped from it and the conduct version carved out?

## Claims

**Title + Choice clause 1 — "Every plugin manifest carries the same semantic
version at every release."** The population is the set of plugin manifests,
enumerated from reality rather than from the decision's wording: the marketplace
manifest (pinned below) lists exactly two plugin sources, `./plugins/ok-conduct`
and `./plugins/ok`, and `plugins/*/.claude-plugin/plugin.json` yields exactly
those two files — both pinned below, both reading `"version": "11.0.0"`. The only
other `.claude-plugin/plugin.json` files anywhere in the tree are the two the
audit checker's own masking fixtures carry, which are not plugins, so the three
carried families still add no members: glob, marketplace listing, and population
coincide. The release skill states the same count in its own words ("exactly two
manifests: `ok` and `ok-conduct` — the families carry none") and directs the bump
into *every* manifest, explicitly including one with no changes in the release.
Equality is then asserted mechanically before any commit or tag: the verbatim,
do-not-skip block carrying this decision's `@decision:` annotation loops the same
glob, prints `MIXED VERSION`, and exits non-zero on any disagreement. Honored.

**Choice clause 2 — "bumped together at the highest level any change in the
suite warrants."** The bump table classifies major / minor / patch by what the
change does to the suite's surface, and the governing sentence is explicit that
the highest level across all plugins wins, with genuine ambiguity resolved upward
and said out loud. The survey step attributes changes per plugin *and per
family*, declaring a change under the front door's payload a suite change like
any other. Honored.

**Choice clause 3 — "with one annotated repo-wide tag per release cut by the
repo-local release skill."** The tag step is annotated (`git tag -a`), taken on
the commit that is the tip of the default branch, and immediately followed by the
prohibition on per-plugin tags with its stated reason (an ambiguous
`git describe`). "Repo-local" holds of the skill itself: it lives at the
repo-root `.claude/skills/release/`, outside every plugin, and its own body says
that is why and forbids copying it into a plugin directory. Honored.

**Choice clause 4 — "the carried family payload is stamped with that same suite
version wherever it materializes."** The quantifier was enumerated from reality
across the whole population under `plugins/ok/families/` — all three carried
families, and every version substitution site in each converge core.
ok-planner's core resolves `SUITE_MANIFEST` three levels up to the front-door
manifest and reads `SUITE_VERSION` out of it, substituting it into the estate
guide, the cheatsheet, `surface-corpus`, `audit-check`, the session-start hook,
and the trailing stamp of every vendored skill. ok-plumbline's core resolves the
identical path the same way and stamps the cheatsheet, the vendored binary
(replacing its `0.0.0-unvendored` placeholder), and the post-edit hook.
ok-workspaces' `converge.js` reads `'..', '..', '.claude-plugin', 'plugin.json'`
and stamps src-tag, the port allocator, the worktree ignore header, the
cheatsheet, and its vendored skills. No family reads any other version source and
none has a manifest of its own to read.

This checkout corroborates it: every stamped artifact in the dogfood estate —
estate guide, cheatsheet, `surface-corpus`, `audit-check`'s `VERSION`, both
version sites in the session-start hook, and all fifteen vendored planner skill
files — reads `11.0.0`, matching the manifests exactly, with no stamp left at a
prior version (the sixteenth file under `.claude/skills/` is the repo-local
release skill, which is not vendored payload and carries no stamp). Re-derived
for this audit rather than carried over: running the planner's converge core
against a scratch copy bumped to `11.0.1` rewrote exactly the stamped files and
no others. The administration harness independently asserts that the estate
guide's stamp equals the version read straight from the front-door manifest.
Honored.

Adversarially examined and not charged: the plumbline converge core gained, in
this cycle's uncommitted work, one materialization that carries no version at
all — `.ok-plumbline/package.json`, a fixed `{ "type": "commonjs" }` module
marker. Read as "every materialized file bears a stamp", that would be a new
unstamped member. That reading is not the one the clause makes: the subject is
"the carried family payload", and the marker is not carried payload — it is a
literal converge generates, with no version to carry and no family-local version
source introduced. The commitment this decision holds is that every version in
the suite is *the* suite version, derived from the front-door manifest; a file
with no version disagrees with nothing. If the Choice were tightened to "every
materialized artifact carries the suite-version stamp", this member would flip
the determination.

**Choice clause 5 — "The release act itself is mechanical: it changes only
release-mutable metadata — the manifest version fields and the stamps a
re-converge rewrites — plus the release commit and tag, verifies itself with
deterministic assertions alone (manifest equality, remote installability), and
neither runs nor re-derives implementation audits; the sole judgment a release
holds is the semver level."** Honored, clause by clause against the procedure as
it stands. The skill carries a dedicated, `@decision:`-annotated section stating
exactly this, and the steps match it: the only edits the act authors are step 5's
manifest `version` fields ("Touch no other field") and step 5c's delegated
re-converge, described as "a deterministic re-stamp, nothing more"; step 6's
`git add -A` records the pre-existing tree as the release commit rather than
authoring content; step 8 tags. Verification is step 5b (manifest equality, a
verbatim shell block), step 9b (three remote queries that must agree), and the
preflight — all deterministic; no step invokes `audit-check`, dispatches an
agent, or touches `.ok-planner/audits/`, and the Notes restate that the release
never writes the audit corpus. The one judgment step is step 3's semver level;
step 4's conduct check warns from a diff, step 2's drift resolution is "take the
highest", and step 7's merge path is a fixed procedure with a stop rule.

The supporting claim the skill leans on for this clause — that the vendored
checker masks release-mutable metadata so "no implementation audit goes stale" —
was re-derived here on the current tree rather than taken on the skill's word: a
scratch copy of this repo with both manifests at `11.0.1` and the planner core
re-converged changes twenty-two files, every one of which hashes identically
under the checker's own masking function, and `audit-check` over that tree
returns a finding set byte-identical to the baseline. There is genuinely nothing
for the release to re-audit. (The masking itself is charged against
`decision:adversarial-implementation-audits`, whose audit records the
derivation.) Honored.

**Choice clause 6 — "A release is done only when the release commit is reachable
from the remote default branch and the tag points at it."** The finish-line
sentence states exactly that, naming the landing step (7) and the verification
step (9b). The landing step precedes tagging, the default branch is derived from
the remote via `git ls-remote --symref` rather than assumed, and the closing
verification queries `origin` for the tag, the branch head, and containment, with
the instruction never to report a release done without it. Honored.

**Choice clause 7 — "Between releases manifests may drift while work is in
flight; the release converges them."** The read-current-version step anticipates
differing manifests ("a repo mid-unification, or a hand-edited manifest"), takes
the highest as the current suite version, requires saying so in the report, and
forbids picking a lower one because lowering strands existing installs. Honored.

**Choice clause 8 — "The conduct's version is the one carve-out: hand-managed
and untouched by a release."** The carve-out is the conduct document's own body
stamp — `Conduct version: 1.11.0 (Koala)` — not the conduct *plugin manifest*,
which is one of the two bumped in lockstep and currently at 11.0.0 like its
sibling. The release skill only warns when the conduct body changed without a
bump, and states that it bumps plugin `version` fields only. The conduct stamp is
unchanged at 1.11.0 across the 10.0.0 → 11.0.0 suite bump — the carve-out
exhibited rather than asserted. It also survives the checker's mask: the stamp
carries no `v` prefix, so it is hashed as written and a hand-bump of it would
break any anchor over it. Honored.

**Rationale — "A shared number is what makes 'which versions work together'
answerable, and equality at release time is the property consumers actually
depend on."** Follows from clause 1 plus clause 4: two manifests at one number,
and every project-side stamp in every family derived from one of them. The
Rationale asserts nothing about the harness's update key, so nothing in it
depends on third-party behaviour this repo cannot observe; the update-key
justification survives only inside the release skill, as procedural reasoning,
where no commitment turns on it. Honored.

**Rationale — "Correctness is established where it belongs, at certification: by
release time the tree is already certified, so any verification beyond
deterministic assertions would re-buy what the gates already paid for, at the
moment of least new information."** Honored as a description of the procedure:
the mechanical-release section opens with the same premise and the procedure
carries no gate, reviewer, or auditor.

**Alternatives — independent semver, rejecting drift, per-plugin tags, a
re-auditing release gate.** All four are genuine roads not taken; the third and
fourth are explicitly negated in the procedure (the per-plugin-tag prohibition,
and the sentence stating the release dispatches no agent and re-audits nothing).

## Determination

**satisfied.** Both manifests in the enumerated population carry 11.0.0, and no
third manifest exists anywhere in the tree outside the checker's masking
fixtures. The release procedure writes one version into every manifest, asserts
equality with a verbatim guard that blocks tagging a mixed set, cuts one
annotated repo-wide tag while forbidding per-plugin tags, converges mid-cycle
drift upward, and verifies remote reachability as the finish line. All three
families derive their stamps from the front-door manifest and from nothing else,
so the payload is stamped with the suite version wherever it materializes —
visible in this checkout, where every materialized and vendored artifact reads
11.0.0, and re-derived by converging a bumped scratch copy. The plumbline core's
new unstamped module marker was examined against clause 4 and does not refute it:
it is a generated marker, not carried payload, and it introduces no second
version source. The mechanical clause holds for the right reason: the act edits
only manifest versions and delegated stamps, verifies itself with two
deterministic assertions, dispatches no agent, runs no audit — and a simulated
version-only release of this repo genuinely voids nothing, re-derived on the
current tree. The conduct's hand-managed document version stayed at 1.11.0
through the suite bump.

This stops holding if: a third plugin appears in the marketplace manifest with a
version that does not track the other two, or either manifest's version moves
alone (all three pins break and force the population to be re-derived); the
equality-assertion block is deleted, weakened, or moved out of its pre-commit
position (the `cite-span` covers its body); the mechanical-release section is
deleted or an audit/review/gate step is added to the procedure (its `cite-span`
covers the whole paragraph); a family gains a manifest of its own or reads a
version from anywhere but the front-door manifest (the whole-file pins on all
three converge cores break); per-plugin tags are introduced; the release skill is
copied into a plugin directory; the administration harness stops asserting
stamp-equals-manifest; or the remote-reachability verification stops being the
finish line. It would also re-open if the checker's masking regressed, since the
mechanical clause's "deterministic assertions alone" depends on a version-only
release leaving the audit corpus untouched, and it would flip to violated if
clause 4 were reworded to require a suite-version stamp on every materialized
artifact, since `.ok-plumbline/package.json` carries none.

## Citations

- cite-file: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-file: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-file: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
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
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "SUITE_MANIFEST="
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "'..', '..', '.claude-plugin', 'plugin.json'"
- cite: plugins/ok/test/administration.sh :: "Materialized by ok-planner v${suite_version}"
- cite: plugins/ok-conduct/output-styles/ok-conduct.md :: "Conduct version: 1.11.0 (Koala)"
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:75db5f704edb
- cite-file: plugins/ok/families/ok-plumbline/admin/converge @ sha256:77508ce089a1
- cite-file: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
