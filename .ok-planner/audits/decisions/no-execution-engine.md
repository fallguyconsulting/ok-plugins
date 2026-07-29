---
audit: no-execution-engine
artifact: decision:no-execution-engine
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:e6e81610d2b6
---

# Does the planner genuinely ship no execution machinery and no plan artifact, with every sprint self-driving instead?

Rewritten whole. The design artifact's hash is unchanged
(`sha256:e6e81610d2b6`), so precedent did not lapse — but the changed bytes land
squarely inside what four of the five Choice clauses rest on, which is the
rewrite condition rather than the amend condition. The v11.2.0 release reworded
the ceremony's **How to execute this sprint** and **Completion contract**
boilerplate substantially: step 2 was rewritten, a step 8 (the completion
report) was inserted, the contract's item 4 was replaced and made
repository-verifiable, and a **goal rule** was appended. Both boilerplate spans
and two of this audit's existence anchors went stale on that. The sprint
population also moved again — the corpus-browser sprint archived and a new live
sprint appeared, with a companion completion report beside it — the recurring
blind spot the prior two passes named, caught here by re-listing both
directories rather than by any pin.

Three things were tested adversarially this pass rather than assumed: whether
the reworded boilerplate still *states* clauses 2 and 3 at all; whether the
newly defined **completion report** is a plan artifact under clause 1; and what
the red `text-presence` check means for a determination the prior pass leaned
on it to support.

Amended. The design artifact's hash is unchanged and no other cited reality
moved: the fix cycle following that pass repointed `checks/text-presence`'s two
stale needles at the surviving wording, exactly as this audit's own note
called for. Re-read against clause 2 as required: the repointed needles carry
the same prohibition, the check now exits 0, and the determination — already
`satisfied` on prose alone — is corroborated by all three assertions again
rather than one. Citation regenerated; the paragraphs describing the interim
red state are corrected to describe the repair.

Amended again. The design artifact's hash is unchanged. The owner ratified
one further template change this cycle: the Completion contract's goal-rule
paragraph gained a sentence recognising a run parked at the review-fix
loop's cycle cap as a legal in-flight state, never grounds to report the
work done. That change lands squarely on clause 4's byte-for-byte claim and
clause 5's goal-rule claim, so it was re-verified rather than refreshed
blindly: the in-flight sprint's own Completion Contract section was
re-extracted and re-diffed against the current template, and it carries the
identical new sentence — the owner-ratified template change was carried into
the sprint in the same cycle, so the byte-for-byte match holds at its new,
longer length (124 lines, up from 121) rather than having lapsed. The
`#sprint-planning.process.3-draft-the-sprint` node (the whole drafting
template, which encloses both baked sections as a nested fenced block) moved
for the same reason and was re-checked on the same basis; the specific
sentence this decision's Rationale rests on ("The implementation itself
happens elsewhere") sits elsewhere in that block and is unchanged. Citations
regenerated; the byte count corrected in clause 4 above.

## Claims

