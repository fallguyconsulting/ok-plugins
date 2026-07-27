---
closed: 9ae6639ccfc07cf2d09d421a2109dc5bf13d73ff
---

# Sprint: Skill families, front-door administration, audit-model reconciliation

## Intent

A feature-work sprint with three strands and no manufactured theme. First, the reconciliation the new planning phase surfaced: the out-of-band audit redesign (adversarial implementation audits replacing falsifier exhibition; proofs confined to stories) is regularized — its three already-edited artifacts restated here as approved deltas — and folded out to every artifact still speaking proof-mandate language; the sprint-boundary mechanism built earlier (the reconciliation phase and the close stamp) likewise lands in the corpus, with the git-commit mechanics owned by a new decision. Second, the distribution model completes its move off the plugin system: a new skill-family concept names the unit of project-scoped distribution; the three families become payload inside the front-door plugin at plugins/ok/families/; the front door becomes the suite's sole administrator, driving each family's conventional administration surfaces (converge core plus administration doc) — per-family true-up skills and the project-local merged true-up verb retire, and the integration contract's purpose reframes from dispatcher ignorance to factoring: family knowledge lives in the family's directory. Third, defect repair: the vendoring renderer's audit-name rewrite corrupted a support-script path in five vendored files; the renderers are tightened and the layer re-vendored.

No issues are promoted into this sprint (the intake is empty).

In-session owner rulings recorded: the falsifier model is retired because sustaining it would require editing code or maintaining an overlay — falsifiers remain as prose informing the audit; proofs are limited to stories as deterministic integration tests; stories and concepts stay abstract about the close record while a technical decision owns the git-commit mechanism; the families live inside the front-door plugin's directory as its payload (single copy, no release-time duplication); the merged project-local true-up retires because the front door represents the whole administration process.

## Corpus deltas

### New decision: adversarial-implementation-audits

```markdown
---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project implements what a story or decision claims is determined by an adversarial implementation audit: a durable, per-artifact determination (`satisfied` or `violated`) recorded in a fourth corpus collection, written only by a certification producer that did not implement the work under audit, and never hand-edited. Audits cite code by content anchors and pin quantified claims' population sources by file hash; a deterministic checker flags any audit whose design artifact, cited code, or population source has changed, and the stale set — not human memory — is what gets re-audited. Stories additionally carry deterministic integration-test proofs; decisions carry no test obligation. A negative determination stands in place until a re-audit flips it, and blocks certification unless linked to an intake issue awaiting the owner's ruling.

## Rationale

The claims that go wrong in practice are disproportionately structural, negative, or quantified — a transport a decision's text never reached, a rationale selling a property nothing delivers, an "every" enforced on the members someone remembered — and for those the honest verification is an adversarial reading against reality, with the population enumerated from the compose file or route table rather than from the artifact's own examples. Mandating a test per claim buys determinism at the cost of test-side machinery per claim and still misses the claims that are not runtime-observable; an audit covers every normative sentence at the cost of trusting a reader, and that trust is bounded three ways: the reader is never the author of the work, the determination is a signed, citation-carrying record that can be re-derived and compared, and staleness is mechanical — the fixer cannot satisfy an audit by any means except changing the code it cites, which breaks its anchors and forces a fresh adversarial read. Content anchors rather than line numbers make the tripwire survive unrelated edits; whole-file pins on population sources make a new member re-open the exact audits whose quantifiers it threatens.

## Alternatives

- Test mandates with registered falsifier exhibits per claim — deterministic and unfoolable where it applies, but a per-claim authoring and maintenance layer, and structurally blind to claims that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same class once, but leaves nothing to go stale, so nothing triggers the re-read when the code moves.
- Diff-scoped review as the only reader — reviews the change, so a claim whose code was never written produces nothing to review; absence has no diff.
```

### Amend concept: proof

```markdown
---
concept: proof
---

# Proof

## What it is

A proof is a codebase artifact — an integration test, demo, or example — that exercises a story's functionality deterministically against the assembled product, linked to its story by an annotation. The story's proof field is the canonical statement of intent; proof files are working examples of that intent. Proofs are not regression tests: they are exhibitions of intent that happen to live as runnable code. Proofs belong to stories only; a decision's verification is its implementation audit.

## Purpose

Proofs make a story's delivery executable: a third party can run them and watch the promised outcome happen. They are the deterministic half of verification — cheap to run, honest about pass/fail, blind to adequacy. Whether a green proof actually spans the story's claim is the implementation audit's adversarial question, answered with citations rather than assumed from the green.

## Boundaries

The protected thing is the intent, not the byte shape: updates that keep a proof satisfying its story's proof field are ambient code change; a change that makes it exhibit something different, less, or nothing is a story mutation and must ride a sprint's deltas. Removal requires explicit user direction — the agent never proposes it. Linkage belongs to the annotation (see also: annotation); execution belongs to the proof run; adequacy and implementation truth belong to the implementation audit; coverage of the audit corpus itself belongs to the corpus-audit (see also: corpus-proof, corpus-audit under stories). The intake's proof category names questions *about* proofs awaiting the owner's ruling — a classification label, not a third proof sense (see also: issue).

## Invariants

- Every live story has at least one annotated proof; an unannotated proof file proves nothing.
- Multiple proofs per story are welcome and adding one is unrestricted.
- When intent shifts, the proof-field rewrite comes first and the proof modification follows — never the reverse.
- Decisions carry no proofs; nothing in the corpus obligates a test per decision.
```

