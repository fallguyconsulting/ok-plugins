# Completion report — Practices corpus and suite-level ceremonies

Execution record for
`.ok-planner/sprints/2026-08-08-practices-corpus-and-suite-ceremonies.md`.
Written as the work lands; `/certify-work` finishes it with its
presentation.

## Staging

The sprint's sixteen work items were grouped into eight stages, ordered
so nothing is built on something not yet there:

1. Apply the sixteen corpus deltas and refresh the catalog TOCs.
2. Revision-bearing deltas (as originally ruled — later redirected;
   see "Owner redirection" below).
3. Hoist the ceremonies and collapse the audit verbs.
4. The subject/practice corpus for ok-plumbline and its coverage
   determination.
5. Practice citation in the certification pass.
6. Materialized files that stand alone in a consumer.
7. The renamed-and-retired verb sweep.
8. Tests, repo checks, and the close.

## Work done

### Stage 1 — corpus deltas applied

All sixteen deltas copied verbatim into `.ok-planner/design/`:

| Operation | Artifacts |
|---|---|
| New concepts | `subject`, `practice` |
| Amended concepts | `corpus-delta`, `integration-contract`, `skill-family`, `finding` |
| New decisions | `final-form-deltas` (originally `revision-bearing-deltas`; see "Owner redirection"), `affirmative-practices-over-exemptions`, `violations-are-remediation-not-issues`, `suite-owned-ceremonies` |
| Amended decisions | `adversarial-implementation-audits`, `audit-audience-split` |
| New stories | `record-coding-practices`, `practice-coverage-report`, `one-ceremony-per-project` |
| Amended story | `corpus-audit` |

The three catalog TOCs were regenerated from the artifact bodies by the
same derivation the existing entries follow (slug, aliases, first
paragraph truncated to 117 characters plus an ellipsis, sorted by slug).
Every pre-existing line reproduced byte-identically, which is what makes
the regeneration safe to run wholesale; only the six new slugs and the
five amended descriptions moved.

### Stage 2 — revision-bearing deltas

- **`scripts/corpus-delta`** (new, materialized to
  `.ok-planner/bin/corpus-delta`) is the one derivation both the drafter
  and the executor run: `base` prints a twelve-hex sha256 stamp of the
  live artifact, `revise` prints that stamp plus the anchored unified
  diff to a resulting body, `verify` compares a stamp against the live
  file, and `apply-check` proves the resulting body is the base with the
  revision applied. One derivation is what makes a base comparison a
  fact rather than two independent guesses — without it, a drafter and
  an executor disagreeing on line endings would false-halt every
  amendment.
- **`{{CORPUS-DELTA-FORM}}`** (new token in `artifact-definitions.md`)
  is the authority on a delta's parts: one for a new artifact, none for
  a retirement, three for an amendment. It also states what execution
  does with them — verify the base, halt for the owner on a mismatch,
  copy the resulting body verbatim — and what review does: the revision
  is the unit under review, and `apply-check` catches drift in sections
  the amendment never claimed to touch.
- **`skills/_shared/sprint-document.md`** (new) holds the sprint
  template and its fixed execution boilerplate, previously inline in the
  planning skill. Step 3 of that boilerplate and the completion
  contract's first item now distinguish the three operations, and a
  moved base joins the list of genuine blockers.
- The sign-off review gained the derivation check, and certification's
  mechanical floor gained the same check at execution scope.

### Stage 3 — the ceremonies hoisted, the audit verbs collapsed

- **`plugins/ok/ceremonies/{plan-sprint,certify-work,audit}/SKILL.md`**
  (new): one canonical body per verb. Each resolves estates from the
  filesystem at invocation, reads each present family's ceremony
  surface, and runs a named phase spine. The bodies carry the process
  and no family-specific instructions.
- **`plugins/ok/admin/{converge,ADMINISTRATION.md}`** (new): the suite's
  own conventional surfaces, for the one layer that belongs to no
  family. The core vendors the three verbs under their bare names and
  retires the four verbs the hoist replaced.
- **`<family>/ceremony/{plan-sprint,certify-work,audit}.md`** (new, all
  three families): the conventional ceremony surface, materialized into
  each estate at `.ok-<name>/ceremony/`. ok-planner's carry the
  substance of the retired `plan-sprint`, `certify-work`, and
  `verify-corpus` skills; ok-workspaces' audit surface carries the
  discipline sweep from its retired `audit` verb; ok-plumbline's carry
  its lint sweep and the new coverage determination.
