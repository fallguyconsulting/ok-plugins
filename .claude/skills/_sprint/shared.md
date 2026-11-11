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
  A gated element is internal whatever its class, so changing or
  removing one crosses no release boundary.
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

### {{NO-PERSON-RULE}}

```
No step of a sprint's execution or certification waits on a person.
The rule binds each work item, each call in the implementation notes,
each line the notes have the build write into
`.ok-planner/review/project.md`, and the drive of each story.

An element needs a person when a builder, a fixer, or a driver can
finish it only after a person acts: an owner act on the running
product, a sign-in or consent a person completes, input only a real
user gives, or a credential a person fetches. Planning questions and
Approval wait on no step of execution, since a person is present for
them, and the archive and commit after the close stay the owner's one
act.

Where a story's benefit passes through a party outside the product,
such as a third party's sign-in or input only a real user gives, the
sprint builds a local stand-in for that party. The project's stack
runs the stand-in, the review facts name it under `## Stand-ins for
outside parties`, and the drive and the tests use it. A stand-in
replaces only that party, never the product's own code: the product
reaches the party at an address its configuration sets, and the
stack's configuration points that address at the stand-in. A stand-in
adds no gated element and no test branch to product code.

A step that needs a person is never a reason to leave work out of a
sprint. Reshape the element so no person is needed.
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
  - Where the stage builds a stand-in for a party outside the product,
    name it in the same stage under `## Stand-ins for outside parties`
    in `.ok-planner/review/project.md`, with how the stack runs it and
    how a driver and a test reach it; add the heading where the file
    lacks it.
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
  - A code stage adds, edits, deletes, and runs no test: the sprint's
    test stages own the tests. Leave every file at a test path as it
    stands. Where a check fails only because a test reaches code the
    stage changed or removed, record it as a call naming the test, and
    go on: the sprint's test stages and its certification settle the
    test.

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

What counts as a defect in sprint certification (`/converge sprint`). The sprint passes and the suite's reports report under it, and the merge agent judges their reports by it.

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
| T1 | A test fails | A test the sprint runs fails in a whole-suite round, or stands failing since one, and no held promise or owner issue settles it. Filed by `tests reports`. | the scenario; the round; the output tail; whether it failed again when run alone |
| T2 | A leftover count grew | A count `testing.leftovers` prints grew over a round: a test or the product left that kind of resource behind. Filed by `tests reports`. | the kind; the counts before and after; the round |
| T3 | A product is slow | A speed reviewer found a test slow because the product is, a `perf:` entry: the site does work its answer does not use. Filed by `tests reports`. | the site as path::function; what it does; how its cost grows; the cheaper behavior; the speed item |
| T4 | A schedule breach | The suite command ran two tests at the same time that `testing.schedule`'s form forbids together, a `schedule--` entry. Filed by `tests reports`. | the two tests; the form; each one's start and arrival; the round |

A C3 defect is fixed in the run by landing the delta: its fixer
copies the delta's body into the artifact, or deletes the retired
file, and regenerates the catalog TOCs, the docspec index among them.

A T1 to T4 defect is in the sprint's scope whatever the base shows:
its test checks a promise of the sprint or the corpus. Its fixer
changes code, never a test. A test at fault goes back to a test task
once a verifier agrees the product is right, and only a change to
what the corpus commits to holds a test failing, once a verifier
agrees it is a promise. A T4 defect takes a support task, never a
fixer.

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

The reading of a sprint's change: `/converge`'s sprint review root does it once, and a sprint pass reissued to a fresh agent does it in the root's place. The block names the base commit `<base>` and the sprint's path `<sprint>`, which the prompt states above it.

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

How a documentation sprint, the run `/plan-docs` plans, executes. The executing session follows these rules beside the steps its own boilerplate gives.

