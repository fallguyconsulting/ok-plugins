---
audit: isolated-parallel-workspaces
artifact: story:isolated-parallel-workspaces
determination: satisfied
audited: 2026-07-27T13:20:17Z
artifact-hash: sha256:58f2728b8f8e
---

# Does opening a job produce an isolated checkout, branch, and runtime namespace — and can a third party verify all three are disjoint?

Refreshed only: the design artifact's hash is unchanged and no nomination
implicates this audit. `test/demo.sh` gained per-story timing instrumentation
this cycle (a `section`/`emit_timing` helper pair plus one `section
isolated-parallel-workspaces` marker line dropped in immediately after this
story's section header, ahead of the two `git worktree add` calls). Read the
whole diff: the only change inside the cited span is that one inserted line —
every assertion the span and the whole-file citation vouch for is
byte-identical and still runs. Citations re-pinned; the determination and
every claim below stand on the same evidence as the prior audit.

## Claims

**1. "opens a named job → a new worktree and branch are created under the committed profile's naming."**
The open verb takes the job slug and creates worktree and branch from the profile's
directory and branch prefixes in one command; the defaults are stated once in the
detection proposal and re-derived identically by converge (which stamps them into the
cheatsheet's first rule) and by the allocator. The demo reads both prefixes out of the
sandbox's committed profile before it uses them, so its assertions test
profile-derivation rather than a hard-coded pair.
Honored.

**2. "only version-control-invisible local files carry over."**
Quantifier "only". Population: every place in the family that puts a file into a
worktree — enumerated from the open verb's carry-over step (the sole such place) and
confirmed against the rest of the family, where the converge script writes only the
suite-owned estate at fixed paths and the allocator prints to stdout and holds no write
primitive at all. The step names the local env files and the harness's local settings
file, and constrains the set explicitly: "Copy only files that are gitignored (tracked
files came with the worktree)". Population source pinned by a whole-file cite on the
open verb.
Honored.

**3. "the runtime is namespaced per the profile — a per-job container project name or a reserved port block."**
A disjunction; both branches realized, and both observed from materialized output rather
than restated. Dev-server: the materialized allocator, whose arithmetic is a single
computed source — the job's index among the profile-prefixed worktrees in live
`git worktree list` order, times the profile's span, off the profile's base port —
printed as `VAR=port` lines and reported as an explicit range (population source pinned
by a whole-file cite). Compose: the project prefix from the profile suffixed by the job,
written by converge into the cheatsheet's runtime rule; the demo converges a **second
sandbox** declaring the compose runtime and reads the namespace template back out of
that project's materialized cheatsheet, so the assertion's left-hand side is converge's
output, not a string the harness built. `runtime: "none"` provisions nothing, which is
the profile's declaration and not a gap — I converged that case and confirmed the
allocator is deliberately not materialized.
Honored.

**4. "the report names path, branch, and namespace with the reminder that work happens in the worktree."**
Prompt-realized: the verb's final step names exactly those four elements. There is no
code layer that could carry it.
Honored.

**5. "an existing directory or branch stops the open rather than being reused."**
Stated as an unconditional stop in the create step ("never reuse or clobber an existing
workspace"), and mechanically true of the underlying command — a command-level backstop
the proof exercises directly by re-issuing the same open and requiring it to fail.
Honored.

**6. "Reporting of discipline residue is the compliance-report outcome, not this story's."**
A scope disclaimer, not an obligation. The family's compliance sweep is a separate
read-only verb; nothing in the open path reports residue.
Honored.

**7. Proof: "two jobs opened side by side whose checkouts, branches, and runtime namespaces a third party can verify are disjoint, both stacks startable simultaneously, plus an open of an already-existing job name stopping with a report."**
One annotated proof artifact — `rg -l '@story:isolated-parallel-workspaces'` outside
`.ok-planner/` and `.claude/skills/` returns exactly the family demo, pinned by
cite-file. Read whole and run here: exit 0. It converges a sandbox project from a
**committed profile** (so the naming is profile-derived), opens two jobs, and asserts
from reality that each is on its own branch, that the two checkouts have different
toplevels, and that a second open of an existing name fails. It runs the **materialized
allocator** for both jobs and asserts the two port sets are disjoint (3010,3011 against
3020,3021 on my run), that the allocator prints one line per declared port env var, that
each workspace's env is distinct, and that allocating the second job's block left the
first job's env byte-identical — the "startable simultaneously" conjunct in exactly the
form the story's own falsifier states it ("a second workspace cannot start without
editing the first"). It then asserts the dev-server profile's materialized cheatsheet
hands the workspace to the allocator and states **no** compose namespace, and converges
a second sandbox under the compose runtime to read that runtime's namespace template out
of its cheatsheet, asserting it is derived from the profile's prefix and that
substituting two job names yields two different namespaces.
Honored.

## Determination

**satisfied.** Every Acceptance conjunct has a citable enforcement point — the open
verb's five steps for naming, existing-name refusal, carry-over, namespacing, and
reporting; the allocator for the dev-server arithmetic; the converge script's runtime
rules for both cheatsheet variants — and the annotated proof exercises from reality all
three disjointness axes the `Proof:` field demands (checkouts, branches, runtime
namespaces) plus the existing-name stop, with simultaneous startability exhibited as the
property the falsifier names. Both arms of the profile's runtime disjunction are covered
by observation of converge's own output rather than by harness-built strings.

The proof file grew a new section this cycle (a converge-refusal case belonging to a
different decision), which sits between the compose assertions and the close-gate
assertions. It adds coverage and removes none: every assertion this story rests on is
still present and still ran.

Carry-over (claim 2) and the report's wording (claim 4) are still not exercised by any
harness; both are prompt-realized, and neither appears in the story's Falsifier or in its
`Proof:` field, so this is scope rather than a gap.

This stops holding if: the open verb's carry-over step loses its gitignored-only
constraint or gains a tracked path; the allocator stops deriving the index from live
worktree state under the profile's prefix, or can hand two jobs overlapping blocks;
either cheatsheet runtime rule stops deriving its namespace from the profile; the verb
stops refusing an existing directory or branch; the demo's compose sandbox is removed and
the compose namespace goes back to being asserted against a harness-concatenated string;
or the demo reverts to asserting only checkout and branch disjointness — the state that
made an earlier audit violated.

## Citations

- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "   git worktree add <dirPrefix><job> -b <branchPrefix><job>"
- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "   Branch from the current HEAD unless the user names a different base."
- cite-span: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "3. **Carry over ephemeral local config.**" +1 sha256:2e812715ceab
- cite-span: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "4. **Provision the namespaced runtime.**" +4 sha256:a68bf6adec7d
- cite: plugins/ok/families/ok-workspaces/skills/open/SKILL.md :: "5. **Report.** Workspace path, branch, runtime namespace"
- cite-node: plugins/ok/families/ok-workspaces/skills/open/SKILL.md @ sha256:36650ee9c762
- cite: plugins/ok/families/ok-workspaces/scripts/detect.js :: "  worktrees: { dirPrefix: '.ok-workspaces/worktrees/', branchPrefix: 'wt/' },"
- cite-span: plugins/ok/families/ok-workspaces/scripts/port-block :: "const idx = jobs.indexOf(job);" +4 sha256:99c538957bc4
- cite: plugins/ok/families/ok-workspaces/scripts/port-block :: "console.error(`port-block: workspace ${job} is #${n} — ports ${start}-${start + span - 1}`);"
- cite-node: plugins/ok/families/ok-workspaces/scripts/port-block @ sha256:5c15c8febb77
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "  runtimeRule = `**One runtime stack per worktree.** Every workspace runs its own compose" +7 sha256:aff7b02ae209
- cite-span: plugins/ok/families/ok-workspaces/scripts/converge.js :: "  runtimeRule = `**One runtime stack per worktree.** Every workspace allocates its own" +7 sha256:c63d0a99f2fd
- cite: plugins/ok/families/ok-workspaces/test/demo.sh :: "# @story: isolated-parallel-workspaces"
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Two jobs opened side by side, under the profile's naming ---------------" +14 sha256:00a7294926d2
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "block_a=$("$repo/.ok-workspaces/bin/port-block" job-a 2>/dev/null)" +21 sha256:dd6ed815006e
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- This profile's runtime namespace, as converge materialized it ---------" +8 sha256:9f6f7607f061
- cite-span: plugins/ok/families/ok-workspaces/test/demo.sh :: "# --- Disjoint runtime namespaces: the compose project names ----------------" +28 sha256:547c2ef16f67
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:ea9c18329ea1
