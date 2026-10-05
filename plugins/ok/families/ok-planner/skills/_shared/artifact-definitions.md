# Shared artifact definitions

This file defines the artifacts ok-planner skills produce and consume — concept, story, decision, issue, corpus delta, audit — and the rules that govern their bodies. Skills read it and never restate it. Change wording here only.

## What `.ok-planner/design/` holds

The corpus is the project's durable model: what the project is and what it owes its users. Its three artifact kinds:

- **Concepts** define the load-bearing nouns: what kind of thing exists, not which instances exist now.
- **Stories** state durable user expectations: what the product owes its users, never how it delivers it.
- **Decisions** record technical choices with real alternatives: the choice and the tradeoff, never the implementation.

Interface designs, route shapes, CLI grammars, schemas, and implementation diagrams live in code, sprints, and other documentation. The `/audit` compliance pass flags them in `design/`.

**Issues** are questions about the corpus awaiting the owner's ruling. They live in the intake: one record per open issue in `.ok-planner/issues.jsonl`, and one per closed issue in `.ok-planner/history/issues.jsonl`. `.ok-planner/bin/issues` is the only writer of both files.

## How consumers use this file

Each `###` heading below names a token. A skill that dispatches a subagent replaces `{{TOKEN}}` in the prompt with the body under that heading. `[...]` marks a per-run value the skill fills. A skill whose logic runs in the main loop reads the block by path.

## Token catalog

---

### {{CONCEPT-DEFINITION}}

A **concept** is a load-bearing noun the system traffics in. A reviewer who meets the noun in code needs its definition to read the code.

A concept defines. It does not guarantee, forbid, or decide. It says what kind of thing exists, what it is for, and where it ends against its neighbors.

A concept says nothing about implementation. It names no instance — a verb, a library, a file extension, a route, a wire identifier, a license, a constant, a command, a page, a screen, a view, a button, a field, a layout, a menu, a flow — and no mechanism, no requirement, no prohibition. Instances and mechanisms belong in code or, where a tradeoff picked them, in a decision. A promise to a user belongs in a story.

Two tests decide whether a concept exists and whether its body is a definition. A drafter applies them before writing; the compliance reviewer fails a concept on either.

- **Existence.** The project narrows the noun: a competent engineer reading the word alone would take it to mean something wrong or incomplete. The body carries at least one sentence that states the narrowing. Deleting the file would change how a reader reads some story, decision, or annotated code. A noun whose body is its dictionary meaning fails. A noun that names a part of the product — a page, a screen, a module, a table, a service — rather than a kind of thing the product reasons about fails; the part lives in code, and the kind it embodies, if any, is the concept.
- **Invariance.** A sentence under `## What it is` or `## Boundaries` stays when it holds for every product that meets the same stories, whatever decisions that product makes. A sentence that some such product could make false describes this build, and goes, to a decision or to code. In video-editing software, "a timeline arranges media clips in time" stays; "a timeline is saved as an edit decision list" goes, because a product that saves its timelines another way still meets every story.

One concept per file. Merge `_discover/` entries that describe one noun.

---

### {{CONCEPT-TEMPLATE}}

Write each concept to `.ok-planner/design/concepts/<slug>.md`. The slug is the preferred name; aliases go inside the file.

```markdown
---
concept: <slug>
aliases:
  - <other names this concept goes by in code/prose>
---

# <Concept name>

## What it is

<One paragraph. Stands alone for a reader who has never opened the repo.>

## Purpose

<What this concept makes possible.>

## Boundaries

<What is in, what is out and lives in a neighbor, and which neighbors it interacts with. Name neighbors by slug (`see also: <slug>`).>

## Aliases

<Names that appear in live code or prose today. Two live names for one concept is an issue: file it. Omit the section when there are none.>
```

---

### {{STORY-DEFINITION}}