### Amend concept: falsifier

```markdown
---
concept: falsifier
---

# Falsifier

## What it is

A falsifier is the declared statement of what failure would look like: the user-observable absence that would prove a story is not delivered — the user acts and the promised result never appears, the result is unrelated to their input, the value-delivering component turns out to be synthetic. It is prose in the story artifact, not machinery: a story's `Falsifier` section states it explicitly.

## Purpose

The falsifier keeps both of a story's verifiers honest about what they are protecting. The proof author reads it to know what the integration test must be capable of detecting; the implementation auditor reads it to know what to hunt for adversarially — the specific way this claim would be false if it were false. A claim whose falsifier nobody can state is not a claim; it is a mood, and writing the falsifier at authoring time is what surfaces that early.

## Boundaries

The falsifier belongs to the story artifact (see also: story-artifact); decisions state no separate falsifier — what would violate a Choice is derived by its audit from the Choice itself (see also: decision-artifact). Exercising functionality against the falsifier's scenario belongs to the story's proof; adversarially determining whether the claim holds belongs to the implementation audit, which decomposes every normative sentence, enumerates quantified populations from reality, and records its determination with content-anchored citations (see also: proof).

## Invariants

- Every story states its falsifier as a user-observable absence, in the story's own terms, never as a mechanism.
- A falsifier names what would be observed if the story were undelivered — something a third party could watch fail, not an internal state.
```
### Amend concept: completion-contract

```markdown
---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition carried in every sprint: the corpus matches every delta applied verbatim; the proof run returns clean over the new and touched stories — every registered proof present, passing, and runnable; the implementation-audit corpus is current for everything the change touched or made stale, with any standing violation linked to an intake issue; and the change-scoped corpus checks and review-fix loop have run last, with mechanical findings fixed in-cycle and judgment findings filed to the intake for the next sprint.

## Purpose

Because the planner deliberately ships no execution engine, the contract is the entire interface between planning and execution: it tells whoever executes a sprint when the work is done, identically for every executor. It is what does not scale away when execution fans out.

## Boundaries

The contract owns the definition of "done" for a sprint, and its scope is the change: the stories, decisions, and audits the work touched. Whole-corpus proof and audit are the whole-corpus certification gate's business, run on the owner's cadence rather than per close (see also: certify-completion under stories). It does NOT own how work is staged or performed — that is execution-time planning (see also: sprint). The certification gate is the contract's realization plus review and presentation. The contract also legitimizes non-slash invocation of the checking verbs by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the corpus checks run last because their judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors owe the contract and nothing else.
- Story proofs are established by deterministic execution; whether an implementation genuinely satisfies a claim is established by the implementation audit, never by the implementer's own read (see also: proof, falsifier).
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

The proof run executes over the in-scope stories → each receives a verdict (pass, missing, failing, or unrunnable) in a structured in-context report, with failure output carried verbatim; the run invokes only harnesses the project itself documents; the intake queue is never written; and whether a green proof spans its story's claim is left to the implementation audit, never asserted by the run. The proof-running skill and the proofs it executes are real.

## Falsifier

A verdict is issued for a proof never executed; a failing run reports pass; the run bends a proof to green or weakens a verdict; an invented invocation stands in for the project's own harness; or findings leak into the owner's queue.

## Proof

Demo — a run over stories containing one honest passing proof, one deliberately failing proof, and one story with no annotated proof, reporting pass, failing, and missing respectively, with the working tree unchanged afterward.
```

### Amend story: certify-completion

