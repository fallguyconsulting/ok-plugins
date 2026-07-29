---
audit: corpus-audit
artifact: story:corpus-audit
determination: satisfied
audited: 2026-07-28T22:40:00Z
artifact-hash: sha256:1e00663ed014
---

# Does the corpus audit return one in-context report, every finding classified, writing nothing anywhere — with the check behind each finding real?

The design artifact's hash is unchanged since the prior audit, and that
audit carried no `## Notes` ledger, so no adjudication binds this pass and
none is opened. Two things moved beneath this audit. `test/proofs.sh`'s
whole-file pin broke from this cycle's per-proof timing instrumentation (a
`section`/`emit_timing` wrapper around every harness's existing assertions)
and the addition of a new story's block elsewhere in the file — neither
touches this story's own cited spans, which are unchanged byte-for-byte.
`skills/audit/SKILL.md` itself also moved: step 7's closing paragraph was
repointed from a single-path "only the architect's confirmed forks are
promoted" sentence to the two-gated-path wording ("the architect's
confirmed forks, and the remainders escalated at the cap") already used
by the certification core this story's Acceptance 4 also cites — read
directly, this narrows no claim and drops nothing the story rests on; if
anything the verb's own text now states the rule this audit already
credited it with agreeing to. This pass is therefore a citation refresh
plus one prose correction: the proof half was re-derived, the mechanism
half re-checked against the current files, and Acceptance 4's quoted text
updated to the surviving wording.

## Claims

**Title — "Audit the corpus and report the judgment calls."** Honored.
The verb's identity is the one the title names: its frontmatter
description reads "A pure reporter: findings return in-context, nothing is
written", its opening paragraph calls it "a pure reporter — the
corpus-side reviewer, the exact peer of a code reviewer", and its report
step hands the report to the caller and routes nothing.

**Story clause — "the whole design corpus periodically checked for
compliance, proof coverage, intent drift, and cross-artifact conflict."**
Honored: four named subjects against four real check sites — compliance
(pass 1, the shared design-doc compliance reviewer dispatched in
whole-corpus mode), proof coverage and intent drift (pass 2, one dispatch
carrying both as separately specified sections plus annotation integrity
and audit-corpus health), cross-artifact conflict (pass 3). Pass 4 adds a
subject the Story does not enumerate (surface inventory) — a superset, not
a gap.

**Story clause — "with every finding returned to me classified as
mechanical or judgment."** Honored, checked member by member rather than
taken from the opening sentence. The population is the four dispatched
passes, enumerated from the skill file itself (pinned whole below). Pass
1's reviewer output format carries a per-finding class line with both
branches defined; pass 2's output format is "One entry per finding:
heading, class, evidence"; pass 3 instructs "Classify each" with both
branches and their tests spelled out; pass 4 assigns a class to each
non-consistent surface verdict, and its only unclassified verdict
("claimed and consistent") produces no finding at all. No pass can emit an
unclassified finding, and step 7 requires the class to survive into the
report ("each carrying its advisory mechanical/judgment class"). The class
is declared advisory rather than routing, which is exactly what the story
asks — the owner must be able to tell them apart, not have the class move
anything.

**Acceptance 1 — "the caller receives one in-context report: mechanical
findings to fix in-cycle, judgment findings classified for the owner's
calibration."** Honored. Step 7 fixes one report shape — a status line and
a single Findings block carrying every finding entry from every pass
verbatim — and closes by telling the caller to re-run after fixes until
clean. One report, not one per pass.