A **story** is a durable user expectation: a capability the product owes its users and the benefit it serves. The test: years from now, a regression of this capability is a defect a user would notice. A change, a build record, or a task is not a story.

Write a story as `As <role>, I want <capability>, so that <benefit>`. The "so that" clause is mandatory. A story without it names an activity, not a need, and fails compliance. A story that names mechanism — library, data shape, algorithm, storage, protocol — fails compliance. The story owns the need; decisions own the how.

A story states a need, never a design. The capability reads as `I want a way to <do something>`, and the product is free to deliver it on any surface in any shape. A story that names a surface element — a page, a screen, a view, a panel, a button, a link, a menu, a field, a layout — or an interaction on one — click, open, navigate, select, scroll — or enumerates what a surface contains and what happens when the user acts on it, is an interface specification and fails compliance. Interface specifications live in a sprint's work items and, where a tradeoff picked the surface, in a decision.

Three tests decide whether a story is a story and whether its body is a need. A drafter applies them before writing; the compliance reviewer fails a story on any of them.

- **Need.** Strike every surface element and every interaction from the capability clause. What remains, phrased as `a way to <do something>`, is the story. If nothing remains, there is no story: the draft was a design, and it goes to a work item or a decision.
- **One need.** The capability clause names one capability and the benefit clause names one benefit. A capability clause that lists several capabilities, or a benefit clause that lists several outcomes, is several artifacts. Factor it: each capability with the benefit it serves becomes its own story, and each item that says how — a surface, a policy, a value, a mechanism — becomes a decision where it has an alternative, or goes.
- **Invariance.** The story stays true if the product were rebuilt on a different surface with a different implementation. A sentence a surface change could falsify describes a design, and goes.

An overloaded or over-specific story is factored, never trimmed to a stub: the needs it bundled become stories, the choices it prescribed become decisions, and the interface detail it carried goes to the work item that builds it.

- The story has no acceptance section. Its acceptance is that the user has a way to do the capability and gain the benefit.
- The delivery surface belongs to a decision. Two stories with one user outcome through different surfaces are one story.
- State an outcome a reader can settle by observing it. Concreteness is about the outcome the user gains, never about the surface that delivers it. Correct, clear, helpful, intuitive describe how well the product delivers, not what it delivers. Rewrite them as what the user can now do. Where a promise rests on a human discipline's judgment, the audit records a referral per `{{DECIDABILITY-BOUNDARY}}`.
- The audit verifies stories, from the user's vantage, per `{{AUDIT-DEFINITION}}`. A story carries no `Proof:` field. The code that realizes a story carries `@story:<slug>` at that site.
- A change is not a story. Capture the expectation that persists across the change.

Discover stories from public surfaces (the surface goes to a decision, the outcome to a story), README and docs sections that say what the product does for users, and `.ok-planner/history/sprints/` where present.

---

### {{STORY-TEMPLATE}}

Write each story to `.ok-planner/design/stories/<slug>.md`.

```markdown
---
story: <slug>
---

# <Short story title>

## Story

As <role>, I want <capability>, so that <benefit>.

```

---

### {{DECISION-DEFINITION}}

A **decision** is a technical choice with real alternatives. An engineer can name the choice and a plausible different choice, and the rationale is a tradeoff.

- The Choice may name the artifact: library, protocol, format, value.
- A decision names the choice and the reasoning only. Implementation steps, file structure, schema, and call sequences live in code and sprints. How the chosen thing works lives in the thing.
- The audit verifies decisions by adversarial reading against the code, per `{{AUDIT-DEFINITION}}`. Code that enforces the choice carries `@decision:<slug>` at the point of enforcement. A Choice no code enforces audits as unsupported.
- A choice with no alternative is a default. Delete it.
- One decision per choice.

Discover decisions from architecture and configuration choices in code, comments and commits that justify a choice, ADR-style files (keep the choice and rationale), and `_discover/` Observations flagged as choices with an alternative.

---

### {{DECISION-TEMPLATE}}

