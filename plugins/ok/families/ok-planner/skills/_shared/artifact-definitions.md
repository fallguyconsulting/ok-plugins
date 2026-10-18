# Shared artifact definitions

This file defines the artifacts ok-planner skills produce and consume — concept, story, decision, docspec, surface intent, issue, and corpus delta — and the rules that govern their bodies. Skills read it and never restate it. Change wording here only.

## What `.ok-planner/design/` holds

The corpus is the project's durable model: what the project is and what it owes its users. Its three artifact kinds:

- **Concepts** define the load-bearing nouns: what kind of thing exists, not which instances exist now.
- **Stories** state durable user expectations: what the product owes its users, never how it delivers it.
- **Decisions** record technical choices with real alternatives: the choice and the tradeoff, never the implementation.

Interface designs, route shapes, CLI grammars, schemas, and implementation diagrams live in code, sprints, and other documentation. The sign-off review flags them in a delta.

Two kinds of owner intent sit beside the corpus, outside `.ok-planner/design/`: the **docspecs**, one per kind of documentation the project keeps, and the **surface intent**, which declares the project's public surface. Each changes only through a sprint's delta, like the corpus.

**Issues** are questions about the corpus awaiting a person's ruling. They live in the intake: one record per open issue in `.ok-planner/issues.jsonl`, and one per closed issue in `.ok-planner/history/issues.jsonl`. `.ok-planner/bin/issues` is the only writer of both files.

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
- State an outcome a reader can settle by observing it. Concreteness is about the outcome the user gains, never about the surface that delivers it. Correct, clear, helpful, intuitive describe how well the product delivers, not what it delivers. Rewrite them as what the user can now do: write the concrete version per `{{DECIDABILITY-BOUNDARY}}`.
- A story carries no `Proof:` field. The code that realizes a story carries `@story:<slug>`.
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
- Code that enforces the choice carries `@decision:<slug>` at the point of enforcement.
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

### {{DOCSPEC-DEFINITION}}

A **docspec** is the owner's declaration of one kind of documentation the project keeps: where it lives, whom it is for, what it covers, which parts of the project it describes, the shape of its files, and, for reference documentation, which classes of public surface it lists in full. A docspec describes a kind of documentation, usually a section of several files, never the single features within it. It carries the order, never the text: the documentation is the files under its `## Where`, and only a documentation sprint writes them, after the code they describe settles.

- Documentation in a docspec's sense is for humans, or for agents that use a deliverable shipped without its source. An agent working with the source reads the design corpus, the code, and the rules, and no docspec governs documentation for that agent.
- A docspec is owner intent, like a corpus artifact. It changes only by applying an approved sprint's docspec delta, save true-up's migrations, which change no commitment. It is not part of the design corpus: the corpus says what the product is and owes, and a docspec says what one kind of documentation tells its reader.
- Each docspec is one file, at `.ok-planner/docspec/<slug>.md`. `.ok-planner/bin/catalog-toc` writes the docspec index `.ok-planner/docspec.md`, one line per docspec giving the first line of its `## Where` and its `## References` bullets, comma-joined. The lint reads each index line whose Where starts `in code:`. The index is generated: the next run discards a hand edit.
- `## Where` opens with the path: one file, a folder ending in `/`, or, for documentation that lives in code as doc comments, `in code:` followed by one or more backticked paths or globs from the project root, comma-separated. For a folder, the lines after the path say how its files are laid out. The index shows the first line, so the path stands alone on it. The lint allows a doc comment on a declaration only in a file an `in code:` line names, or in a file whose opt-in marker an earlier release committed; it refuses a marker an edit adds.
- `## Reader` names whom the documentation is for and what that reader already has.
- `## Covers` names what the documentation tells its reader and what it leaves out.
- `## References` lists one bullet per part of the project the documentation describes: `concept:<slug>`, `story:<slug>`, `decision:<slug>`, or a backticked code path or glob from the project root. A change to a reference since the docspec's stamp puts the docspec in the next documentation sprint's window.
- `## Lists` appears only in a docspec for reference documentation. It names one class of public surface per bullet, in the surface intent's terms: a class whose rule makes its members public, or one whose exceptions make a member public. The documentation sprint lists every public element of each class from the tree as it stands, starting from the files the surface intent names as declaring the class, and lists no element the intent keeps internal: for a class its rule makes public, every member but those its exceptions make internal; for any other class, only the members its exceptions make public. A change to the surface intent, or to a file it names as declaring a listed class, puts the docspec in the window.
- `## Shape` gives one file's parts, in order, and what each part holds. Planning copies it, with the layout lines under `## Where`, from a shape template under `.ok-planner/docs/shapes/` when it declares the docspec, and the owner adjusts both. The docspec never names its template, so a suite update never changes a project's shape. A documentation sprint checks every file against the shape and the layout.
- `## Generator` appears only in a docspec whose Where starts `in code:`. It names the command that builds a document from the doc comments, where its output goes, and whether the output is committed, or says `none` where readers read the comments in place. A documentation sprint runs the command, and the command must succeed.
- `## Notes` is optional. It carries the owner's standing instructions to the writer: an outline, a passage to keep verbatim, a thing to leave out.
- The body holds these sections in this order and no other.
- A docspec's run state is not owner intent, and lives apart from it, in `.ok-planner/doc-state/<slug>.json`, which only `.ok-planner/bin/docs` writes: the **stamp**, the commit at which its documentation last passed a documentation sprint; the **claim ledger**, each claim the documentation makes, the files it rests on, and how it was checked; and the **worked example**, the document the owner approved as the model for the style pass.

