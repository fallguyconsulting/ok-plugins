---
audit: rules-compliance-report
artifact: story:rules-compliance-report
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:e607b3a97c95
---

# Does every rules-bearing family deliver a read-only, grouped, mechanical-vs-judgment drift report over its own rulebook, modifying nothing?

Refreshed. The design artifact's hash is unchanged. The one stale citation is
the whole-file pin on `plugins/ok/families/ok-planner/skills/audit/SKILL.md`,
moved by this cycle's fix loop repointing step 7's closing paragraph from a
single-path to a two-gated-path description of how findings reach
`.ok-planner/issues/` (the same edit `story:corpus-audit` reads in full).
That paragraph is outside this story's own cited territory — Acceptance
clause 3's evidence is "1. Create nothing. This verb is read-only against
the project", which is unchanged and unaffected. Citation regenerated;
nothing else touched.

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
set of skill families, enumerated this cycle from the payload directory itself
rather than from any list in the code — exactly three directories under
`plugins/ok/families/`: ok-planner, ok-plumbline, ok-workspaces. Each is
rules-bearing: ok-planner materializes its cheatsheet and estate guide, ok-plumbline
its cheatsheet and style guide, ok-workspaces its three-rule cheatsheet written
into the consumer's rules layer by its converge core. Each has a compliance verb
at the conventional `skills/audit/` path, and each verb checks its *own* rulebook
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
the population. Honored.

Two qualifications recorded rather than charged. First, unchanged from the
previous cycle: ok-workspaces' checks are executed by the agent following the
verb's instructions rather than by a committed script, which is thinner
machinery than the other two but is the family's real and only checking
apparatus for those rules. Second, sharpened this cycle: **both** mechanical
guards over this quantifier enumerate the families from a remembered tuple, not
from the directory — the repo check hard-codes
`FAMILIES = ("ok-planner", "ok-plumbline", "ok-workspaces")` and the roster proof
loops the same three literals. That is precisely the "every enforced on
remembered members" shape, so I did not rely on either: the population above was
listed from the filesystem, and it happens to equal the remembered list today. A
fourth family added without touching those two literals would be invisible to
both guards; nothing about the claim would be false at that moment, but nothing
would be checking it either. The story's claim holds on reality as enumerated.

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
Re-run this cycle: the whole plumbline harness is green, both cited proof spans
are byte-identical to the ones the prior audit cited, and the compliance and
roster assertions pass.

**Proof coverage against the Acceptance.** Clauses 1–3 are exercised
behaviourally for ok-plumbline. Clause 4's quantifier is exercised for all three
families only textually, and only over the remembered roster: the second proof
loops three hard-coded family names and asserts each verb declares itself
read-only and carries both remediation classes, plus that ok-planner's verb
creates no directory. That is a real per-family assertion that would go red if a
listed family's verb were removed or lost its remediation view, but it does not
execute ok-planner's or ok-workspaces' machinery and it would not notice a fourth
family. Recorded as a partial; the Proof field asks for a run over one family's
rules, which is delivered in full.

## Determination

**satisfied.** All three families in the population — enumerated this cycle from
the payload directory rather than from any code list — carry a compliance verb
over their own rulebook, each grouping findings by rule and location, each
splitting remediation into mechanical and judgment, and each proposing without
writing, with ok-planner's verb declining even to create its own layout. The
proof reconciles a real run against seeded defects and asserts an unchanged
working tree, and a second proof holds the per-family quantifier at the text
level.

Re-derived, not carried: this audit went stale only because the story catalog's
whole-file pin moved when the sprint's new story was appended to it. The catalog
line for this story is unchanged and still reads "a skill family's declared
rules", which is the reading the population above uses; nothing normative moved,
and the artifact's own hash is unchanged. Every clause was re-checked against
current bytes and the plumbline harness re-run green.

Refreshed again this cycle for the same mechanical reason: the catalog gained
three more appended entries (`explain-lint-rules`, `pipeline-check-wiring`,
`trace-corpus-to-code`, all belonging to an unrelated corpus-view feature),
moving the whole-file pin a second time. This story's own catalog line is
untouched — still "a skill family's declared rules" — so nothing this audit's
population reading rests on moved.

This stops holding if: a fourth rules-bearing family is added without a
compliance verb — and note that neither the repo check nor the roster proof would
catch it, since both enumerate from a remembered tuple, so the family directory
is the thing to re-list, not the verbs; any verb gains a write path that is not
the owner's explicit act; a verb drops its mechanical/judgment split or its
grouping; ok-plumbline's verb stops preferring the project's vendored binary, so
the report would describe rules the project does not lint against; a family stops
materializing a rules layer, so it leaves the population; or the per-family
roster proof is removed, leaving the "each family" quantifier unexercised even
at the text level.

## Citations

- cite: checks/vendored-layer :: "FAMILIES = ("ok-planner", "ok-plumbline", "ok-workspaces")"
- cite-span: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "echo "by category:"" +8 sha256:6f2bdf711ae9
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "bin=".ok-plumbline/bin/plumbline""
- cite: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md :: "  - **mechanical** — the fix is fully determined and changes no decision: residue, restatement, dividers, commented-out code, TODO markers (delete), and citations whose slug is a typo or a rename away from resolving (repoint)."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "Read-only sweep of the project against the mechanical rules the discipline admits."
- cite-span: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "## Checks" +6 sha256:818c51895ce6
- cite: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md :: "Classify every finding; when the class is genuinely unclear, call it"
- cite: plugins/ok/families/ok-workspaces/scripts/converge.js :: "fs.writeFileSync(path.join(rulesDir, 'ok-workspaces-cheatsheet.md'), cheatsheet);"
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_adoption_proof() {" +98 sha256:9dbae600c267
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_roster_proof() {" +30 sha256:1fb51885f4a8
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:bf7abd501b40
- cite-node: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md @ sha256:e98581de78d4
- cite-node: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md @ sha256:2429e6e6f72d