Write each decision to `.ok-planner/design/decisions/<slug>.md`.

```markdown
---
decision: <slug>
---

# <Short decision title>

## Choice

<The option adopted. One or two sentences. May name the artifact.>

## Rationale

<The tradeoff. Source it from code, comments, ADRs, or the code's shape. If unclear, file an issue.>

## Alternatives

<The options not taken. One bullet each, one line each.>

```

---

### {{CORPUS-DELTA-FORM}}

A **corpus delta** is one change to the corpus, carried in a sprint under a heading naming the operation and the target: `### New story: <slug>`, `### Amend concept: <slug>`, `### Retire decision: <slug>`. Sprint deltas are the only way the corpus changes.

- A concept, story, or decision delta lands under `.ok-planner/design/`. A sprint also carries subject and practice deltas (`### New practice: <slug>`), which land under `.ok-planner/subjects/` and `.ok-planner/practices/`. Applying any delta includes regenerating its collection's catalog TOC with `python3 .ok-planner/bin/catalog-toc`.

- Every delta is a complete final-form body. A new artifact and an amendment carry the whole file per the templates above. A retirement carries only its heading; execution deletes the file. There is no diff form and no base pin. Author an amendment by editing the artifact during planning and carrying the whole result. Application is a copy. The completion contract's first item is a file comparison.
- Long bodies go in a sidecar: `.ok-planner/sprints/<sprint-name>-deltas/<kind>s/<slug>.md`, one file per artifact, and the sprint heading reads `body: in the sidecar`. The sidecar is part of the sprint: sign-off reads it, execution copies from it, close-out archives it. Inline bodies are the norm.
- Review reads each body whole: form, claims, coherence with the live corpus. Whether an amendment drops something silently is the reviewer's judgment against the live artifact. Sprint certification (`/converge sprint`) then checks the applied corpus against the deltas by file equality. There is no mechanical derivation check.

---

### {{ISSUE-DEFINITION}}

An **issue** is one record in the intake. Most issues are **judgment issues**: a question about the corpus or the tooling that needs the owner's judgment. A **defect issue** is the other kind: a harm the accept list at `.ok-planner/review/catalog/accept.md` covers, at a named site, for the next `/converge` to fix. The "Defect issues" section of `.claude/rules/ok-planner-cheatsheet.md` carries the defect issue's filing, verifying, routing, and closing rules. Categories:

- `overloaded` — one name means several things.
- `unspecified` — something load-bearing has no name or no boundary.
- `unclear` — the definition is fuzzy, or parts of the project disagree.
- `inconsistent` — one property implemented two ways, one concept spelled two ways, one constraint with two cutoffs.
- `conflicting` — two parts of the code or two prose sources contradict each other.
- `vestigial` — named or annotated but no longer load-bearing.
- `muddy-boundary` — adjacent concepts blur.
- `test` — a test question needing owner calibration.
- `design` — the corpus decides the end state and only the way to reach it is open.
- `product-intent` — the answer changes what the product owes.
- `tooling` — how the project's own tooling works: the skills, prompts, and rules the project owns under `.claude/` and `.ok-planner/`, and its environment. The next `/plan-sprint` takes it up. A change to a suite-owned file is an `upstream` issue.
- `upstream` — a harm whose fix lies in a part the project does not own: a suite-owned file (one `/ok` overwrites on every converge), a library the project depends on, an outside tool or service, or the suite's accept list itself, for a harm the list does not name. Its `upstream` field carries a draft ready to file with the part's maintainers. It stays in the intake while the project still shows the harm, and the next `/plan-sprint` walks it with the owner.
- `other` — a judgment item none of the above fits.
- `defect` — a defect issue, as above.

Judgment items and defects outside a run's scope become issues. Fix mechanical findings in-cycle and file none.

