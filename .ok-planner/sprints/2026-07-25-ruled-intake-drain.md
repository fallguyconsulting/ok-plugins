# Sprint: Ruled intake drain — corpus corrections, dead capability removal, proof declarations

## Intent

An intake-drain sprint over the ruled batch the owner named: the 35 verified issues whose generated or recommended rulings the owner accepted, plus one earlier live-transcribed ruling whose substance this sprint realizes. No single theme — the items are corpus-vs-reality corrections, dead-capability removals, proof-field declarations under the prompt-executed-checks precedent, and small deterministic checks. Seven attention-flagged issues remain open in the intake and are not part of this sprint.

Issues promoted into this sprint (36):
`prompt-executed-checks-as-proofs`,
`proof-filesystem-discovery-markers`, `proof-prove-audit-audience-split`, `proof-relevance-scoped-queue-gate`, `proof-single-source-transclusion`, `proof-slash-only-activation`, `proof-hook-shims`, `proof-lockstep-suite-version`, `proof-no-execution-engine`,
`activation-class-rule-unstated`, `audit-verb-overload`, `budget-baseline-outside-estate`, `check-flags-vs-no-soft-start`, `prove-scope-clause-mismatch`, `retired-layout-migration-consent`, `retirement-mechanics-diverge`, `toc-retired-section-shape`, `toc-refresh-owner-unassigned`, `session-start-matcher-asymmetry`, `status-field-values-undefined`, `verb-set-omits-prove`, `close-integration-branch-resolution`, `design-notes-unmarked-superseded`, `falsifier-field-asymmetry`, `planner-diagnose-not-standalone`, `planner-tooling-constraint-vs-python`, `plumbline-estate-dogfood-gap`, `profile-version-field-unread`, `proof-noun-overload`, `root-resolution-copy-family`, `stamp-coverage-inconsistent`, `concept-instance-enumeration-altitude`, `front-door-concept-unpromoted`, `intake-queue-concept-unpromoted`, `workspaces-audit-story-home`.

Retired during this session (recorded in their files, moved to history): `goal-mechanism-external` (corpus already at the right altitude; concrete host naming in docs is acceptable), `model-pinning-vs-most-capable` (ruling ratified the status quo; already realized by the shared dispatch discipline).

Two sprint-wide notes the deltas depend on:

- The `status:` frontmatter field on corpus artifacts is retired by this sprint (nothing reads or defines it). Every delta below is final-form **without** it; a work item removes it from the shared templates and strips it from the untouched live artifacts.
- Five decision Proof rewrites apply the owner's prompt-executed-checks precedent: prompt-realized discipline gets a **declared text-presence proof** — the governing line stands greppably, the falsifier is its deletion, and the Proof says it checks presence, not behavior.

## Corpus deltas

### Amend decision: slash-only-activation

```markdown
---
decision: slash-only-activation
---

# User-facing skills activate only on explicit command

## Choice

Every user-facing skill declares in its description that it is activated only by its explicit slash command and never auto-triggered by conversation content — some naming one additional legitimate non-human activator, such as whoever executes a sprint's completion contract — while plumbing skills deliberately drop the restriction so the front door and sibling skills can drive them through the skill tool. The membership rule: a skill carries the explicit-activation guard unless another suite surface is documented to drive it through the skill-invocation tool; absence of a documented machine driver means the guard belongs.

## Rationale

The activation phrase is load-bearing prompt engineering: it prevents the model from invoking consequential ceremonies inferentially because a conversation resembled one. The two-class split preserves composability — machinery can still drive the plumbing layer — without opening user-facing verbs to inference, and the membership rule keeps the split testable as skills are added.

## Alternatives

- Let skills trigger on inferred intent — consequential verbs (planning, certification, teardown) fire on resemblance rather than instruction.
- Restrict every skill to slash commands — the front door could no longer drive lifecycle verbs, breaking suite composition.
- Classify by feel per skill — the unstated-rule state this decision retired, which produced divergent same-named skills.

## Proof

Presence check over skill frontmatter: every user-facing skill's description carries the explicit-activation phrase, with plumbing skills on a named allowlist justified by their documented machine drivers. Falsifier: strip the phrase from any user-facing skill, or allowlist a skill with no documented driver — the check goes red. Declared as presence, not behavior: activation conduct itself is prompt-realized and unprovable.
```

### Amend concept: skill

```markdown
---
concept: skill
---

# Skill

## What it is

A skill is one named prompt file inside a plugin whose markdown body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs; consumers drive them by slash command, and machinery drives the plumbing class through the skill-invocation tool.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills declare themselves activated only by their explicit slash command, never auto-triggered by conversation content — some widening the activator to a named non-human caller such as whoever executes a completion contract (see also: completion-contract) — and plumbing skills drop that restriction so other machinery can drive them; a skill belongs to the plumbing class only while another suite surface is documented to drive it (see also: slash-only-activation under decisions). The contract's uniform verbs intentionally share names across plugins, and invocation is plugin-qualified where more than one is integrated (see also: integration-contract). Skills do not chain into pipelines; each is terminal at its own artifact. A plugin may additionally ship an index skill — a briefing, not a verb — injected into sessions at start (see also: session-awareness under stories). Canonical shared rule text is transcluded, never restated (see also: single-source-transclusion under decisions).

## Invariants

- The explicit-activation phrasing on user-facing skills is deliberate and preserved on new skills; inferential invocation is forbidden.
- A skill's negative-behavior list binds as strongly as its steps.
```

