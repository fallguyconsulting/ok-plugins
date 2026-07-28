---
audit: incremental-lint-adoption
artifact: story:incremental-lint-adoption
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:a6dfca540c0b
---

# Can an owner survey, cluster, plan and ratchet a legacy backlog without stopping work and without moving backward — with every proposal verb read-only?

## Claims

**Title — "Adopt the lint on a legacy codebase without regressing."** The five
adoption mechanisms below exist and compose: survey, cluster, plan, ratchet,
starter config. Nothing in the adoption path requires clearing the backlog
first, and nothing requires turning a check off. Honored.

**Acceptance clause 1 — "a whole-repo report groups violations by check and by
file."** The compliance verb runs the lint over the repository root, echoes the
full violation list (one `file:line: plumbline/<check>: <message>` line per
finding), then prints a by-category tally and a by-file tally. Both groupings
are present; the by-file tally is capped at the ten worst files, but the
complete per-file evidence is in the echoed list above it, so nothing is
withheld. Honored.

**Acceptance clause 2 — "clusters of similar violations surface as single
proposed bulk fixes."** The binary's clustering pass buckets `citation-unresolved`
by tag and `comment-hygiene` by inferred shape (divider, license-fragment,
todo-marker, commented-out-code, doc-residue, disallowed-prose), printing each
bucket with its count and up to three sample sites; the clustering verb then
maps each shape to a named bulk proposal for the owner to authorize. The shape
inference is a real content classifier over the offending lines, not a rename of
the check code. Honored.

**Acceptance clause 3 — "a port plan enumerates the passes to zero."** The port
verb runs diagnose, the lint, and the clustering pass, then emits a
phase-by-phase plan whose stated goal is a clean lint under both checks: an
Adopt pass when diagnosis is not healthy, one pass per non-zero check carrying
that check's count and the cluster listing, and a terminal Maintain pass. Its
own notes state that the ratchet is explicitly *not* part of the plan, so the
plan is a to-zero plan rather than a live-with-it plan.

The verb's binary resolution changed this cycle — it now prefers the target
project's vendored copy and falls back to the payload with an announcement —
which does not touch what the plan contains. One consequence worth naming: the
plan's "Reference:" line now degrades to a prose reference when the payload's
porting-guide document is unreachable, rather than printing a path that does not
exist. Content of the passes is unchanged, and I re-ran the verb against a
converged fixture to confirm the plan still carries the goal statement, the
per-check backlog table and the Maintain pass. Honored.

**Acceptance clause 4 — "a recorded baseline makes any change that increases the
count fail in CI while any that holds or decreases it passes."** The budget
check re-lints, compares against the recorded count, and exits with the failing
status only when the current count exceeds the baseline, printing the per-check
deltas; equal exits clean, lower exits clean with a note that the baseline can
be ratcheted. The GitHub and GitLab CI templates the family emits both wire the
budget check as a step conditioned on the baseline file's presence. (The
pre-commit template carries only the lint, not the budget step — it is a local
commit hook rather than CI, and the claim's subject is CI.) Honored.

**Acceptance clause 5 — "a starter proposal shapes the config from detected repo
signals for the owner to confirm."** The starter command detects a Go module, a
Node package, an ok-planner sibling and generated-code directories anywhere in
the tree, and emits a config object — the three design citation entries when the
planner estate is present, plus the detected ignore paths — on stdout, with the
"save this as the config" instruction on stderr. It writes nothing. The family's
administration document requires the administrator to walk the owner through
that output and transcribe only confirmed answers. Honored — see the proof
claim for how thinly this is exercised.

**Acceptance clause 6 (quantified) — "All proposal verbs are read-only — nothing
is applied without the owner."** The population is the family's vendored verb
set, enumerated from the vendoring map in the binary rather than from the
story's examples: audit, budget, ci, explain, patterns, port, slug, starter,
suggest, version. Every one of them prints and stops. I re-derived this from
behaviour this cycle rather than from the branches: I converged a fresh
repository, committed it, cloned it, and ran all ten verbs' own Run blocks from
the clone — the working tree was unchanged afterwards in every case. The two
that could write do so only on an explicit owner act: the port verb writes a
file only when the invocation names an output path (and prints a read-only
notice otherwise), and the budget verb writes the baseline only under its `save`
argument — and `save` refuses with a failing status when the count is above the
recorded one, so even the owner's write cannot move the ratchet the wrong way.
No verb applies a fix. Honored.

