---
audit: per-project-pinning
artifact: decision:per-project-pinning
determination: satisfied
audited: 2026-07-27T13:10:00Z
artifact-hash: sha256:8450a689e5db
---

# Is every materialized artifact stamped with the version that wrote it and executed from the project's own copy, with payload execution confined to two classes and announced when it is an advisory fallback?

## Claims

**Choice clause 1 — "Every materialized artifact — vendored skills, scripts,
hooks, cheatsheets, the vendored lint binary — is stamped with the suite
version that wrote it."** The quantifier was enumerated from reality by reading
each family's converge core and listing every write target:

- ok-planner: vendored skill files (a trailing `Materialized by ok-planner
  v%s` stamp appended by the renderer to every file it writes, source skills
  and `_shared/` alike), `.ok-planner/CLAUDE.md` and the cheatsheet (template
  substitution of `{{OK_PLANNER_VERSION}}`), `scripts/surface-corpus`,
  `bin/audit-check`, and `hooks/session-start` (the same substitution, each
  chmod'd executable).
- ok-plumbline: the cheatsheet and the materialized `hooks/post-edit.js` by
  `{{OK_PLUMBLINE_VERSION}}` substitution, and the vendored binary by
  rewriting its `0.0.0-unvendored` placeholder to the suite version.
- ok-workspaces: `src-tag`, `port-block`, the cheatsheet, and the vendored
  skill files, each written through the family's `stamp()`/renderer.

No write target in any of the three cores escapes a stamp. The suite check
`text-presence` independently pins the planner's ceremony-helper case — the one
write that is a substitution rather than a copy — asserting both the template's
placeholder and the exact `sed` line that fills it. Honored.

**Choice clause 2 — "and executes from the project's own copy; everything
downstream prefers the project copy over the front door's carried payload."**
Read outward from each materialized script to its callers: the session hook is
reached only through the consented settings entry pointing at
`$CLAUDE_PROJECT_DIR/.ok-planner/hooks/session-start`; the certification gates
and the shared implementation-auditor prompt name `.ok-planner/bin/audit-check`;
`/plan-sprint` and `/verify-issues` invoke
`python3 .ok-planner/scripts/surface-corpus`; every plumbline verb resolves
`bin=".ok-plumbline/bin/plumbline"` first; ok-workspaces' `/open` runs the
materialized `.ok-workspaces/bin/port-block` allocator and tells the owner to
run `/ok` if it is missing. The integration contract states the same rule
normatively. Honored.

**Choice clause 3 — "Exactly two classes legitimately run from the payload: the
administration process itself … and read-only advisory verbs."** The
administration class is the three converge cores plus the front door's
diagnose/converge/wire-hooks driving, which by construction run before or while
the project copies are written; the contract names that carve-out in the same
terms. The advisory class was enumerated from reality by listing every verb
directory: ok-plumbline ships ten verbs (`audit`, `budget`, `ci`, `explain`,
`patterns`, `port`, `slug`, `starter`, `suggest`, `version`) and ok-planner's
`audit` is the eleventh candidate. Eight plumbline verbs plus the planner's
audit — nine — carry a project-copy-first resolution with a payload fallback;
`port` and `starter` are bootstrap verbs that state in their own comments that
they deliberately run the payload's copy because there is nothing vendored yet.
No other verb in any family executes a payload script. Honored.

**Choice clause 4 — "an advisory verb falling back to the payload copy
announces the fallback in its output."** All nine announcements are asserted
verbatim by `text-presence`, whose enumeration source is pinned below with
`cite-file`: six share one wording (`audit`, `budget`, `patterns`, `suggest`,
`explain`, `slug`), and `ci`, `version`, and the planner's `audit` announce it
in their own words. Spot-read of the skill bodies confirms each announcement
sits on the else-branch of the project-copy check, not merely in prose.
Honored.

**Choice clause 5 — "Updating the front-door plugin changes nothing in any
project until its owner converges deliberately."** Nothing project-side
executes from the payload outside the two carved-out classes, so a payload
update is inert until a converge rewrites the stamped copies; the contract
states the same conclusion, and each core's diagnose reports the resulting
stamp gap as information rather than as an error. Honored.

**Rationale capability claims — "an audit must report what this project was
trued up to", "CI can lint at the project's pinned version with nothing
installed", "the stamp makes version drift mechanically checkable".** The first
two follow from clauses 1–2 (the vendored `audit-check` and the vendored
plumbline binary are what run); the `ci` verb's fallback line refuses to emit a
config against a payload copy for exactly this reason. The third is the
diagnose mode of each core, which compares each materialized file against the
carried rendering at the stamped version. Honored.

## Determination

**Satisfied.** Every materialized artifact across all three families is written
through a version substitution or renderer stamp; every downstream consumer
names the project-side path first; payload execution is confined to the
administration cores and to nine read-only advisory verbs, each of which
announces its fallback in its own output, with the two bootstrap verbs
excluded by an explicit stated rationale rather than by omission.

This stops holding if: a converge core gains a write target that skips the
stamp; a skill, hook, or check is changed to invoke a payload path where a
materialized copy exists; an advisory verb loses its announcement or gains a
silent fallback (the `cite-file` pin on `text-presence` breaks the moment its
enumeration changes, forcing the advisory population to be re-derived); a new
verb is added that runs the payload without being one of the two carved-out
classes; or the ceremony-helper substitution stops being version-stamped.

## Citations

- cite-file: checks/text-presence @ sha256:1223b216280a
- cite: plugins/ok/families/ok-planner/admin/converge :: "Materialized by ok-planner v%s"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the session-start hook and the ceremony-time helper" +12 sha256:68b1dffe2a53
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker, version-stamped. Consumer" +6 sha256:edcd4468664d
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "sed "s/^const VERSION = '0" +3 sha256:0a0c85b9699c
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node .ok-plumbline/bin/plumbline version"
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Run the vendored checker" +6 sha256:752f7869841f
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "note: no vendored checker"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "python3 .ok-planner/scripts/surface-corpus"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Run the vendored"
- cite: plugins/ok/families/ok-plumbline/skills/version/SKILL.md :: "project (vendored): none"
- cite: plugins/ok/families/ok-plumbline/skills/port/SKILL.md :: "Bootstrap verb: deliberately the plugin"
- cite: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "Bootstrap verb: deliberately the payload"
- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "the materialized allocator"
- cite: docs/integration-contract.md :: "Exactly two classes legitimately run from the carried"
- cite: docs/integration-contract.md :: "they were converged to, and updating the front door changes nothing"