```
Work unsupervised to a defensible done. Do not pause for approval,
confirmation, or progress checks, and file no task for the owner to
perform. Stop only on a genuine blocker: a credential or access you
cannot obtain, a step impossible in the current state, a destructive
or irreversible action not clearly authorized, or a task closed
`blocked` twice. To stop, wait until no agent you started still runs,
then write the stop record: the file beside the documentation sprint
with its filename, `-stopped` before the extension and `.txt` as the
extension, holding the reason as plain text, one line per reason.
Then run `.ok-planner/bin/docs complete --sprint <the documentation
sprint's path>`, show its output whole, and stop. While the record
stands, it prints `DOCS STOPPED` with the reason, which ends the goal.
Where a tool that command loads is missing, it cannot run: the
documentation sprint's step 3 says how that stop ends the goal.
A new `/goal` on the documentation sprint resumes the run from its
base and its task record. Ambiguity is not a blocker: the agent makes
the most plausible call, records it, and goes on.

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

### {{CEREMONY-VETO}}

The owner's veto at the close of a sprint or a documentation sprint. `<rows>` is each row of the completion report the close presents for the veto, and `<problem>` is what a vetoed row's issue states.

```
Ask the owner once which of <rows>, if any, the owner vetoes. For each
vetoed row, file one issue with `.ok-planner/bin/issues file --from
-`, in the format of the `{{ISSUE-FILE-FORMAT}}` block of
`.claude/skills/_shared/artifact-definitions.md`: kind `human`,
category `product-intent`, its problem <problem>. Then record the
owner's words as that issue's ruling with `.ok-planner/bin/issues
rule <id> --text -`, the words on stdin, so the next `/plan-sprint`
pulls the veto in as the owner's decision. `issues rule` signs the
ruling with the name of the person running the session; where it
refuses for want of a name, relay the refusal's setting text to the
owner and record the ruling once a name resolves.
```

---

### {{CEREMONY-ARCHIVE}}

The owner's archive and commit for a documentation sprint, the run `/plan-docs` plans. `<folder>` is the run's folder under `.ok-planner/`, `doc-sprints`, `<also>` is each file the session itself wrote outside that folder that the commit carries, or none, and `<stamp command>` is the command its boilerplate names.

```
Offer the archive and the commit as one owner act, and wait. "Finish
the run" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Run `.ok-planner/bin/tasks split <path> ...` on each JSON Lines
   file this step moves, its `-run.jsonl` among them, and show its
   output whole. It splits each file larger than
   `archive.part_bytes` in `.ok-planner/config.json` into numbered
   parts beside it, `<name>.part<n>.jsonl`, and removes the whole
   file from git's index and the disk; it leaves a smaller file
   whole. Then move the run's document and every file beside it that
   shares its filename (its `-run.jsonl` or that file's parts, its
   `-base.txt` and `-completion.md` files, its prompt files, its
   sidecar folder, and its `-stopped.txt` stop record where one
   stands) to `.ok-planner/history/<folder>/`: `git mv` for a
   tracked file, `mv` for an untracked one.
2. Stage by name every path the run's tasks staged, every moved file
   at its new path, each file `<also>` names, and the intake's two
   files where the run, or the planning session before it, filed an
   issue. Commit those paths alone with `git commit -- <paths>`,
   naming each path that exists and each removed path the last commit
   holds, a `git mv` source, a whole file the split removed, or a file
   a task removed with `git rm` among them, and no other, so nothing
   else standing in the index rides along.
3. Run `<stamp command>` with the commit's sha. It adds `closed:
   <sha>` to the archived document and writes the state the next
   plan reads. Stage what it wrote, and each path it names as removed,
   by name, and commit that alone.
```

---

### {{PLANNING-HANDOFF}}

The last step of `/plan-sprint` and `/plan-docs`, after the owner approves and the session's own writes are done: it leaves the tree ready for execution's base step, then hands over the goal line. `<goal path>` is the approved document's path from the project root: `.ok-planner/sprints/<name>.md` for a sprint, `.ok-planner/doc-sprints/<name>.md` for a documentation sprint.

