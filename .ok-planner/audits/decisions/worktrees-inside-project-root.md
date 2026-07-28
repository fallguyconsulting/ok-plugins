---
audit: worktrees-inside-project-root
artifact: decision:worktrees-inside-project-root
determination: satisfied
audited: 2026-07-27T13:20:17Z
artifact-hash: sha256:92c8a2d2eb2a
---

# Are worktrees defaulted inside the root, is the suite-owned ignore file written wherever the profile puts them, and is the root gitignore truly never touched?

## Claims

**1. Title / Choice: "Job worktrees are created by default inside the plugin's dot-directory under the project root."**
The default prefix is the worktrees directory under the family's dot-directory, and it
is stated once per stage: the detection proposal writes it into the profile, and both
the write core and the diagnose core fall back to the identical literal when the profile
omits it (including when it is present but empty). The open verb repeats the same
default and its rationale — a job's checkout must not be strandable next to the project.
Confirmed in a default-profile sandbox: converge produced `.ok-workspaces/.gitignore`
listing `worktrees/`, and `git check-ignore` answered "ignored" for a checkout path
under it.
Honored.

**2. "the family's converge core writes the suite-owned gitignore that covers wherever the profile puts them ... the dot-directory's own gitignore for the default location, and a suite-owned gitignore at the declared prefix itself when a profile points worktrees at another in-repo path."**
Checked against reality, not read. Converge classifies the declared prefix and acts on
each case: inside the dot-directory, it writes the relative path into the dot-directory's
own ignore file; outside the repository, it writes a comment saying there is nothing to
ignore; in-repo but outside the dot-directory, it writes a second suite-owned ignore file
**at the declared prefix itself**, containing the catch-all with a negation that keeps
the materialized file visible so the owner commits it. The classification is made on the
*resolved* location — the prefix is resolved against the repository root and taken
relative to it — never on the spelling. I converged five sandboxes and inspected every
`.gitignore` each produced: the default (dot-directory ignore only); an in-repo prefix
outside the dot-directory (`trees/` — both ignore files appear, and `git check-ignore`
says a checkout under it is ignored); an absolute prefix that resolves *inside* the repo
(correctly classified in-repo, second file written under it); a prefix that normalizes
out of the repository (`a/../../escaped/` — classified outside, the dot-directory
comment says so, and nothing was written outside the repository); and the degenerate
root-resolving prefix, treated below. The "covers wherever" quantifier holds over every
case converge accepts; the population source, converge's whole write surface, is pinned
by cite-file.
Honored.

**3. "since a gitignore governs only its own directory."**
This is the reason the second file exists, and it is what diagnose encodes: rather than
inferring coverage from the prefix's shape, diagnose asks `git check-ignore` about a
probe path under the declared prefix and reports DRIFT when git says the checkout would
be offered as repo content, naming the file converge would write as the remedy. Observed
in the `trees/` sandbox: `[ok] worktree-ign worktrees under trees/ are ignored (git
check-ignore)` — the answer came from git, not from a string test.
Honored.

**4. "A profile pointing worktrees elsewhere is a declaration, not drift."**
Diagnose emits an explicit `ok` line for an out-of-dot-directory prefix, worded as
declaration rather than drift — observed in both the `trees/` and the escaping sandboxes,
each exiting 0 — and the administration document treats a non-default prefix as a profile
value to honor, never to reconcile. The one prefix this does not cover is the repository
root itself, which converge now refuses; see the Determination for why that is inside
the Choice rather than against it.
Honored, with the carve-out below.

**5. "the project's root gitignore is never touched."**
Quantifier "never". Population: every write the family performs, enumerated from the
converge script (its only writing module — diagnose, detect, and the allocator hold no
write primitive at all) and independently pinned by the repository's own ownership
conformance check, which enumerates the permitted write targets by pattern, fails any
other, requires the second ignore file to be derived from the declared prefix resolved
against the repository root, and requires its write to be gated on the in-repo case. The
root ignore file is not among the permitted targets. I then closed the arithmetic myself:
the only write that can land outside the dot-directory is at
`<resolved prefix>/.gitignore`, which equals the root ignore file exactly when the
resolved prefix equals the root — and converge now exits 2 on that input *before its
first write*. Confirmed in every sandbox: I seeded each with a hand-written root
`.gitignore` and it came back byte-identical, including both root-resolving spellings
(`./` and `.`), where no estate was materialized at all.
Honored, without exception.

