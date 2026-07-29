---
audit: edit-time-lint-enforcement
artifact: story:edit-time-lint-enforcement
determination: satisfied
audited: 2026-07-28T22:40:00Z
artifact-hash: sha256:f49b67f53973
---

# Does an agent edit get blocked in-turn on violations in its changed lines, with pre-existing debt spared, untracked files checked whole, every failure path silent, and the project's pinned binary doing the work?

## Claims

**Why this is a re-audit, and what moved.** The story is unchanged (hash
identical to the last two cycles), so its determinations bind absent moved
reality. Nothing here went mechanically stale this cycle: every cited node,
span, anchor and file pin still resolves. The audit is open because
certification's change inspector nominated it — the lint binary's two check
functions had their inline violation-code string literals replaced by named
constants, and this audit's cited `lintCmd` reaches those functions through
`runLint`, so the objects the blocking hook consumes are produced by code the
change touched. That note is adjudicated below (promoted), and the claims it
implicates were re-derived from the tree rather than carried.

The hook implementation itself is byte-unchanged this cycle — `git diff` against
the last commit reports no hunks in it, and its whole-file pin plus every span
over it still resolve — so the nine exit paths, the binary resolution and the
ESM guard stand by recorded precedent. Under the same rule the ESM
guard-reversion exhibit from the previous cycle is not re-paid: the citations it
rests on (the hook's whole-file pin, the span on the module-load guard, the
`module-marker` redirect in the converge core, the canonical constant in the
binary) are all byte-identical. What was re-exhibited is the message content
claim, because that is what the change touched.

**A second, citation-only pass this cycle.** `audit-check` reports the
`cite-node: …#runLint` citation this audit's Notes ledger added last pass no
longer resolves in the committed graph — not because `runLint` moved or was
renamed (`grep -n 'function runLint' bin/plumbline` still finds it, unmoved,
at the same declaration it always was), but because the graph's JS extractor
mis-parses this file: the committed mirror shows only 43 of the file's 63
`function` declarations as nodes, several genuine top-level functions
(`runLint`, `lintCmd`, `explainCmd` among them) missing outright and others
folded as bogus children of `parseCitations` — an extraction defect, not a
structural change, and `source-graph check` reports no drift because the
same defective extractor produced the committed mirror in the first place.
This is outside this audit's charter to fix (the source graph is its own
tooling, not this story's claim), so the citation is downgraded from a
graph-node pin to a direct content anchor, which resolves correctly against
the file text regardless of the extractor's structure-detection: `cite-span:
plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target)
{" +16 sha256:3179b4bc7d47`. The function's body is confirmed byte-identical
to what the promoted note's citation covered (`git diff HEAD` over this file
shows no hunk touching it), so the claim the citation carries — every route
to the two check functions runs through `runLint`, which only `main()`
reaches — stands exactly as adjudicated last pass.

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
channel the harness feeds back to the agent.

The clause's second half — *with the violation message* — is where the nominated
change lands, and it is a real sub-claim rather than restatement: the message is
what makes the block actionable in-turn. Its content is assembled from the
violation object's `file`, `line`, `code` and `message` fields by a single
formatter, and the `code` field is exactly what the change rewrote — from two
inline string literals inside the two check functions to two named constants
declared at module scope. I refused to take the diff's word that this is inert
and checked three things from reality.

First, the values. Both constants are declared with the same bytes the literals
carried (`'comment-hygiene'`, `'citation-unresolved'`), and the formatter is
untouched, so the rendered line is byte-identical.

Second, the initialization order, because a constant is not a literal: the two
`const` declarations sit *below* both check functions in the file, so a call
reaching them during module evaluation would throw on the temporal dead zone and
turn a lint run into a crash — an infrastructure error the falsifier's fourth
limb names. I enumerated every top-level statement in the binary rather than
assuming: the only top-level *invocation* in the file is `main()` on the last
line, and every path to `checkCommentHygiene` / `checkCitationResolution` runs
through `runLint`, which the subcommand table reaches only from `main`. So the
constants are always initialized before any check function is entered. There is
no dead-zone path.