---

### {{DOCSPEC-TEMPLATE}}

Write each docspec to `.ok-planner/docspec/<slug>.md`. The slug names the kind of documentation.

```markdown
---
docspec: <slug>
---

# <Name of this kind of documentation>

## Where

<The path, alone on this line: one file, a folder ending in `/`, or
`in code:` and the backticked paths or globs whose doc comments are the
documentation.>
<For a folder: how its files are laid out.>

## Reader

<Whom the documentation is for, and what that reader already has.>

## Covers

<What the documentation tells its reader, and what it leaves out.>

## References

- concept:<slug>
- story:<slug>
- decision:<slug>
- `<code path or glob>`

## Lists

- <class of public surface, as the surface intent names it>

## Shape

<One file's parts, in order, and what each part holds, copied from a
shape template under `.ok-planner/docs/shapes/` and adjusted.>

## Generator

<The command that builds a document from the doc comments, where its
output goes, and whether the output is committed; or `none`.>

## Notes

<Standing instructions to the writer. Omit the section when there are none.>
```

Omit `## Lists` for documentation that is not reference documentation, and `## Generator` for documentation that does not live in code.

---

### {{SURFACE-INTENT-DEFINITION}}

The **surface intent** is the project's declaration of what its user-facing surface is meant to be: which modules, services, or paths are user-facing at all, and which of their elements are public. It is owner intent and the source of truth for the public surface. Every question about the public surface routes back to it.

- It is one prose document, at `.ok-planner/surface/surface.md`, of class rules with named exceptions: which classes of element are public, and the specific elements that depart from those rules. A rule is general, such as every endpoint of one API, or every command one script exposes, and names a single element only where no general rule can say it. It states intent, never an inventory of elements.
- Nothing is public until the owner declares it. The intent names what is public, never what is internal: an element no rule or exception makes public is internal. A new element joins the surface only where a rule already makes its class public, such as a new verb on a declared command.
- It changes only by applying an approved sprint's surface intent delta, save true-up's migrations, which change no commitment. Only the owner declares a surface. Declaring a docspec opens the question: planning asks the owner what surface the documentation describes, and the answer becomes a surface intent delta in the same sprint.
- Every class a rule makes public, and every class an exception draws a public member from, has a reference docspec whose `## Lists` names it. Where a surface intent delta declares a class no docspec lists, planning drafts that docspec from the reference shape template as a call.
- Its last section, `## Where each class is declared`, names, for each class of entry point, the files that declare the class's members, such as a command table or a route table. Each line reads `` - <class>: `<path or glob>`[, `<path or glob>`] ``, the class named as the rules above it name it, each path or glob from the project root. `/converge` in `analysis` mode cuts one flow area per declaring file on each run, and skips a line in any other form.
- Nothing stores the surface's members: no extraction, no map, no index of entry points. Whoever needs a class's members lists them from the tree at that moment, starting from the class's declaring files: a documentation sprint's writer, as it writes reference documentation, and its checker, to check the documentation misses no public element and lists no internal one. The class's rule and the intent's exceptions decide which members are public. A reference docspec's `## Lists` names classes in the intent's terms.

