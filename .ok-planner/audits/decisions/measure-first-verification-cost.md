---
audit: measure-first-verification-cost
artifact: decision:measure-first-verification-cost
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:5bea85fbd82e
---

# Is changing verification cost actually governed by profile → justify → re-measure, and are the proof run's timings really the profile of record?

Refreshed. The design artifact's hash is unchanged. Both stale citations
are whole-file node pins — `ok-planner-CLAUDE.md` and
`ok-planner-cheatsheet.md` — moved by the Release v11.2.0 commit. Read
directly: the edits to both files add a qualitative-rim/referrals
paragraph (audits attach only to decidable claims) and a completion-report
paragraph, both inside the audits/source-graph and execution-boilerplate
sections respectively — neither anywhere near the `## Changing what
verification costs (proof-timings.json)` section this decision cites,
whose own sub-node hash (`#...changing-what-verification-costs-proof-timings-json`)
did not go stale, confirming the section itself is untouched. Same for the
cheatsheet: its edits sit in the proofs/audits paragraph the same
release commit touched, not the `## Hard rules` bullet this decision
cites, whose own span hash likewise did not move. Citations regenerated;
nothing else touched.

Refreshed again. Both whole-file pins moved a second time — this cycle's
fix-loop pass aligned and rewrapped both templates' prose. The two sub-node
pins this decision's clauses actually rest on
(`#...changing-what-verification-costs-proof-timings-json` on the estate
guide, the `## Hard rules` span on the cheatsheet) did not go stale, so the
rewrap landed outside both claims' territory again. Citations regenerated;
nothing else touched.

Amended. The design artifact's hash is unchanged, so the prior pass's
reasoning binds except where the cited reality moved. This pass exists to
adjudicate the two provisional notes the change inspector left open, and it
does three things: promotes both notes with the citations that cover their
territory, enumerates from reality the per-family guidance population the
second note raises (rather than promoting it by reflex), and corrects a
statement of fact the prior pass got wrong about what the six harnesses
actually emit. None of the three moves the determination; the last narrows
what this audit is willing to assert on behalf of a non-binding surface.

The prior pass recorded that this repository's planner-family guidance
sentence had been rewritten from "Every harness under `test/` reports
per-case and per-story cost" to "Every harness under `test/` reports
per-case cost, and the story harness (`test/proofs.sh`) reports per-story
cost as well," and concluded the correction made the sentence accurate.
Read against the emitting call sites rather than against the `emit_timing`
definitions this audit pins, that conclusion is wrong in both directions —
see the harness enumeration under clause 1. The sentence is still
inaccurate about `test/proofs.sh`, and the prior parenthetical describing
the six harnesses was inaccurate about four of them. Both are corrected
below. Neither is a claim of this artifact, and neither refutes the Choice;
what changes is that this audit no longer vouches for the granularity
sentence in the planner family's guidance.

A decision like this one is the hardest kind to audit honestly, because the
failure mode is not a broken mechanism but a mentioned one: a discipline
written into a document nobody is obliged to read, with no artifact behind it.
So the reading was done in two halves — *where is the discipline stated in a
surface that binds a working session*, and *does the profile it points at
actually exist and cost less than a run* — and the second half was exercised
rather than inferred.

Refreshed again. The design artifact's hash is unchanged. The one stale
citation is the whole-file pin on `ok-planner-CLAUDE.md`, moved by the
owner-ratified cap rewording of the ceremony's goal-rule paragraph (the
"legal in-flight state" sentence added to the estate guide's own execution
section) and the issue-intake paragraph naming the cap's escalation as a
second gated path to the intake. Neither sits anywhere near the `##
Changing what verification costs (proof-timings.json)` section this
decision cites, whose own sub-node hash
(`#...changing-what-verification-costs-proof-timings-json`) did not go
stale — re-confirmed directly. Citation regenerated; nothing else touched.

## Claims

**Title — "Changing verification cost is performance engineering."** Honored
as the framing every enforcement surface uses, in those words. It is not a
slogan hanging alone: each surface that says it goes on to state the three
steps.

**Choice clause 1 — "Changing what a verification suite costs follows
performance-engineering discipline: a profile is taken before any change, the
change is justified by what that profile names, and a re-measure confirms the
effect."** Honored, with citable enforcement points, two of them in surfaces a
session cannot avoid loading. The enumeration is from the converge core's own
materialization list — what a converged project actually receives — rather
than from the decision's examples:

- **The always-in-context rules layer.** The cheatsheet template carries the
  discipline as a bullet under `## Hard rules`, beside the rules this corpus
  treats as binding ("Design docs are current-state only"; "Suite upkeep is
  the front door's administration"), and the converge core renders it to
  `.claude/rules/ok-planner-cheatsheet.md` — the project-instructions layer
  loaded on every session. All three steps are in the bullet: "profile before
  you change anything, justify the change by what the profile names, and
  re-measure to confirm it."
- **The estate's per-directory rules.** The `ok-planner-CLAUDE.md` template
  carries a dedicated section, `## Changing what verification costs
  (proof-timings.json)`, materialized into each consumer's `.ok-planner/
  CLAUDE.md`. It states the same three steps and then says *why* the rule is
  written down at all — "The reflex that fires reliably on product code does
  not fire on verification, which is exactly why it is written down here" —
  which is the Rationale's own claim, restated where it governs.
- **This repository's own per-family guidance**, under Constraints — now in
  two families rather than one. Both copies state the same three steps and
  name the read command; the planner family's adds a sentence about what its
  harnesses report, the workspaces family's names `test/demo.sh` and
  `test/tags.sh` as the per-story cost that grounds it. The workspaces
  sentence is accurate (both of those harnesses emit per-story rows and
  nothing else); the planner sentence is not, and this audit no longer
  vouches for it — see the harness enumeration below.
- **The contributor-facing README**, in the paragraph that lists the harnesses:
  "Treat changing what these harnesses cost as performance engineering rather
  than test work: read that profile first, change what it names, and
  re-measure to confirm the effect — the profile is a read, not a run, so
  there is no excuse for guessing."

Whether these *bind* or merely *mention* is the real question, and the answer
turns on placement rather than on wording. Two of the four are the surfaces
this project uses for every other rule an agent must obey: the rules file
loaded as project instructions, and the per-directory `CLAUDE.md` for the
estate. A rule stated there is as binding as this architecture makes anything
that is not a script — the same standing as "never read `history/` to
understand the project", which nothing mechanically enforces either. The two
remaining surfaces are ordinary documentation and add reach, not force.

**The per-family guidance population, enumerated from reality.** The second
inspector note asks whether the workspaces copy makes this a population with
a member missing. It was enumerated by listing every `CLAUDE.md` in the tree
and reading it against the family roster the front door's own guidance
declares (`families/{ok-planner,ok-plumbline,ok-workspaces}`):

- `plugins/ok/families/ok-planner/CLAUDE.md` — carries the bullet.
- `plugins/ok/families/ok-workspaces/CLAUDE.md` — carries the bullet, added
  this cycle.
- `ok-plumbline` has **no** `CLAUDE.md` at all. Its `docs/` holds the
  family's outward product documentation (manifesto, style guide, porting
  guide, cheatsheet), which governs consumers of the linter, not maintainers
  of this repository. There is no surface that omits the rule here; there is
  no surface.
- `plugins/ok/CLAUDE.md` — the front door's own maintainer guidance, which
  owns a timing-emitting harness (`plugins/ok/test/administration.sh`). Its
  Constraints do **not** carry the bullet. This is the one existing surface
  that omits it.

So the restatement is present in two of the three maintainer-guidance
surfaces that exist. That is a real unevenness, and the honest question is
whether the Choice quantifies over it. It does not. The Choice's only
quantifier is over *a verification suite* — the thing whose cost is being
changed — never over the documents that restate the rule, and this audit
declines to manufacture a quantifier the artifact does not carry. The
surfaces that carry force are family-agnostic by construction: one converge
run renders the hard-rules bullet into `.claude/rules/` and the estate
section into `.ok-planner/CLAUDE.md`, and both govern every directory of the
project — plumbline's and the front door's included. A maintainer making
`ok-plumbline/test/run.sh` more expensive is bound by exactly the same
always-loaded rule as one touching `ok-planner/test/run.sh`. The per-family
bullets amplify a rule already in force locally; they are not its carrier.

The mechanism half reaches all three families too, which is what makes this
unevenness cosmetic rather than a hole: plumbline's harness and the front
door's administration harness both emit timing spans into the same record,
and both are pinned by citation here. Nothing about plumbline's cost is
outside the profile of record; only the optional local reminder is absent.

**What the six harnesses actually emit.** Read at the call sites, not at the
`emit_timing` definitions:

- per-case rows only: `plugins/ok/families/ok-planner/test/run.sh`.
- per-story rows only: `plugins/ok/families/ok-planner/test/proofs.sh`,
  `plugins/ok/families/ok-workspaces/test/demo.sh`,
  `plugins/ok/families/ok-workspaces/test/tags.sh`,
  `plugins/ok/test/administration.sh`.
- both: `plugins/ok/families/ok-plumbline/test/run.sh`.

Every one of the six leaves a row, which is all the Choice needs. But the
planner family's sentence claims per-case cost from *every* harness under its
`test/`, and `test/proofs.sh` emits none — its `ok()` helper prints a bare
`ok: <name>` with no seconds and calls `emit_timing` nowhere per case. The
sentence is a granularity overclaim in a surface this audit already classes
as reach rather than force. It is recorded, not rated: the artifact claims
nothing about granularity, so this cannot refute the Choice, and the
inaccuracy is not a violation to fix under this decision's determination.

**Choice clause 2 — "The timings the proof run records are the profile of
record."** Honored, and this is the half that is mechanism rather than prose.
The proof verb makes recording unconditional — step 3 is "Execute, timed",
every proof runs through `.ok-planner/bin/proof-timings run …` with the word
**never bare**, non-executing verdicts are recorded at zero so the record
never reads as coverage it does not have, and the step names this decision by
slug as the reason: "That is the profile `decision:measure-first-verification-cost`
requires before anyone changes what verification costs." The recorder merges
per `(story, proof)`, so a narrowed run replaces only what it re-measured and
leaves the rest of the profile standing — without that, a scoped run would
quietly destroy the profile the discipline depends on. The converge core
renders the recorder to `.ok-planner/bin/proof-timings`, so the command the
guidance names is one a converged project actually has.

The claim was exercised, not merely read. One documented harness was run once
through the recorder naming the five stories it proves; a separate, later
process then printed all five stories with their own measured seconds, their
scope labels (`story-section` where a section measured one story,
`shared-section` where one section proves several), and the total — having
executed no proof. That is the profile existing, per proof, and readable
afterwards.

**Rationale — "Verification cost reads as test work, and the measure-first
reflex that fires reliably on product code does not fire on it. Naming the
discipline is what makes the reflex fire."** Honored in the only way a claim
about a reflex can be: the naming exists, in the surfaces that govern, in the
imperative. Nothing in the corpus claims a mechanical gate, and none is
asserted here.

**Rationale — "Grounding it on timings the proof run already leaves is what
makes measuring the cheap path rather than another full run."** Honored, and
checked at the level of the code rather than the promise. `show` opens the
JSON record, sorts, prints, and returns; it starts no subprocess and runs no
proof. Reading the profile is genuinely a read. The record is also durable
across sessions by construction, and that durability now has a corpus-level
basis as well as a mechanical one: the estate concept names machine-local
content a family's own ignore file excludes from the repository as one of the
estate's content kinds, and gives "a measurement one of its runs left" — this
decision's own `proof-timings.json` — as its worked example. So leaving the
record behind is not a working-tree mutation by accident of a `.gitignore`
line; it is the kind of content the durable model says an estate holds.

**Rationale — "The two halves fail apart: a measure-first rule with no
measurement available is unaffordable in practice, and a timing record nobody
is directed to consult changes nothing."** Honored, and the diagnosis is
matched by the shipped shape: the rule surfaces all name the read command, and
the record's own header states its purpose as the discipline's affordable
path. Neither half is present without the other — the same converge run places
the recorder, the ignore file, the cheatsheet bullet, and the estate section.

**Alternatives.** All three are roads not taken, and the third was checked
rather than taken on trust. "Leave verification cost to ordinary engineering
judgment" and "record the timing artifact without stating the discipline" both
contradict the shipped shape. "Home the discipline with the lint family's
existing check-speed criterion" describes something real — the lint family's
manifesto does carry "Check speed is an architectural property … a legitimate
placement criterion, on par with cohesion", and its style guide asks "what is
the cheapest check that covers it there?" when deciding where logic lives.
That is exactly an authoring-time *placement* criterion and says nothing about
the cost of running a suite, so the alternative's stated reason for rejection
is accurate rather than a straw man.

**Annotation of the enforcement points.** Not a claim of the artifact, but
worth recording because it is how a future reader finds this: the decision's
slug is annotated at the recorder's header and at the timing-emission site of
every one of the six harnesses this project documents, so the code that makes
the profile exist carries the link to the rule that requires it.

## Determination

**satisfied.** Both halves of the Choice have citable enforcement points, and
they are of different kinds, which is what the Rationale predicts they must
be. The discipline is stated — three steps, imperative, no hedging — in the
two surfaces this project uses to bind a working session (the always-loaded
rules file and the estate's per-directory `CLAUDE.md`), plus two families'
guidance and the README. The profile of record is not aspirational: the proof
verb forbids running a proof outside the recorder, the recorder guarantees a
per-proof number, the merge is scoped so a narrowed run cannot destroy the
profile, `show` reads without running, and the converge core places all of it
in a consumer's estate. A run and a subsequent read were performed for this
audit and behaved as claimed.

Three real limits, none of which refutes the Choice as written, all recorded
so a later reading does not mistake them for oversights:

- **No mechanical gate exists, and none is claimed.** Nothing fails if someone
  makes a harness ten times slower without profiling. Unlike several peer
  decisions in this corpus, this one carries no `checks/text-presence`
  assertion, so the governing sentences can be deleted or reworded
  without turning any check red. Only this audit's citations catch that.
- **The profile's reach is narrower than the Choice's first sentence.** That
  sentence says "a verification suite"; the mechanism reaches story proofs
  run through `/prove`. The repository's own maintenance suite (`checks/run`)
  is verification whose cost is real and whose harnesses emit no spans, so a
  change to *its* cost has no profile of record to consult. The Choice's
  second sentence pins the profile to the proof run, and the family guidance
  scopes the rule to "this family's verification", so this is a bounded scope
  rather than a broken promise — but a reader who takes the first sentence
  literally will find a gap there.
- **The local restatement is uneven, and one surface's version overclaims.**
  Two of the three maintainer-guidance surfaces that exist carry the bullet;
  `plugins/ok/CLAUDE.md` does not, and `ok-plumbline` has no such surface at
  all. The Choice quantifies over verification suites, not over restatements,
  and the binding layer is family-agnostic, so this is outside the claim
  rather than a hole in it — but a reader should not take the two family
  copies as evidence of a per-family convention that is enforced. Separately,
  the planner family's copy asserts per-case cost from every harness under
  its `test/`, which `test/proofs.sh` does not emit; the artifact claims
  nothing about granularity, so the overclaim is recorded here rather than
  rated.

This stops holding if: the cheatsheet's hard-rules bullet or the estate
template's `## Changing what verification costs` section is deleted or
softened out of the imperative (the pinned span and node break); the converge
core stops rendering the cheatsheet to `.claude/rules/`, or stops rendering
`bin/proof-timings`, so the rule's named command is absent from a converged
project; the proof verb's step 3 stops requiring the recorder, or drops the
sentence naming this decision as the reason; `merge` stops being scoped per
`(story, proof)`, so a narrowed run destroys the profile the discipline reads;
`cmd_show` stops being a pure read; the estate ignore file stops naming
`proof-timings.json`, or the estate concept stops naming machine-local
run output as a content kind it holds, making the profile a working-tree
mutation again; a fourth family joins the roster the front door's guidance
declares (which is why that file is pinned whole); or the lint family's
placement criterion is widened to cover run cost, at which point the
third alternative's stated reason for rejection stops being true.

## Notes

- note: `.ok-planner/design/concepts/estate.md` (What it is / Boundaries) was amended to add a general content kind — "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)" — and "a measurement one of its runs left" names this decision's own artifact, `proof-timings.json`, as its second worked example. No citation here covers the concept file.
  adjudication: promoted — the clause is now cited (`cite:` on `.ok-planner/design/concepts/estate.md`), and the second Rationale claim's durability finding rests on it: the record's exclusion from the repository is no longer justified by a `.gitignore` line alone but by the durable model naming this exact kind of content as estate content. The Determination's stops-holding list names the concept's loss of that kind as a tripwire.
- note: `plugins/ok/families/ok-workspaces/CLAUDE.md` gained a new Constraints bullet stating the same discipline this decision's Choice names, near-verbatim to the already-cited `plugins/ok/families/ok-planner/CLAUDE.md` sentence ("Changing what this family's verification costs is performance engineering, not test work: profile first ... justify the change by what the profile names, re-measure"), and pointing at `test/demo.sh`/`test/tags.sh` for the per-story cost that grounds it — a new member of the per-family population this decision's guidance is meant to reach, and no citation here spot-checks it (only the planner family's own copy is cited).
  adjudication: promoted — the bullet is now pinned (`cite-span:` on the sentence, `cite-node:` on the file whole), and the population it belongs to was enumerated from reality rather than assumed: two of the three maintainer-guidance surfaces that exist carry the discipline, `plugins/ok/CLAUDE.md` omits it, and `ok-plumbline` has no such surface. The determination stands at `satisfied` because the Choice quantifies over verification suites, not over documents restating the rule, and the force-carrying surfaces (the rendered cheatsheet rule and the estate section) are family-agnostic and already reach plumbline's and the front door's harnesses — both of which emit into the profile of record and are pinned here. The unevenness and its bounds are recorded as the third limit under Determination. `plugins/ok/CLAUDE.md` is pinned whole as the family-roster enumeration source, so a fourth family — or that file gaining or losing the bullet — re-triggers this audit. The bullet's own factual claim was checked rather than assumed: `test/demo.sh` and `test/tags.sh` do emit per-story rows and only per-story rows, so the workspaces sentence is accurate (unlike the planner family's, corrected under clause 1).

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "- Changing what verification costs is performance engineering, not test" +6 sha256:7df4c13e9ead
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md#ok-planner-cheatsheet.hard-rules @ sha256:3fe759ba3ade
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md#ok-planner-the-planner-s-directory.changing-what-verification-costs-proof-timings-json @ sha256:2cd204e527c6
- cite-span: plugins/ok/families/ok-planner/CLAUDE.md :: "Changing what this family's verification costs is performance engineering" +4 sha256:363f0cc917ef
- cite-span: plugins/ok/families/ok-workspaces/CLAUDE.md :: "Changing what this family's verification costs is performance engineering" +1 sha256:6536cf270260
- cite: README.md :: "performance engineering rather than test work: read that profile"
- cite: .ok-planner/design/concepts/estate.md :: "the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left)"
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$CHEATSHEET_TEMPLATE" > "${ROOT}/.claude/rules/ok-planner-cheatsheet.md""
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$PROOF_TIMINGS" > "${OK_DIR}/bin/proof-timings""
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.process @ sha256:ec4293fbb2af
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "3. **Execute, timed.** Run every proof through the project's own recorder"
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def merge(root, entries):" +11 sha256:41a6f2c2ea01
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def attribute(root, stories, proof, spans, whole_elapsed, rc):" +32 sha256:650bd0b6a402
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "def cmd_show(argv):"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "proof-timings.json"
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh#emit_timing @ sha256:45d852a040d5
- cite-node: plugins/ok/families/ok-planner/test/run.sh#emit_timing @ sha256:c2d6be117857
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#emit_timing @ sha256:fc35cbda7827
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh#emit_timing @ sha256:298b5a30a855
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh#emit_timing @ sha256:45d852a040d5
- cite-node: plugins/ok/test/administration.sh#emit_timing @ sha256:45d852a040d5
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-manifesto.md :: "**Check speed is an architectural property.**"
- cite-node: README.md @ sha256:e1090bf5222a
- cite-node: plugins/ok/families/ok-planner/scripts/proof-timings @ sha256:a02e8cbfb2fa
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md @ sha256:284a6200837e
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md @ sha256:1d1d41e12b03
- cite-node: plugins/ok/families/ok-planner/CLAUDE.md @ sha256:46a68bb623ad
- cite-node: plugins/ok/families/ok-workspaces/CLAUDE.md @ sha256:9fa581d029c4
- cite-node: plugins/ok/CLAUDE.md @ sha256:c2c31a1ee198
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:6e2b32d8b092
- cite-node: checks/run @ sha256:11cd8739c376
