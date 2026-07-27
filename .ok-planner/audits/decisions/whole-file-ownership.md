---
audit: whole-file-ownership
artifact: decision:whole-file-ownership
determination: satisfied
audited: 2026-07-27T13:30:00Z
artifact-hash: sha256:1d70b41acafa
---

# Does the suite's machinery own only whole regenerable files, never edit human-edited files, converge its own layer silently, and reach everything else through the owner's consent?

## Claims

**Title + Choice clause 1 — "The suite's machinery — the front door's
administration and every family's converge core — owns whole files only:
version-stamped, deterministically regenerable, overwritten wholesale."** The
population is the front door plus three converge cores, enumerated from
`plugins/ok/families/`. The front door writes nothing itself and says so
explicitly — all writes happen inside the families' cores — so the checkable
population is those three. Each core writes by full replacement: the planner's
bash half redirects rendered templates over their targets and its python half
opens each vendored file `"w"` and writes the whole rendered body;
ok-plumbline's core redirects the rendered cheatsheet, binary, and hook;
ok-workspaces' `converge.js` writes each target with `fs.writeFileSync`. No
core reads-modifies-writes an existing file and none carries merge or marker
logic. The maintenance check `owned-paths` enumerates the write sites per
family and fails on any target outside each family's declared owned set, on any
deletion not rooted in it, and — for the planner — on any python write site
outside the vendoring loop other than the consent path. Honored.

**Choice clause 2 — "It never edits a file a human also edits; the consumer's
own rules file and memory file are categorically untouchable."** Grepping the
cores for `CLAUDE.md` and `rules.md` returns only `.ok-planner/CLAUDE.md` —
the estate's own suite-owned guide, whose administration document states
plainly that it is not a user-customization surface and that project-specific
guidance belongs in the project's root `CLAUDE.md`. No core references the
consumer's root memory file or `.claude/rules/rules.md`; the only file written
under `.claude/rules/` is each family's own cheatsheet. The contract states the
prohibition normatively. Honored.

**Choice clause 3 — "Ownership decides consent: suite-owned files converge
silently."** The cores prompt for nothing: converge is a straight
materialization run and, on a compliant project, a git-level no-op — the
administration harness converges a fourth time after committing and asserts an
empty `git status`. Honored.

**Choice clause 4 — "the suite's own retired-layout content is suite territory,
migrated mechanically under the administration's own authorization."** The
planner's administration document opens its migration section with "no consent
prompt: driving the administration is itself the authorization to migrate the
suite's own retired layouts", and states that the migrations are mechanical —
files move between directories, contents are not rewritten, `history/`
preserves the record, and archived records keep their old wording. The cores
enact the machine-checkable part: retired vendored payloads and retired estate
payloads are removed by the core, and the harness asserts the retired merged
verb is gone after converge. Honored.

**Choice clause 5 — "anything else at a path the suite cares about — hand-
written overlaps, preexisting guidance the suite would now govern, or a genuine
collision between an earlier layout and the current one — is presented for the
owner's decision."** The administration document carries the overlapping-context
scan and requires proposing a conversion plan for the owner's consent with three
named outcomes, forbidding silent conversion, editing, moving, or deletion; the
one genuine old-vs-new collision case stops for the owner rather than
overwriting. The contract states the same rule. Honored.

**Choice clause 6 — "and owner-declared configuration, hook wiring in the
project's committed harness settings included, is written only as transcription
of explicit answers."** The planner core's settings write is confined to the
`wire-hooks` branch, which transcribes exactly the entry diagnose printed and
exits; `owned-paths` asserts that every `json.dump` and every settings write
site lies inside that branch, and asserts the equivalent for the plumbline
binary's `settingsPath` writes while forbidding the plumbline and workspaces
converge scripts from mentioning `settings.json` at all. The harness confirms
behaviourally: converge alone leaves `.claude/settings.json` absent, and only
`wire-hooks` creates it. The contract's ownership rule states the transcription
requirement, and ok-workspaces' profile walkthrough follows the same shape.
Honored.

**Rationale capability claim — "Whole-file ownership is what makes silent
convergence safe and drift correction trivial — overwrite, never merge."**
Exercised: the harness drifts a suite-owned file deliberately, confirms
diagnose reports it read-only and non-zero, then confirms converge repairs it
by overwrite. Honored.

## Determination

**Satisfied.** All three converge cores write whole files only, within
per-family owned sets a maintenance check enforces mechanically; the consumer's
rules and memory files are never referenced, let alone written; the suite's own
retired layouts migrate mechanically under the administration's authorization
with bodies untouched; overlapping and colliding non-suite content is routed to
an owner decision by documented procedure; and the harness settings file is
reachable only through a consent-transcription path, verified both by the check
and by a live converge that leaves the file absent.

This stops holding if: a core gains a write target outside its declared owned
set, or a settings write appears outside the `wire-hooks` branch (the
`cite-span` on that branch and the `cite-file` on the check both break); a core
begins editing rather than replacing a file, or acquires merge/marker logic;
`.ok-planner/CLAUDE.md`'s regeneration rule is softened into
edit-preservation; the migration section starts asking consent for the suite's
own layout, or stops being body-preserving; or the overlapping-context proposal
requirement is dropped so preexisting guidance could be converted silently.

## Citations

- cite-file: checks/owned-paths @ sha256:12cd569528fb
- cite: checks/owned-paths :: "# @decision: whole-file-ownership"
- cite-span: checks/owned-paths :: "def check_planner():" +42 sha256:d501e1c65a4a
- cite-span: checks/owned-paths :: "def check_workspaces():" +44 sha256:17bde30421b6
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "if mode == "wire-hooks":" +26 sha256:4fffaff9b3de
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "no consent prompt: driving the administration is itself the"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "migrations below are mechanical: files move between directories,"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Leave the moved files' contents alone."
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "propose a conversion plan for the owner's consent"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "Does not preserve local edits to"
- cite: plugins/ok/skills/ok/SKILL.md :: "Does not edit any file itself"
- cite-span: plugins/ok/test/administration.sh :: "# --- Consented wiring: the wire-hooks path is the only settings writer" +6 sha256:3e3a46428c08
- cite-span: plugins/ok/test/administration.sh :: "# --- Pass 2: repair after deliberate drift in a suite-owned file" +11 sha256:d54b241833e6
- cite: docs/integration-contract.md :: "nothing in the suite touches"
- cite: docs/integration-contract.md :: "presented for the owner's consent"
- cite: docs/integration-contract.md :: "Owner-declared configuration is written only as **transcription"
