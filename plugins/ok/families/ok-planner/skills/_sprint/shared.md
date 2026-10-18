# Sprint shared blocks

The blocks `/plan-sprint`, `/plan-docs`, the execution boilerplate of a sprint and of a documentation sprint, and `/converge` share; `/converge` reads them through `block_sources` in `.ok-planner/review/config.json`. Each is defined here once; a prompt transcludes it by name, resolved only where the token stands alone on its line, as in `../_shared/dispatch-discipline.md`.

The defect catalog these skills judge by is the project's accept list at `.ok-planner/review/catalog/accept.md`, the same list `/converge` reads. The project's facts (the root, what is out of scope, the code rules) are in `.ok-planner/review/project.md`, and its settings in `.ok-planner/review/config.json`, whose `checks` list is the one source of the checks.

---

### {{BEHAVIOR-CHANGE-DEFINITION}}

```
A behavior change is something a user outside the changed code can
observe: the inputs it accepts or refuses, what it returns, what it
raises, the rows, files, messages, or events it writes, their order,
the state it leaves, and the format of its output. A change no user
can observe is not a behavior change.

A user is a site that depends on the behavior: a caller or reference,
code that reads the same stored data or configuration, or a user
across a release boundary. A user that passes the change on to its
own users is a behavior change in turn; follow it until the change
stops spreading.
```

---

### {{RELEASE-BOUNDARIES}}

```
A release boundary separates code that ships in one release from a
user that does not update in the same step. The project declares its
boundaries in `.ok-planner/release-boundaries.md`, each with who is
across it, what crosses it, and where in the tree to look. A declared
boundary may lie off the public surface.

Two boundaries apply to every project and are never declared:

  Stored state. Data an earlier release wrote and a later release
  reads or writes: database rows and columns, files and objects,
  configuration files a running deployment holds, messages waiting in
  a queue. The data does not update when the code does.

  The public surface. Every element the surface intent at
  `.ok-planner/surface/surface.md` made public before the change: a
  command, a verb, a flag, a route, an exported module, an env var, or
  any other element a rule or an exception of the intent makes public.
  Planning and a fix outside a sprint read the intent as it stands.
  Sprint certification reads it as it stood at the sprint's base
  commit, the commit the `-base.txt` file beside the sprint records.
  Across the boundary are the element's callers outside the project,
  which update on their own schedule. A caller inside the project's
  tree ships in the same release.

  What crosses it is the element's contract: what the element accepts,
  what it returns, raises, writes, and prints, the order of its
  effects, and the state it leaves. A change breaks the contract where
  it narrows what the element accepts, changes any of the rest, or
  removes the element. A surface intent delta that makes a public
  element internal, or drops it, breaks its contract as a removal
  does. An addition no existing caller reaches, such as a new optional
  flag, breaks nothing. A fix that removes only the harm an
  accept-list entry names keeps the contract, because no caller may
  rely on the harm.

  The intent's `## Where each class is declared` names where to look.
  Where the project has no surface intent, no element is public, and
  this boundary has no users.
```

---

### {{OWNER-QUESTION-TEST}}

```
A planning question goes to the owner only when at least one of these
holds:

1. The answer changes a promise: it adds, drops, widens, or narrows
   what a story promises or what a decision's Choice commits to.
   Rewording a drafted body to match what the code will do is not a
   promise change.
2. A change breaks compatibility across a release boundary: an older
   or newer part within the same major version, a public element's
   caller outside the project, or stored data, stops working, and no
   compatible form of the change reaches the outcome.
   The owner decides whether the release is a major one, or whether
   the outcome changes. A decision under `.ok-planner/design/`
   states the rule where the project declares one.
3. Two readings of a person's ruling lead to results a user can
   observe that differ, and the corpus does not pick between them.

A new element no rule or exception of the surface intent makes public
is internal, and asks the owner nothing: only the owner declares a
surface.

