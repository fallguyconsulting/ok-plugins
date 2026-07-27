# Sprint: Vendored suite, context unhobbling, conduct split

## Intent

A feature-work sprint realizing two taken-up sketches and one owner directive, with the whole ruled intake riding along. The suite's project-scoped behavior — skills, hooks, scripts, context — becomes committed project files vendored from the installed plugins by the lifecycle verb, with hooks wired through consented entries in the project's harness settings; the plugin system keeps only the user-scoped plugins: the front door and a new `ok-conduct` plugin carrying the output style, never vendored and never a dependency of `ok`. Session-start injection shrinks to the banner plus the concepts TOC, the hub becomes a router with rows single-sourced from skill descriptions, and skill-body fencing is pruned to what traces to a failure. Owner decisions taken in-session: settings wiring by consented transcription (whole-file-ownership stands unamended in its Choice); the lifecycle verb merges project-locally while other verb collisions materialize plugin-prefixed; vendoring fetches from the installed plugin copy, ref recorded in the stamp; `concept:plugin` retires — "plugin" means a Claude Code plugin, the harness's primitive, not this project's to define — with its surviving commitments folded into the integration contract; and the authoring rules' enumeration prohibition is clarified to target code-level instances.

Issues promoted into this sprint (7): `proof-edit-hook-wiring`, `proof-whole-file-ownership`, `plumbline-discovery-marker-undocumented`, `index-skill-drift-unchecked`, `port-allocation-no-single-home`, `vendored-fallback-soft-edge`, `project-record-concept-unpromoted`.

Both sketches (2026-07-25 context unhobbling, 2026-07-26 vendored suite) are taken up by this sprint and archive to the sketch history with it.

## Corpus deltas

### New decision: vendored-skills

```markdown
---
decision: vendored-skills
---

# Project-scoped behavior is vendored into the project

## Choice

Everything project-scoped the suite delivers — skill files, hook implementations, support scripts, context payloads, cheatsheets — reaches a consumer project as committed, version-stamped files materialized from the installed plugin copies by the lifecycle verb, and the harness is pointed at them project-side: skills live in the project's committed skills directory under the contract's collision rule, and hooks are declared in the project's committed harness settings by consented transcription, every session-start entry carrying the startup-clear-compact matcher and never firing on resume. The plugin system delivers only the user-scoped plugins — the front door and the conduct. A converged project is self-contained: cloning it yields the working suite with no plugin installed.

## Rationale

The harness scopes plugin enablement per project but plugin content per machine: one installed copy serves every project, updating or editing it changes all of them at once, and no project has a version of its own. Committing the behavioral surface to the project makes the version a property of the repo — updates arrive as reviewable diffs, contributors get everything by cloning, and the machine-shared layer shrinks to the two things that are genuinely personal.

## Alternatives

- Plugin-root hooks as shims to materialized copies, with skills machine-global — hooks would be pinned, but the skills and their governing text would still move under every project at once.
- A suite checkout committed per project and registered as a local marketplace — pins source, but the harness registry and installed state stay machine-global, so projects still contend for one registration.
- Staying fully on the plugin system — forfeits per-project versions entirely.

## Proof

The lifecycle verb's diagnose phase fails when any vendored layer diverges from the installed copies' rendering for the stamped version — skill files, hooks, scripts, cheatsheets — or when a consented hook entry is absent or its session-start matcher dropped. Falsifier: hand-edit a vendored skill, delete a hook entry, or widen the matcher — diagnosis goes red.
```

### Retire decision: hook-shims

Delete `.ok-planner/design/decisions/hook-shims.md`. The shim layer existed because hooks executed from the machine-shared plugin root; with hook wiring transcribed into the project's harness settings and pointing directly at the estate's materialized hooks, no plugin-root hook remains to shim. The matcher discipline it carried lives on in `decision:vendored-skills`.

### Retire concept: plugin

