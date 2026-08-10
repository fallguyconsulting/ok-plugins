# Shared artifact definitions

Canonical definitions of the durable design artifacts ok-planner skills produce and consume: **concept**, **story**, **decision**, and the **issue** intake. Also the **corpus delta** — the form by which a sprint changes any of them — the implementation-audit corpus under `.ok-planner/audits/`, and the cross-cutting rules that govern artifact bodies: self-containment, current-state-only.

This file is the single source of truth. Every skill that authors, reviews, or mutates these artifacts (`discover-design`, `plan-sprint`, `audit`) reads from here. When the canonical wording changes, it changes here; consumers re-read on next invocation.

## What "design" means in `.ok-planner/design/`

The directory name is a label, not a load-bearing claim about content. "Design" here is shorthand for the project's **durable identity / model** — the high-level, general framing of what the project is and what it owes its users. The three catalog kinds live at that altitude:

- **Concepts** are general — load-bearing nouns with definitions, purposes, boundaries, and invariants. They name *what kind of thing exists*, not the specific instances that exist now.
- **Stories** are durable user expectations — what the product owes its users on an ongoing basis. Not dev tasks. Not one-time changes. Every story is a non-prescriptive statement of user need with a mandatory "so that" clause.
- **Decisions** are technical tradeoffs — real choices with non-trivial alternatives. They may name the specific artifact picked, because the artifact identity is what carries the tradeoff. But they are not specs (no implementation steps) and not designs (no description of how the chosen thing works internally). Every decision is verified by an adversarial implementation audit recorded under `.ok-planner/audits/`.
- **Issues** are open ambiguities about the above three, awaiting human resolution. They are not files in `design/`; they are markdown files in the `.ok-planner/issues/` intake directory (see `{{ISSUE-DEFINITION}}`), each carrying a verifier-written discussion and a `## Ruling` section where the owner writes their decision. They close only through a `/plan-sprint` session — promoted into that sprint or retired — and closed files move to `.ok-planner/history/issues/`. A sprint takes the issues bearing on its work, or the whole intake when working it is the session's purpose.

What's **NOT** in `design/`: specific designs of interfaces, route shapes, CLI grammars, schema details, implementation diagrams, anything that prescribes how a particular piece of the product looks. Those live in code, in `.ok-planner/sprints/`, and in other project documentation. If something in `design/` reads like a specification of an interface or an implementation diagram, it's out of place — that's what the `/audit` compliance pass flags.

The directory name is what it is for historical reasons; the bright line is the altitude of its contents, not the literal noun "design."

## How consumers use this file

Two consumption modes:

**Mode 1 — Transclusion into subagent dispatches.** Skills that dispatch subagents (e.g., `discover-design`'s Phase 2 Extractor Prompt, `audit`'s compliance reviewer) embed `{{TOKEN}}` placeholders in the dispatched prompt. When assembling the dispatch, replace each placeholder with the **body** of the matching `###` block in this file (the prose under the header, not the header line). The convention: `{{...}}` = static block to inline at dispatch-assembly time; `[...]` = per-run value to fill.