### Amend decision: ratchet-over-soft-start

```markdown
---
decision: ratchet-over-soft-start
---

# Adoption eases by one-way ratchet, never by softened checks

## Choice

A project whose violation backlog is too large to clear at once records a baseline count in a budget file inside the plugin's estate — migrated there from any earlier root-level location by the lifecycle verb — and CI fails any change that increases it while accepting any that holds or decreases it: a one-way ratchet. The checks themselves stay strict from day one; there is no soft start, and the config schema exposes no switch that disables a check.

## Rationale

The ratchet separates "we have debt" from "we make new debt": work continues immediately, regression is mechanically impossible, and the baseline only ever moves down. Softening the checks instead would re-open exactly the judgment seams the methodology exists to close, and grandfathered leniency tends to become permanent — which is also why no disabling switch ships at all.

## Alternatives

- Disable checks until the backlog is cleared — a soft start that in practice never ends.
- Per-check config flags that skip a check outright — shipped briefly as unproposed schema capability and retired; the rejected soft start in switch form.
- Per-violation suppression annotations — scatters permanent exemptions through the code as more residue.
- Big-bang cleanup before adoption — stops feature work and loses to drift racing the cleanup.

## Proof

The ratchet check exits nonzero whenever the current violation count exceeds the recorded baseline; introducing one net-new violation on a baselined project turns CI red, and the check is what CI templates run on every change.
```

### Amend concept: completion-contract

```markdown
---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition carried in every sprint: the corpus matches every delta applied verbatim; the proof run returns clean over the new and touched stories and decisions — every proof present, passing, and non-vacuous; and the change-scoped corpus checks and review-fix loop have run last, with mechanical findings fixed in-cycle and judgment findings filed to the intake for the next sprint.

## Purpose

Because the planner deliberately ships no execution engine, the contract is the entire interface between planning and execution: it tells whoever executes a sprint when the work is done, identically for every executor. It is what does not scale away when execution fans out.

## Boundaries

The contract owns the definition of "done" for a sprint, and its scope is the change: the stories and decisions the work touched. Whole-corpus proof and audit are the whole-corpus certification gate's business, run on the owner's cadence rather than per close (see also: certify-completion under stories). It does NOT own how work is staged or performed — that is execution-time planning (see also: sprint). The certification gate is the contract's realization plus review and presentation. The contract also legitimizes non-slash invocation of the checking verbs by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the corpus checks run last because their judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors owe the contract and nothing else.
- Proof cleanliness is established by execution and falsifier exhibition, never by reading (see also: falsifier).
```

### Amend concept: true-up

```markdown
---
concept: true-up
---

# True-up

## What it is

True-up is the suite's uniform lifecycle verb: the idempotent converge of a plugin's project-side estate toward what the installed plugin declares. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not plugin-owned needs migrating or resolving), and converge (deterministic materialization of the plugin-owned layer from committed declarations).

## Purpose

Because every true-up is an idempotent installer — materializing a missing estate the same way it repairs a drifted one — the front door needs no per-plugin install knowledge, and a compliant project is a silent no-op. The verb is the single place upgrades, migrations, and bootstraps happen, which is what makes convergence deliberate.

## Boundaries

True-up owns the plugin-owned layer of the estate and the mechanics of retired-layout migration; it never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers (see also: estate, stack-profile, ownership under decisions: whole-file-ownership). Other skills lean on it as plumbing so the layout exists before they write. It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations, never re-inferred at use time.
- Migration moves files and never rewrites their bodies; archived records keep their old wording.
- Invoking the verb is itself the authorization to migrate the plugin's own retired layout; consent is reserved for genuine collisions and for content the plugin does not own.
```

### Amend decision: whole-file-ownership

```markdown
---
decision: whole-file-ownership
---

# Plugins own whole files and never edit human-edited files

## Choice

A plugin owns whole files only — version-stamped, deterministically regenerable, overwritten wholesale — and never edits a file a human also edits; the consumer's own rules file and memory file are categorically untouchable. Ownership decides consent: plugin-owned files converge silently, and the plugin's own retired-layout content is plugin territory, migrated mechanically under the lifecycle verb's own authorization; anything else at a path the plugin cares about — hand-written overlaps, preexisting guidance the plugin would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment a plugin edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the plugin's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the plugin destroys or shadows guidance the project chose deliberately.
- Consent-gating the plugin's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.

## Proof

No enforcing check exists today: diagnosis verifies the plugin-owned layer's fidelity but nothing fails if a plugin writes into a human-edited file; the boundary lives in contract prose and skill text. Filed to the intake queue for owner calibration.
```

