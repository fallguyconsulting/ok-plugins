---
audit: rules-compliance-report
artifact: story:rules-compliance-report
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:e607b3a97c95
---

# Does every rules-bearing family deliver a read-only, grouped, mechanical-vs-judgment drift report over its own rulebook, modifying nothing?

## Claims

**Title — "Read-only report of drift from declared rules."** Each family exposes
a compliance verb whose own description declares it read-only and whose body
ends by proposing rather than applying. None of the three writes to the project
under any argument. Honored.

**Acceptance clause 1 — "violations and residue are reported grouped by rule and
location."** For ok-plumbline the verb echoes the raw violation list — each line
carrying file, line number and rule code — then prints a tally grouped by rule
code and a tally grouped by file. For ok-planner the report is per-finding with
the artifact or code site as the location, assembled from four passes. For
ok-workspaces each finding is keyed to its check and carries file:line evidence.
Rule and location are present in all three. Honored.

**Acceptance clause 2 — "with a remediation view distinguishing what is
mechanically fixable from what needs judgment."** ok-plumbline's verb defines
the two classes explicitly and assigns concrete violation shapes to each;
ok-workspaces' verb defines them against its four checks and requires every
finding to be classified, defaulting to judgment when unclear; ok-planner's
passes each classify per the corpus's canonical mechanical-vs-judgment rule.
Honored.

**Acceptance clause 3 — "the verb proposes and stops — nothing in the project is
modified."** ok-plumbline's run block invokes the lint read-only and its
reporting section forbids applying fixes without authorization. ok-workspaces'
verb states outright that it fixes nothing and that the caller drives the loop.
ok-planner's verb goes furthest: its first instruction is to create nothing at
all, not even its own layout, and to report a missing directory rather than
materialize one. The proof asserts this behaviourally for ok-plumbline by
comparing `git status --porcelain` before and after a run, and textually for
ok-planner by asserting its verb carries no directory-creating command. Honored.

**Acceptance clause 4 (quantified) — "Each rules-bearing family delivers this
over its own rulebook with its real checking machinery."** The population is the
set of skill families, enumerated from the payload directory itself — three:
ok-planner, ok-plumbline, ok-workspaces (the same three the repo's maintenance
check pins). Each is rules-bearing: each materializes a rules layer into its
consumers. Each has a compliance verb, and each verb checks its *own* rulebook
with the family's *own* machinery:

- ok-plumbline — the lint's two checks over the comment and citation rules,
  executed by the project's vendored binary (falling back to the payload copy
  with an announcement).
- ok-planner — the design-corpus rules, executed by four dispatched passes plus
  the vendored deterministic audit-corpus checker, whose output is folded in
  verbatim as authoritative rather than re-derived.
- ok-workspaces — the discipline's three cheatsheet rules, executed as four
  named checks driven off the committed profile (mutable tags in verification
  paths, runtime-isolation parameterization, worktree naming, src-tag
  consumption), each with a concrete evidence-producing command.

The front door itself is not rules-bearing (it materializes no project estate)
and the conduct is a user-scoped output style, not a family, so neither enters
the population. Honored. Recorded as a qualification, unchanged from the
previous cycle: ok-workspaces' checks are executed by the agent following the
verb's instructions rather than by a committed script, which is thinner
machinery than the other two but is the family's real and only checking
apparatus for those rules.

**A note on this cycle's change.** The story's catalog line was repaired this
cycle from "a plugin's declared rules" to "a skill family's declared rules",
bringing the generated table of contents into agreement with the story file's
own text, which already read "skill family". Nothing normative moved: the
artifact's own hash is unchanged, and the enumerated population — families, not
plugins — is the one the previous audit already used. The repair removes a
reading under which the front door and the conduct would have entered the
population as "plugins", which they do not.

**Falsifier — "The report mutates the project; real drift goes unreported; or
proposed fixes are applied without the owner's direction."** Limb 1 is negated
by clause 3 and its before/after assertion; limb 2 by the compliance run over a
seeded backlog, which surfaces both seeded shapes and the specific seeded file;
limb 3 by each verb's explicit stop-before-applying instruction. Honored.

**Proof — "a compliance run over a project seeded with known violations of the
family's rules, producing a grouped report a third party can reconcile against
the seeded defects, with the working tree unchanged."** The registered proof
seeds a repository with four known violations across two shapes and two
languages, executes the ok-plumbline compliance verb's own run block (extracted
from the SKILL.md, so the tested artifact is the shipped verb rather than a
paraphrase), and asserts the output carries the by-category heading, the by-file
heading, the rule code, and a specific seeded file — reconcilable against the
seed. It then asserts the porcelain status is byte-identical before and after.
The extraction helper it uses was refactored this cycle to take a path rather
than a verb name, so the block under test is still the shipped verb's own; the
assertions are unchanged. Deterministic and green as of this audit.

**Proof coverage against the Acceptance.** Clauses 1–3 are exercised
behaviourally for ok-plumbline. Clause 4's quantifier is exercised for all three
families only textually: a second proof loops the three families and asserts
each verb declares itself read-only and carries both remediation classes, plus
that ok-planner's verb creates no directory. That is a real per-family assertion
that would go red if a family's verb were removed or lost its remediation view,
but it does not execute ok-planner's or ok-workspaces' machinery. Recorded as a
partial; the Proof field asks for a run over one family's rules, which is
delivered.

## Determination

**satisfied.** All three families in the population carry a compliance verb over
their own rulebook, each grouping findings by rule and location, each splitting
remediation into mechanical and judgment, and each proposing without writing —
with ok-planner's verb declining even to create its own layout. The proof
reconciles a real run against seeded defects and asserts an unchanged working
tree, and a second proof holds the per-family quantifier at the text level. This
cycle's catalog repair aligned the story's summary line with the story itself
and with the population this audit enumerates.

This stops holding if: a fourth rules-bearing family is added without a
compliance verb (the family enumeration is the thing to re-check, not the
verbs); any verb gains a write path that is not the owner's explicit act; a verb
drops its mechanical/judgment split or its grouping; ok-plumbline's verb stops
preferring the project's vendored binary, so the report would describe rules the
project does not lint against; or the per-family roster proof is removed,
leaving the "each family" quantifier unexercised.

## Citations

- cite: checks/vendored-layer :: "FAMILIES = ("ok-planner", "ok-plumbline", "ok-workspaces")"
- cite-span: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "by category:"" +8 sha256:6f2bdf711ae9
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "bin=".ok-plumbline/bin/plumbline""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "  - **mechanical** — the fix is fully determined and changes no decision: residue, restatement, dividers, commented-out code, TODO markers (delete), and citations whose slug is a typo or a rename away from resolving (repoint)."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project — it does not even ensure its own layout: if `.ok-planner/issues/` or `.ok-planner/history/issues/` is absent, report that in the findings (the front door's administration materializes the layout) and carry on. (When assembling the dispatches below, `{{LEAF-AGENT-RULE}}` transcludes from `skills/_shared/dispatch-discipline.md`; the other tokens from `skills/_shared/artifact-definitions.md`.)"
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "Read-only sweep of the project against the mechanical rules the discipline admits. Reports findings with file:line evidence; fixes nothing (the caller fixes and re-runs). Read `.ok-workspaces/config.json` first — the profile decides which checks apply."
- cite-span: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "## Checks" +6 sha256:818c51895ce6
- cite-file: .ok-planner/design/stories.md @ sha256:a2bf08454f3a
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:9dbae600c267
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_roster_proof() {" +30 sha256:1fb51885f4a8
