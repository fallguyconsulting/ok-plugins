# Documentation sprints — Design Sketch

**Date:** 2026-10-18
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Take documentation writing out of sprints and give it a ceremony of
its own, on the sprint model. Sprints keep declaring what
documentation the project keeps and what its public surface is.
`/plan-docs` plans a **documentation sprint** with the owner, and the
documentation sprint runs unattended under `/goal`, on the task
tracker. Separate agents write the documentation. The owner starts
`/plan-docs` on their own schedule, usually before a release. The
work cycle becomes: one or more sprints, then a test sprint, then a
documentation sprint. `/converge` stays an ad hoc check of the whole
project.

Each docspec gets a shape copied from a suite template, and each run
checks every document against that shape. A cold style pass reads
each document the run created or changed. A fact loop then checks
every claim against the tree, running examples where it can, until
every claim holds. A claim ledger and a stamp per docspec keep a run
cheap: a run checks again only the claims whose source changed.
Documentation that lives in code, as doc comments, gets a docspec of
its own, and that docspec grants the lint's carve-out from the
comment rule.

Builders never write documentation. The docspec back-out sprint
introduced that rule through `decision:sprints-write-the-documentation`,
and it was a mistake.

## Shape

### Declaring the public surface

- **Nothing is public by default.** The surface intent lists only
  what the owner declares public. It does not track what is internal:
  module interfaces, internal APIs, and CLI tools are internal unless
  declared.
- **Only the owner declares a surface.** A new feature never makes an
  element public by itself. Today `{{OWNER-QUESTION-TEST}}` item 4
  asks the owner about each unclaimed new element. That question goes
  away: an unclaimed element is internal. A new element under a class
  already declared, such as a new verb on a declared CLI, is public by
  that class's rule.
- **Surface rules are prose and general.** "Every endpoint in the foo
  API." "Every command `bar.sh` exposes." "Every endpoint in the foo
  API except the routes under `/tables`." A rule names single members
  only where no general rule can say it. This is the surface intent
  `decision:surface-intent-is-one-prose-document` already describes.
- **Declaring a docspec opens the surface question.** In
  `/plan-sprint`, a new docspec delta leads to one question: what
  surface does this documentation describe? The answer becomes a
  surface intent delta in the same sprint.
- **Every surface has a reference docspec.** When a surface intent
  delta declares a class no docspec lists, planning drafts a reference
  docspec delta for it, from the reference template, as a call. The
  compliance review refuses a sprint that leaves a public class with
  no docspec whose `## Lists` names it. A guide or a tutorial docspec
  does not count.

### Docspec shapes

A docspec describes a kind of documentation, usually a section of
several files, not one file, and never single features inside it. Its
shape has two levels:

- **The layout**: how the section's files split up, such as one file
  per CLI tool. `## Where` already states this today, in the lines
  after its path.
- **The file shape**: one file's parts, in order. This is a new
  section, `## Shape`.

The suite carries a few shape templates, suite-owned, materialized
under `.ok-planner/docs/shapes/`:

| Template | Layout | One file's shape |
|---|---|---|
| Reference | one file per declared class | one entry per public element: what it does, inputs, outputs, errors, one example |
| Tutorial | one file per lesson, in order | goal, what you need, numbered steps, what you should see |
| How-to | one file per task | the task, the steps, the result, common failures |
| Overview | one file, or one per subsystem | what it is, its parts, how they fit, where to go next |

When planning adds a docspec, it proposes the template that fits, and
the owner adjusts it. The docspec copies the shape. It never names the
template, so a suite update cannot change a project's documentation
shape without a sprint.

Once the owner approves a document of a docspec, that document
becomes the docspec's worked example. The style pass uses it as its
model, as triage's clarity pass uses the issue the owner approved.

### `/plan-docs` and the documentation sprint

The third ceremony of one pattern:

| | `/plan-sprint` | `/plan-tests` | `/plan-docs` |
|---|---|---|---|
| Reads | the owner's goals, the intake, out-of-band work | what changed since the last test sprint | what changed since each docspec's stamp |
| Produces | a sprint | a test sprint | a documentation sprint |
| Folder | `sprints/` | `test-sprints/` | `doc-sprints/` |
| Execution | build tasks, then certification | the test loop, until every test passes or needs judgment | write, style pass, fact loop, until every claim holds |
| Stop command | `review certified` | `TESTS COMPLETE` | a fixed line once every docspec in the plan carries a fresh stamp |