Delete `.ok-planner/design/concepts/plugin.md`. "Plugin" in this suite means a Claude Code plugin — the harness's primitive, not this project's to define; no formal cross-reference targets the concept. Its load-bearing content survives in sharper homes: the never-assume-a-specific-consumer rule and the repo-root-machinery boundary move into `concept:integration-contract` (amended below), the lockstep invariant already lives in `decision:lockstep-suite-version`, and the user-scoped-vs-project-scoped delivery split is committed in `decision:vendored-skills` and `concept:conduct`.

### Amend concept: integration-contract

```markdown
---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set of conventions by which every integrable plugin meets a consumer project. It defines the layers of a plugin's presence — the committed project-side estate whose existence is the discovery marker, the always-in-context rules cheatsheet, the vendored skill set in the project's committed skills directory, hook wiring transcribed into the project's committed harness settings, and materialized support scripts — plus the ownership rule, the verb set and its collision rule, version stamps, and stack tailoring.

## Purpose

The contract is what makes the suite composable by a deliberately ignorant dispatcher: the front door — the term names the dispatcher plugin, and this Purpose is its canonical definition — knows the contract's two conventions, discovery markers and the uniform lifecycle verb, and nothing about any plugin's internals. A plugin needing special-casing has integrated wrong, not the dispatcher; new plugins must conform.

## Boundaries

The contract governs how integrable plugins meet consumer projects; it does not govern any plugin's interior behavior, and the user-scoped plugins — the front door and the conduct — never integrate, so it does not govern their presence on a machine. Repo-root machinery — the marketplace catalog, the contract's own document, the release tooling, the maintenance checks — is maintenance material and part of no plugin. Its layers are realized by neighboring concepts: estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile. "Front door" has no concept of its own — this artifact defines it. The front door's own conduct is the contract's consumer-side realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every integrable plugin exposes the lifecycle verb — project-locally as one merged verb converging the whole integrated set; plugins with rules to check also expose a read-only compliance verb; plugins whose estate carries provable artifacts also expose a proof-running verb.
- Vendored verb names collide by rule, never by accident: the lifecycle verb materializes once, merged; any other verb name claimed by more than one integrated plugin materializes plugin-prefixed.
- Whether a project uses a plugin is a filesystem check, never an inference.
- Every discovery marker the dispatcher honors is documented in the contract; the contract, not the dispatcher, is where per-plugin knowledge lives.
- Nothing in any plugin may assume a specific consumer project.
```

### Amend concept: skill

```markdown
---
concept: skill
---

# Skill

## What it is

A skill is one named prompt file whose markdown body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs: authored inside plugins, and — for the integrable plugins — vendored by the lifecycle verb into the consumer project's committed skills directory, where consumers drive them by slash command and machinery drives the plumbing class through the skill-invocation tool.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing where it traces to a real failure or boundary confusion — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills declare themselves activated only by their explicit slash command, never auto-triggered by conversation content — some widening the activator to a named non-human caller such as whoever executes a completion contract (see also: completion-contract) — and plumbing skills drop that restriction so other machinery can drive them; a skill belongs to the plumbing class only while another suite surface is documented to drive it (see also: slash-only-activation under decisions). The project's skills directory is a flat namespace, so vendored names follow the contract's collision rule (see also: integration-contract). Skills do not chain into pipelines; each is terminal at its own artifact. A plugin may additionally ship an index skill — a router and briefing, not a verb, its per-skill rows single-sourced from the skills' own descriptions (see also: session-awareness under stories). Canonical shared rule text is transcluded, never restated (see also: single-source-transclusion under decisions).

## Invariants

- The explicit-activation phrasing on user-facing skills is deliberate and preserved on new skills; inferential invocation is forbidden.
- A skill's negative-behavior list binds as strongly as its steps, and every entry traces to an observed failure or a genuine boundary confusion — never a mere negation of the skill's own description.
- A vendored skill is a materialized artifact: version-stamped, plugin-owned, overwritten on converge, never hand-edited (see also: materialized-artifact).
```

### Amend concept: conduct

