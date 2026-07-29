---
audit: edit-hook-blocks-in-turn
artifact: decision:edit-hook-blocks-in-turn
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:4db61a4d4286
---

# Does lint enforcement run as a post-edit hook that blocks in-turn, scoped to changed lines for tracked files and whole for untracked, with every failure path a silent pass?

Amended again, this pass by a refresh dispatch. The design artifact's hash
is unchanged and no note is open. The one stale item is the `cite-node:`
pin on `runLint` itself, which now fails to resolve in the committed graph
— not because `runLint` moved or was renamed (read directly: same
signature, same body, same line count, at the same place in the file) but
because unrelated edits elsewhere in this cycle's binary (the CI-template
and `explain`-topic changes the change inspector's note below already
covers) evidently confuse the graph extractor's structural walk past that
point in the file — the extractor now also fails to resolve several other
functions declared after that same region, none of them cited by any
audit. This is a graph-extraction gap, not a decision violation and not
this audit's territory to fix (`decision:deterministic-source-graph` owns
that machinery); the honest response here is to stop pinning through a
node identity that cannot currently be resolved and cite the same span by
anchor instead, which needs no graph. Re-read `runLint` directly against
this claim's text below to confirm the citation form change carries no
substantive change: it still calls `checkCommentHygiene` and
`checkCitationResolution` exactly as read at the last amendment, and the
Notes ledger's promoted adjudication — which names the `cite-node:` form —
is carried forward verbatim as the historical record of that promotion,
per the rule against rewriting recorded adjudications; only the live
Citations entry changes form.

## Claims

**Why this is a re-audit, and what moved.** The decision is unchanged (hash
identical), and nothing here went mechanically stale — every cited node, span
and anchor still resolves. The audit is open because certification's change
inspector nominated it: the lint binary's two check functions had their inline
violation-code string literals replaced by named constants, and this audit's
cited `lintCmd` reaches those functions through `runLint`, so the violation
objects fed to the blocking mechanism are produced by code the change touched.
That note is adjudicated below (promoted). The hook implementation is
byte-unchanged this cycle — `git diff` reports no hunks in it — so the exit-path
enumeration and the ESM guard's exhibit stand as precedent under the rule that a
demonstration is re-paid only when a citation it rests on moves.

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
Both cases are green on this tree. Honored.

**Choice (quantified) — "with every hook failure path (missing input, no
repository, no vendored binary, spawn error) degrading to a silent pass."** The
population was re-enumerated from the hook implementation read whole (pinned
below) rather than from the decision's own parenthetical, because the
parenthetical names four and the file contains **nine**. In order: a failure
loading the standard-library modules at the top of the file; unparseable stdin;
absent or non-existent `file_path`; no enclosing git repository; target outside
the repository root; no binary at the vendored path; a tracked file with zero
changed ranges; spawn error; and a binary status other than the blocking code.
All nine take a zero exit and none of them writes to stderr, so the pass is
silent as well as non-blocking. The single non-zero exit in the file is the
deliberate block.

The module-load path was established by exhibit in the cycle that added it, and
stands here as precedent because nothing it rests on moved. Under a consumer root
declaring `"type": "module"`, node loads the materialized hook as ESM, `require`
is undefined, and the top-level requires throw at load time; a real fixture
converged under such a root, with the estate's module marker deleted so the hook
was genuinely ESM-scoped, exits 0 with empty output, while the same fixture with
the guard reverted to plain top-level `const` requires exits 1 with a `file:///…`
module error on stderr. The four the Choice names are each still exercised by a
named harness case, the proof asserts the missing-binary path produces empty
output, and the ESM case holds the ninth from both sides — all green this cycle.
Honored — and honored more widely than the parenthetical claims.

**Title clause 3 — "and never breaks a session."** Follows from the clause
above: the only path to a non-zero exit is a filtered-non-empty violation list
from the binary. A lint internal error (the binary's own non-blocking failure
status) is explicitly not forwarded, and a module-load failure is caught rather
than escaping as a runtime abort.

The nominated change is a fresh candidate counterexample to this clause and I
checked it as one rather than dismissing it on the diff's face. Replacing a
string literal inside a function with a module-scope `const` declared *below*
that function creates a temporal-dead-zone hazard: a call reaching the check
functions during module evaluation would throw a `ReferenceError`, and a lint
that crashes is an infrastructure failure the hook forwards as a non-zero spawn
result — except that it does not, because a spawn error and a non-blocking status
both exit zero, so the worst case is a silently skipped check rather than a
broken session. Independently, the hazard does not exist: I enumerated every
top-level statement in the binary and the only top-level *invocation* is `main()`
on the last line, with every route to `checkCommentHygiene` /
`checkCitationResolution` running through `runLint` under it. Honored.

