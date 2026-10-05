# ok-planner Cheatsheet

Materialized by ok-planner v23.0.0. Suite-owned:
overwritten wholesale by the front door's administration (`/ok`);
project-specific rules belong in your own files under `.claude/rules/`.

The planner's estate lives in `.ok-planner/`; its embedded `CLAUDE.md`
carries the full per-directory rules. The short version every session
needs:

## The content kinds

- **`design/` — source of truth, read freely.** Concepts, stories,
  decisions: the project's durable model, same weight as code. What it
  commits to changes only by applying an approved sprint's corpus
  deltas; `/converge` and `/triage-issues` edit no corpus file. Code
  cites the corpus with
  `@concept:` / `@story:` / `@decision:` annotations, and rollout is
  incremental: consult an artifact while working on a file and leave
  the annotation — kind plus slug, at the load-bearing site — before
  you are done.
- **`issues/` — the intake.** One markdown file per issue: a judgment
  issue awaiting the owner, or a `category: defect` issue awaiting the
  next `/converge`, as "Defect issues" below says. Anyone may file one.
  `/triage-issues` makes each one ready for its next reader and ends it
  in a marked generated or recommended ruling the owner accepts by
  silence or overrides; it fixes nothing. A `/plan-sprint` session
  closes a judgment issue, **promoted** into that sprint (file stamped
  with the sprint's name) or **retired**. Closed files move to
  `history/issues/`. Unmarked Ruling text is the owner's alone.
- **`review/` — the review loop's estate.** `/converge` reads and
  writes it, and `/triage-issues` reads its accept list. `catalog/` is
  suite-owned; `config.json` and `project.md` are the owner's; `runs/`
  holds records, out of context by default.
- **`sprints/`, `sketches/`, `documentation/`, `history/` — records,
  out of context by default.** Do not read them to understand the
  project, include them in general exploration, or reconcile them with
  current code. A sprint is in context while you execute it, not
  otherwise. `sketches/` is speculative future thinking (written by
  `/sketch`). `documentation/` is the release-stamped corpus
  `/document` produces — a snapshot, never a source of truth, allowed
  to go stale — and so are the documents it maintains in the tree
  (under `docs/`, the root `README.md`), each opening with a
  provenance stamp; a document behind the tree files nothing and marks
  nothing, and the next `/document` revises it.
  `history/` is the archive: one same-named folder per artifact kind,
  preserved indefinitely. Touch records only when the user or an
  ok-planner skill directs it.
- **`subjects/`, `practices/` — the coding standards, read freely.**
  The project's own coding policies: a subject names an enumerable
  population of constructs, and a practice says what the code does
  about some of its members. Like `design/`, they change only by
  applying an approved sprint's corpus deltas, and code cites them with
  `@subject:` / `@practice:` annotations. Their TOCs, `subjects.md` and
  `practices.md`, are generated: `.ok-planner/bin/catalog-toc` rewrites
  them. `practice-definitions.md` carries the authoring rules, and
  `docs/` the suite-owned standards documents (`events.md`,
  `technical-writing.md`) that `.claude/rules/plumbline-cheatsheet.md`
  condenses.
- **`config.json` — the owner's configuration.** It turns each lint
  check on or off (`lint_checks`) and declares the citation tags, the
  test paths, the folders the project owns beside its root, and the
  port names `port-block` prints. The lint, `.ok-planner/bin/plumbline`,
  reads it, and so does its edit hook, `.ok-planner/hooks/post-edit.js`.
- **`bin/run-tag`, `bin/port-block` — per-run verification.** They mint
  a run's tag and read back its stack's ports, as "Per-run artifacts
  and verification stacks" below says.

## Lifecycle

`/sketch` captures an idea in `sketches/`; it authorizes nothing.
`/plan-sprint` produces a sprint in `sprints/` — corpus deltas, work
items, implementation notes, a fixed completion contract. It pulls
every ruled issue in without re-discussion, offers the open defect
issues for the owner to pick, resolves with the owner the unruled open
issues that bear on the work, and has a code planner write the
implementation notes against the release boundaries at
`.ok-planner/release-boundaries.md`. The owner approves once, at the
end. Executing the sprint is a task run the
session plans and drains, same contract for every executor: read the
sprint and the code, cut the work into stages — each the smallest change
that makes progress toward the completion contract and leaves the tree
runnable — and file one build task (`ok-opus`, under the sprint build
prompt) per stage into the task tracker, naming the files it may touch
and the stages it builds on; stages with disjoint files run together,
and no review task is filed.
The harness task tools, where available, mirror the stages, one entry
each, created when the build tasks are filed, marked in progress at
dispatch and done as each build task closes. The drain loop at
`.claude/skills/_tasks/drain.md` drains them, a fresh agent per task. The build task applies the deltas
to `design/`, builds, and records its calls and
forks as pool items. The session builds nothing, writes `tasks render`'s
output into the completion report, and edits no file a running task
owns. Code complete means every stage's build task closed `done`.
**Sprint certification**, `/converge sprint <path>`, then closes the
sprint: one review of the
change for completion and regression against the implementation
notes' rulings, the project's checks over the changed files, and a
drive of the stories the sprint adds or amends. Fixers work through the
merged defect list once; verifiers read only each fixer's change, until
none is sent back. A defect at its limit of send-backs has its change
backed out and goes to the intake as a judgment issue.
On the owner's cadence, `/converge` in `drive`, `analysis`, or
`defects` mode finds and fixes defects across the product the same
way, and `/triage-issues` verifies the intake.
Whether the corpus's claims still hold is `/audit`'s question, on the
owner's cadence, never at a close. At a release, `/document` ensures a
current audit (running `/audit` when the tree has moved past its
stamp), settles the document types (`.ok-planner/surface/documents/`)
in the documentation walk, constructs the commit-stamped documentation
corpus from the audit's records — measuring nothing — and revises one
self-contained document per declared type, at the type's target in
the tree. On completion, artifacts move to their same-named
folder under `history/` (a sprint with its `-completion` report). The
full execution shape is in `.ok-planner/CLAUDE.md`.

## Defect issues

The intake under `.ok-planner/issues/` holds two kinds of issue, told
apart by the `category:` field:

- **A judgment issue**, in any category but `defect`: something the
  code, the design corpus, and the project's tooling do not decide,
  where reasonable owners would choose differently. It may ask what the
  product commits to, or how the project's own tooling works (the
  skills, prompts, and rules under `.claude/` and `.ok-planner/`,
  `category: tooling`). The next `/plan-sprint` takes it up. A change
  to a suite-owned file goes upstream instead, to the ok-plugins
  suite. A file is suite-owned when `/ok` overwrites it on every
  converge: a `Materialized by ok-` stamp stands on its last line or
  on one of its first five lines, it lies under
  `.ok-planner/review/catalog/`, it is a `LICENSE` whose first line
  says `materialized by the ok-* suite`, or it is
  `.ok-planner/package.json` or `.claude/rules/ok-concepts.md`, which
  the suite writes with no stamp.