```markdown
---
concept: conduct
aliases:
  - ok-conduct
---

# Conduct

## What it is

The conduct is the suite's optional behavioral layer, shipped as its own user-scoped plugin: an output style layered on the harness defaults that governs delivery and working discipline — brevity, no time estimates, prose questions, grounded claims, one-concept-per-turn delivery, tight lists, running unsupervised, completeness as the floor with overshoot the only legal divergence, never destroying uncommitted work, and staying out of the planner's estate unless directed there.

## Purpose

The conduct standardizes how the assistant behaves and delivers for the user who chose it, across every project and session, regardless of which skill is active. Because attention to a session-start style decays, the conduct plugin's own reminder hook re-anchors it every turn, and its most load-bearing rules are deliberately duplicated into sprint boilerplate so executors without the conduct still receive them.

## Boundaries

The conduct is personal, not project infrastructure: chosen and installed by a user for themselves, never vendored into a project, never another plugin's dependency, and never pinned by a project's committed configuration. It is explicitly not the always-in-context rules layer (see also: cheatsheet). It yields to skills that define their own dialogue protocols or autonomous scopes. It carries its own hand-managed version, independent of the suite version, bumped only when its body changes; the stamp is read from the body by the version verbs and the conduct plugin's own announcements (see also: see-governing-versions under stories, lockstep-suite-version under decisions).

## Invariants

- The conduct version is independent of the suite version and untouched by a release; a release only warns when the body changed without a bump.
- The version stamp stays in the body with a fixed prefix, because tooling reads it from there.
- Nothing activates the conduct automatically and no skill depends on it being active.
- Installing the suite never installs the conduct; the choice is the user's alone.
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

The estate is plugin territory inside the consumer's repo, converged by the lifecycle verb (see also: true-up); outside it a plugin owns only its cheatsheet and its vendored skill files (see also: cheatsheet, vendored-skills under decisions). Documented pre-migration marker locations are honored for discovery so un-migrated projects are still found and offered migration (see also: filesystem-discovery-markers under decisions). The front-door plugin deliberately has no estate. Content kinds inside an estate carry distinct context rules — source-of-truth corpus content, operational intake state, and project records (see also: design-corpus, issue). The record discipline is this concept's to state once: records — sprints, sketches, and the archive — are committed and versioned but out of agent context by default, with exactly one live exception (the sprint currently being executed), and every completed or retired record moves to its same-named folder in the archive (see also: sprint, sketch).

## Invariants

- The project root everything resolves against is the nearest git ancestor of the working directory, falling back to the working directory itself; every implementation of root resolution across the suite conforms to this one rule.
- Whether the estate is tracked in git is the project owner's decision where the plugin has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive; migration moves files, never rewrites their bodies.
- An installed plugin with no estate is offered bootstrap by consent; declining is a valid state, not drift.
```

### Amend concept: sketch

```markdown
---
concept: sketch
---

# Sketch

## What it is

A sketch is a pre-commitment design artifact: an idea captured in one pass, in enough detail to think about it, share it, or come back to it, without entering the planning ceremony. A sketch can be wrong, incomplete, or speculative; it externalizes thinking and explicitly does not authorize implementation.

## Purpose

Sketches give ideas a cheap, durable landing place so they are neither lost nor prematurely promoted into committed work. The hard boundary against the sprint keeps speculation from silently acquiring authority.

## Boundaries

A sketch owns an idea's shape, open questions, and risks. It does NOT authorize building — the path to building runs through the planning ceremony into a sprint (see also: sprint) — and it writes nothing to the design corpus or the intake queue (see also: design-corpus, issue). Sketches are project records under the estate's record discipline (see also: estate).

## Invariants

- One pass, one document: no review loop, no dialogue; assumptions are noted as open questions rather than asked.
- A sketch is never silently upgraded into planning mid-flight.
- Sketches are a live artifact kind: estate maintenance never flags them for migration.
- When taken up for real or abandoned, a sketch moves to the archive per file, not wholesale.
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

A sprint owns approved intent: deltas, work items, and the two verbatim boilerplate sections (execution shape and completion contract). It does NOT own execution order — items are never grouped into stages, phases, or themes — and it is NOT the intake queue: questions live as issues until promoted, and after promotion the sprint alone is the source of truth (see also: issue, corpus-delta, completion-contract, plan-a-sprint under stories). Sprints are project records under the estate's record discipline, and the sprint being executed is that discipline's single live exception — the one record allowed in context (see also: estate, design-corpus).

## Invariants

- Self-sufficiency: an executing agent never reads the queue or history to learn what a promoted issue "really meant"; a genuine gap is raised with the owner, never filled by inference.
- Work items name the stories and decisions they make true, and describe outcomes, not methods.
- A sprint archives only once it certifies clean; an uncertified sprint stays in flight.
- A sprint is never rewritten into a plan document.
```