**Title / Choice clause 1 — "The planner ships no execution machinery and
defines no plan artifact."** The quantifier is over the verbs the family ships.
Re-enumerated from reality — the converge core's `SKILLS` map, which is what a
consumer project actually receives, cross-checked against the directory listing
of `skills/` (the same eleven plus `_shared/`) — the population is **eleven**,
unchanged: audit, browse, certify-all, certify-work, discover-design,
ok-planner, ok-version, plan-sprint, prove, sketch, verify-issues. The pinned
`SKILLS =` span is byte-identical to the prior pass (re-confirmed, not assumed),
so no verb was added or removed. None stages, sequences, or drives work: the
planning verb is terminal at the approved sprint ("do not implement, do not
invoke further skills, do not write plans"), the two gates certify work already
done, the corpus verbs report, `/browse` starts a read-only server and writes
nothing, the bootstrap extracts, the sketch verb captures, the verifier prepares
issues, the version verb recites, and the router routes. A search of the family
for a plan template or plan artifact returns only the `plan-sprint` skill
directory, the two consumer templates whose filenames merely contain the family
name, the checker's fixture dot-directories, and prose mentions; the family
carries no runner and no scheduler.

Two pieces of machinery arrived with this release and both were tested against
this clause, because both are durable artifacts the planner now defines:

- The **completion report** is the sharper candidate: a file the planner
  defines, names, and requires. It is not a plan artifact and the corpus says so
  in its own words on both surfaces — `concept:completion-report` fixes it as
  "a record of one execution, never a plan document", and the boilerplate step
  that creates it closes "It is a record of this execution, never a plan
  document." Its content is retrospective by construction ("as each stage lands,
  record what was done, every divergence, and every call you made where the
  sprint was silent"), it is written *during and after* the work rather than
  before it, and nothing reads it to decide what to do next: the executor stages
  from the sprint, and the report's only consumers are the closing ceremony,
  which writes its presentation into it, and a goal checker, for which its
  absence means not-done. A plan artifact would have to sit between the sprint
  and the work and be *read* to sequence it; this one sits after the work and is
  read only to confirm it happened.
- The **inspection registry** is gate-time bookkeeping keyed to source-graph
  node identities — coverage accounting over a diff. It stages nothing, orders
  nothing, and is written only by a certification producer.

Honored.

**Choice clause 2 — "a sprint is never rewritten into a plan."** Honored, and
this is the clause the reword put under real pressure, so it was checked
statement by statement rather than by grep count. The boilerplate's own sentence
narrowed its subject: step 2 used to read "It is never rewritten into a plan
document: this sprint is the whole brief" and now reads "**Staging** is never
rewritten into a plan document: this sprint is the whole brief." The prohibition
survives there — and the "this sprint is the whole brief" half is untouched —
but the sprint-side statement of the rule now rests on the other surfaces, all
verified present as they stand:

- the family router: "Never turn a sprint into a plan document."
- the materialized consumer estate guide: "a sprint is never rewritten into a
  plan document" (this one is still mechanically pinned and its assertion
  passes)
- the always-in-context cheatsheet, from the staging side: "it is execution's
  job — never write a plan document from one."
- `concept:sprint`'s own invariant list, which closes "A sprint is never
  rewritten into a plan document."
- the ceremony's prose ahead of the template: "this skill never hands off to a
  planning or execution pipeline", and its NOT-do list's "Does not stage, phase,
  or theme the work items."