```markdown
---
story: certify-completion
---

# Certify completed work through one gate

## Story

As a project owner, I want one terminal gate that aligns finished work to its sprint, drives every fixable finding to zero without my mid-run involvement, and presents outcomes and divergences to me whole, so that "done" means the same thing for every piece of work and I keep an after-the-fact veto over every call made in my absence.

## Acceptance

The owner (or the sprint's own boilerplate) invokes certification over completed work → sprint alignment is verified with undershoot treated as blocking, the completion-contract verbs run, implementation audits are written or refreshed by an auditor that did not implement the work — covering the touched artifacts and everything the change made stale — code and design-doc reviews dispatch, and a no-discretion fix loop drives findings to zero within a bounded number of cycles; truly unclear findings are filed to the intake queue, never asked live; the owner then receives one whole presentation — status, outcomes, divergences including every call made where sprint and corpus were silent, findings fixed, issues filed — and the sprint archives only when clean, with committing left to the owner and the close-out recording the close so the next planning ceremony can detect what lands after it.

## Falsifier

An undershoot survives into the presentation instead of being fixed; the implementer authors its own audit determinations; the orchestrator triages, defers, or summarizes findings away; the owner is interrupted mid-run with questions; an uncertified sprint is archived; a close leaves no record for the next ceremony's baseline; or divergences the owner should veto go unreported.

## Proof

Demo — a certification over work seeded with an undershot work item and a silent-intent gap, after which a third party sees the undershoot fixed (absent from the presentation), the gap either fixed-and-reported as a divergence or filed as an issue, the sprint archived only on clean status, and the archived sprint carrying its close record.
```

### Amend story: plan-a-sprint

```markdown
---
story: plan-a-sprint
---

# Plan a sprint with the owner

## Story

As a project owner, I want an interactive ceremony that turns my goals — and the open design questions and unreconciled work that bear on them — into a signed-off, self-sufficient sprint, so that any executor can realize my intent without re-deriving it or deciding my open questions for me.

## Acceptance

The owner drives the planning ceremony → work done since the last close is detected against the close's recorded baseline, filtered to what bears on the corpus's commitments, and reconciled with the owner up front — the corpus catching up, the code catching up, or the question deferred to the intake, each an owner call; the dialogue surfaces every tradeoff explicitly; on feature work a draft is produced first and only the open issues that bear on it are walked, one at a time, with the corpus artifacts relevant to each surfaced and read before presenting; each walked issue ends in the owner's promote-or-retire call; the draft passes compliance review; and after sign-off a sprint document exists containing final-form corpus deltas, flat work items, and the verbatim execution and completion boilerplate, with promotions recorded only once the approved sprint exists. The ceremony, its reviewers, and the compliance reviewer are real components.

## Falsifier

The produced sprint is not self-sufficient — an executor must consult the queue or history to learn what a resolution meant; issues are terminated without the owner's call; promotions land before sign-off; building proceeds over a bearing open issue, deciding it silently; or work that landed outside any sprint is built over without the owner reconciling it.

## Proof

Demo — a third party given only the finished sprint document can state exactly what will change in the corpus and code and when the work is done, and the queue fold shows every walked issue promoted into that sprint or retired with a reason.
```

### Amend concept: sprint

```markdown
---
concept: sprint
---

# Sprint

## What it is

A sprint is the planning ceremony's terminal artifact: a change-order against the design corpus, expressed as final-form corpus deltas plus the flat, unordered work items that realize them, terminated by a fixed completion contract. It is a sprint in the scrum sense — a collection of potentially disparate changes with no required unifying focus and no manufactured narrative.

## Purpose

The sprint is the whole interface between planning and execution. Because it is self-sufficient — everything the work needs, in final form — any executor works from the same brief: an inline session, a fan-out of subagents, or an external orchestrator. Staging and sequencing belong to execution time, so the sprint never has to be rewritten into a plan.

## Boundaries

A sprint owns approved intent: deltas, work items, and the two verbatim boilerplate sections (execution shape and completion contract). It does NOT own execution order — items are never grouped into stages, phases, or themes — and it is NOT the intake queue: questions live as issues until promoted, and after promotion the sprint alone is the source of truth (see also: issue, corpus-delta, completion-contract, plan-a-sprint under stories). Sprints are project records under the estate's record discipline, and the sprint being executed is that discipline's single live exception — the one record allowed in context (see also: estate, design-corpus). An archived sprint carries the record of its close, which the next planning ceremony reads as the baseline for detecting work done out of band (see also: closing-commit-baseline under decisions).

## Invariants

- Self-sufficiency: an executing agent never reads the queue or history to learn what a promoted issue "really meant"; a genuine gap is raised with the owner, never filled by inference.
- Work items name the stories and decisions they make true, and describe outcomes, not methods.
- A sprint archives only once it certifies clean; an uncertified sprint stays in flight.
- A sprint is never rewritten into a plan document.
```

### New decision: closing-commit-baseline

```markdown
---
decision: closing-commit-baseline
---

# The close is recorded as a commit stamp on the archived sprint

## Choice

When a certification close-out archives a sprint and commits the work, it stamps the archived sprint file's frontmatter with the closing commit — `closed: <sha of the archive commit>`, written after that commit lands and carried in one small follow-on commit. The planning ceremony resolves its out-of-band baseline as the newest archived sprint's stamp and computes the reconciliation window from that commit to the current tree; an archive with no stamped sprint yields no baseline, and the ceremony asks the owner for one rather than guessing.

## Rationale

The stamp makes "what landed outside any sprint" a mechanical git question instead of a memory question, and it lives on the artifact that defines the boundary — the closed sprint — so the record travels with the archive and needs no second ledger. Stamping after the archive commit is what lets the stamp name that commit exactly; the follow-on commit is the small price of an exact pointer.

## Alternatives

- A separate baseline ledger file in the estate — a second source of truth that drifts from the archive it describes.
- Deriving the close by inference (the commit that moved the sprint into the archive) — reconstructable but fragile across history rewrites and file moves, and invisible to a reader of the sprint file.
- No recorded baseline — out-of-band detection degrades to human memory, which is the failure the mechanism exists to end.
```