- **A defect**, `category: defect`: a harm the accept list at
  `.ok-planner/review/catalog/accept.md` covers, at a named site, found
  outside the scope of the run that found it. Nobody needs to judge it.
  The next `/converge` fixes it.

**Filing.** Two writers file defect issues, in the issue format, kind
`audit`. `/converge`'s owner list files each defect a run leaves: the
Problem names the site, the accept-list entry or sprint class, the
trigger, the harm, and the evidence, and says whether a merge agent
confirmed it or a fixer only noticed it. The one Candidate is to fix
the site so the harm no longer follows. The audit's judge files each
practice violation it confirms: one defect issue per practice, naming
entry A8 and every breaking site, unless an open defect issue on that
practice already stands. When a
defect reaches the run's limit of send-backs, the run backs its change
out of the tree, and the owner list turns its issue into a judgment
issue, or writes one: `category: design` or `product-intent`, `status:
open`, no `triage:` stamp, and a `## Stuck in <run>` section with each
fix tried and each verifier's reason.

**Verifying.** `/triage-issues` verifies the intake. It sorts each issue
as a defect claim, which asserts the code is wrong and asks only that
it be fixed, or a judgment issue, which asks the owner to choose. The
accept list filters defect claims alone, as it stands; an issue
written from a `/converge` proposal is a defect claim first, and its
proposed entry counts for nothing until the suite adopts it. Each
issue takes one route:

- `answered`: the code no longer shows the problem, or the corpus or
  the tooling settles it. The issue closes, naming what changed.
