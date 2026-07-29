# Sprint: Corpus browser, plumbline surface coverage, verification-cost discipline

## Intent

This sprint has no single theme, and does not pretend to one. It carries
two unrelated bodies of work.

The first is a new capability: a view that makes the corpus-to-code
relation the audit corpus already records legible to a person — which code
each live story and decision claims, and which sources nothing claims at
all. The second is the resolution of four ruled issues drawn from the
intake: two plumbline verbs brought under committed stories, one retired,
and the verification-cost gap closed in the planner family.

It also carries retroactive authorization for two concept edits made
outside any sprint, reconciled at this ceremony's out-of-band walk.

Promoted issues: `plumbline-ci-emission-ungoverned`,
`plumbline-explain-verb-ungoverned`, `plumbline-slug-verb-ungoverned`,
`verification-cost-work-has-no-measurement-discipline`.

## Corpus deltas

### Amend concept: decision-artifact

```markdown
---
concept: decision-artifact
aliases:
  - decision
  - TD
  - technical decision
---

# Decision (artifact kind)

## What it is

A decision is the design-corpus artifact kind that records a real architectural or technical choice: one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is that a reasonable engineer can name both the choice and a plausible different choice, and the rationale is a tradeoff rather than a default. A choice with no plausible alternative is a default, not a decision.

## Purpose

Decisions preserve the reasoning that picked one shape over another, so later work neither silently re-litigates settled tradeoffs nor cargo-cults shapes whose rationale is lost. They also absorb the specifics that concepts must not carry: the decision names the instances; the concept names the kind.

## Boundaries

A decision owns the choice, the tradeoff, and the alternatives that were on the table. It owns no verification of its own: it carries no proof and states no separate falsifier — whether an implementation honors the choice is determined adversarially by the decision's implementation audit, which derives what would violate the choice from the choice itself. Its choice section may name the specific artifact picked, because the artifact identity carries the tradeoff — the sanctioned exemption to self-containment. It is NOT a spec (no implementation steps or schemas) and NOT a design (no inner workings of the chosen thing). Neighbors: concept-artifact, story-artifact, proof, falsifier.

## Invariants

- One decision per choice; unrelated choices never share a file.
```

### Amend concept: finding

```markdown
---
concept: finding
---

# Finding

## What it is

A finding is one defect surfaced by any of the suite's review passes — compliance review, coverage and drift checks, code review, proof runs. Every finding is classified on one axis: mechanical (fixable without owner judgment — a forbidden section to strip, a stale index line, a dangling cross-reference with an obvious successor) or judgment (requires owner calibration — a boundary unstatable without naming a file, a story with no honest benefit clause, a decision whose rationale is a default rather than a tradeoff).

## Purpose

The mechanical/judgment split is the suite's routing rule for defects: it keeps owners out of work agents can finish alone, and keeps agents from silently deciding questions that belong to the owner. The classification says which findings an agent may finish and which need the owner's calibration; it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act.

## Boundaries

Mechanical findings are handed back to the producing cycle's caller and fixed in-cycle, then re-verified; they never become issues. Judgment findings do not route themselves: a judgment classification is advisory context for whoever holds the report, and the intake is reached only by a deliberate act of filing — the human reading a standalone report files what they judge fork-worthy, certification's architect, the repeating cycle's one gated writer, files what survived the fixer's veto test and its own adversarial check, and the one-time corpus bootstrap files the judgment questions its review loops surface, ungated by design because it sits outside that cycle; what lands there then waits for planning (see also: issue, prove-audit-audience-split under decisions). During certification the bar is deliberately high: fixable is the overwhelming default, a finding is judgment only when sprint and corpus are silent AND reasonable resolutions materially diverge on product intent, and the owner is never asked live (see also: certify-completion under stories). Proof-run verdicts are findings for the executing agent, never queue rows (see also: corpus-proof under stories).

## Invariants

- A finding is fixed, filed, or explicitly stuck at a loop cap — never silently dropped, summarized away, or triaged out by an orchestrator.
- The classifier never grades severity; the split is the only taxonomy.
```

### New story: trace-corpus-to-code

