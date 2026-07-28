---
audit: whole-file-ownership
artifact: decision:whole-file-ownership
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:3c3d07cc3841
---

# Does the suite's machinery own only whole regenerable files — stamped save for a fixed-content one — never edit human-edited files, converge its own layer silently, and reach everything else through the owner's consent?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical to the previous cycle), so prior determinations bind absent
moved reality. What moved is the plumbline converge core, whose whole-file pin
this audit carries as the enumeration source for its write-target quantifier:
the core's module-marker write changed mechanism (the inline `printf` of a
literal became `node "$BIN" module-marker >`, taking its bytes from a single
canonical constant in the family binary). The clause that edit touches — clause
1, the write-target enumeration — was re-derived from the cores rather than
carried; the previous cycle's adjudicated note is carried forward verbatim.

**Title + Choice clause 1 — "The suite's machinery — the front door's
administration and every family's converge core — owns whole files only:
version-stamped — save for a fixed-content file … — deterministically
regenerable, overwritten wholesale."** The population is the front door plus
every family converge core, enumerated from `plugins/ok/families/` (three:
ok-planner, ok-plumbline, ok-workspaces). The front door writes nothing itself
and says so in its own body — every write happens inside a family core — so the
checkable population is those three, each pinned whole below as the enumeration
source for the write targets. Read out of the cores rather than out of the
decision's wording, the write targets are **eighteen**:

- ok-planner (7): `.ok-planner/CLAUDE.md`, `.claude/rules/ok-planner-cheatsheet.md`,
  `.ok-planner/scripts/surface-corpus`, `.ok-planner/bin/audit-check`,
  `.ok-planner/bin/source-graph`, `.ok-planner/hooks/session-start` — each a
  `sed`-substituted whole-file redirect, the last four chmod'd 755 — plus the
  vendored skill files, written by the python half with `open(path, "w")` over
  a wholly re-rendered body. `.ok-planner/bin/source-graph` is the member this
  cycle added; its payload source carries the `{{OK_PLANNER_VERSION}}`
  placeholder, so the materialized copy is stamped like its siblings.
- ok-plumbline (5): `.claude/rules/plumbline-cheatsheet.md`,
  `.ok-plumbline/package.json`, `.ok-plumbline/bin/plumbline` (its
  `0.0.0-unvendored` placeholder rewritten to the suite version),
  `.ok-plumbline/hooks/post-edit.js`, and the vendored skills through the
  binary's `vendorSkillsCmd`, whose renderer appends the stamp.
- ok-workspaces (6): the profile-declared `src-tag` path,
  `.ok-workspaces/bin/port-block` (dev-server runtime only),
  `.ok-workspaces/.gitignore`, the worktree `.gitignore` at an out-of-dot-directory
  in-repo prefix, `.claude/rules/ok-workspaces-cheatsheet.md`, and the vendored
  skills — all through `stamp()` or the version-bearing `ignoreHeader`.

Seventeen of eighteen carry a version. The one that does not is
`.ok-plumbline/package.json`, whose bytes are now a single named constant in the
family binary (`const MODULE_MARKER = '{ "type": "commonjs" }\n'`) that an
emit-only `module-marker` subcommand writes to stdout and the core redirects
into place — no version interpolation anywhere in the constant, so its bytes are
invariant across suite versions by construction, which is exactly the
fixed-content file the clause excepts. Note what this clause does **not** claim:
it excuses the stamp ("carries no stamp to verify by") and says nothing about
how the file's fidelity is verified. The weaker claim is the true one here, and
it holds. (The stronger verified-by-exact-content claim lives in
`decision:per-project-pinning`; this cycle's fix delivered it, and that audit
now finds it satisfied.)

