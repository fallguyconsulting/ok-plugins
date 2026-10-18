# ok-planner Cheatsheet

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned:
overwritten wholesale on true-up (`/ok`); project-specific rules
belong in your own files under `.claude/rules/`.

The planner's estate lives in `.ok-planner/`; its embedded `CLAUDE.md`
carries the full per-directory rules. The short version every session
needs:

## The content kinds

- **`design/` — source of truth, read freely.** Concepts, stories,
  decisions: the project's durable model, same weight as code. What it
  commits to changes only by applying an approved sprint's corpus
  deltas; `/converge` and `/triage-issues` edit no corpus file,
  except that sprint certification lands an approved delta of its
  own sprint that execution missed, the one corpus write a review
  run makes. Code
  cites the corpus with
  `@concept:` / `@story:` / `@decision:` annotations, and rollout is
  incremental: consult an artifact while working on a file and leave
  the annotation — kind plus slug, at the load-bearing site — before
  you are done. Its TOCs, `concepts.md`, `stories.md`, and
  `decisions.md`, are generated: `.ok-planner/bin/catalog-toc`
  rewrites them.
- **`issues.jsonl` — the intake.** One record per open issue, with its
  discussion: a judgment issue awaiting the owner, or a `category:
  defect` issue awaiting the next `/converge`, as "Defect issues" below
  says. `.ok-planner/bin/issues` is its one reader and writer; never
  edit the file by hand. Anyone may file an issue with `issues file`.
  `/triage-issues` makes each one ready for its next reader and ends it
  in a marked generated or recommended ruling; it fixes nothing.
  Silence accepts that ruling, except on an upstream issue or while a
  person's comment awaits triage, and `/plan-sprint` walks each of those
  with the owner. A `/plan-sprint` session closes a judgment issue:
  **promoted** into that sprint, **retired**, or, for an upstream
  issue the owner files upstream, **answered**. Closed records move to
  `history/issues.jsonl`. A ruling is a person's alone, written with
  `issues rule` or on the dashboard `.ok-planner/bin/dashboard` serves,
  and anyone who works the intake may rule.
- **`review/` — the review loop's estate.** `/converge` reads and
  writes it, and `/triage-issues` reads its accept list. `catalog/` is
  suite-owned; `config.json` and `project.md` are the project's,
  seeded once and never overwritten, and agents keep `project.md`
  current; `runs/`
  holds records, out of context by default.
- **`docspec/` — the documentation orders, read freely.** One docspec
  per kind of documentation the project keeps, as "Documentation"
  below says. A docspec is owner intent: like `design/`, it changes
  only by applying an approved sprint's delta. Its index,
  `.ok-planner/docspec.md`, is generated:
  `.ok-planner/bin/catalog-toc` rewrites it.
- **`surface/surface.md` — the surface intent, read freely.** Owner
  intent for the public surface, changed only by applying an approved
  sprint's delta, as "The public surface" below says.
- **`sprints/`, `doc-sprints/`, `doc-state/`, `sketches/`, `history/`
  — records, out of context by default.** Do not read them to
  understand the project, include them in general exploration, or
  reconcile them with current code. A sprint or a documentation sprint
  is in context while you execute it, not otherwise. `doc-state/`
  holds each docspec's stamp, claim ledger, and worked example, which
  only `.ok-planner/bin/docs` writes. `sketches/` is speculative future thinking (written by
  `/sketch`).
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
  condenses, and the docspec shape templates under `docs/shapes/`.
- **`config.json` — the project's configuration.** It turns each lint
  check on or off (`lint_checks`) and declares the citation tags, the
  test paths, the folders the project owns beside its root, and the
  dashboard's `title`. The lint, `.ok-planner/bin/plumbline`, reads
  it, and so does its edit hook, `.ok-planner/hooks/post-edit.js`.
  `ports` and `port_range` are the port registry's settings
  (`.ok-planner/bin/ports`), and `stack` is the stack the reference
  stack tool, `.ok-planner/bin/stack`, runs when called with no
  command. No process prompt reads any of the three.
  `.ok-planner/docs/stack-helpers.md` is the reference document for
  the stack helpers and the reference stack tool; read it before you
  build or change a project's stack tooling.