Every other question is a call. Whoever meets it makes the most
plausible call, writes it with the rule, artifact, or ruling that
decides it, and moves on. The approval lists the calls for the
owner's veto. Sprint certification judges each call against the
accept list and fixes any that leaves a harm; it asks the owner about
none.
```

---

### {{BEHAVIOR-RULINGS}}

```
Each behavior change in a sprint's implementation notes carries one
ruling:

- `rewrite`: every user ships in the same release, and the sprint
  changes each user that must change. The code planner sets it.
- `preserve`: users across the boundary observe no change. The change
  adds beside the behavior and alters nothing they reach.
- `migrate: <how>`: the behavior changes, and `<how>` states how old
  users keep working or the refusal they get: both shapes accepted,
  stored data converted, a minimum version named and refused below it.
- `rewrite across <boundary>: <reason>`: the owner accepts that users
  across the boundary break, for the reason given.

The code planner sets `rewrite`, and sets `preserve` or `migrate:
<how>` where the rules, the corpus, or a ruling the owner already gave
determine it, marking it `(call)` after the ruling. Within a major
version a change across a boundary is `preserve` or `migrate` with both
shapes accepted; a migration that refuses an older part is a break. A
behavior change that meets the owner question test above is written
`owner (<boundary>)` until the owner rules. Only the owner sets
`rewrite across <boundary>`.
```

---

### {{SPRINT-BUILD-PROMPT}}

The build task prompt for a sprint written by `/plan-sprint`. It carries the coding rules `/converge`'s fixers follow, writes no documentation, keeps the sprint's rulings, records what a builder meets outside its files for sprint certification, and files a harm in a part the project does not own as an upstream issue. `[SPRINT PATH]` is the sprint document.

```
Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  {{LEAF-AGENT-RULE}}

  You build one stage of the sprint at [SPRINT PATH]. Your brief names
  the work items the stage lands, the corpus deltas it applies, the
  behavior changes it carries by id with their rulings, and where the
  code is. Your task's files are the paths you may edit. Read the
  sprint's intent, its deltas, the work items you land, and their
  implementation notes before you write.

  ### The stage

  - Write the code the notes name. Apply each corpus delta the stage
    carries: copy the final-form body verbatim (from the sidecar where
    the heading points there) into its home, `.ok-planner/design/` for
    a concept, story, or decision, `.ok-planner/subjects/` or
    `.ok-planner/practices/` for a subject or practice,
    `.ok-planner/docspec/` for a docspec, and
    `.ok-planner/surface/surface.md` for the surface intent, or delete
    the file for a retirement. After every delta but a surface intent
    delta, run `python3 .ok-planner/bin/catalog-toc` to regenerate
    that collection's TOC, the docspec index `.ok-planner/docspec.md`
    after a docspec delta.
  - Every new or amended story implemented in code carries the
    `@story:` annotation at the site that realizes it.
  - Where the stage adds or changes an input of a script
    `.ok-planner/review/project.md` lists, update that script's entry
    in the same stage, keeping every limit the file's `## What no agent
    of this loop ever runs` section sets.
  - Keep each ruling your brief names. A `preserve` behavior stays
    unchanged for its users across the boundary. A `migrate` behavior
    lands its migration in this stage. A `rewrite` behavior brings
    every user the notes list along.
  - Where your code changes a behavior a user can observe and the
    notes list no such change, record it: `tasks item add --pool
    divergences --key <your key> --field kind=call --field
    site=<path::symbol> --field choice="<one line>" --body "unlisted
    behavior change: <path::symbol>; before: <...>; after: <...>;
    users: <...>" --task <task>`. Sprint certification judges it.
  - Record each improvement the stage lands, by its I-id: `tasks item
    add --pool divergences --key <your key> --field kind=improvement
    --field site=<path::symbol> --field choice="I<n>: <one line>"
    --body "<what the code does now>" --task <task>`.
  - Completeness is the floor. Deliver every outcome the brief
    promises, or close `blocked` naming what stops you. A stub, a
    `TODO`, or a no-op standing in for an outcome is an undelivered
    outcome.
  - Run the project's checks (`.ok-planner/review/config.json` `checks`
    lists them) on every file you changed, in the foreground, and close with no
    process of your own still running. Leave the tree runnable.
  - Write no documentation and no doc comment: a documentation sprint
    writes them after the code settles. Leave every file under the
    `## Where` of a docspec at `.ok-planner/docspec/<slug>.md` as it
    stands, and every doc comment, save one on a declaration the stage
    removes, which goes with it.

  ### The coding rules

  {{CONVERGE-CODING-RULES}}

  ### Calls, forks, and what you notice

  Every item you add to the divergences pool carries `--field
  site=<path::symbol>`, the site it concerns, and `--field
  choice="<one line>"`, what you chose there, so the completion
  report's calls table shows it in one row. Where the sprint is
  silent, make the most plausible call, continue, and record it:
  `tasks item add --pool divergences --key <your key> --field
  kind=call --field site=<path::symbol> --field choice="<one line>"
  --body "<the call>" --task <task>`. Where the sprint and corpus do
  not decide and reasonable owners diverge, build the reading you
  judge best and record the fork with its options: `--field kind=fork
  --state fork`, with the reading you built as its choice. Sprint certification settles every
  fork: one the sprint or corpus decides becomes work or nothing, and
  the rest become questions for the owner.

  A defect you meet outside your files is recorded once and left;
  sprint certification reads it as a report: `tasks item add --pool
  divergences --key <your key> --state noticed --field kind=noticed
  --field file=<path> --field site=<path::symbol> --field
  choice="<one line>" --body "<the site; the harm>" --task <task>`. A site outside your files that your own
  change must reach (a caller of a definition you changed) is yours:
  stage what you built and close `partial` with a result that starts
  `outside files: <path>: <site>`.

  A harm whose fix lies in a part the project does not own — a file
  the suite owns, a library the project depends on, an outside tool or
  service — is the one issue you file, and the intake the one write
  outside your task's files. Every read and write of the intake goes
  through `.ok-planner/bin/issues`. First look for an open issue on the
  same harm: `.ok-planner/bin/issues list` prints every open issue's
  id, state, category, and title, and `.ok-planner/bin/issues show
  <id>` prints one whole. Where one stands, file nothing and name its
  id in your close result. Otherwise file one issue with
  `.ok-planner/bin/issues file --from -`, one JSON object on stdin in
  the format of the `{{ISSUE-FILE-FORMAT}}` block of
  `.claude/skills/_shared/artifact-definitions.md` (open that file and
  read the block): kind `sprint`, `category: upstream`, the `problem`
  naming the foreign part as the project sees it (the package and its
  version, the tool, or the file's path as it sits in the project,
  never a path to a local checkout), the site, the harm, and the
  evidence, and the `upstream` draft ready to file. Call the suite
  "the ok suite". Where `.ok-planner/bin/issues` refuses the filing, name the
  harm and its message in your close result instead. Stage
  `.ok-planner/issues.jsonl` and list it under `--staged`.

  ### Rules

  - Never destroy uncommitted work. Stage the paths you touched by
    name as you finish (`git add <paths>`). Never run `git
    checkout`/`restore`/`reset`/`stash`/`clean`. Fix a bad edit
    forward by editing again. The owner commits.
  - Read files before editing.

  ### Close

  Close with every path you touched under `--staged`, every site your
  searches returned under `--sites` (`path[:locator]`, `=standing`
  after one that already had the shape), and one line in the result
  naming what the stage now does. A stage you could not finish closes
  `partial` with where you stopped and what is staged.