### Amend concept: true-up

```markdown
---
concept: true-up
---

# True-up

## What it is

True-up is the suite's uniform lifecycle verb: the idempotent converge of a project's integrated-plugin presence — estate, cheatsheet, vendored skills, and hook wiring — toward what the installed plugins declare. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not plugin-owned needs migrating, resolving, or transcribing), and converge (deterministic materialization of the plugin-owned layer from committed declarations and the installed copies).

## Purpose

Because every true-up is an idempotent installer — materializing a missing presence the same way it repairs a drifted one — the front door needs no per-plugin install knowledge, and a compliant project is a silent no-op. In a project it is one merged verb: converging the whole integrated set is a single act, which is what the front door drives and what keeps every upgrade, migration, and bootstrap deliberate per project.

## Boundaries

True-up owns the plugin-owned layer — estate, cheatsheet, vendored skills — and the mechanics of retired-layout migration; it never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers, hook wiring in the project's committed harness settings included (see also: estate, stack-profile, whole-file-ownership under decisions). Other skills lean on it as plumbing so the layout exists before they write. It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations and the installed plugins' canonical copies, never re-inferred at use time.
- Migration moves files and never rewrites their bodies; archived records keep their old wording.
- Invoking the verb is itself the authorization to migrate the plugin's own retired layout; consent is reserved for genuine collisions, for content the plugin does not own, and for transcription into owner-declared configuration.
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

A materialized artifact is a project-side copy of a plugin-canonical file — a skill file, support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the lifecycle verb, version-stamped with the plugin version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the installed plugin changes nothing anywhere until each owner converges deliberately, and editing a plugin cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are plugin-owned whole files, never hand-edited. Hooks execute from the project's own materialized copies, reached through wiring transcribed into the project's committed harness settings — never from the installed plugin copy (see also: vendored-skills under decisions). The things that legitimately run from the plugin copy are the lifecycle verb's own entry point, bootstrap verbs that by definition run before anything is vendored, and read-only advisory verbs falling back with an announcement (see also: true-up, per-project-pinning under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the plugin that wrote it.
- Diagnosis verifies fidelity against the canonical copy for the installed version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is proven to run at materialization time; one that cannot run is worse than none.
```

### Amend story: session-awareness

```markdown
---
story: session-awareness
---

# Sessions start knowing the suite and my vocabulary

## Story

As a project owner, I want every session in my project to start already briefed on the governing versions and on my project's concept vocabulary, so that agents use my terms correctly and discover my verbs without me pasting context or repeating rules.

## Acceptance

Any session opens in a converged project → a banner names the governing versions and, where a corpus exists, the concept catalog's table of contents is injected, directing agents to read a term's full definition before using it; the suite's verbs are discovered from the vendored skills' own descriptions, each carrying its activation guard, with no separate skills briefing injected beside them; when the user has the conduct installed, the conduct's own per-turn reminder re-anchors delivery rules. The materialized session hook and context payload are real.

## Falsifier

A fresh session cannot name the governing versions or defines corpus terms by paraphrase instead of reading the catalog; the injection reflects the installed plugin rather than what this project was converged to; sessions in projects without the estate are disturbed at all; or session start injects a briefing that duplicates what the vendored skill set already carries.

## Proof

Demo — a fresh session in a converged project names the governing versions and defines a project concept by reading its catalog file unprompted, while the same questions in an unintegrated project show no injection.
```

