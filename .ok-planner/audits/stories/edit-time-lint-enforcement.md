---
audit: edit-time-lint-enforcement
artifact: story:edit-time-lint-enforcement
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:f49b67f53973
---

# Does an agent edit in an integrated project get checked and blocked in-turn on its changed lines, by the project's own pinned binary, never breaking the session?

## Claims

**1. Story — "every agent edit checked … the moment it lands."** The check is
wired as a `PostToolUse` entry matching `Edit|Write`, i.e. it fires after the
tool call that wrote the file and before the agent's turn continues. The
project-side hook script is what that entry runs. Honored.
`cite-span: … bin/plumbline "const HOOK_ENTRY = {" +10`.

**2. Acceptance conjunct — "violations within the changed line ranges block
with the violation message in the same turn, so the agent fixes before
proceeding."** The hook derives the changed ranges from git, passes them to the
lint as `--lines`, and on the lint's violation exit code writes the lint's
stdout and stderr to the agent-visible channel and exits 2. The proof asserts
the *message*, not just the block: after a fresh disallowed comment is appended
to a committed file, the captured stderr carries `legacy.py:3:`,
`plumbline/comment-hygiene` and `comment is not permitted`, with exit 2 —
which is exactly what makes the fix free while the edit is still in hand.
Honored.
`cite-span: … post-edit.js "function main() {" +33`,
`cite-span: … post-edit.js "function blockWithViolationsOnAgentVisibleChannel(result) {" +5`,
`cite-span: … test/run.sh "run_message_proof() {" +52`.

**3. Acceptance conjunct — "edits clean in their changed ranges pass even when
the rest of the file carries older violations."** The lint filters its
violation list to the passed ranges before reporting, so a pre-existing
violation outside the diff is invisible to the hook. Proven twice: the harness
case (`violation on untouched line passes`, exit 0) and the demo assertion
(`a clean edit passes while an older violation stands elsewhere in the file`)
— both on a file whose line 1 violation is committed and untouched.
Honored.
`cite-span: … bin/plumbline "function lintCmd(targets, opts) {" +19`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`,
`cite-span: … test/run.sh "run_message_proof() {" +52`.

**4. Acceptance conjunct — "untracked files are checked whole."**
`git ls-files --error-unmatch` fails for an untracked path, the range function
returns `null`, and the `null` branch appends no `--lines` flag. Harness: a new
untracked file with a violation blocks (exit 2). Honored.
`cite-span: … post-edit.js "function getChangedLineRanges(repoRoot, file) {" +16`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`.

**5. Acceptance conjunct — "every hook failure path degrades to silence — the
check never breaks a session."** Quantifier; population enumerated from reality
as every `process.exit` in the hook (all in the pinned file): eight exits, of
which seven are silent 0s (unparseable stdin, absent/non-existent
`file_path`, no `.git` ancestor, target outside the root, missing binary, empty
range set, `spawnSync` error) plus the silent 0 tail after a non-blocking lint
status; exactly one is non-zero, the genuine-finding branch. The hook has no
error exit at all, and a lint internal error (exit 1) falls through to 0. Four
of these are exercised as named harness cases, and the demo additionally
asserts *silence* rather than merely exit 0 for the missing-binary path
(`[ -z "$out" ]`). Honored.
`cite-file: … post-edit.js` (population pin),
`cite-span: … post-edit.js "function main() {" +33`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`.

**6. Acceptance conjunct — "The project's own pinned lint binary, not the
installed plugin's, performs the check."** The hook resolves its binary
strictly relative to its own location — `<project>/.ok-plumbline/hooks/` →
`<project>/.ok-plumbline/bin/plumbline` — with no `PATH` lookup, no
`CLAUDE_PLUGIN_ROOT` fallback, and no payload path anywhere in the file. The
falsifier's third clause ("the check runs at a version other than the
project's pinned one") is therefore closed by construction, and the demo makes
it observable: with the vendored binary deleted the hook goes silent instead of
reaching for another copy. Honored.
`cite: … post-edit.js "  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');"`,
`cite-span: … test/run.sh "run_message_proof() {" +52`.

**7. Proof field — "Demo — in an integrated project, an edit introducing a
disallowed comment is blocked in-turn while a clean edit to a file with old
violations passes, and disabling the vendored binary shows the session degrade
to silence rather than error."** The proof harness is annotated
`@story: edit-time-lint-enforcement` at the top of the file and again above the
demo function; it builds a real integrated project (git repo with a commit,
`.ok-plumbline/{bin,hooks,config.json}`, the hook rendered from the family's
template) and drives the hook through its actual stdin JSON contract. All three
demo clauses are exhibited, plus a fourth the story's Acceptance implies but
does not name — an extensionless script is checked by its shebang rather than
skipped. Run in full at audit time: 45 assertions, all green, exit 0.
Honored.
`cite-span: … test/run.sh "run_message_proof() {" +52`,
`cite-file: … test/run.sh` (population pin for which conjuncts the harness
exercises).

## Determination

**satisfied.** Every Acceptance conjunct is realized in the hook and exercised
by the annotated proof, and the proof spans the Proof field rather than a
subset of it: block-with-message, changed-range scoping against a dirty file,
untracked-whole, all four named fail-open paths (with silence, not just exit
0, asserted for the vendored-binary case), and the pinned-binary requirement
made observable by the deletion case. The falsifier is closed clause by
clause: a violating edit does not land silently (claim 2), pre-existing
violations elsewhere do not block (claim 3), the check cannot run at a
non-pinned version (claim 6), and no hook path errors out (claim 5).

The one thing the harness necessarily substitutes for is a live agent: "blocks
the agent in the same turn" is exhibited as exit code 2 plus the violation text
on the channel the agent receives, which is the deterministic surrogate for the
PostToolUse contract. A third party watching the harness sees the block and the
message; they do not see a model react to it. That is the right line for a
deterministic proof and the assertion names the channel explicitly.

This stops holding if: the hook resolves its binary anywhere other than
relative to its own directory (a payload or `PATH` fallback would break claim
6 and the falsifier with it); `--lines` stops being passed or honored, so
old debt blocks unrelated edits; the `null`-range branch starts skipping
untracked files; any exit point in the hook becomes non-zero outside the
`status === 2` branch, or any of them starts writing output; or the settings
entry moves off `PostToolUse`/`Edit|Write`, at which point the check is no
longer in-turn.

## Citations

- cite-file: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:b5b86e505257
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "  const binary = path.resolve(__dirname, '..', 'bin', 'plumbline');"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite-file: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:c144bbb9094b
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621