### Amend concept: catalog-toc

```markdown
---
concept: catalog-toc
aliases:
  - catalog
  - TOC
---

# Catalog table of contents

## What it is

A catalog table of contents is the generated one-file index beside each durable catalog: an alphabetical list of slugs with one-line self-contained summaries drawn from each artifact's leading line, plus alias parentheticals. It is generated, never hand-edited, and declares so in its own header.

## Purpose

The TOCs are the one-shot-readable form of the corpus: skills and agents learn what artifacts exist without reading every full file, then follow a slug to the full body or grep for its annotation. The concept TOC has extra standing — it is injected into every session so agents read a term's definition before using it.

## Boundaries

A TOC owns discovery of what exists; the artifacts own their definitions (see also: design-corpus). Where an artifact is load-bearing is the annotation's job (see also: annotation). TOC consistency — every bullet matching a live artifact and vice versa, one-liners obeying self-containment — is checked by the corpus audit (see also: corpus-audit under stories). Session delivery belongs to the materialized session hook (see also: session-awareness under stories).

## Invariants

- Generated content only: hand edits are overwritten.
- Applying a corpus delta that touches a catalog regenerates that catalog's TOC as part of the same act; the audit is the consistency backstop, never the generator.
- Summaries obey self-containment: no paths, no external-document references.
- Entries are alphabetical, slug plus a bounded one-sentence summary.
```

### Amend concept: integration-contract

```markdown
---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set of conventions by which every plugin integrates into a consumer project. It defines the three layers of a plugin's presence — the committed project-side estate whose existence is the discovery marker, the always-in-context rules cheatsheet, and the skills as uniform verbs — plus the ownership rule, the verb set, version stamps, support-script materialization, hook shims, and stack tailoring.

## Purpose

The contract is what makes the suite composable by a deliberately ignorant dispatcher: the front door — the term names the dispatcher plugin, and this Purpose is its canonical definition — knows the contract's two conventions, discovery markers and the uniform lifecycle verb, and nothing about any plugin's internals. A plugin needing special-casing has integrated wrong, not the dispatcher; new plugins must conform.

## Boundaries

The contract governs how plugins meet consumer projects; it does not govern any plugin's interior behavior. Its layers are realized by neighboring concepts: estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile. "Front door" has no concept of its own — this artifact defines it. The front door's own conduct is the contract's consumer-side realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every integrable plugin exposes the lifecycle verb; plugins with rules to check also expose a read-only compliance verb; plugins whose estate carries provable artifacts also expose a proof-running verb.
- Whether a project uses a plugin is a filesystem check, never an inference.
- The contract, not the dispatcher, is where per-plugin knowledge is documented.
```

### Amend story: safe-workspace-teardown

```markdown
---
story: safe-workspace-teardown
---

# Close a workspace without ever losing work

## Story

As a project owner, I want workspace teardown gated on a clean tree and a merged branch — with my explicit word as the only override — so that closing a finished job can never destroy uncommitted or unmerged work.

## Acceptance

The owner (or an orchestrator finishing a job) closes a named workspace → the clean-tree gate and the merged-branch gate are checked first — the integration branch resolved from the remote's own report of its default branch, never assumed from a local guess, unless the owner names another — and a failing gate stops the close with exactly what is dirty or unmerged, the fix being the owner's act in that workspace; on passing gates the job's runtime is torn down scoped to its own namespace, the worktree is removed and the branch deleted using only non-forcing commands that themselves fail if the gates lied, and the report names the merge commit the work survives in. Only the user's explicit "close it anyway, discard the work" overrides a gate, and then exactly that and nothing broader.

## Falsifier

A close discards uncommitted or unmerged work; a gate is bypassed on the agent's own judgment; the merged-branch gate is checked against an assumed rather than remote-resolved integration branch; teardown reaches beyond the workspace's own runtime namespace; or a forced removal succeeds where a gate had failed.

## Proof

Demo — a close attempt on a workspace with uncommitted changes stopping at the first gate with the dirty paths named, followed by a clean, merged workspace closing completely, with a third party able to locate the surviving merge commit.
```

### Amend concept: falsifier

