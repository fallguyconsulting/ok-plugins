---
audit: content-addressed-src-tag
artifact: decision:content-addressed-src-tag
determination: satisfied
audited: 2026-07-29T12:25:08Z
artifact-hash: sha256:212a6df70fcb
---

# The tag is a 12-hex git tree hash of the working tree, derived through a temporary index, with the derivation frozen

## Confirmation

Satisfied.

- **The stated derivation is the implemented one.** `src-tag` copies the real
  index to a `mktemp` file, enumerates the tree with `git ls-files --cached
  --others --exclude-per-directory=.gitignore`, feeds it to `git update-index`
  under `GIT_INDEX_FILE`, writes a tree object, and prints `src-` plus the
  first 12 hex of that hash. Uncommitted changes are in; paths the
  repository's own committed ignore files exclude are out; the real index is
  untouched.
- **Nothing outside the tree reaches the hash.** The committed `.gitignore`
  files are the only exclude source, and the `update-index` call pins
  `core.excludesFile=/dev/null`, `core.attributesFile=/dev/null` and
  `core.autocrlf=false`, so per-machine and per-clone ignore configuration
  and per-machine content filters cannot participate. `tags.sh` exercises
  exactly this: two converged checkouts of the same tree, the second one
  carrying a `core.excludesFile` and a `.git/info/exclude` that git itself
  demonstrably honours (asserted), still produce the identical tag.
- **The printed shape is the frozen one.** `tags.sh` asserts the tag matches
  `src-` plus twelve hex characters.
- **POSIX shell, git only.** The script is `#!/bin/sh` and invokes `git` plus
  POSIX utilities; nothing else is required, and `tags.sh` runs the
  materialized copy directly through its own shebang rather than through a
  node or python wrapper.
- **Every consumer derives byte-identical tags for identical trees.** The two
  checkouts in `tags.sh` each get their script from `converge.js`, which
  writes the canonical payload script verbatim (version stamp substituted) at
  the profile-declared path — so agreement across consumers is agreement
  across the same bytes, exercised.
- **The derivation never changes without a major version bump.** Realized in
  prose as a family constraint.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "git ls-files -z --cached --others --exclude-per-directory=.gitignore |"
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/families/ok-workspaces/CLAUDE.md#claude-md.constraints @ sha256:8a95853ff138
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh @ sha256:61e6ad6c8a19
