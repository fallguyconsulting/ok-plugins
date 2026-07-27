---
audit: corpus-proof
artifact: story:corpus-proof
determination: satisfied
audited: 2026-07-27T12:26:54Z
artifact-hash: sha256:14edfea3fbd5
---

# Does the proof run execute every in-scope story's proofs deterministically and report verdicts without writing the intake?

## Claims

**Title / Story — "every live story's registered proofs executed
deterministically, so that promised functionality is demonstrated by a run a
third party can repeat rather than by a read-through opinion."** Honored. The
verb's scope is "every live story under `.ok-planner/design/stories/`", with
caller narrowing (a slug list, or a sprint whose deltas name the touched
stories) as the explicit exception, and the whole-corpus run reserved for an
explicit request. Collection is by annotation — `rg -l '@story:\s*<slug>'` —
so "registered" has a mechanical meaning rather than a judged one.

**Acceptance 1 — "each receives a verdict (pass, missing, failing, or
unrunnable)."** Honored, with each of the four verdicts bound to a producing
condition rather than left to discretion: zero annotated artifacts → `missing`
(step 1); no discoverable invocation → `unrunnable` (step 2); execution result
→ pass or `failing` (step 3).

**Acceptance 2 — "in a structured in-context report, with failure output
carried verbatim."** Honored. Step 4 fixes the report shape — a status line, a
verdict table with one row per in-scope story, and a findings block per
non-pass verdict — and step 3 requires capturing "the failure output verbatim
on failure", echoed by the findings block's evidence line.

**Acceptance 3 — "the run invokes only harnesses the project itself
documents."** Honored, and stated as a prohibition rather than a preference:
harness commands are discovered "from the project's own docs (CLAUDE.md,
README, Makefile, package manifest) — never invent an invocation", and the
consequence of finding none is the `unrunnable` verdict, not a guess.

**Acceptance 4 — "the intake queue is never written."** Honored, stated in the
verb's own frontmatter description and again in the body: it "**never writes to
the issue intake (`.ok-planner/issues/`)** — filing for the human belongs to
certification's architect." The same sentence is additionally pinned by a
repository maintenance check registered under
`decision:prove-audit-audience-split`, so deleting it turns an assertion red.

**Acceptance 5 — "whether a green proof spans its story's claim is left to the
implementation audit, never asserted by the run."** Honored twice: in the
opening ("that judgment belongs to the implementation audit … `/prove` answers
exactly one thing, deterministically") and in the NOT-do list ("Does not judge
whether a passing proof covers its story — adequacy is the implementation
audit's determination").

**Acceptance 6 — "The proof-running skill and the proofs it executes are
real."** Honored: the verb is vendored to consumer projects by the converge
core, and this repository carries a real annotated harness that runs green.

**Falsifier — a verdict issued for a proof never executed; a failing run
reporting pass; the run bending a proof to green or weakening a verdict; an
invented invocation; findings leaking into the queue.** Each has its
counterpart prohibition: the verdict conditions, the verbatim-capture rule, the
NOT-do list's "Does not fix proofs, code, or corpus" and "Nothing in this verb
edits the working tree", the never-invent rule, and the intake prohibition. The
suggested-fix line even names the case where bending would be tempting and
forbids it: an intent change is "an intent-level corpus mutation only a sprint
can make, and the caller should leave the proof failing rather than bend it."

**Proof — "a run over stories containing one honest passing proof, one
deliberately failing proof, and one story with no annotated proof, reporting
pass, failing, and missing respectively, with the working tree unchanged
afterward."** The story is annotated in `test/proofs.sh`, and the block builds
exactly that fixture — three stories, an exit-0 annotated script, an exit-1
annotated script, and one unannotated story — collects by annotation as the
verb documents, asserts the three verdicts, and then asserts the fixture's git
working tree is clean afterward. All four assertions pass on the current tree.
The field's population is three stories and it is exhibited member by member.

## Determination

**satisfied.** Every Acceptance clause has a citable enforcement point in the
prove verb, and the enforcement is specific rather than gestural: four verdicts
with four producing conditions, a fixed report shape, a verbatim-capture
requirement, a prohibition on invented invocations, an explicit intake
prohibition, and an explicit hand-off of the adequacy question to the
implementation audit. The annotated proof exercises the whole of the `Proof:`
field, including the unchanged-tree conjunct, and runs green.

The one limit worth naming, non-determinative: the harness models the verb's
documented collection-and-verdict algorithm in shell rather than driving the
prompt, since the verb is a prompt. It says so at its head. That keeps the
demonstration honest about what it exhibits, but it means a regression in the
verb's *text* — a verdict dropped from the report template, say — would not by
itself turn the harness red.

This determination stops holding if: the never-writes-the-intake sentence is
softened or removed (the `text-presence` assertion under
`decision:prove-audit-audience-split` breaks first); the harness-discovery step
gains a fallback that invents an invocation; the report template loses the
per-story entry or the verbatim failure output; the adequacy hand-off to the
implementation audit is dropped, putting the verb in the audit's chair; the
Acceptance is widened — for instance to require the `unrunnable` verdict to be
demonstrated — without the harness growing to match; or `test/proofs.sh` loses
its `corpus-proof` block or its `@story:` annotation.

## Citations

- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "## Process" +8 sha256:db2b80f53183
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Discover the commands from the project's own docs"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "3. **Execute.** Run each proof. Capture pass/fail and the failure output verbatim on failure."
- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "4. **Report** in-context, structured, one entry per in-scope story:" +26 sha256:830d6426400d
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "- Does not judge whether a passing proof covers its story"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "verdict_for() {" +6 sha256:e6d095603a07
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: working tree unchanged after the run"
- cite-file: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:f96535bcf843