An issue carries its **discussion**: the owner's comments and rulings, and the replies and updates `/triage-issues` writes in answer. A comment is not a ruling. The owner questions or corrects an issue's analysis by commenting on the issue, and the next `/triage-issues` run answers on the issue itself, so every later reader sees the answer.

The intake is a queue, not a work tracker. A judgment issue closes three ways, each an owner act recorded through `/plan-sprint`:

- **Promoted** — the ruling is carried into a sprint as a delta, a work item, or both, and the record's `sprint` names the sprint's file. The sprint is then the source of truth. The record closes as `promoted` when the sprint closes. A later sprint never reopens a promoted issue; a wrong outcome is a new issue. An upstream issue the owner answers with a workaround closes this way, and one the owner answers with both a workaround and a filing closes this way with the ruling naming where it was filed.
- **Answered upstream** — the owner files an upstream issue's draft with the part's maintainers. The ruling names where it was filed, and the record closes as `answered` at once.
- **Retired** — the owner drops the question. The record closes as `retired`, with the owner's reason, at once.

`/triage-issues` closes an issue the code, the corpus, or the tooling already settles as `answered`, and retires a defect claim no accept-list entry covers. It leaves an upstream issue open while the project still shows the harm, and closes it as `answered` once the harm is gone, as after an update of the foreign part. A defect issue closes through `/converge`: `fixed` when the run verified the fix, `answered` when the code no longer shows the defect. A defect issue the owner picks into a sprint closes as `promoted`.

Life of a judgment issue: filed → triaged → ruled → promoted or retired. Life of an upstream issue: filed → triaged → filed upstream (answered), promoted, or answered once the harm is gone. Life of a defect issue: filed → triaged → fixed, answered, or promoted.

---

### {{ISSUE-FILE-FORMAT}}

The intake is two JSON Lines files with one record per line. `.ok-planner/issues.jsonl` holds the record of every open issue, and `.ok-planner/history/issues.jsonl` holds the record of every closed one. `.ok-planner/bin/issues` is the schema's authority and the only writer of both files. It checks every record on every read, refuses a line that breaks the schema with `<file>:<line>: <field>: <defect>`, and runs every write under one lock, on the files as reread under that lock. Never edit either file by hand, and never write an issue as a markdown file. `.ok-planner/bin/issues --help` lists the verbs.

A filer files one issue by passing one JSON object to `.ok-planner/bin/issues file --from -` (or `--from <path>`):

```json
{
  "id": "<stable-slug>",
  "kind": "audit | discover | sprint | human",
  "category": "<category>",
  "artifacts": ["concept:<slug>", "story:<slug>"],
  "title": "<One-line summary of the question>",
  "problem": "<First sentence: what the tree does or lacks, and which commitment that breaks. Then only what a reader needs to judge the options.>",
  "options": [{"text": "<resolution shape, stated as a durable corpus mutation; never picked>"}],
  "upstream": "<the draft ready to file; an upstream issue only>"
}
```

`artifacts` takes `concept`, `story`, `decision`, `subject`, and `practice` slugs. The module labels the options A, B, … and fills in the rest of the record:

| Field | Value |
|---|---|
| `id`, `title`, `kind`, `category`, `artifacts`, `problem`, `upstream` | As filed, and as the verifier rewrites them; `upstream` is null on any other issue |
| `options` | A list of `{"label", "text"}` objects |
| `route` | Null until `/triage-issues` routes the issue, then `upstream`, `defect`, `corpus`, or `question` |
| `recommendation` | Null, or `{"form": "generated" or "recommended", "text"}`: the verifier's marked ruling |
| `ruling` | Null, or `{"text", "at"}`: the owner's words and when the owner gave them |
| `messages` | The discussion, below |
| `sprint` | The sprint's filename; present only once promoted |
| `source` | The markdown file a converted record came from; converted records only |
| `opened`, `updated` | ISO 8601 UTC times ending in `Z` |

