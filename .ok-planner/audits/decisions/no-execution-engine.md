---
audit: no-execution-engine
artifact: decision:no-execution-engine
determination: satisfied
audited: 2026-07-28T09:44:34Z
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
plan-sprint, prove, sketch, verify-issues. Checked member by member against each
skill's own frontmatter description and, where the verb could plausibly drive
work, its body: none stages, sequences, or drives work. The planning verb is
terminal at the approved sprint ("do not implement, do not invoke further skills,
do not write plans"), the two gates certify work already done, the corpus verbs
report — `/prove` executes proofs, and it discovers the project's own test runner
rather than shipping one — the bootstrap extracts, the sketch verb captures, the
verifier prepares issues, the version verb recites, and the router routes. A
search of the family for any plan template or plan artifact returns only the
`plan-sprint` skill directory, the two consumer templates whose filenames merely
contain the family name, the checker's fixture dot-directories, and prose
mentions; the family carries no runner and no scheduler.

The two most recent additions to the family were re-tested against this clause
rather than assumed, since both are machinery: the `source-graph` script is an
extractor and drift checker over the source tree (its own header: "The graph
carries no judgment and nothing hand-written"), and the certification core's
change inspector and reconciliation ledger are gate-time judgment and bookkeeping
over a diff. Neither stages work, orders work items, or produces a plan artifact;
the ledger's closure condition ("The gate does not present as clean while any hunk
lacks a disposition") is a certification stop condition, not an executor. Honored.

**Choice clause 2 — "a sprint is never rewritten into a plan."** Honored, and
stated in four independent places so that deleting one does not lose it: the
sprint's own baked execution section ("It is never rewritten into a plan
document: this sprint is the whole brief"), the family router ("Never turn a
sprint into a plan document."), the consumer-side estate template ("a sprint
is never rewritten into a plan document"), and the cheatsheet carrying the same
rule from the staging side. Three of those — the two plan-sprint sentences and
the estate template's — are additionally pinned by a repository maintenance check
registered under this decision's own `@decision:` annotation, so a deletion or
rewording turns an assertion red before any reader notices; `checks/text-presence`
exits 0 on the tree as it stands, verified by running it this cycle.

**Choice clause 3 — "staging happens at execution time in the executor's own
working state."** Honored: the boilerplate's step 2 tells the executor to group
and order the flat items itself and locates the result in the executor's working
state — a task list, an orchestrator's graph — and the ceremony separately
terminates at the approved sprint with "do not implement, do not invoke further
skills, do not write plans." The ceremony's own "What this skill does NOT do"
repeats the negative from the other side ("Does not stage, phase, or theme the
work items — sequencing is execution's job").

**Choice clause 4 — "every sprint bakes a fixed execution-shape section plus the
completion contract."** The quantifier is over the sprints that exist, and the
population moved again since the last audit — which is why this audit went stale.
Re-enumerated from reality, not from the prior audit's text: `.ok-planner/sprints/`
is now **empty** (the sprint the prior audit pinned as live,
`2026-07-27-source-graph-certification.md`, was archived and its file rehashed by
the `closed:` frontmatter stamp the close-out writes), and
`.ok-planner/history/sprints/` holds **six**. So the population is six, all of
them archived, and the prior audit's "one live plus five archived" is now false in
both halves. All six carry exactly one `## How to execute this sprint` and exactly
one `## Completion contract` as top-level sections, confirmed by counting both
headings in each file; five of the six also carry the `closed:` stamp (the oldest,
`2026-07-25-ruled-intake-drain.md`, predates that mechanism, which is the case the
ceremony's baseline resolution explicitly handles). All six are pinned below, so
an edit to any of them re-opens this audit. The source of the property is the
ceremony's rule that both sections are "fixed boilerplate — include both verbatim
in every sprint"; the newest member remains the strongest evidence the rule is
live rather than historical, since it was produced by the ceremony after the
prior audit and carries the boilerplate verbatim, including the sentence naming
the three executor shapes.

**Choice clause 5 — "so it can be picked up inline, handed to a goal-driving
harness mechanism, or dispatched to any orchestrator unchanged."** Honored: the
boilerplate names exactly those three executor shapes — "an inline working
session, an agent this file is handed to via the native `goal` mechanism, or an
orchestrator that does its own planning" — and says they proceed the same way,
and the most recent sprint carries that sentence verbatim. What makes the claim
more than an assertion is that the artifact carries its own stop condition: the
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
all six sprint documents that exist — every one of them now archived — carry both
baked sections. The negative half of the decision is protected by four
independent prose prohibitions plus a mechanical presence assertion that turns red
if any of three governing lines is deleted or reworded; the positive half is
realized by fixed boilerplate the ceremony requires verbatim, which is what lets
the sprint be the whole brief for any of the three executor shapes.

Re-derived, not carried. This audit went stale not on a rotted hash but on a moved
artifact: the sprint it pinned as live no longer exists at that path, because the
close-out archived it to `history/sprints/` and stamped it with its closing
commit. Both facts the prior Claims asserted about where sprints live were checked
directly and rewritten — `sprints/` is empty, `history/sprints/` holds six — and
the archival mechanism that produces that state is now pinned rather than assumed.
The rest of the artifact was re-read whole against reality: the converge `SKILLS`
map is unchanged at the same ten verbs, every governing sentence still exists at
its anchor, `checks/text-presence` still exits 0, and each of the six sprints was
counted for both headings. Nothing about the decision itself moved — its hash is
unchanged, so untouched clauses stand on re-verified evidence rather than on
precedent alone.

Citations were re-homed onto the committed source graph where the node form
carries the verdict as well or better: the converge core's population pin is now a
whole-file `cite-node:`. The sub-node spans (the `SKILLS` map, the two boilerplate
sections inside the ceremony's fenced template, the proof-authoring step) and the
existence anchors are kept in their finer forms, since a heading-section node
would be strictly coarser than the span that actually carries each verdict. The
`.ok-planner/` estate — the archived sprints — is not in the graph and keeps
`cite-file:` pins.

This stops holding if: the converge `SKILLS` map gains a verb that executes or
stages sprints (the pinned span over the map and the whole-file node pin on the
core both break); a plan template appears in the family, or any of the four "never
a plan document" statements is deleted (for three of them the `text-presence`
check fails first); the ceremony stops requiring both boilerplate sections
verbatim, or an archived sprint is edited to drop them — the six sprint pins break
on either; staging migrates out of the executor's working state into a written
artifact; or the completion contract stops being carried inside the sprint and
becomes an engine's responsibility. It would also warrant a fresh look if the
Rationale's "proofs with exhibited falsifiers" were tightened into a
machine-checked claim, since today it is an authoring rule enforced by review.

One tripwire is judged rather than mechanical, and is named here so the gap is not
mistaken for coverage: a **new** sprint appearing in `.ok-planner/sprints/`
enlarges clause 4's population without breaking any pin, because no citation form
pins a directory's membership. Nothing catches that but re-enumeration — this
audit's own, or certification's change inspector nominating it. That is precisely
the failure mode this cycle corrected, and any future re-audit must re-list both
sprint directories from disk before repeating a count.

## Citations

- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
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
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "archive the sprint (and its promoted issue receipts) to"
- cite: checks/text-presence :: "# @decision: no-execution-engine"
- cite-file: .ok-planner/history/sprints/2026-07-25-ruled-intake-drain.md @ sha256:f37924f3eebd
- cite-file: .ok-planner/history/sprints/2026-07-26-vendored-suite-conduct-split.md @ sha256:b243ceed76fe
- cite-file: .ok-planner/history/sprints/2026-07-27-mechanical-release-audit-masking.md @ sha256:52eadd17e037
- cite-file: .ok-planner/history/sprints/2026-07-27-plumbline-esm-scope.md @ sha256:7e5eae3664cf
- cite-file: .ok-planner/history/sprints/2026-07-27-skill-families-audit-reconciliation.md @ sha256:faa6d1d91f3e
- cite-file: .ok-planner/history/sprints/2026-07-27-source-graph-certification.md @ sha256:3eabd5c24f04
