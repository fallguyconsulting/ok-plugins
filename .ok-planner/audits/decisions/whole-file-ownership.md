---
audit: whole-file-ownership
artifact: decision:whole-file-ownership
determination: satisfied
audited: 2026-07-28T18:00:00Z
artifact-hash: sha256:3c3d07cc3841
---

# Does the suite's machinery own only whole regenerable files — stamped save for a fixed-content one — never edit human-edited files, converge its own layer silently, and reach everything else through the owner's consent?

## Claims

**Why this is a re-audit, and what moved.** The design artifact is unchanged
(hash identical to the previous cycle), so prior determinations bind absent
moved reality. This cycle's staleness is a direct consequence of what the
*previous* pass of this very audit found: it recorded, prominently, that
`checks/owned-paths`' `cp`/`mv`/`rm` regexes never matched the browser
build's `rm -rf`/`cp -R` write, and separately that the placed build carried
no version stamp to verify by. A certification fixer closed both gaps this
cycle, entirely inside clause 1's territory, and both are re-tested from
scratch rather than assumed fixed: `checks/owned-paths` gained a
flag-stripping, quote-aware `check_bash_file_ops` that replaces the old
positional `cp`/`mv`/`rm` regexes in both `check_planner()` and
`check_plumbline()`; `admin/converge` gained a `browser_stamp()` function
that writes a `.build-stamp` file beside the placed build (suite version
plus a digest over every placed byte), and diagnose now distinguishes
missing / unstamped / stale / drifted for that member the same way
`check_rendered` does for every sed-substituted sibling. Nothing else in
clause 1's population moved: the write-target count is still twenty-one, the
plumbline module marker's mechanism is unchanged from last cycle, and the
previous cycle's adjudicated note on `bin/source-graph` is carried forward
verbatim.

**Title + Choice clause 1 — "The suite's machinery — the front door's
administration and every family's converge core — owns whole files only:
version-stamped — save for a fixed-content file … — deterministically
regenerable, overwritten wholesale."** The population is the front door plus
every family converge core, enumerated from `plugins/ok/families/` (three:
ok-planner, ok-plumbline, ok-workspaces). The front door writes nothing itself
and says so in its own body — every write happens inside a family core — so the
checkable population is those three, each pinned whole below as the enumeration
source for the write targets. Read out of the cores rather than out of the
decision's wording, the write targets are **twenty-one**, up from eighteen:

- ok-planner (10, up from 7): `.ok-planner/CLAUDE.md`, `.claude/rules/ok-planner-cheatsheet.md`,
  `.ok-planner/scripts/surface-corpus`, `.ok-planner/bin/audit-check`,
  `.ok-planner/bin/source-graph`, **now also `.ok-planner/bin/proof-timings`
  and `.ok-planner/bin/corpus-view`** (same `sed`-substituted redirect, chmod'd
  755, each carrying the `{{OK_PLANNER_VERSION}}` placeholder its payload
  source stamps), `.ok-planner/hooks/session-start`, **and the estate's own
  new `.ok-planner/.gitignore`** (same shape again) — each a whole-file
  redirect — plus the vendored skill files, written by the python half with
  `open(path, "w")` over a wholly re-rendered body. **And now also
  `.ok-planner/browser/`**, the corpus view's release-built frontend, written
  by an unconditional `rm -rf "${OK_DIR}/browser"` followed by
  `cp -R "${BROWSER_BUILD}/." "${OK_DIR}/browser/"` — read directly rather than
  through the checker (see below): a full-directory delete-then-copy, the same
  never-edit, always-regenerate shape as every other member, and rooted inside
  the declared `${OK_DIR}/` prefix by construction. `.ok-planner/bin/source-graph`
  is the member the *previous* cycle added; its payload source carries the
  `{{OK_PLANNER_VERSION}}` placeholder, so the materialized copy is stamped
  like its siblings.
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

