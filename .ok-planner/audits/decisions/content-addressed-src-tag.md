---
audit: content-addressed-src-tag
artifact: decision:content-addressed-src-tag
determination: satisfied
audited: 2026-07-27T13:00:35Z
artifact-hash: sha256:212a6df70fcb
---

# Is the tag a frozen 12-hex tree hash whose derivation reads nothing outside the tree?

## Claims

**1. Title / Choice: "hashing the working tree ... through a temporary index into a git tree object, printed as a fixed prefix plus the first 12 hex of the tree hash."**
The script copies the real index to a temporary file, refreshes that copy from the
enumerated file set, writes a tree object from the copy, and prints the fixed
prefix plus a twelve-character truncation of the tree hash. The write target is the
copy, via the index-file environment override, so tagging never mutates repository
state — asserted by the annotated harness, which compares porcelain status before
and after a tagging run.
Honored.

**2. "the working tree the repository's own committed ignore rules admit — uncommitted changes included, ignored paths excluded."**
The enumeration takes index entries and untracked files in one pass and refreshes
the temporary index with add-and-remove semantics, so an uncommitted edit to a
tracked file, a newly created untracked file, and a deleted-but-still-indexed path
each move the hash; the per-directory ignore files remove the excluded set. The
exclude flag applies only to the untracked half — every index entry is listed
regardless — so nothing tracked can silently drop out of the enumeration and leave a
stale index entry behind in the temporary index. All three directions, including the
negative one (an ignored file leaves the tag alone), are exercised in the annotated
harness, which I ran.
Honored.

**3. "The derivation reads nothing outside the tree: the file set is enumerated with the repository's own ignore files as the only exclude source, so per-machine and per-clone configuration cannot reach the hash."**
Refuted rather than read. The enumeration names the repository's per-directory
ignore file as its only exclude source and deliberately omits the standard-exclusion
flag — the flag that would pull in the global excludes file and the per-clone
exclude file. The update step additionally pins the global excludes file, the global
attributes file, and line-ending translation to inert values. Two independent
checks. The annotated harness now builds the discriminating case: two checkouts
whose only difference is that the second names **untracked** paths in a global
excludes file and in its per-clone exclude file, with preconditions asserting that
git itself hides those paths in the second checkout and offers them in the first —
the tags come out equal. Separately, I stood up two checkouts of an identical tree
where the second sets a global attributes file forcing end-of-line conversion plus
line-ending translation; the tags are equal there too.
Honored.

**4. "The script stays POSIX shell with no dependency beyond git."**
The script is `/bin/sh` and invokes, besides git, only shell builtins and the POSIX
file utilities (temp-file creation, copy, remove) — no node, no python, no external
checksum tool, which is what the rationale's build-and-CI argument turns on. The
family constraint states the requirement as a standing rule. Read at its most
literal the POSIX file utilities are dependencies beyond git; they are present in
every POSIX userland including the minimal ones the rationale targets, so they do
not defeat the claim's purpose.
Honored.

**5. "its derivation never changes without a major version bump, so every consumer derives byte-identical tags for identical trees."**
Two halves. The freeze is a standing family constraint stating exactly that
prohibition; it has no mechanical gate, so its enforcement is the constraint plus
review. The byte-identity half **is** mechanical: converge writes the canonical
payload verbatim (version-stamped) to the profile-declared path in every consumer,
and diagnose byte-compares what is on disk against the canonical rendering and
reports divergence as drift. The harness runs against the materialized copy rather
than the payload source, so it proves the artifact consumers actually receive.
Honored.

**6. Rationale: "Deriving from a tree object gives content identity without requiring a commit and without touching the real index."**
Both properties exercised: the harness asserts the tag changes on an edit that is
still uncommitted (and separately asserts the edit is still uncommitted), and
asserts porcelain status is unchanged across a tagging run. Nothing in the
derivation consults HEAD, a commit, or a ref.
Honored.

**7. The enforcement site is navigable.**
The derivation site now carries an `@decision: content-addressed-src-tag`
annotation — the navigation gap the previous audit recorded is closed.

## Determination

**satisfied.** The chosen mechanism is present exactly as the Choice describes —
temporary index, tree object, fixed prefix plus twelve hex, POSIX shell with no node
dependency, byte-pinned into every consumer and byte-checked by diagnose — and the
terminal claim the whole tradeoff is sold on, that identical trees yield identical
tags because per-machine and per-clone configuration cannot reach the hash, survives
a discriminating test the harness itself now performs, which I reproduced
independently for the attributes and line-ending axes the harness does not cover.

One observation, not a ground for the determination: the attributes and
line-ending pins on the update step are defence in depth rather than presently
load-bearing — I could not construct a case on this platform where removing them
changed a tag, because the refreshed paths' stat data already matches the index and
their content is therefore not re-read. They cost nothing and close a real hole for
trees carrying carriage returns; I record only that they are unexercised.

This stops holding if: the enumeration gains the standard-exclusion flag or any
other exclude source beyond the repository's own ignore files; the attributes or
line-ending pins are dropped from the update step; the derivation touches the real
index, a commit, or a ref; the output shape changes without a major version bump;
the script acquires a dependency a bare build environment would lack; the harness's
ignore-configuration case loses its discrimination preconditions and reverts to
varying excludes over tracked or already-ignored paths; or converge stops writing
the canonical payload to the profile path, or diagnose stops byte-comparing it — the
byte-identity half of the freeze rests entirely on those two.

## Citations

- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "# @decision: content-addressed-src-tag"
- cite-span: plugins/ok/families/ok-workspaces/scripts/src-tag :: "git ls-files -z --cached --others --exclude-per-directory=.gitignore |" +6 sha256:f307532b192e
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "printf 'src-%.12s\n' "$tree""
- cite-file: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite: plugins/ok/families/ok-workspaces/CLAUDE.md :: "- `scripts/src-tag` must stay POSIX sh with no dependencies beyond git"
- cite-file: plugins/ok/families/ok-workspaces/CLAUDE.md @ sha256:da5173b0d811
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "fs.writeFileSync(srcTagAbs, stamp(fs.readFileSync(path.join(pluginRoot, 'scripts', 'src-tag'), 'utf8')));"
- cite-span: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "    const canonical = fs" +6 sha256:65b3ad1ecd17
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "# The second checkout carries ignore configuration that is not tree" +26 sha256:b40e6d7cdc9b
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "tag() { (cd "$1" && ./.ok-workspaces/bin/src-tag); }" +11 sha256:a911e5c10046
- cite-file: plugins/ok/families/ok-workspaces/test/tags.sh @ sha256:4bee332851a6