A record in the archive adds `closed` (the time), `closed_as` (`answered`, `retired`, `promoted`, or `fixed`), `reason` (required for `answered` and `retired`), and `fixed_by` (the `/converge` run; required for `fixed`).

An issue's **state** is computed, never stored: no route and no ruling is `open`; route `defect` is `verified`; any other route with no ruling is `needs-ruling`; a ruling is `ruled`; a record in the archive is `closed`. `issues list`, `issues show <id>`, and `issues history` read the intake; with `--json` they add `state`, `waiting` (no route and no ruling, or an owner message triage has not yet seen), `unseen` (owner messages triage has not yet seen), and `unread` (triage messages the owner has not yet read).

The **discussion** is `messages`, numbered by `n` from 1. No writer removes a message.

| `type` | Written by (`by`) | What it carries |
|---|---|---|
| `comment` | `owner` | `text`; `seen`, null until triage acts on it |
| `ruling` | `owner` | `text`, which also becomes `ruling`; `seen`, as for a comment |
| `reply` | `triage-issues` | `replies_to`, the owner messages it answers; `text`; `read`, null until the owner reads it |
| `update` | `triage-issues` | `changed`, the fields the same write rewrote; `text`, what changed; `read`, as for a reply |

The writers and their verbs:

| Writer | Verbs |
|---|---|
| A filer | `issues file --from -` |
| `/triage-issues` | `issues revise <id> --from -` routes an issue and rewrites its fields; `issues respond <id> --from -` writes replies, an update, and seen marks in one write; `issues close <id> --as answered\|retired --reason <why>` |
| The owner | `issues rule <id> --text <words>`, `issues comment <id> --text <words>`, `issues read <id>`, or the dashboard (`.ok-planner/bin/dashboard`) |
| `/plan-sprint` | `issues rule` to transcribe a ruling the owner gives live; `issues promote <id> --sprint <file>`; `issues close <id> --as promoted\|retired\|answered` |
| `/converge`'s owner list | `issues revise`; `issues close <id> --as fixed --fixed-by <run>` or `--as answered --reason <what it found>` |
| `/ok` | `issues import`, converting an earlier intake |

An upstream issue (`category: upstream`) carries its draft in `upstream`, ready to file with the part's maintainers, in this shape:

```markdown
<Plain title>

<The foreign part as the project sees it: the package and its version,
the tool, or the file's path as it sits in the project, never a path
to a local checkout of the suite or of any other part. The suite is
"the ok suite", and a suite-owned file names the version its stamp
gives. Each site, as path:function, with its trigger and its harm. The
evidence, quoted. For a harm the accept list does not name, the
proposed entry wording, quoted.>
```

Rules:

