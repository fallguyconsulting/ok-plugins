# Shared artifact definitions

Canonical definitions of the durable design artifacts ok-planner skills produce and consume: **concept**, **story**, **decision**, **tension**. Also the cross-cutting rules that govern their bodies: self-containment, tension-surface, current-state-only, proof-protection.

This file is the single source of truth. Every skill that authors, reviews, or mutates these artifacts (`discover-design`, `brainstorm`, `refine-design`, `review-work`, `review-design`, `write-plan`) reads from here. When the canonical wording changes, it changes here; consumers re-read on next invocation.

## What "design" means in `.ok-planner/design/`

The directory name is a label, not a load-bearing claim about content. "Design" here is shorthand for the project's **durable identity / model** — the high-level, general framing of what the project is and what it owes its users. The four artifact kinds live at that altitude:

- **Concepts** are general — load-bearing nouns with definitions, purposes, boundaries, and invariants. They name *what kind of thing exists*, not the specific instances that exist now.
- **Stories** are durable user expectations — what the product owes its users on an ongoing basis. Not dev tasks. Not one-time changes.
- **Decisions** are technical tradeoffs — real choices with non-trivial alternatives. They may name the specific artifact picked, because the artifact identity is what carries the tradeoff. But they are not specs (no implementation steps) and not designs (no description of how the chosen thing works internally).
- **Tensions** are open ambiguities about the above three, awaiting resolution.

What's **NOT** in `design/`: specific designs of interfaces, route shapes, CLI grammars, schema details, implementation diagrams, anything that prescribes how a particular piece of the product looks. Those live in code, in `.ok-planner/specs/`, and in other project documentation. If something in `design/` reads like a specification of an interface or an implementation diagram, it's out of place — that's the cycle 2 / `/review-design` audit flagging it.

The directory name is what it is for historical reasons; the bright line is the altitude of its contents, not the literal noun "design."

## How consumers use this file

Two consumption modes:

**Mode 1 — Transclusion into subagent dispatches.** Skills that dispatch subagents (e.g., `discover-design`'s Phase 2 Extractor Prompt, `review-work`'s cycle 2 reviewer prompt) embed `{{TOKEN}}` placeholders in the dispatched prompt. When assembling the dispatch, replace each placeholder with the **body** of the matching `###` block in this file (the prose under the header, not the header line). The convention: `{{...}}` = static block to inline at dispatch-assembly time; `[...]` = per-run value to fill.