Third, by exhibit rather than by reading. A throwaway git repository with one
file carrying a stray comment, linted by this binary directly, returns exit 2
with `f.js:2: plumbline/comment-hygiene: comment is not permitted …` — file,
line and rule code, unchanged. Through the hook, the family harness's message
case does the same end-to-end against a converged fixture and asserts the
received text contains `legacy.py:3:`, the literal `plumbline/comment-hygiene`,
and the rule prose; it is green on the tree as it stands. The proof therefore
pins the emitted code's *value*, not merely its presence. Honored, and the
production side of that value is now cited rather than reachable only through
`lintCmd`.

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
below), not from the story's or the decision's examples. There are **nine**,
unchanged this cycle and re-counted from the file rather than carried: a failure
loading the standard-library modules at the top of the file; unparseable stdin;
absent or non-existent `file_path`; not inside a git repository; target
resolving outside the repository root; no binary at the vendored path; a tracked
file whose diff yields zero ranges; spawn error; and a binary status other than
the blocking code (including the lint's own internal-error status). Every one of
the nine reaches a zero exit and none writes to stderr; the single non-zero exit
in the file is the deliberate block.

The module-load path is load-bearing rather than defensive dressing, established
by exhibit in the cycle that added it and standing here as precedent because
nothing it rests on moved. Under a consumer whose root package manifest declares
`"type": "module"`, the materialized hook is loaded as ESM, `require` is
undefined, and bare top-level requires throw at load. With the guard in place and
the estate's module marker deleted, the hook exits 0 and emits nothing. With the
guard reverted to plain top-level `const` requires in an otherwise identical
fixture, the same invocation exits 1 and spills a `file:///…` module error onto
stderr — a non-zero exit on an infrastructure condition, which is exactly the
falsifier's "hook malfunction interrupts the session". Five of the nine
(module-load, missing input, no repository, no vendored binary, spawn error) are
exercised by the harness, and the proof additionally asserts that the
missing-binary path is not merely non-blocking but *silent* — empty output. All
of those cases run green on this tree. Honored.

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

The estate's module marker — what makes the resolved binary and the hook loadable
as CommonJS under an ESM consumer root — is materialized by the same core into
the same path by redirecting the binary's emit-only `module-marker` output, from
a single canonical constant, and diagnose compares the result to that constant by
string equality, reporting drift or absence in an integrated estate as a `fail`
that moves the exit code. Both anchors still resolve; the fidelity case is green.

**Falsifier — "a violating edit lands silently; pre-existing violations
elsewhere in a file block an unrelated edit; the check runs at a version other
than the project's pinned one; or a hook malfunction interrupts the session."**
Each limb is negated by the clause above it, and each is exercised by a harness
case that would go red under it. The fourth limb is the one the module-load
guard closed; the nominated refactor is a fresh candidate instance of it (a
dead-zone crash would be a hook malfunction), and the enumeration above shows no
path reaches one.

**Proof — "in an integrated project, an edit introducing a disallowed comment is
blocked in-turn while a clean edit to a file with old violations passes, and
disabling the vendored binary shows the session degrade to silence rather than
error."** The registered proof is the family harness, annotated with the story
slug at file scope and at the two hook functions that carry it. It builds a real
git repository, materializes the hook from the same source converge uses, and
drives the hook over stdin exactly as the harness would. It exercises all three
Proof-field limbs plus the extensionless-shebang path and the fail-open paths,
so what it exercises spans the Acceptance. The ESM case converges a real fixture
under a `"type": "module"` root, asserts the hook loads and blocks while the
estate's module marker is present, then removes the marker and asserts the hook
exits zero with empty output — the module-load path held from both sides. A
sibling case holds the marker's own fidelity from both sides as well (drift that
still parses as `commonjs` must make diagnose non-zero; converge must restore
byte-identical content; deletion in an integrated estate must make diagnose
non-zero), which is what keeps the ESM case's premise honest. Deterministic, each
assertion fails loudly rather than skipping, and the whole harness was run for
this audit and is green.

## Determination