- `id` is a stable fingerprint of artifact plus nature of the problem: a slug, with no line numbers and no dates. Check the intake before filing: `issues list --artifact <kind:slug>` lists the open issues on an artifact, and `issues show <id>` shows one. An open issue re-observed files nothing. The module refuses an id that is already open.
- Ownership follows the lifecycle. The filer writes the filed fields above. The verifier (`/triage-issues`) sets `route` and rewrites the filed body into the verified form below with `issues revise`; it may replace the title with a plainer one. Once it has routed an issue, the verifier changes it only through `issues respond`, whose `update` message names each field it rewrote, so the owner sees the change as new analysis. The owner alone writes `ruling` and owner messages. The verifier never writes `ruling`, and `revise` and `respond` refuse it. A defect issue (`category: defect`) is the exception: `/converge`'s owner list closes it, or turns it into a judgment issue when its defect sticks, as the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` says.
- Write `problem` under the technical-writing standard. First sentence: what the tree does or lacks and which commitment that breaks. For a rule violation, state the rule, then how the code breaks it. Call each thing what it is. Include a fact only when it changes how the reader judges an option. Name the member that breaks the rule, never the population that keeps it; the count belongs in the audit record. Where any definition in this file conflicts with the technical-writing standard, the standard wins.
- The verified form carries, for an engineer who does not know the project and must evaluate the ruling: in `problem`, the defect and the commitment it breaks, the mechanism (what talks to what, who observes it), the state of play, and one sentence naming what the ruling decides; in `options`, each real option with its one cost; and in `recommendation`, the marked ruling. It includes a project term only when evaluating the ruling requires it, cites a slug only after the words it labels, and restates nothing. A recommendation states what to do and why, with the flip case; it carries no delta phrasing and no file paths.
- Evidence in `problem` may rot. A judgment issue's options as filed are durable corpus mutations, never file or symbol citations. A defect issue's one option is to fix its site, named as `path:function`, so the harm no longer follows.
- A set `ruling` is the ruled signal. The next `/plan-sprint` pulls every ruled issue in without re-discussion, asking only when it cannot understand a ruling. A later ruling replaces the earlier one.
- A recommendation may be generated. When the corpus and its authoring rules determine the one compliant resolution, the verifier writes it as `recommendation` with `form: generated`. The verifier never applies the fix. The recommendation names the fix concretely enough that `/plan-sprint` drafts it and execution applies it. An issue the rules do not determine gets no generated recommendation. An issue reducible to "should the docs follow the rules?" gets one. The authoring rules bind like lint: the verifier applies them and never adjudicates them. A debatable application still applies; note the doubt in one sentence of the narrative.
- A recommendation may be recommended. Where the resolution is a judgment call, the verifier writes the resolution it judges best serves the project's intent as `recommendation` with `form: recommended` and a brief rationale.
- Silence accepts a recommendation of either form: left standing, it becomes the owner's ruling when the next `/plan-sprint` carries it, and that session names each form's batch in one sign-off line. Two exceptions hold it back. An upstream issue's answer is the owner's act, so silence accepts nothing there. An owner message triage has not yet seen holds back the recommendation on its issue. The next `/plan-sprint` walks each held-back issue with the owner. The owner rules to adopt the recommendation or to redirect it, and comments to discuss it.
- Every owner message starts with `seen: null`. `/triage-issues` marks an owner message seen only after acting on it, in the same write as its reply or update, so a run that dies midway leaves the message for the next run. Every triage message starts with `read: null`; the owner's reading (`issues read`, or opening the issue on the dashboard) sets `read`. The module refuses an owner message on a closed or promoted issue, and an empty text.
- State moves forward only. `issues close` moves a record from the live file to the archive. The planner stamps `sprint` with `issues promote` at sign-off and closes the record as `promoted` when the sprint's implementation closes. It closes a record as `retired`, with the owner's reason, or, for an upstream issue the owner files upstream, as `answered`, with the ruling naming where it was filed, at once. The verifier closes two ways, each with a reason that cites the deciding artifact and section. `answered`: the code, the corpus, or the tooling decides the question, or the filed gap no longer exists; for an upstream issue, only once the project no longer shows the harm. `retired`: a defect claim no accept-list entry covers. The verifier never closes a ruled issue. A defect issue closes as `fixed` or `answered` (`/converge`'s owner list). A rules-determined fix is not a closure; it stays open under a generated recommendation. Never delete a record.
- Writers file; the owner closes a judgment issue. `promoted`, an owner's `retired`, and an owner's filing upstream are recorded only from a `/plan-sprint` session. The verifier's `answered` and `retired` carry their reason, and its report lists them for veto. Anything else the verifier is certain of becomes a generated recommendation, never an edit.
- `sprint` names the handoff. Once stamped, the sprint is the source of truth; nothing reads the issue's record to learn how the work went.
- The sprint gate is relevance-scoped. A `/plan-sprint` planning new work drafts it first, then resolves with the owner every open, unruled issue that bears on the draft — one whose answer the work would otherwise encode silently. Independent issues stay open. A sprint convened to work the intake takes it, or a named batch, as its scope.
- Earlier layouts are converted, never edited. Markdown issue files under `.ok-planner/history/issues/` stay as written and read as closed, whatever their `status:`; read `repaired`, a retired terminal status, as closed too, and never write it. A project whose `.ok-planner/issues/` still holds markdown issue files, or whose `.ok-planner/issues.jsonl` is the pre-v9 event log (`open` / `promote` / `retire` / legacy `resolve` events), converts it through the front door's administration (`/ok`). The `markdown-intake` cleanup offer turns each open markdown file into a record, its owner's `## Ruling` text becoming `ruling` and its marked generated or recommended ruling becoming `recommendation`, then moves every file to `history/issues/`. A marker that names a retired `/recommend-rulings` or `/verify-issues` verb reads the same. The `legacy-intake` offer converts the event log in place into open and closed records. Until the owner accepts, every verb of `.ok-planner/bin/issues` but `import` refuses, naming the offer. Never edit or append to the log or the markdown files.

---

### {{DECIDABILITY-BOUNDARY}}

Every story, and many a decision rationale, mixes two kinds of clause:

- **The mechanical core** — clauses with a decision procedure: a population is covered, a verb answers, a value round-trips, a file exists. Audits determine these, and findings rest on them.
- **The qualitative rim** — clauses whose truth is a human quality judgment: correct (of prose), canonical, clear, helpful, complete (of explanation), useful, intuitive, well-designed. No procedure settles them.

Rules:

- Write the concrete version first. Restate a rim clause as something observable, per `{{STORY-DEFINITION}}`. What survives is residue a human discipline owns; the process records it and does not rule on it.
- No determination rests on the rim. An audit rules a rim clause neither supported nor unsupported. A finding grounded only in it dissolves and never reaches the intake.
- The line is the existence of a decision procedure, not difficulty. "Hard to check" is not qualitative. A coverage claim is mechanical however large the population. Classifying a decidable claim as qualitative to escape work is itself a finding.
- Where the rim names something a human discipline owns, the auditor records a referral (format in `{{AUDIT-FILE-FORMAT}}`): the promise, what was established in form, and the owning discipline. A referral exempts no work and is never an issue.

---

### {{SELF-CONTAINMENT-RULE}}

Artifact bodies stand alone. The corpus owns the definition; code points at it with `@concept:`, `@story:`, `@decision:`. A refactor that moves files does not invalidate an artifact.

- Frontmatter carries slug-form metadata only: `concept:` / `story:` / `decision:` and `aliases:`. No `references:` field, no paths.
- Allowed in bodies: other artifact slugs (`see also: <slug>`, `concept:<slug>`, `story:<slug>`, `decision:<slug>`); invariant IDs under the codebase's own convention.
- Disallowed in bodies: file or directory paths in any form; code citation forms and bare URLs; references to external documentation; quoted code, quoted lint allowlists, quoted external prose — state the property and let the code enforce it; "Owns / Does NOT own" sections naming code paths.
- A concept body does not enumerate its instances.
- A decision's Choice may name the artifact.

An artifact that cannot say what it needs without naming a file has a muddy boundary — file an issue — or carries material that belongs in `_discover/`.

---

### {{CURRENT-STATE-ONLY-RULE}}

Artifact bodies describe the project as it stands. Present tense.

- No history: no "changed on", "previously called", "used to live in", "see the spec that introduced this". No `## Notes`, `## History`, or `## Changelog` section; strip one where found.
- No roadmap: no "we plan to", "will be replaced by", "TODO", "out of scope for now", "deferred", "open question". Open ambiguities go to the intake; intended changes go to a sprint.

`_discover/` scaffolding is point-in-time and exempt. A sprint's delta rewrites the affected section in place.

---

### {{AUDIT-DEFINITION}}

An **implementation audit** answers two independent questions about one artifact: does its text comply with its kind's authoring rules, and does the codebase support what it claims at this commit? An audit is a statement about a named commit, not a standing verdict. Nothing computes its freshness.

One audit file per live artifact, at `.ok-planner/audits/{concepts,stories,decisions,subjects}/<slug>.md`: the first three buckets mirror `.ok-planner/design/{concepts,stories,decisions}/<slug>.md`, and `subjects/` mirrors `.ok-planner/subjects/<slug>.md`.

Rules:

- Only the periodic audit run writes audits. Never the implementing session, never by hand, never patched. Each run rewrites every audit whole.
- `implementation:` is `supported` or `unsupported`. `supported`: the codebase carries what the artifact claims. `unsupported`: it does not, and the audit says what is absent. Where the artifact's text does not settle what would count as support, the verdict is `unsupported`. The initial auditor may reach either; `unsupported` escalates to the judge, the only writer that finalizes it.
- The instrument differs by kind. A story's support is passing runs of the maintained experiments through the public surface the extraction records — never a reading. A decision's support is an adversarial reading of the claim against the code. A concept's support is the vocabulary reading: the concept has one live name, and the sites that cite it and the code around them agree with its What it is and its Boundaries. A concept's Purpose carries no determination. A subject's support is its coverage: the population enumerated from the code, and the members no practice accounts for; a member that breaks the practice governing it is a defect the judge files, never an unaccounted member.
- `text:` is `compliant` or `noncompliant`, and independent. `noncompliant` adds a `## Compliance` section naming the rule and the compliant text. A text defect is mechanical. It never changes the implementation verdict.
- One sentence to one paragraph: the verdict, then what was looked at, broadly. Present tense. No history, prior verdicts, hypotheticals, or speculation.
- Every universal comes back as a count and its population. For every, all, each, never, none, only: report the number checked and where the set came from. This shape belongs to the audit record. An issue filed from an audit names the member that breaks the rule, not the population.
- A coverage claim takes the coverage shape. Where the artifact names an enumerable population and claims all of it, frontmatter carries `checked:` (population size, enumerated from reality) and `unaccounted:` (members nothing accounts for), and `## Unaccounted` names each. `unaccounted: 0` and `supported` agree.
- No citations, line numbers, hashes, pasted code, or per-evidence paths. A path appears only to name a population or an unaccounted member.
- The audit is a record; the intake is separate. When the judge finalizes `unsupported`, it files an intake issue by the ordinary conventions. No audit-specific fields, no linkage in either direction. An issue may cite its audit in prose.
- Qualitative clauses ground referrals, never verdicts, per `{{DECIDABILITY-BOUNDARY}}`.

---

### {{AUDIT-FILE-FORMAT}}

```markdown
---
audit: <artifact-slug>
artifact: <kind>:<slug>
text: compliant | noncompliant
implementation: supported | unsupported
commit: <short sha of the commit this audit is a statement about>
audited: <ISO 8601 UTC>
checked: <population size — coverage-shaped audits only>
unaccounted: <members nothing accounts for — coverage-shaped audits only>
---

# <One-line restatement of what was checked>

<One sentence to one paragraph: the verdict, then what was looked at,
broadly. Every universal comes back as a count plus its population.
No citations, no paths beyond naming a population, no line numbers,
no hashes, no code.>

## Compliance

<Only when `text: noncompliant`. One line per defect: the rule broken
and the compliant text.>

## Unaccounted

<Only when `unaccounted:` is above zero. One line per member nothing
accounts for.>

## Referrals

<Only when the artifact promises something a human discipline owns.
Fixed grammar:>

- referral: <the promised thing, one line>
  established: <what exists in form, and how it was confirmed>
  discipline: <documentation | editorial | ux | human-review | <other>>
```

---

## Anti-padding

- File no issue a `_discover/` topic already makes clear.
- One issue per genuine muddiness. Do not merge issues that share only a category.
- Do not grade severity.
- One file per artifact. Merge duplicates.
- Do not invent stories the product does not deliver or decisions the project has not made.
