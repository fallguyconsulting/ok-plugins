---
audit: corpus-audit
artifact: story:corpus-audit
determination: violated
audited: 2026-07-27T12:26:54Z
artifact-hash: sha256:d6caf4d240b6
issue: audit-verb-intake-channel
---

# Does the corpus audit file its judgment calls to the owner's intake queue?

## Claims

**Title — "Audit the corpus and file the judgment calls."** Not honored. The
verb's identity in the shipped text is the opposite of a filer: its frontmatter
description reads "A pure reporter: findings return in-context, nothing is
written", its opening paragraph calls it "a pure reporter — the corpus-side
reviewer, the exact peer of a code reviewer", and its NOT-do list closes with
"Does not touch the issue intake — no filing, no editing, no closing." The
router table in the family's own `ok-planner` skill carries the same one-line
identity.

**Story clause — "with mechanical defects reported for immediate fixing and
judgment questions filed to my intake queue, so that design rot surfaces as an
owner-calibrated worklist."** Half honored. Mechanical defects are indeed
reported for the caller to fix in-cycle, and the `mechanical`/`judgment` class
is attached to every finding. But the class is explicitly demoted to "advisory
context for whoever consumes the report, never routing", and nothing files: the
worklist the clause promises is assembled by whoever reads the report, not by
the verb.

**Acceptance 1 — "the caller receives the mechanical findings to fix in-cycle
and re-runs to clean."** Honored. The report is machine-readable and
in-context, and its closing paragraph instructs the caller to re-run until
clean.

**Acceptance 2 — "genuine judgment findings appear as deduplicated open rows in
the intake queue."** Not honored, on both halves. No finding of any class
reaches `.ok-planner/issues/` from this verb: process step 1 is "Create
nothing. This verb is read-only against the project", and the report step says
"The caller decides what happens next; the audit routes nothing." The
deduplication the clause names lives elsewhere — in the certification loop's
dedup step and in the architect's check against slugs already present in the
intake — not in the audit.

**Acceptance 3 — "nothing else in the project is written."** Vacuously true of
the code, but only because the write it excepts ("nothing *else*") does not
happen either; the clause presupposes an append that does not exist.

**Acceptance 4 — "Its append to the queue is reporting, not fixing."** Not
honored: there is no append. The successor path is named explicitly in the same
file — inside certification "only the architect's confirmed forks are promoted
to `.ok-planner/issues/`"; standalone, the report goes to the human who invoked
it, who files what they judge fork-worthy. The shared certification core states
the rule from the other side: "Promotion is the loop's only path to the intake,
and the owner is never asked live."

**Acceptance 5 — "the verb is otherwise read-only against corpus and code."**
Honored, and stated twice.

**Acceptance 6 — "and it never executes proofs."** Honored — "Does not execute
proofs — that's `/prove`. The intent-drift check reads; it never runs."

**Acceptance 7 — "The four-pass audit (compliance, coverage-and-drift,
cross-artifact consistency, surface inventory) is real."** Honored, and this
clause is now correct against reality: the population was enumerated from the
verb's own process steps, which dispatch exactly four review passes under those
four names, each a subagent with a full prompt. (This clause was the
pass-count error the previous cycle recorded; the repair landed.)

**Falsifier — "the audit fixes artifacts itself or writes terminal queue
events; judgment findings never reach the queue."** The second condition is met
by the implementation as it stands: judgment findings never reach the queue
from this verb.

**Proof — "an audit over a corpus seeded with a known compliance violation, an
uncovered claim, and a cross-artifact contradiction, after which a third party
finds the mechanical item in the caller's report and the judgment items as open
queue rows, with a second run appending nothing new."** The story carries no
annotated proof artifact: `rg -l '@story: corpus-audit'` outside `.ok-planner/`
and `.claude/skills/` returns nothing, and `test/proofs.sh` — which annotates
seven sibling stories — does not annotate this one. Two of the field's three
observables (judgment items visible as open queue entries, a second run
appending nothing new) cannot be exhibited under the shipped shape at all, so
what the proof must exercise is downstream of the pending ruling rather than
merely unwritten.

## Determination

**violated**, on the mechanism, not merely on proof coverage.

The story's central promise — stated in its title, its Story clause, and two of
its Acceptance clauses — is that the audit **files judgment findings to the
owner's intake**. The shipped verb deliberately does the opposite: it is a
declared pure reporter that writes nothing, and it names its successor channel
explicitly, which is what makes this a stale claim rather than an ambiguity.
The rest of the project agrees with the code, not with the story: the
certification core's single-path sentence, the family's own router row, and
`story:corpus-proof`'s counterpart clause all describe a world in which no
corpus-checking verb writes the intake.

Secondarily, the story carries no annotated proof artifact, and two of its
Proof field's three conjuncts are unexhibitable while the filing channel does
not exist.

The pass-count clause, which was the second independent violation last cycle,
is repaired and now reads correctly against the four dispatched passes.

To flip this determination, both the mechanism claims and the proof must be
addressed: the story must describe the channel that exists (the audit reports;
certification's architect promotes; a human files from a standalone run) and
carry a proof artifact exercising what the corrected Acceptance claims.
Changing the code to file instead would contradict the audit verb's declared
pure-reporter posture, `decision:prove-audit-audience-split`'s counterpart
claim, and the certification core's one-path sentence — which direction to take
changes what the project commits to, and is the owner's call.

This violation is linked to intake issue `audit-verb-intake-channel`, which
puts exactly that fork to the owner; it stands until a ruling lands and a
re-audit flips it.

## Citations

- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "The caller decides what happens next; the audit routes nothing."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "only the architect's confirmed forks are promoted to"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "3. **Pass 1 — compliance.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "4. **Pass 2 — coverage + intent-drift + annotation integrity.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "5. **Pass 3 — cross-artifact consistency.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "6. **Pass 4 — surface inventory.**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not execute proofs"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**"
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "| `/audit` | A pure reporter: findings return in-context, nothing is written. |"
- cite-file: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:f96535bcf843