Write the surface intent to `.ok-planner/surface/surface.md`.

```markdown
# Surface intent

## What is user-facing

<The modules, services, or paths a user reaches at all, and what lies
outside the user's view.>

## Classes

<One rule per class of element the owner makes public, stated
generally.>

## Exceptions

<Each specific element that departs: a member of a public class kept
internal, or one element made public where no class rule can say it.
Omit the section when there are none.>

## Where each class is declared

- <class>: `<path or glob>`[, `<path or glob>`]
```

---

### {{CORPUS-DELTA-FORM}}

A **corpus delta** is one change to the design corpus, the coding standards, a docspec, or the surface intent, carried in a sprint under a heading naming the operation and the target: `### New story: <slug>`, `### Amend concept: <slug>`, `### Retire decision: <slug>`. Sprint deltas are the only way any of them changes what it commits to; true-up's migrations change no commitment.

- A concept, story, or decision delta lands under `.ok-planner/design/`. A subject or practice delta (`### New practice: <slug>`) lands under `.ok-planner/subjects/` or `.ok-planner/practices/`. A docspec delta (`### New docspec: <slug>`, `### Amend docspec: <slug>`, `### Retire docspec: <slug>`) lands at `.ok-planner/docspec/<slug>.md`. A surface intent delta (`### New surface intent`, `### Amend surface intent`) lands at `.ok-planner/surface/surface.md`; the project holds one surface intent, so its heading names no slug.
- Applying any delta but a surface intent delta includes regenerating its collection's catalog TOC with `python3 .ok-planner/bin/catalog-toc`: `.ok-planner/design/concepts.md`, `stories.md`, or `decisions.md`, `.ok-planner/subjects.md` or `.ok-planner/practices.md`, or the docspec index `.ok-planner/docspec.md`.
- Every delta is a complete final-form body. A new artifact and an amendment carry the whole file per the templates above, a subject or practice per the templates in `.ok-planner/practice-definitions.md`. A retirement carries only its heading; execution deletes the file. There is no diff form and no base pin. Author an amendment by editing the artifact during planning and carrying the whole result. Application is a copy. The completion contract's first item is a file comparison.
- Long bodies go in a sidecar, one file per artifact, and the sprint heading reads `body: in the sidecar`: `.ok-planner/sprints/<sprint-name>-deltas/<kind>s/<slug>.md` for a corpus artifact or a coding standard, `<sprint-name>-deltas/docspecs/<slug>.md` for a docspec, and `<sprint-name>-deltas/surface/surface.md` for the surface intent. The sidecar is part of the sprint: sign-off reads it, execution copies from it, close-out archives it. Inline bodies are the norm.
- Review reads each body whole: form, claims, coherence with the live corpus. Whether an amendment drops something silently is the reviewer's judgment against the live artifact. Sprint certification (`/converge sprint`) then checks the applied corpus against the deltas by file equality, and lands each delta whose artifact does not match, by the same copy. There is no mechanical derivation check.

---

### {{ISSUE-DEFINITION}}

An **issue** is one record in the intake. Most issues are **judgment issues**: a question about the corpus or the tooling that needs a person's judgment. A **defect issue** is the other kind: a harm the accept list at `.ok-planner/review/catalog/accept.md` covers, at a named site, for the next `/converge` to fix. The "Defect issues" section of `.claude/rules/ok-planner-cheatsheet.md` carries the defect issue's filing, verifying, routing, and closing rules. Categories:

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
- `upstream` — a harm whose fix lies in a part the project does not own: a suite-owned file (one `/ok` overwrites on every true-up), a library the project depends on, an outside tool or service, or the suite's accept list itself, for a harm the list does not name. Its `upstream` field carries a draft ready to file with the part's maintainers. It stays in the intake while the project still shows the harm, and the next `/plan-sprint` walks it with the owner.
- `other` — a judgment item none of the above fits.
- `defect` — a defect issue, as above.