**Planning.** `/plan-docs` runs step 1 below, the window, and writes a
documentation sprint with fixed boilerplate. The plan lists one item
per file to write or change, each with the rules that fire on it, and
the claims the ledger says to check again. The session asks the owner
little, because sprints already settled the docspecs and the surface.
It asks two kinds of question:

- Approval of each docspec's first document as its worked example.
  The planning session shows the owner the document a past run wrote,
  or a draft of one entry in the shape.
- A change in the window whose intent no sprint explains.

The owner approves the plan once, as with a sprint. The separate
folder keeps `/plan-sprint`'s reconcile baseline correct, as for test
sprints.

**Execution.** The executing session files small tasks on the task
tracker: one writer task per file, one style task per changed file,
and checker tasks over batches of claims. Every agent of a profile
starts from one identical message, so each profile shares one cached
prefix. The drain loop drains them. The session states the stop
condition in its first message, as feature sprints do with `review
certified`.

The steps, planning's window first:

1. **The window.** For each docspec, the run reads the docspec's
   stamp: the commit at which its documentation last passed the fact
   loop. It takes each docspec whose references, declaring files, or
   docspec text changed since then. For intent, it also reads the
   sprints closed since the stamp: their work items, implementation
   notes, and rulings. A docspec with no stamp is new and gets written
   whole.
2. **Write.** A writer agent creates or updates each file the window
   reaches. It edits a file only when one of these rules fires, and
   each edit names its rule:

   | Rule | Edit |
   |---|---|
   | A claim is false against the tree. | Rewrite the claim to match. |
   | A public element of a class the docspec lists is missing. | Add an entry in the shape. |
   | An element the surface intent keeps internal appears. | Remove it. |
   | A sprint in the window changed what a user can do through the docspec's references, and the text doesn't say so. | Add or change the text that covers it. |
   | A file departs from the shape or the layout. | Restructure it. |
   | A claim the tree cannot settle, such as one about speed or an outside service. | Cut it. |

   Every other sentence stays as written.
3. **The style pass.** For each file the run created or changed, an
   agent that did not write it reads it once, cold, and revises it
   against the docspec's shape, its worked example, and the writing
   standard. The pass checks:
   - Each section opens with its point.
   - Each term is defined where it first appears.
   - Each fact appears once, in the section that owns it.
   - A revision never makes a section longer than the facts it adds.

   Nobody sends a taste finding back. The pass stamps each file with
   a digest of its text, so the next run reads the file again only
   once its text changes.
4. **The fact loop.** A checker that is not the writer checks every
   claim against the tree. A claim is a sentence that says what the
   project does, accepts, returns, prints, or requires. The checker
   uses the strongest check it can:
   1. **Run it.** Every example runs, every command and code sample,
      in a scratch project or a stack run, and the output must match
      what the document shows.
   2. **Ask it.** A claim about a flag or an option is checked
      against the program, through its `--help` or its argument
      parser.
   3. **Read it.** Any other claim is checked by reading the code it
      describes, and the checker names the symbol it read.

   Every link must resolve, to a file, a heading, or another
   document. The checker sends each false claim to the writer and
   checks the rewrite. The loop has no cap. A document makes a finite
   number of claims, and the code holds still while the run works, so
   the loop ends when every claim holds or is cut.
5. **The claim ledger.** The run writes a ledger beside each docspec:
   each claim, its source, and the commit at which it held. The
   ledger is generated and readers never see it. The next run checks
   again only the claims whose source changed since that commit, plus
   every claim in a file the run rewrote.
6. **The close.** The run stamps each docspec with the commit, and it
   reports each edit with its rule and each claim it cut. The stop
   command prints its fixed line when every docspec in the plan
   carries a fresh stamp. The close stamps the archived documentation
   sprint with `closed: <sha>`.

The run changes no code but doc comments, so it cannot break a test.
That is why it runs after the test sprint.

### In-code documentation