### Amend concept: design-corpus

```markdown
---
concept: design-corpus
aliases:
  - design docs
  - durable design docs
  - the corpus
---

# Design corpus

## What it is

The design corpus is a project's durable, committed model of what it is and what it owes its users, held at a fixed altitude: a catalog of load-bearing nouns (concepts), a catalog of durable user expectations (stories), and a catalog of technical tradeoffs (decisions), plus generated tables of contents over each catalog and a point-in-time discovery scaffold that feeds the initial extraction. It is a source of truth with the same weight as code: it describes the project as it stands, and it is read freely.

## Purpose

The corpus gives every agent and human one stable place to learn a project's identity, vocabulary, and obligations, so that identity does not live in transient conversation, stale specifications, or individual memory. Because code links back to it rather than the reverse, refactors that move files never invalidate the model, and a code path that diverges from a stated boundary is a defect rather than an ambiguity.

## Boundaries

The corpus holds only the general framing: what kinds of things exist, what the product owes users, and which tradeoffs were chosen. Specific interface designs, schemas, grammars, and implementation diagrams are NOT corpus material — they live in code and in sprints (see also: sprint). Open questions about the corpus live in the intake queue, not in artifact bodies (see also: issue). The implementation-audit corpus that verifies the corpus's claims against the code is a separate, machine-written collection in the estate — a record of determinations, not corpus material (see also: estate, adversarial-implementation-audits under decisions). The discovery scaffold inside the corpus directory is point-in-time and exempt from the durable rules. Neighbors: concept-artifact, story-artifact, decision-artifact, catalog-toc, corpus-delta, annotation, proof.

## Invariants

- After bootstrap, the corpus changes only by applying an approved sprint's corpus deltas — never ad hoc.
- The direction of reference is fixed: code cites the corpus via annotations; corpus bodies never cite code locations.
- Artifact bodies are self-contained and current-state only: no journals, no roadmaps, no path citations.
- The presence of the corpus is the gate other planning verbs key on; a project without one is directed to bootstrap first.
- The literal directory name is not load-bearing; the bright line is the altitude of the contents.
```
### New concept: skill-family

```markdown
---
concept: skill-family
aliases:
  - family
---

# Skill family

## What it is

A skill family is the suite's unit of project-scoped distribution: a self-contained directory of skills, templates, support scripts, and administration surfaces, carried whole as payload inside the front-door plugin and delivered into consumer projects as committed, vendored files. A family is not a plugin: nothing family-scoped installs machine-globally, and consumers meet a family only through its vendored presence in their project.

## Purpose

The family is the shape that gives every project its own version of the suite's behavior: installing one user-scoped plugin puts every family's canonical source on the machine, and each project owner converges deliberately from that payload. It also fixes where knowledge lives — everything specific to a family, from converge mechanics to migration judgment, belongs to the family's own directory, so the suite grows by adding a conforming directory rather than by editing its administrator.

## Boundaries

A family owns its skills, its estate's shape, its cheatsheet, and its administration surfaces (see also: estate, cheatsheet, skill, true-up). It does NOT own its own delivery: vendoring, wiring, and upkeep are the front door's administration, driven through the contract's conventional surfaces (see also: integration-contract, one-command-suite-upkeep under stories). The plugin system carries only the user-scoped plugins — the front door that carries the families, and the personal conduct (see also: conduct).

## Invariants

- Families travel only as front-door payload and reach projects only by vendoring; no family is separately installable.
- Every family exposes the contract's conventional administration surfaces, and family-specific knowledge lives nowhere but the family's directory.
- Whether a project uses a family is a filesystem check against its committed markers, never an inference.
```

### Amend concept: integration-contract

