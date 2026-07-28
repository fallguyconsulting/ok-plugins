---
audit: content-addressed-artifacts
artifact: story:content-addressed-artifacts
determination: satisfied
audited: 2026-07-27T13:00:35Z
artifact-hash: sha256:4e84ce1ec546
---

# Is the tag a pure function of tree content, and does an annotated proof exhibit it?

## Claims

**1. "Anyone runs the project's materialized tag script in any tree state → the printed tag is a pure function of tree content."**
The derivation enumerates the file set from the working tree — index entries plus
untracked files — with the repository's own per-directory ignore files as the sole
exclude source, feeds that set through a throwaway copy of the index, and writes a
git tree object from it. The three per-machine inputs that could otherwise reach the
hash are pinned off at the update step: the global excludes file, the global
attributes file, and line-ending translation. I verified purity adversarially rather
than reading it: two checkouts of an identical tree where the second sets a global
attributes file forcing end-of-line conversion and enables line-ending translation
produce the identical tag, and the annotated harness's own cross-checkout case
(below) covers the ignore-configuration axis.
Honored.

**2. "the same tree yields the same tag on every machine with no commit required."**
Nothing in the derivation consults HEAD, a commit, or a ref; the temporary index is
a copy, so the real index and working tree are untouched. Every consumer receives
byte-identical bytes: converge writes the canonical payload to the profile-declared
path, and diagnose byte-compares what is on disk against the canonical rendering,
reporting divergence as drift.
Honored.

**3. "any change to tracked or untracked content the repository's own ignore rules do not exclude changes it."**
Tracked content enters through the index enumeration and untracked content through
the others enumeration; the per-directory ignore files remove the excluded set, so
an ignored path is outside the hash by construction — which is what keeps a job's
worktree, living under an ignored prefix, from perturbing the tag of the tree it was
cut from. The harness exercises all three directions (tracked edit, new untracked
file, appended ignored file) and I ran it.
Honored.

**4. "harnesses resolving artifacts by tag fail loudly when the tag is absent."**
Not a property of the script — the script prints a tag — but of the consumer-side
rule the family ships and audits. The materialized cheatsheet's third rule states it
("fail loudly when it is missing. Never `:latest` or any mutable tag in a
verification path"), and the family's compliance verb sweeps for mutable tags in
verification paths and for a materialized script nothing consumes. The harness
exhibits the shape in a fixture and asserts the materialized cheatsheet carries the
rule.
Honored.

**5. "The materialized script is the real, byte-pinned component."**
The proof converges its fixture projects and runs the script converge materialized
into them, not the payload source; the byte pin is enforced by diagnose's canonical
comparison.
Honored.

**6. Proof: "the same tree hashed on two checkouts producing the identical tag, one edited file producing a different tag, and a harness lookup of a missing tag failing loudly rather than falling back."**
One annotated proof artifact — `rg -l '@story:content-addressed-artifacts'` outside
`.ok-planner/` and `.claude/skills/` returns exactly the family tag harness, pinned
by cite-file. Read and run here: all twelve assertions pass. It exhibits, in order:
that the second checkout's per-machine and per-clone excludes are genuinely in force
and hide **untracked** paths the first checkout offers (the two preconditions that
make the cross-checkout comparison discriminating — the weakness the previous audit
recorded is repaired: the case now varies excludes over untracked paths no committed
ignore file mentions, so a derivation that honoured per-machine ignore configuration
would drop them from one hash and only one); the frozen `src-` plus twelve-hex
shape; the two checkouts producing the identical tag; an uncommitted edit to a
tracked file changing it, with the edit asserted still uncommitted; a new untracked
file changing it; an ignored file leaving it alone; the real index and working tree
unperturbed by tagging; and a consumer-shaped harness that exits non-zero with a
"refusing to fall back" message when no artifact exists for the tag, then resolves
cleanly once one does. All three elements the `Proof:` field names are present.
Honored.

## Determination

**satisfied.** The derivation is a pure function of tree content in the sense the
Acceptance states, verified against reality rather than read off the comments, and
the story's annotated proof exhibits every element its `Proof:` field names —
identical tags across two checkouts, a divergent tag from an uncommitted edit with
no commit taken, and a by-tag lookup that fails loudly instead of resolving a
mutable tag. The proof runs against the materialized script, so it is proving the
component consumers actually get, and its cross-checkout case is now discriminating:
the exhibition weakness recorded last cycle is closed, and the invariance claim can
be cited to the harness rather than only to a hand-built case.

The Acceptance's fourth conjunct remains the weakest link by nature, not by defect:
"harnesses resolving artifacts by tag fail loudly" is a claim about consumer
projects, and what the family can carry is the rule in the materialized cheatsheet,
the compliance verb's sweep, and a fixture harness demonstrating the shape. That is
what is here.

This stops holding if: the enumeration gains the standard-exclusion flag or
otherwise admits per-machine or per-clone excludes; the attributes or line-ending
pins are dropped from the update step; the output shape stops being the fixed prefix
plus twelve hex; converge stops writing the canonical payload to the profile-declared
path or diagnose stops byte-comparing it; the cheatsheet's fail-loudly rule is
softened; the harness's ignore-configuration preconditions are dropped, returning
that case to a non-discriminating comparison; or the `@story:` annotation is removed
from the harness, which would return the story to the no-proof state an earlier
audit found.

## Citations

- cite: plugins/ok/families/ok-workspaces/test/tags.sh :: "# @story: content-addressed-artifacts"
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "# The second checkout carries ignore configuration that is not tree" +26 sha256:b40e6d7cdc9b
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "tag() { (cd "$1" && ./.ok-workspaces/bin/src-tag); }" +11 sha256:a911e5c10046
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "printf 'hello, world\n' > "$tmp/one/src/app.txt"" +14 sha256:8da726d45690
- cite-span: plugins/ok/families/ok-workspaces/test/tags.sh :: "# --- A harness resolving by tag fails loudly on a missing artifact ---------" +32 sha256:d3bf2c172435
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh @ sha256:4bee332851a6
- cite-span: plugins/ok/families/ok-workspaces/scripts/src-tag :: "git ls-files -z --cached --others --exclude-per-directory=.gitignore |" +6 sha256:f307532b192e
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "printf 'src-%.12s\n' "$tree""
- cite-node: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "fs.writeFileSync(srcTagAbs, stamp(fs.readFileSync(path.join(pluginRoot, 'scripts', 'src-tag'), 'utf8')));"
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "3. **Content-addressed artifacts.** Build outputs used for verification" +7 sha256:31c5da0880ed
- cite-span: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "    const canonical = fs" +6 sha256:65b3ad1ecd17
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "4. **src-tag consumption** — the src-tag script exists at the profile path"
