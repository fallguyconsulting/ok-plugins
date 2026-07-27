---
audit: corpus-proof
artifact: story:corpus-proof
determination: satisfied
audited: 2026-07-27T23:45:00Z
artifact-hash: sha256:14edfea3fbd5
---

# Does the proof run execute every in-scope story's proofs deterministically and report verdicts without writing the intake?

## Claims

**Title / Story — "every live story's registered proofs executed
deterministically, so that a story's promised functionality is demonstrated by
a run a third party can repeat rather than by a read-through opinion."**
Honored. The verb's default scope is "every live story under
`.ok-planner/design/stories/`", with caller narrowing (a slug list, or a sprint
whose deltas name the touched stories) as the stated exception and the
whole-corpus run reserved for an explicit request — never a contract-time
override. "Registered" has a mechanical meaning rather than a judged one:
collection is by annotation, `rg -l '@story:\s*<slug>'`, so what counts as a
proof is decided by a grep, not by a reader.

**Acceptance 1 — "each receives a verdict (pass, missing, failing, or
unrunnable)."** Honored, and the population of four verdicts was checked
against four producing conditions rather than against the report template:
zero annotated artifacts → `missing` (step 1); no discoverable invocation →
`unrunnable` (step 2); execution result → pass or `failing` (step 3). No
verdict is left to discretion, and there is no fifth.

**Acceptance 2 — "in a structured in-context report, with failure output
carried verbatim."** Honored. Step 4 fixes the report shape — a status line, a
verdict table with one row per in-scope story, and a findings block per
non-pass verdict — and step 3 requires capturing "the failure output verbatim
on failure", echoed by the findings block's evidence line.

**Acceptance 3 — "the run invokes only harnesses the project itself
documents."** Honored, as a prohibition rather than a preference: harness
commands are discovered "from the project's own docs (CLAUDE.md, README,
Makefile, package manifest) — never invent an invocation", and the consequence
of finding none is the `unrunnable` verdict, not a guess. Checked against this
project rather than assumed: the planner's story harness is documented by name
and invocation in the repository README, so the verb's discovery step has a
real source to find here.

**Acceptance 4 — "the intake queue is never written."** Honored, stated in the
verb's own frontmatter description and again in the body: it "**never writes to
the issue intake (`.ok-planner/issues/`)** — filing for the human belongs to
certification's architect." The same sentence is additionally pinned by a
repository maintenance check registered under
`decision:prove-audit-audience-split`, so deleting it turns an assertion red
independently of any audit.

**Acceptance 5 — "whether a green proof spans its story's claim is left to the
implementation audit, never asserted by the run."** Honored twice: in the
opening ("that judgment belongs to the implementation audit … `/prove` answers
exactly one thing, deterministically") and in the NOT-do list ("Does not judge
whether a passing proof covers its story — adequacy is the implementation
audit's determination").

**Acceptance 6 — "The proof-running skill and the proofs it executes are
real."** Honored: `prove` is in the converge core's `SKILLS` map, so it is
vendored into consumer projects rather than living only in the payload, and
this repository carries a real annotated harness that runs green (54
assertions, exit 0 on the current tree).

**Falsifier — a verdict issued for a proof never executed; a failing run
reporting pass; the run bending a proof to green or weakening a verdict; an
invented invocation; findings leaking into the queue.** Each has its
counterpart prohibition: the four verdict conditions, the verbatim-capture
rule, the NOT-do list's "Does not fix proofs, code, or corpus" and "Nothing in
this verb edits the working tree", the never-invent rule, and the intake
prohibition. The suggested-fix line even names the case where bending would be
tempting and forbids it: an intent change is "an intent-level corpus mutation
only a sprint can make, and the caller should leave the proof failing rather
than bend it."

**Proof — "a run over stories containing one honest passing proof, one
deliberately failing proof, and one story with no annotated proof, reporting
pass, failing, and missing respectively, with the working tree unchanged
afterward."** The story is annotated in `test/proofs.sh`, and the block builds
exactly that fixture: three stories, an exit-0 annotated script, an exit-1
annotated script, one unannotated story, collected by annotation exactly as the
verb documents. It asserts the three verdicts and then asserts the fixture's
git working tree is clean afterward. The field's population is three stories
and every member is exhibited; the fourth verdict (`unrunnable`) is in the
Acceptance but not in the Proof field, so its absence from the harness is not a
gap in the proof. The harness was re-run this cycle and all four assertions
pass; the block itself was untouched by the cycle's edits.

## Determination

**satisfied.** Every Acceptance clause has a citable enforcement point in the
prove verb, and the enforcement is specific rather than gestural: four verdicts
with four producing conditions, a fixed report shape, a verbatim-capture
requirement, a prohibition on invented invocations, an explicit intake
prohibition, and an explicit hand-off of the adequacy question to the
implementation audit. The annotated proof exercises the whole of the `Proof:`
field, including the unchanged-tree conjunct, against a real fixture rather
than against the verb's text, and runs green.

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
demonstrated — without the harness growing to match; `prove` leaves the
converge `SKILLS` map, making "the skill is real" false for consumers; or
`test/proofs.sh` loses its `corpus-proof` block or its `@story:` annotation.

## Citations

- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "## Process" +8 sha256:db2b80f53183
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Discover the commands from the project's own docs"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "3. **Execute.** Run each proof. Capture pass/fail and the failure output verbatim on failure."
- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "4. **Report** in-context, structured, one entry per in-scope story:" +26 sha256:830d6426400d
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "- Does not judge whether a passing proof covers its story"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "verdict_for() {" +6 sha256:e6d095603a07
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: working tree unchanged after the run"
- cite: README.md :: "`bash plugins/ok/families/ok-planner/test/proofs.sh` (the planner's story"
- cite-file: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:57bedf31463e