An in-code docspec's `## Where` names the files that declare a surface
class, such as the foo API's route handlers. A new line names the
tool that turns doc comments into a document, such as `go doc` or
`typedoc`, and where its output goes. The shape is the reference
entry shape, written as doc comments on each public element. The
documentation sprint writes and checks those doc comments like any other
document. Running the generator must succeed. A doc comment on an
internal element gets removed.

The lint's carve-out moves from the file to the docspec. Today the
lint allows JSDoc-style and Go-doc-style comments only in a file that
holds the marker `@plumbline:allow-docstrings`, and nothing says who
may add the marker. Instead, the lint allows doc comments in the
files an in-code docspec's `## Where` covers. It reads those files
from the docspec index `catalog-toc` writes. The marker retires. Only
an approved sprint can declare a docspec, so only an approved sprint
can open the carve-out.

### What leaves the sprint

- The documentation rule in the build prompt (`{{DOCUMENTATION-RULE}}`
  in `skills/_sprint/shared.md`).
- The "Update the documentation per docspec" work items, and the
  docspec match in code planning (step 8 of `{{CODE-PLANNER-PROMPT}}`).
- Certification's documentation pass, and its finding C5,
  "Documentation off its docspec".
- The docspec references that make planning add a work item.
  `## References` stays, as what the documentation sprint reads to
  choose its window.

Sprints keep the docspec deltas, the surface intent deltas, the
template proposal, the surface question, and the reference-docspec
check.

### Corpus changes

- `decision:sprints-write-the-documentation` is retired. A new
  decision says that a documentation sprint writes all documentation, after
  the code settles, with stamps.
- `decision:out-of-band-documentation-reconciled` gets narrowed. The
  documentation sprint's window catches out-of-band code changes through
  the stamps. A person's direct edit to documentation is still
  reconciled at planning.
- `{{DOCSPEC-DEFINITION}}` and `{{DOCSPEC-TEMPLATE}}` in
  `skills/_shared/artifact-definitions.md` gain `## Shape`, the
  in-code generator line, and the stamp. Their sentence "a sprint's
  builders write them after the code they describe" goes.
- `{{OWNER-QUESTION-TEST}}` item 4 goes. An unclaimed element is
  internal.
- The plumbline cheatsheet's docstring paragraph names the docspec
  as the carve-out.

## Open questions

- **Where stamps and ledgers live.** Options: in the docspec's
  frontmatter, which makes owner intent carry run state; or in a
  generated folder such as `.ok-planner/docspec-runs/`, committed.
  The second keeps the docspec owner-only.
- **The style pass digest.** One digest per file, stored in the
  ledger, or one per docspec.
- **Shared boilerplate.** Three ceremonies now share a shape: the
  window, the plan, the boilerplate, the stop command, the archive,
  and the `closed:` stamp. The shared parts belong in one place, such
  as `skills/_sprint/shared.md`, or the three will drift apart.
- **The concept.** `concept:sprint` needs a boundary line for both
  test sprints and documentation sprints: sprints that change no
  corpus, planned by their own ceremony.
- **Builders and doc comments.** Builders must not write doc comments,
  but nothing stops them. A change-scoped lint check, like
  `no-tests`, could flag a doc comment added outside a documentation
  run.
- **Generated output.** Whether the in-code generator's output is
  committed, or built at release.
- **Projects with documentation but no surface.** A tutorial docspec
  over internal behavior is allowed. The reference rule binds only
  public classes.

## Risks / unknowns

- **Running examples needs a stack.** Examples against a web API need
  the stack tool and a seeded state. Some examples may only be
  readable, not runnable.
- **"A claim the tree cannot settle" can be abused.** A checker could
  cut a hard claim instead of checking it. The run's report lists
  every cut claim, so the owner sees them.
- **Docs lag between runs.** Between documentation sprints, the
  documentation may be stale by design. A release step should refuse
  to cut a release while any docspec's stamp is older than the code it
  references.
- **Templates may not fit.** A project whose documentation fits no
  template adjusts one at declaration. The adjusted shape is the
  docspec's own, so this costs one conversation, not a new template.

## What this is not

- Not a review of taste. The style pass runs once per change, and
  nobody sends taste findings back.
- Not documentation for agents that have the source. Those agents read
  the corpus, the code, and the rules.
- Not a release step. `/plan-docs` is the owner's to start. A release may
  check its stamps.