```markdown
---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set of conventions by which every skill family meets a consumer project, and by which the front door administers them all. It defines the layers of a family's presence — the committed project-side estate whose existence is the discovery marker, the always-in-context rules cheatsheet, the vendored skill set in the project's committed skills directory, and hook wiring transcribed into the project's committed harness settings — plus each family's conventional administration surfaces (a deterministic converge core and an administration document for the judgment the core cannot encode), the ownership rule, the vendored-name collision rule, version stamps, and stack tailoring.

## Purpose

The contract is what keeps the suite composable as it grows: family knowledge lives in the family's own directory at the contract's conventional surfaces, so the front door — the term names the administrator plugin, and this Purpose is its canonical definition — administers every family by driving those surfaces, and adding a family means adding a conforming directory, never rewriting the administrator. The front door is the suite's sole administrator, and administration is one process: install, converge, repair.

## Boundaries

The contract governs how families meet consumer projects and how the front door administers them; it does not govern any family's interior behavior, and the user-scoped plugins — the front door and the conduct — never integrate, so it does not govern their presence on a machine. Repo-root machinery — the marketplace catalog, the contract's own document, the release tooling, the maintenance checks — is maintenance material and part of no plugin or family. Its layers are realized by neighboring concepts: skill-family, estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile. "Front door" has no concept of its own — this artifact defines it. The front door's own conduct is the contract's consumer-side realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every family exposes the conventional administration surfaces the front door drives; families expose no administration verbs of their own.
- Vendored verb names collide by rule, never by accident: a verb name claimed by more than one integrated family materializes family-prefixed.
- Whether a project uses a family is a filesystem check, never an inference.
- Every discovery marker the front door honors is documented in the contract; the contract, not the administrator's prompt, is where the convention lives.
- Nothing in any family may assume a specific consumer project.
```

### Amend concept: true-up

```markdown
---
concept: true-up
---

# True-up

## What it is

True-up is the suite's administration act: the idempotent converge of a project's integrated-family presence — estate, cheatsheet, vendored skills, and hook wiring — toward what the front door's carried payload declares. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not suite-owned needs migrating, resolving, or transcribing), and converge (deterministic materialization of the suite-owned layer from committed declarations and the payload's canonical copies).

## Purpose

Because true-up is an idempotent installer — materializing a missing presence the same way it repairs a drifted one — the front door needs no separate install, upgrade, or repair modes: one act covers bootstrap and convergence alike, and a compliant project is a silent no-op. Converging the whole integrated set is a single administration pass, which is what keeps every upgrade, migration, and bootstrap deliberate per project.

## Boundaries

True-up is what the front door does, not a verb any family exposes and not a skill a project carries: each family contributes its conventional administration surfaces — the deterministic converge core, and the administration document holding the migration and repair judgment the core cannot encode — and the front door drives them (see also: skill-family, integration-contract). It never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers, hook wiring in the project's committed harness settings included (see also: estate, stack-profile, whole-file-ownership under decisions). It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations and the payload's canonical copies, never re-inferred at use time.
- Migration moves files and never rewrites their bodies; archived records keep their old wording.
- Invoking the administrator is itself the authorization to migrate the suite's own retired layouts; consent is reserved for genuine collisions, for content the suite does not own, and for transcription into owner-declared configuration.
```

### Amend concept: skill

```markdown
---
concept: skill
---

# Skill

## What it is

A skill is one named prompt file whose markdown body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs: authored inside skill families, and vendored by the front door's administration into the consumer project's committed skills directory, where consumers drive them by slash command and machinery drives the plumbing class through the skill-invocation tool.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing where it traces to a real failure or boundary confusion — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills declare themselves activated only by their explicit slash command, never auto-triggered by conversation content — some widening the activator to a named non-human caller such as whoever executes a completion contract (see also: completion-contract) — and plumbing skills drop that restriction so other machinery can drive them; a skill belongs to the plumbing class only while another suite surface is documented to drive it (see also: slash-only-activation under decisions). The project's skills directory is a flat namespace, so vendored names follow the contract's collision rule (see also: integration-contract). Skills do not chain into pipelines; each is terminal at its own artifact. A family may additionally ship an index skill — a router and briefing, not a verb, its per-skill rows single-sourced from the skills' own descriptions (see also: session-awareness under stories). Administration is not a skill surface: families expose converge cores and administration documents, not lifecycle verbs (see also: true-up). Canonical shared rule text is transcluded, never restated (see also: single-source-transclusion under decisions).

## Invariants

- The explicit-activation phrasing on user-facing skills is deliberate and preserved on new skills; inferential invocation is forbidden.
- A skill's negative-behavior list binds as strongly as its steps, and every entry traces to an observed failure or a genuine boundary confusion — never a mere negation of the skill's own description.
- A vendored skill is a materialized artifact: version-stamped, suite-owned, overwritten on converge, never hand-edited (see also: materialized-artifact).
```

### Amend concept: materialized-artifact

```markdown
---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a family-canonical file — a skill file, support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the front door's administration, version-stamped with the suite version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the front-door plugin changes nothing anywhere until each owner converges deliberately, and editing the suite's source cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are suite-owned whole files, never hand-edited. Hooks execute from the project's own materialized copies, reached through wiring transcribed into the project's committed harness settings — never from the front door's carried payload (see also: vendored-skills under decisions). The things that legitimately run from the payload are the administration process itself — diagnosis, bootstrap, and converge run before or while the project copies are being written — and read-only advisory verbs falling back with an announcement (see also: true-up, per-project-pinning under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the payload that wrote it.
- Diagnosis verifies fidelity against the canonical copy for the carried version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is proven to run at materialization time; one that cannot run is worse than none.
```