```
Run `git status --porcelain`. The planning session's own files lie
under `.ok-planner/` and stay uncommitted, as execution's base step
expects. Where the status lists no path outside `.ok-planner/`, hand
over the goal line below.

Where it lists a path outside `.ok-planner/`, name every such path to
the owner, grouped by the work each belongs to, such as "true-up of
the vendored layer" or "out-of-band code". In the same message, ask
the owner once whether to commit them, and propose one commit per
group: its message and its paths, staged by name. A renamed path
counts as both its old and its new path.

On the owner's yes, for a documentation sprint, first run `git
rev-parse HEAD`. Then make each proposed commit: `git add -- <paths>`
for the group's untracked paths, then `git commit -m "<message>" --
<paths>`, naming every path of the group and no other, so nothing
else standing in the index rides along. Then run `git status
--porcelain` again. Where it lists no path outside `.ok-planner/`,
hand over the goal line. Where it still lists one, go on as on a no.
For a documentation sprint, once the commits are made, rewrite its
Window's ``Planned against commit `<sha>`.`` line only where both of
these hold: the `HEAD` printed before the first commit is the commit
`/plan-docs` recorded at its window, and `git diff --name-only <the
tree /plan-docs recorded at its window> HEAD -- <every path the
commits named>` prints nothing. Then the commits hold only what the
plan read from the tree: write the output of `git rev-parse HEAD`
into the line in place of the commit the plan recorded, so
execution's start check counts none of them against the plan. Where
either fails, leave the line as it stands: a commit made after the
window, or a path changed after it, may hold what the plan never
read, and execution's start check weighs it against the plan.

On the owner's no, name each path outside `.ok-planner/` that still
stands, and say that execution's base step refuses to start while
any such path stands uncommitted: it names those paths and stops,
because the run would count them as its own work. Hand over no goal
line.

The goal line starts execution under the native `goal` mechanism.
Its tail carries the owner's opt-in to running each drain as a
Workflow script, in words the owner types, since the harness runs a
Workflow script only on the owner's own words. Hand it over whole,
the path stamped in:

    /goal <goal path> — run each drain as a workflow
```

---

### {{TEST-SCENARIO-DEFINITION}}

```
A test checks one scenario, and a scenario exists in two cases only:

1. A story names it, and executable code carries it: each distinct
   outcome a user or the product sees through a program, for any
   plausible way the story's implementation gives or refuses its
   benefit. Only the part a program does counts: a script, a service, a library, a tool. A
   skill, a rule, a document, and the design corpus are prose, and
   prose has no tests; the drive and review cover them. A story
   offered through a skill still has scenarios where a script behind
   the skill carries part of its benefit, as far as the script
   carries it.
2. A runtime class applies to a runtime part of the project, and one
   harm from the accept list at `.ok-planner/review/catalog/accept.md`
   follows when the part fails that way. A runtime part is something
   the product holds or depends on at run time: a stored file and its
   lock, a database, a queue, a second host, a long-running process,
   an outside service.

Two outcomes through one program are distinct when the user or the
product sees a different result: a different reply, a different
refusal, or a different state left behind. One outcome that two
programs show yields one scenario per program. A second scenario that
checks an outcome another scenario checks through the same program is
a duplicate. Each runtime pairing of part, class, and harm yields one
scenario. A scenario's text states the outcome a user or
the product sees, never how the code reaches it. A test that checks
the code against itself, such as a test of one function's current
return value, checks no scenario.

A scenario a story names that no code supports is a gap: it gets no
test, because a failing test builds no feature. Support is decided
once, when the test is written. After that, a failing test is a
regression, never evidence that the scenario is unsupported.

A program no story serves gets no scenario. The owner decides it:
an issue asks `/plan-sprint` for the story it serves, or the
scenario list records it as unguarded.
```

---

### {{TEST-RUNTIME-CLASSES}}