```markdown
---
concept: falsifier
---

# Falsifier

## What it is

A falsifier is the declared, concretely producible mutation that must turn a proof red: the value-delivering component stubbed, the enforced boundary crossed, the choice silently violated. For stories it is stated as the user-observable absence proving the story undelivered; for decisions it is the silent-violation clause of the proof field.

## Purpose

The falsifier is how non-vacuity is demonstrated rather than judged: a proof earns its name only if it can fail, and "can fail" is established by exhibiting the failure — applying the falsifier, watching red, reverting, watching green. Reading a proof and forming an opinion is the foolable step the falsifier exists to eliminate.

## Boundaries

The falsifier belongs to a proof's intent, declared in the owning story or decision (see also: proof, story-artifact, decision-artifact). The two artifact kinds state it differently by design: a story's falsifier is a first-class user-visible failure with its own section, while a decision's is inseparable from its proof — the silent-violation clause itself — so decisions carry no separate falsifier field. Exhibition — actually applying the mutation transiently — belongs to the proof run; a falsifier that cannot be produced at all marks the proof vacuous, which is the seam where a corpus claim has outrun the code (see also: corpus-proof under stories). Restoration after exhibition is fix-forward and never destroys other uncommitted work.

## Invariants

- A proof is non-vacuous only when applying its falsifier actually reddens it and reverting restores green.
- Every live decision's proof field states its silent-violation clause explicitly; nothing derives a decision's falsifier by inference.
- Quantified claims are falsified by introducing a non-conforming population member and confirming rejection.
- Only a mutation that cannot be safely staged and undone excuses exhibition, and then the exact unrunnable mutation is named — never a read-only opinion reported as passing.
```

### Amend decision: filesystem-discovery-markers

```markdown
---
decision: filesystem-discovery-markers
---

# Integration is discovered by filesystem markers, never inference

## Choice

"Which suite plugins does this project use" is answered solely by checking for each plugin's committed dot-directory estate at the project root (resolved as the nearest git ancestor), plus documented pre-migration marker locations so un-migrated projects are still discovered and offered migration. Hooks use the same rule to decide whether to no-op; absence is a meaningful state — bootstrap candidate or recorded decline — not an error.

## Rationale

A filesystem check is deterministic, per-project, and requires zero per-plugin knowledge in the dispatcher — exactly what lets the front door stay deliberately dumb. Inference from project content would misfire in both directions and make integration state a matter of opinion; honoring documented legacy markers keeps migration offerable without guessing.

## Alternatives

- Infer usage from project content or conversation — nondeterministic, and puts per-plugin heuristics into the dispatcher the contract forbids to carry them.
- A central registry of integrated plugins — a second source of truth that drifts from the estates themselves.

## Proof

Declared text-presence check: the discovery rules — estate markers plus documented pre-migration locations, filesystem check never inference — stand verbatim in the dispatcher's governing text and the contract's conformance prose. Falsifier: either statement deleted or reworded away turns the presence check red. Declared as presence, not behavior: discovery conduct at runtime is prompt-realized and unprovable.
```

### Amend decision: prove-audit-audience-split

```markdown
---
decision: prove-audit-audience-split
---

# Prove reports to the agent; audit files to the human

## Choice

The two corpus-checking verbs have disjoint audiences and channels: the proof run produces work items for an agent — a structured in-context report the executing agent triages, never writing the issue intake — while the audit produces work items for a human, filing judgment findings to the intake and handing mechanical ones back to the caller. A proof finding that turns out to need owner judgment reaches the owner via the next audit catching the underlying corpus problem.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an executing agent needs findings now, in context, at machine tempo; an owner needs a durable, deduplicated agenda at calibration tempo. Giving each verb one channel also makes the intake's meaning crisp — every issue is an owner question, never agent chatter.

## Alternatives

- One verb doing both — every execution-time finding becomes intake noise, and owner questions get buried in agent triage.
- Both verbs writing the intake — the intake stops meaning "requires owner calibration" by construction.

## Proof

Declared text-presence check: the channel lines — the proof run's never-writes-the-intake statement and the audit's filing-as-its-only-write statement — stand verbatim in the two verbs' governing text. Falsifier: either line deleted or reworded turns the presence check red. Declared as presence, not behavior: channel conduct at runtime is prompt-realized and unprovable.
```

### Amend decision: relevance-scoped-queue-gate

```markdown
---
decision: relevance-scoped-queue-gate
---

# The intake gates planning by relevance, not at the door

## Choice

A feature-work planning session drafts the sprint first; a dedicated relevance reviewer then splits the open issues into bearing and independent, and only the bearing ones are walked with the owner — one at a time, with the corpus artifacts relevant to each surfaced first. The open count is information, not a gate, and the reviewer's tiebreak is fixed: when it cannot tell, it answers that the issue bears. Intake-drain sessions invert this: there the intake is the agenda.

## Rationale

The justification is narrow and structural: building over a bearing issue decides it silently, while an independent issue costs the sprint nothing by staying open. A needless owner conversation costs a minute; a silently decided design question costs a rewrite — hence the tiebreak toward walking.

## Alternatives

- The intake as an entry gate — every planning session pays for the whole backlog, punishing owners for filing issues.
- Ignore the intake during feature work — bearing issues get decided silently by whatever the sprint builds over them.

## Proof

Declared text-presence check: the gate's steps — draft first, the dedicated relevance pass, the bears-when-in-doubt tiebreak — stand verbatim in the planning ceremony's governing text. Falsifier: the step or the tiebreak deleted or reworded turns the presence check red. Declared as presence, not behavior: ceremony conduct at runtime is prompt-realized and unprovable.
```

### Amend decision: single-source-transclusion

