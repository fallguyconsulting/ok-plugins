---
audit: per-project-pinning
artifact: decision:per-project-pinning
determination: satisfied
audited: 2026-07-28T00:35:18Z
artifact-hash: sha256:8450a689e5db
---

# Is every materialized artifact stamped with the version that wrote it and executed from the project's own copy, with payload execution confined to two classes and announced when it is an advisory fallback?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical to last cycle); the staleness came from the `cite-file` pin on
`checks/text-presence`, which this cycle's repair edited. The repair closed the
exact gap the previous audit recorded against the *check*: the stale comment
claiming "port and starter are bootstrap verbs that run the payload's copy by
design, so they have no fallback to announce" is gone, replaced by a count of
eleven, and the two missing assertions were added. The check now asserts all
eleven announcement lines. Every claim below was re-derived from the tree.

**Choice clause 1 — "Every materialized artifact — vendored skills, scripts,
hooks, cheatsheets, the vendored lint binary — is stamped with the suite
version that wrote it."** The quantifier was re-enumerated from reality by
reading each family's converge core (and, where it delegates, the script it
execs) and listing every write target:

- ok-planner (6): `.ok-planner/CLAUDE.md`, `.claude/rules/ok-planner-cheatsheet.md`,
  `.ok-planner/scripts/surface-corpus`, `.ok-planner/bin/audit-check`,
  `.ok-planner/hooks/session-start` — each a
  `sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g"` substitution, the last
  three chmod'd 755 — plus the vendored skill files, which the renderer stamps
  with a trailing `Materialized by ok-planner v%s` comment. The `mkdir -p` of
  the estate subdirectory tree writes no content and the retired-payload `rm`s
  write none either.
- ok-plumbline (4 + skills): `.claude/rules/plumbline-cheatsheet.md` and
  `.ok-plumbline/hooks/post-edit.js` by `{{OK_PLUMBLINE_VERSION}}`
  substitution; `.ok-plumbline/bin/plumbline` by rewriting its
  `0.0.0-unvendored` placeholder to `${SUITE_VERSION}`; `.ok-plumbline/package.json`
  by a fixed `printf`; and the vendored skills through
  `vendor-skills` → `expectedVendoredSkills` → `renderVendoredSkill`, which
  appends `Materialized by ok-plumbline v${version}`.
- ok-workspaces (6): `src-tag` and `port-block` through
  `stamp()` (`{{OK_WORKSPACES_VERSION}}` → version); `.ok-workspaces/.gitignore`
  and, in the out-of-dot-directory in-repo case, a second `.gitignore` at the
  declared prefix — both built from `ignoreHeader`, whose first line is
  `# Materialized by ok-workspaces v${version}`; the vendored skill files; and
  the cheatsheet.

The one write target that escapes a stamp is `.ok-plumbline/package.json`,
which is JSON and has no comment channel. Charged as recorded rather than as a
breach: it is version-invariant layout (a fixed `{ "type": "commonjs" }`
literal that diagnose compares exactly) rather than behaviour, and it is none
of the kinds the Choice enumerates — not a skill, script, hook, cheatsheet, or
the binary. I specifically re-checked the workspaces `.gitignore` writes this
cycle as candidate second escapees and they are stamped. Every other write
target in all three cores carries a version. The suite check independently pins
the planner's ceremony-helper case — the one write that is a substitution
rather than a copy — asserting both the template's placeholder and the exact
`sed` line that fills it. Honored.

**Choice clause 2 — "and executes from the project's own copy; everything
downstream prefers the project copy over the front door's carried payload."**
Read outward from each materialized script to its callers: the session hook is
reached only through the consented settings entry pointing at
`$CLAUDE_PROJECT_DIR/.ok-planner/hooks/session-start`; the certification gates
and the shared implementation-auditor prompt name `.ok-planner/bin/audit-check`;
`/plan-sprint` and `/verify-issues` invoke
`python3 .ok-planner/scripts/surface-corpus`; the plumbline hook entry runs
`node "$CLAUDE_PROJECT_DIR/.ok-plumbline/hooks/post-edit.js"`; ok-workspaces'
`/open` runs the materialized allocator and tells the owner to run `/ok` if it
is missing. On the plumbline side all ten verbs open with
`bin=".ok-plumbline/bin/plumbline"` (or, for `port`, the target-relative
equivalent) and branch to the payload only on `! -x`. Exhibited, not read: the
family's clone self-containment case converges a fresh repo, then runs
`version`, `starter`, and `port` from the vendored skills with
`CLAUDE_PLUGIN_ROOT` unset, failing if any of them prints
`no vendored binary` — it passes on this tree, and the whole family suite is
green. Honored.

**Choice clause 3 — "Exactly two classes legitimately run from the payload: the
administration process itself … and read-only advisory verbs."** The
administration class is the three converge cores plus the front door's
diagnose/converge/wire-hooks driving, which by construction run before or while
the project copies are written — visible in plumbline's core, which execs the
payload `$BIN` for diagnose and wire-hooks and for `vendor-skills`, and only
then runs `node .ok-plumbline/bin/plumbline version` against what it just
wrote. The advisory class was re-enumerated from reality by listing every verb
directory across all three families: ok-plumbline ships ten (`audit`, `budget`,
`ci`, `explain`, `patterns`, `port`, `slug`, `starter`, `suggest`, `version`),
ok-planner's `audit` is the eleventh, and ok-workspaces' four skills (`audit`,
`close`, `open`, index) reference no payload path at all. A grep for
`CLAUDE_PLUGIN_ROOT` across all three families' `skills/` returns exactly
eleven fallback branches plus `port`'s reference to the porting-guide
*document* — no twelfth site, and nothing outside the two classes. Honored.

