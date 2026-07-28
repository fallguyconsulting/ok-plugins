---
audit: edit-hook-blocks-in-turn
artifact: decision:edit-hook-blocks-in-turn
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:4db61a4d4286
---

# Does lint enforcement run as a post-edit hook that blocks in-turn, scoped to changed lines for tracked files and whole for untracked, with every failure path a silent pass?

## Claims

**Title clause 1 — "The edit hook blocks in-turn."** The wiring the family
transcribes into the project's settings is a `PostToolUse` entry with matcher
`Edit|Write`, so the hook runs immediately after the tool call that made the
edit, inside the same turn. The hook's only non-zero exit is the harness's
blocking status, taken after it writes the lint's stdout and stderr to stderr —
the channel the agent receives. Honored.

**Title clause 2 / Choice — "scoped to changed lines."** Before invoking the
binary the hook computes the file's added-side hunk ranges against `HEAD` and
passes them as `--lines`; the binary filters its violation list to those ranges
before deciding whether to exit non-zero. Scoping is applied at the point that
decides the block, not merely in the report. Honored.

**Choice — "but only within the edited file's changed line ranges for tracked
files (untracked files checked whole)."** Trackedness is decided by
`git ls-files --error-unmatch`; failure returns a null range set, and a null
range set means the `--lines` argument is never appended, so the whole file is
linted. A tracked file whose diff yields zero ranges exits zero without running
the binary at all. The harness proves both halves: a violation in an untracked
file blocks, and a violation on an untouched line of a tracked file does not.
Honored.

**Choice (quantified) — "with every hook failure path (missing input, no
repository, no vendored binary, spawn error) degrading to a silent pass."** The
population was enumerated from the hook implementation read whole (pinned below)
rather than from the decision's own parenthetical, because the parenthetical
names four and the file now contains **nine** — one more than the eight of the
previous cycle. In order: a failure loading the standard-library modules at the
top of the file; unparseable stdin; absent or non-existent `file_path`; no
enclosing git repository; target outside the repository root; no binary at the
vendored path; spawn error; a binary status other than the blocking code; and a
tracked file with zero changed ranges. All nine take a zero exit and none of
them writes to stderr, so the pass is silent as well as non-blocking.

The ninth is new this cycle and I refused to take it on the diff's word. Under a
consumer root declaring `"type": "module"`, node loads the materialized hook as
ESM, `require` is undefined, and the top-level requires throw at load time. I
converged a real fixture under such a root, deleted the estate's module marker
so the hook was genuinely ESM-scoped, and ran it: exit 0, empty output. I then
reverted the guard to plain top-level `const` requires in the same fixture and
re-ran: exit 1 with a `file:///…` module error on stderr. So before this cycle
the decision's "never breaks a session" had a live counterexample, and the guard
is what closes it. The four the Choice names are each still exercised by a named
harness case, the proof asserts the missing-binary path produces empty output,
and the ESM case holds the ninth from both sides. Honored — and honored more
widely than the parenthetical claims.

**Title clause 3 — "and never breaks a session."** Follows from the clause
above: the only path to a non-zero exit is a filtered-non-empty violation list
from the binary. A lint internal error (the binary's own non-blocking failure
status) is explicitly not forwarded, and a module-load failure is now caught
rather than escaping as a runtime abort. Honored.

**Rationale — "Blocking in-turn is the only moment the fix is free — the agent
sees the message with the edit still in hand."** The capability claimed is that
the agent actually receives the violation text, not merely a refusal. The hook
writes both of the binary's streams to stderr before the blocking exit, and the
proof asserts the received text contains the file, the line number and the rule
code — which I re-exhibited against a converged fixture this cycle. Honored.

**Rationale — "Scoping to the change keeps pre-existing debt from blocking
unrelated work."** Proven by the harness case that edits a clean line of a file
carrying a committed violation and asserts a zero exit. Honored.

**Rationale — "failing open on infrastructure errors means the check can only
ever block on genuine findings."** Equivalent to the quantified claim above,
which the enumeration confirms over the full exit-path population — including
the module-load path, the one infrastructure error that until this cycle did not
fail open. Honored.

## Determination

**satisfied.** Enforcement is a `PostToolUse` hook that blocks with the
violation text in the same turn, narrows to the edited file's changed ranges for
tracked files and lints untracked files whole, and returns a silent zero on
every one of the nine exit paths the implementation contains — a superset of the
four the Choice enumerates. The ninth path, the module-loading guard, was
verified by exhibit: with it the hook is silent under an ESM-scoped consumer
root, without it the same fixture exits non-zero with module noise. Decisions
carry no proof obligation, but the family harness exercises the scoping, the
four named fail-open paths, and the ESM load failure deterministically, and runs
green as of this audit.

This stops holding if: the settings entry moves off `PostToolUse` or its
implementation stops exiting with the blocking status; a failure path is added
that returns non-zero or writes to stderr on an infrastructure error, or the
module-loading guard is removed (the whole-file pin catches any edit to the
hook, and the span pin on the guard breaks first); the trackedness test or the
`--lines` argument is dropped, so whole-file results start reaching the block;
or the binary stops filtering by the supplied ranges.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "let fs, path, spawnSync;" +8 sha256:f324a0faed9c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "const BLOCKING_EXIT_CODE = 2;"
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_esm_root_case() {" +45 sha256:d84ba811094f
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621