### Amend concept: cheatsheet

```markdown
---
concept: cheatsheet
aliases:
  - rules layer
---

# Cheatsheet

## What it is

A cheatsheet is the one suite-owned file each integrated skill family maintains in the consumer's always-in-context rules directory: the small, stable, condensed statement of the family's rules that every session sees, wholly owned and overwritten by the front door's administration — drift corrected by overwrite, never merge.

## Purpose

The cheatsheet is the layer that reaches contributors and sessions that never load a skill: committed to the project, it delivers the rules even to people with nothing installed. Keeping it small and stable is what earns it permanent context residency.

## Boundaries

One file per family; the project's other rules files are never touched, per the ownership rule (see also: whole-file-ownership under decisions). Production varies by family — stamped template, byte-copy of a canonical document, or rendered from the committed profile (see also: stack-profile, materialized-artifact). The optional conduct output style is explicitly not this layer (see also: conduct).

## Invariants

- Wholly suite-owned: local edits are not preserved.
- Content is a condensation of rules canonical elsewhere, never the canonical statement itself.
```

### Amend concept: estate

```markdown
---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is a skill family's committed project-side presence, rooted in one dot-directory at the consumer repo root named for the family: declared configuration (including any stack profile), the family's corpus of durable content, materialized support scripts and hooks, injected-context payloads, and any machine-written determination records. Its existence doubles as the discovery marker answering "which suite families does this project use."

## Purpose

Rooting everything in one committed directory makes integration state a property of the project rather than of any machine: contributors without anything installed still see the estate, discovery is a filesystem check, and each project runs exactly what it was converged to. Absence is a meaningful state — a bootstrap candidate or a recorded decline — not an error.

## Boundaries

The estate is suite territory inside the consumer's repo, converged by the front door's administration (see also: true-up); outside it a family owns only its cheatsheet and its vendored skill files (see also: cheatsheet, vendored-skills under decisions). Documented pre-migration marker locations are honored for discovery so un-migrated projects are still found and offered migration (see also: filesystem-discovery-markers under decisions). The front-door plugin deliberately has no estate. Content kinds inside an estate carry distinct context rules — source-of-truth corpus content, operational intake state, machine-written audit determinations, and project records (see also: design-corpus, issue, adversarial-implementation-audits under decisions). The record discipline is this concept's to state once: records — sprints, sketches, and the archive — are committed and versioned but out of agent context by default, with exactly one live exception (the sprint currently being executed), and every completed or retired record moves to its same-named folder in the archive (see also: sprint, sketch).

## Invariants

- The project root everything resolves against is the nearest git ancestor of the working directory, falling back to the working directory itself; every implementation of root resolution across the suite conforms to this one rule.
- Whether the estate is tracked in git is the project owner's decision where the family has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive; migration moves files, never rewrites their bodies.
- An estate-less family carried by the installed front door is offered bootstrap by consent; declining is a valid state, not drift.
```
### Amend decision: vendored-skills

```markdown
---
decision: vendored-skills
---

# Project-scoped behavior is vendored into the project

## Choice

Everything project-scoped the suite delivers — skill files, hook implementations, support scripts, context payloads, cheatsheets — reaches a consumer project as committed, version-stamped files materialized from the front-door plugin's carried family payload by its administration, and the harness is pointed at them project-side: skills live in the project's committed skills directory under the contract's collision rule, and hooks are declared in the project's committed harness settings by consented transcription, every session-start entry carrying the startup-clear-compact matcher and never firing on resume. The plugin system delivers only the user-scoped plugins — the front door carrying the families, and the conduct. A converged project is self-contained for running the suite: cloning it yields the working skills with nothing installed; converging needs only the front door.

## Rationale

The harness scopes plugin enablement per project but plugin content per machine: one installed copy serves every project, updating or editing it changes all of them at once, and no project has a version of its own. Committing the behavioral surface to the project makes the version a property of the repo — updates arrive as reviewable diffs, contributors get everything by cloning, and the machine-shared layer shrinks to the two things that are genuinely personal: the administrator and the conduct.

## Alternatives

- Distributing each family as its own installable plugin with per-family lifecycle verbs — the vendor source then lives in N machine-global installs, the marketplace distributes things that are not really plugins, and administration text is duplicated per family.
- Plugin-root hooks as shims to materialized copies, with skills machine-global — hooks would be pinned, but the skills and their governing text would still move under every project at once.
- A suite checkout committed per project and registered as a local marketplace — pins source, but the harness registry and installed state stay machine-global, so projects still contend for one registration.
- Staying fully on the plugin system — forfeits per-project versions entirely.
```

### Amend decision: per-project-pinning