- **Retired**: `ok-planner/skills/{plan-sprint,certify-work,audit,verify-corpus}`,
  `ok-plumbline/skills/audit`, `ok-workspaces/skills/audit`. Each
  family's converge stopped vendoring them; the suite's converge removes
  the stale vendored copies (`ok-planner-audit`, `ok-plumbline-audit`,
  `ok-workspaces-audit`, `verify-corpus`).
- **The audit collapse**: the reporter's artifact-form and
  annotation-integrity checks folded into the periodic run. Every audit
  now records two independent axes — `determination:` (support) and
  `compliance:` — and `{{AUDIT-FILE-FORMAT}}` gained the coverage shape
  (`checked:`, `unaccounted:`, `## Unaccounted`, `## Remediation`). Only
  the support axis escalates to the judge.
- **`scripts/audit-check`** rewritten: it now walks every estate
  dot-directory carrying an `audits/` collection, pairs each bucket with
  the live collection it mirrors, and checks six things — coverage,
  catalog consistency, shape (both axes' vocabularies), brevity,
  accountability, and agreement between the coverage counts and the
  determination.

### Stage 4 — the subject/practice corpus

- **`docs/practice-definitions.md`** (new, materialized to
  `.ok-plumbline/practice-definitions.md`): the authoring rules for both
  kinds, their templates, and the four states a subject's member can be
  in — accounted for, violating, gap, collision.
- **Estate layout**: converge lays out `.ok-plumbline/subjects/`,
  `.ok-plumbline/practices/`, and `.ok-plumbline/audits/subjects/`.
  Practices get no audit file of their own: a practice's claim is
  answered inside its subject's coverage audit, where the population it
  is measured against is what makes the answer refutable.
- **Citation tags**: the starter proposes `@subject:` and `@practice:`
  entries once the collections exist, diagnose warns while they are
  undeclared, and `admin/ADMINISTRATION.md` carries the consent
  walkthrough. Nothing writes them without the owner's yes — tags are
  owner-declared configuration, never a shipped default.
- **Coverage determination**: ok-plumbline's audit surface carries the
  auditor prompt that enumerates a subject's population from reality,
  classifies every member, and reports `checked`/`unaccounted` with the
  gaps and collisions named. Violations go to `## Remediation` as work;
  only gaps, collisions, and sites whose governing practice could not be
  established at the point of use reach the intake.
- **The cheatsheet** gained a Subjects and Practices section stating the
  affirmative-practice rule, the cite-as-you-write discipline, and that
  a gap is the owner's question.

### Stage 5 — practice citation in certification

ok-plumbline's certification surface adds a second producer: for each
construct the change introduced or touched, whether a live subject
claims it and whether it carries a `@practice:` citation whose condition
covers it. A missing citation is an ordinary finding fixed in the same
change; a construct no practice covers is a gap the architect routes.
The producer contributes nothing where the project has authored no
subjects or declared no tags, and says so in one line.

### Stage 6 — materialized files that stand alone

Every payload a converge core writes into a consumer project was
stripped to what the machine requires: a single `Materialized by … v…`
stamp line, plus SPDX where it was already there. Prose headers and
citation tags are gone from `surface-corpus`, `session-start`,
`bin/plumbline`, `post-edit.js`, `src-tag`, and `port-block`; the
annotations they carried moved to non-shipping sites (the families' test
harnesses and converge cores), so the annotation grep still finds every
slug.

`checks/materialized-standalone` (new) enforces the outcome: it copies
every payload into a throwaway repository with **no** plumbline config —
zero declared citation tags, the state of every project that has not
opted in — and lints it there. Linting in place would prove nothing,
because this monorepo declares the planner's citation tags for its own
subtree, which is exactly the declaration a consumer has not made.

### Stage 7 — the verb sweep

Every reference to a renamed or retired verb was updated across the
suite's skills, cheatsheets, shared definitions, family and plugin
`CLAUDE.md` files, the integration contract, the README, and the
administration test. The only remaining occurrences are deliberate: the
retired-verb table in the suite's administration document, the removal
list in its converge core, the contract paragraph that records the
retirement, and the test's negative fixture.

### Stage 8 — tests and checks

New:

- `plugins/ok/families/ok-planner/test/corpus-delta.sh` — base stamps,
  revise, verify, apply-check, including untouched-section drift, a
  mismatched revision, and a moved base.
- `checks/ceremony-surfaces` — one canonical body per ceremony verb,
  one surface per family per verb, every surface heading a declared
  phase or conventional heading, and no family carrying a ceremony
  verb's name.
- `checks/materialized-standalone` — described above.

Extended:

- `ok-planner/test/run.sh` — the compliance axis, the coverage shape,
  and a second estate whose live collection sits directly under the
  estate rather than under `design/`.
- `ok-plumbline/test/run.sh` — the practice corpus end to end
  (`@story: record-coding-practices`), and the collision-rule case
  rewritten for its flipped premise: no verb name is claimed by more
  than one family now, so every name stays bare and the ceremony verbs
  are absent from the family's vendored set.
- `plugins/ok/test/administration.sh` — the suite's ceremony layer:
  bare-named vendoring, per-family surfaces, and the four retired verbs
  swept.
- `checks/token-resolution` — now scans the ceremony surfaces and
  bodies, where the heaviest transcluding prompts moved.
- `checks/vendored-layer` — asserts the suite's own two administration
  surfaces exist.

All seven repo checks and all seven test harnesses pass.

## Review-fix loop — parked at the cycle cap

`/certify-work` ran with two producers at change scope (sprint alignment
and code review over the diff) beside the test suites and the mechanical
floor. The loop reached its cycle cap after three fixer passes, stopped,
and put the two cap steps to the owner, who chose another cycle. A fourth
pass then worked all eleven remainders.

| pass | findings | worked |
|---|---|---|
| initial review | 19 (7 alignment, 12 code review) | all |
| after pass 1 | 17 (6 alignment, 11 code review) | all |
| after pass 2 | 9 (4 alignment, 5 code review) | all |
| after pass 3 | 11 (5 alignment, 6 code review) | all — cap reset on the owner's word |
| after pass 4 | 11 (5 alignment, 6 code review) | all |
| after pass 5 | 13 (7 alignment, 6 code review) | all |
| after pass 6 | 10 (6 alignment, 4 code review) | all |

Three of the fixed findings were defects in the amendment machinery
rather than record-keeping, and each was a case where the reviewed text
and the applied effect could differ — the class the revision-bearing
delta form exists to close: a file with no trailing newline and a removed
line whose own text reads as a diff header both produced revisions the
tool's own checker rejected; a zero-context insert anchored one line
early; and a hunk header understating its body silently dropped edits.
All four now raise, with regression cases in
`test/corpus-delta.sh`.

### The eleven remainders, and what pass four did with them

Blocking undershoots:

1. Concepts get no compliance determination — the audit enumerates only
   stories and decisions, while the amended
   `adversarial-implementation-audits` says "each live artifact".
2. Nothing checks TOC consistency for the planner's three catalogs; live
   `concept:catalog-toc` calls the audit "the consistency backstop".

Correctness:

3. `apply_diff` silently drops body lines outside any hunk, so a revision
   can over-claim and still certify as derived.
4. The certify-time amendment check hardcodes `HEAD` as the base, which
   false-escalates every amendment on a commit-range scope.
5. `catalog-toc` opens files with the platform encoding — under an ASCII
   locale it truncates a TOC to zero bytes and aborts converge.
6. `audit-check` skips an estate with no `audits/` directory, so a live
   corpus with no audit corpus goes undetected.

Coverage and residue:

7. `plumbline diagnose` still exits on a structurally invalid config; the
   guard covered only unparseable JSON.
8. No regression case for that guard or for any `estateCorpusFindings`
   branch.
9. `design-doc-compliance-reviewer.md` still names `audit` whole-corpus
   mode as a consumer — a retired invocation.
10. ok-planner's `ADMINISTRATION.md` declares an owned set omitting
    `bin/corpus-delta` and `ceremony/`.
11. `concept:true-up` and that same document still defer to "the
    compliance verbs", a class this sprint retired.

Pass four closed all eleven. The two blocking undershoots widened what
the collapsed audit owns: concepts now carry a determination like every
other live artifact (`audits/concepts/`, enumerated by the ceremony
surface, with the auditor reading a concept's Invariants and Boundaries
as its decidable claims), and catalog consistency became a deterministic
check inside `audit-check` — every TOC bullet resolving to a live artifact
and every live artifact carrying a bullet — which is what
`concept:catalog-toc` calls the audit's backstop. The four correctness
findings were fixed at the source and each carries a regression case; the
five residue findings were text the sweep had missed.

Pass five closed eleven more. Three were defects the earlier passes had
introduced rather than missed: the `@decision:` parentheticals pass four
added to plumbline's ceremony surfaces **ship**, so their slugs would
dangle in every consumer — the exact defect work item 14 closes — and
`checks/materialized-standalone` could not see them, because it lints only
payloads with a comment grammar. The guard now also reads every
materialized markdown file and rejects a citation whose slug resolves in
this repo's corpus and would resolve in no consumer's; the two decisions
moved to the family README, which does not ship.

The rest of pass five: the audit's live-side coverage fallback no longer
mistakes discovery scaffolding for a collection; `loadConfig` rejects a
non-object config the way diagnose reports it, so the report predicts what
the lint will do; five more `open()` calls take an explicit encoding; and
every materialized ceremony surface and the practice definitions now carry
the version stamp `decision:whole-file-ownership` requires, which is what
lets a vendored-only diagnose tell current from stale.

Pass six closed thirteen. The pattern of the late cycles is worth
recording: they stopped finding gaps in the sprint's work and started
finding **the fix loop's own residue** — text a fix had contradicted, a
count a new check had made wrong, an enumeration a widened scope had left
behind. Two were process failures rather than code ones. A pass-five edit
to a workspaces test comment silently did nothing, because the text it
searched for spanned a line break and the replace was unasserted; every
edit since asserts its match before writing. And the check that keeps
materialized files standing alone was itself missing seven vendored
plumbline skill bodies, so it could not have caught a citation in any of
them.

The substantive ones: `plumbline diagnose` now agrees with the lint on a
non-object config instead of blessing one the lint refuses to run over;
the consumer-facing `CLAUDE.md` and cheatsheet describe the audited set
as concepts, stories, and decisions, matching the ceremony surface
materialized beside them; every statement of what `audit-check` does
names its six jobs rather than the four it had at HEAD; and the coverage
auditor's `unaccounted:` count admits all three escalating states, not
the two its step 4 listed.

Pass seven closed ten. One was not residue: making `compliance:` a
required audit field means every audit the **previous** release wrote
reads as malformed, and converge's migration swept only the shape from
two model changes ago — so the first `/audit` in an upgrading project
would have opened with a wall of findings about files nobody is meant to
keep, which is the thing that migration's own comment says it exists to
prevent. Converge now sweeps an audit carrying no `compliance:` field,
and the fixture seeds that shape.

Three more closed gaps rather than residue: `corpus-delta` now sizes the
fence it emits to the diff, so an amendment to an artifact carrying
fenced code of its own can still be extracted back out of the sprint;
`audit-check` reports a collection with no table of contents at all,
which the catalog backstop had been silent about; and
`checks/ceremony-surfaces` now enforces the contract's collision rule,
which had no implementation left once every renderer dropped its
prefixing arm.

## Owner redirection — the revision form backed out

After the seventh review cycle the owner redirected the sprint live: the
revision-bearing delta form was an optimization the process never
consumed, and the mechanical derivation check it required would
eventually hard-stop a sprint whose artifact legitimately needs a change
discovered during the work — a case the divergence and escalation
mechanisms already cover. The ruling: corpus edits are resolved fully
during planning as complete final-form bodies, with a sidecar folder
beside the sprint for large ones, and no diff tool, no base pin, and no
reliance on git.

The sprint document was revised accordingly (its Intent, the
`corpus-delta` delta, `revision-bearing-deltas` replaced by
`final-form-deltas`, and work items 1–3 replaced by one), and the
execution backed out to match:

- deleted: `scripts/corpus-delta` (the hand-rolled diff tool), its
  materialization and diagnose wiring, and `test/corpus-delta.sh`; a
  previously materialized `bin/corpus-delta` joins the retired-payload
  sweep
- rewritten: `{{CORPUS-DELTA-FORM}}` to final-form bodies plus the
  sidecar; the sprint template's delta section, apply step, blocker
  list, and contract item; the sign-off reviewer's draft-mode scope;
  both planner ceremony surfaces (the plan-sprint drafting and
  apply-check steps, the certify amendment-derivation floor); the
  plumbline planning surface's delta paragraph
- corpus: `concept:corpus-delta` re-amended to the final-form + sidecar
  shape, `decision:revision-bearing-deltas` retired,
  `decision:final-form-deltas` added recording the trust-the-reviewers
  rationale, `concept:sprint` restored to its committed text
- the close-out (certification core and the planner certify surface)
  archives a sprint's sidecar folder with it

The eight cycles' worth of diff-engine hardening went with the engine.
What survives of the original issue's concern is the review posture:
drift between a delta and the live artifact it amends is the sign-off
reviewer's and the alignment producer's judgment, by design rather than
by pin.

## Divergences

Four corpus-side repairs were made in cycle and stand in the tree, each
rules-determined and intent-preserving, each named here for
after-the-fact veto:

- **`concepts/skill.md`, What it is and Boundaries.** Two edits, both
  from the same cause — the new `suite-owned-ceremonies` puts skill
  bodies outside every family. In **What it is**, "authored inside skill
  families" was exhaustive and wrong for the three ceremony verbs;
  widened to "authored inside a skill family, or in the suite's own
  ceremony layer where the verb belongs to no family". In
  **Boundaries**, "Administration is not a skill surface: families
  expose converge cores and administration documents, not lifecycle
  verbs" read as an exhaustive enumeration and was incomplete once
  families also expose a ceremony surface and no ceremony verbs of their
  own; rewritten to "Neither administration nor the ceremonies is a
  family's skill surface", naming all three surfaces and both kinds of
  verb, with `integration-contract` added to that sentence's see-also for
  the ceremony surface it defines. What the concept commits to —
  skills are the suite's verbs, vendored into the project; families
  expose surfaces, not verbs — is unchanged.
- **`concepts/estate.md`, What it is.** The enumeration of estate
  content kinds did not name the ceremony surfaces this sprint
  materializes at `.ok-<name>/ceremony/`, while the amended
  `integration-contract` names `estate` as the concept realizing that
  layer. Added "ceremony surfaces" to the enumeration; the commitment —
  the estate holds the family's materialized content — is unchanged.
- **`decisions/vendored-skills.md`, Choice** and
  **`concepts/materialized-artifact.md`, What it is.** Both narrowed
  vendoring's source to a *family* payload, which the new
  `suite-owned-ceremonies` contradicts: three vendored skill bodies now
  come from a layer belonging to no family. Widened both to "a family's,
  or the suite's own"; what either artifact commits to — everything
  project-scoped arrives version-stamped and materialized, never run
  from the payload — is unchanged.
- **`concepts/true-up.md`, What it is, Purpose, and Boundaries.** The
  first two scoped the converge to a project's "integrated-family
  presence", which the new `suite-owned-ceremonies` contradicts: the
  ceremony verbs every project gets belong to no family, so a converge
  of only the family presence would not reach them. Both now say "suite
  presence", and the What-it-is enumeration names "the ceremony verbs
  every project gets" alongside each family's estate, cheatsheet,
  vendored skills, and hook wiring. **Boundaries** carries the same
  widening once more: "and the front door drives them" → "the
  suite carries the same pair for its own ceremony layer, and the front
  door drives them all", so the sentence listing each family's converge
  core and administration document no longer implies families are the
  only contributors of that pair. The commitment — one idempotent
  converge of everything the payload declares, in three phases, driven
  by the front door — is unchanged. (The same section's other edit,
  "the compliance verbs' job" → "the periodic audit's job", is finding
  11 of the review-fix log above.)

**Two further in-cycle repairs were made and then reverted; neither
stands in the tree.**

`concepts/sprint.md`, What it is: "expressed as final-form corpus
deltas" was, at the time, contradicted by the three-part amendment
shape this execution was building, and "final-form" was dropped as
expression. When the owner redirected the sprint back to final-form
deltas (see the section above), that edit was backed out with the rest
of the revision-form machinery. The file is byte-identical to its
committed text — the sentence still reads "expressed as final-form
corpus deltas", which the redirected design makes correct — so there is
nothing here to veto.

`story:rules-compliance-report` asks for a *read-only* report of drift
from a family's declared rules,
and the collapsed audit writes determinations, so the word is now
contradicted. This execution first dropped it as expression. The
certification alignment judge called that a commitment change made
outside the delta mechanism — which it is, since no delta in this
sprint amends that story — and the edit was reverted. The story is
byte-identical to its committed text, and the contradiction is filed
for your ruling as
`.ok-planner/issues/2026-08-08-123611-read-only-report-promise-outlives-its-verb.md`.

- **`checks/owned-paths` made quoting-insensitive.** It compared a write
  target's *quoted* form against the allowed prefixes, so
  `cp … ".ok-plumbline/ceremony/x.md"` read as a write outside the owned
  set purely because it was quoted. Targets are now unquoted before the
  prefix test and the planner's allowed prefixes lost their leading
  quote to match. The owned set is unchanged; only the comparison is.

- **Overshoot: a suite-level converge core.** The sprint asks that the
  ceremonies be "vendored into consumer projects", and the ownership
  rule says only a converge core writes into a project. Nothing owned
  that write, so `plugins/ok/admin/{converge,ADMINISTRATION.md}` was
  built to hold it. Without it the ceremonies could not reach a project
  at all, which is why this is required by intent rather than new scope.

- **Overshoot: `skills/_shared/sprint-document.md`.** The sprint
  document template lived inside the planning skill's body, which the
  hoist splits between a suite-owned ceremony and a family surface.
  Leaving it in either place would have put ok-planner's artifact into a
  suite body or duplicated it; giving it its own shared file keeps the
  single-source rule intact.

- **Overshoot: two new repo checks.** `ceremony-surfaces` and
  `materialized-standalone` are the mechanical enforcement of two
  outcomes the sprint states as properties ("every family exposes a
  conforming surface", "no materialized file depends on a declaration
  the project has not made"). A property with no check is one the next
  change silently breaks.

## Calls made where the sprint was silent

- **The ceremonies require the ok-planner estate.** The sprint says the
  ceremonies cover "whichever estates the project has", and says nothing
  about a project without a planner. The three bodies transclude the
  corpus vocabulary — issue format, the mechanical/judgment line, the
  decidability boundary — from ok-planner's vendored `_shared/`, and the
  planning ceremony's terminal artifact is ok-planner's sprint. So each
  body states the dependency plainly and stops when `.ok-planner/` is
  absent, rather than inventing a second home for that vocabulary.
  `one-ceremony-per-project` is about a project with *more than one*
  family and is unaffected.

- **The determination vocabulary stayed at three words.** The amended
  `adversarial-implementation-audits` says a coverage-governed artifact's
  determination "takes that shape — the count checked, the population it
  was enumerated from, and the members not accounted for". That is a
  statement about the audit's *shape*, so the coverage form adds
  frontmatter counts and an `## Unaccounted` section rather than a
  fourth and fifth determination word. Keeping one vocabulary is also
  what lets `audit-check` carry zero family knowledge: it resolves each
  estate's collections by convention and validates every bucket the same
  way.

- **Ceremony phase names are a fixed, checked vocabulary.** The sprint
  asks for "a conventional ceremony surface" without saying what makes
  one conforming. Each verb's spine is a named phase list, a surface
  contributes by heading name, and `checks/ceremony-surfaces` rejects a
  heading that is neither a phase nor one of the three conventional
  headings — a surface heading nothing drives would otherwise be content
  the ceremony silently never reads.

- **The lint's clustering is the audit's grouping.** The retired
  plumbline audit verb re-derived a by-category/by-file grouping in
  shell. The ceremony surface runs `plumbline patterns` instead, so the
  grouping has one home in the binary rather than two answers to the
  same question.

- **This repo's vendored layer was deliberately left at HEAD.** No
  converge was run here. `checks/vendored-layer` pins `.claude/skills/`
  and the materialized estate to the last commit, and its own rule is
  that the layer changes only by a deliberate, committed converge after
  a release. So this repo still carries `ok-planner-audit` and
  `verify-corpus` as vendored skills; the next `/ok` run removes them.

# Certification — Practices corpus and suite-level ceremonies

Status: certified clean

A first certification run earlier in this execution parked at the
review-fix loop's cycle cap and was superseded by the owner
redirection recorded above; this is the full re-run after the
back-out, from Phase A. It converged in three fixer passes, every
finding a completion-report disclosure repair — no code, corpus, or
test finding survived Phase A.

## Outcomes delivered

- `decision:final-form-deltas` (with `concept:corpus-delta` amended,
  `concept:sprint` unchanged) — corpus edits are resolved fully
  during planning as complete final-form bodies; a sprint with large
  bodies carries them in a sidecar folder beside the sprint file; no
  delta carries a diff, a base pin, or a machine-checked derivation.
  The planning ceremony, the sprint template, the compliance
  reviewer, and the certification alignment producer all state and
  enforce this shape.
- `story:record-coding-practices` (with `concept:subject`,
  `concept:practice`, `decision:affirmative-practices-over-exemptions`)
  — an ok-plumbline project can declare subjects (enumerable
  populations of constructs) and practices (affirmative statements
  about members of a subject) under `.ok-plumbline/{subjects,practices}/`,
  with generated TOCs (`catalog-toc`), owner-declared `@subject:` /
  `@practice:` citation tags, and authoring rules in
  `docs/practice-definitions.md`.
- `story:practice-coverage-report` (with
  `decision:violations-are-remediation-not-issues`) — the plumbline
  audit ceremony reports practice coverage in the coverage shape
  (checked counts against the enumerated population, an Unaccounted
  section, a Remediation section); violations are remediation lines,
  never intake issues; only gaps, collisions, and traced members
  escalate.
- `story:one-ceremony-per-project` (with
  `decision:suite-owned-ceremonies`, `concept:integration-contract`
  and `concept:skill-family` amended) — planning, certification, and
  audit are suite-owned verbs, one canonical body each under
  `plugins/ok/ceremonies/`, vendored bare-named by the suite's
  converge; each family contributes per-verb ceremony surfaces
  materialized into its estate; the two audit verbs collapsed into
  one writing `/audit`, and the per-family audit skills plus
  `/verify-corpus` are retired and swept on converge.
- `story:corpus-audit` amended (with
  `decision:adversarial-implementation-audits` and
  `decision:audit-audience-split` amended, `concept:finding` amended)
  — the audit is two-axis (`determination:` support plus
  `compliance:`), covers concepts as well as stories and decisions,
  and `audit-check` enforces coverage, catalogs, shape, brevity,
  accountability, and agreement across every estate.

## Divergences

The detailed record lives in the sections above; the standing set,
for veto:

- Four in-cycle corpus-side repairs stand in the tree (per-hunk
  disclosure in the Divergences section above): `concepts/skill.md`,
  `concepts/estate.md`, `decisions/vendored-skills.md` together with
  `concepts/materialized-artifact.md`, and `concepts/true-up.md` —
  all the same suite-owned-ceremonies coherence widening.
- Two in-cycle repairs were made and reverted; neither stands:
  `concepts/sprint.md` and `stories/rules-compliance-report.md` (the
  latter's contradiction filed as
  `2026-08-08-123611-read-only-report-promise-outlives-its-verb.md`).
- Five calls made where the sprint was silent, recorded in "Calls
  made" above.
- The owner redirection (revision form backed out in favor of
  final-form deltas) is recorded in its own section above; the sprint
  document itself was revised to match and its boilerplate re-synced
  verbatim to the template.
- This certification run's three fixes were all to this report's own
  Divergences section: the undisclosed `true-up.md` repair disclosed;
  a bullet claiming a standing `sprint.md` repair corrected to a
  disclosed revert; two bullets extended to name every hunk of their
  diffs.

## Findings fixed

- Sprint alignment: 3 findings over 3 cycles — all
  completion-report disclosure accuracy, all fixed; deltas verbatim
  (16/16), work items realized with no undershoot, corpus coherent
  on every pass.
- Test suites: clean on first pass (7 suites, plus the repo checks).
- Mechanical floor: clean on first pass (66 annotations across the
  changed files, all resolving).
- Code review: clean on first pass; two scoped delta passes over the
  report fixes, both clean.

## Issues promoted

None this run — no kickbacks, no architect involvement, no cap
escalation. (The one open intake issue,
`2026-08-08-123611-read-only-report-promise-outlives-its-verb.md`,
was filed during execution before this run and awaits the owner's
ruling.)

The close-out — archiving this sprint with this report and its two
promoted issue receipts to `history/`, committing the work, and
stamping the archived sprint with the closing commit — was
pre-authorized by the owner and performed at the end of this run.