## Lifecycle

`/sketch` captures an idea in `sketches/`; it authorizes nothing.
`/plan-sprint` produces a sprint in `sprints/` — corpus deltas, work
items, implementation notes, a fixed completion contract. It pulls
every ruled issue in without re-discussion, offers the open defect
issues for the owner to pick, resolves with the owner the unruled open
issues that bear on the work, and has a code planner write the
implementation notes against the release boundaries: those
`.ok-planner/release-boundaries.md` declares, stored state, and the
public surface. The owner approves once, at the
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
to the corpus, the docspecs, and the surface intent, builds, and
records its calls and forks as pool items. It writes no
documentation and no doc comment. The session builds nothing, writes `tasks render`'s
output into the completion report, and edits no file a running task
owns. Code complete means every stage's build task closed `done`.
**Sprint certification**, `/converge sprint <path>`, then closes the
sprint: one review of the
change for completion and regression against the implementation
notes' rulings, the project's checks over the changed files, and a
drive of every story. Fixers work through the
merged defect list once; verifiers read only each fixer's change, until
none is sent back. A defect at its limit of send-backs has its change
backed out and goes to the intake as a judgment issue. The close
presents the completion report's calls table, one row for every
judgment an agent made without the owner, and the owner vetoes any row
they disagree with.
On the owner's cadence, `/converge` in `drive`, `analysis`, or
`defects` mode finds and fixes defects across the product the same
way, and `/triage-issues` verifies the intake, and `/plan-docs`
plans a documentation sprint, as "Documentation" below says.
On completion, artifacts move to their same-named
folder under `history/` (a sprint with its `-completion` report). The
full execution shape is in `.ok-planner/CLAUDE.md`.

## Defect issues

The intake at `.ok-planner/issues.jsonl` holds one record per open
issue, and its archive at `.ok-planner/history/issues.jsonl` one per
closed issue. `.ok-planner/bin/issues` is the only reader and writer
of both: it reads every record with an id, keeping fields it does not
know, checks what each write changes against the issue format, and
runs every write under one lock. The intake
holds two kinds of issue, told apart by the record's `category`:

- **A judgment issue**, in any category but `defect`: something the
  code, the design corpus, and the project's tooling do not decide,
  where reasonable owners would choose differently. It may ask what the
  product commits to, or how the project's own tooling works (the
  skills, prompts, and rules the project owns under `.claude/` and
  `.ok-planner/`, `category: tooling`). An **upstream issue** (`category: upstream`)
  names a harm whose fix lies in a part the project does not own: a
  suite-owned file, a library the project depends on, an outside tool
  or service, or a harm the accept list does not name. The next
  `/plan-sprint` takes each up. A file is suite-owned when `/ok` overwrites it on every
  true-up: a `Materialized by ok-` stamp stands on its last line or
  on one of its first five lines, it lies under
  `.ok-planner/review/catalog/`, it is a `LICENSE` whose first line
  says `materialized by the ok-* suite`, or it is
  `.ok-planner/package.json` or `.claude/rules/ok-concepts.md`, which
  the suite writes with no stamp.
- **A defect**, `category: defect`: a harm the accept list at
  `.ok-planner/review/catalog/accept.md` covers, at a named site, found
  outside the scope of the run that found it. Nobody needs to judge it.
  The next `/converge` fixes it.