- `answered`, upstream: a proposed entry the accept list as it stands
  does not cover, or any change to a suite-owned file. The closed file
  carries a ready-to-file issue against the ok-plugins suite (the
  site, the harm, and the proposed entry wording), and the report
  hands it to the owner to file upstream.
- `retired`: a defect claim no accept-list entry covers as a harm the
  code causes. The reason goes under `## Ruling`, and the report lists
  it for the owner's veto.
- `defect`: an entry covers the harm and the fix changes code alone.
  The issue gets `category: defect` and `> Generated ruling
  (/triage-issues): fix <the site> so <the harm> no longer follows.`
- `corpus` or `question`: the fix changes what the design corpus
  commits to or how the project's own tooling works. The issue keeps its category and
  goes to `/plan-sprint`, with a generated ruling where the rules decide
  the change and a recommended ruling where the owner must choose.

**Routing.** `/plan-sprint` lists every open or verified `category:
defect` issue at Frame, one line each with its site and harm, and the
owner picks which join the sprint. A picked issue joins as a ruled
issue does. `/converge` in `drive`, `analysis`, and `defects` mode reads
every open or verified defect issue as a report; `defects` mode hunts
nothing else, and sprint certification reads none.

**Closing.** `/converge`'s owner list closes a defect issue and moves
it to `.ok-planner/history/issues/`: `status: fixed` with `fixed-by:
<run>` when the run verified the fix, or `status: answered` with what
the run found under `## Ruling` when the code no longer shows the defect. A
stuck defect's issue turns into a judgment issue instead. A defect issue
picked into a sprint closes as `promoted`, and sprint certification checks its fix.

## The public surface