```

---

### {{SPRINT-CATALOG}}

What counts as a defect in sprint certification (`/converge sprint`). The sprint passes report under it, and the merge agent judges their reports by it.

```
#### The defect standard

The accept list at `.ok-planner/review/catalog/accept.md` names the harms that
count as defects, and what it leaves standing. A sprint adds its own
promises: its work items, its taken improvements, its deltas, and its
implementation notes' rulings. The classes below cover both.

#### The scope test

A defect is in the sprint's scope when the change caused it, or when
the change makes a promised outcome fail through it, or newly exposes
an existing user to it. Read the site at the sprint's base commit
(`git show <base>:./<path>`, from the project root) to tell. A defect the accept list covers whose code
stood the same at the base, and which the change does not reach, is
real but outside the sprint: it goes to the intake as a
`category: defect` issue, and the next `/converge` fixes it.

Code structure is out of scope unless the sprint's notes have taken an
improvement for it: planning decides structure, and the loop this
replaced ran to its round cap filing structure findings on its own
fixes.

A user's goal is what it needs from a behavior, read from a named
source: a design corpus artifact it cites, a sprint work item, or
what its own code does with the value. A user across a boundary has
no code in this tree to read, so its goal is the behavior as it stood
at the base; a ruling other than `preserve` is how the owner allows a
difference there.