**The mechanical assertion, repointed since the last pass, is green again.**
The fixer did exactly what the prior pass's tripwire called for: `checks/text-presence`'s
two needles under `no-execution-engine` are repointed from the pre-v11.2.0
wording to the surviving sentences — "Staging is never rewritten into a plan
document: this sprint is the whole brief." and "build the list in your own
working state" — both read directly against `plan-sprint/SKILL.md` and both
present verbatim; the third needle (`ok-planner-CLAUDE.md`'s "a sprint is
never rewritten into a plan document") was already surviving and is
untouched. `checks/text-presence` exits 0 on this tree, re-run rather than
inferred. Read against clause 2 as the prior pass's note required: the new
first needle carries the same prohibition the old one did, now scoped
explicitly to staging rather than to the sprint generally, which is the same
narrowing this audit already read the boilerplate's own sentence as making —
the repointing tracks the reword rather than papering over a different claim.
The check file is pinned whole below, so any further edit to either needle or
to the wording it targets re-stales this audit again.

**Choice clause 3 — "staging happens at execution time in the executor's own
working state."** Honored, and if anything strengthened by the reword. Step 2
still assigns the grouping and ordering to the executor and still locates the
result in the executor's own state — "build the list in your own working state —
the harness's task tracking where available, one entry per stage; an
orchestrator uses its own graph" — and now additionally instructs the executor
to seed the closing entries into that same private list. The ceremony
separately terminates at the approved sprint ("do not implement, do not invoke
further skills, do not write plans") and its NOT-do list repeats the negative
from the other side ("sequencing is execution's job, decided at execution
time"). Nothing migrated staging into a written artifact: the one written
artifact the release added is retrospective (clause 1).

**Choice clause 4 — "every sprint bakes a fixed execution-shape section plus the
completion contract."** The quantifier is over the sprints that exist, and the
population moved for the third consecutive cycle without breaking any pin.
Re-enumerated from reality: `.ok-planner/sprints/` holds **one** live sprint,
`2026-07-28-ratify-inline-certification-repairs.md` (beside it sits its
completion report, `…-completion.md`, which is not a sprint and carries neither
heading — correctly, since it is a record); `.ok-planner/history/sprints/` holds
**seven**, the prior six plus the now-archived
`2026-07-28-corpus-browser-and-ruled-intake.md`, whose hash moved because
archival stamped its `closed:` frontmatter. The population is **eight**, and
every one of the eight carries exactly one `## How to execute this sprint` and
exactly one `## Completion contract` — counted per file, not sampled.

"Fixed" was tested mechanically rather than trusted, and this is the strongest
evidence in the audit: the live sprint's two sections were extracted and diffed
against the ceremony's template, and they match **byte for byte across all 124
lines** (up from 121 this pass — the template's goal-rule paragraph gained one
owner-ratified sentence, "A run parked at the review-fix loop's cycle cap
awaiting the owner's direction is a legal in-flight state … never grounds for
the run to take either cap step itself", and the live sprint's own Completion
Contract carries that exact sentence too, re-extracted and re-diffed rather
than assumed) — the reworded step 2, the new step 8, the replaced contract item
4, and the goal rule included. The seven archived sprints carry the pre-reword text of
the same two sections, which is what "fixed boilerplate" means for a record
written under an earlier version: the ceremony's rule is that both sections are
"fixed boilerplate — include both verbatim in every sprint", and the live sprint
demonstrates that rule enforced at authoring time, not merely preserved in
history.

**Choice clause 5 — "so it can be picked up inline, handed to a goal-driving
harness mechanism, or dispatched to any orchestrator unchanged."** Honored, and
materially strengthened. The boilerplate still names exactly those three
executor shapes — "an inline working session, an agent this file is handed to
via the native `goal` mechanism, or an orchestrator that does its own planning"
— and still says they proceed the same way. What was an assertion plus a
four-term stop condition is now a stop condition whose terms are declared
"verifiable from the repository as it stands", with item 3 reduced to a command
exit status and item 4 to the presence and completeness of a named file, plus an
explicit **goal rule** telling any checker the exactly-two ways the goal is met.
That is executor-agnosticism moving further *into* the artifact, which is the
direction this decision commits to.

**Rationale — "executor-agnosticism through the artifact rather than through an
engine … The verification burden an engine would carry lives instead in the
corpus itself (proofs with exhibited falsifiers) and the terminal gates."**
Honored. The proofs-with-falsifiers half remains a real authoring obligation on
the executor ("a deterministic integration test (or demo) present, carrying its
`@story:` annotation, and able to actually fail under the story's falsifier" —
that span is unchanged), and the terminal-gate half is the contract's
requirement that `/certify-work` be run last and come back clean. The release
shifted part of that burden from review toward mechanism — the contract's audit
term is now `audit-check --inspection` exiting 0 — which is a checker the
executor runs, not an engine that runs the executor.

**Alternatives — a workflow engine with plan documents; a required
orchestrator.** Both remain roads not taken; the second is negated explicitly by
"an inline working session" being listed first among the three executor shapes,
and by the router's "Executing a sprint needs no orchestrator."

## Determination

**satisfied.** Every clause has a citable enforcement point, and both quantified
clauses were re-enumerated member by member against reality rather than carried:
the eleven vendored verbs are unchanged and none executes or stages, and all
eight sprint documents that now exist — one live, seven archived — carry both
baked sections, with the live one matching the ceremony's template byte for byte
across all 121 lines. The two artifacts the release newly defines were tested as
plan-artifact candidates and neither is one: the completion report is
retrospective, is read only to confirm the work happened, and is called "never a
plan document" on both the concept and the boilerplate surface; the inspection
registry is coverage bookkeeping keyed to graph nodes.

The reword cost this decision something real for one cycle, now repaired: the
boilerplate's own "never rewritten into a plan document" sentence narrowed its
subject from the sprint to the staging, which briefly left two of the three
mechanical assertions red until the fixer repointed them at the surviving
wording. Neither the narrowing nor the interim red state ever falsified a
clause — the sprint-side prohibition still stands in the router, the
materialized estate guide, the cheatsheet, and `concept:sprint`'s invariants —
and the determination is once again carried by prose in five places plus all
three mechanical assertions green.

This stops holding if: the converge `SKILLS` map gains a verb that executes or
stages sprints (the pinned span over the map and the whole-file node pin on the
core both break); a plan template appears in the family, or the sprint-side
"never a plan document" statement is deleted from the router, the estate
template, the cheatsheet, and `concept:sprint` (the boilerplate's own sentence
is now about staging, so it no longer carries this clause alone); the completion
report acquires a forward-looking role — becoming something an executor reads to
decide what to build next, rather than a record of what it built; the ceremony
stops requiring both boilerplate sections verbatim, or any sprint is edited to
drop them (all eight sprint pins break on any); staging migrates out of the
executor's working state into a written artifact; or the completion contract
stops being carried inside the sprint and becomes an engine's responsibility;
or either repointed `text-presence` needle drifts from the wording it now
targets (the pin below re-stales this audit on any further edit).

The blind spot the prior two passes named is now confirmed three cycles running
and must be treated as a standing condition of clause 4, not an incident: a
sprint appearing in or leaving `.ok-planner/sprints/` changes this clause's
population without breaking any pin, because no citation form pins a directory's
membership. Only re-enumeration catches it — this audit's own, or
certification's change inspector nominating it. Any future re-audit must re-list
both sprint directories from disk before repeating a count, and must not mistake
a `-completion.md` file for a sprint.

## Citations

- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:8aa7cd5969fb
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "The view is read-only. Nothing in this verb writes to the working tree."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The implementation itself happens elsewhere"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Staging is never rewritten into a plan"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "order the groups so nothing is built on something not yet there,"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "It is a record of this execution, never a plan document."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "an agent this file is handed to via the native"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "**The goal rule, for any checker verifying this contract.**"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "## How to execute this sprint" +93 sha256:0c496a675e3c
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "## Completion contract" +30 sha256:6fab9c45028d
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "4. Build stage by stage. Every new or amended story gets its proof: a" +6 sha256:6c7779bf633e
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The **How to execute this sprint** and **Completion contract** sections are fixed boilerplate"
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.3-draft-the-sprint @ sha256:0c7447281493
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "Never turn a sprint into a plan document."
- cite: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md :: "Executing a sprint needs no orchestrator"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "it is execution's job — never write a plan document from one."
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "a sprint is never rewritten into a plan document"
- cite: .ok-planner/design/concepts/sprint.md :: "A sprint is never rewritten into a plan document."
- cite: .ok-planner/design/concepts/completion-report.md :: "record of one execution, never a plan document"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "archive the sprint — with its completion report and its"
- cite: checks/text-presence :: "# @decision: no-execution-engine"
- cite-file: checks/text-presence @ sha256:3f0942864be5
- cite-file: .ok-planner/sprints/2026-07-28-ratify-inline-certification-repairs.md @ sha256:634169344e92
- cite-file: .ok-planner/history/sprints/2026-07-25-ruled-intake-drain.md @ sha256:f37924f3eebd
- cite-file: .ok-planner/history/sprints/2026-07-26-vendored-suite-conduct-split.md @ sha256:b243ceed76fe
- cite-file: .ok-planner/history/sprints/2026-07-27-mechanical-release-audit-masking.md @ sha256:52eadd17e037
- cite-file: .ok-planner/history/sprints/2026-07-27-plumbline-esm-scope.md @ sha256:7e5eae3664cf
- cite-file: .ok-planner/history/sprints/2026-07-27-skill-families-audit-reconciliation.md @ sha256:faa6d1d91f3e
- cite-file: .ok-planner/history/sprints/2026-07-27-source-graph-certification.md @ sha256:3eabd5c24f04
- cite-file: .ok-planner/history/sprints/2026-07-28-corpus-browser-and-ruled-intake.md @ sha256:19761cc218d7
