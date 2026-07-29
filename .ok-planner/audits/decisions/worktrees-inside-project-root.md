---
audit: worktrees-inside-project-root
artifact: decision:worktrees-inside-project-root
determination: satisfied
audited: 2026-07-29T13:21:47Z
artifact-hash: sha256:92c8a2d2eb2a
---

# Worktrees default inside the project root and are covered by a suite-owned gitignore wherever the profile puts them

## Confirmation

Satisfied. Converge's three worktree-location branches are the whole
population, they are enumerated from `converge.js` itself
(`inDotDir` / `outsideRepo` / neither), and `demo.sh` exercises each one
against a real checkout, asking git rather than reading a file back.

- **The default, inside the dot-directory.** `converge.js` defaults
  `worktrees.dirPrefix` to `.ok-workspaces/worktrees/` and `detect.js`
  proposes the same; the demo creates two real worktrees there, requires
  `git check-ignore` to cover both the checkout and content inside it,
  requires `check-ignore -v` to name `.ok-workspaces/.gitignore` as the
  file that answered, and requires `git status -uall` to be empty.
- **A declared in-repo prefix outside the dot-directory.** The demo
  converges a profile pointing worktrees at `build/worktrees/`, requires
  the suite-owned `.gitignore` to appear at that prefix, adds a real
  worktree under it and requires `check-ignore -v` to name that file —
  not the dot-directory's, which cannot govern another directory. It also
  requires the ignore file itself to stay visible to the owner, deletes
  the cover and requires diagnose to call the prefix uncovered, then
  requires converge to restore it.
- **A prefix resolving outside the repository.** The demo requires the
  dot-directory ignore file to record the location and carry no ignore
  pattern, requires no `.gitignore` to be written at the outside prefix,
  creates a real checkout there and requires it never to appear as repo
  content, and requires no project source file and no unused default
  location to have become ignored as a side effect. A prefix that
  normalizes out of the root is required to take the same branch.
- **Declaration, not drift.** Diagnose is run on both non-default shapes
  and required to report `worktree-dir` as "declaration, not drift" and
  to confirm `worktree-ign` by asking `git check-ignore` itself.
- **The root gitignore is never touched.** Every one of the branches
  above compares the project's root `.gitignore` byte-for-byte
  afterwards, and a profile whose prefix resolves to the repository root
  is refused before any write, with converge naming the offending field,
  no estate materialized, and diagnose reporting the same profile as
  drift.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const inDotDir = dirPrefix.startsWith('.ok-workspaces/');"
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "if (!inDotDir && !outsideRepo) {"
- cite-node: plugins/ok/families/ok-workspaces/scripts/diagnose.js @ sha256:28bef14ec895
- cite-node: plugins/ok/families/ok-workspaces/scripts/detect.js @ sha256:361f52db19b7
- cite-node: plugins/ok/families/ok-workspaces/skills/open/SKILL.md#open-a-workspace @ sha256:7369a4181ce4
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    *) fail "the default-prefix checkout is covered by '$default_cover', not the suite-owned .ok-workspaces/.gitignore" ;;"
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge wrote no suite-owned .gitignore at the declared in-repo worktree prefix""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "diagnose does not report an uncovered in-repo worktree prefix as drift""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge did not record that the declared worktree location is outside the repository""
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "    || fail "converge edited the project's root .gitignore — a human-owned file""
- cite-node: checks/run @ sha256:e827e4abcc44