#### The classes

| code | class | the check | the evidence |
|---|---|---|---|
| C1 | Outcome not reached | A work item's outcome, or an improvement the notes list (I-id), that no entry point reaches, or reaches only in part: the entry never calls the code that produces it, a value is computed and not used, a configuration is read and not honored, or a stub, `TODO`, or ignored flag stands in for it. | the entry point; where the path ends; the outcome and its work item or I-id |
| C2 | Accept-list harm on the change | A harm an accept-list entry names, reached through a path the change added or altered, that the list does not leave standing. Report it under the entry's own code, A1 to A8. | the entry; the trigger; the path as path:function steps; the harm; path:line quoted |
| C3 | Delta not landed | A corpus delta whose artifact (under `.ok-planner/design/`, under `.ok-planner/subjects/` or `.ok-planner/practices/` for a subject or practice, under `.ok-planner/docspec/` for a docspec, or `.ok-planner/surface/surface.md` for the surface intent) does not match the delta's final-form body byte for byte, or is not deleted for a retirement. | the delta; the artifact; the first differing line |
| C4 | Commitment contradicted | Code in the change contradicts a commitment a corpus artifact states that the sprint's deltas or work items name, or a story a driver could not get, where a sprint work item asked for the contradicting code. | the artifact and its sentence; the code site; what the code does instead; for a story, the work item that asked for it |
| R1 | Preserved behavior changed | A `preserve` behavior change whose users across the boundary now observe a difference. | the B-id; before and after, from the code at the base and now |
| R2 | Migration not as ruled | A `migrate` behavior change whose old users neither keep working nor get the refusal its ruling states. | the B-id; the ruling; what an old user gets now |
| R3 | Rewrite left a user behind | A `rewrite` behavior change with a user in the release the change did not update, whose goal now fails. | the B-id; the user; its goal and source; what it gets now |
| R4 | Unlisted change breaks a user | A behavior change the notes do not list, with a user in the release whose goal now fails on some path. | the changed site; the user; its goal and source; the trigger, old outcome, new outcome |
| R5 | Boundary user not ruled | A behavior change with a user across a boundary that no ruling covers: the notes do not list the change, or list it without naming that user. | the changed site or B-id; the boundary and its user; before and after |
| M1 | Check fails | A check `.ok-planner/review/config.json` names fails on a file the change touched. Filed by the session. | the check; the file; the output |

A C3 defect is fixed in the run by landing the delta: its fixer
copies the delta's body into the artifact, or deletes the retired
file, and regenerates the catalog TOCs, the docspec index among them.

An unlisted behavior change that meets every user's goal is not a
defect; it is recorded for the owner as a `kind=unlisted` call. A
change a work item or delta asks for is not a regression; the
completion classes cover it. Every story is checked by the drive,
and the merge agent sorts its failures by the scope test.

#### How to state a report

State the failure, not the edit: the fixer chooses the fix, and a
report that names an edit narrows the fix to that edit. One report per
failure; two paths that fail through one site the same way are one
report.
```

---

### {{SPRINT-REVIEW-READING}}

The reading of a sprint's change: `/converge`'s sprint review root does it once, and a sprint pass reissued to a fresh agent does it in the root's place. `review prompt` fills no slot inside a block, so the block names the base commit `<base>` and the sprint's path `<sprint>`, which the prompt states above it.

```
`<base>` below is the base commit, and `<sprint>` the sprint's path,
both named above.