**Mode 2 — Direct reference from a skill's own body.** Skills whose authoring or reviewing logic runs in Claude's main loop (e.g., `brainstorm`'s spec-authoring section) read this file directly. The skill body references this file by path and describes how to apply the canonical content in its context; it does NOT restate the definitions inline.

Both modes share the same canonical source. Drift between skills cannot happen.

## Token catalog

The blocks below are the transcludable units. Each `###` heading is a token name; the body under it is what gets inlined.

---

### {{CONCEPT-DEFINITION}}

A **concept** is a load-bearing noun the system traffics in — general and abstract. The bar is: a reviewer reading code that mentions this noun needs a stable definition to know what it means.

Examples (concretely project-dependent):
- "frame", "claim", "node", "template", "instance", "lock", "executor", "scope", "advisory lock", "blob", "userdata"
- Cross-cutting properties that have noun status: "opacity", "verify-before-run guard", "auto-terminal"

A concept names **what kind of thing exists**, not the specific instances that exist now. If a concept body lists current implementations (CLI verbs, library names, file extensions, route paths, wire-format identifiers, license identifiers, etc.), it has descended below concept altitude — those specifics are implementation detail that belongs in code, in specs, or (for choices with tradeoffs) in a decision. The concept body states the general property; the decisions name the instances that satisfy it.

One concept per file. Merge multiple `_discover/` entries when they describe the same noun.

---

### {{CONCEPT-TEMPLATE}}

Write each concept to `.ok-planner/design/concepts/<slug>.md`. Slug is the preferred name; aliases go inside the file.

```markdown
---
concept: <slug>
status: as-is
aliases:
  - <other names this concept goes by in code/prose>
---

# <Concept name>

## What it is

<Definition. One paragraph. Should stand alone — a reader who has never opened the repo should be able to identify what this is.>

## Purpose

<Why this concept exists. What it makes possible that a flatter design without this concept could not. What problem its presence solves.>

## Boundaries

<What is in this concept, what is NOT (and lives in a neighbor concept), and which adjacent concepts it interacts with. Name the neighbors with their slugs (`see also: <slug>`).>

## Invariants

<Load-bearing properties stated as properties of the concept, not as descriptions of code. If the codebase numbers its invariants under any convention, list those IDs here — the ID is stable across file moves, the file path is not.>

## Aliases

<Other names this concept currently goes by in code or prose today. List only names that actually appear in the live codebase or live prose — not retired names, not names someone used to use. If multiple live names point at the same concept, that is itself a tension candidate — produce a corresponding tensions/ entry. Drop this section entirely if there are no live aliases.>
```

---

### {{STORY-DEFINITION}}

A **story** is a **durable user expectation** — what the product owes its users on an ongoing basis. It is not a build record, not a one-time change, not a development task. The test: years from now, would a regression of this capability be a defect a reasonable user would notice and complain about? If yes, story. If the answer is "of course not, that was a one-time thing we built," it isn't.

A story is a user-outcome the running product delivers — a capability a user can observe by driving the assembled product. The bar is: a reasonable user (or a third party watching one) can see this happen, not by reading code but by using the product. Examples (concretely project-dependent):

- "submit a claim and see it persisted"
- "create a widget and see its id"
- "receive the daily digest at 09:00 UTC"

**The delivery surface is not part of the story.** Which surface a user reaches through — CLI verb, HTTP route, wire message, scheduled job, UI — is a technical choice and lives in `decisions/`, not in the story. The story names the capability and what the user observes; the decision names how the product exposes it. Two stories that describe the same user-outcome through different surfaces are one story (the surface is the decision's territory).

**Things that look like stories but aren't.** "Added support for X library," "migrated from A to B," "introduced a new field on resource Y," "renamed the foo endpoint" — these are TDs, refactors, or implementation events, not stories. The underlying user expectation may persist across the change ("users can still authenticate" persists across an auth-library swap), but the *change* is not a story. Capture the persistent expectation as a story; capture the choice as a TD; let the change live in git.

**Why the stories catalog exists.** Capture functional user expectations as durable artifacts; prevent high-level feature loss when individual tests don't catch end-to-end regression; provide a single place a third party can read to know what the product is *for*. Stories outlive specs, refactors, and library changes — they describe the product's enduring obligations to its users.

**Proofs are examples of the story's intent.** A story carries a `Proof:` field naming what the proof must exhibit to a third party — that field IS the canonical statement of the story's intent. The proof artifacts in the codebase (demos, examples, executable proofs) are working examples of that intent: each one a usage pattern showing some facet of why the story exists. A story may have multiple proof artifacts exhibiting different facets, and proof files may be freely updated — refactored, retargeted at a new API, made more robust — as long as they still satisfy the story's `Proof:` field. The protected thing is the intent, not the byte shape. See `{{PROOF-PROTECTION-RULE}}` for the change discipline.

Discover stories from:
- Public surfaces the product exposes: CLI verbs, HTTP routes, wire messages, scheduled jobs, subscribed events. (These tell you a story is there; the surface itself goes into `decisions/`, the user-outcome it serves into `stories/`.)
- End-to-end tests that drive the assembled product and observe outcomes (these often name the story directly).
- README / docs sections describing what the product does for its users.
- Spec history under `.ok-planner/history/specs/` if present — every shipped spec carried stories that now describe what the product does.

---

### {{STORY-TEMPLATE}}

Write each story to `.ok-planner/design/stories/<slug>.md`.

```markdown
---
story: <slug>
status: as-is
---

# <Short story title>

## Story

As <role>, I can <capability>, so that <business value>.

## Acceptance

<What the user does, in their terms> → <what they observe happening>. The component that delivers the value is real (not stubbed) — name it. The surface the user reaches through is a technical decision (captured in `decisions/`), not part of the story.

## Falsifier

<The user-observable absence that would prove this story is NOT delivered: the user takes the action and the promised result never appears; the result appears but is unrelated to their input; the result looks real but the underlying state is synthetic (a stubbed or canned value-delivering component).>

## Proof

<Demo | example | proof | all-of-the-above> — <what the proof must exhibit to a third party so they would conclude the story is delivered>.
```

---

### {{DECISION-DEFINITION}}

A **decision** (TD = "technical decision") is a real architectural or technical choice the project has made — one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is: a reasonable engineer can identify both the choice and a plausible different choice the project could have made, and the rationale is a tradeoff (not a default with no real alternative).

Examples (concretely project-dependent):
- "persistence is Postgres with the `pgx` driver (alternatives: SQLite, a different driver)"
- "claim recovery runs on a 30s tick (alternatives: longer interval, event-driven recovery)"
- "handler registration is explicit (alternative: auto-discovery via reflection)"

**Decisions MAY include technical detail.** The Choice section may name the specific artifact picked — the library, the protocol, the format, the cron string, the threshold value — because the *artifact identity* is often what carries the tradeoff. "Use Postgres" is a real decision; the alternative was "use a different relational store" or "use a non-relational store" or "build our own." Naming Postgres in the Choice section is honest; abstracting it to "use a relational store" hides the tradeoff that was actually made.

**Decisions are NOT specs.** A decision names the *choice* and the *reasoning*. It does not enumerate implementation steps, file structure, schema details, or call sequences. Implementation lives in code; specs (under `.ok-planner/specs/`) describe what to build; decisions describe what was chosen and why.

**Decisions are NOT designs.** A decision does not describe how the chosen thing works in detail — that's the thing itself, or its documentation. A decision records the choice point, not the inner workings of the chosen artifact.

One decision per choice. Don't lump unrelated choices into one file.

Discover decisions from:
- Architecture and configuration choices visible in code: which library, which framework, which protocol, which storage shape, which pattern.
- Comments and commit history that justify a choice.
- ADR-style files (if present) — extract the choice and rationale, drop the historical narrative.
- Choices the `_discover/` Observations sections flag as "choice with an identifiable alternative."

---

### {{DECISION-TEMPLATE}}

Write each decision to `.ok-planner/design/decisions/<slug>.md`.

```markdown
---
decision: <slug>
status: as-is
---

# <Short decision title>

## Choice

<The option the project adopted. One or two sentences, concrete and unambiguous. May name the specific artifact (library, protocol, format, value).>

## Rationale

<Why this choice over the alternatives. The tradeoff that was made. Source from code, comments, ADRs, or the most plausible reading of the code's shape. If the rationale is genuinely unclear, file a tension rather than fabricating one.>

## Alternatives

<The options the project could have taken instead. One bullet each. Brief — these are not full proposals, just enough to show what was on the table. If no plausible alternative existed, this isn't a decision; it's a default.>
```

---

### {{TENSION-DEFINITION}}

A **tension** is anything about the as-is design that is sloppy, unspecified, unclear, overloaded, conflicting, or vestigial. Categories (use these in frontmatter):

- `overloaded` — one name means multiple things.
- `unspecified` — something load-bearing has no name, or its boundary is undefined.
- `unclear` — concept exists, but its definition is fuzzy or different parts of the project disagree.
- `inconsistent` — same property implemented two ways, or same concept spelled two ways, or same constraint with different cutoffs.
- `conflicting` — two parts of the code or two prose sources actively contradict each other.
- `vestigial` — concept named or annotated but no longer load-bearing.
- `muddy-boundary` — adjacent concepts blur into each other.

---

### {{TENSION-TEMPLATE}}

Write each tension to `.ok-planner/design/tensions/<slug>.md`.

```markdown
---
tension: <slug>
category: overloaded | unspecified | unclear | inconsistent | conflicting | vestigial | muddy-boundary
status: open
affects:
  - <concept-slug>
  - <concept-slug>
---

# <Short tension title>

## What is muddy

<Describe the tension. Be specific. Quote code or prose where helpful (with file:line). State exactly which two things disagree, or what is missing, or what is overloaded.>

## Why it matters

<What downstream consequence falls out of this tension.>

## Resolution candidates (do NOT pick)

<List the resolution shapes the tension admits, without picking one. If you don't see a clean shape, say so. refine-design walks this with the user.>

## Evidence

<Specific citations: code paths, prose paths, _discover/ entries.>
```

---

### {{SELF-CONTAINMENT-RULE}}

Concept, story, and decision bodies are self-contained. The design owns the definition; code references it via `@concept:`, `@story:`, and `@decision:` annotations. A refactor that moves files around does not invalidate an artifact, and an external doc that moves to another repo does not orphan one. Citations in artifact body are restricted to forms that survive the codebase moving.

**The rule applies to frontmatter as well as body.** A `references:` frontmatter field that lists `_discover/...` artifacts, spec paths, sketch paths, or any other file-form citation is the same durability problem the rule exists to prevent — those paths rot when the scaffolding is retired, when specs are archived, or when the repo is reorganized. Once an artifact is baked, the lineage that produced it lives in the `_discover/` scaffolding (as history) and in the git history of the artifact file itself; the artifact body and frontmatter carry no lineage. Frontmatter is restricted to slug-form metadata only: `concept:` / `story:` / `decision:` / `tension:`, `status:`, `aliases:` (list of names), and for tensions `category:` and `affects:` (list of slugs). Path-form `references:` does not belong in any artifact's frontmatter; if a `discover-design` or earlier-version run wrote one, strip it.

**Allowed in artifact body** (concepts / stories / decisions):
- Other artifact slugs across catalogs: `see also: claim-handle`, `concept:claim-handle`, `story:claim-co-holder`, `decision:persistence`.
- Invariant IDs the codebase uses, whatever the project's numbering convention is — the ID is stable across file moves; the file path is not. Code-referent annotations the project may carry for its own coding conventions are not cited here: those tags belong to the code layer, and design docs cite only design-owned identities (concept / story / decision slugs and invariant IDs).

**Disallowed in artifact body** (concepts / stories / decisions):
- File or directory paths (`foo/bar.go`, `pkg:foo/bar/baz`, `services/widget/`, etc.) — bare or in any citation form, in-tree or in a sibling repo.
- Citation forms `code:foo.go::Symbol`, `pkg:github.com/...`, bare URLs, "the code at X" pointers.
- References to external documentation (`docs/...`, READMEs, CHANGELOG, sibling-repo paths).
- Quoted code, quoted lint-config allowlists, or quoted external prose. If a property matters, state it as a property of the artifact; the code is responsible for enforcing it.
- "Owns / Does NOT own" sections that name code paths. Concept Boundaries is the in-vs-out section, and it names neighbor concepts by slug.

**Concept-specific tightening — no implementation enumeration.** A concept body must not enumerate the current instances of itself (CLI verbs, library names, file extensions, route paths, wire-format identifiers, license names, command-line flags, environment variable names). The concept names the kind of thing; the specific instances live in decisions (where the tradeoffs that picked them live), in code, or in specs. A concept body that reads as a list of "things that currently exist" rather than "what this thing is, in general" has descended below concept altitude.

**Decision exemption — Choice may name the artifact.** The Choice section of a decision MAY name the specific artifact picked (the library, protocol, format, value), because the artifact identity is what carries the tradeoff. This is not a violation of self-containment; it is the decision doing its job. The artifact name in a decision is permanent (the decision records what was chosen); the artifact name in a concept would be implementation detail (the concept describes what kind of thing the artifact is an instance of). Same word, different altitude.

If an artifact feels like it can't say what it needs to without naming a file, that's either (a) a hint that the artifact's boundary is muddier than the current text claims — file a tension — or (b) material that belongs in the `_discover/` scaffolding (Code surface section), not in the artifact body.

---

### {{TENSION-SURFACE-RULE}}

The `## Evidence` section is a snapshot — it documents the specific code or prose that motivated the tension, and may rot when the cited surface moves. That's expected; tensions are point-in-time observations of muddiness. Code-citation evidence is fine in `## What is muddy` and `## Evidence`.

The `## Resolution candidates` section is different: resolutions become spec instructions, and the spec lives forward in time. State resolution shapes as durable concept mutations (which concept's Definition / Boundaries / Invariants change, and how) and as durable code-discipline changes (what property the code will hold). Resolution shapes must NOT cite specific files, paths, or symbols — those will rot before the tension gets resolved.

---

### {{CURRENT-STATE-ONLY-RULE}}

Concept, story, decision, and tension bodies describe the project **as it stands today**. They are not journals and they are not roadmaps. Two failure modes to avoid:

- **Historical content** — "changed on YYYY-MM-DD", "previously called X", "used to live in foo/bar.go", "see spec Z that introduced this", "was tightened per spec Q", or any audit-trail line whose subject is *what changed* rather than *what is*. Git already records what changed; duplicating that in the design doc is at best distracting, at worst the artifact ages into a changelog nobody reads. **There is no `## Notes` / `## History` / `## Changelog` section on any concept, story, decision, or tension file.** If you find one (in a hand-written artifact or an older-version output), strip it.
- **Forward-looking content** — "we plan to", "will be replaced by", "TODO: tighten this", "out of scope for now", "deferred to V2", "open question for later". A design doc that names work not yet done invites readers (and execute-plan agents) to defer against it. Open ambiguities go in `tensions/`, where they are tracked as explicitly unresolved; intended future changes go in a spec, not the design doc. Nothing in the durable model is aspirational.

The exception is the discovery scaffolding kept around as judgment-call surface: `_discover/` (phase-1 raw notes) and `review-notes.md` (agent-confessed uncertainty consumed by `/refine-design`). Those are explicitly point-in-time artifacts; the durable model is not.

When a spec changes a concept / story / decision, the spec rewrites the affected section in place to reflect the new state. The git commit carries the lineage. Do not paste a dated entry into the artifact body.

---

### {{PROOF-PROTECTION-RULE}}

Proofs (the demo / example / executable-proof artifacts that exhibit a story working) are protected, but the protection is on **story intent**, not byte shape. The story file's `Proof:` field is the canonical intent statement. Proof artifacts in the codebase carrying `@story:<slug>` annotations are examples that satisfy that intent.

**Proof artifacts must carry `@story:<slug>` annotation.** Every proof file (the demo script, example file, executable proof) carries an `@story:<slug>` annotation in a top-of-file comment, in whatever form the project uses for structured tags. The annotation is the durable link between the story and its exhibition; without it, the proof is anonymous and the coverage audit cannot find it. A proof file without the annotation is, for coverage purposes, not a proof of any story.

**Multiple proofs per story are welcome.** A story may have many `@story:<slug>`-annotated files exhibiting different facets of the same user-outcome. Adding a new proof is unrestricted (it strictly increases coverage). The discipline applies to *modifying* and *removing* existing ones.

**Updates are ambient when intent is preserved.** Updating a proof artifact's call site for a renamed API, refactoring for clarity, swapping an internal library, making assertions more robust, hardening setup — any change that keeps the proof satisfying the story's `Proof:` field — is an ordinary code change. No special gate; the normal code-review cycle catches genuine surprises (e.g., a refactor that quietly stubs the value-delivering component).

**Intent changes are story mutations.** If a change would cause a proof to *no longer satisfy* the story's `Proof:` field — exhibiting something different, less, or nothing — the story itself is changing. That is not "modifying a proof"; it is "mutating the story." It must be carried in the spec's `## Design changes` section as a story Proof-field rewrite (and possibly an Acceptance rewrite if the user-observable outcome is also shifting). The proof modification follows the story mutation; the story mutation does not follow the proof modification.

**Removals require explicit user direction.** Removing a `@story:<slug>` annotation, deleting an annotated file, or otherwise dropping a story's only proof artifact reduces coverage. This requires the user to explicitly direct the removal during brainstorm dialogue (the agent never proposes removal). The removal is recorded in `## Design changes` as either a story removal (no story → no proof needed) or as an explicit Proof artifact decommissioning that names a replacement (story preserved; proof artifact replaced).

**Brainstorm dialogue gate.** Brainstorm surfaces proof-affecting changes during spec authoring when the spec's content implies a story-intent change — the spec mutates a story, removes or replaces a delivery surface that a story's `Proof:` field references, or deprecates a story entirely. The three options surfaced to the user are: **preserve the intent** (proof artifact updated, no Design changes for the story), **shift the intent** (story's Proof field mutates — drafted now under Design changes), or **remove the story** (explicit, recorded under Design changes). The agent never picks; the user does.

**Closing audit catches drift.** At the end of execute-plan, a closing coverage + intent-drift audit runs:

- **Coverage check** (cheap, whole-corpus): for every live story in `design/stories/`, grep the codebase for `@story:<slug>`. A story with zero matches is a coverage gap.
- **Intent-drift check** (judgment-heavy, spec-scoped): for stories the spec touched or proof files the diff modified, a subagent reads each proof against the story's `Proof:` field and gives a verdict (satisfies / does not satisfy / uncertain).

Findings land in the completion report's `## Coverage divergences` section — the fourth section alongside proofs walked, decisions kept, decisions diverged. The user adjudicates each: accept as informational, course-correct now, or bounce back to the implementer.

**On-demand audit.** The same coverage and intent-drift checks are available outside execute-plan via `/review-design` (whole-corpus) and `/verify` (am-I-done check). The closing audit is the safety net; the standalone skills are for explicit checking.

**Why these bright lines, not stricter ones.** Proofs are not tests in the regression-protection sense. They are exhibitions of story intent that happen to live as runnable code. Treating them as immutable would mean either an unmaintainable codebase or constant friction over routine refactors. The discipline keys on the story's `Proof:` field, not the proof file's literal shape. Most changes pass through ambient; only intent shifts and removals trip the gate.

---

### {{ANNOTATION-INTEGRITY-RULE}}

Code-side annotations `@concept:<slug>`, `@story:<slug>`, and `@decision:<slug>` link code to the design model. Each annotation's slug MUST resolve to a live artifact at the corresponding path: `@concept:<slug>` to `design/concepts/<slug>.md`, `@story:<slug>` to `design/stories/<slug>.md`, `@decision:<slug>` to `design/decisions/<slug>.md`. The discipline is symmetric across the three kinds.

An annotation fails integrity in one of two ways:

- **Dangling** — the slug does not exist at any kind. The annotation points at a design artifact that was never written, was renamed, or was retired without sweeping the code. Fix: rename the annotation to the canonical slug if the artifact exists under a different name, or drop the annotation if the artifact no longer exists.
- **Kind-mismatch** — the slug exists, but at a *different* kind than the annotation claims (e.g. `@concept:foo` but `concepts/foo.md` does not exist while `stories/foo.md` does). The author reached for the wrong tag prefix. Fix: rename the annotation to match the artifact's actual kind. Story / decision / concept name distinct kinds of design content; the annotation must carry the kind that matches the artifact.

The slug stamped into the code is the *exact* basename of the design artifact's filename. Paraphrasing — using a short-form code annotation against a long-form artifact slug — is dangling, even when the short form reads naturally. The artifact's filename is the canonical slug; the annotation cites it byte-for-byte.

**Where this is checked:**

- At validator time, per pass — newly-added annotations in the diff must resolve to live artifacts of the correct kind. A dangling or kind-mismatched annotation is a pass-blocking finding (the implementer paraphrased or wrong-kinded the citation; fix on next dispatch).
- At closing audit time, whole-corpus — `rg -n '@(concept|story|decision):\s*\S+'` across the codebase; every match's slug-and-kind pair must resolve. Findings land in the completion report's `## Coverage divergences` section under the **Dangling annotation** entry kind (with a sub-flavor noting whether it is slug-dangling or kind-mismatched).
- On demand via `/review-design` and `/verify` — same integrity rule, no pass scope.

**Why this rule, not "any annotation is fine."** The annotation is the durable link between code and the design model. A paraphrased slug or wrong-kind tag looks like a link but resolves to nothing — a future reader (or agent) chasing the citation finds no artifact, with no signal whether the artifact was missed, retired, or simply named differently. The rule keeps the link real: an annotation either resolves to an artifact of the named kind, or it should not exist at all.

---

## Anti-padding (general)

- Don't manufacture tensions. If a topic is clear in `_discover/`, the concept / story / decision file alone is enough.
- Don't merge tensions that share a category but are semantically separate. One tension per genuine muddiness.
- Don't grade severity.
- Don't write more than one file for the same artifact (same concept, same story, same decision). Merge if you find duplicates.
- Don't introduce code-path citations into concept, story, or decision bodies. The design owns the definition; code references it via `@concept:` / `@story:` / `@decision:` annotations.
- Don't invent stories the product does not yet deliver, or decisions the project has not yet made. Those go into specs (or remain unwritten until a spec proposes them).