```markdown
---
decision: single-source-transclusion
---

# Canonical rule text lives once and is transcluded into prompts

## Choice

Every canonical definition, template, and rule the planner's skills share lives in one shared definitions file (plus one shared reviewer prompt), and skill prompts pull them in by named double-braced token blocks replaced at dispatch-assembly time by the running model; skills running in the main loop reference the file directly instead of restating it. Definitions are never restated inline in a skill.

## Rationale

The writer, the checker, and the mutator of the same artifact kind each see only their own dispatched prompt; defining the rules once and transcluding keeps the wording from drifting between the agent that writes and the agent that checks. Editorially, one file to change is what keeps canonical wording canonical.

## Alternatives

- Restate rules per skill — guaranteeing drift between authoring and reviewing prompts.
- Build-time template assembly — requires a build step in a plugin family that deliberately ships none.

## Proof

Two parts. Mechanical: every double-braced token used in any skill resolves to a live block heading in the shared definitions files — the resolution check goes red when a heading is renamed or deleted out from under a token, which is its falsifier. Declared: substitution correctness at dispatch time is prompt-realized and unprovable, and is covered only as presence of the transclusion convention's statement in the skills' governing text, not as behavior.
```

### Amend decision: no-execution-engine

```markdown
---
decision: no-execution-engine
---

# No plan artifact, no execution engine

## Choice

The planner ships no execution machinery and defines no plan artifact: a sprint is never rewritten into a plan, staging happens at execution time in the executor's own working state, and every sprint bakes a fixed execution-shape section plus the completion contract so it can be picked up inline, handed to a goal-driving harness mechanism, or dispatched to any orchestrator unchanged.

## Rationale

Executor-agnosticism through the artifact rather than through an engine: the contract is what does not scale away, while sequencing is planning that belongs to whoever does the work, at the moment they do it. This reverses the suite's own earlier flip-gated execution engine, whose verification burden moved into the corpus itself (proofs with exhibited falsifiers) and the terminal gates.

## Alternatives

- A workflow engine with plan documents, gate pre-flight, and escalation taxonomy — the suite's own pre-4.0 architecture, retired.
- A required orchestrator for sprint execution — forecloses the ordinary inline session as a first-class executor.

## Proof

Declared text-presence check: the no-plan-artifact commitment — a sprint is never rewritten into a plan document; staging lives in the executor's working state — stands verbatim in the planning ceremony's governing text and the materialized estate guidance. Falsifier: those lines deleted or reworded turn the presence check red. Declared as presence, not behavior; a structural reintroduction sweep is the named upgrade path if regrowth pressure ever materializes.
```

### Amend decision: hook-shims

```markdown
---
decision: hook-shims
---

# Plugin-root hooks are shims; behavior is materialized project-side

## Choice

Every hook file in a plugin is a shim with one job: resolve the project root, exec the same-named materialized hook inside the plugin's project-side estate, and exit silently when that file is absent. All hook behavior and injected payloads live in the materialized, version-stamped project copies; the shim is the only part that may read the plugin-root path, and it reads nothing but the path it execs. Session-start injection fires on session startup, clear, and compact — never on resume, where the session already holds its earlier injection — uniformly across plugins.

## Rationale

The harness resolves hook commands against the installed, machine-shared plugin copy, which changes on every update or edit — so nothing a hook actually does may live there. The shim split buys per-project hook versions (a project runs the hooks it was converged to), safe plugin development (editing a plugin cannot disturb another project's session), and discovery-by-filesystem (no estate, silent no-op). Excluding resume avoids re-injecting content a resumed session already carries.

## Alternatives

- Run hook behavior directly from the plugin root — every plugin update instantly changes behavior in every project and session.
- Fire session injection on every session source including resume — duplicates the briefing into sessions that already hold it.
- No hooks at all — forfeits session injection and edit-time enforcement.

## Proof

Conformance check: every plugin-root hook file matches the canonical shim shape — root resolution, hand-off to the same-named materialized hook, silent exit when absent, nothing else — and every session-start hook declaration carries the shared startup-clear-compact matcher. Falsifier: a shim that grows behavior beyond the hand-off, or a session-start declaration that drops or widens the matcher, turns the check red.
```

### Amend decision: lockstep-suite-version

```markdown
---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any plugin's changes warrant, with one annotated repo-wide tag per release cut by the repo-local release skill. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins install à la carte but are designed as a set — the front door declares the others as dependencies, they share one integration contract, and a change in one routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key, and equality at release time is the property consumers actually depend on.

## Alternatives

- Independent semver per plugin — four drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.

## Proof

The release procedure's post-bump verification asserts every plugin manifest carries the new version before tagging. Falsifier: hand-edit one manifest to a different version after the bump step — the release's verification fails rather than tagging a mixed set.
```

### Amend concept: plugin