```
| Class | Example |
|---|---|
| Concurrency | Two writers on one record, and one write is lost. |
| A dependency goes down | The database refuses connections. |
| A dependency is slow | A call never returns, and nothing times out. |
| A crash mid-operation | The process dies between two writes. |
| Shutdown and restart | Work in flight is lost or done twice. |
| Duplicate or out-of-order delivery | A retry repeats a write. An event arrives early. |
| Resources run out | The disk is full. The pool is empty. A rate limit hits. |
| Volume and long running | A million rows. A slow leak. |
| Time | Clock skew. A daylight-saving change. A token expires. |
| Version skew | New code reads old stored data. An old client calls a new server. |
| Bad data from outside | A dependency returns garbage. A file is corrupt. |
| Bad configuration | A missing setting. A missing permission. |

A class applies only where the project has the part it names.
```

---

### {{TEST-CALL-RULE}}

```
Where the scenario definition, the plan, and the rules above do not
decide a choice, make the most plausible one, go on, and record it,
for the owner's veto in the completion report: `tasks item add --pool
calls --key <scenario or file> --field site=<file or scenario>
--field kind=<untested | departure | scope | mechanics> [--field
story=<slug>] --field choice="<one line>" --body "<the call and what
you weighed>" --task <task>`.

Give each call the one kind that fits it:

- `untested`: the call leaves a behavior untested.
- `departure`: it departs from an owner answer.
- `scope`: it reads what a story covers.
- `mechanics`: it says how a test reaches the code or sets up, or how
  a legacy test was sorted.

A call about one story also names it: `--field story=<slug>`.
`tests plan` refuses a planner's call with no kind or a kind outside
these four.
```

---

### {{TEST-RESOURCES-RULE}}

```
A test is isolated by default: it touches only state it created and
named, and reads no shared resource, so it takes no lock and runs
beside any test the recorded schedule allows. A test that must change
shared state names each shared resource it changes in `resources`, as
a slug, such as `broker` for the test stack's message broker, `clock`
for its clock, or a deployment-wide setting. A test names each shared
resource it reads and does not change in `reads`, by the same slugs.

The testing standard recommends one schedule: two tests may run at
the same time unless one changes a resource the other changes or
reads. Tests that share a changed resource form one group, which runs
its tests one after another on one worker. `testing.schedule` records
the schedule the suite command runs, and each run of `tests run`
locks what its tests declare: an exclusive lock for a resource a test
changes, and a shared lock for one a test only reads.

Record `reads` on every test you plan: the shared resources it reads,
or `[]` where it reads none. A test that declares `resources` and
records no `reads` counts as reading every shared resource, each one
any live test changes or reads, so it runs apart from every test that
declares one. Plan the test so it needs no declaration where a
cheaper design allows: a clock the test injects, a broker or a record
of its own, or data of its own in place of shared data it reads.
Record `resources=[]` and `reads=[]` for an isolated test.
```

---

### {{TEST-WAITS-RULE}}

```
A test's verdict never waits on elapsed time. Name in `waits` what
each `new` and `rewrite` test waits on, one of:

- `event: <what the product emits>`: an event, a state it leaves
  behind, or a call's reply the product gives;
- `control: <the time control>`: a time control that makes the event
  happen now, sets the time the product sees, or sets how long it
  waits;
- `clock: <the clock the test moves>`: a clock the test injects into
  the product and moves forward.

A time control is product code every deployment carries, in one of
three forms: `trigger`, a manual trigger that runs a timed job at
once; `clock`, an injectable clock that gives the product its time
from outside; or `setting`, an exposed setting that gives a timer's
length or a threshold from configuration. Where the product has one
for the timer the outcome meets, name it as `control: <its name>`.
Where it has none, record a time control item with the id
`control--<a short slug for the timer>`, and name it as `control:
control--<slug>`. Each time control item becomes a work item of the
sprint, which a code stage builds before the test stages that use
it, and the owner approves each with the sprint. A trigger and a clock force an event or move the product's
time, so each sits behind a gate setting, on in the test stack's
configuration and off in production's: name its key in `gate`. A
setting has no gate. Name in `files` every file the time control
changes, each deployment configuration that carries its gate or its
setting included.
```

---

### {{TEST-SILENCE-RULE}}

```
Make every test as deterministically fast as it can be, and never
silent for long. `tests run` stops a run after `testing.silence`
seconds with no result line and no output, and the project keeps
that setting as small as it can. Every line the suite command prints
resets that clock. So make each test, and each tool under the
project's control that a test runs, print a line of progress as it
works: a step started, a step done, a record written.