**Acceptance 2 — "nothing anywhere is written — the verb is read-only
against corpus, code, and intake alike."** Honored at the strongest
available altitude: process step 1 is "Create nothing. This verb is
read-only against the project — it does not even ensure its own layout",
with a missing `issues/` directory reported as a finding rather than
created, and the NOT-do list repeating it for the intake specifically ("no
filing, no editing, no closing"). The one executable any pass invokes —
the vendored `audit-check` — was re-read end to end at the prior audit,
after its node-citation rewrite: every `open()` in it is a read, and there
is no write, unlink, mkdir, or `os.remove` path anywhere in the file, so
delegating to it smuggles in no write. That reading stands unchanged here
— `audit-check` was untouched this cycle and its pinned span still
verifies. Worth naming as an adversarial check that could have failed: the
sibling program that rewrite added, `source-graph`, does write (`build`
creates directories, rewrites graph files, and removes orphans) — but no
pass of this verb invokes it, and the audit-corpus-health section names
only `audit-check` and its payload fallback. Re-checked against the
cycle's actual edit: the changed bytes are a fixture *inside*
`test/proofs.sh` that drives `source-graph`, which is the proof harness's
business and not this verb's; no pass acquired an invocation of it.

**Acceptance 3 — "and it never executes proofs."** Honored: "Does not
execute proofs — that's `/prove`. The intent-drift check reads; it never
runs."

**Acceptance 4 — "What the caller does with the report is the caller's: a
human files what they judge fork-worthy, and the certification gate drains
it through its review-fix loop."** Honored, both halves in the same
paragraph as the report: "The caller decides what happens next; the audit
routes nothing. Inside certification, every finding enters the review-fix
loop … and `.ok-planner/issues/` is reached only by the two gated paths —
the architect's confirmed forks, and the remainders escalated at the cap.
A human running `/audit` standalone fixes what they choose and files what
they judge fork-worthy themselves." The verb's own wording now names both
paths explicitly (repointed this cycle from a single-path "only the
architect's confirmed forks" sentence), matching rather than merely
agreeing with the certification core's statement of the same rule
("certification creates issues only through the architect's confirmed
forks and through the owner's cap escalation"), and `certify-all` consumes
the verb as a producer on exactly those terms.

**Acceptance 5 — "The check behind every one of those findings —
compliance, proof coverage, intent drift, cross-artifact conflict — is
real, not stubbed."** Honored, with the population read as four *checks*
rather than four passes and each enumerated against the file. Compliance:
pass 1 dispatches the shared reviewer prompt transcluded verbatim from
`design-doc-compliance-reviewer.md`, not a summary of it. Proof coverage:
pass 2 carries a "Coverage check" section with a mechanical collection
rule (`rg -n '@story:\s*<slug>'` per live story), both verdict branches,
and the class each produces. Intent drift: pass 2 carries a separate
"Intent-drift check" section requiring the proof file read in full against
the story's `Proof:` field, with three verdicts and the candidates each
records. Cross-artifact conflict: pass 3 is a full dispatch with a
five-item definition of what counts as a conflict, a stated method, an
output format, and a classification rule that requires reading the code
before classing. None of the four is a heading with nothing under it and
none is a passing mention: each carries a job statement, transcluded rule
tokens, a procedure, an output format, and anti-padding. A conjunct beyond
presence backs this: every `{{TOKEN}}` the four passes transclude resolves
to exactly one `###` heading in `skills/_shared/` (six tokens, resolved at
harness run time), so no pass dispatches a prompt assembled from a block
nobody defines. Checked on the vendored side too, where the transclusion
paths are rewritten to `../_shared/`: that directory is vendored into
`.claude/skills/_shared/` by the converge core, so the rewritten paths
resolve in a consumer project rather than dangling.

**Falsifier — "Corpus muddiness or a claim that outran the code passes
without a finding."** Each half has a pass that catches it. Muddiness:
pass 1 enforces self-containment, current-state-only, story form, decision
form, TOC consistency, and cross-reference integrity. A claim that outran
the code: pass 2 folds `audit-check`'s `violated` determinations in
verbatim, and pass 4 builds the surface inventory from reality first and
reports "claimed and contradicted" against it.

**Falsifier — "the audit fixes artifacts itself; the run writes anything —
the intake included."** Negated by step 1 and by the NOT-do list's "Does
not fix anything — not even mechanical findings. The caller fixes; the
audit re-verifies."

**Falsifier — "the mechanical/judgment classification is missing."**
Negated per pass, above.

**Proof — "an audit over a corpus seeded with a known compliance
violation, an uncovered claim, and a cross-artifact contradiction, after
which a third party finds all three in the caller's report with the
judgment items classified as such, and the working tree — intake
included — unchanged."** The story is annotated in `test/proofs.sh`, whose
`corpus-audit` block runs over both copies of the verb — the family source
and the vendored `.claude/skills/ok-planner-audit/SKILL.md` this project
actually runs — asserting the four passes are present, that the report
contract still carries the mechanical/judgment class, and that the
read-only stance stands verbatim (in-context report, `Create nothing.`, no
intake writes, no proof execution), plus the token-resolution conjunct
above. All seven assertions pass on the current tree, and the block itself
was untouched by this cycle (its three pinned spans are unmoved).

The weakness is recorded rather than waved through, and it is the same one
the prior audit named. The seeded run is exhibited by nothing: the verb is
a prompt whose findings come from four subagents reading prose, so
planting a compliance violation and reading it back out of a report is
inherently agentic, and the harness names that at the assertion with the
file and step that carry it. The consequence is that the Proof field's
three detection observables are asserted only as the governing text that
would produce them, and the tree-unchanged observable only as the verb's
stated read-only stance — not as a before/after listing, the technique
`sketch-an-idea`'s block does use against its own fixture. The
four-passes assertion is also a heading grep: a pass emptied of its prompt
body would still satisfy it, and only the token conjunct partially guards
that. What the block does buy is coverage of the vendored copy as well as
the source, so a converge that dropped a pass or softened the stance turns
it red.

A further citation-only pass: `test/proofs.sh` moved again this cycle — it
gained a new `trace-corpus-to-code` section (a decision fixture with its
own audit and new assertions) immediately ahead of the `corpus-audit`
section — which only shifts this story's block's offset and moves the
whole-file pin. The `corpus-audit` block itself and its three cited spans
(`audit_copy_check`, the agentic-proof comment, the token-resolution
comment) are byte-identical, none of them re-flagged stale.

A further citation-only pass: `test/proofs.sh`'s whole-file pin moved again
from the owner-ratified cap-rewording exhibitions added to the
`certify-completion` story's section elsewhere in the file. The
`corpus-audit` block itself and its three cited spans (`audit_copy_check`,
the agentic-proof comment, the token-resolution comment) are byte-identical,
none re-flagged stale. Citation regenerated; nothing else touched.

## Determination

**satisfied.**

Every Acceptance clause has a citable enforcement point in the verb a
project runs. The four *checks* the Acceptance names — compliance, proof
coverage, intent drift, cross-artifact conflict — are four fully specified
dispatch sections, each with its own procedure and output contract, and
every block they transclude resolves to exactly one canonical definition.
The read-only stance holds through the one executable the verb delegates
to, re-verified against that program's post-rewrite text and against the
adversarial case the rewrite created (a sibling program that does write,
which no pass invokes). The mechanism side is corroborated rather than
contradicted by the rest of the corpus: the certification core's one-path
sentence agrees, and `story:corpus-proof`'s counterpart clause agrees.

This determination stops holding if: the verb reacquires a write of any
kind, to the intake or elsewhere (step 1's "Create nothing." and the
NOT-do line break first), or `audit-check` gains a write path, or a pass
starts invoking `source-graph`; any of the four named checks is deleted or
demoted to a mention, making the "real, not stubbed" clause an overclaim;
a transcluded block loses its canonical heading or acquires a second one
(the token conjunct breaks first); any pass's output format drops the
class, or step 7 stops requiring the class to survive into the report; the
report is split per pass so the caller no longer receives one; the
vendored copy drifts from the source, or `_shared/` stops being vendored
so the rewritten transclusion paths dangle; or `test/proofs.sh` loses its
`corpus-audit` block or its `@story:` annotation. It would also weaken —
without strictly falsifying — if the block's detection assertions stay
text-presence-only once a deterministic residue becomes available, for
instance a fixture exercising that the one executable the verb invokes
leaves the tree untouched.

## Citations

- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project" +1 sha256:79e0277d8554
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "3. **Pass 1 — compliance.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "4. **Pass 2 — coverage + intent-drift + annotation integrity.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "### Coverage check (cheap, mechanical to detect; judgment to resolve)"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "### Intent-drift check (judgment)"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "5. **Pass 3 — cross-artifact consistency.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "6. **Pass 4 — surface inventory.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "One entry per finding: heading, class, evidence, and for"
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "7. **Report to the caller** — machine-readable, in-context:" +12 sha256:06b94fccc316
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not execute proofs"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing."
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "returns everything in-context, and writes nothing"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "Class: `mechanical` or `judgment`. The line is intent, not"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "certification creates issues only through the architect's confirmed forks and through the owner's cap escalation"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs," +55 sha256:a4d90f60f643
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def build(root):" +30 sha256:a6300c738da4
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: corpus-audit"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "audit_copy_check() {" +29 sha256:eff0ecac23da
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# The seeded-corpus run is agentic (four subagent passes reading a" +7 sha256:23e80bad87e7
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# {{TOKEN}} the verb uses is resolved here against the shared directory —" +3 sha256:40dad09d6b5e
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "the vendored verb this project runs"
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:bf7abd501b40
- cite-node: .claude/skills/ok-planner-audit/SKILL.md @ sha256:5c079142d7b5
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
