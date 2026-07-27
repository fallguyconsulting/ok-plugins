---
audit: no-execution-engine
artifact: decision:no-execution-engine
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:e6e81610d2b6
---

# Does the planner genuinely ship no execution machinery and no plan artifact, with every sprint self-driving instead?

## Claims

**Title / Choice clause 1 — "The planner ships no execution machinery and defines
no plan artifact."** The quantifier is over the verbs the family ships.
Re-enumerated from reality for this audit — the converge core's `SKILLS` map,
which is what a consumer project actually receives, cross-checked against the
directory listing of `skills/` (the same ten plus `_shared/`) — the population is
ten: audit, certify-all, certify-work, discover-design, ok-planner, ok-version,
plan-sprint, prove, sketch, verify-issues. Checked member by member, none stages,
sequences, or drives work: the planning verb is terminal at the approved sprint,
the two gates certify work already done, the corpus verbs report, the bootstrap
extracts, the sketch verb captures, the verifier prepares issues, the version verb
recites, and the router routes. A search of the family for any plan template or
plan artifact returns only the `plan-sprint` skill directory, the two consumer
templates whose filenames merely contain the family name, and prose mentions; the
family carries no runner and no scheduler. Honored.

**Choice clause 2 — "a sprint is never rewritten into a plan."** Honored, and
stated in three independent places so that deleting one does not lose it: the
sprint's own baked execution section ("It is never rewritten into a plan
document: this sprint is the whole brief"), the family router ("Never turn a
sprint into a plan document."), and the consumer-side estate template ("a sprint
is never rewritten into a plan document"), with the cheatsheet carrying the same
rule from the staging side. Three of those are additionally pinned by a
repository maintenance check registered under this decision's own `@decision:`
annotation, so a deletion or rewording turns an assertion red before any reader
notices; the check passes on the tree as it stands.

**Choice clause 3 — "staging happens at execution time in the executor's own
working state."** Honored: the boilerplate's step 2 tells the executor to group
and order the flat items itself and locates the result in the executor's working
state — a task list, an orchestrator's graph — and the ceremony separately
terminates at the approved sprint with "do not implement, do not invoke further
skills, do not write plans."

**Choice clause 4 — "every sprint bakes a fixed execution-shape section plus the
completion contract."** The quantifier is over the sprints that exist.
Re-enumerated from reality: `.ok-planner/sprints/` holds one live sprint
(`2026-07-27-mechanical-release-audit-masking.md`) and `history/sprints/` holds
three, so the population is four — unchanged since the last audit. All four carry
both `## How to execute this sprint` and `## Completion contract` as top-level
sections, confirmed by counting the two headings in each file. All four are
pinned below, so a fifth sprint or an edit to any of them re-opens this audit.
The source of the property is the ceremony's rule that both sections are "fixed
boilerplate — include both verbatim in every sprint". Honored.

**Choice clause 5 — "so it can be picked up inline, handed to a goal-driving
harness mechanism, or dispatched to any orchestrator unchanged."** Honored: the
boilerplate names exactly those three executor shapes — "an inline working
session, an agent this file is handed to via the native `goal` mechanism, or an
orchestrator that does its own planning" — and says they proceed the same way,
and the live sprint carries that sentence verbatim. What makes the claim more
than an assertion is that the artifact carries its own stop condition: the
completion contract's four numbered conditions are what an executor of any shape
owes, regardless of shape.

**Rationale — "executor-agnosticism through the artifact rather than through an
engine … The verification burden an engine would carry lives instead in the
corpus itself (proofs with exhibited falsifiers) and the terminal gates."**
Honored as a capability claim. The proofs-with-falsifiers half is a real
authoring obligation on the executor ("Every new or amended story gets its proof:
a deterministic integration test (or demo) present, carrying its `@story:`
annotation, and able to actually fail under the story's falsifier"), and the
terminal-gate half is the contract's requirement that `/certify-work` be run last
and come back clean. It is an authoring rule enforced by review rather than by a
runtime — the honest reading of a decision that declines to build a runtime.

**Alternatives — a workflow engine with plan documents; a required
orchestrator.** Both are genuine roads not taken, and the second is negated
explicitly by "an inline working session" being listed first among the three
executor shapes, and by the router's "Executing a sprint needs no orchestrator."

## Determination

**satisfied.** Every clause of the Choice has a citable enforcement point, and
the two quantified clauses were re-enumerated member by member against reality:
the ten vendored verbs contain no execution machinery and no plan artifact, and
all four sprint documents in the estate — the live one plus three archived —
carry both baked sections. The negative half of the decision is protected by
three independent prose prohibitions plus a mechanical presence assertion that
turns red if any governing line is deleted or reworded; the positive half is
realized by fixed boilerplate the ceremony requires verbatim, which is what lets
the sprint be the whole brief for any of the three executor shapes.

Re-derived, not carried: this audit went stale only because the checker's mask
gained a family-scoped rule that normalizes a `v9.0.0` literal in one archived
sprint's prose, changing that file's masked hash with nothing in the file itself
changed — confirmed against git, which reports all four sprint files unmodified.
Nothing substantive about this decision moved, and the re-derivation above found
the same population and the same enforcement points. The stale-pin mechanics are
recorded against `decision:adversarial-implementation-audits`; the pin is simply
re-taken here.

This stops holding if: the converge `SKILLS` map gains a verb that executes or
stages sprints (the pinned span over the map and the whole-file pin on the core
both break); a plan template appears in the family, or any of the three "never a
plan document" statements is deleted (the `text-presence` check fails first); the
ceremony stops requiring both boilerplate sections verbatim, or a sprint is
produced without them — the four sprint pins break on either, and a newly planned
sprint appearing in `sprints/` enlarges the population and forces this audit to be
re-derived; staging migrates out of the executor's working state into a written
artifact; or the completion contract stops being carried inside the sprint and
becomes an engine's responsibility. It would also warrant a fresh look if the
Rationale's "proofs with exhibited falsifiers" were tightened into a
machine-checked claim, since today it is an authoring rule enforced by review.

## Citations

- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The implementation itself happens elsewhere"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "It is never rewritten into a plan document"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "nothing is built on something not yet there. Staging lives in the"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "an agent this file is handed to via the native"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "## How to execute this sprint" +73 sha256:bb08a9fbb4e8
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "## Completion contract" +15 sha256:d4044e6a5ec4
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "4. Build stage by stage. Every new or amended story gets its proof: a" +6 sha256:6c7779bf633e
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The **How to execute this sprint** and **Completion contract** sections are fixed boilerplate"
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "Never turn a sprint into a plan document."
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "Executing a sprint needs no orchestrator"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "it is execution's job — never write a plan document from one."
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "a sprint is never rewritten into a plan document"
- cite: checks/text-presence :: "# @decision: no-execution-engine"
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:75db5f704edb
- cite-file: .ok-planner/sprints/2026-07-27-mechanical-release-audit-masking.md @ sha256:493ef1cb6663
- cite-file: .ok-planner/history/sprints/2026-07-25-ruled-intake-drain.md @ sha256:f37924f3eebd
- cite-file: .ok-planner/history/sprints/2026-07-26-vendored-suite-conduct-split.md @ sha256:b243ceed76fe
- cite-file: .ok-planner/history/sprints/2026-07-27-skill-families-audit-reconciliation.md @ sha256:faa6d1d91f3e