A test that has no choice but to endure a longer stretch of
silence, such as one that waits on a program the project does not
control and that prints nothing, records a silence of its own: the
whole seconds it may go with no output, as `--field
silence=<seconds>` on its `tests` item. While that test has no
result, the run waits that long. The silence is an exception: record
one only where no progress line and no cheaper design keeps the test
inside `testing.silence`, and keep it as small as the wait needs. A
verifier or a speed reviewer sends back a silence that a progress
line or a cheaper design would remove.
```

---

### {{TEST-WASTE-RULE}}

```
Plan each test at the cheapest reach that still proves its outcome,
and spend its time on nothing else. The testing standard at
`.ok-planner/docs/testing.md` names these wastes; read it. Each of
these is a waste:

- A costlier reach than the outcome needs. An outcome inside one
  service is tested through that service's own entry point, its
  command, its route, or its exported function, with its clock
  injected. An outcome that crosses services is tested on the shared
  test stack. Only an outcome about bringing up a deployment brings
  one up. A cheaper reach drops the services the outcome does not
  cross, and fakes none it checks.
- Setup a test repeats that it could share safely, such as a sign-in
  or a stack per test, or, where the project has a seed
  `testing.setup` builds, data the test only reads that the seed could
  hold.
- A shared resource declared where a cheaper design keeps the test
  isolated.
- Work the outcome does not need, such as extra devices, records, or
  steps.
```

---

### {{TEST-SPEED-JUDGING}}

```
No number of seconds decides your verdict: you judge where the test's
time goes. Its time goes to its outcome's own work where the outcome
needs each service it starts, each record and step it makes, and each
resource it holds. Your brief names what the test costs the run's
wall time under the schedule `testing.schedule` records: how much the
round's lower bound on wall time under that schedule drops when the
test's seconds drop to zero. Tests that share a changed resource run
one after another in their group, so a test in the group that bounds
the round can cost up to its whole seconds, and a test the workers
spread costs about its seconds divided by the workers. The cost your
brief names already charges the test for its place in the schedule.

Send the test back where part of its time goes to one of the wastes
below, which the testing standard at `.ok-planner/docs/testing.md`
names, and a cheaper form proves the same outcome through the same
program: it mocks nothing the scenario checks, and its verdict waits
on what the scenario's `waits` names. Name the waste and the cheaper
form:

- A costlier reach: the entry point the outcome needs, and the
  services the cheaper reach drops.
- Repeated setup: the setup to share, and how the tests share it
  safely.
- A shared resource declared where a cheaper design keeps the test
  isolated: the design, such as a clock the test injects, or a
  broker or a record of its own, and each declaration the rewrite
  drops, in `resources` or in `reads`. A declaration keeps the test
  apart from every test it conflicts with, so this waste often costs
  the most.
- Work the outcome does not need: the devices, records, or steps to
  drop.
- A silence of its own that a progress line or a cheaper design
  would remove, or one longer than its wait needs: the progress
  line or the design, and the silence the rewrite records, or none.

Record the test as product-slow where part of its time goes to the
product, not the test: a site in the product code the test reaches
does work its answer does not use, such as reading every record to
answer about one. Name the site as `path::function`, what it does,
how its cost grows, such as with the records stored or the requests
made, and the cheaper behavior: the site doing only the work its
answer uses. Where the test also wastes time of its own, record the
larger verdict: product-slow where the site's extra work costs the
test more seconds than its own waste, and a send-back where its own
waste costs more. A product-slow verdict is never an acceptance: the
fix loop files a fixer for the site, keyed `perf:`, and once the fix
is accepted the test gets a fresh speed read.

Otherwise accept it. An earlier send-back never makes you accept: a
rewrite that left a named waste goes back again, naming what the
rewrite missed.
```

<!-- Materialized by ok-planner v31.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