**Rationale — "Blocking in-turn is the only moment the fix is free — the agent
sees the message with the edit still in hand."** The capability claimed is that
the agent actually receives the violation text, not merely a refusal. The hook
writes both of the binary's streams to stderr before the blocking exit; the
message's content is assembled from the violation object's `file`, `line`, `code`
and `message` by one formatter, and the `code` field is exactly what this cycle's
change rewrote. Re-exhibited rather than assumed: a throwaway repository linted
directly returns `f.js:2: plumbline/comment-hygiene: comment is not permitted …`
at exit 2, and through the hook the harness's message case asserts the received
text contains the file, the line number and the literal rule code against a
converged fixture — green on this tree. The constants carry byte-identical values
and the formatter is untouched, so the received line is unchanged. Honored, and
the production side of that text is now cited rather than reachable only through
`lintCmd`.

**Rationale — "Scoping to the change keeps pre-existing debt from blocking
unrelated work."** Proven by the harness case that edits a clean line of a file
carrying a committed violation and asserts a zero exit. Honored.

**Rationale — "failing open on infrastructure errors means the check can only
ever block on genuine findings."** Equivalent to the quantified claim above,
which the enumeration confirms over the full exit-path population — including
the module-load path, the one infrastructure error that until a prior cycle did
not fail open. Honored.

## Determination

**satisfied.** Enforcement is a `PostToolUse` hook that blocks with the
violation text in the same turn, narrows to the edited file's changed ranges for
tracked files and lints untracked files whole, and returns a silent zero on
every one of the nine exit paths the implementation contains — a superset of the
four the Choice enumerates. Decisions carry no proof obligation, but the family
harness exercises the scoping, the four named fail-open paths, the ESM load
failure and the message content deterministically, and was run for this audit
green. This cycle's nominated change to how the violation code is spelled is
inert against every clause: identical values, untouched formatter, no
dead-zone path, and the received message re-exhibited end to end.

This stops holding if: the settings entry moves off `PostToolUse` or its
implementation stops exiting with the blocking status; a failure path is added
that returns non-zero or writes to stderr on an infrastructure error, or the
module-loading guard is removed (the whole-file pin catches any edit to the
hook, and the span pin on the guard breaks first); the trackedness test or the
`--lines` argument is dropped, so whole-file results start reaching the block;
the binary stops filtering by the supplied ranges; or the violation objects stop
carrying a rule code, or the emitted line stops rendering one, so the block
arrives without the text the Rationale's "the fix is free" rests on (the
`cite-node:` on `runLint` and the `cite:` lines on the two code constants and the
formatter's template break).

## Citations

- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "let fs, path, spawnSync;" +8 sha256:f324a0faed9c
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_ENTRY = {" +10 sha256:4f5e5fa2be68
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "const BLOCKING_EXIT_CODE = 2;"
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function blockWithViolationsOnAgentVisibleChannel(result) {" +5 sha256:c0311453066c
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function getChangedLineRanges(repoRoot, file) {" +16 sha256:0a36d1e9980a
- cite-span: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "function main() {" +33 sha256:f17d1ea1d5ae
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function lintCmd(targets, opts) {" +19 sha256:859ca542950b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target) {" +18 sha256:5d204f7417f4
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_COMMENT_HYGIENE = 'comment-hygiene';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_CITATION_UNRESOLVED = 'citation-unresolved';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  return `${v.file}:${v.line}: plumbline/${v.code}: ${v.message}`;"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_hook_harness() {" +43 sha256:3e40133fbad3
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_esm_root_case() {" +45 sha256:d84ba811094f
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_message_proof() {" +52 sha256:8c51ae91f621

## Notes

- note: bin/plumbline's `checkCommentHygiene`/`checkCitationResolution` had their inline violation-code string literals ('comment-hygiene', 'citation-unresolved') replaced by named constants `CODE_COMMENT_HYGIENE`/`CODE_CITATION_UNRESOLVED` (same corpus-browser-and-ruled-intake change that added `CHECK_CODES`/`explainCmd` topic listing for story:explain-lint-rules) — this decision's cited `lintCmd` span calls `runLint`, which calls both check functions directly, so the violation objects fed to the blocking mechanism are produced by code this change touched, even though the values appear unchanged.
  adjudication: promoted — the nomination names real uncovered territory: the Rationale's "the agent sees the message" rests on the emitted text, and nothing between the check functions and `lintCmd` was cited, so a change to an emitted rule code moved no hash here. Now carried under Citations as `cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#runLint @ sha256:c4fd8a6c4b80`, `cite: … :: "const CODE_COMMENT_HYGIENE = 'comment-hygiene';"`, `cite: … :: "const CODE_CITATION_UNRESOLVED = 'citation-unresolved';"`, and `cite: … :: "  return \`${v.file}:${v.line}: plumbline/${v.code}: ${v.message}\`;"`. The change itself does not move the determination: the constants carry byte-identical values, the formatter is untouched, the temporal-dead-zone hazard the refactor could have introduced does not exist (the binary's only top-level invocation is `main()` on the last line), and even a crash there would fail open rather than break a session.