```markdown
---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — vendored skills, scripts, hooks, cheatsheets, the vendored lint binary — is stamped with the suite version that wrote it and executes from the project's own copy; everything downstream prefers the project copy over the front door's carried payload. Exactly two classes legitimately run from the payload: the administration process itself (diagnosis, bootstrap, and converge, which run before or while the project copies are being written), and read-only advisory verbs — and an advisory verb falling back to the payload copy announces the fallback in its output. Updating the front-door plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, a ratchet baseline is only comparable against the version that produced it, and CI can lint at the project's pinned version with nothing installed. The pinning rule guards enforcement reproducibility; read-only advisory verbs are exploration tools, most useful before adoption, so they may read the payload copy — the announced fallback preserves the owner's ability to notice an unpinned answer. The stamp makes version drift mechanically checkable, and the gap between pinned and carried is itself the useful signal.

## Alternatives

- Always execute the payload's copy — every front-door update silently changes every project's behavior and breaks baseline comparability.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.
- Forcing advisory verbs through the pinning gate — makes pre-adoption exploration impossible, serving the letter against the reason.
```

### Amend decision: filesystem-discovery-markers

```markdown
---
decision: filesystem-discovery-markers
---

# Integration is discovered by filesystem markers, never inference

## Choice

"Which suite families does this project use" is answered solely by checking for each family's committed dot-directory estate at the project root (resolved as the nearest git ancestor), plus documented pre-migration marker locations so un-migrated projects are still discovered and offered migration. Hooks use the same rule to decide whether to no-op; absence is a meaningful state — bootstrap candidate or recorded decline — not an error.

## Rationale

A filesystem check is deterministic, per-project, and independent of anyone's memory of what was adopted where: integration state stays a property of the project, and the administrator reads it rather than deciding it. Inference from project content would misfire in both directions and make integration state a matter of opinion; honoring documented legacy markers keeps migration offerable without guessing.

## Alternatives

- Infer usage from project content or conversation — nondeterministic, and makes integration state a matter of opinion rather than a committed fact.
- A central registry of integrated families — a second source of truth that drifts from the estates themselves.
```

### Amend decision: lockstep-suite-version

```markdown
---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any change in the suite warrants, with one annotated repo-wide tag per release cut by the repo-local release skill; the carried family payload is stamped with that same suite version wherever it materializes. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins and the families they carry are designed as a set — one integration contract, one administrator, and a change in one family routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key, and equality at release time is the property consumers actually depend on.

## Alternatives

- Independent semver per plugin or per family — drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.
```

### Amend decision: whole-file-ownership

```markdown
---
decision: whole-file-ownership
---

# The suite owns whole files and never edits human-edited files

## Choice

The suite's machinery — the front door's administration and every family's converge core — owns whole files only: version-stamped, deterministically regenerable, overwritten wholesale. It never edits a file a human also edits; the consumer's own rules file and memory file are categorically untouchable. Ownership decides consent: suite-owned files converge silently, and the suite's own retired-layout content is suite territory, migrated mechanically under the administration's own authorization; anything else at a path the suite cares about — hand-written overlaps, preexisting guidance the suite would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment the machinery edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the suite's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the machinery destroys or shadows guidance the project chose deliberately.
- Consent-gating the suite's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.
```

### Amend story: one-command-suite-upkeep

```markdown
---
story: one-command-suite-upkeep
---

# Keep the whole suite current with one command

## Story

As a project owner, I want my project's whole suite presence brought current in one consolidated act, so that suite upkeep requires no per-family knowledge from me.

## Acceptance

The owner runs the front door → the installed user-scoped plugins are updated to the marketplace's current versions; integrated families are discovered by filesystem markers alone; carried-but-unintegrated families are offered bootstrap in exactly one consent question, with decline recorded as a valid state; each integrated or consented family is administered in one pass — diagnose, any consent the ownership rule requires, converge from the carried payload — with every hook-wiring consent presented once, together, and written only on the owner's yes; and a fixed summary table closes the run, naming per family the carried and project-stamped versions and the outcome. Migration and repair judgment comes from the family's own administration document, never improvised. The personal conduct plugin is never vendored or offered by the front door.

## Falsifier

A family is bootstrapped without consent or a plugin installed by the front door; an integrated family goes undiscovered; family knowledge is improvised rather than read from the family's own administration surfaces; hook wiring is written without the owner's yes; or the front door vendors or offers the conduct.

## Proof

Demo — a run on a project with one integrated family and one carried-but-unintegrated family, producing exactly one bootstrap question, a per-family administration pass a third party can reconcile against the project's filesystem markers and stamps, and a closing table.
```

### Amend story: converge-project-estate