**satisfied.** The hook blocks with the violation text on the agent-visible
channel, scopes to changed ranges for tracked files, checks untracked files
whole, exits zero and silent on all nine enumerated failure paths, and can only
ever run the project's own vendored binary. The proof spans every Acceptance
clause, including the three — range scoping, silent degradation, and the ESM
load failure — that are the story's real content rather than its restatement.
This cycle's nominated change to how the violation code is spelled is inert
against every clause: the values are byte-identical, the formatter is untouched,
no path reaches the new constants before they initialize, and the emitted line
was re-exhibited both directly and through the hook.

This stops holding if: a new exit path is added to the hook that returns
non-zero for anything but a genuine finding, or writes to stderr on an
infrastructure error (the whole-file pin catches any edit to the hook); the
module-loading guard is removed or narrowed, so an ESM-scoped consumer breaks
the session again (the span pin on the guard breaks first); the estate's module
marker stops being materialized by converge, or its canonical bytes change so
the hook's CommonJS scoping no longer holds (the `cite:` lines on the core's
`module-marker` redirect and on the constant break); the binary resolution gains
a `CLAUDE_PLUGIN_ROOT` or `PATH` fallback; `--lines` stops filtering, or the hook
stops passing it, so whole-file results reach the block; the tracked test is
dropped so untracked files are skipped rather than checked whole; the violation
objects stop carrying a rule code, or the emitted line stops rendering one, so
the block arrives without the message that makes the fix free (the `cite:` lines
on the two code constants and on the formatter's template break, and the
`cite-span:` on `runLint` breaks on any change to how the violation list is
assembled); or the harness's hook, ESM or message cases are removed, leaving the
range scoping, fail-open behaviour and message content unexercised.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "let fs, path, spawnSync;" +8 sha256:f324a0faed9c
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "const BLOCKING_EXIT_CODE = 2;"
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function parseLineRanges(spec) {" +12 sha256:094927932a0c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target) {" +16 sha256:3179b4bc7d47
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_COMMENT_HYGIENE = 'comment-hygiene';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_CITATION_UNRESOLVED = 'citation-unresolved';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  return `${v.file}:${v.line}: plumbline/${v.code}: ${v.message}`;"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "node "$BIN" module-marker > .ok-plumbline/package.json"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MODULE_MARKER = '{ "type": "commonjs" }\n';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  const moduleMarker = path.join(repoRoot, MODULE_MARKER_REL);" +16 sha256:5be8d60618d0
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_module_marker_fidelity_case() {" +54 sha256:9989593660f5
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_esm_root_case() {" +45 sha256:d84ba811094f
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621

## Notes

- note: bin/plumbline's `checkCommentHygiene`/`checkCitationResolution` had their inline violation-code string literals ('comment-hygiene', 'citation-unresolved') replaced by named constants `CODE_COMMENT_HYGIENE`/`CODE_CITATION_UNRESOLVED` (same corpus-browser-and-ruled-intake change that added `CHECK_CODES`/`explainCmd` topic listing for story:explain-lint-rules) — this audit's cited `lintCmd` span calls `runLint`, which calls both check functions directly, so the violation objects the blocking hook consumes are produced by code this change touched, even though the values appear unchanged.
  adjudication: promoted — the inspector is right that the territory was uncovered: Acceptance clause 1 blocks *with the violation message*, and until now nothing between the check functions and `lintCmd` was cited, so a change to an emitted rule code would have moved no hash here. Now carried under Citations as `cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target) {" +16 sha256:3179b4bc7d47` (originally recorded as a `cite-node:`, downgraded to a content anchor this pass when the graph's extractor stopped resolving `#runLint` — see the citation-only pass above; the underlying claim and evidence are unchanged), `cite: … :: "const CODE_COMMENT_HYGIENE = 'comment-hygiene';"`, `cite: … :: "const CODE_CITATION_UNRESOLVED = 'citation-unresolved';"`, and `cite: … :: "  return \`${v.file}:${v.line}: plumbline/${v.code}: ${v.message}\`;"`. The change itself is inert against the determination: values byte-identical, formatter untouched, no temporal-dead-zone path (the only top-level invocation in the binary is `main()` on the last line, and every route to the check functions runs through it), and the emitted line re-exhibited both by a direct lint run and through the hook by the green message proof.