### Amend story: one-command-suite-upkeep

```markdown
---
story: one-command-suite-upkeep
---

# Keep the whole suite current with one command

## Story

As a project owner, I want a single front-door command that updates my installed suite plugins, discovers which are integrated here, offers to bootstrap the rest in one consent question, and drives the project's merged lifecycle verb, so that keeping the suite current requires no per-plugin knowledge from me.

## Acceptance

The owner runs the front door → installed suite plugins are updated to the marketplace's current versions; integrated plugins are discovered by filesystem markers alone; installed-but-unintegrated integrable plugins are offered bootstrap in exactly one consent question, with decline recorded as a valid state; the project's merged lifecycle verb runs once over the integrated set (bootstrap runs the installed plugin's own entry point, which materializes the merged verb), with its consent questions relayed verbatim and its report relayed uninterpreted; and a fixed summary table closes the run. The dispatcher writes no file itself; all writes happen inside the lifecycle verb. The personal conduct plugin is never installed, vendored, or offered by the front door.

## Falsifier

A plugin is bootstrapped or installed without consent; the dispatcher special-cases a plugin's internals or reinterprets its findings; an integrated plugin goes undiscovered; a missing plugin is silently installed rather than reported with its remedy; or the front door installs or offers the conduct.

## Proof

Demo — a run on a project with one integrated, one installed-but-unintegrated, and one uninstalled suite plugin, producing the update moves, exactly one bootstrap question, a verbatim relayed lifecycle report, and a table a third party can reconcile against the project's filesystem markers.
```

### Amend decision: per-project-pinning

```markdown
---
decision: per-project-pinning
---

# Projects run what they were converged to

## Choice

Every materialized artifact — vendored skills, scripts, hooks, cheatsheets, the vendored lint binary — is stamped with the writing plugin's version and executes from the project's own copy; everything downstream prefers the project copy over the installed plugin's. Exactly three classes legitimately run from the installed plugin copy: the lifecycle verb's entry point, pre-estate bootstrap verbs, and read-only advisory verbs — and an advisory verb falling back to the installed copy announces the fallback in its output. Updating the installed plugin changes nothing in any project until its owner converges deliberately.

## Rationale

Reproducibility over freshness: an audit must report what this project was trued up to, a ratchet baseline is only comparable against the version that produced it, and CI can lint at the project's pinned version with no plugin installed. The pinning rule guards enforcement reproducibility; read-only advisory verbs are exploration tools, most useful before adoption, so they may read the installed copy — the announced fallback preserves the owner's ability to notice an unpinned answer. The stamp makes version drift mechanically checkable, and the gap between pinned and installed is itself the useful signal.

## Alternatives

- Always execute the installed plugin's copy — every plugin update silently changes every project's behavior and breaks baseline comparability.
- Pin by lockfile reference rather than materialized copies — leaves projects unable to run the machinery without the plugin present.
- Forcing advisory verbs through the pinning gate — makes pre-adoption exploration impossible, serving the letter against the reason.

## Proof

Each plugin's diagnose phase fails on divergence between project copies and the installed plugin's canonicals — stamp comparison and byte-identity checks — and vendoring proves the copied binary executes; deleting a stamp, editing a materialized file, or breaking the vendored binary turns diagnosis red. The advisory-fallback announcement stands as a declared text-presence check over the advisory verbs' governing text; its falsifier is the announcement line deleted — declared as presence, not behavior.
```

### Amend decision: edit-hook-blocks-in-turn

