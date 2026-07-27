---
audit: lockstep-suite-version
artifact: decision:lockstep-suite-version
determination: satisfied
audited: 2026-07-27T20:45:00Z
artifact-hash: sha256:5934e6584838
---

# Does every plugin manifest carry one suite version per release, cut as one annotated repo-wide tag, with the family payload stamped from it and the conduct version carved out?

## Claims

**Title + Choice clause 1 — "Every plugin manifest carries the same semantic
version at every release."** The population is the set of plugin manifests,
enumerated from reality rather than from the decision's own wording: `plugins/`
contains exactly two directories, `ok` and `ok-conduct`, and
`plugins/*/.claude-plugin/plugin.json` yields exactly those two files, both
pinned below with `cite-file` and both currently reading `"version": "11.0.0"`.
A search for any `.claude-plugin` directory or `plugin.json` beneath
`plugins/ok/families/` returns nothing, so the three carried families add no
members: glob and population coincide. The release skill states the same count
in its own words ("exactly two manifests: `ok` and `ok-conduct` — the families
carry none") and directs the bump into *every* manifest, explicitly including
one with no changes in the release. Equality is then asserted mechanically
before any commit or tag: the verbatim, do-not-skip block carrying this
decision's `@decision:` annotation loops the same glob, prints `MIXED VERSION`,
and exits non-zero on any disagreement. Honored.

**Choice clause 2 — "bumped together at the highest level any change in the
suite warrants."** The bump table classifies major / minor / patch by what the
change does to the suite's surface, and the governing sentence is explicit that
the highest level across all plugins wins, with genuine ambiguity resolved
upward and said out loud. The survey step attributes changes per plugin *and
per family* and declares a change under the front door's payload a suite change
like any other. Honored.

**Choice clause 3 — "with one annotated repo-wide tag per release cut by the
repo-local release skill."** The tag step is annotated (`git tag -a`), taken on
the commit that is the tip of the default branch, and immediately followed by
the prohibition on per-plugin tags with its stated reason (an ambiguous
`git describe`). "Repo-local" holds of the skill itself: it lives at the
repo-root `.claude/skills/release/`, outside every plugin, and its own body
says that is why and forbids copying it into a plugin directory. Honored.

**Choice clause 4 — "the carried family payload is stamped with that same suite
version wherever it materializes."** The quantifier "wherever it materializes"
was enumerated from reality across all three carried families — the whole
population under `plugins/ok/families/`. ok-planner's converge core resolves
`SUITE_MANIFEST` three levels up to the front-door manifest and reads
`SUITE_VERSION` out of it, substituting it into the estate guide, the
cheatsheet, `surface-corpus`, `audit-check`, the session-start hook, and the
trailing stamp of every vendored skill. ok-plumbline's core resolves the
identical path the same way and stamps the cheatsheet, the vendored binary
(replacing its `0.0.0-unvendored` placeholder), and the post-edit hook.
ok-workspaces' `converge.js` reads `'..', '..', '.claude-plugin', 'plugin.json'`,
and its sibling `diagnose.js` derives from the same manifest, so the diagnostic
and the writer cannot disagree. No family reads any other version source and
none has a manifest of its own to read — the front door's own `CLAUDE.md`
states the constraint in the same terms. This checkout corroborates it: every
stamped artifact in the dogfood estate (estate guide, cheatsheet,
`surface-corpus`, `audit-check`'s `VERSION`, the session-start hook, and all
fifteen vendored skill files) reads `11.0.0`, matching the manifests exactly,
with no stamp left at a prior version. The administration harness independently
asserts that the estate guide's stamp equals the version read straight from the
front-door manifest, and its closing-table check re-asserts it per family.
Honored.

**Choice clause 5 — "A release is done only when the release commit is
reachable from the remote default branch and the tag points at it."** The
finish-line sentence states exactly that, naming the landing step (7) and the
verification step (9b). The landing step precedes tagging, the default branch is
derived from the remote via `git ls-remote --symref` rather than assumed, and
the closing verification queries `origin` for the tag, the branch head, and
containment, with the instruction never to report a release done without it.
Honored.

**Choice clause 6 — "Between releases manifests may drift while work is in
flight; the release converges them."** The read-current-version step anticipates
differing manifests ("a repo mid-unification, or a hand-edited manifest"), takes
the highest as the current suite version, requires saying so in the report, and
forbids picking a lower one because the version is the harness's update key.
Honored.

**Choice clause 7 — "The conduct's version is the one carve-out: hand-managed
and untouched by a release."** The carve-out is the conduct document's own
stamp — `Conduct version: 1.11.0 (Koala)`, a body line of the output style —
not the conduct *plugin manifest*, which is one of the two manifests bumped in
lockstep and currently at 11.0.0 like its sibling. The release skill only warns
when the conduct body changed without a bump, and its notes state that it bumps
plugin `version` fields only and that the conduct version is hand-managed. The
conduct stamp is unchanged at 1.11.0 across the 10.0.0 → 11.0.0 suite bump,
which is the carve-out exhibited rather than merely asserted. Honored.

**Rationale capability claim — "A shared number is what makes 'which versions
work together' answerable."** Follows from clause 1 plus clause 4: two manifests
at one number, and every project-side stamp in every family derived from one of
them. Honored.

## Determination

**satisfied.** Both manifests in the enumerated population carry 11.0.0, and no
third manifest exists anywhere in the tree. The release procedure writes one
version into every manifest, asserts equality with a verbatim guard that blocks
tagging a mixed set, cuts one annotated repo-wide tag while forbidding
per-plugin tags, converges mid-cycle drift upward, and verifies remote
reachability as the finish line. All three families derive their stamps from the
front-door manifest and from nothing else, so the payload is stamped with the
suite version wherever it materializes — visible in this checkout, where every
materialized and vendored artifact reads the manifests' 11.0.0. The conduct's
hand-managed document version stayed at 1.11.0 through the suite bump, which is
the carve-out working.

This stops holding if: a third plugin directory appears with a manifest that
does not track the other two, or either manifest's version moves alone (both
`cite-file` pins break on any version change and force the population to be
re-derived); the equality-assertion block is deleted, weakened, or moved out of
its pre-commit position (the `cite-span` covers its body); a family gains a
manifest of its own or reads a version from anywhere but the front-door
manifest; per-plugin tags are introduced; the release skill is copied into a
plugin directory; the administration harness stops asserting stamp-equals-
manifest; or the remote-reachability verification stops being the finish line.

