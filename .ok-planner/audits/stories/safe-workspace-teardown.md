---
audit: safe-workspace-teardown
artifact: story:safe-workspace-teardown
determination: satisfied
audited: 2026-07-27T13:20:17Z
artifact-hash: sha256:22d234b6b9ae
---

# Does closing a workspace really gate on a clean tree and a remote-resolved merge — and does the proof show both gates holding?

## Claims

**1. "the clean-tree gate and the merged-branch gate are checked first."**
The close verb puts both gates under a heading that states the ordering as a
precondition ("all must pass before any teardown"), and the teardown section repeats it
("only after both gates pass"). Gate 1 is porcelain status emptiness. There is no
ordering in the verb by which a teardown step is reachable before both gates.
Honored.

**2. "against the branch the remote actually treats as the integration branch, never a guess, unless the owner names another."**
Gate 2 resolves the integration branch by asking the remote for its symbolic HEAD and
stripping the ref prefix, with a stated fallback to the local default branch only when
there is no remote — and the fallback must be reported. The "unless the user names
another" escape is stated in the same sentence.
Honored.

**3. "a failing gate stops the close with exactly what is dirty or unmerged, the fix being the owner's act in that workspace."**
Gate 1 stops and reports the dirty paths, explicitly assigning the fix to the owner
("the fix ... is the owner's act in that workspace, never this skill's"). Gate 2 stops
and says what remains unmerged, with merge-or-abandon named as the owner's next act
before a re-run.
Honored.

**4. "the job's runtime is torn down scoped to its own namespace."**
Prompt-realized: compose teardown carries the per-workspace project-name flag and the
verb states that the flag is what scopes it "to this workspace's stack and nothing
else"; `dev-server` has nothing persistent to stop and the verb explicitly refuses to
kill a listening process, only to report it; `none` skips.
Honored.

**5. "the worktree is removed and the branch deleted using only non-forcing commands that themselves fail if the gates lied."**
Quantifier "only". Population: every teardown command the family issues, enumerated by
sweeping the whole family directory for a worktree-removal or branch command carrying
the forcing flag, the short forcing flag, or the uppercase delete. The only
teardown-related hits are the two non-forcing forms in the close verb (each naming the
forcing form in order to forbid it) and the family constraint that forbids adding such a
path; every other worktree-or-branch command in the family is non-forcing, and I read the
harness occurrences to confirm it. Both population sources pinned by cite-file. The
"themselves fail" half is exercised, not asserted: the demo requires the non-forcing
removal to fail on a dirty worktree and the lowercase deletion to fail on an unmerged
branch.
Honored.

**6. "the report names the merge commit the work survives in."**
The final teardown step names the merge commit, plus leftovers the owner should know
about. The demo captures the merge commit and proves it is an ancestor of HEAD after the
close, which is what makes it locatable by a third party (it printed
`12371511a9a1…` on my run).
Honored.

**7. "Only the user's explicit 'close it anyway, discard the work' overrides a gate, and then exactly that and nothing broader."**
Stated verbatim as the sole override, with self-judgment bypass forbidden in the same
sentence ("Never bypass a gate on your own judgment").
Honored.

**8. Proof: "a close attempt on a workspace with uncommitted changes stopping at the first gate with the dirty paths named, followed by a clean, merged workspace closing completely, with a third party able to locate the surviving merge commit."**
One annotated proof artifact — `rg -l '@story:safe-workspace-teardown'` outside
`.ok-planner/` and `.claude/skills/` returns exactly the family demo, pinned by
cite-file. Read whole and run here: exit 0. It runs **the gate itself**, not only its
backstop: it dirties a file in a live worktree, runs porcelain status, asserts the output
is non-empty and that it *names the dirty path*, then asserts the non-forcing removal
also refuses. For gate 2 the sandbox stands up a bare origin whose HEAD is
`integration`, resolves the branch with the exact remote query the verb prescribes, and
asserts twice — that the resolved name is `integration`, and that it is *not* `main` — so
a guessing implementation would fail the harness rather than pass by luck. It then
asserts the unmerged branch is neither listed as merged nor deletable, merges, re-asserts
the merged gate, closes both workspaces with the non-forcing commands, and proves the
merge commit is an ancestor of HEAD. The harness states explicitly that the verb's prose
is the prompt-realized half and the commands under it are what it executes.
Honored.

## Determination

**satisfied.** Every Acceptance conjunct has a citable enforcement point in the close
verb — the executable substance of a prompt-driven verb — and the non-forcing-only claim
survives a family-wide enumeration that finds no forcing path anywhere, only its
prohibition in three places. The proof does not infer the gates from their backstops: it
runs the clean-tree gate and asserts the dirty path is named, and it resolves the
integration branch from a remote deliberately set to a name that is not the obvious
guess, which is the story's most distinctive commitment and its sharpest falsifier. Both
are exercised deterministically and both held when I ran the demo in this tree.

The proof file grew a new section this cycle (a converge-refusal case belonging to a
different decision), inserted ahead of the close-gate sections. It adds coverage and
removes none: every gate assertion this story rests on is still present and still ran,
and the sandbox state the gates run against is unchanged.

The runtime-teardown conjunct (claim 4) is the one that stays prompt-realized: no harness
stands up a container stack, so what stands behind "scoped to its own namespace" is the
project-name flag written into the verb and the reasoning printed beside it. The story's
`Proof:` field does not name it, so this is scope rather than a gap.

This stops holding if: either gate's stated precondition is weakened or reordered after
teardown; the integration-branch resolution stops reading the remote's symbolic HEAD (or
the fallback stops being reported); a forcing form appears in the teardown steps or the
family constraint forbidding it is dropped; the compose teardown loses its project-name
scoping; or the demo's sandbox loses its non-`main` bare origin, its dirty-path
assertion, its unmerged-branch refusals, or its ancestry check on the merge commit.

## Citations

- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "## Gates — all must pass before any teardown"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "1. **Clean tree.** `git -C <worktree> status --porcelain` must be empty."
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "   integration=$(git ls-remote --symref origin HEAD | awk '/^ref:/ {sub("refs/heads/","",$2); print $2}')"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "Never bypass a gate on your own judgment."
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "## Teardown — only after both gates pass"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "1. **Stop the runtime.** `runtime: "docker-compose"`:"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "2. **Remove the worktree.** `git worktree remove <dirPrefix><job>` (never `--force`"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "3. **Delete the branch.** `git branch -d <branchPrefix><job>` (`-d`, not `-D`"
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "4. **Report.** What was torn down, the merge commit the work survives in,"
- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md @ sha256:81ff352d2b1d
- cite: plugins/ok/families/ok-workspaces/CLAUDE.md :: "- `open`/`close` are safety-first: close's gates (clean tree, merged branch) are load-bearing"
- cite-node: plugins/ok/families/ok-workspaces/CLAUDE.md @ sha256:da5173b0d811
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "# @story: safe-workspace-teardown"
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Close gate 1: the clean-tree gate, with the dirty paths named ---------" +14 sha256:aeafcc31716e
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Close gate 2: the integration branch comes from the remote ------------" +16 sha256:881f90ac8f34
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Teardown after both gates pass ----------------------------------------" +12 sha256:2ae698ee3dcf
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:04d3e5220cac