Judgment items and defects outside a run's scope become issues. Fix mechanical findings in-cycle and file none.

An issue carries its **discussion**: the comments and rulings people write, and the replies and updates agents write: the replies and updates `/triage-issues` writes in answer, and the update any agent writes when it revises a routed or ruled issue. A comment is not a ruling. Any person who works the intake comments or rules, and the latest ruling stands. A person questions or corrects an issue's analysis by commenting on the issue, and the next `/triage-issues` run answers on the issue itself, so every later reader sees the answer.

The intake is a queue, not a work tracker. A judgment issue closes three ways, each an owner act recorded through `/plan-sprint`:

- **Promoted** — the ruling is carried into a sprint as a delta, a work item, or both, and the record's `sprint` names the sprint's file. The sprint is then the source of truth. The record closes as `promoted` when the sprint closes. A later sprint never reopens a promoted issue; a wrong outcome is a new issue. An upstream issue the owner answers with a workaround closes this way, and one the owner answers with both a workaround and a filing closes this way with the ruling naming where it was filed.
- **Answered upstream** — the owner files an upstream issue's draft with the part's maintainers. The ruling names where it was filed, and the record closes as `answered` at once.
- **Retired** — the owner drops the question. The record closes as `retired`, with the owner's reason, at once.

`/triage-issues` closes an issue the code, the corpus, or the tooling already settles as `answered`, and retires a defect claim no accept-list entry covers. It leaves an upstream issue open while the project still shows the harm, and closes it as `answered` once the harm is gone, as after an update of the foreign part. A defect issue closes through `/converge`: `fixed` when the run verified the fix, `answered` when the code no longer shows the defect. A defect issue the owner picks into a sprint closes as `promoted`.

Life of a judgment issue: filed → triaged → ruled → promoted or retired. Life of an upstream issue: filed → triaged → filed upstream (answered), promoted, or answered once the harm is gone. Life of a defect issue: filed → triaged → fixed, answered, or promoted.

---

### {{ISSUE-FILE-FORMAT}}

The intake is two JSON Lines files with one record per line. `.ok-planner/issues.jsonl` holds the record of every open issue, and `.ok-planner/history/issues.jsonl` holds the record of every closed one. `.ok-planner/bin/issues` is the schema's authority and the only writer of both files. It reads every record that has an id, whatever else it holds: a field it does not know is kept as written, and a field it cannot read shows as empty. Only a line that is no record at all (not JSON, a line with no id, a duplicate) is skipped, kept in its file on every write, and named in a note on stderr. An earlier layout is not a stray line: where `.ok-planner/issues/` holds markdown issue files, or either file holds a pre-v9 event-log row, every verb but `issues import` refuses (exit 2), naming the file and saying to run `/ok`, which converts it. A record no write touches goes back to its file unchanged. It checks every record a write changes and refuses a schema defect the write introduced, naming the field. It runs every write under one lock, on the files as reread under that lock. Never edit either file by hand, and never write an issue as a markdown file. `.ok-planner/bin/issues --help` lists the verbs.

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

`artifacts` takes `concept`, `story`, `decision`, `subject`, `practice`, and `docspec` slugs. The module labels the options A, B, … and fills in the rest of the record:

| Field | Value |
|---|---|
| `id`, `title`, `kind`, `category`, `artifacts`, `problem`, `upstream` | As filed, and as the verifier rewrites them; `upstream` is null on any other issue |
| `options` | A list of `{"label", "text"}` objects |
| `route` | Null until `/triage-issues` routes the issue, then `upstream`, `defect`, `corpus`, or `question` |
| `recommendation` | Null, or `{"form": "generated" or "recommended", "text"}`: the verifier's marked ruling |
| `ruling` | Null, or `{"text", "at"}`: the words of the person who ruled last, and when that person gave them |
| `messages` | The discussion, below |
| `sprint` | The sprint's filename; present only once promoted |
| `source` | The markdown file a converted record came from; converted records only |
| `flagged` | When a person flagged the open issue for discussion in a session; absent otherwise, and dropped when the issue closes |
| `linked` | When `/triage-issues` last checked the issue's citations and links; absent until the first check |
| `issued` | The highest message number the record has issued, set when a person removes a message; absent until then |
| `opened`, `updated` | ISO 8601 UTC times ending in `Z` |