**Falsifier — "The violation count rises without a failure; proposals are
bulk-applied without confirmation; the backlog is only readable
violation-by-violation with no clustering or plan; or adoption requires
disabling the checks."** Limb 1 is negated by the budget check and by `save`'s
refusal; limb 2 by the read-only enumeration above and by each verb's explicit
"do not apply without authorization" instruction; limb 3 by the clustering pass
and the port plan; limb 4 by the config reader, which honors only citation and
ignore keys and treats the retired per-check key as a diagnose warning rather
than an off switch. Honored.

**Proof — "on a repo with a seeded backlog: a baseline recorded, a change adding
one violation failing the ratchet check while a reducing change passes, and a
clustered report plus port plan a third party can follow to drive one cluster to
zero."** The registered proof seeds a real git repository with four known
violations of two shapes, then asserts: the baseline file lands in the estate; a
net-new violation trips the check; a holding change passes; a reducing change
passes and is reported below baseline; `save` refuses to raise; the clustered
report names both seeded shapes; the port verb's own run block produces a plan
containing the check name and the Maintain pass; the port verb writes nothing
unless an output path is named, and writes exactly there when one is. Every
Proof-field limb is covered, and the read-only clause is covered beyond it. The
proof's run-block extraction helper was refactored this cycle to take a path
rather than a verb name; the assertions it drives are unchanged, and the whole
harness runs green.

**Proof coverage against the Acceptance.** Five of the six Acceptance clauses
are exercised behaviourally. Clause 5, the starter proposal, moved from
unexercised to partially exercised: the clone self-containment case added this
cycle invokes the starter verb's own Run block against a converged fixture and
asserts it exits clean against the project's own binary. What it still does not
do is reconcile the emitted config against the fixture's signals — the fixture
has no Go module, no planner estate and no generated directories, so the case
would pass unchanged if the detection logic were deleted and the verb emitted an
empty config. The mechanism is present and read-only by construction (it only
writes to stdout), so this remains a gap in the deterministic exercise rather
than in the implementation, and the story's own Proof field does not ask for it.
Recorded as a partial.

## Determination

**satisfied.** All five adoption mechanisms exist and behave as the Acceptance
describes: the survey groups by check and by file, the clustering pass buckets
by real content shape with bulk proposals, the port plan enumerates passes to a
clean lint, the ratchet fails increases and passes holds and decreases in CI,
and the starter emits a signal-derived config for confirmation. Every verb in
the vendored set is read-only except for two owner-invoked writes, one of which
is itself one-way — which I confirmed by running all ten from a clone and
finding the tree unchanged. The registered proof covers every limb of the Proof
field and runs green.

This stops holding if: the budget check stops failing on an increase, or `save`
stops refusing to raise; the clustering pass collapses to bucketing by check
code, so "clusters of similar violations" becomes a rename of clause 1; the port
plan starts writing by default or drops its to-zero contract; any verb begins
applying fixes rather than proposing them; or the config reader begins honoring
a key that disables a check. The starter gap closes — and this claim strengthens
— if the harness gains a case that runs the starter over a fixture with known
signals and reconciles the emitted config against them, rather than only
asserting that the verb exits clean.

## Citations

- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const VENDORED_SKILLS = {" +12 sha256:404c640aa813
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function budgetCmd(action, target) {" +73 sha256:bc1df8e3883d
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CI_TEMPLATES = {" +44 sha256:ffb2c2cbc05b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function patternsCmd(target) {" +29 sha256:b3de8aafff4e
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function commentHygieneShape(v, fileCache) {" +42 sha256:b77951a0f9ea
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +43 sha256:7c2d8dc77c6b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "by category:"" +8 sha256:6f2bdf711ae9
- cite: plugins/ok/families/ok-plumbline/skills/budget/SKILL.md :: "Without args, the skill checks current usage against the saved baseline. Pass `save` to record a lower baseline: the ratchet is one-way in code, so `save` refuses (exit 2) when the current count is above the recorded one — raising a baseline is not something this verb can do."
- cite-span: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md :: "bin=".ok-plumbline/bin/plumbline"" +9 sha256:9b6c85eb67fa
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:9dbae600c267
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_ratchet_case() {" +35 sha256:796b9295ae88
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_clone_self_containment_case() {" +32 sha256:00252415793d