```markdown
---
concept: plugin
---

# Plugin

## What it is

A plugin is the suite's unit of distribution: a self-contained directory carrying a manifest, a tree of skill prompt files, and optionally hooks, support scripts, documentation, and an output style. The suite ships no application runtime — the executable substance is prompt text and small support tools — and each plugin owns exactly one concern: what to build, how code reads, where work happens, or the suite front door.

## Purpose

One concern per plugin lets consumers adopt à la carte while the front door composes them uniformly. The manifest-with-dependencies pattern makes installing the front door pull the whole set, without the plugins needing knowledge of each other.

## Boundaries

A plugin owns everything a consumer receives; repo-root machinery — the marketplace catalog, the normative contract, the release tooling — is maintenance material and part of no plugin. Integrable plugins additionally materialize a project-side estate and conform to the integration contract (see also: integration-contract, estate); the front door deliberately has no estate and is never integrated. The behavior itself lives in skills (see also: skill).

## Invariants

- Every plugin carries the same suite version at every release, converged and stamped by the release procedure (see also: lockstep-suite-version under decisions).
- A plugin that would need the front door to special-case it has integrated wrong.
- Nothing in any plugin may assume a specific consumer project.
```

### Amend concept: proof

```markdown
---
concept: proof
---

# Proof

## What it is

A proof is a codebase artifact — a demo, example, executable exhibition, or enforcing check — that shows a story or decision holding, linked to its artifact by an annotation. The artifact's proof field is the canonical statement of intent; proof files are working examples of that intent. Proofs are not regression tests: they are exhibitions of intent that happen to live as runnable code.

## Purpose

Proofs make the corpus's claims falsifiable. A story or decision without an annotated proof is, for coverage purposes, an unverified claim; with one, drift between what the corpus asserts and what the code does becomes mechanically detectable.

## Boundaries

The protected thing is the intent, not the byte shape: updates that keep a proof satisfying its artifact's proof field are ambient code change; a change that makes it exhibit something different, less, or nothing is an artifact mutation and must ride a sprint's deltas. Removal requires explicit user direction — the agent never proposes it. Non-vacuity belongs to the falsifier (see also: falsifier); linkage belongs to the annotation (see also: annotation); execution belongs to the proof run and coverage to the audit (see also: corpus-proof, corpus-audit under stories). The intake's proof category names questions *about* proofs awaiting the owner's ruling — a classification label, not a third proof sense (see also: issue).

## Invariants

- Every live story and decision has at least one annotated proof; an unannotated proof file proves nothing.
- Multiple proofs per artifact are welcome and adding one is unrestricted.
- Quantified proofs enumerate their population: "every" over a singleton is vacuously true, and coverage checks presence and cardinality.
- When intent shifts, the proof-field rewrite comes first and the proof modification follows — never the reverse.
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

An estate is a plugin's committed project-side presence, rooted in one dot-directory at the consumer repo root named for the plugin: declared configuration (including any stack profile), the plugin's corpus of durable content, materialized support scripts and hooks, and injected-context payloads. Its existence doubles as the discovery marker answering "which suite plugins does this project use."

## Purpose

Rooting everything in one committed directory makes integration state a property of the project rather than of any machine: contributors without the plugin still see the estate, discovery is a filesystem check, and each project runs exactly what it was converged to. Absence is a meaningful state — a bootstrap candidate or a recorded decline — not an error.

## Boundaries

The estate is plugin territory inside the consumer's repo, converged by the lifecycle verb (see also: true-up); the one file a plugin owns outside it is its cheatsheet (see also: cheatsheet). Documented pre-migration marker locations are honored for discovery so un-migrated projects are still found and offered migration (see also: filesystem-discovery-markers under decisions). The front-door plugin deliberately has no estate. Content kinds inside the planner's estate carry distinct context rules — source-of-truth design, operational intake state, and out-of-context records (see also: design-corpus, issue, sprint).

## Invariants

- The project root everything resolves against is the nearest git ancestor of the working directory, falling back to the working directory itself; every implementation of root resolution across the suite conforms to this one rule.
- Whether the estate is tracked in git is the project owner's decision where the plugin has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive; migration moves files, never rewrites their bodies.
- An installed plugin with no estate is offered bootstrap by consent; declining is a valid state, not drift.
```

### Amend concept: issue