Twenty of twenty-one carry a version — up from nineteen this cycle, now that
the browser build carries one via its companion stamp file (below).
`.ok-plumbline/package.json` is the sole remaining exception — its bytes are
now a single named constant in the family binary
(`const MODULE_MARKER = '{ "type": "commonjs" }\n'`) that an emit-only
`module-marker` subcommand writes to stdout and the core redirects into place
— no version interpolation anywhere in the constant, so its bytes are
invariant across suite versions by construction, which is exactly the
fixed-content file the clause excepts. Note what this clause does **not**
claim: it excuses the stamp ("carries no stamp to verify by") and says nothing
about how the file's fidelity is verified. The weaker claim is the true one
here, and it holds for the marker. (The stronger verified-by-exact-content
claim — not merely that a stamp exists, but that it is checked — lives in
`decision:per-project-pinning`, a separate decision with its own audit; the
previous cycle's version of that audit charged the browser build precisely
because it then had no stamp to check. That audit's own redetermination
against the fix described below is that audit's business, not this one's —
recorded here only because the same code change bears on both.)

**`.ok-planner/browser/`, the twenty-first member, is no longer the
exception the previous cycle recorded.** Last cycle's audit found it
genuinely neither stamped nor the named fixed-content exception — its bytes
are the compiled Svelte build, explicitly release-variant by the repo's own
`/release` procedure, so there was no invariant-content excuse either. That
gap is closed this cycle, verified by reading the mechanism rather than
assumed: `admin/converge` now writes a companion
`.build-stamp` file into the placed build — `browser_stamp()` walks every
file under the build directory (skipping the stamp file itself), hashes each,
and prints a line naming "Materialized by ok-planner v<version>" plus a
combined `build-sha256:` digest — and diagnose reads that same function
against both the carried and the placed build to distinguish four states:
`missing:` (no stamp file at all), `stale:` (the placed build's stamp
doesn't match a fresh hash of the *carried* build — wrong version), and
`drifted:` (the placed build's stamp doesn't match a fresh hash of the
*placed* build — corrupted in place), each a distinct `DRIFT:` finding. This
is the same fidelity guarantee `check_rendered`'s `cmp` gives every
sed-substituted sibling, expressed as a digest because the build is a
directory of generated bytes rather than one rendered template, not a weaker
substitute for it. So the twenty-first member now carries a stamp to verify
by, on the same terms as the other twenty — this decision's own clause 1
text ("version-stamped — save for a fixed-content file") is now honored
without qualification for all twenty-one members, not twenty of them plus
one excepted-by-necessity. Whether the *checking* is now adequate in the
stronger sense `decision:per-project-pinning` stakes out is that decision's
own question to re-settle, not this one's.

Every one of the twenty-one is, on direct reading, a whole-file write: bash
`>` redirects, `rm`+`cp` pairs, python `open(..., "w")`, and
`fs.writeFileSync`. The marker's earlier change of mechanism did not change
its kind — a `>` redirect of a subcommand's stdout is the same wholesale
overwrite the `printf` redirect was — and the browser build's
`rm -rf "${OK_DIR}/browser"` followed by `cp -R "${BROWSER_BUILD}/."
"${OK_DIR}/browser/"` is the same shape again: full delete, full re-copy, no
partial edit, rooted at a literal `${OK_DIR}/` path. No core
reads-modifies-writes an existing target, and none carries merge or marker
logic.

**Enforcement is now mechanical for all twenty-one, and I re-derived that
rather than trusting the fixer's own description of the fix.** The previous
cycle's finding was specific and testable: `checks/owned-paths`' `cp`/`mv`
pattern required exactly one token between the command and its two path
arguments, so `cp -R "$SRC" "$DST"` — three tokens after `cp` — never
matched, and its `rm` pattern required the literal flag `-f`, so `rm -rf
"$PATH"` never matched either — in-prefix or not, in either case, which is
why the browser build's two lines were invisible to the checker rather than
approved by it. `checks/owned-paths` now carries a replacement,
`check_bash_file_ops`, called from both `check_planner()` (with the planner's
`"${OK_DIR}/` prefix) and `check_plumbline()` (with the plumbline prefix and
its one named exemption); the old function-local regexes are gone from both
call sites. Read on its own terms, the new function first strips leading
flag tokens (anything starting with `-`) from a `cp`/`mv`/`rm`/`rmdir`
invocation's arguments before testing the remainder against the owned
prefix, rather than counting tokens positionally — which is exactly the
shape that made `-R` and `-rf` invisible before. I did not take that reading
on faith: I extracted `check_bash_file_ops` and ran it standalone against
the real lines (`rm -rf "${OK_DIR}/browser"`, `cp -R "${BROWSER_BUILD}/."
"${OK_DIR}/browser/"` — no finding, correctly, since both are in-prefix) and
against out-of-prefix analogues in the same shape and flag style
(`rm -rf "/tmp/evil"`, `cp -R "$X" "/tmp/evil/"`, plus `mv` and `rmdir`
variants) — all four out-of-prefix cases were flagged, all two real lines
were not. I then ran `checks/owned-paths` itself, unmodified, against this
tree: exit 0, no findings, over a core that does write those two lines. The
"mechanical, not merely observed" characterization this audit lost last
cycle is restored — for both the browser build specifically and, because the
fix is a shared function rather than a browser-build special case, for any
future `cp`/`mv`/`rm`/`rmdir` write in either core regardless of which flags
it carries.

On the plumbline side the same replacement landed — `check_plumbline()` now
calls `check_bash_file_ops` with the prefix `.ok-plumbline/` and the one
named exemption (`.claude/skills/true-up`, the retired merged verb's
removal) in place of its own old `mv`/`rm -rf` regexes, which had the same
positional blind spot. The marker's redirect (unchanged this cycle) is still
inside the enforced set by construction and by prefix, not by remembered
membership, and the binary's `fs.writeFileSync` first arguments are still
exactly the three declared names. `checks/owned-paths` exits 0 on this tree
for the plumbline core too. Honored.

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

**satisfied.** All three converge cores write whole files only — twenty-one
write targets enumerated from the cores themselves (up from eighteen: two new
stamped support scripts, a new stamped estate `.gitignore`, and a new
frontend build), twenty version-stamped — up from nineteen, now that the
browser build carries its own via a companion `.build-stamp` file digesting
every byte it places — and one (the plumbline module marker) the
fixed-content exception the clause names. Both members that stood out from
the guarantee last cycle are back inside it this cycle, and I re-verified
both rather than carrying the fix forward on description: the browser
build's stamp file, and diagnose's fidelity check against it (missing /
unstamped / stale / drifted), are real in `admin/converge` as read; and
`checks/owned-paths`' new `check_bash_file_ops` genuinely flags an
out-of-prefix `cp -R`/`rm -rf`/`mv`/`rmdir` in the same shape the browser
build uses, tested directly against both the real lines and synthetic
out-of-prefix analogues, not inferred from the diff.

Within-owned-set enforcement is mechanical for all twenty-one write
targets now, restored from nineteen of twenty-one last cycle —
`checks/owned-paths` enforces by path prefix rather than remembered
membership for every write shape the three cores use, including the
`cp`/`rm` pair the previous cycle found invisible to it. The mechanism that
produced last cycle's finding — this audit's own whole-file citation pin on
`admin/converge` and on `checks/owned-paths`, either of which goes stale on
any edit and forces a fresh adversarial read — is also what forced this
cycle's re-verification rather than a rubber-stamped carry-forward, and it
remains the backstop against a future regression in either file.

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
`cite-span` on that branch, the `cite-node` on the check, and the whole-file
pins on all three cores break); a core begins editing rather than replacing a
file, or acquires merge/marker logic; a second unstamped write target appears
that is neither fixed content nor covered by a verified stamp mechanism, or
the module marker starts varying with the suite version (the `cite:` lines on
its canonical constant and on the core's `module-marker` redirect break);
`check_bash_file_ops` regresses to missing a flagged `cp`/`mv`/`rm`/`rmdir`
invocation — a new flag combination it does not strip, or a write shape
neither it nor `check_bash_redirects` parses — which is exactly the failure
mode this cycle closed and the one most worth re-testing on any future edit
to that function, not just reading; the browser build's stamp stops being
written, or diagnose stops checking it against both the carried and the
placed build; the workspaces root-prefix refusal is dropped;
`.ok-planner/CLAUDE.md`'s regeneration rule is softened into
edit-preservation; the migration section starts asking consent for the
suite's own layout, or stops being body-preserving; or the
overlapping-context proposal requirement is dropped so preexisting guidance
could be converted silently.

## Notes

- note: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md and admin/converge (source-graph-certification sprint) add `bin/source-graph` as a new materialized artifact and a new member of the owned-paths enumeration ("Does not write outside the owned set: ... `bin/audit-check`, `bin/source-graph`, ..."); the existing `cite:` lines on ADMINISTRATION.md are existence-only and untouched by this addition, and the `cite-span` on converge's owned-writing branch is a different function than the one materializing the new binary, so citation staleness did not catch this new population member — the checker `checks/owned-paths` was not part of this change, so whether it still mechanically enumerates the full owned set (now including `bin/source-graph`) is exactly what this audit needs to check.
  adjudication: promoted — the nominated territory is now covered three ways, and the note's question is answered in the affirmative: `checks/owned-paths` enumerates the planner's owned set as a path *prefix* (`"${OK_DIR}/`), not as a remembered member list, so the new redirect is inside the enforced set by construction. Citations now carried: `cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4` (the new materialize block itself), `cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "  \`bin/audit-check\`, \`bin/source-graph\`, the retired payloads it"` (the owned-set prose line naming the new member), and `cite-file:` whole-file pins on all three converge cores as the population source for the write-target quantifier — so the next write target added to any core breaks this audit mechanically rather than needing a judged nomination.

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: checks/owned-paths @ sha256:7e57eb4f6daf
- cite: checks/owned-paths :: "# @decision: whole-file-ownership"
- cite-span: checks/owned-paths :: "def check_bash_file_ops(label, text, allowed, exempt=()):" +26 sha256:e2f9ecbfd07e
- cite-span: checks/owned-paths :: "def check_planner():" +33 sha256:1d92c27bc526
- cite-span: checks/owned-paths :: "def check_plumbline():" +32 sha256:1ff463abf607
- cite-span: checks/owned-paths :: "def check_workspaces():" +44 sha256:17bde30421b6
- cite: checks/owned-paths :: "check_bash_file_ops(label, text, ('"${OK_DIR}/',))"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "# Materialize the audit-corpus checker and the source-graph" +13 sha256:4064d7f971f4
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "if mode == "wire-hooks":" +26 sha256:4fffaff9b3de
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function moduleMarkerCmd() {" +5 sha256:3fcc2ceea20c
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "// @decision: whole-file-ownership" +11 sha256:06926cb2acd7
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "  `bin/proof-timings`, `bin/corpus-view`, `browser/`, the retired payloads it"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "rm -rf "${OK_DIR}/browser"" +5 sha256:471b3cb09341
- cite: plugins/ok/families/ok-planner/admin/converge :: "cp -R "${BROWSER_BUILD}/." "${OK_DIR}/browser/""
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "browser_stamp() {  # browser_stamp <build-dir>" +20 sha256:922c852a93d9
- cite: plugins/ok/families/ok-planner/admin/converge :: "browser_stamp "$BROWSER_BUILD" > "${OK_DIR}/browser/${BROWSER_STAMP_NAME}""
- cite: plugins/ok/families/ok-planner/admin/converge :: "findings+=("unstamped: .ok-planner/browser/ carries no build stamp, so which version's build it is cannot be told")"
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