```markdown
---
story: trace-corpus-to-code
---

# See which code each story and decision actually claims

## Story

As someone working on a project the planner governs, I want to see which code each live story and decision claims, and which sources nothing claims at all, so that I can judge what the project's durable model actually covers without re-deriving it from audit prose.

## Acceptance

The reader opens the project's corpus view → every live story and decision is listed with its audit determination, and opening one shows the code that audit cites, excerpted in place; from any source file the reader sees which stories and decisions claim which of its regions, and which regions nothing claims; and the sources carrying no claim at all are reachable as a view of their own rather than left implicit. A claim over a whole file is shown as the file-level claim it is, never as a claim over each of its lines. The determinations, citations, and code are the project's real ones, resolved by the project's own materialized audit checker, so the view never contradicts what that project's certification gate reports.

## Falsifier

The view shows an artifact claiming code its audit does not cite, or marks code as claimed that no citation reaches; a whole-file claim is rendered as if every line served the artifact; sources nothing claims are invisible, so the corpus reads as fully covered; or the view reports a citation current that the project's own checker reports stale.

## Proof

Demo — on a project with a live corpus: a third party opens a story, sees the code its audit cites excerpted, follows it into that file, sees the same story claiming that region alongside a region nothing claims, reaches the uncited sources as their own view, and observes the view's verdict for a deliberately broken citation agreeing with the checker's.
```

### New decision: local-web-surface

```markdown
---
decision: local-web-surface
---

# The corpus view is a local web application

## Choice

The corpus view is delivered as a read-only local web application — a page served over loopback by a program the project runs on demand — rather than as terminal output or an editor extension.

## Rationale

The view's core act is lateral movement: artifact to code, code back to the artifacts claiming it, a cited region out to its enclosing unit, all with excerpts held open beside a list. A terminal report can print any one of those but cannot keep several navigable at once, so every lateral step costs another invocation and loses the reader's place. An editor extension buys the best code surface at the price of one editor's plugin model and a separate implementation per editor. A local page gives arbitrary navigation and inline excerpting together, while remaining something the owner starts and closes.

## Alternatives

- A terminal report per artifact — composes with the suite's existing verbs, but flattens navigation into one linear dump per invocation.
- An editor extension — the strongest code surface, at the cost of a per-editor implementation and per-editor drift.
- A static site generated and committed per project — no service to run, but excerpts freeze at generation time and the generated artifact lands in every consumer repository.
```

### New decision: built-bundle-fetched-at-pin

```markdown
---
decision: built-bundle-fetched-at-pin
---

# The view's build is fetched to match the project's pinned version, never committed

## Choice

The corpus view's frontend is built once per suite release and carried as family payload. A project receives the build matching the suite version its estate is already stamped with, placed inside the planner's estate and ignored by git rather than committed. Earlier versioned builds stay retrievable, so a project pinned to an older suite version keeps a build that understands the corpus of its era.

## Rationale

Per-project pinning is the property that decides this. The corpus's citation forms move between releases, so a view built against a newer corpus renders an older project as empty or broken. Committing the build into each consumer estate would pin it correctly but pay a permanent, churning generated artifact in repositories that gain nothing from its bytes; running the front door's carried build unpinned would keep those repositories clean but misread exactly the projects that have not converged. Fetching the pinned build keeps both properties. No new committed record is needed to support it: the estate already carries the suite version stamp and already serves as the discovery marker.

## Alternatives

- Commit the built bundle into each consumer estate — correctly pinned, but a large generated artifact rewritten wholesale in every repository on every converge.
- Run the front door's carried build unpinned — nothing lands in consumer repositories, but a project behind the current release gets a view that misreads its own corpus.
- Render every view server-side and ship no build — no distributed artifact at all, at the cost of the interaction the surface choice exists to buy.
```

### New decision: resolution-through-pinned-checker

```markdown
---
decision: resolution-through-pinned-checker
---

# Citations are resolved by the project's own checker, never by a second implementation

## Choice

The program serving the corpus view resolves every citation by calling the project's own materialized audit checker, rather than reimplementing anchor location, release-metadata masking, and span hashing inside itself.

## Rationale

The checker carries the certification gate's arithmetic, including a masking rule that deliberately ignores release-mutable metadata so that a version bump voids no audit. A second implementation of that rule would drift from it, and the drift would surface as the view calling a citation stale that the gate calls clean — worst precisely during a release, which is when someone would open the view to understand what moved. Calling the project's own copy makes that disagreement structurally impossible, and inherits each project's pinned resolution behavior without tracking it separately.

## Alternatives

- Reimplement resolution inside the serving program — no dependence on the checker's internals, at the cost of two implementations of one rule that must never disagree.
- Invoke the checker's command line per citation — the same authority, but its output reports findings rather than resolved locations, so what the view needs is not exposed.
- Read the committed source graph alone — sufficient for node citations, but blind to the anchor-based citation forms that carry most of the corpus.
```

