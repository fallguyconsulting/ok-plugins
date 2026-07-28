---
audit: per-project-pinning
artifact: decision:per-project-pinning
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:87246400739a
---

# Is every materialized artifact stamped and executed from the project's own copy — and is the fixed-content exception now actually verified by exact content?

## Claims

**Why this is a fresh derivation of one clause.** The design artifact's hash is
unchanged from the previous cycle (`sha256:87246400739a`), so its precedent
would ordinarily bind. It does not bind on clause 1b, because the cited reality
that carried the previous `violated` determination moved: the plumbline module
marker's fidelity check was rewritten. That clause is therefore re-derived from
the tree below with no deference to the prior verdict. The remaining clauses
were re-verified against the changed files and otherwise carried.

**Choice clause 1a (quantified) — "Every materialized artifact — vendored
skills, scripts, hooks, cheatsheets, the vendored lint binary — is stamped with
the suite version that wrote it."** The quantifier was re-enumerated from
reality by reading each family's converge core (and, where it delegates, the
script it execs) and listing every write target. Eighteen, unchanged in count:

- ok-planner (7): `.ok-planner/CLAUDE.md`, `.claude/rules/ok-planner-cheatsheet.md`,
  `.ok-planner/scripts/surface-corpus`, `.ok-planner/bin/audit-check`,
  `.ok-planner/bin/source-graph`, `.ok-planner/hooks/session-start` — each a
  `sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g"` substitution, the last
  four chmod'd 755 — plus the vendored skill files, stamped by the renderer with
  a trailing `Materialized by ok-planner v%s` comment. The estate `mkdir -p`
  writes no content and the retired-payload `rm`s write none.
- ok-plumbline (5): `.claude/rules/plumbline-cheatsheet.md` and
  `.ok-plumbline/hooks/post-edit.js` by `{{OK_PLUMBLINE_VERSION}}` substitution;
  `.ok-plumbline/bin/plumbline` by rewriting its `0.0.0-unvendored` placeholder;
  the vendored skills through `vendor-skills` → `renderVendoredSkill`, which
  appends `Materialized by ok-plumbline v${version}`; and
  `.ok-plumbline/package.json`, whose write mechanism changed this cycle — the
  inline `printf` of a literal is gone, replaced by
  `node "$BIN" module-marker > .ok-plumbline/package.json`.
- ok-workspaces (6): `src-tag` and `port-block` through `stamp()`;
  `.ok-workspaces/.gitignore` and, in the out-of-dot-directory in-repo case, a
  second `.gitignore` at the declared prefix — both built from `ignoreHeader`,
  whose first line carries `Materialized by ok-workspaces v${version}`; the
  cheatsheet; and the vendored skill files.

Seventeen carry a version. The one that does not is `.ok-plumbline/package.json`
— which is precisely what the clause excepts, so clause 1a is honored.

**Choice clause 1b (the exception, quantified) — "the one exception being a
fixed-content artifact, whose bytes never vary across suite versions and which
is therefore verified by exact content rather than by a stamp."** Two
sub-claims; the population of fixed-content artifacts is one, enumerated from
the eighteen write targets above (the cores are pinned whole below).

**The first sub-claim holds, and now holds structurally rather than
incidentally.** The marker's bytes are a single named constant in the family
binary — `const MODULE_MARKER = '{ "type": "commonjs" }\n'` — with no version
interpolation anywhere in it and no second spelling anywhere in the suite. The
`module-marker` subcommand does nothing but write that constant to stdout, and
converge's redirect takes its bytes from that subcommand. "Fixed content" is
therefore definitional here: the canonical bytes exist in exactly one place and
every writer derives from it.

**The second sub-claim now holds too — this is the clause the previous cycle
charged, and the charge is discharged.** Diagnose reads the file whole and
compares it to the same constant by string equality (`markerContent ===
MODULE_MARKER`). Not a parse, not a field test: byte-for-byte identity against
the canonical literal. I probed the three cases the previous determination said
an exact-content check would have to distinguish and this one did not:

- **Drift that still parses.** A marker rewritten to
  `{ "type": "commonjs", "private": true }` — whose `type` still parses to
  `commonjs`, exactly the shape the old check admitted — is now reported
  `differs from its canonical content`. The harness case asserts this case
  specifically, and asserts the diagnose exit code is non-zero for it.
- **Fail level, not warn.** The drift branch pushes `fail`, and diagnose's
  tally counts only `fail` before `process.exit(fails > 0 ? 1 : 0)`. So a
  drifted marker moves the exit code, which is what the previous cycle said was
  missing. Absence is `fail` too when the estate is integrated
  (`.ok-plumbline/` present) and `warn` otherwise — a project with no estate has
  no materialized artifact to verify, so the warn is the honest level there
  rather than a softening of the check. Exhibited on this repository, which
  carries no plumbline estate: the absent marker reports at warn and diagnose
  exits healthy; the harness exhibits the integrated side, deleting the marker
  from a converged estate and asserting a non-zero diagnose.
