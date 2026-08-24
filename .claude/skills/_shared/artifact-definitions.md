# Shared artifact definitions

This file defines the artifacts ok-planner skills produce and consume — concept, story, decision, issue, corpus delta, audit — and the rules that govern their bodies. Skills read it and never restate it. Change wording here only.

## What `.ok-planner/design/` holds

The corpus is the project's durable model: what the project is and what it owes its users. Its three artifact kinds:

- **Concepts** define the load-bearing nouns: what kind of thing exists, not which instances exist now.
- **Stories** state durable user expectations: what the product owes its users, never how it delivers it.
- **Decisions** record technical choices with real alternatives: the choice and the tradeoff, never the implementation.

Interface designs, route shapes, CLI grammars, schemas, and implementation diagrams live in code, sprints, and other documentation. The `/audit` compliance pass flags them in `design/`.

**Issues** are questions about the corpus awaiting the owner's ruling. They live in the intake, `.ok-planner/issues/`.

## How consumers use this file

Each `###` heading below names a token. A skill that dispatches a subagent replaces `{{TOKEN}}` in the prompt with the body under that heading. `[...]` marks a per-run value the skill fills. A skill whose logic runs in the main loop reads the block by path.

## Token catalog

---

### {{CONCEPT-DEFINITION}}

A **concept** is a load-bearing noun the system traffics in. A reviewer who meets the noun in code needs its definition to read the code.

A concept defines. It does not guarantee, forbid, or decide. It says what kind of thing exists, what it is for, and where it ends against its neighbors.

A concept says nothing about implementation. It names no instance — a verb, a library, a file extension, a route, a wire identifier, a license, a constant, a command — and no mechanism, no requirement, no prohibition. Instances and mechanisms belong in code or, where a tradeoff picked them, in a decision. A promise to a user belongs in a story.

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

- The story has no acceptance section. Its acceptance is that the user has a way to do the capability and gain the benefit.
- The delivery surface belongs to a decision. Two stories with one user outcome through different surfaces are one story.
- State what a reader can settle by looking. Correct, clear, helpful, intuitive describe how well the product delivers, not what it delivers. Rewrite them as what the user can now do. Where a promise rests on a human discipline's judgment, the audit records a referral per `{{DECIDABILITY-BOUNDARY}}`.
- The audit verifies stories, from the user's vantage, per `{{AUDIT-DEFINITION}}`. A story carries no `Proof:` field. Tests still exercise stories end-to-end and carry `@story:<slug>`.
- A change is not a story. Capture the expectation that persists across the change.

Discover stories from public surfaces (the surface goes to a decision, the outcome to a story), end-to-end tests, README and docs sections that say what the product does for users, and `.ok-planner/history/sprints/` where present.

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
- The audit verifies decisions by adversarial reading against the code, per `{{AUDIT-DEFINITION}}`. A decision carries no test obligation. Code that enforces the choice carries `@decision:<slug>` at the point of enforcement. A Choice no code enforces audits as unsupported.
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

- Every delta is a complete final-form body. A new artifact and an amendment carry the whole file per the templates above. A retirement carries only its heading; execution deletes the file. There is no diff form and no base pin. Author an amendment by editing the artifact during planning and carrying the whole result. Application is a copy. The completion contract's first item is a file comparison.
- Long bodies go in a sidecar: `.ok-planner/sprints/<sprint-name>-deltas/<kind>s/<slug>.md`, one file per artifact, and the sprint heading reads `body: in the sidecar`. The sidecar is part of the sprint: sign-off reads it, execution copies from it, close-out archives it. Inline bodies are the norm.
- Review reads each body whole: form, claims, coherence with the live corpus. Whether an amendment drops something silently is the reviewer's judgment against the live artifact. The certification gate then checks the applied corpus against the deltas by file equality. There is no mechanical derivation check.

---

### {{ISSUE-DEFINITION}}

An **issue** is a question about the corpus that needs the owner's judgment. Each issue is one markdown file in the intake. Categories:

- `overloaded` — one name means several things.
- `unspecified` — something load-bearing has no name or no boundary.
- `unclear` — the definition is fuzzy, or parts of the project disagree.
- `inconsistent` — one property implemented two ways, one concept spelled two ways, one constraint with two cutoffs.
- `conflicting` — two parts of the code or two prose sources contradict each other.
- `vestigial` — named or annotated but no longer load-bearing.
- `muddy-boundary` — adjacent concepts blur.
- `test` — a test question needing owner calibration.
- `other` — a judgment item none of the above fits.

Only judgment items become issues. Fix mechanical findings in-cycle and file none.

The intake is a queue of questions, not a work tracker. An issue closes two ways, both owner acts recorded through `/plan-sprint`:

- **Promoted** — the ruling is carried into a sprint as a delta, a work item, or both, and the file is stamped with the sprint's name. The sprint is then the source of truth. The file moves to `history/issues/` when the sprint closes. A later sprint never reopens a promoted issue; a wrong outcome is a new issue.
- **Retired** — the owner drops the question. The file moves to `history/issues/` at once.

Life of an issue: filed → verified → ruled → promoted or retired.

---

### {{ISSUE-FILE-FORMAT}}

One markdown file per issue in the intake, named `<YYYY-MM-DD-HHMMSS>-<slug>.md` (UTC filing time, then slug). Closed issues keep the name under `.ok-planner/history/issues/`. As filed:

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

<First sentence: what the tree does or lacks, and which commitment
that breaks. Then only what a reader needs to judge the candidates.>

## Candidates

- <resolution shape, stated as a durable corpus mutation; never picked>
```

Verification replaces the filed body. A **verified** file reads:

```markdown
---
issue: <same-slug>
…
status: verified
---

# <Plain-language title telling the story>

<The defect and the commitment it breaks; the mechanism; the
state of play.>

## Options

- <each real option with its one cost>

## Ruling