1. The sprint, whole: intent, deltas and their sidecar, work items,
   implementation notes. Every artifact under `.ok-planner/design/` a
   delta names or a work item cites, in full. Every docspec delta's
   docspec under `.ok-planner/docspec/`, as it stands.
   `.ok-planner/release-boundaries.md` where it exists. The surface
   intent at `.ok-planner/surface/surface.md` as it stands, where it
   exists, and as it stood at the base, where it existed then
   (`git show <base>:./.ok-planner/surface/surface.md`): the base
   version decides which elements are public across the boundary.
2. The change: `.ok-planner/bin/review changed --base <base> --sprint <sprint>`
   lists every file the sprint added, changed, or deleted, relative to
   the project root, less the files `.ok-planner/bin/review owner`
   classes as anything but `project` and the paths
   `.ok-planner/review/config.json` excludes. A changed harness
   settings file, corpus file, or record is not on the list; step 1
   reads each artifact a delta names. It includes the files under each
   folder the sprint lists under `## Paths outside the project root`,
   as paths starting `../`. Read each file's diff with
   `git diff <base> -- <path>`, run from the project root, and each
   added file whole.
3. Every changed file in full, as it stands now, and each changed
   file's base version where the diff alone does not show a changed
   definition whole (`git show <base>:./<path>`, the `./` making the
   path relative to the project root).
4. Each work item's and each taken improvement's path: from the entry
   point that reaches its outcome to the outcome, reading every
   unchanged file the path crosses in full.
5. The users of each changed definition that existed at the base: its
   callers and references (load the LSP with
   `ToolSearch("select:LSP")`; `rg` for the rest), code that reads the
   same stored data or configuration, and what each release boundary's
   Where to look names. Read each user's calling function in full.
```

---

### {{CEREMONY-RUN-RULES}}

How a run planned by a ceremony other than `/plan-sprint` executes: a documentation sprint today. The executing session follows these rules beside the steps its own boilerplate gives.

```
Work unsupervised to a defensible done. Do not pause for approval,
confirmation, or progress checks, and file no task for the owner to
perform. Stop only on a genuine blocker: a credential or access you
cannot obtain, a step impossible in the current state, a destructive
or irreversible action not clearly authorized, or a task closed
`blocked` twice. Surface the blocker and stop. Ambiguity is not a
blocker: the agent makes the most plausible call, records it, and
goes on.

The session plans and dispatches; it writes nothing a task writes,
and edits no file a running task owns. Every agent is a task on the
task tracker at `.ok-planner/bin/tasks`, drained by the loop at
`.claude/skills/_tasks/drain.md`. A task that closes `partial` is
refiled for its remainder with `tasks refile <task>`, and one that
closes `blocked` is refiled once.

Uncommitted work is the only record of the run. Every task stages
the paths it touched, by name, as it closes. Never run `git
checkout`/`restore`/`reset`/`stash`/`clean` on your own initiative;
fix a bad edit forward by editing again. The archive and the commit
are the owner's one act after completion, and the run never pushes.
```

---

### {{CEREMONY-ARCHIVE}}

The owner's archive and commit for a run a ceremony other than `/plan-sprint` planned. `<folder>` is the run's folder under `.ok-planner/`, such as `doc-sprints`, and `<stamp command>` is the command its boilerplate names.

```
Offer the archive and the commit as one owner act, and wait. "Finish
the run" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Move the run's document and every file beside it that shares its
   filename (its `-run.jsonl`, `-base.txt`, and `-completion.md`
   files, its prompt files, and its sidecar folder) to
   `.ok-planner/history/<folder>/`: `git mv` for a tracked file, `mv`
   for an untracked one.
2. Stage by name every path the run's tasks staged, every moved file
   at its new path, and the intake's two files where the run filed an
   issue. Commit those paths alone with `git commit -- <paths>`,
   naming only paths that exist or that `git mv` removed, so nothing
   else standing in the index rides along.
3. Run `<stamp command>` with the commit's sha. It adds `closed:
   <sha>` to the archived document and writes the state the next
   plan reads. Stage what it wrote, by name, and commit that alone.
```