- **The spelling disagreement the previous cycle recorded is gone.** The design
  corpus no longer quotes a rival spelling anywhere (a grep of
  `.ok-planner/design/` for `commonjs` returns nothing), and the family's
  administration document now quotes the canonical form with its spaces
  (`whose fixed content \`{ "type": "commonjs" }\``) and describes the check in
  the terms the code implements: present "and matches its canonical content byte
  for byte — it carries no version stamp, so exact content is what fidelity
  means for it, and absence or any drift is a diagnosis failure whose remedy is
  converge." Corpus, document, and code now say the same thing.

The full fidelity round trip is exercised rather than read:
`run_module_marker_fidelity_case` converges a bare repository, asserts a clean
diagnose, drifts the marker in the still-parsing way, asserts a non-zero
diagnose carrying the drift message, re-converges, asserts the file is
byte-identical to `module-marker`'s output via `cmp -s`, asserts diagnose is
clean again, then deletes the marker and asserts a non-zero diagnose. The
family harness runs green on this tree.

One residual asymmetry, recorded and not charged because no sentence of the
Choice reaches it: converge and its diagnose both run the *payload* binary, so
the emitting and checking constants are the same object by construction. A
consumer's *vendored* binary at an older suite version would carry its own copy
of the constant — but the clause's premise is that these bytes never vary across
suite versions, so the copies cannot disagree while the premise holds, and if
one ever did, the drift would surface as a `fail` rather than pass silently.

**Choice clause 2 — "and executes from the project's own copy; everything
downstream prefers the project copy over the front door's carried payload."**
Read outward from each materialized script to its callers: the session hook is
reached only through the consented settings entry pointing at
`$CLAUDE_PROJECT_DIR/.ok-planner/hooks/session-start`; the certification gates
and the shared implementation-auditor prompt name `.ok-planner/bin/audit-check`;
both certify gates name `.ok-planner/bin/source-graph build` and no payload path
for it; `/plan-sprint` and `/verify-issues` invoke
`python3 .ok-planner/scripts/surface-corpus`; the plumbline hook entry runs
`node "$CLAUDE_PROJECT_DIR/.ok-plumbline/hooks/post-edit.js"`; ok-workspaces'
`/open` runs the materialized allocator. On the plumbline side all ten verbs open
with `bin=".ok-plumbline/bin/plumbline"` (or, for `port`, the target-relative
equivalent) and branch to the payload only on `! -x`. The new `module-marker`
subcommand adds no downstream consumer: it is invoked by converge alone, which
is the administration class carved out in clause 3. Exhibited, not read: the
family's clone self-containment case converges a fresh repo and runs `version`,
`starter`, and `port` from the vendored skills with `CLAUDE_PLUGIN_ROOT` unset.
Honored.

**Choice clause 3 — "Exactly two classes legitimately run from the payload: the
administration process itself … and read-only advisory verbs."** The
administration class is the three converge cores plus the front door's
diagnose/converge/wire-hooks driving, which by construction run before or while
the project copies are written; `module-marker` is reached only from inside that
class. The advisory class was re-enumerated from reality by listing every verb
directory across all three families and the front door — twenty-five verbs (plus
`skills/_shared/`): ok-plumbline ten, ok-planner ten, ok-workspaces four, the
front door one. A grep for `CLAUDE_PLUGIN_ROOT` across all family `skills/`
returns ten binary fallback branches (the plumbline verbs) plus `port`'s
reference to the porting-guide *document*; ok-planner's `audit` is the eleventh
advisory fallback, expressed against the payload's `scripts/audit-check` rather
than through the variable. No twelfth site, and nothing outside the two classes.
Honored.

**Choice clause 4 (quantified) — "an advisory verb falling back to the payload
copy announces the fallback in its output."** Enumerated over the eleven, each
read at its else-branch: six share one wording (`audit`, `budget`, `explain`,
`patterns`, `slug`, `suggest`); `ci`, `version`, `starter`, `port`, and the
planner's `audit` each announce in their own words. All eleven go to stderr or
into the report. `checks/text-presence` asserts all eleven verbatim and states
the population as eleven in its own comment; its enumeration source is pinned
below, and it exits 0 on this tree. Honored.

**Choice clause 5 — "Updating the front-door plugin changes nothing in any
project until its owner converges deliberately."** Nothing project-side executes
from the payload outside the two carved-out classes, so a payload update is
inert until a converge rewrites the stamped copies. The integration contract
states the same conclusion, and each core's diagnose reports the resulting stamp
gap as information rather than as an error. The marker is the one artifact where
this now cuts the other way and correctly so: because its content is fixed
rather than stamped, a payload update leaves a converged project's marker
*already correct*, and diagnose says so. Honored.

