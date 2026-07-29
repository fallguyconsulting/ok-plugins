---
audit: content-addressed-artifacts
artifact: story:content-addressed-artifacts
determination: satisfied
audited: 2026-07-29T12:25:08Z
artifact-hash: sha256:148f0c403e20
---

# The artifact tag is derived from the exact working tree and is identical on every machine

## Confirmation

Satisfied.

- **Derived from the exact working tree, uncommitted changes included.**
  `src-tag` enumerates the file set with `git ls-files --cached --others
  --exclude-per-directory=.gitignore`, stages it into a temporary index copy,
  writes a tree object and prints `src-` plus its first 12 hex. No commit is
  involved anywhere in the derivation.
- **Identical on every machine.** `tags.sh` runs the script converge actually
  materializes (not the payload source) in two independently converged
  checkouts of the same tree and asserts the tags are equal — with the second
  checkout deliberately carrying a `core.excludesFile` and a
  `.git/info/exclude` that hide two untracked paths both checkouts really
  have. The harness first asserts the discriminating condition holds (git
  itself shows the paths in one checkout and hides them in the other), so an
  equal tag can only mean per-machine and per-clone ignore configuration did
  not reach the hash.
- **Sensitive to content, indifferent to ignored content, inert on the repo.**
  The same harness asserts an uncommitted edit to a tracked file changes the
  tag, that a new untracked file changes it, that appending to a
  `.gitignore`-excluded file does not, that the edit is still uncommitted
  afterwards, and that `git status` is byte-identical before and after
  tagging — the real index is never mutated.
- **Staleness unrepresentable in a verification path.** The consumer-side
  shape is exercised: a harness resolving `artifacts/app-<tag>.tar` exits
  non-zero with a "refusing to fall back" message when that artifact is
  absent, while a mutable `app-latest.tar` sits beside it untouched, and the
  same harness resolves once the tagged artifact exists. The rule that
  requires this shape is materialized into every consumer's cheatsheet by
  `converge.js` (asserted present by the harness), and whether a given
  project's real verification paths obey it is swept by the family's `audit`
  verb — checks 1 and 4, mutable tags in verification paths and unconsumed
  src-tag scripts.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "git ls-files -z --cached --others --exclude-per-directory=.gitignore |"
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "3. **Content-addressed artifacts.** Build outputs used for verification"
- cite-node: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md#audit-workspace-discipline-compliance.checks @ sha256:4a2c86c59d43
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh @ sha256:61e6ad6c8a19