## Citations

- cite-file: plugins/ok/.claude-plugin/plugin.json @ sha256:1e0d1df885e8
- cite-file: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:fcd4bd327f39
- cite-span: .claude/skills/release/SKILL.md :: "# @decision: lockstep-suite-version" +12 sha256:420a532dd477
- cite: .claude/skills/release/SKILL.md :: "writes that version into *every*"
- cite: .claude/skills/release/SKILL.md :: "The **highest level across all plugins wins**"
- cite: .claude/skills/release/SKILL.md :: "Annotated, repo-wide, on the commit that is now the tip of the default branch"
- cite: .claude/skills/release/SKILL.md :: "Do not create per-plugin tags"
- cite: .claude/skills/release/SKILL.md :: "the release commit is on the default branch at"
- cite: .claude/skills/release/SKILL.md :: "the current suite version is the **highest** of them"
- cite: .claude/skills/release/SKILL.md :: "The conduct version in `ok-conduct.md` is hand-managed"
- cite: plugins/ok/families/ok-planner/admin/converge :: "SUITE_MANIFEST="
- cite: plugins/ok/families/ok-planner/admin/converge :: "SUITE_VERSION=$(sed -n"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "SUITE_MANIFEST="
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "'..', '..', '.claude-plugin', 'plugin.json'"
- cite: plugins/ok/test/administration.sh :: "grep -q "Materialized by ok-planner v${suite_version}" .ok-planner/CLAUDE.md"
- cite: plugins/ok-conduct/output-styles/ok-conduct.md :: "Conduct version: 1.11.0 (Koala)"