A record in the archive adds `closed` (the time), `closed_as` (`answered`, `retired`, `promoted`, or `fixed`), `reason` (required for `answered` and `retired`), and `fixed_by` (the `/converge` run; required for `fixed`).

An issue's **state** is computed, never stored: no route and no ruling is `open`; route `defect` is `verified`; any other route with no ruling is `needs-ruling`; a ruling is `ruled`; a record in the archive is `closed`. `issues list`, `issues show <id>`, and `issues history` read the intake; with `--json` they add `state`, `waiting` (no ruling, and either no route or a person's message triage has not yet seen), `unseen` (the people's messages triage has not yet seen), `unread` (the messages others wrote that the reading person has not read, per that person's ledger), `unopened` (true where the reading person has never read the issue), and `ruling_by` (the author of the current ruling message, or null). They mark `new` each message another person or an agent wrote on an open issue that the reading person has not read, and mark each person's message `untouched` where no one has answered it. `issues list --unread` lists every open issue where `unread` is above zero or `unopened` holds. Where no name resolves, `issues list` and `issues show <id>` count nothing unread and print one note on stderr saying how to set a name. Every surface that shows an update message shows its difference: `issues show` prints each revised field's word diff under the message, `show --json` and the dashboard's issue route add the diff's computed `parts` to each field, and the dashboard draws them.

The **discussion** is `messages`, numbered by `n`. A new message takes the number above every number the record has issued, a removed message's included, so no number is used twice. A person removes only a message of their own, and only one no one has answered: triage has never seen it and no reply names it. That removal leaves a gap in the numbers.

