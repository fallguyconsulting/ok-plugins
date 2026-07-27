---
audit: edit-hook-blocks-in-turn
artifact: decision:edit-hook-blocks-in-turn
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:4db61a4d4286
---

# Does lint enforcement run as a post-edit hook that blocks in-turn, scoped to changed lines for tracked files, failing open on every hook error?

## Claims

**1. Title / Choice — "Lint enforcement runs as a post-edit hook."** The
wiring the family transcribes into a project's settings is a `PostToolUse`
entry with matcher `Edit|Write` running
`node "$CLAUDE_PROJECT_DIR/.ok-plumbline/hooks/post-edit.js"`. The same entry
object is the single source for wiring, for the wiring-diagnosis, and for the
block the administration prints for the owner's consent — there is no second
definition to drift from. Honored.
`cite-span: … bin/plumbline "const HOOK_ENTRY = {" +10`,
`cite: … bin/plumbline "  const post = (hooks.PostToolUse = hooks.PostToolUse || []);"`.

**2. Choice — "blocks the agent in the same turn on violations."** The hook
spawns the lint synchronously and, on the lint's violation exit code (2),
writes the lint's stdout *and* stderr to the agent-visible channel and exits 2
itself — the PostToolUse contract for feeding a message back and blocking
rather than merely logging. Nothing is deferred, queued, or written to a
report file. The harness asserts the whole shape, not just the code: a fresh
violation on a changed line exits 2 *and* the captured stderr carries the
file, the line number (`legacy.py:3:`), the rule (`plumbline/comment-hygiene`)
and the human message (`comment is not permitted`). Honored.
`cite-span: … post-edit.js "function blockWithViolationsOnAgentVisibleChannel(result) {" +5`,
`cite-span: … post-edit.js "function main() {" +33`,
`cite-span: … test/run.sh "run_message_proof() {" +52`.

**3. Choice — "but only within the edited file's changed line ranges for
tracked files."** Tracking is decided by `git ls-files --error-unmatch`; for a
tracked file the hook takes `git diff -U0 HEAD -- <file>`, parses the `+`
hunk headers into ranges, drops zero-count (pure-deletion) hunks, and passes
`--lines <ranges>` to the lint, which filters its violations to those ranges.
When the parse yields no ranges at all (nothing changed against HEAD) the hook
exits 0 without running the lint. Harness: a pre-existing violation on an
untouched line passes (exit 0) while a violation on a changed line blocks
(exit 2), in the same file, in the same repo. Honored.
`cite-span: … post-edit.js "function getChangedLineRanges(repoRoot, file) {" +16`,
`cite-span: … bin/plumbline "function lintCmd(targets, opts) {" +19`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`.

**4. Choice — "(untracked files checked whole)."** `ls-files --error-unmatch`
exits non-zero for an untracked path, the range function returns `null`, and
the `null` branch appends no `--lines` flag — so the lint sees the whole file.
Harness: a brand-new untracked file carrying a violation blocks (exit 2).
Honored.
`cite-span: … post-edit.js "function main() {" +33`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`.

**5. Choice — "with every hook failure path (missing input, no repository, no
vendored binary, spawn error) degrading to a silent pass."** Quantifier, with
the population named in the parenthetical. I enumerated the *actual* exit
points from reality — every `process.exit` in the hook, all of which live in
the pinned file — and there are eight: unparseable/absent stdin JSON → 0;
absent or non-existent `file_path` → 0; no `.git` ancestor → 0; target outside
the resolved root → 0; no binary at `../bin/plumbline` → 0; empty changed-range
set → 0; `spawnSync` error → 0; and the tail after a non-blocking lint status
→ 0. Exactly one path is not 0: lint status === 2, the genuine finding. Nothing
is written on any of the eight — the only writes in the file are inside the
blocking function. The four paths the Choice names are each exercised by the
harness as its own case (`fail-open: missing input`, `fail-open: no
repository`, `fail-open: no vendored binary`, `fail-open: spawn error`), all
asserting exit 0. Honored.
`cite-file: … post-edit.js` (population pin),
`cite-span: … post-edit.js "function main() {" +33`,
`cite-span: … test/run.sh "run_hook_harness() {" +43`.

**6. Rationale capability claim — "the check can only ever block on genuine
findings, never break a session."** Follows from claim 5's enumeration: the
hook has no error exit at all, and a lint internal error (exit 1, e.g. a
malformed config) falls through the `status === 2` test to exit 0 rather than
surfacing as a hook failure. Honored.
`cite-span: … post-edit.js "function main() {" +33`.

## Determination

**satisfied.** All five normative clauses hold against the hook as it stands:
it is a `PostToolUse`/`Edit|Write` entry, it blocks in-turn by exiting 2 with
the violation text on the agent-visible channel, it scopes to git-derived
changed ranges for tracked files and to the whole file for untracked ones, and
every one of its eight exit points other than the genuine-finding branch is a
silent 0. The harness exercises each clause as a separate assertion and the
whole suite is green.

One edge deserves recording so a later reader is not surprised. If a file *is*
tracked but `git diff -U0 HEAD` itself fails — realistically only in a
repository with a staged file and no commits yet — the range function returns
`null` and the file is checked whole, exactly as an untracked file is. That is
not a session-breaking path (the hook still exits 0 or blocks on a real
violation), and it is not one of the four failure paths the Choice enumerates;
it is a fall-back to a stricter-but-still-genuine check. The Choice's promise —
never break a session, only ever block on findings — survives it.

This stops holding if: the hook gains any non-zero exit other than the
`status === 2` branch, or writes to stdout/stderr outside the blocking
function; the `--lines` flag stops being passed for tracked files (or the lint
stops filtering on it), making pre-existing debt block unrelated edits; the
`null`-range branch starts skipping untracked files instead of checking them
whole; or the settings entry moves off `PostToolUse`/`Edit|Write`, at which
point enforcement is no longer in-turn.

## Citations

- cite-file: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:b5b86e505257
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  const post = (hooks.PostToolUse = hooks.PostToolUse || []);"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621