**Filing.** `/converge`'s owner list is the one writer of defect
issues. It files each defect a run leaves with `issues file`, in the
issue format, kind `audit`: the problem names the site, the
accept-list entry or sprint class, the trigger, the harm, and the
evidence, and says whether a merge agent confirmed it or a fixer only
noticed it. The one option is to fix the site so the harm no longer
follows. When a
defect reaches the run's limit of send-backs, the run backs its change
out of the tree, and the owner list turns its issue into a judgment
issue with `issues revise`, or files one: category `design` or
`product-intent`, no route and no recommendation, and a `Stuck in
<run>` section in its problem with each fix tried and each verifier's
reason. Whichever run meets a harm in a part the project does not own
files it as an upstream issue, its `upstream` draft ready to file, in
the issue format: `/converge`'s owner list as kind `audit`, and a
sprint's build task as kind `sprint`. True-up files under kind `audit`
too: one issue for each retired suite script caller it cannot
repoint, and one for a review facts file it cannot decode.

**Verifying.** `/triage-issues` verifies the intake. It sorts each issue
as a defect claim, which asserts the code is wrong and asks only that
it be fixed, or a judgment issue, which asks the owner to choose. The
accept list filters defect claims alone, as it stands; an issue
written from a `/converge` proposal is a defect claim first, and its
proposed entry counts for nothing until the suite adopts it. Each
issue takes one route:

- `answered`: the code no longer shows the problem, or the corpus or
  the tooling settles it. The issue closes, naming what changed.
- `upstream`: a proposed entry the accept list as it stands does not
  cover, or any other fix in a part the project does not own, such as
  a suite-owned file. The issue gets `category: upstream`, an
  `upstream` draft ready to file with the ok suite or the part's
  maintainers, and a recommended ruling, and stays in the intake for
  `/plan-sprint`. Triage closes it as `answered` only once the project
  no longer shows the harm.
- `retired`: a defect claim no accept-list entry covers as a harm the
  code causes. The issue closes with the reason, and the report lists
  it for the owner's veto.
- `defect`: an entry covers the harm and the fix changes code alone.
  The issue gets `category: defect` and a generated ruling: `fix <the
  site> so <the harm> no longer follows.`
- `corpus` or `question`: the fix changes what the design corpus
  commits to or how the project's own tooling works. The issue keeps its category and
  goes to `/plan-sprint`, with a generated ruling where the rules decide
  the change and a recommended ruling where the owner must choose.

Every run then gives each routed or ruled issue whose text changed
since its last clarity pass a cold read by an agent that did not write
it. The agent rewrites the title and problem for an engineer who does
not know the project: the cause first, then the harm, then the context
from the top with each project term defined. It also checks each fact
the issue states against the project as it stands.

**Routing.** `/plan-sprint` lists every open or verified `category:
defect` issue at Frame, one line each with its site and harm, and the
owner picks which join the sprint. A picked issue joins as a ruled
issue does. `/plan-sprint` also sets apart at Frame every upstream
issue the owner has not ruled in their own words, and walks each with
the owner at Resolve, who answers one of three
ways: a workaround, which becomes sprint work and promotes the issue;
a filing upstream, after which the issue closes `answered`, naming
where it was filed; or both. `/converge` in `drive`, `analysis`, and `defects` mode reads
every open or verified defect issue as a report; `defects` mode hunts
nothing else, and sprint certification reads none.

**Closing.** `issues close` moves an issue's record to
`.ok-planner/history/issues.jsonl`. `/converge`'s owner list closes a
defect issue as `fixed`, naming the run, when the run verified the
fix, or as `answered`, with what the run found as the reason, when the
code no longer shows the defect. A stuck defect's issue turns into a
judgment issue instead. A defect issue picked into a sprint closes as
`promoted`, and sprint certification checks its fix. Markdown issue
files under `.ok-planner/history/issues/` are an earlier layout's
records: they stay as written and read as closed. `.ok-planner/bin/issues` reads only
the current layout: where open markdown issue files or the pre-v9
event log remain, it refuses and names `/ok`, whose true-up converts
them in its plan, under the owner's one consent.

**Discussing.** Anyone who works the intake comments on an issue, or
rules on it, with `issues comment` and `issues rule` or on the
dashboard; each comment and ruling carries its author's name, and the
latest ruling stands. The next `/triage-issues` run answers each
person's message it has not yet seen: it replies, revises the issue
where the message shows it wrong or thin, and only then marks the
message seen. It never rewrites a person's ruling. On an open issue,
every message, a person's comment or ruling included, stays unread to
each person but its author until that person reads the issue, and
reading the issue marks every message on it read. An open issue a
person has never read counts as new.

