---
audit: teardown-gates-in-git-flags
artifact: decision:teardown-gates-in-git-flags
determination: satisfied
audited: 2026-07-27T13:20:17Z
artifact-hash: sha256:207d23beff27
---

# Are the teardown commands the non-forcing forms, with no force path anywhere in the family?

## Claims

**1. Title / Choice: "Workspace close verifies its two gates (clean tree, merged branch) and then tears down."**
The ordering is stated twice in the close verb — the gates sit under a heading declaring
them a precondition of any teardown, and the teardown section is headed as conditional
on both passing. Gate 1 is porcelain emptiness; gate 2 is containment in the
remote-resolved integration branch. The teardown steps are numbered under that second
heading, so there is no path through the verb that reaches a removal before both gates.
Honored.

**2. "using only the non-forcing forms: worktree removal without force, and lowercase branch deletion that refuses unmerged work."**
Quantifier "only". Population: every command in the family that removes a worktree or
deletes a branch. Enumerated from reality by sweeping the whole family directory for a
worktree-removal or branch command bearing the forcing flag, the short forcing flag, or
the uppercase delete. The sweep returns exactly three lines, all of them prohibitions:
the two teardown steps, each naming the forcing form solely in order to forbid it, and
the family constraint that forbids adding one. Every other worktree-or-branch command in
the family — twenty-odd, all in the two harnesses — is a non-forcing form; I read the
harness occurrences to confirm none is a disguised force. Both population sources
(the close verb and the family constraint file) pinned by cite-file.
Honored.

**3. "Forcing flags and forced deletion are never added; a force 'need' means a gate lied, and the response is stop and re-check."**
Each teardown step carries that reasoning inline — the removal step says a force need
means gate 1 lied and directs a stop and re-check; the deletion step says the lowercase
form succeeds only because gate 2 passed. The family constraint states the prohibition
as a standing rule rather than a one-off, so a future session reaching for `--force`
meets a written refusal before it meets the command.
Honored.

**4. Rationale: "the teardown physically cannot complete against a dirty tree or unmerged branch."**
This is a capability claim about the commands, and it is exercised rather than asserted.
The family demo — which carries an `@decision: teardown-gates-in-git-flags` annotation
at the site where it exercises the backstop — dirties a file in a live worktree and
requires the non-forcing removal to fail, commits unmerged work on a job branch and
requires the lowercase deletion to fail, then re-runs both successfully once the tree is
clean and the branch is merged. I ran the demo here to completion (exit 0); both
directions held.
Honored.

**5. Rationale: "a worktree is the only record of its uncommitted work" / "checks-over-discipline applied inside a prompt-driven verb."**
Consistent with the shape: the safety property is carried by the choice of command, so
it survives a session that reasons badly about the gates — which is exactly what the
demo demonstrates by removing the prompt from the loop entirely and running the raw
commands. The same instinct is recorded as the family's own standing constraint.
Honored.

## Determination

**satisfied.** Both teardown commands are the non-forcing forms, each annotated in place
with the reason its forcing counterpart is excluded, and a family-wide enumeration finds
no forcing path anywhere — the only teardown-related matches are the two prohibitions
and the constraint that forbids adding one. The rationale's operative claim, that the
commands themselves refuse when a gate would have lied, is exercised in both directions
by the annotated demo, which I ran to completion in this tree.

One placement I looked at and am not treating as grounds: the `@decision:` annotation
sits on the demo's backstop assertions rather than on the close verb itself. The verb is
prompt text, not code, and it carries the prohibition in prose at both teardown steps, so
a reader chasing the decision reaches an enforcement site either way and the navigation
the annotation exists for works. Nothing in the family's write path issues a teardown
command at all, so there is no code site the annotation is missing from.

This stops holding if: a forcing flag appears on either teardown command, or a fallback
path is added that reaches for one when the non-forcing form fails; the gates are moved
after teardown or made advisory; the family constraint forbidding force paths is
removed; or the demo stops requiring the dirty-worktree removal and the unmerged-branch
deletion to fail.

## Citations

- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "## Gates — all must pass before any teardown"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "## Teardown — only after both gates pass"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "1. **Clean tree.** `git -C <worktree> status --porcelain` must be empty."
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "2. **Remove the worktree.** `git worktree remove <dirPrefix><job>` (never `--force`"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "3. **Delete the branch.** `git branch -d <branchPrefix><job>` (`-d`, not `-D`"
- cite-file: plugins/ok/families/ok-workspaces/skills/close/SKILL.md @ sha256:81ff352d2b1d
- cite: plugins/ok/families/ok-workspaces/CLAUDE.md :: "- `open`/`close` are safety-first: close's gates (clean tree, merged branch) are load-bearing"
- cite-file: plugins/ok/families/ok-workspaces/CLAUDE.md @ sha256:da5173b0d811
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "# @decision: teardown-gates-in-git-flags"
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Close gate 1: the clean-tree gate, with the dirty paths named ---------" +14 sha256:aeafcc31716e
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Close gate 2: the integration branch comes from the remote ------------" +16 sha256:881f90ac8f34
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Teardown after both gates pass ----------------------------------------" +12 sha256:2ae698ee3dcf
- cite-file: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:04d3e5220cac
