---
audit: edit-hook-blocks-in-turn
artifact: decision:edit-hook-blocks-in-turn
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:4db61a4d4286
---

# The lint runs as a post-edit hook that blocks in-turn, scopes to changed lines, and fails open on infrastructure errors

## Confirmation

Satisfied. The materialized hook is a `PostToolUse` command over `Edit|Write`
that runs the project's pinned binary on the edited file and exits 2 with the
violation report on the agent-visible channel — the in-turn block. Everything
else it can do is exit 0 silently.

- **Scoped to changed lines for tracked files.** `git ls-files --error-unmatch`
  decides tracked; changed ranges come from `git diff -U0 HEAD` hunk headers and
  are passed as `--lines`; zero ranges exits 0 without linting. When the file is
  not tracked the range computation returns null and the whole file is checked.
  Exercised: a violation on an untouched line of a tracked file passes, the same
  file blocks once the violation is on a changed line, and a violation in an
  untracked file blocks.
- **Fail-open on every infrastructure path.** Reading the hook's exits, the
  non-violation exits are: module loading failing (the `require` block is
  wrapped and exits 0 — this is also what makes the hook silent when a `type:
  module` project root would otherwise refuse to load it), unreadable or
  unparseable event input, no `file_path` or a path that does not exist, no
  repository above the file, a path outside the resolved root, no vendored
  binary beside the hook, a spawn error, and any binary exit other than 2. Each
  of the four the decision names is exercised — empty stdin, a sandbox with no
  git repository, the vendored binary deleted, and `node` unreachable via an
  emptied `PATH` — all asserted to exit 0, with the missing-binary case also
  asserted to print nothing at all; the ESM case additionally asserts the hook
  degrades to silence (exit 0, no output) when the estate's module marker is
  removed under a `"type": "module"` root.
- **The block carries the finding.** The message proof asserts the blocking exit
  writes `legacy.py:3:`, `plumbline/comment-hygiene` and the rule message on the
  channel the agent receives, so the fix is available with the edit in hand.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js @ sha256:7e523441c46a
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#main @ sha256:c037279fc8a1
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#getChangedLineRanges @ sha256:88946b571a1a
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#blockWithViolationsOnAgentVisibleChannel @ sha256:566ada8a982f
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#lintCmd @ sha256:675a1be4712b
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  matcher: 'Edit|Write',"
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_hook_harness @ sha256:a182154ede75
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#invoke_hook @ sha256:1a2818ecedfd
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_message_proof @ sha256:0b1756d4b8ff
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_esm_root_case @ sha256:0422e4246514
