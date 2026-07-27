---
audit: corpus-audit
artifact: story:corpus-audit
determination: satisfied
audited: 2026-07-27T23:45:00Z
artifact-hash: sha256:1e00663ed014
---

# Does the corpus audit return one in-context report, every finding classified, writing nothing anywhere — with the check behind each finding real?

## Claims

**Title — "Audit the corpus and report the judgment calls."** Honored. The
verb's identity is the one the title names: its frontmatter description reads
"A pure reporter: findings return in-context, nothing is written", its opening
paragraph calls it "a pure reporter — the corpus-side reviewer, the exact peer
of a code reviewer", and its report step hands the report to the caller. The
cycle that refuted this clause is closed: the title and the two Acceptance
clauses that once promised an intake append were rewritten to describe the
channel that exists.

**Story clause — "the whole design corpus periodically checked for compliance,
proof coverage, intent drift, and cross-artifact conflict."** Honored: four
named subjects against four real check sites — compliance (pass 1, the shared
design-doc compliance reviewer dispatched in whole-corpus mode), proof coverage
and intent drift (pass 2, one dispatch carrying both as separately specified
sections plus annotation integrity and audit-corpus health), cross-artifact
conflict (pass 3). Pass 4 adds a subject the Story does not enumerate (surface
inventory) — a superset, not a gap.

**Story clause — "with every finding returned to me classified as mechanical or
judgment."** Honored, checked member by member rather than taken from the
opening sentence. The population is the four dispatched passes, enumerated from
the skill file itself (pinned whole below). Pass 1's reviewer output format
carries a per-finding class line with both branches defined; pass 2's output
format is "One entry per finding: heading, class, evidence"; pass 3 instructs
"Classify each" with both branches and their tests spelled out; pass 4 assigns
a class to each non-consistent surface verdict, and its only unclassified
verdict ("claimed and consistent") produces no finding. No pass can emit an
unclassified finding, and step 7 requires the class to survive into the report
("each carrying its advisory mechanical/judgment class"). The class is declared
advisory rather than routing, which is what the story asks: the owner must be
able to *tell them apart*, not have the class move anything.

**Acceptance 1 — "the caller receives one in-context report: mechanical
findings to fix in-cycle, judgment findings classified for the owner's
calibration."** Honored. Step 7 fixes one report shape — a status line and a
single Findings block carrying every finding entry from every pass verbatim —
and closes by telling the caller to re-run after fixes until clean. One report,
not one per pass.

**Acceptance 2 — "nothing anywhere is written — the verb is read-only against
corpus, code, and intake alike."** Honored at the strongest available altitude:
process step 1 is "Create nothing. This verb is read-only against the project —
it does not even ensure its own layout", with a missing `issues/` directory
reported as a finding rather than created. The NOT-do list repeats it for the
intake specifically ("no filing, no editing, no closing"). The one executable
any pass invokes — the vendored `audit-check` — was re-read end to end this
cycle after its release-masking rewrite: every `open()` in it is a read, and
there is no write, unlink, or mkdir path anywhere, so delegating to it smuggles
in no write.

**Acceptance 3 — "and it never executes proofs."** Honored: "Does not execute
proofs — that's `/prove`. The intent-drift check reads; it never runs."

**Acceptance 4 — "What the caller does with the report is the caller's: a human
files what they judge fork-worthy, and the certification gate drains it through
its review-fix loop."** Honored, both halves in the same paragraph as the
report: "The caller decides what happens next; the audit routes nothing. Inside
certification, every finding enters the review-fix loop … and only the
architect's confirmed forks are promoted to `.ok-planner/issues/`. A human
running `/audit` standalone fixes what they choose and files what they judge
fork-worthy themselves." The certification core states the same rule from the
other side ("Promotion is the loop's only path to the intake"), and
`certify-all` consumes the verb as a producer on exactly those terms.

**Acceptance 5 — "The check behind every one of those findings — compliance,
proof coverage, intent drift, cross-artifact conflict — is real, not stubbed."**
This is the clause repaired in-cycle, and it changes the population from four
*passes* to four *checks*, so it was re-enumerated against the file rather than
carried over. Compliance: pass 1 dispatches the shared reviewer prompt
transcluded verbatim from `design-doc-compliance-reviewer.md`, not a summary of
it. Proof coverage: pass 2 carries a "Coverage check" section with a mechanical
collection rule (`rg -n '@story:\s*<slug>'` per live story), both verdict
branches, and the class each produces. Intent drift: pass 2 carries a separate
"Intent-drift check" section requiring the proof file read in full against the
story's `Proof:` field, with three verdicts and the candidates each records.
Cross-artifact conflict: pass 3 is a full dispatch with a five-item definition
of what counts as a conflict, a stated method, an output format, and a
classification rule that requires reading the code before classing. None of the
four is a heading with nothing under it, and none is a passing mention: each
carries job statement, transcluded rule tokens, procedure, output format, and
anti-padding. A conjunct beyond presence backs this: every `{{TOKEN}}` the four
passes transclude resolves to exactly one `###` heading in `skills/_shared/`
(six tokens, checked at run time), so no pass dispatches a prompt assembled from
a block nobody defines. Checked on the vendored side too, where the transclusion
paths are rewritten to `../_shared/`: that directory is vendored into
`.claude/skills/_shared/` by the converge core, so the rewritten paths resolve
in a consumer project rather than dangling.