## The public surface

The **surface intent** at `.ok-planner/surface/surface.md` is one
prose document of class rules with named exceptions: which classes of
element are public, which specific elements depart, and, for each
class of entry point, the files that declare its members, such as a
command table or a route table. It is owner intent: it changes only by
applying an approved sprint's delta. Nothing is public until the owner
declares it: an element no rule or exception makes public is internal,
and a new feature makes nothing public but a new member of a class a
rule already makes public. Declaring a docspec in `/plan-sprint` opens
the question of what surface it describes, and the answer becomes a
surface intent delta in the same sprint. Every class the intent makes
public has a reference docspec that lists it. Every element it classes as public is a release
boundary, with its callers outside the project across it: planning
sends a change that breaks its contract to the owner, and a fix keeps
it working. A reference docspec reads it to learn which
classes are public. `/converge` in `analysis` mode cuts one flow area
per declaring file on each run; where the project has no surface
intent, or it names no declaring file, the run hunts file areas only
and says so in its return.

Nothing stores the surface's members: no extraction, no map, no index
of entry points. Whoever needs a class's members lists them from the
tree at that moment, starting from the files the intent names as
declaring the class.

## Documentation

A **docspec** at `.ok-planner/docspec/<slug>.md` declares one kind of
documentation the project keeps for humans, or for agents that use a
deliverable without its source: where it lives (a file, a folder and
how its files are laid out, or, for doc comments, `in code:` and the
files that carry them), its reader, what it covers, its references
(the corpus artifacts and code paths it describes), the surface
classes it lists in full (reference documentation only), the shape of
one file, copied from a template under `.ok-planner/docs/shapes/`,
the generator of in-code documentation, and notes. A docspec carries
the order, never the text. An agent working with the source reads the
design corpus, the code, and the rules, not the documentation. Where
`.ok-planner/docspec/` is missing, the project declares no
documentation.

Only a documentation sprint writes documentation. A sprint declares
the docspecs and the surface, and its builders write no documentation
and no doc comment. On the owner's schedule, usually before a release,
`/plan-docs` reads what changed since each docspec's stamp, plans one
item per file to write, change, or drop, each with the rules that fire
on it, and produces a documentation sprint in `doc-sprints/`. The
owner approves each docspec's first worked example and the plan once.
The documentation sprint runs under `/goal` on the task tracker:
writers edit only where a rule fires, a cold style pass reads each
changed file once, and a fact loop with no cap checks every claim
against the tree until each holds or is cut.
`.ok-planner/bin/docs complete --sprint <path>` prints `DOCS COMPLETE`
when it is done. After the owner commits, `.ok-planner/bin/docs stamp`
records each docspec's stamp and claim ledger in `doc-state/`, so the
next run checks again only what changed. The lint allows doc comments
only in the files an in-code docspec names, and in a file whose
opt-in marker an earlier release committed. Planning's reconcile step
flags documentation a person edited directly, for the owner to decide.

## The task tracker

`.ok-planner/bin/tasks` tracks one run's tasks and the items agents file
into keyed pools, in one committed JSONL log; its index and pointer sit
under `.ok-planner/.cache/`, ignored from git. Every agent an orchestrator
dispatches against it is a vendored profile under `.claude/agents/`
(`ok-opus`, `ok-haiku`, and `ok-review`, the forking profile of sprint
certification's review) that pins model and effort, and
every agent of one profile starts from one identical message that
names no task, so the first request is one cached prefix per profile,
and takes the oldest issued task filed for its profile with `tasks
claim --agent <profile>`; only a fork claims by id, the pass task its
root filed for it. `tasks next` issues every ready task and prints one
line per profile with the count waiting, and the drain loop at
`.claude/skills/_tasks/drain.md` starts that many agents up to its
concurrency cap; it files nothing.

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