**Choice clause 4 (quantified) — "an advisory verb falling back to the payload
copy announces the fallback in its output."** Enumerated over the eleven, each
read at its else-branch:

- Six share one wording — `audit`, `budget`, `explain`, `patterns`, `slug`,
  `suggest`: `note: no vendored binary — using the payload's copy; /ok pins one
  to this project`.
- `ci`: `note: no vendored binary — CI needs one committed; run /ok first`
  (it announces and still runs, so the fallback is announced, not silent).
- `version`: `project (vendored): none — /ok pins one to this project`.
- `starter`: `note: no vendored binary in this project — proposing from the
  carried payload`.
- `port`: `note: no vendored binary in this project — planning from the carried
  payload`.
- ok-planner's `audit`: `note: no vendored checker — using the payload's copy;
  /ok pins one to this project`, required verbatim and on its own line before
  the findings.

All eleven are to stderr or to the report, never swallowed. **The previous
cycle's recorded gap is closed**: `checks/text-presence` now asserts all eleven
verbatim — the six in the loop, then `ci`, `version`, `starter`, `port`, and
the planner's `audit` individually — and its comment states the population as
eleven with the two bootstrap verbs named as announcing "in their own words"
rather than as exempt. I re-ran the check: exit 0. Its enumeration source is
pinned below, so any change to the population breaks this audit. Honored, with
no qualification this cycle.

**Choice clause 5 — "Updating the front-door plugin changes nothing in any
project until its owner converges deliberately."** Nothing project-side
executes from the payload outside the two carved-out classes, so a payload
update is inert until a converge rewrites the stamped copies. The integration
contract states the same conclusion in its own words, and each core's diagnose
reports the resulting stamp gap as information rather than as an error.
Honored.

**Rationale capability claims — "an audit must report what this project was
trued up to", "CI can lint at the project's pinned version with nothing
installed", "the stamp makes version drift mechanically checkable".** The first
two follow from clauses 1–2: the vendored `audit-check` and the vendored
plumbline binary are what actually run, and the `ci` verb's comment says in so
many words that the emitted config must invoke the committed binary so the
pipeline lints at the pinned version with no plugin installed — which the clone
case demonstrates end to end. The third is the diagnose mode of each core,
comparing each materialized file against the carried rendering at the stamped
version. Honored.

## Determination

**satisfied.** Every materialized artifact across all three families is written
through a version substitution or a renderer stamp — sixteen write targets
enumerated this cycle, including the workspaces `.gitignore` pair I re-checked
as candidate escapees — with the sole unstamped write being the plumbline
estate's JSON module marker, which is layout rather than behaviour and outside
the Choice's enumerated kinds. Every downstream consumer names the project-side
path first, and a converged clone runs its verbs against its own binary with
nothing installed, exhibited by the family's own test case rather than inferred
from the diff. Payload execution is confined to the administration cores and to
eleven read-only advisory verbs, each of which announces its fallback in its
own output — and as of this cycle all eleven announcements are asserted
verbatim by the suite check, closing the coverage gap the previous audit
recorded against it.

This stops holding if: a converge core gains a write target that skips the
stamp; a skill, hook, or check is changed to invoke a payload path where a
materialized copy exists; an advisory verb loses its announcement or gains a
silent fallback (the `cite-file` pin on `checks/text-presence` breaks the
moment its enumeration changes, and the `cite-span` on the
`per-project-pinning` block breaks on any reword inside it); a new verb is
added that runs the payload without being one of the two carved-out classes; or
the ceremony-helper substitution stops being version-stamped.

## Citations

- cite-file: checks/text-presence @ sha256:1473f590fc7e
- cite-span: checks/text-presence :: "# @decision: per-project-pinning" +56 sha256:08ce8fb4012e
- cite: plugins/ok/families/ok-planner/admin/converge :: "Materialized by ok-planner v%s"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the session-start hook and the ceremony-time helper" +12 sha256:68b1dffe2a53
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker, version-stamped. Consumer" +6 sha256:edcd4468664d
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "sed "s/^const VERSION = '0" +3 sha256:0a0c85b9699c
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "printf '{ "type": "commonjs" }\n' > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node .ok-plumbline/bin/plumbline version"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function renderVendoredSkill(text, srcName, version) {" +11 sha256:3e1ee7db4bfa
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function vendorSkillsCmd(target) {" +14 sha256:e9c8a483dfde
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const stamp = (s) => s.replace(/\{\{OK_WORKSPACES_VERSION\}\}/g, version);"
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const ignoreHeader = [" +4 sha256:a48cc4222c17
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Run the vendored checker" +6 sha256:752f7869841f
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "python3 .ok-planner/scripts/surface-corpus"
- cite: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "project (vendored): none"
- cite-span: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "bin=".ok-plumbline/bin/plumbline"" +6 sha256:d3a9d94b28b6
- cite: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "  echo "note: no vendored binary in this project — proposing from the carried payload" >&2"
- cite-span: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "plumbline_bin="$abs_target/.ok-plumbline/bin/plumbline"" +4 sha256:3a679b429998
- cite: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "  echo "note: no vendored binary in this project — planning from the carried payload" >&2"
- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "the materialized allocator"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
- cite: docs/integration-contract.md :: "Exactly two classes legitimately run from the carried"
- cite: docs/integration-contract.md :: "they were converged to, and updating the front door changes nothing"