```markdown
---
story: converge-project-estate
---

# Converge my project's estate deliberately

## Story

As a project owner, I want each family's project-side estate bootstrapped or repaired to match the suite version my machine carries — migrating retired layouts and asking before touching anything that is mine — so that upgrades are deliberate, repeatable, and never destructive.

## Acceptance

The front door administers a family → on an empty project the estate is materialized whole; on a drifted project the suite-owned layer is overwritten to match the carried version and retired layouts are migrated with bodies untouched; on a compliant project nothing changes at the git level; anything owner-declared or overlapping is surfaced for consent rather than silently converted. Each family's diagnose-and-converge machinery is real.

## Falsifier

Repeated runs churn the working tree; a hand-edited or owner-declared file is silently overwritten; a retired layout is left half-migrated or its archived records rewritten; or a missing estate fails to bootstrap.

## Proof

Demo — three consecutive administration passes on one project: a bootstrap from nothing, a repair after deliberate drift in a suite-owned file, and a no-op on the resulting compliant estate, with the git status empty after the third.
```
## Work items

Flat and unordered; each names the artifacts it makes true. Dependencies are stated where real.

- **Family payload relocation** (`concept:skill-family`, `decision:vendored-skills`): the three families move to `plugins/ok/families/{ok-planner,ok-plumbline,ok-workspaces}`, whole — skills, scripts, docs, tests, licenses; `plugins/` holds exactly the two user-scoped plugins. Family plugin manifests retire; every version stamp the family machinery writes derives from the front-door manifest (the suite version).
- **Front-door administrator rewrite** (`story:one-command-suite-upkeep`, `concept:integration-contract`, `concept:true-up`): `/ok` becomes the whole administration process — update the installed user-scoped plugins, discover integrated families by contract-documented markers, offer bootstrap in one consent question, then per family drive its conventional administration surfaces from the carried payload: run the converge core, consult the family's administration document for any migration or repair judgment, collect every `WIRING NEEDED` block and present all hook wiring once for consent, and close with the per-family table (carried version, project-stamped version, outcome). No Skill-tool invocation of family verbs anywhere in the flow.
- **Family administration surfaces** (`concept:skill-family`, `concept:true-up`, `concept:integration-contract`): each family directory gains the contract's two conventional surfaces — its deterministic converge core at the conventional path (the existing converge scripts, repositioned) and an administration document carrying the judgment the core cannot encode (the planner's retired-layout and intake-integrity procedures, plumbline's config-declaration walkthrough and conflict handling, workspaces' profile walkthrough and drift resolution — all moved out of the retiring true-up skills, none improvised by the administrator).
- **Retire the true-up verbs** (`concept:skill`, `concept:integration-contract`, `concept:true-up`): the three family true-up skills and the shared merged-verb template are deleted; converge stops materializing `.claude/skills/true-up/` and removes it from existing projects as a retired payload; the activation-guard allowlist and hub tables shed the entries.
- **Vendoring renderer fix** (`decision:vendored-skills`): the audit-name rewrite in the planner and workspaces renderers no longer matches support-script paths (the `bin/audit-check` corruption), the five corrupted vendored files re-render correctly, and the re-vendored layer diagnoses clean. Depends on the relocation item settling source paths.
- **Contract document rewrite** (`concept:integration-contract`, `concept:skill-family`): the normative contract document describes the family layers, the two conventional administration surfaces, the collision rule, every honored discovery marker, consented hook wiring, version stamps, and repo-root machinery, with a per-family conformance section.
- **Planner template and boilerplate alignment** (`concept:completion-contract`, `story:plan-a-sprint`, `story:certify-completion`): the sprint template's baked execution boilerplate reflects the audit model (story proofs deterministic; decision verification is certification's implementation audit) and the completion contract's audit-currency clause; the estate guide and cheatsheet templates reflect the retired merged verb and front-door administration; the certify gates' close-out and the planning ceremony's baseline phase read exactly as `decision:closing-commit-baseline` states.
- **Checks suite update** (`decision:vendored-skills`, `decision:whole-file-ownership`, `decision:slash-only-activation`): the vendored-layer conformance check drives the new source paths and asserts the retired merged verb is absent; the owned-path check re-anchors to the family converge cores and the front door's write surfaces; the activation-guard allowlist drops the retired true-up entries; text-presence assertions re-anchor to any governing lines the rewrites move.
- **Release skill update** (`decision:lockstep-suite-version`): the release surveys and stamps the two plugin manifests, treats family changes under the front door's payload as suite changes, and its manifest-equality assertion covers exactly the manifests that exist.
- **Docs alignment**: README and the plugin and family development guides describe the family model — install the front door, optionally the conduct; families are payload, never installed — and the audit-model verification story.
- **Dogfood re-converge** (all of the above): this repo converges under the new administrator — vendored layer re-stamped from the relocated payload, `.claude/skills/true-up/` removed, hook wiring intact, checks green.

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

4. Build stage by stage. Every new or amended story and decision gets
   its proof: present, carrying its `@story:` / `@decision:`
   annotation, and able to actually fail under a producible falsifier.
   Write the proof with the work, not at the end.

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
2. `/prove` returns clean over all new and touched stories and
   decisions: every proof present, passing, and non-vacuous.
3. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