**Rationale capability claims — "an audit must report what this project was
trued up to", "CI can lint at the project's pinned version with nothing
installed", "the stamp makes version drift mechanically checkable", and (for the
excepted artifact) that content equality is what stands in for the stamp.** The
first two follow from clauses 1a–2 and are demonstrated end to end by the clone
case. The third is each core's diagnose comparing the materialized file against
the carried rendering — true of the seventeen stamped targets. The fourth is now
delivered rather than promised: the eighteenth is compared against its canonical
bytes, at fail level, with converge named as the remedy — which is strictly
stronger than the stamp comparison its siblings get, since a stamp-equal file
with drifted body would pass a stamp check and cannot pass this one. Honored.

**Alternatives — always run the payload, pin by lockfile, force advisory verbs
through the gate.** All three are genuine roads not taken and none is in play.

## Determination

**satisfied**, flipped from the previous cycle's `violated` by a change in the
cited reality rather than by a change of reading. The previous determination
rested on one finding: the fixed-content exception licensed an artifact to skip
the version stamp on the express ground that it "is therefore verified by exact
content rather than by a stamp", and the only check that existed parsed the file
and tested one field, tolerated arbitrary other content, and recorded a `warn`
that left diagnose at exit 0. That check no longer exists. The marker's bytes
are now a single canonical constant, emitted by an emit-only subcommand that
converge redirects into place, and diagnose compares the file to that same
constant by string equality — reporting a mismatch as a `fail`, which is the
only status diagnose's exit code counts, with converge named as the remedy.
Absence is a `fail` too once the estate exists. The family's administration
document was brought to the same words, and the corpus carries no rival spelling
of the canonical bytes. All of it is held from both sides by a harness case that
drifts the marker in the exact way the old check tolerated, watches diagnose
fail, watches converge restore byte-identical content, and watches a deletion
fail as well.

Every other clause holds on re-derivation: eighteen write targets enumerated
from the three cores, seventeen stamped; every downstream consumer naming the
project-side path first; payload execution confined to the administration cores
and eleven read-only advisory verbs, each announcing its fallback, all eleven
asserted verbatim by a check that exits 0 here.

This stops holding if: the module marker's diagnosis stops being a whole-content
comparison — reverting to a parse-and-field test, or comparing against anything
but the canonical constant (the span pin on the diagnose block breaks first);
the drift or the integrated-absence branch is demoted from `fail` to `warn`, or
diagnose's exit stops keying on `fail`; a second canonical spelling of the
marker's bytes appears anywhere, so `MODULE_MARKER` stops being the single
source the emitter and the checker share (the `cite:` on the constant and the
`cite:` on converge's `module-marker` redirect break); the harness's fidelity
case is deleted or weakened so the still-parsing drift goes unexercised; a
second unstamped write target appears that is not fixed content, or a stamped
one loses its substitution (the whole-file pins on all three cores break); a
downstream consumer reintroduces an unconditional payload path; or an advisory
verb drops its fallback announcement.

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER_REL = '.ok-plumbline/package.json';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function moduleMarkerCmd() {" +5 sha256:3fcc2ceea20c
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  'module-marker': () => moduleMarkerCmd(),"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  const moduleMarker = path.join(repoRoot, MODULE_MARKER_REL);" +16 sha256:5be8d60618d0
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    if (status === 'fail') fails++;"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  process.exit(fails > 0 ? 1 : 0);"
- cite: plugins/ok/families/ok-plumbline/admin/ADMINISTRATION.md :: "whose fixed content `{ "type": "commonjs" }` makes the vendored binary and"
- cite: plugins/ok/families/ok-plumbline/admin/ADMINISTRATION.md :: "marker (`.ok-plumbline/package.json`) is present and matches its"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_module_marker_fidelity_case() {" +54 sha256:9989593660f5
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "check_rendered() {" +10 sha256:2fd5f3e4dc75
- cite-node: checks/text-presence @ sha256:1473f590fc7e
- cite-span: checks/text-presence :: "# @decision: per-project-pinning" +56 sha256:08ce8fb4012e
- cite: plugins/ok/families/ok-planner/admin/converge :: "Materialized by ok-planner v%s"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the session-start hook and the ceremony-time helper" +12 sha256:68b1dffe2a53
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: ".ok-planner/bin/source-graph build"
- cite-span: plugins/ok/families/ok-plumbline/admin/converge :: "sed "s/^const VERSION = '0" +3 sha256:0a0c85b9699c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function renderVendoredSkill(text, srcName, version) {" +11 sha256:3e1ee7db4bfa
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