**6. The degenerate input, and how it is resolved.** A prefix resolving to the repository
root is the one place the Choice's own sentences pull apart: the root *is* "another
in-repo path", so the positive rule would prescribe writing a suite-owned ignore file
exactly where the final clause forbids writing. Converge resolves it by refusing the
profile outright — exit 2 with a message naming the offending field, the reason, and the
default to declare instead — and diagnose reports the same profile as a `profile` DRIFT
rather than calling it covered. Both sites carry an `@decision: whole-file-ownership`
annotation, and that is the corpus's own tiebreak: the ownership decision says the
machinery "never edits a file a human also edits", categorically. I reproduced the
refusal for both spellings and verified nothing at all was materialized — not the tag
script, not the cheatsheet, not the vendored skills — so the estate is never left half
built.
Honored as the only reading consistent with the corpus.

**7. Rationale: "keeping worktrees inside the root keeps ownership, cleanup, and discovery local" / "the ownership rule forbids editing the human-owned root gitignore, so the plugin carries its own ignore files instead."**
Consistent with the mechanism: both ignore files are version-stamped, suite-owned whole
files declared as such in their own headers, and the ownership check is what makes
"carries its own" mechanical rather than aspirational.
Honored.

## Determination

**satisfied.** The default location, the dot-directory scoping, the coverage of an
out-of-dot-directory in-repo prefix by a second suite-owned file at that prefix, the
declaration-not-drift treatment, and the never-touch-the-root-gitignore rule are each
implemented and independently enforced — the last mechanically, by an ownership check
that pins the writable set and also pins the root-resolution and the in-repo gate on the
second write. I verified the case split by converging and diagnosing sandboxes and
reading the files that appeared, not by reading the classification.

The counterexample that stood as a recorded residual through the previous cycle — a
prefix resolving to the repository root, which used to make converge overwrite the
project's own root `.gitignore` — is closed, and closed in the direction the corpus
determines. Converge refuses that profile before any write and diagnose reports it as a
problem, so claim 5's "never" is now unqualified and demonstrated rather than
qualified. The price is that the one clause reading "a profile pointing worktrees
elsewhere is a declaration, not drift" does not extend to that input. I judge that
inside the Choice rather than against it: the sentence's two conjuncts constrain each
other, and the root is precisely the in-repo path where honoring the first would breach
the second and breach `decision:whole-file-ownership` besides. No implementation can
satisfy all three clauses on that input; the one chosen sacrifices the reporting wording
for the degenerate case and keeps the safety property absolute, which is the ordering the
Rationale states.

The demo exercises this rather than leaving it to reading: it stands up a sandbox with a
hand-written root `.gitignore`, requires converge to fail, requires that file to survive
byte-identical, requires the refusal message to name the offending profile field,
requires no estate to have been materialized, and requires diagnose to report DRIFT on
it. I ran the harness here to completion (exit 0), and `test/tags.sh` alongside it.

This stops holding if: the refusal on a root-resolving prefix is removed or downgraded to
a warning; the second ignore write is removed or its in-repo gate is loosened; the
resolved-location classification reverts to a textual one; diagnose reverts to inferring
coverage from the prefix instead of asking `git check-ignore`; the default prefix stops
living under the dot-directory; the root ignore file enters the family's write surface
deliberately (which the ownership check would catch); or the declaration-not-drift line
for ordinary non-default prefixes becomes a DRIFT verdict.

## Citations

- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "// @decision: worktrees-inside-project-root"
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "if (path.relative(root, path.resolve(root, declaredDirPrefix)) === '') {" +9 sha256:6052a5a7a3cf
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const inDotDir = dirPrefix.startsWith('.ok-workspaces/');" +20 sha256:5986a40a3143
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "const worktreeIgnoreAbs = path.join(dirPrefixAbs, '.gitignore');" +5 sha256:e0c3c9dcdcef
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-span: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "  if (dirPrefixFromRoot === '') {" +6 sha256:80908c58455d
- cite-span: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "    const probe = path.posix.join(dirPrefix.replace(/\/$/, ''), 'ok-workspaces-probe-job');" +15 sha256:fbd53f5963f5
- cite: plugins/ok/families/ok-workspaces/scripts/diagnose.js :: "    check('worktree-dir', true, `worktrees at ${dirPrefix}* — outside the family dot-directory by declaration, not drift`);"
- cite-node: plugins/ok/families/ok-workspaces/scripts/diagnose.js @ sha256:28bef14ec895
- cite: plugins/ok/families/ok-workspaces/scripts/detect.js :: "  worktrees: { dirPrefix: '.ok-workspaces/worktrees/', branchPrefix: 'wt/' },"
- cite-span: checks/owned-paths :: "def check_workspaces():" +22 sha256:35ee44ab9b6d
- cite-node: checks/owned-paths @ sha256:12cd569528fb
- cite-span: plugins/ok/families/ok-workspaces/admin/ADMINISTRATION.md :: "  `.ok-workspaces/.gitignore` inside the dot-directory the suite owns" +8 sha256:e8e0bd5a2740
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- A root-resolving worktree prefix is refused, not materialized ---------" +36 sha256:e15ddfb1334e
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:04d3e5220cac