**Mode 2 — Direct reference from a skill's own body.** Skills whose authoring or reviewing logic runs in Claude's main loop (e.g., `plan-sprint`'s corpus-delta authoring) read this file directly. The skill body references this file by path and describes how to apply the canonical content in its context; it does NOT restate the definitions inline.

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

<Other names this concept currently goes by in code or prose today. List only names that actually appear in the live codebase or live prose — not retired names, not names someone used to use. If multiple live names point at the same concept, that is itself an issue candidate — file a corresponding issue to the intake. Drop this section entirely if there are no live aliases.>
```

---

### {{STORY-DEFINITION}}

A **story** is a **durable user expectation** — what the product owes its users on an ongoing basis. It is not a build record, not a one-time change, not a development task. The test: years from now, would a regression of this capability be a defect a reasonable user would notice and complain about? If yes, story. If the answer is "of course not, that was a one-time thing we built," it isn't.

**A story is an agile-style non-prescription of user need.** It states who needs what and why — never how the product delivers it. The canonical form is `As <role>, I want <capability>, so that <benefit>`, and **the "so that" clause is mandatory**: a story that cannot say why the user wants the capability has not identified a need, only an activity, and fails compliance. Equally, a story body that prescribes mechanism — naming libraries, data shapes, algorithms, storage, protocols, or any other implementation choice — has crossed into decision or spec territory and fails compliance. The story owns the need; decisions own the how.

A story is a pure expression of business value: a capability a user needs and the benefit it serves. The only acceptance is that the user has a way to do the capability and accomplish the benefit — the story states nothing else, and no acceptance section exists. Examples (concretely project-dependent):

- "submit a claim and see it persisted"
- "create a widget and see its id"
- "receive the daily digest at 09:00 UTC"

**The delivery surface is not part of the story.** Which surface a user reaches through — CLI verb, HTTP route, wire message, scheduled job, UI — is a technical choice and lives in `decisions/`, not in the story. The story names the capability and what the user observes; the decision names how the product exposes it. Two stories that describe the same user-outcome through different surfaces are one story (the surface is the decision's territory).

**Things that look like stories but aren't.** "Added support for X library," "migrated from A to B," "introduced a new field on resource Y," "renamed the foo endpoint" — these are TDs, refactors, or implementation events, not stories. The underlying user expectation may persist across the change ("users can still authenticate" persists across an auth-library swap), but the *change* is not a story. Capture the persistent expectation as a story; capture the choice as a TD; let the change live in git.

**Why the stories catalog exists.** Capture functional user expectations as durable artifacts; prevent high-level feature loss when individual tests don't catch end-to-end regression; provide a single place a third party can read to know what the product is *for*. Stories outlive specs, refactors, and library changes — they describe the product's enduring obligations to its users.

**A story states something concrete, and a concrete expression of business value does not speak to the qualitative.** The capability and the benefit are both things a reader can settle by looking: the user has a way to do the thing, and doing it accomplishes something observable. Adjectives that only a judgment can settle — correct, clear, helpful, intuitive, well-designed, seamless — are not what the product owes anyone; they describe how well it owes it. A story reaching for them has usually not finished identifying the need, and the fix is to say what the user can now do instead: not "so that the report is clear" but "so that they can find which line failed without reading the whole run." Write the observable version, and where a promise genuinely rests on a human discipline's judgment, per `{{DECIDABILITY-BOUNDARY}}` it becomes a referral in the story's audit rather than a clause the story leans on.

**Verification is the audit's, and tests are ordinary tests.** A story carries no `Proof:` field and no proof artifacts. The periodic audit determines a story's support from the user's vantage — passing experiments driven through the ruled public surface, per `{{AUDIT-DEFINITION}}` — never by citing a test, which may reach behind the surface. The project's ordinary test suites still exercise code-implemented stories end-to-end as engineering discipline, and test files touching a story carry the `@story:<slug>` annotation for navigation, like any load-bearing site.

Discover stories from:
- Public surfaces the product exposes: CLI verbs, HTTP routes, wire messages, scheduled jobs, subscribed events. (These tell you a story is there; the surface itself goes into `decisions/`, the user-outcome it serves into `stories/`.)
- End-to-end tests that drive the assembled product and observe outcomes (these often name the story directly).
- README / docs sections describing what the product does for its users.
- Sprint history under `.ok-planner/history/sprints/` if present — every shipped sprint carried stories that now describe what the product does.

---

### {{STORY-TEMPLATE}}

Write each story to `.ok-planner/design/stories/<slug>.md`.

```markdown
---
story: <slug>
---

# <Short story title>

## Story

As <role>, I want <capability>, so that <benefit>. (The "so that" clause is mandatory — a story without it fails compliance.)

```

---

### {{DECISION-DEFINITION}}

A **decision** (TD = "technical decision") is a real architectural or technical choice the project has made — one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is: a reasonable engineer can identify both the choice and a plausible different choice the project could have made, and the rationale is a tradeoff (not a default with no real alternative).

Examples (concretely project-dependent):
- "persistence is Postgres with the `pgx` driver (alternatives: SQLite, a different driver)"
- "claim recovery runs on a 30s tick (alternatives: longer interval, event-driven recovery)"
- "handler registration is explicit (alternative: auto-discovery via reflection)"

**Decisions MAY include technical detail.** The Choice section may name the specific artifact picked — the library, the protocol, the format, the cron string, the threshold value — because the *artifact identity* is often what carries the tradeoff. "Use Postgres" is a real decision; the alternative was "use a different relational store" or "use a non-relational store" or "build our own." Naming Postgres in the Choice section is honest; abstracting it to "use a relational store" hides the tradeoff that was actually made.

**Decisions are NOT specs.** A decision names the *choice* and the *reasoning*. It does not enumerate implementation steps, file structure, schema details, or call sequences. Implementation lives in code; sprints (under `.ok-planner/sprints/`) describe what to build; decisions describe what was chosen and why.

**Decisions are NOT designs.** A decision does not describe how the chosen thing works in detail — that's the thing itself, or its documentation. A decision records the choice point, not the inner workings of the chosen artifact.

**Decisions are audited.** A decision carries no test obligation of its own: its verification is the **implementation audit** — an adversarial reading of the Choice against the code as it stands, recorded as a determination about a named commit (`{{AUDIT-DEFINITION}}`). This is because many real decisions are structural or negative ("permissions are read from the database, never carried in the token"), where the honest check is a reading, not a runtime exercise. Code that enforces a choice still carries the `@decision:<slug>` annotation at the point of enforcement — the annotation is how auditors navigate, and a decision whose Choice no code anywhere enforces is exactly what its audit will report as unsupported. A "decision" with no identifiable alternative is still a default, not a decision — delete it rather than audit it.

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
---

# <Short decision title>

## Choice

<The option the project adopted. One or two sentences, concrete and unambiguous. May name the specific artifact (library, protocol, format, value).>

## Rationale

<Why this choice over the alternatives. The tradeoff that was made. Source from code, comments, ADRs, or the most plausible reading of the code's shape. If the rationale is genuinely unclear, file an issue rather than fabricating one.>

## Alternatives

<The options the project could have taken instead. One bullet each. Brief — these are not full proposals, just enough to show what was on the table. If no plausible alternative existed, this isn't a decision; it's a default.>

```

A decision's verification is its **implementation audit** (`{{AUDIT-DEFINITION}}`): an adversarial reading of the Choice against the code, recorded under `.ok-planner/audits/decisions/<slug>.md` as a determination about a named commit. Code enforcing a decision still carries the `@decision:<slug>` annotation — that is what the auditor navigates by.

---

### {{CORPUS-DELTA-FORM}}

A **corpus delta** is one unit of change to the design corpus, carried inside a sprint under a heading naming the operation and the target: `### New story: <slug>`, `### Amend concept: <slug>`, `### Retire decision: <slug>`. A sprint's deltas are the only sanctioned way the corpus mutates.

**Every delta is a complete final-form artifact body, resolved fully during planning.** A new artifact and an amendment each carry the complete file content per the templates above; a retirement carries nothing beyond its heading, and execution deletes the file. There is no revision form: no diff, no base pin, no machine-checked derivation. An amendment is authored by editing the artifact surgically during the planning dialogue and carrying the resulting whole body — which is what makes application a copy and the completion contract's first item a file comparison.

**Large bodies go in the sidecar.** A sprint whose delta bodies are long may carry them in a sidecar folder beside the sprint file — `.ok-planner/sprints/<sprint-name>-deltas/<kind>s/<slug>.md`, one file per artifact, each the exact final-form body. The delta heading in the sprint then reads `body: in the sidecar` instead of carrying a fenced block. The sidecar is part of the sprint: the sign-off review reads it, execution copies from it, and the close-out archives it with the sprint and its completion report. Inline fenced bodies remain the norm for ordinary-sized deltas.

**What review does.** The sign-off compliance review reads each delta body whole — form, claims, and coherence with the live corpus. Whether an amendment silently drops or drifts something the planning conversation never meant to touch is the reviewer's judgment, exercised against the live artifact it amends; the certification gate's alignment producer then checks the applied corpus against the deltas by file equality. A mechanical derivation check is deliberately absent: it would halt the sprint whose artifact legitimately needs a change discovered during the work, and the suite's mechanisms for that case are the presentation's divergences and issue escalation, not a pin.

---

### {{ISSUE-DEFINITION}}

An **issue** is anything about the design corpus that requires human judgment to resolve: sloppy, unspecified, unclear, overloaded, conflicting, or vestigial design — or a test whose intent has drifted, or a question deferred during planning. Issues live as one markdown file each under `.ok-planner/issues/`, the **intake directory**. Categories:

- `overloaded` — one name means multiple things.
- `unspecified` — something load-bearing has no name, or its boundary is undefined.
- `unclear` — concept exists, but its definition is fuzzy or different parts of the project disagree.
- `inconsistent` — same property implemented two ways, or same concept spelled two ways, or same constraint with different cutoffs.
- `conflicting` — two parts of the code or two prose sources actively contradict each other.
- `vestigial` — concept named or annotated but no longer load-bearing.
- `muddy-boundary` — adjacent concepts blur into each other.
- `test` — a test question needing owner calibration (intent drift, missing end-to-end coverage, deprecation candidate).
- `other` — a judgment item none of the above fits.

**Only judgment items become issues.** Anything mechanically fixable (a dangling annotation, a stripped-section violation, a stale TOC line) is fixed in-cycle by whoever found it, never filed. An issue file means "requires owner calibration" by construction — that is what makes the sprint gate meaningful.

**The intake is not a work tracker.** An issue is a question waiting for the owner's ruling; it is never worked, fixed, or tracked to completion in the intake itself. It closes exactly two ways, both owner acts recorded through `/plan-sprint`:

- **Promoted** — the owner's resolution (a ruling written in the file, or a decision made live in the planning session) is carried into a sprint as a corpus delta, a work item, or both, and the issue file is stamped with that sprint's name. From that moment the **sprint is the source of truth** for the work: the issue is settled and out of consideration, whatever happens downstream. The file moves to `history/issues/` when the sprint's implementation closes. A later sprint does not re-open, re-litigate, or "check on" a promoted issue; if the sprint turns out to have gotten it wrong, that is a *new* issue with its own file.
- **Retired** — the owner drops the question outright (won't fix, no longer real, answered by something that already happened). Nothing is carried anywhere; the file moves to `history/issues/` on the spot. (An issue the design corpus itself already answers is the verifier's variant of this — closed with the citation, no ruling needed.)

An issue file's life is: filed by whoever noticed the ambiguity → verified (a full discussion prepared for the owner) → ruled by the owner, in the file at their leisure or live in a planning session → promoted into a sprint or retired.

---

### {{ISSUE-FILE-FORMAT}}

Each issue is one markdown file in `.ok-planner/issues/`, named `<YYYY-MM-DD-HHMMSS>-<slug>.md` — the UTC filing time then the slug, so a directory listing sorts chronologically. Closed issues live in `.ok-planner/history/issues/` under the same name. Template:

```markdown
---
issue: <stable-slug>
kind: audit | discover | sprint | human
category: <category>
artifacts:
  - concept:<slug>
  - story:<slug>
status: open | verified | answered | promoted | retired
opened: <ISO 8601 UTC>
sprint: <sprint filename — present only once promoted>
---

# <One-line summary of the question>

## Problem

<What disagrees / is missing / drifted — specific, quoting evidence.>

## Candidates

- <resolution shape, stated as a durable corpus mutation; never picked>
```

That is the **open** (as-filed) shape. Verification supersedes it — a **verified** file reads:

```markdown
---
issue: <same-slug>
…
status: verified
---

# <Plain-language title telling the story>

<The narrative: lede, causal mechanism, state of play — written for
an engineer who has never opened the repo. See the ownership and
narrative rules below.>

## Options

- <each real option with its one honest cost>

## Ruling

<A marked generated/recommended ruling, or the owner's own words.>
```

Rules:

- **`issue:` is a stable fingerprint** of artifact + nature of the problem (no line numbers, no dates), so a writer re-observing an open issue files nothing — check the slugs already present in `issues/` first, then file only genuinely new ones. The filename adds the timestamp for chronology; the slug is the identity.
- **Ownership follows the lifecycle.** The *filer* (certification's architect, `discover-design`, `plan-sprint` deferring a question, a human) writes frontmatter (`status: open`), title, `## Problem`, and `## Candidates` — raw material, no Discussion, no Ruling. Verification (`/verify-issues`) **supersedes the raw body**: the verified file is frontmatter + a single from-the-top narrative (title may be replaced by a plainer one) + `## Options` + `## Ruling`; the filer's raw sections live on in git history only. The *owner* — and only the owner — decides; owner text under Ruling is written in their own words, whenever they like, and the verifier writes into Ruling only the marked generated/recommended forms below or a decision the owner just gave live. Once verified, nobody but the owner touches the file.
- **The verified narrative is written from the top, for a stated audience — and checked by rules.** The audience: an experienced engineer who doesn't know much about the project or its implementation and doesn't have a lot of time to read, but needs to evaluate a ruling based on an informed technical opinion. The narrative gives them a lede that tells the whole story, the causal mechanism, the state of play, and the real options with their costs. The checkable rules (canonically in `/verify-issues`): a project term is taught only when evaluating the ruling requires it; a taught term gets a two-or-three-word parenthetical on first use then stands alone (slugs cited only after the plain words they label; no bare code symbol carrying meaning); and every fact gets exactly one home — a sentence deletable without weakening the reader's ability to evaluate the ruling is a violation. It explains and lays out tradeoffs; the picking happens only in the marked Ruling, which is written in an engineer's informal register — what to do and why, with the flip case; never delta phrasing or file paths, which are the planning ceremony's translation to make.
- **A non-empty Ruling is the "ruled" signal.** There is no `ruled` status value — the owner just writes text under `## Ruling` and walks away. The next `/plan-sprint` pulls every ruled issue into the sprint it is planning without re-discussing it, asking about a ruling only when it genuinely cannot be understood.
- **A ruling may be generated.** When the corpus and its authoring rules determine an issue's one compliant resolution, the verifier writes that resolution under `## Ruling`, explicitly marked: a `> Generated ruling (/verify-issues): …` blockquote stating the resolution, followed by an owner comment saying edit-or-delete overrides it. This holds whether realizing it would change what the corpus commits to or merely how a commitment is expressed — **the verifier never applies either**; a filed issue is resolved through a sprint, not by the verifier's own edit, so a generated ruling names the fix concretely enough that `/plan-sprint` drafts it and execution applies it without re-deriving it. A generated ruling is a default, not a decision: the owner may rewrite or empty it any time before planning, and `/plan-sprint` names the generated-ruling issues it pulls in as one batch line at sign-off — never re-discussed individually, never silently absorbed. An issue whose resolution the rules do NOT determine never gets a generated ruling; its Ruling stays empty for the owner. "Do you want the docs to follow the rules?" is not a question — an issue reducible to that gets a generated ruling, never an empty Ruling. The authoring rules are binding as written, like lint: the verifier applies them and never adjudicates them, and a rule whose application to the case seems debatable still applies — the doubt is worth one sentence in the generated ruling's Discussion, never an empty Ruling.
- **A ruling may be recommended.** Where the resolution IS a judgment call, the verifier's inline authoring stage fills the Ruling with the resolution it judges best serves the project's intent, explicitly marked: a `> Recommended ruling (/verify-issues): …` blockquote stating the resolution plus a brief rationale, followed by an owner comment. (Files from earlier layouts may carry the same marker attributed to a retired `/recommend-rulings` verb — read identically.) Acceptance is by silence: left untouched, the recommendation is a ruling — the next `/plan-sprint` carries it, naming the recommended batch in one sign-off line exactly as with generated rulings. The owner may delete the marker note (or rewrite the text in their own words) to adopt it as their own, edit the resolution to redirect, or empty the section to discuss live. A recommendation never overwrites owner text, a generated ruling, or another recommendation.
- **Status moves forward only, and closure is a move to history.** `open` → `verified` (verifier) → `promoted` (planner stamps `status` and `sprint` after sign-off; the file moves to `history/issues/` when the sprint's implementation closes) or `retired` (planner records the owner's reason under Ruling and moves the file to `history/issues/` immediately). One verifier terminal state closes without an owner ruling, moving the file to `history/issues/`: `answered` — the design corpus squarely decides the question (or the filed gap no longer exists), the Discussion citing the deciding artifact and section. That is the verifier's only closure: a rules-determined *fix* is not one, however mechanical — it stays open under a generated ruling for the owner and the next sprint. (Files in `history/issues/` from earlier layouts may carry `repaired`, a terminal status the verifier wrote when it applied such fixes itself; read it as closed, and never write it again.) Never delete an issue file.
- **Writers may file; only the owner closes.** `promote` and `retired` stamps are written only from a `/plan-sprint` session, where the owner decides — resolution is the calibration act, and the lifecycle enforces it. The verifier's `answered` closure is not an exception in substance: the corpus it cites is owner-approved truth, and the list is reported for veto. Nothing else the verifier finds closes — a fix it is certain of becomes a generated ruling, never an edit.
- **`sprint:` names the handoff.** Once stamped, the intake's involvement is over: the sprint is the source of truth for execution, and nothing reads the issue file to find out how the work went.
- **The sprint gate is relevance-scoped.** A `/plan-sprint` planning new work drafts it first, then resolves with the owner every open issue that **bears** on the draft — one whose answer the work would otherwise encode silently — and only those not already answered by a ruling. Issues independent of the work stay open and untouched; a sprint convened to work the intake takes it (or a named batch) as its scope instead.
- Evidence quoted in Problem is a point-in-time snapshot and may rot; that's expected. Candidates must be stated as durable corpus mutations (which artifact's sections change, and how), never as file/symbol citations — a candidate becomes sprint text and lives forward in time.
- **Legacy `issues.jsonl` is read-only history.** Projects that predate the file-per-issue intake carry an append-only `issues.jsonl` event log (`open` / `promote` / `retire`, legacy `resolve` terminal on read). `/verify-issues` converts it: each open id becomes an issue file (status `open`, `opened` from the row's `at`), and the log itself moves to `history/issues.jsonl` as the closed issues' receipt. Never edit the log's rows and never write new ones.

---

### {{MECHANICAL-VS-JUDGMENT-RULE}}

The line between a finding an agent fixes and a finding the owner rules on is **intent, not file surface**.

- **Mechanical** — the compliant end state is fully determined by the corpus's existing commitments, the authoring rules, and the code, and reaching it changes only how a commitment is *expressed*, never what the project commits to. Where the fix lands is irrelevant: a code-side repair (a missing annotation, a missing assertion in a test) and a corpus-side repair (a stale TOC line, a heading brought to canonical shape, a mechanism tail stripped from a story body, a stale sentence in one artifact aligned to the commitment the code and the counterpart artifact already agree on) are equally mechanical. Mechanical findings are fixed in-cycle by whoever holds the finding — never filed, never queued for a ruling — and every corpus-side mechanical fix is surfaced to the owner for after-the-fact veto, named in the certification presentation's Divergences. **In-cycle is the whole window.** Once a finding has been filed as an issue, the mechanical route is spent: `/verify-issues` applies no fix of any kind, and a mechanical one it is certain of becomes a generated ruling naming the fix, resolved through the next sprint like everything else in the intake.
- **Judgment** — resolving it would require a redesign or would materially change intent — what the project commits to, promises users, or forbids: a retirement, a Choice rewritten, an invariant added or dropped, a claim widened or narrowed, restore-vs-deprecate on an artifact the code no longer realizes. Also any finding whose end state is genuinely undecidable from the corpus, rules, and code. Judgment findings are never fixed by an agent; they reach the issue intake for the owner's ruling — and a reviewer's class alone never files one: inside certification, promotion is the architect's act after the fixer's kickback survives its adversarial check; outside it, filing is a human's.

The per-finding test: *would any reasonable fix change what the project commits to?* No → mechanical, fix it. Yes, or can't tell → judgment, file it. "The fix touches `design/`" is never, by itself, a reason to file. A finding that is neither — nothing decidable for anyone, agent or owner, to do — is governed by `{{DECIDABILITY-BOUNDARY}}` below: it dissolves.

---

### {{DECIDABILITY-BOUNDARY}}

Every story — and many a decision rationale — mixes two kinds of content, and the process reads them differently:

- **The mechanical core** — clauses with a deterministic decision procedure: an enumerable population is covered, an output is delivered from a named committed source, a verb answers, a value round-trips, a file exists. These are what tests exercise, audits determine, and findings rest on.
- **The qualitative rim** — clauses whose truth is a human quality judgment: correct (of prose), canonical, clear, helpful, complete (of explanation), useful, intuitive, well-designed. No test can settle them, and an adversarial re-audit against them never converges — there is always one more sense in which quality might fall short.

The boundary rules:

- **Write the concrete version first.** The rim is not what the product owes its users, so an artifact leaning on it has usually stopped short of naming the outcome — restate it as something observable, per `{{STORY-DEFINITION}}`. What survives that rewrite is genuine residue: a promise whose quality a human discipline owns, and the process records it rather than ruling on it.
- **No determination may rest on the rim.** An audit rules a qualitative clause neither supported nor unsupported, and no test obligation extends to it; a finding grounded solely in it is not a finding — it **dissolves**, and never reaches the issue intake, because there is nothing unambiguous for this process to do. Even if the documentation is wrong or the surface is ugly, that is another discipline's work.
- **The bright line is the existence of a decision procedure, not difficulty.** Qualitative means no procedure can settle the claim's truth over its subject. "Hard to test" is not qualitative; an enumerable coverage claim is mechanical however large the population; "inability is never grounds" stands undiminished for everything decidable. Classifying a decidable claim as qualitative to escape work is itself a finding, and the classification is recorded where it can be adversarially checked.
- **Where the rim names something a human discipline owns, the auditor records a referral** (format in `{{AUDIT-FILE-FORMAT}}`): the promise, what was established about it in form, and the owning discipline — documentation, UX, editorial, human review. A referral is a positive statement of what exists, never a licence to skip the work around it, and never an issue: it shows what was delivered and where this process's jurisdiction ends.

---

### {{SELF-CONTAINMENT-RULE}}

Concept, story, and decision bodies are self-contained. The design owns the definition; code references it via `@concept:`, `@story:`, and `@decision:` annotations. A refactor that moves files around does not invalidate an artifact, and an external doc that moves to another repo does not orphan one. Citations in artifact body are restricted to forms that survive the codebase moving.

**The rule applies to frontmatter as well as body.** A `references:` frontmatter field that lists `_discover/...` artifacts, spec paths, sketch paths, or any other file-form citation is the same durability problem the rule exists to prevent — those paths rot when the scaffolding is retired, when specs are archived, or when the repo is reorganized. Once an artifact is baked, the lineage that produced it lives in the `_discover/` scaffolding (as history) and in the git history of the artifact file itself; the artifact body and frontmatter carry no lineage. Frontmatter is restricted to slug-form metadata only: `concept:` / `story:` / `decision:` and `aliases:` (list of names). Path-form `references:` does not belong in any artifact's frontmatter; if a `discover-design` or earlier-version run wrote one, strip it.

**Allowed in artifact body** (concepts / stories / decisions):
- Other artifact slugs across catalogs: `see also: claim-handle`, `concept:claim-handle`, `story:claim-co-holder`, `decision:persistence`.
- Invariant IDs the codebase uses, whatever the project's numbering convention is — the ID is stable across file moves; the file path is not. Code-referent annotations the project may carry for its own coding conventions are not cited here: those tags belong to the code layer, and design docs cite only design-owned identities (concept / story / decision slugs and invariant IDs).

**Disallowed in artifact body** (concepts / stories / decisions):
- File or directory paths (`foo/bar.go`, `pkg:foo/bar/baz`, `services/widget/`, etc.) — bare or in any citation form, in-tree or in a sibling repo.
- Citation forms `code:foo.go::Symbol`, `pkg:github.com/...`, bare URLs, "the code at X" pointers.
- References to external documentation (`docs/...`, READMEs, CHANGELOG, sibling-repo paths).
- Quoted code, quoted lint-config allowlists, or quoted external prose. If a property matters, state it as a property of the artifact; the code is responsible for enforcing it.
- "Owns / Does NOT own" sections that name code paths. Concept Boundaries is the in-vs-out section, and it names neighbor concepts by slug.

**Concept-specific tightening — no implementation enumeration.** A concept body must not enumerate the current instances of itself (CLI verbs, library names, file extensions, route paths, wire-format identifiers, license names, command-line flags, environment variable names). The concept names the kind of thing; the specific instances live in decisions (where the tradeoffs that picked them live), in code, or in specs. A concept body that reads as a list of "things that currently exist" rather than "what this thing is, in general" has descended below concept altitude. The prohibition targets code-level instance enumerations like those; a concept that is by nature a group of suite-level things may name its members — naming them is definition, not implementation detail.

**Decision exemption — Choice may name the artifact.** The Choice section of a decision MAY name the specific artifact picked (the library, protocol, format, value), because the artifact identity is what carries the tradeoff. This is not a violation of self-containment; it is the decision doing its job. The artifact name in a decision is permanent (the decision records what was chosen); the artifact name in a concept would be implementation detail (the concept describes what kind of thing the artifact is an instance of). Same word, different altitude.

If an artifact feels like it can't say what it needs to without naming a file, that's either (a) a hint that the artifact's boundary is muddier than the current text claims — file an issue — or (b) material that belongs in the `_discover/` scaffolding (Code surface section), not in the artifact body.

---


### {{CURRENT-STATE-ONLY-RULE}}

Concept, story, and decision bodies describe the project **as it stands today**. They are not journals and they are not roadmaps. Two failure modes to avoid:

- **Historical content** — "changed on YYYY-MM-DD", "previously called X", "used to live in foo/bar.go", "see spec Z that introduced this", "was tightened per spec Q", or any audit-trail line whose subject is *what changed* rather than *what is*. Git already records what changed; duplicating that in the design doc is at best distracting, at worst the artifact ages into a changelog nobody reads. **There is no `## Notes` / `## History` / `## Changelog` section on any concept, story, or decision file.** If you find one (in a hand-written artifact or an older-version output), strip it.
- **Forward-looking content** — "we plan to", "will be replaced by", "TODO: tighten this", "out of scope for now", "deferred to V2", "open question for later". A design doc that names work not yet done invites implementing agents to defer against it. Open ambiguities go in the issue intake, where they sit as explicitly unresolved; intended future changes go in a sprint, not the design doc. Nothing in the durable model is aspirational.

The exception is the discovery scaffolding kept around as judgment-call surface: `_discover/` (phase-1 raw notes). It is explicitly point-in-time; the durable model is not.

When a sprint changes a concept / story / decision, its delta rewrites the affected section in place to reflect the new state. The git commit carries the lineage. Do not paste a dated entry into the artifact body.

---

### {{AUDIT-DEFINITION}}

An **implementation audit** is a good-faith, adversarially-minded answer to two independent questions about one artifact: *does this artifact comply with its own authoring rules?* and *does the codebase support what it claims, at this commit?* Both are recorded, because they genuinely come apart — a malformed artifact may be accurately implemented, and a well-formed one may be implemented nowhere. It is a **statement about a named tree**, not a standing verdict — which is what makes it simple: nothing computes its freshness, nothing invalidates it, and asking whether it still holds is a git question anyone can answer by looking at how far HEAD has moved.

One audit file per live artifact of every estate the project has, at `<estate>/audits/<bucket>/<slug>.md` mirroring the collection it audits:

- `.ok-planner/audits/concepts/<slug>.md` ↔ `.ok-planner/design/concepts/<slug>.md`
- `.ok-planner/audits/stories/<slug>.md` ↔ `.ok-planner/design/stories/<slug>.md`
- `.ok-planner/audits/decisions/<slug>.md` ↔ `.ok-planner/design/decisions/<slug>.md`

Audits are a corpus collection of their own, with their own rules:

- **Written only by the periodic audit run** — never by the session that implemented the work, never edited by hand, and never patched. Each run rewrites every audit whole from a fresh read; there is no refresh, no re-pointing, and no partial update.
- **The determination is one of three words.** `supported` — the codebase carries what the artifact claims. `unsupported` — it does not, and the audit says what is absent. `unclear` — the artifact itself does not settle what would count as support. The initial auditor may reach any of the three; `unsupported` and `unclear` escalate to the second-opinion judge, which is the only writer that finalizes them.
- **The support instrument differs by kind.** A story promises a user outcome, so its support is determined from the user's vantage: passing experiments driven through the ruled public surface on the maintained harness demonstrate the capability and the benefit — never a reading, and never a test, which may reach behind the surface. A decision or concept describes internals no user-vantage run can see, so its support is an adversarial reading of the claim against the code as it stands. The same three words, the same collection, the same escalation, a different instrument.
- **The compliance axis is one of two words, and it is independent.** `compliant` — the artifact body satisfies its kind's authoring rules. `noncompliant` — it does not, and a `## Compliance` section says which rule and what the compliant text would be. A compliance defect is mechanical by nature: whoever reads the report fixes it. The audit records it and fixes nothing, and it never changes the determination.
- **An audit is one sentence to one paragraph, and no more.** It states the verdict and what was looked at to reach it, broadly: "checked all 23 skills under the families plus the front door and `/release`; each declares the explicit-slash-command guard." The audience is an experienced engineer with little knowledge of the project and not a lot of time. Present tense, current state only — no history, no prior determinations, no account of what changed, no hypotheticals, and no speculation about what might invalidate it.
- **Any universal the artifact claims comes back as a count and the population it was taken from.** A quantifier — every, all, each, never, none, only — is only worth asserting if someone enumerated the members, so the audit reports the number it checked and where the set came from ("all 23 skills … every `SKILL.md` under `plugins/ok/families/*/skills/`"). A count is refutable by a reader in seconds and changes only when membership changes; a vague assurance is neither.
- **Where the artifact is governed by coverage rather than by a single verdict, the determination takes the coverage shape.** An artifact that names an enumerable population and claims the whole of it is audited by counting: the frontmatter carries `checked:` (the population size enumerated from reality) and `unaccounted:` (its members nothing accounts for), and every unaccounted member is named under `## Unaccounted`. `unaccounted: 0` and `supported` mean the same thing and must agree. The words, the stages, and the run's refusal to fix are the same as for any other audit.
- **No citations, no line numbers, no hashes, no pasted code, and no per-evidence paths.** Naming a population is the one place a path belongs — and naming an unaccounted member, or a site listed for remediation, is that same place: those lists *are* the deliverable, not evidence for a verdict. The reading list for the next run is the annotation grep, which costs nothing and cannot rot into a false alarm — the one job annotations have.
- **A non-supported determination must name its issue.** `unsupported` and `unclear` each carry an `issue:` slug written by the judge when it files. An audit in either state without one is malformed: it asserts a gap nobody is holding.
- **Subjective clauses ground referrals, never determinations.** Per `{{DECIDABILITY-BOUNDARY}}`, where an artifact promises something whose quality only a human discipline can judge, the audit records a referral — the promise, what exists in form, and the discipline that owns the judgment — and opines no further.

---

### {{AUDIT-FILE-FORMAT}}

```markdown
---
audit: <artifact-slug>
artifact: <kind>:<slug>
determination: supported | unsupported | unclear
compliance: compliant | noncompliant
commit: <short sha of the commit this audit is a statement about>
audited: <ISO 8601 UTC>
issue: <issue-slug — required on unsupported and unclear, absent on supported>
checked: <population size — coverage-shaped audits only>
unaccounted: <members nothing accounts for — coverage-shaped audits only>
---

# <One-line restatement of what was checked>

<One sentence to one paragraph. The verdict, then what was looked at to
reach it — broadly, in prose. Every universal the artifact claims comes
back as a count plus the population it was taken from. No citations, no
paths beyond naming a population, no line numbers, no hashes, no code.>

## Compliance

<Only when `compliance: noncompliant`; omitted otherwise. Which
authoring rule the body breaks and what the compliant text would be.
One line per defect.>

## Unaccounted

<Coverage-shaped audits with `unaccounted:` above zero; omitted
otherwise. One line per member of the enumerated population that
nothing accounts for. Naming the members is the deliverable.>

## Remediation

<Coverage-shaped audits only, and optional: members that ARE accounted
for but depart from what accounts for them. One line each. These are
work for ordinary planning, never questions for the issue intake.>

## Referrals

<Only when the artifact promises something a human discipline owns;
omitted otherwise. Each referral is a positive statement about what was
established, never an exemption from work. Fixed line grammar:>

- referral: <the promised thing, one line>
  established: <what exists in form, and how it was confirmed>
  discipline: <documentation | editorial | ux | human-review | <other>>
```

---

### {{ANNOTATION-INTEGRITY-RULE}}

Code-side annotations `@concept:<slug>`, `@story:<slug>`, and `@decision:<slug>` link code to the design model. Each annotation's slug MUST resolve to a live artifact at the corresponding path: `@concept:<slug>` to `design/concepts/<slug>.md`, `@story:<slug>` to `design/stories/<slug>.md`, `@decision:<slug>` to `design/decisions/<slug>.md`. The discipline is symmetric across the three kinds.

An annotation fails integrity in one of two ways:

- **Dangling** — the slug does not exist at any kind. The annotation points at a design artifact that was never written, was renamed, or was retired without sweeping the code. Fix: rename the annotation to the canonical slug if the artifact exists under a different name, or drop the annotation if the artifact no longer exists.
- **Kind-mismatch** — the slug exists, but at a *different* kind than the annotation claims (e.g. `@concept:foo` but `concepts/foo.md` does not exist while `stories/foo.md` does). The author reached for the wrong tag prefix. Fix: rename the annotation to match the artifact's actual kind. Story / decision / concept name distinct kinds of design content; the annotation must carry the kind that matches the artifact.

The slug stamped into the code is the *exact* basename of the design artifact's filename. Paraphrasing — using a short-form code annotation against a long-form artifact slug — is dangling, even when the short form reads naturally. The artifact's filename is the canonical slug; the annotation cites it byte-for-byte.

**Where this is checked:** by `/audit`, whole-corpus — `rg -n '@(concept|story|decision):\s*\S+'` across the codebase; every match's slug-and-kind pair must resolve. Dangling and kind-mismatched annotations are mechanical findings: the caller fixes them in-cycle (repoint or remove), then re-runs the audit.

**Why this rule, not "any annotation is fine."** The annotation is the durable link between code and the design model. A paraphrased slug or wrong-kind tag looks like a link but resolves to nothing — a future reader (or agent) chasing the citation finds no artifact, with no signal whether the artifact was missed, retired, or simply named differently. The rule keeps the link real: an annotation either resolves to an artifact of the named kind, or it should not exist at all.

---

## Anti-padding (general)

- Don't manufacture issues. If a topic is clear in `_discover/`, the concept / story / decision file alone is enough.
- Don't merge issues that share a category but are semantically separate. One issue file per genuine muddiness.
- Don't grade severity.
- Don't write more than one file for the same artifact (same concept, same story, same decision). Merge if you find duplicates.
- Don't introduce code-path citations into concept, story, or decision bodies. The design owns the definition; code references it via `@concept:` / `@story:` / `@decision:` annotations.
- Don't invent stories the product does not yet deliver, or decisions the project has not yet made. Those go into sprints (or remain unwritten until a sprint proposes them).

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