```markdown
---
concept: issue
---

# Issue

## What it is

An issue is anything about the design corpus that requires human judgment to resolve — sloppy, unspecified, unclear, overloaded, conflicting, or vestigial design, a proof whose intent has drifted, or a question deferred during planning. Issues live as one markdown file each in the intake directory, named so a listing sorts chronologically; a file's status moves forward only — open, then verified once a from-the-top discussion is prepared, then a terminal state — and a non-empty ruling section is the owner's decision, however it got there.

## Purpose

The issue separates judgment from mechanics: anything mechanically fixable is fixed in-cycle by whoever found it and never filed, so an issue file means "requires owner calibration" by construction. The intake turns scattered design muddiness into a single owner-facing agenda that verification makes ruling-ready and planning drains deliberately.

## Boundaries

An issue is a question waiting to reach a sprint — the intake is a holding area, not a work tracker; nothing is worked or tracked to completion in it. Many writers may open an issue; the verifier prepares each file for ruling and may close only what the corpus already answers or the authoring rules fully determine, every such closure reported for the owner's veto. All other closure is an owner act recorded through the planning ceremony — promoted into a sprint or retired with a reason — and closed files move to the archive. After promotion the sprint alone carries the resolution (see also: sprint, plan-a-sprint under stories). The nature of an issue is its category; the identity of its writer is its kind — two orthogonal labelings. Mechanical findings are the neighbor that never becomes an issue (see also: finding).

## Invariants

- Only judgment items become issues.
- Slugs are stable fingerprints of artifact plus nature — writers check the intake first and file only genuinely new questions, so re-observation files nothing.
- Many writers may open; only the planning ceremony and the verifier's corpus-cited closures terminate, and the verifier's closures are always reported for veto.
- A non-empty ruling is the ruled signal: the next planning session carries it into the sprint it plans without re-discussion.
- Settled means settled: a later sprint never re-opens a promoted issue; a wrong resolution becomes a new issue with its own file.
- Resolution candidates are durable corpus mutations, never file or symbol citations.
```

### Retire decision: append-only-issue-queue