### New story: pipeline-check-wiring

```markdown
---
story: pipeline-check-wiring
---

# Receive working pipeline configuration for the adopted checks

## Story

As an owner adopting the lint on a project with a pipeline, I want ready-to-use configuration that runs the committed checks on every change, so that the rules the project has adopted are enforced on contributions I never review by hand.

## Acceptance

The owner asks for pipeline configuration for their platform → they receive working configuration that runs the lint, failing on any violation, and the ratchet check, failing whenever the recorded violation count has risen; the configuration invokes the project's own committed lint rather than an installed one, so the pipeline enforces the version the project was converged to. What the owner receives runs as given — it is real configuration, not an illustration to adapt.

## Falsifier

The emitted configuration does not run as given; it passes while a violation is present, or while the recorded count has risen; it invokes a lint the pipeline does not have, so the job fails for want of an install rather than for a violation; or the owner must write the wiring themselves from prose.

## Proof

Demo — the emitted configuration for one platform, run unmodified against a repository with a seeded violation and against one whose recorded count has risen, failing in both, and passing on a clean tree at a held count.
```

### New story: explain-lint-rules

```markdown
---
story: explain-lint-rules
---

# Learn what a lint rule means without reading the linter

## Story

As someone meeting a lint violation I do not recognise, I want the canonical definition and examples for the rule that fired, so that I can decide whether to fix the code or change the configuration without reading the linter's source.

## Acceptance

The reader asks about a check code or a configuration topic → they receive that rule's canonical definition and worked examples, drawn from the project's own committed lint so the explanation matches the rules that project actually enforces; asking without a topic lists what can be explained. The definitions delivered are the lint's own, not a separately maintained restatement of them.

## Falsifier

An explained rule's description contradicts what the lint enforces; a check code the lint can emit has no explanation; the explanation is a hand-maintained copy that drifts from the rules it describes; or the reader must read the lint's source to learn what a code means.

## Proof

Demo — a check code taken from a real lint run and explained; the explanation's stated behavior confirmed by a run that triggers the rule and then satisfies it; and the topic listing covering every check code the lint can emit.
```

### Amend story: corpus-proof

```markdown
---
story: corpus-proof
---

# Prove the corpus's story claims deterministically

## Story

As an executing agent closing work against a sprint, I want every live story's registered proofs executed deterministically, so that a story's promised functionality is demonstrated by a run a third party can repeat rather than by a read-through opinion.

## Acceptance

The proof run executes over the in-scope stories → each receives a verdict (pass, missing, failing, or unrunnable) in a structured in-context report, with failure output carried verbatim, and each executed proof also receives the time it took; the run leaves those timings as a durable artifact a later session reads without re-running anything. The run invokes only harnesses the project itself documents; the intake queue is never written; and whether a green proof spans its story's claim is left to the implementation audit, never asserted by the run. The proof-running skill and the proofs it executes are real.

## Falsifier

A verdict is issued for a proof never executed; a failing run reports pass; the run bends a proof to green or weakens a verdict; an invented invocation stands in for the project's own harness; findings leak into the owner's queue; or a completed run leaves no readable record of what each proof cost, so the next cost question requires another full run.

## Proof

Demo — a run over stories containing one honest passing proof, one deliberately failing proof, and one story with no annotated proof, reporting pass, failing, and missing respectively, leaving per-proof timings a second session reads without re-running, with the working tree otherwise unchanged afterward.
```

### New decision: measure-first-verification-cost