**Falsifier — "Corpus muddiness or a claim that outran the code passes without
a finding."** Each half has a pass that catches it. Muddiness: pass 1 enforces
self-containment, current-state-only, story form, decision form, TOC
consistency, and cross-reference integrity. A claim that outran the code: pass
2 folds `audit-check`'s `violated` determinations in verbatim, and pass 4 builds
the surface inventory from reality first and reports "claimed and contradicted"
against it.

**Falsifier — "the audit fixes artifacts itself; the run writes anything — the
intake included."** Negated by step 1 and by the NOT-do list's "Does not fix
anything — not even mechanical findings. The caller fixes; the audit
re-verifies."

**Falsifier — "the mechanical/judgment classification is missing."** Negated
per pass, above.

**Proof — "an audit over a corpus seeded with a known compliance violation, an
uncovered claim, and a cross-artifact contradiction, after which a third party
finds all three in the caller's report with the judgment items classified as
such, and the working tree — intake included — unchanged."** The story is
annotated in `test/proofs.sh`, whose `corpus-audit` block runs over both copies
of the verb — the family source and the vendored
`.claude/skills/ok-planner-audit/SKILL.md` this project actually runs —
asserting the four passes are present, that the report contract still carries
the mechanical/judgment class, and that the read-only stance stands verbatim
(in-context report, `Create nothing.`, no intake writes, no proof execution).
The block gained one assertion this cycle that is not presence: the
token-resolution conjunct above. All pass on the current tree.

The weakness is recorded rather than waved through. The seeded run itself is
exhibited by nothing: the verb is a prompt whose findings come from four
subagents reading prose, so planting a compliance violation and reading it back
out of a report is inherently agentic, and the harness names that at the
assertion with the file and step that carry it. The consequence is that the
Proof field's three detection observables are asserted only as the governing
text that would produce them, and the tree-unchanged observable only as the
verb's stated read-only stance — not as a before/after listing, the technique
`sketch-an-idea`'s block does use against its own fixture. The four-passes
assertion is also a heading grep: a pass emptied of its prompt body would still
satisfy it, and only the token conjunct partially guards that. What the block
does buy is coverage of the vendored copy as well as the source, so a converge
that dropped a pass or softened the stance turns it red.

## Determination

**satisfied.**

Every Acceptance clause has a citable enforcement point in the verb a project
runs. The repaired clause reads correctly against reality: the four *checks* it
now names — compliance, proof coverage, intent drift, cross-artifact conflict —
are four fully specified dispatch sections, each with its own procedure and
output contract, and every block they transclude resolves to exactly one
canonical definition. The read-only stance holds through the one executable the
verb delegates to. The mechanism side is corroborated rather than contradicted
by the rest of the corpus: the certification core's one-path sentence agrees,
and `story:corpus-proof`'s counterpart clause agrees.

This determination stops holding if: the verb reacquires a write of any kind,
to the intake or elsewhere (step 1's "Create nothing." and the NOT-do line break
first), or `audit-check` gains a write path; any of the four named checks is
deleted or demoted to a mention, making the "real, not stubbed" clause an
overclaim; a transcluded block loses its canonical heading or acquires a second
one (the token conjunct breaks first); any pass's output format drops the class,
or step 7 stops requiring the class to survive into the report; the report is
split per pass so the caller no longer receives one; the vendored copy drifts
from the source, or `_shared/` stops being vendored so the rewritten
transclusion paths dangle; or `test/proofs.sh` loses its `corpus-audit` block or
its `@story:` annotation. It would also weaken — without strictly falsifying —
if the block's detection assertions stay text-presence-only once a deterministic
residue becomes available, for instance a fixture exercising that the one
executable the verb invokes leaves the tree untouched.

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
- cite-span: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "7. **Report to the caller** — machine-readable, in-context:" +12 sha256:c753d8f98232
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not execute proofs"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing."
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "returns everything in-context, and writes nothing"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "Class: `mechanical` or `judgment`. The line is intent, not"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: corpus-audit"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "audit_copy_check() {" +29 sha256:eff0ecac23da
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# The seeded-corpus run is agentic (four subagent passes reading a" +7 sha256:23e80bad87e7
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# {{TOKEN}} the verb uses is resolved here against the shared directory —" +3 sha256:40dad09d6b5e
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "the vendored verb this project runs"
- cite-file: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-file: .claude/skills/ok-planner-audit/SKILL.md @ sha256:5c079142d7b5
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:57bedf31463e