The **surface intent** at `.ok-planner/surface/surface.md` is one
prose document naming which classes of element are public by default
and which specific elements depart: general rules with named
exceptions. The audit's **interactive intent stage** produces and
maintains it — a short class-level conversation ("every CLI verb is
public"), an à la carte run's one owner walk — and the owner may edit
the file between audits. Once the intent lands, the run dispatches a
**surface extractor subagent** that reads it, walks the code and
deployment configuration, and writes the run's **surface extraction**
at `.ok-planner/audits/surface/extraction.json`, one entry per element
found, kind discovered by the walk. Elements the intent does not
settle are defaulted internal for the run and filed as intake issues.
No reconciler tool, no committed member lists, no stamped ruling.
Work that introduces surface the intent cannot classify is settled
during `/plan-sprint`.

## Audits

The implementation-audit corpus under
`.ok-planner/audits/{concepts,stories,decisions,subjects}/` holds one
file per live artifact, written only by the periodic `/audit` run, never by the
implementing session, never hand-edited. Only a running `/audit`
reads or writes `.ok-planner/audits/` and `.ok-planner/experiments/`:
they record behavior at the time of the audit. An experiment the work
breaks stays broken until the next run repairs or retires it. An
audit answers two
independent questions in one sentence to one paragraph: `text:`
(`compliant` | `noncompliant`) — does the body follow its authoring
rules — and `implementation:` (`supported` | `unsupported`) — does the
codebase support the claim at this commit. They come apart: a
malformed artifact may be accurately implemented. Where an artifact
claims an enumerable population, the verdict adds the coverage shape:
`checked:`, `unaccounted:`, and the unaccounted members named.

The instrument differs by kind. Story support is measured from the
user's side: the maintained experiments at `.ok-planner/experiments/`,
re-run at this tree through the public surface the extraction
records — never settled by reading, and conclusions never carry. Each experiment is self-contained: it uses
only what an end user has and shares no helper code with the project
or with another experiment. Assumptions — user-vantage priors a boxed
agent synthesizes cold from user-visible material — are measured on
the same instrument, each record closing with a disposition (`held` |
`trap` | `unverified`); a contradicted assumption is documentation,
never a fix issue. Decision support is an adversarial reading against
the code. Concept support is the vocabulary reading: one live name,
and the citing sites and the code around them agree with What it is
and Boundaries.

An audit is a statement about a named commit, not a standing verdict:
its `commit:` frontmatter names the tree it describes, so whether it
still holds is a git question. Nothing tracks staleness. No audit
carries citations, hashes, or line numbers; the next run navigates by
the annotation grep. Every universal comes back as a count and its
population ("checked all 8 skills the payload vendors under
`.claude/skills/`").

The run is two stages and no loop: auditors, filed as tasks, over every
live artifact, then one terminal judge over every escalation —
`unsupported` verdicts, practice violations, assumption contradictions,
corpus contradictions from the extraction, the orchestrator's driving
observations. A confirmed gap becomes an intake issue, and a confirmed
practice violation a `category: defect` issue, one per practice; the
run fixes nothing. The audit
corpus and the intake are independent: no `issue:` field in either
direction. The experiments are the audit's instruments and remain in
its collection. The run ends by writing
its report to `.ok-planner/history/audits/<date>-<sha>-report.md` — a
record, never a channel — committing everything, and stamping the
commit; it presents only when invoked à la carte. The orchestrator runs
no validator over the corpus; a malformed audit is rewritten whole by
the next run.

## Documentation

`/document` produces release documentation into
`.ok-planner/documentation/` and measures nothing: it ensures a
current audit and constructs from the audit's records. The
**publishable layer** — a catalog over the extraction's public side,
assessments whose held claims cite the audit's passing experiments,
traps read from the assumption dispositions, a concept router —
speaks the shipped vocabulary and cites catalog rows at the stamp,
never source paths. The **verification layer** — trap
evidence, the extraction, the audit's records, the experiments —
stays internal and cites the tree freely. The **documents** — one per
declared document type, settled in the documentation walk — are
self-contained and live at each type's target in the tree, carrying a
provenance stamp. Only declared targets are written. Every record and
document is stamped with the release commit; each release re-derives
the records whole and revises each document where it lives, keeping
what the tree still supports. The run runs no validator over its own
records; the next release rewrites a malformed one whole.

A concrete story does not speak to the qualitative. Correct, clear,
helpful, intuitive describe how well the product owes something, not
what it owes. Where a promise rests on a human discipline's judgment,
the audit records a **referral** — the promise, what exists in form,
and the owning discipline — and opines no further.

## The task tracker

`.ok-planner/bin/tasks` tracks one run's tasks and the items agents file
into keyed pools, in one committed JSONL log; its index and pointer sit
under `.ok-planner/.cache/`, ignored from git. Every agent an orchestrator
dispatches against it is a vendored profile under `.claude/agents/`
(`ok-opus`, `ok-haiku`, `ok-audit`, the audit's forking
profile, and `ok-review`, the forking profile of sprint certification's
review) that pins model and effort, and
every agent of one profile starts from one identical message that
names no task, so the first request is one cached prefix per profile,
and takes the oldest issued task filed for its profile with `tasks
claim --agent <profile>`; only a fork claims by id, the pass task its
root filed for it. `tasks next` issues every ready task and prints one
line per profile with the count waiting, and the drain loop at
`.claude/skills/_tasks/drain.md` starts that many agents up to its
concurrency cap; it files nothing.

## Per-run artifacts and verification stacks

Every verification run mints one fresh tag, builds every artifact it
verifies under that tag, and hands the tag to its verification path
through the one environment variable this project declares. Run
`.ok-planner/bin/run-tag` to mint the tag: it prints `run-<12 hex>`, a
new value on every invocation. The verification path resolves
artifacts by that tag alone and fails loudly when the variable is
unset or no artifact carries the tag. Never `:latest`, and never any
tag that outlives the run, in a verification path. A tag unique to the
run keeps concurrent runs from colliding; building and verifying inside
one run makes staleness unrepresentable.

A verification stack runs under the run's tag and binds host ports the
OS assigns. A container stack runs as the compose project the tag
names and publishes its container ports with no host port given. A dev
server listens on port 0 and writes the port it got to a path holding
the tag. `.ok-planner/bin/port-block <run-tag>` reads those ports back
and prints one `NAME=<port>` line per name `ports` declares in
`.ok-planner/config.json`. Never pick a port in one program for another
to bind later. Where the stack cannot bind this way, `port-block`
refuses with exit 2, and the project's own stack commands handle
isolation.

## Hard rules

- A sprint is a disparate set of work items: no theme, no order.
  Staging it is execution's job; never write a plan document from one.
- The sprint is the source of truth for its work. A promoted issue is
  settled; never read the intake to learn what a sprint meant.
- Open issues gate the work they bear on, not all work; the rest stay
  queued.
- Design docs are current-state only: no changelogs, no roadmaps, no
  TODOs.
- Suite upkeep is the front door's administration (`/ok`), never a
  ceremony's job and never run from a hook; it is always a user
  action.