```markdown
---
decision: measure-first-verification-cost
---

# Changing verification cost is performance engineering

## Choice

Changing what a verification suite costs follows performance-engineering discipline: a profile is taken before any change, the change is justified by what that profile names, and a re-measure confirms the effect. The timings the proof run records are the profile of record.

## Rationale

Verification cost reads as test work, and the measure-first reflex that fires reliably on product code does not fire on it. Naming the discipline is what makes the reflex fire. Grounding it on timings the proof run already leaves is what makes measuring the cheap path rather than another full run. The two halves fail apart: a measure-first rule with no measurement available is unaffordable in practice, and a timing record nobody is directed to consult changes nothing.

## Alternatives

- Leave verification cost to ordinary engineering judgment — no new commitment, but the observed failure stands unaddressed.
- Record the timing artifact without stating the discipline — the data exists and nothing directs anyone to it before changing the suite.
- Home the discipline with the lint family's existing check-speed criterion — reaches authoring-time placement choices only, never the cost of a run.
```

## Work items

- **The corpus view.** Deliver `story:trace-corpus-to-code`: a program a project runs on demand that presents every live story and decision with its audit determination and the code that audit cites, lets a reader move from an artifact into a source file and back to the artifacts claiming its regions, distinguishes a whole-file claim from a claim over specific lines, and reaches the sources nothing claims as a view of their own. Realizes `decision:local-web-surface` and `decision:resolution-through-pinned-checker`: the surface is a loopback-served page, and every citation is resolved by calling the project's own materialized audit checker rather than a second implementation. Carries the story's proof.

- **Release-built view, delivered at the project's pin.** Realizes `decision:built-bundle-fetched-at-pin`: the view's frontend is built as part of producing a suite release and carried as family payload; a project's administration places the build matching the suite version its estate is stamped with, inside the planner's estate and ignored by git; builds for earlier suite versions remain retrievable. Depends on the corpus view existing to be built. Includes whatever the estate needs so that an ignored build does not become content of the repository or of the source graph.

- **Announce the version the view is running.** The corpus view is a read-only advisory verb under `decision:per-project-pinning`, which requires an advisory verb reading the front door's payload to announce that fallback in its output. Make the version the view is running, and whether it is the project's pinned build, visible to the reader.

- **Per-proof timings.** Realizes the amended `story:corpus-proof`: the proof run records the time each executed proof took and leaves it as a durable artifact a later session reads without re-running. Covers the proof-running verb and the harnesses of all three families, none of which currently emits per-proof timings. Update the story's proof to exhibit the timing artifact.

- **Retire the `slug` verb.** Remove the `slug` skill from the plumbline family and its entry in the family's vendored-skills mapping, so the verb leaves every consumer's skills directory on the next converge. No corpus artifact covers it, so nothing is retired from `design/`; remove any test fixtures or references that exist only to exercise it.

- **Bring the pipeline-wiring verb under its story.** Realizes `story:pipeline-check-wiring`. The emitting verb exists; establish that what it emits satisfies the story — configuration that runs as given, fails on any violation, fails when the recorded count has risen, and invokes the project's committed lint — and carry the story's proof.

- **Bring the rule-explanation verb under its story.** Realizes `story:explain-lint-rules`. The verb exists; establish that its definitions come from the project's committed lint rather than a separately maintained copy, that its topic listing covers every check code the lint can emit, and carry the story's proof.

- **Record the measure-first discipline where sessions will meet it.** Realizes `decision:measure-first-verification-cost`. The decision carries no proof; its verification is its implementation audit, so the choice needs an enforcement point a citation can reach — the guidance a session follows when asked to change what verification costs. Depends on per-proof timings existing, since the discipline is grounded on them.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work. The items above are a flat, unordered list; group
   them by theme, file surface, or dependency and order the groups so
   nothing is built on something not yet there. Staging lives in the
   executor's working state — a task list, an orchestrator's graph.
   It is never rewritten into a plan document: this sprint is the
   whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story gets its proof: a
   deterministic integration test (or demo) present, carrying its
   `@story:` annotation, and able to actually fail under the story's
   falsifier. Write the proof with the work, not at the end. Decisions
   carry no proofs — a decision's verification is the implementation
   audit certification writes.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, or a destructive/irreversible
   action not clearly authorized. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Close by running `/certify-work`. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope: `/prove` over the touched
   stories and decisions, change-scoped corpus checks over the
   touched artifacts and annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whole-corpus certification is `/certify-all`, run on the owner's
   cadence, not per close.) The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends by offering the close-out — archiving
   this sprint and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories: every
   registered proof present, passing, and runnable.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue.
4. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