```markdown
---
decision: edit-hook-blocks-in-turn
---

# The edit hook blocks in-turn, scoped to changed lines, and never breaks a session

## Choice

Lint enforcement runs as a post-edit hook that blocks the agent in the same turn on violations — but only within the edited file's changed line ranges for tracked files (untracked files checked whole), and with every hook failure path (missing input, no repository, no vendored binary, spawn error) degrading to a silent pass.

## Rationale

Blocking in-turn is the only moment the fix is free — the agent sees the message with the edit still in hand. Scoping to the change keeps pre-existing debt from blocking unrelated work, which is what makes strict enforcement livable on legacy code; failing open on infrastructure errors means the check can only ever block on genuine findings, never break a session.

## Alternatives

- Advisory-only reporting after the fact — residue accumulates faster than sessions clean it.
- Whole-file blocking — any legacy file becomes uneditable until fully clean, punishing unrelated edits.
- Failing closed on hook errors — session breakage as the price of an infrastructure hiccup.

## Proof

The lint binary's violation exit code is asserted by the fixture suite, and the hook wiring itself is exercised end-to-end by the hook-invocation harness: git-backed cases invoke the materialized hook as the harness would, asserting changed-line scoping — a violation on an untouched line passes, the same violation on a changed line blocks — and that each fail-open branch degrades to a silent pass. Falsifier: mis-scope the range parsing or make a fail-open branch block — the harness case for that behavior goes red.
```

### Amend decision: whole-file-ownership

```markdown
---
decision: whole-file-ownership
---

# Plugins own whole files and never edit human-edited files

## Choice

A plugin owns whole files only — version-stamped, deterministically regenerable, overwritten wholesale — and never edits a file a human also edits; the consumer's own rules file and memory file are categorically untouchable. Ownership decides consent: plugin-owned files converge silently, and the plugin's own retired-layout content is plugin territory, migrated mechanically under the lifecycle verb's own authorization; anything else at a path the plugin cares about — hand-written overlaps, preexisting guidance the plugin would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment a plugin edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the plugin's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the plugin destroys or shadows guidance the project chose deliberately.
- Consent-gating the plugin's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.

## Proof

A static owned-path check asserts each plugin's converge implementation writes only within its declared owned set — its estate, its cheatsheet, its vendored skill files — with the project's harness settings reachable solely through the consent-transcription path. Falsifier: add a stray write outside the declared set, or an unconsented settings write — the check goes red.
```

## Work items

Flat and unordered; each names the artifacts it makes true. Dependencies are stated where real.