Delete `.ok-planner/design/decisions/append-only-issue-queue.md`. The mechanism it records — a single append-only JSONL event log folded by stable id — was retired in suite v9.0.0 in favor of the file-per-issue intake the amended `concept:issue` above describes. The choice it recorded has been unmade; the archived log format is documented where the migration lives (the verifier's conversion step), not as a live decision.

## Corpus deltas (continued)

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

A materialized artifact is a project-side copy of a plugin-canonical file — a support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the lifecycle verb, version-stamped with the plugin version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the installed plugin changes nothing anywhere until each owner converges deliberately, and editing a plugin cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are plugin-owned whole files, never hand-edited; the only thing that legitimately runs from the plugin copy is the lifecycle verb's own entry point, plus bootstrap verbs that by definition run before anything is vendored (see also: true-up, per-project-pinning under decisions). Plugin-root hook files are deliberately not behavior — they are shims to the materialized hooks (see also: hook-shims under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the plugin that wrote it.
- Diagnosis verifies fidelity against the canonical copy for the installed version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is proven to run at materialization time; one that cannot run is worse than none.
```

### Amend story: isolated-parallel-workspaces

```markdown
---
story: isolated-parallel-workspaces
---

# Open isolated workspaces for parallel jobs

## Story

As a project owner running parallel agent jobs, I want each job opened in its own checkout on its own branch with its own namespaced runtime, so that concurrent jobs cannot collide on files, containers, volumes, or ports — and none of them ever works on my main checkout.

## Acceptance

The owner (or an orchestrator starting a job) opens a named job → a new worktree and branch are created under the committed profile's naming, only version-control-invisible local files carry over, the runtime is namespaced per the profile — a per-job container project name or a reserved port block — and the report names path, branch, and namespace with the reminder that work happens in the worktree; an existing directory or branch stops the open rather than being reused. Reporting of discipline residue is the compliance-report outcome, not this story's (see also: rules-compliance-report).

## Falsifier

Two concurrent jobs share a tree, container namespace, or port; an existing workspace is clobbered or reused; job work lands on the main checkout; or a second workspace cannot start without editing the first.

## Proof

Demo — two jobs opened side by side whose checkouts, branches, and runtime namespaces a third party can verify are disjoint, both stacks startable simultaneously, plus an open of an already-existing job name stopping with a report.
```

## Work items

Flat and unordered; each names the artifacts it makes true. Dependencies are stated where real.

- **Activation-guard remediation** (`decision:slash-only-activation`, `concept:skill`): add the explicit-activation phrase to the descriptions of ok-plumbline's ten user-facing skills (`slug`, `suggest`, `explain`, `patterns`, `ci`, `audit`, `version`, `starter`, `port`, `budget`), preserving each description's substance.
- **Activation-guard presence check** (`decision:slash-only-activation` proof): a deterministic check asserting every user-facing skill description across the suite carries the guard phrase, with a named plumbing allowlist (the three `true-up` skills, `verify-issues`, and any other skill with a documented machine driver). Depends on the remediation item above being done first (or the check lands red).
- **Token-resolution check** (`decision:single-source-transclusion` proof): a deterministic check that every `{{TOKEN}}` used under `plugins/ok-planner/skills/` resolves to a live `###` heading in the shared definitions files; carries the decision's annotation.
- **Text-presence proof harness** (`decision:filesystem-discovery-markers`, `decision:prove-audit-audience-split`, `decision:relevance-scoped-queue-gate`, `decision:no-execution-engine` proofs, plus the declared half of `decision:single-source-transclusion`): a deterministic check asserting each declared governing line stands in its named home (dispatcher/contract text; prove and audit skill texts; plan-sprint gate text; ceremony no-plan-artifact text; the transclusion convention statement), one annotated assertion per decision so each proof is independently exhibitable (delete a line, its assertion reds).
- **Shim conformance check** (`decision:hook-shims` proof): a deterministic check that each plugin-root hook matches the canonical shim shape and each SessionStart declaration carries the `startup|clear|compact` matcher; carries the decision's annotation.
- **Workspaces session-start matcher** (`decision:hook-shims`): add `"matcher": "startup|clear|compact"` to ok-workspaces' SessionStart declaration in `hooks/hooks.json`.
- **Release-time version equality** (`decision:lockstep-suite-version` proof): the repo-root release skill gains an explicit post-bump assertion that all four manifests carry the new version before tagging; the assertion carries the decision's annotation.
- **Budget baseline migration** (`decision:ratchet-over-soft-start`): the baseline's home becomes `.ok-plumbline/budget.json`; plumbline true-up gains a converge step migrating a root-level `.plumbline-budget.json` (mirroring the config migration, collision stops for the owner); the `budget` and `ci` skills and the porting guide reference the new path, with the ratchet check reading both locations during migration.
- **Check-disable flags retired** (`decision:ratchet-over-soft-start`): remove `checks.comment_hygiene` / `checks.citation_resolution` disabling from the lint binary's config handling (both checks always run); the starter stops emitting the flags; plumbline true-up's diagnose flags a config still carrying the dead key.
- **Prove scope clause** (`concept:completion-contract`): reword `prove/SKILL.md`'s Scope section — the caller may scope; whole-corpus is `/certify-all`'s explicit invocation, and no contract-invocation override exists.
- **Front-door consent wording** (`concept:true-up`, `decision:whole-file-ownership`): align `plugins/ok/skills/ok/SKILL.md`'s one "proposes any migration … for the owner's consent" line (and the ok plugin CLAUDE.md's generic "diagnose → consent → converge" framing) with the consent rule: migration of a plugin's own retired layout is converge territory; consent is for collisions and non-plugin-owned content.
- **Retired-section checks stripped** (`concept:catalog-toc`; realizes the retirement-is-deletion ruling): remove the `_retired/` scope carve-outs and "Retired section" TOC checks from `skills/_shared/design-doc-compliance-reviewer.md` and `audit/SKILL.md`.
- **Status field retired** (corpus-wide): remove `status:` from the concept/story/decision templates in `skills/_shared/artifact-definitions.md` and strip the line from every live artifact under `.ok-planner/design/` not already rewritten by a delta above.
- **Close-gate branch resolution** (`story:safe-workspace-teardown`): `close/SKILL.md` gains the canonical resolution recipe (`git ls-remote --symref origin HEAD`) for the integration branch, mirroring the release skill's.
- **Design-notes deletion**: remove `plugins/ok-planner/design-notes/` (both files); git history and `decision:no-execution-engine` are the record.
- **Planner tooling sentence**: correct `plugins/ok-planner/CLAUDE.md`'s tooling constraint to the actual sanctioned surface (no Node tooling; skills markdown, hooks bash, support scripts bash or python).
- **Profile version field dropped**: remove `version` from the profile ok-workspaces' `detect.js` proposes; nothing reads it, and absence identifies pre-change profiles if a schema version is ever needed.
- **Planner standalone diagnose** (`concept:true-up`): `plugins/ok-planner/scripts/true-up` gains a read-only diagnose mode — report drift and retired layout, exit non-zero, write nothing — with converge remaining the default behavior; parity with the other two plugins' diagnose entry points.
- **Plumbline dogfood migration** (`concept:estate`): move the plugin's own `.plumbline.json` to `.ok-plumbline/config.json`; convert the test fixtures to the current layout except one or two explicitly named as legacy-migration coverage; adjust `test/run.sh`.
- **Decision falsifier-clause audit** (`concept:falsifier`): verify every live decision's Proof field states its silent-violation clause explicitly (the deltas above already do for every decision they touch), then remove the derive-from-intent compatibility shim from `prove/SKILL.md`.
- **Plumbline cheatsheet stamp** (`concept:materialized-artifact`): the materialized `plumbline-cheatsheet.md` gains a version stamp via the plugin's existing `{{OK_PLUMBLINE_VERSION}}` substitution; true-up's sync check compares against the stamped rendering.
- **Root-resolution conformance sweep** (`concept:estate`): check the six root-resolution sites (ok-planner's two hooks and true-up script, ok-workspaces' session-start hook and rev-parse-based scripts, ok-plumbline's post-edit hook) against the stated invariant; align any that diverge.
- **Proof-noun disambiguation** (`concept:proof`): carried entirely by the concept delta; no code change.
- **Intake annotation sweep** (`concept:issue`, retirement of `decision:append-only-issue-queue`): repoint or remove any `@decision:append-only-issue-queue` annotation in code (the true-up script's intake-integrity check is the known carrier); the check itself remains, re-annotated to the amended `concept:issue`'s intake rules where appropriate.

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
   committing the work — performed only on the owner's word.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories and
   decisions: every proof present, passing, and non-vacuous.
3. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