| `type` | Written by (`by`) | What it carries |
|---|---|---|
| `comment` | A person: the author's name | `text`; `seen`, null until triage acts on it |
| `ruling` | A person: the author's name | `text`, which also becomes `ruling`; `seen`, as for a comment |
| (either person's type) | A person: the author's name | once answered and then edited, `earlier`, its earlier texts, and `edited`, when; once answered and then removed, `withdrawn`, when, with its text kept |
| `reply` | `triage-issues` | `replies_to`, the people's messages it answers; `text` |
| `update` | `triage-issues` or `converge` | `changed`, the fields the same write rewrote; `diff`, each such field's value before and after, which the module records; `text`, one line saying what changed |

A person's name is the name that person configured outside every project (`issues name --set <name>` writes it), else git's user.name in the project root. No person signs with `triage-issues` or `converge`, the agents' names, or with `owner`. A message whose `by` is `owner` is a person's message from before names were recorded: it reads as a person's message, and no person's name matches it. A `read` key already on an agent message is retired: the module accepts it and keeps it as written, and nothing reads it.

The writers and their verbs:

| Writer | Verbs |
|---|---|
| A filer | `issues file --from -` |
| `/triage-issues` | `issues revise <id> --from -` routes an issue and rewrites its fields, its object carrying `by` and `text` on a routed or ruled issue; `issues respond <id> --from -` writes replies, an update, and seen marks in one write; `issues close <id> --as answered\|retired --reason <why>` |
| A person | `issues name [--set <name>]`, `issues rule <id> --text <words>`, `issues comment <id> --text <words>`, `issues edit <id> <n> --text <words>`, `issues remove <id> <n>`, `issues unrule <id>`, `issues flag <id>`, `issues unflag <id>`, `issues read <id>`, or the dashboard (`.ok-planner/bin/dashboard`); `issues read` and the dashboard's read write the person's own ledger, not the intake |
| `/plan-sprint` | `issues rule` to transcribe a ruling a person gives live, under that person's name; `issues promote <id> --sprint <file>`; `issues close <id> --as promoted\|retired\|answered` |
| `/converge`'s owner list | `issues revise`, its object carrying `by` and `text` on a routed or ruled issue; `issues close <id> --as fixed --fixed-by <run>` or `--as answered --reason <what it found>` |
| `/ok` | `issues import`, converting an earlier intake as a step of true-up's plan; `issues file --from -`, one issue per caller of a retired suite script that it cannot repoint, and one issue for a review facts file it cannot decode |

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
- Ownership follows the lifecycle. The filer writes the filed fields above. The verifier (`/triage-issues`) sets `route` and rewrites the filed body into the verified form below with `issues revise`; it may replace the title with a plainer one. Once it has routed an issue, the verifier changes it only through `issues respond`, whose `update` message records each field it rewrote before and after, so each person sees the change as new analysis and can read its diff. `issues revise` on a routed or ruled issue, by any agent, records an `update` message the same way, naming its writer in `by` and carrying the object's one-line `text`, and refuses a revision without them; a first routing and a change to link markup alone write none. A person alone writes `ruling` and comments; an agent session does so only to transcribe that person's words, under that person's name. The verifier never writes `ruling`, and `revise` and `respond` refuse it. A defect issue (`category: defect`) is the exception: `/converge`'s owner list closes it, or turns it into a judgment issue when its defect sticks, as the Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` says.
- Write `title` and `problem` under the technical-writing standard at `.ok-planner/docs/technical-writing.md`, in the shape the next rule gives, filed or verified. For a rule violation, the lead states the rule, then how the code breaks it. Call each thing what it is. Include a fact only when it changes how the reader judges an option. Name the member that breaks the rule, never the population that keeps it. Where any definition in this file conflicts with the technical-writing standard, the standard wins.
- The shape. An issue is written for an engineer who does not know the project and reads it once, cold. Its `title` names the cause in plain words, under about twelve, naming no project term but the part it concerns, such as `/converge`: what the project does or lacks that lets the harm happen, never the harm alone. Its `problem` is plain paragraphs with no section labels, in this order:
  1. The lead: the cause, then the harm it does and who sees it, in one or two sentences, using no term the reader has not been given. A reader who stops after the lead knows the issue.
  2. From the top: the context the reader needs, in the order things happen, then why the cause happens. Say only what a source shows about why. Define each project term in plain words where it first appears, and cite a slug only after the words it labels.
  3. What happened: the case that shows the cause, and the facts as the project stands now. Give dates and counts where they show how often or how much. Leave out run names, task ids, defect ids, and line numbers unless an option turns on one; a link on the words it supports carries the evidence.
  4. For a judgment issue, one sentence naming what the ruling decides. For a defect issue, the site as `path:function`, the accept-list entry, the trigger, and the evidence quoted from the code as it stands.

  The problem runs under about 250 words, and never longer than the text it replaces; a defect issue's site and evidence fall outside the count. `options` carry each real option with its one cost, and `recommendation` the marked ruling. The text uses a project term only where judging the ruling needs it, and restates nothing. Every sentence names an actor as its subject and the action as its verb, makes one claim, and reads one way on the first pass: a noun that can read as a verb, or a clause stacked on a clause, is rewritten. A recommendation states what to do and why, with the flip case; it carries no delta phrasing and no file paths. `/triage-issues`'s clarity pass holds every routed or ruled issue to this shape and checks its facts against the project as it stands.
- Links. A citation in `problem`, an option, the recommendation, or the `upstream` draft is a Markdown link whose target is the cited file's path relative to the project root, and whose text keeps the citation as written: `[decision:runs-fix-what-the-project-owns](.ok-planner/design/decisions/runs-fix-what-the-project-owns.md)`, or for code `[issues:rule](plugins/ok/families/ok-planner/scripts/issues#L612)`, `#L<n>` for a line and `#L<a>-L<b>` for a range. A concept, story, or decision cites `.ok-planner/design/<kind>s/<slug>.md`; a subject or practice `.ok-planner/<kind>s/<slug>.md`; a docspec `.ok-planner/docspec/<slug>.md`. Link only a file that exists; leave a citation you cannot resolve as plain text. `/triage-issues` writes the links and stamps `linked` once it has checked an issue's citations; `issues links --pending` lists the open issues never checked, holding a link whose file is gone, or linking a file changed since the check, and every `/triage-issues` run takes them. The dashboard opens a link in place.
- Evidence in `problem` may rot. A judgment issue's options as filed are durable corpus mutations, never file or symbol citations. A defect issue's one option is to fix its site, named as `path:function`, so the harm no longer follows.
- A set `ruling` is the ruled signal. The next `/plan-sprint` pulls every ruled issue in without re-discussion, asking only when it cannot understand a ruling. A later ruling replaces the earlier one.
- A recommendation may be generated. When the corpus and its authoring rules determine the one compliant resolution, the verifier writes it as `recommendation` with `form: generated`. The verifier never applies the fix. The recommendation names the fix concretely enough that `/plan-sprint` drafts it and execution applies it. An issue the rules do not determine gets no generated recommendation. An issue reducible to "should the docs follow the rules?" gets one. The authoring rules bind like lint: the verifier applies them and never adjudicates them. A debatable application still applies; note the doubt in one sentence of the narrative.
- A recommendation may be recommended. Where the resolution is a judgment call, the verifier writes the resolution it judges best serves the project's intent as `recommendation` with `form: recommended` and a brief rationale.
- Silence accepts a recommendation of either form: left standing, it becomes the ruling when the next `/plan-sprint` carries it, and that session names each form's batch in one sign-off line. Two exceptions hold it back. An upstream issue's answer is the owner's act, so silence accepts nothing there. A person's message triage has not yet seen holds back the recommendation on its issue. The next `/plan-sprint` walks each held-back issue with the owner. The owner rules to adopt the recommendation or to redirect it, and comments to discuss it.
- Every person's message starts with `seen: null`. `/triage-issues` marks a person's message seen only after acting on it, in the same write as its reply or update, so a run that dies midway leaves the message for the next run. Each person's reading lives in a ledger of that person's own under `.ok-planner/.cache/`, which git ignores, so one person's reading never clears another's unread marks. A ledger starts with everything that exists counted as read. `issues read`, and opening the issue on the dashboard, write the reading person's ledger and no intake file, and mark every message on the issue read; filing, `show`, and every other verb mark nothing read. Every message on an open issue but the reading person's own stays unread to that person until that person next reads the issue. A message counts once, by its number: an edit or a withdrawal of a message the person already read does not count it again. Every write a person makes is signed with that person's name, and refuses with the step that sets one where no name resolves. The module refuses a person's message on a closed or promoted issue, and an empty text. A ruling equal to the issue's current ruling writes nothing. A person edits, removes, or withdraws only their own messages, matched by name; a message another name signs, `owner` included, stays as written, and the person comments or rules again instead. An unanswered message changes in place with no trace; an answered one keeps its earlier text under `earlier`, and an edit sets `seen` back to null so triage answers the new text, while a removal marks it `withdrawn`. Editing or removing the message that holds the current ruling changes or clears `ruling`, and `issues unrule` withdraws the caller's own current ruling and clears it; a ruling another person wrote, or one no ruling message carries, is replaced by ruling again. A withdrawn message counts as nothing triage must see.
- State moves forward only. `issues close` moves a record from the live file to the archive. The planner stamps `sprint` with `issues promote` at sign-off and closes the record as `promoted` when the sprint's implementation closes. It closes a record as `retired`, with the owner's reason, or, for an upstream issue the owner files upstream, as `answered`, with the ruling naming where it was filed, at once. The verifier closes two ways, each with a reason that cites the deciding artifact and section. `answered`: the code, the corpus, or the tooling decides the question, or the filed gap no longer exists; for an upstream issue, only once the project no longer shows the harm. `retired`: a defect claim no accept-list entry covers. The verifier never closes a ruled issue. A defect issue closes as `fixed` or `answered` (`/converge`'s owner list). A rules-determined fix is not a closure; it stays open under a generated recommendation. Never delete a record.
- Writers file; the owner closes a judgment issue. `promoted`, an owner's `retired`, and an owner's filing upstream are recorded only from a `/plan-sprint` session. The verifier's `answered` and `retired` carry their reason, and its report lists them for veto. Anything else the verifier is certain of becomes a generated recommendation, never an edit.
- `sprint` names the handoff. Once stamped, the sprint is the source of truth; nothing reads the issue's record to learn how the work went.
- The sprint gate is relevance-scoped. A `/plan-sprint` planning new work drafts it first, then resolves with the owner every open, unruled issue that bears on the draft — one whose answer the work would otherwise encode silently. Independent issues stay open. A sprint convened to work the intake takes it, or a named batch, as its scope.
- Earlier layouts are converted, never edited. Markdown issue files under `.ok-planner/history/issues/` stay as written and read as closed, whatever their `status:`; read `repaired`, a retired terminal status, as closed too, and never write it. A project whose `.ok-planner/issues/` still holds markdown issue files, or whose `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl` holds the pre-v9 event log (`open` / `promote` / `retire` / legacy `resolve` events), converts it through the front door's administration (`/ok`): true-up converts it as steps of its plan, under the owner's one go-ahead, before any step that files an issue. The markdown conversion moves every markdown file to `history/issues/`, then imports a record for each open one, its owner's `## Ruling` text becoming `ruling` and its marked generated or recommended ruling becoming `recommendation`, and moves every file back if the import fails. A marker that names a retired `/recommend-rulings` or `/verify-issues` verb reads the same. The live log's conversion turns its event rows in place into open and closed records, and the archived log's conversion turns its closed issues into archived records. `issues import` is the converter's writer, which only true-up calls. Never edit or append to the log or the markdown files.

---

### {{DECIDABILITY-BOUNDARY}}

Every story, and many a decision rationale, mixes two kinds of clause:

- **The mechanical core** — clauses with a decision procedure: a population is covered, a verb answers, a value round-trips, a file exists.
- **The qualitative rim** — clauses whose truth is a human quality judgment: correct (of prose), canonical, clear, helpful, complete (of explanation), useful, intuitive, well-designed. No procedure settles them.

Rules:

- Write the concrete version first. Restate a rim clause as something observable, per `{{STORY-DEFINITION}}`. What survives is residue a human discipline owns.
- The line is the existence of a decision procedure, not difficulty. "Hard to check" is not qualitative. A coverage claim is mechanical however large the population. Classifying a decidable claim as qualitative to escape work is itself a finding.

---

### {{SELF-CONTAINMENT-RULE}}

Artifact bodies stand alone. The corpus owns the definition; code points at it with `@concept:`, `@story:`, `@decision:`, `@practice:`. A refactor that moves files does not invalidate an artifact.

This rule binds concepts, stories, decisions, and practices. It binds a subject except its `## How to find them`, which names the declarations, folders, and searches that enumerate the subject's population, as `.ok-planner/practice-definitions.md` requires. It does not bind a docspec, whose `## Where` and `## References` name paths by design, or the surface intent, whose `## Where each class is declared` names files.

- Frontmatter carries slug-form metadata only: `concept:` / `story:` / `decision:` / `subject:` / `practice:` and `aliases:`. No `references:` field, no paths.
- Allowed in bodies: other artifact slugs (`see also: <slug>`, `concept:<slug>`, `story:<slug>`, `decision:<slug>`, `subject:<slug>`, `practice:<slug>`); invariant IDs under the codebase's own convention.
- Disallowed in bodies: file or directory paths in any form; code citation forms and bare URLs; references to external documentation; quoted code, quoted lint allowlists, quoted external prose — state the property and let the code enforce it; "Owns / Does NOT own" sections naming code paths.
- A concept body does not enumerate its instances.
- A decision's Choice may name the artifact.

An artifact that cannot say what it needs without naming a file has a muddy boundary — file an issue — or carries material that belongs in `_discover/`.

---

### {{CURRENT-STATE-ONLY-RULE}}

Artifact bodies describe the project as it stands. Present tense.

This rule binds every artifact a sprint's delta carries: concepts, stories, decisions, subjects, practices, docspecs, and the surface intent.

- No history: no "changed on", "previously called", "used to live in", "see the spec that introduced this". No `## History` or `## Changelog` section, and no `## Notes` section but a docspec's, which carries the owner's standing instructions to the writer and no history; strip one where found.
- No roadmap: no "we plan to", "will be replaced by", "TODO", "out of scope for now", "deferred", "open question". Open ambiguities go to the intake; intended changes go to a sprint.

`_discover/` scaffolding is point-in-time and exempt. A sprint's delta rewrites the affected section in place.

---

## Anti-padding

- File no issue a `_discover/` topic already makes clear.
- One issue per genuine muddiness. Do not merge issues that share only a category.
- Do not grade severity.
- One file per artifact. Merge duplicates.
- Do not invent stories the product does not deliver or decisions the project has not made.