- **ok-conduct plugin** (`concept:conduct`): new plugin carrying the output style (moved from ok-planner), the per-turn reminder hook (moved from ok-planner; a direct plugin hook — user-scoped content correctly runs machine-global, no estate, no shim), and a session-start announcement of the conduct version; manifest at the suite version; marketplace entry added; **not** added to ok's dependency list. ok-planner sheds the output style, the reminder hook, and its banner's conduct line; the repo-root release skill's conduct-version warning repoints to the new plugin's path.
- **Vendoring converge** (`decision:vendored-skills`, `concept:true-up`, `concept:skill`, `concept:materialized-artifact`): the lifecycle verb materializes every integrated plugin's user-facing skills into the project's committed skills directory — version-stamped, collision rule applied (one merged `true-up`; `audit` trio plugin-prefixed as `ok-planner-audit` / `ok-plumbline-audit` / `ok-workspaces-audit`), sibling-invocation references rewritten to the materialized names.
- **Merged project-local true-up** (`concept:true-up`, `decision:vendored-skills`): one vendored `true-up` skill that diagnoses and converges the whole integrated set — estates, cheatsheets, vendored skills, settings wiring — replacing per-plugin invocation in projects; each plugin's own true-up remains in its plugin as vendor-source and bootstrap entry point.
- **Settings-wiring transcription** (`decision:vendored-skills`, `decision:whole-file-ownership`): true-up computes the hook entries each integrated plugin needs (planner session-start with the startup-clear-compact matcher; plumbline post-edit on Edit and Write), presents them once for owner consent, writes them only on yes, and diagnose thereafter reports a missing or drifted entry with the exact block to restore.
- **Plugin hook removal** (`decision:vendored-skills`; realizes the hook-shims retirement): delete the plugin-root hook files and hook manifests from ok-planner, ok-plumbline, and ok-workspaces; the workspaces session-start injection is retired outright — its cheatsheet is the awareness surface; estate-side hook implementations remain the sole hook behavior.
- **Session-start slimming** (`story:session-awareness`): the planner's materialized session-start hook injects the version banner and the concepts TOC only; the skills-index payload is retired — true-up stops materializing it and migrates it out of existing estates.
- **Hub router** (`story:session-awareness`, `concept:skill`; realizes the index-skill-drift ruling): the planner hub shrinks to a router — the what-ok-planner-is framing and the intake-vs-sprint distinction stay; the instruction-priority ladder goes; per-skill rows become one-liners single-sourced from each skill's own description, with a deterministic repo check asserting row-description agreement so drift is mechanical to catch.
- **NOT-do pruning pass** (`concept:skill`): walk every suite skill's negative-behavior list; keep entries traceable to an observed failure or genuine boundary confusion, drop entries that merely negate the skill's description; dispatched subagent prompts keep all fencing; main-session prose that lectures on conduct/cheatsheet-governed behavior cuts to a reference.
- **Estate CLAUDE.md pointer** (`concept:estate`): the materialized estate guide's sprint-execution section shrinks to a pointer at the sprint's own baked-in execution boilerplate plus the certify-gate summary; the guide also gains the record discipline exactly as `concept:estate` now states it.
- **Front-door rewrite** (`story:one-command-suite-upkeep`): `/ok` updates installed suite plugins, discovers by contract-documented markers, offers bootstrap in one question, then drives the project's merged true-up once; it never installs, vendors, or offers the conduct; report table gains the vendored suite version per project.
- **Integration-contract document** (`concept:integration-contract`; realizes the discovery-marker ruling): the normative contract document gains the vendored-skills layer, the verb collision rule, the settings-wiring convention, and documents every honored discovery marker — including ok-plumbline's materialized cheatsheet path — so the dispatcher's marker knowledge is contract-backed.
- **Hook-invocation harness** (`decision:edit-hook-blocks-in-turn`): the plumbline test suite gains git-backed cases that invoke the materialized post-edit hook end-to-end — changed-line scoping red and green, untracked-file whole-file check, and each fail-open branch (missing input, no repository, no vendored binary, spawn error) — annotated as the decision's proof.
- **Static owned-path check** (`decision:whole-file-ownership`): a repo maintenance check extracts each plugin's declared owned-path set and asserts its converge implementation writes only within it, with the harness settings file reachable solely through the consent path; annotated as the decision's proof. Depends on the settings-wiring and vendoring items settling the owned sets.
- **Port-block allocation script** (`story:isolated-parallel-workspaces`; realizes the port-allocation ruling): ok-workspaces materializes a small script computing a job's port block from the committed profile plus live worktree state; the open skill invokes it and the generated cheatsheet points at it; the three prose statements of the algorithm collapse to the one computed source.
- **Advisory-fallback notices** (`decision:per-project-pinning`; realizes the vendored-fallback ruling): the four read-only plumbline skills that fall back to the installed binary announce the fallback in output with one fixed line; the pinning decision's presence check covers the line.
- **Checks suite update** (`decision:vendored-skills`, `decision:slash-only-activation`, `decision:single-source-transclusion`): retire the shim-conformance check with its decision; add the vendored-layer conformance check (stamps, skill fidelity, settings entries, matcher) as the new decision's proof; re-anchor the text-presence assertions that named rewritten governing lines; extend the activation-guard allowlist for the merged true-up and the conduct plugin's skills, and cover vendored copies.
- **Dogfood conversion**: this repo converges to the vendored mode — vendored skills, settings wiring, no plugin hooks — with ok-conduct installed separately as its own plugin; the estate and cheatsheet stay as they are.
- **Docs alignment**: README (marketplace table, layout, harness list) and each plugin's development CLAUDE.md reflect the vendored architecture, the conduct split, and the retired shim layer.
- **Enumeration-rule clarification** (`concept:concept-artifact`): the shared authoring rules' concept-altitude tightening is sharpened per the owner's ruling — the prohibition targets code-level instance enumerations (verbs, libraries, file extensions, paths, flags, identifiers); a concept that is by nature a group of suite-level things may name its members. One sentence in the canonical rule text, so reviewers stop flagging the gray area.

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
