---
audit: edit-time-lint-enforcement
artifact: story:edit-time-lint-enforcement
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:f49b67f53973
---

# Does an agent edit get blocked in-turn on violations in its changed lines, with pre-existing debt spared, untracked files checked whole, every failure path silent, and the project's pinned binary doing the work?

## Claims

**Title — "Violations block the agent at edit time."** The family's edit hook is
declared as a `PostToolUse` entry matching `Edit|Write` whose command runs the
project's own materialized hook through `$CLAUDE_PROJECT_DIR`; the hook exits
with the harness's blocking code after writing the lint's output to the
agent-visible channel. Blocking, not advising, is what the code does. Honored.

**Acceptance clause 1 — "violations within the changed line ranges block with
the violation message in the same turn."** The hook computes the changed ranges,
passes them to the binary as `--lines`, and the binary filters violations to
those ranges before deciding its exit code; a filtered-non-empty result comes
back as the binary's violation exit status, which the hook forwards as its own
blocking exit after emitting both the binary's stdout and stderr on stderr — the
channel the harness feeds back to the agent. The proof asserts the emitted text
carries file, line number and rule code, not merely that the exit code was
right. Re-exhibited this cycle against a freshly converged fixture: a stray
comment came back as exit 2 with the rule code, the file and the line number on
stderr. Honored.

**Acceptance clause 2 — "edits clean in their changed ranges pass even when the
rest of the file carries older violations."** Range computation diffs the file
against `HEAD` and collects only the added-side hunks; a tracked file whose
changed hunks are clean yields no in-range violation and the hook exits zero.
The narrowing is genuine, not cosmetic: the proof commits a file carrying a
violation, then edits a different line and asserts the hook passes, and
separately asserts that adding a violating line to the same file blocks.
(The range basis is `HEAD`, so a violation introduced earlier in the same
uncommitted session still counts as changed — that is this session's residue,
not the "pre-existing debt" the falsifier protects.) Honored.

**Acceptance clause 3 — "untracked files are checked whole."** The tracked test
is `git ls-files --error-unmatch`; a non-zero status returns a null range set,
and a null range set means no `--lines` argument is appended, so the binary
lints the whole file. Proven directly by the untracked-file harness case.
Honored.

**Acceptance clause 4 (quantified) — "every hook failure path degrades to
silence — the check never breaks a session."** The population is every exit path
in the hook implementation, enumerated by reading that file whole (pinned
below), not from the story's or the decision's examples. This cycle it grew from
eight to **nine**: the module-loading guard is new. The nine are — a failure
loading the standard-library modules at the top of the file; unparseable stdin;
absent or non-existent `file_path`; not inside a git repository; target
resolving outside the repository root; no binary at the vendored path; spawn
error; a binary status other than the blocking code (including the lint's own
internal-error status); and a tracked file whose diff yields zero ranges. Every
one of the nine reaches a zero exit and none writes to stderr; the single
non-zero exit in the file is the deliberate block.

The new path is load-bearing rather than defensive dressing, which I established
by exhibit rather than by reading the diff. Under a consumer whose root package
manifest declares `"type": "module"`, the materialized hook is loaded as ESM,
`require` is undefined, and bare top-level requires throw at load. With the
guard in place and the estate's module marker deleted, the hook exits 0 and
emits nothing. With the guard reverted to plain top-level `const` requires in an
otherwise identical fixture, the same invocation exits 1 and spills a `file:///…`
module error onto stderr — a non-zero exit on an infrastructure condition, which
is exactly the falsifier's "hook malfunction interrupts the session". Five of the
nine (module-load, missing input, no repository, no vendored binary, spawn error)
are exercised by the harness, and the proof additionally asserts that the
missing-binary path is not merely non-blocking but *silent* — empty output.
Honored.

**Acceptance clause 5 — "The project's own pinned lint binary, not the installed
plugin's, performs the check."** The hook resolves its binary relative to its own
directory, one level up into `bin/` — from the materialized hook at
`.ok-plumbline/hooks/post-edit.js` that is `.ok-plumbline/bin/plumbline` and
nothing else. There is no `CLAUDE_PLUGIN_ROOT` fallback and no `PATH` lookup
anywhere in the hook, so an installed plugin copy is unreachable from it;
deleting the vendored binary produces silence rather than a fallback, which the
proof asserts. The converge core stamps the suite version into the vendored
copy, so the pinned binary is the version the project was last converged to.
Honored.

**Falsifier — "a violating edit lands silently; pre-existing violations
elsewhere in a file block an unrelated edit; the check runs at a version other
than the project's pinned one; or a hook malfunction interrupts the session."**
Each limb is negated by the clause above it, and each is exercised by a harness
case that would go red under it. The fourth limb is the one this cycle
strengthened: before the guard, an ESM-scoped consumer root was a live instance
of it. Honored.

**Proof — "in an integrated project, an edit introducing a disallowed comment is
blocked in-turn while a clean edit to a file with old violations passes, and
disabling the vendored binary shows the session degrade to silence rather than
error."** The registered proof is the family harness, annotated with the story
slug at file scope and at the two hook functions that carry it. It builds a real
git repository, materializes the hook from the same source converge uses, and
drives the hook over stdin exactly as the harness would. It exercises all three
Proof-field limbs plus the extensionless-shebang path and the fail-open paths,
so what it exercises spans the Acceptance. The ESM case added this cycle
converges a real fixture under a `"type": "module"` root, asserts the hook loads
and blocks while the estate's module marker is present, then removes the marker
and asserts the hook exits zero with empty output — the ninth path held from
both sides. Deterministic, each assertion fails loudly rather than skipping, and
the whole harness runs green as of this audit.

## Determination

**satisfied.** The hook blocks with the violation text on the agent-visible
channel, scopes to changed ranges for tracked files, checks untracked files
whole, exits zero and silent on all nine enumerated failure paths — including
the module-load path this cycle added, whose necessity I exhibited by reverting
it in a fixture and watching the hook exit 1 with module noise — and can only
ever run the project's own vendored binary. The proof spans every Acceptance
clause, including the three — range scoping, silent degradation, and the ESM
load failure — that are the story's real content rather than its restatement.

This stops holding if: a new exit path is added to the hook that returns
non-zero for anything but a genuine finding, or writes to stderr on an
infrastructure error (the whole-file pin catches any edit to the hook); the
module-loading guard is removed or narrowed, so an ESM-scoped consumer breaks
the session again (the span pin on the guard breaks first); the binary
resolution gains a `CLAUDE_PLUGIN_ROOT` or `PATH` fallback; `--lines` stops
filtering, or the hook stops passing it, so whole-file results reach the block;
the tracked test is dropped so untracked files are skipped rather than checked
whole; or the harness's hook or ESM cases are removed, leaving the range scoping
and fail-open behaviour unexercised.

## Citations

- cite-file: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "let fs, path, spawnSync;" +8 sha256:f324a0faed9c
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "const BLOCKING_EXIT_CODE = 2;"
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function parseLineRanges(spec) {" +12 sha256:094927932a0c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "printf '{ "type": "commonjs" }\n' > .ok-plumbline/package.json"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_esm_root_case() {" +45 sha256:d84ba811094f
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621