Every one of the eighteen is a whole-file write: bash `>` redirects, python
`open(..., "w")`, and `fs.writeFileSync`. The marker's change of mechanism did
not change its kind — a `>` redirect of a subcommand's stdout is the same
wholesale overwrite the `printf` redirect was, and `moduleMarkerCmd` itself
touches no filesystem at all (`process.stdout.write` and exit), so the binary
gained no new write site. No core reads-modifies-writes an existing target, and
none carries merge or marker logic. Enforcement is
mechanical, not merely observed: `checks/owned-paths` walks each core and fails
on any redirect, `cp`/`mv`, `rm`, `writeFileSync`, `rmtree`/`rmSync` target
outside that family's declared owned set. For the planner the allowance is a
path *prefix* (`"${OK_DIR}/` plus the family's own cheatsheet), not a
remembered member list, so the new `bin/source-graph` redirect is admitted by
construction while anything outside the estate is still a finding — and the
check further asserts exactly one python write site outside the consent path.
On the plumbline side the same shape holds: the core's admitted redirect targets
are the prefix `.ok-plumbline/` and the family's own cheatsheet, so the marker's
new redirect is inside the enforced set by construction and by prefix, not by
remembered membership; and the binary's `fs.writeFileSync` first arguments are
still exactly the three declared names. It exits 0 on this tree. Honored.

**Choice clause 2 — "It never edits a file a human also edits; the consumer's
own rules file and memory file are categorically untouchable."** Grepping the
cores for memory- and rules-file paths returns only `.ok-planner/CLAUDE.md` —
the estate's own suite-owned guide, whose administration document states
plainly that it is not a user-customization surface and that project-specific
guidance belongs in the project's root `CLAUDE.md`. No core references the
consumer's root memory file or a hand-owned `.claude/rules/` file; the only
things written under `.claude/rules/` are the three families' own cheatsheets.
The sharpest case is ok-workspaces, whose worktree ignore file is written at a
*profile-declared* path: the core resolves the declared prefix against the
repository root and refuses outright — before writing anything — when it
resolves to the root itself, on the stated ground that covering it would mean
writing the project's own `.gitignore`. `owned-paths` pins that guard by
requiring the resolution, the derivation, and the in-repo gate to all be
present. The integration contract states the prohibition normatively. Honored.

**Choice clause 3 — "Ownership decides consent: suite-owned files converge
silently."** The cores prompt for nothing: converge is a straight
materialization run, and on a compliant project a git-level no-op — the
administration harness commits the converged estate, converges a third time,
and asserts `git status --porcelain` is empty, then asserts diagnose is clean.
Run this cycle: both pass, over an estate that now includes
`.ok-planner/bin/source-graph`. Honored.

**Choice clause 4 — "the suite's own retired-layout content is suite territory,
migrated mechanically under the administration's own authorization."** The
planner's administration document opens its migration section with "no consent
prompt: driving the administration is itself the authorization to migrate the
suite's own retired layouts", and states that the migrations are mechanical —
files move between directories, contents are not rewritten, `history/`
preserves the record — with the explicit instruction to leave moved files'
contents alone. The cores enact the machine-checkable part: retired vendored
payloads and retired estate payloads are removed on converge, and the harness
seeds a retired merged verb before pass 1 and asserts it is gone afterwards.
Honored.

**Choice clause 5 — "anything else at a path the suite cares about — hand-written
overlaps, preexisting guidance the suite would now govern, or a genuine
collision between an earlier layout and the current one — is presented for the
owner's decision."** The administration document carries the overlapping-context
scan and requires proposing a conversion plan for the owner's consent, forbidding
silent conversion, editing, moving, or deletion; the one genuine old-vs-new
collision case stops for the owner rather than overwriting. The contract states
the same rule. Honored.

**Choice clause 6 — "and owner-declared configuration, hook wiring in the
project's committed harness settings included, is written only as transcription
of explicit answers."** The planner core's settings write is confined to the
`wire-hooks` branch, which transcribes exactly the entry diagnose printed and
exits; `owned-paths` asserts that every `json.dump` and every python write site
lies inside that branch, asserts the equivalent for the plumbline binary's
`settingsPath` writes, and forbids the plumbline and workspaces converge
scripts from mentioning `settings.json` at all. The harness confirms
behaviourally: converge alone leaves `.claude/settings.json` absent, and only
`wire-hooks` creates it, with the exact `startup|clear|compact` matcher.
Honored.

**Rationale capability claim — "Whole-file ownership is what makes silent
convergence safe and drift correction trivial — overwrite, never merge."**
Exercised rather than asserted: the harness drifts a suite-owned file
deliberately, confirms diagnose reports it read-only and non-zero, then confirms
converge repairs it by overwrite. Honored.

**Alternatives — managed sections, silent adoption of overlaps, consent-gating
the suite's own migration.** All three are genuine roads not taken, and the
second and third are explicitly negated in the administration document.

## Determination

**satisfied.** All three converge cores write whole files only — eighteen write
targets enumerated from the cores themselves, seventeen version-stamped and the
eighteenth the fixed-content module marker the clause excepts by name — within
per-family owned sets a maintenance check enforces by path prefix rather than by
remembered membership, which is why both `.ok-planner/bin/source-graph` and the
marker's re-mechanised write land inside the guarantee rather than beside it.
The marker's move from an inline `printf` to a redirect of the binary's
`module-marker` output changes the source of its bytes, not their wholesale
delivery; it introduces no read-modify-write and no new filesystem write site.
The consumer's rules and memory files are never referenced, and the
one write that could reach a human-owned file is refused before anything is
written. The suite's own retired layouts migrate mechanically under the
administration's authorization with bodies untouched; overlapping and colliding
non-suite content is routed to an owner decision by documented procedure; and
the harness settings file is reachable only through a consent-transcription
path, verified both by the check and by a live converge that leaves the file
absent.

This stops holding if: a core gains a write target outside its declared owned
set, or a settings write appears outside the `wire-hooks` branch (the
`cite-span` on that branch, the `cite-file` on the check, and the whole-file
pins on all three cores break); a core begins editing rather than replacing a
file, or acquires merge/marker logic; a second unstamped write target appears
that is not fixed content, or the module marker starts varying with the suite
version (the `cite:` lines on its canonical constant and on the core's
`module-marker` redirect break); the workspaces root-prefix refusal
is dropped; `.ok-planner/CLAUDE.md`'s regeneration rule is softened into
edit-preservation; the migration section starts asking consent for the suite's
own layout, or stops being body-preserving; or the overlapping-context proposal
requirement is dropped so preexisting guidance could be converted silently.

## Notes

- note: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md and admin/converge (source-graph-certification sprint) add `bin/source-graph` as a new materialized artifact and a new member of the owned-paths enumeration ("Does not write outside the owned set: ... `bin/audit-check`, `bin/source-graph`, ..."); the existing `cite:` lines on ADMINISTRATION.md are existence-only and untouched by this addition, and the `cite-span` on converge's owned-writing branch is a different function than the one materializing the new binary, so citation staleness did not catch this new population member — the checker `checks/owned-paths` was not part of this change, so whether it still mechanically enumerates the full owned set (now including `bin/source-graph`) is exactly what this audit needs to check.
  adjudication: promoted — the nominated territory is now covered three ways, and the note's question is answered in the affirmative: `checks/owned-paths` enumerates the planner's owned set as a path *prefix* (`"${OK_DIR}/`), not as a remembered member list, so the new redirect is inside the enforced set by construction. Citations now carried: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4` (the new materialize block itself), `cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "  \`bin/audit-check\`, \`bin/source-graph\`, the retired payloads it"` (the owned-set prose line naming the new member), and `cite-file:` whole-file pins on all three converge cores as the population source for the write-target quantifier — so the next write target added to any core breaks this audit mechanically rather than needing a judged nomination.

## Citations

- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-file: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-file: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-file: checks/owned-paths @ sha256:12cd569528fb
- cite: checks/owned-paths :: "# @decision: whole-file-ownership"
- cite-span: checks/owned-paths :: "def check_planner():" +42 sha256:d501e1c65a4a
- cite-span: checks/owned-paths :: "def check_workspaces():" +44 sha256:17bde30421b6
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "if mode == "wire-hooks":" +26 sha256:4fffaff9b3de
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function moduleMarkerCmd() {" +5 sha256:3fcc2ceea20c
- cite-span: checks/owned-paths :: "def check_plumbline():" +36 sha256:38b29a68e4aa
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "// @decision: whole-file-ownership" +11 sha256:06926cb2acd7
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "  `bin/audit-check`, `bin/source-graph`, the retired payloads it"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "no consent prompt: driving the administration is itself the"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "migrations below are mechanical: files move between directories,"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Leave the moved files' contents alone."
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "propose a conversion plan for the owner's consent"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Does not preserve local edits to"
- cite: plugins/ok/skills/ok/SKILL.md :: "Does not edit any file itself"
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 2: repair after deliberate drift in a suite-owned file" +11 sha256:d54b241833e6
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 3: no-op on a compliant estate" +12 sha256:7cf01fea76ad
- cite: docs/integration-contract.md :: "nothing in the suite touches"
- cite: docs/integration-contract.md :: "presented for the owner's consent"
- cite: docs/integration-contract.md :: "Owner-declared configuration is written only as **transcription"