<A marked generated/recommended ruling, or the owner's own words.>
```

Rules:

- `issue:` is a stable fingerprint of artifact plus nature of the problem. No line numbers, no dates. Check the slugs in the intake before filing; an open issue re-observed files nothing.
- Ownership follows the lifecycle. The filer writes frontmatter with `status: open`, title, `## Problem`, `## Candidates`. The verifier (`/verify-issues`) replaces that body with frontmatter, one narrative, `## Options`, `## Ruling`. The verifier may replace the title with a plainer one. Owner text under Ruling is the owner's. The verifier writes under Ruling only the marked forms below or a decision the owner gave live. Once verified, only the owner touches the file.
- Write the Problem under the technical-writing standard. First sentence: what the tree does or lacks and which commitment that breaks. For a rule violation, state the rule, then how the code breaks it. Call each thing what it is. Include a fact only when it changes how the reader judges a candidate. Name the member that breaks the rule, never the population that keeps it; the count belongs in the audit record. Where any definition in this file conflicts with the technical-writing standard, the standard wins.
- The verified body carries, for an engineer who does not know the project and must evaluate the ruling: the defect and the commitment it breaks; the mechanism — what talks to what, who observes it; the state of play; `## Options`, each real option with its one cost; and one sentence naming what the ruling decides. It includes a project term only when evaluating the ruling requires it, cites a slug only after the words it labels, and restates nothing. The Ruling states what to do and why, with the flip case; it carries no delta phrasing and no file paths.
- Evidence in Problem may rot. Candidates are durable corpus mutations, never file or symbol citations.
- A non-empty Ruling is the ruled signal. There is no `ruled` status. The next `/plan-sprint` pulls every ruled issue in without re-discussion, asking only when it cannot understand a ruling.
- A ruling may be generated. When the corpus and its authoring rules determine the one compliant resolution, the verifier writes it under `## Ruling` as a `> Generated ruling (/verify-issues): …` blockquote, followed by an owner comment saying edit-or-delete overrides it. The verifier never applies the fix. The ruling names the fix concretely enough that `/plan-sprint` drafts it and execution applies it. The owner may rewrite or empty it before planning. `/plan-sprint` names the generated-ruling batch in one sign-off line. An issue the rules do not determine gets no generated ruling. An issue reducible to "should the docs follow the rules?" gets one. The authoring rules bind like lint: the verifier applies them and never adjudicates them. A debatable application still applies; note the doubt in one sentence of the narrative.
- A ruling may be recommended. Where the resolution is a judgment call, the verifier writes the resolution it judges best serves the project's intent as a `> Recommended ruling (/verify-issues): …` blockquote with a brief rationale, followed by an owner comment. Files from earlier layouts may attribute the marker to a retired `/recommend-rulings` verb; read them identically. Silence accepts: untouched, the recommendation is a ruling, and the next `/plan-sprint` names the batch in one sign-off line. The owner may delete the marker to adopt it, edit it to redirect, or empty the section to discuss live. A recommendation never overwrites owner text, a generated ruling, or another recommendation.
- Status moves forward only. `open` → `verified` (verifier) → `promoted` (planner stamps `status` and `sprint` at sign-off; the file moves to `history/issues/` when the sprint's implementation closes) or `retired` (planner records the owner's reason under Ruling and moves the file at once). The verifier's one closure is `answered`: the corpus decides the question, or the filed gap no longer exists. The narrative cites the deciding artifact and section, and the file moves to `history/issues/`. A rules-determined fix is not a closure; it stays open under a generated ruling. Files in `history/issues/` may carry `repaired`, a retired terminal status; read it as closed and never write it. Never delete an issue file.
- Writers file; only the owner closes. `promoted` and `retired` are stamped only from a `/plan-sprint` session. The verifier's `answered` cites owner-approved corpus and reports the list for veto. Anything else the verifier is certain of becomes a generated ruling, never an edit.
- `sprint:` names the handoff. Once stamped, the sprint is the source of truth; nothing reads the issue file to learn how the work went.
- The sprint gate is relevance-scoped. A `/plan-sprint` planning new work drafts it first, then resolves with the owner every open, unruled issue that bears on the draft — one whose answer the work would otherwise encode silently. Independent issues stay open. A sprint convened to work the intake takes it, or a named batch, as its scope.
- Legacy `issues.jsonl` is read-only history. It is an append-only event log (`open` / `promote` / `retire`; legacy `resolve` is terminal on read). The verifier converts it: each open id becomes an issue file (`status: open`, `opened` from the row's `at`), and the log moves to `history/issues.jsonl`. Never edit or append to the log.

---

### {{MECHANICAL-VS-JUDGMENT-RULE}}

Whether an agent fixes a finding or the owner rules on it turns on intent, not on which file the fix touches.

- **Mechanical** — the corpus's commitments, the authoring rules, and the code determine the compliant end state, and reaching it changes only how a commitment is expressed. A code-side repair and a corpus-side repair are equally mechanical. Whoever holds the finding fixes it in-cycle. Nothing is filed.
- **Judgment** — the fix would change what the project commits to, promises, or forbids: a retirement, a rewritten Choice, an invariant added or dropped, a claim widened or narrowed, restore-vs-deprecate. Also any finding whose end state the corpus, rules, and code do not decide. An agent never fixes these; they go to the intake. A reviewer never files alone: inside certification, the architect promotes after the fixer's kickback survives its adversarial check; outside it, a human files.

The test per finding: would any reasonable fix change what the project commits to? No → mechanical, fix it. Yes, or unsure → judgment, file it. "The fix touches `design/`" is never a reason to file. A finding with nothing decidable to do dissolves per `{{DECIDABILITY-BOUNDARY}}`.

---

### {{DECIDABILITY-BOUNDARY}}

Every story, and many a decision rationale, mixes two kinds of clause:

- **The mechanical core** — clauses with a decision procedure: a population is covered, a verb answers, a value round-trips, a file exists. Tests exercise these, audits determine them, findings rest on them.
- **The qualitative rim** — clauses whose truth is a human quality judgment: correct (of prose), canonical, clear, helpful, complete (of explanation), useful, intuitive, well-designed. No procedure settles them.

Rules:

- Write the concrete version first. Restate a rim clause as something observable, per `{{STORY-DEFINITION}}`. What survives is residue a human discipline owns; the process records it and does not rule on it.
- No determination rests on the rim. An audit rules a rim clause neither supported nor unsupported. No test obligation extends to it. A finding grounded only in it dissolves and never reaches the intake.
- The line is the existence of a decision procedure, not difficulty. "Hard to test" is not qualitative. A coverage claim is mechanical however large the population. Classifying a decidable claim as qualitative to escape work is itself a finding.
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

One audit file per live artifact of every estate, at `<estate>/audits/<bucket>/<slug>.md`: `.ok-planner/audits/{concepts,stories,decisions}/<slug>.md` mirrors `.ok-planner/design/{concepts,stories,decisions}/<slug>.md`.

Rules:

- Only the periodic audit run writes audits. Never the implementing session, never by hand, never patched. Each run rewrites every audit whole.
- `implementation:` is `supported` or `unsupported`. `supported`: the codebase carries what the artifact claims. `unsupported`: it does not, and the audit says what is absent. Where the artifact's text does not settle what would count as support, the verdict is `unsupported`. The initial auditor may reach either; `unsupported` escalates to the judge, the only writer that finalizes it.
- The instrument differs by kind. A story's support is passing runs of the maintained experiments through the public surface the extraction records — never a reading, never a test. A decision's support is an adversarial reading of the claim against the code. A concept's support is the vocabulary reading: the concept has one live name, and the sites that cite it and the code around them agree with its What it is and its Boundaries. A concept's Purpose carries no determination.
- `text:` is `compliant` or `noncompliant`, and independent. `noncompliant` adds a `## Compliance` section naming the rule and the compliant text. A text defect is mechanical. It never changes the implementation verdict.
- One sentence to one paragraph: the verdict, then what was looked at, broadly. Present tense. No history, prior verdicts, hypotheticals, or speculation.
- Every universal comes back as a count and its population. For every, all, each, never, none, only: report the number checked and where the set came from. This shape belongs to the audit record. An issue filed from an audit names the member that breaks the rule, not the population.
- A coverage claim takes the coverage shape. Where the artifact names an enumerable population and claims all of it, frontmatter carries `checked:` (population size, enumerated from reality) and `unaccounted:` (members nothing accounts for), and `## Unaccounted` names each. `unaccounted: 0` and `supported` agree.
- No citations, line numbers, hashes, pasted code, or per-evidence paths. A path appears only to name a population, an unaccounted member, or a remediation site.
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

## Remediation

<Coverage-shaped audits only, optional: members accounted for that
depart from what accounts for them. One line each. Work for planning,
never intake questions.>

## Referrals

<Only when the artifact promises something a human discipline owns.
Fixed grammar:>

- referral: <the promised thing, one line>
  established: <what exists in form, and how it was confirmed>
  discipline: <documentation | editorial | ux | human-review | <other>>
```

---

### {{ANNOTATION-INTEGRITY-RULE}}

`@concept:<slug>`, `@story:<slug>`, and `@decision:<slug>` link code to the corpus. Each slug resolves to a live artifact of the named kind under `design/<kind>s/<slug>.md`. The slug is the artifact's exact filename basename; a paraphrase is dangling.

Two failures:

- **Dangling** — no artifact of any kind has the slug. Rename the annotation to the canonical slug, or drop it if the artifact is gone.
- **Kind-mismatch** — the slug exists at a different kind. Rename the annotation to the artifact's kind.

`/audit` checks the whole corpus with `rg -n '@(concept|story|decision):\s*\S+'`. Both failures are mechanical: fix in-cycle, then re-run.

---

## Anti-padding

- File no issue a `_discover/` topic already makes clear.
- One issue file per genuine muddiness. Do not merge issues that share only a category.
- Do not grade severity.
- One file per artifact. Merge duplicates.
- Do not invent stories the product does not deliver or decisions the project has not made.

<!-- Materialized by ok-planner v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
