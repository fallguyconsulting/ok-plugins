# Sprint shared blocks

The blocks `/plan-sprint`, the sprint's execution boilerplate, and `/converge` share; `/converge` reads them through `block_sources` in `.ok-planner/review/config.json`. Each is defined here once; a prompt transcludes it by name, resolved only where the token stands alone on its line, as in `../_shared/dispatch-discipline.md`.

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
across it, what crosses it, and where in the tree to look. A boundary
need not be part of the declared public surface.

One boundary applies to every project and is never declared:

  Stored state. Data an earlier release wrote and a later release
  reads or writes: database rows and columns, files and objects,
  configuration files a running deployment holds, messages waiting in
  a queue. The data does not update when the code does.
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
   or newer part within the same major version, or stored data, stops
   working, and no compatible form of the change reaches the outcome.
   The owner decides whether the release is a major one, or whether
   the outcome changes. A decision under `.ok-planner/design/`
   states the rule where the project declares one.
3. Two readings of an owner's ruling lead to results a user can
   observe that differ, and the corpus does not pick between them.

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

### {{RELEASE-DOCUMENTS-RULE}}

Carried by every prompt that reads or edits the tree during a sprint: the build prompt below, and `/converge`'s sprint review, sprint pass, and fix prompts. The rule: the documents a release generates are records of that release, which the next `/document` rewrites whole.

```
The documents the release regenerates are out of scope. They are
every file at a target a declared document type names under
`.ok-planner/surface/documents/` (a folder target covers the folder)
and everything under `.ok-planner/documentation/`. `/document`
rewrites them whole at the next release. Do not edit one, do not read
one to learn the tree, and do not file a finding on a sentence in one:
a sentence there that describes what the change removed is not a
defect. Rule files under `.claude/rules/` and infrastructure files
are not such documents.
```

---

### {{SPRINT-BUILD-PROMPT}}

The build task prompt for a sprint written by `/plan-sprint`. It carries the coding rules `/converge`'s fixers follow, keeps the sprint's rulings, and sends what a builder meets outside its files to the owner rather than into the review. `[SPRINT PATH]` is the sprint document.

```
Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  {{LEAF-AGENT-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

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
    a concept, story, or decision and `.ok-planner/subjects/` or
    `.ok-planner/practices/` for a subject or practice, or delete the
    file for a retirement. After a subject or practice delta, run
    `python3 .ok-planner/bin/catalog-toc` to regenerate that
    collection's TOC.
  - Every new or amended story implemented in code carries the
    `@story:` annotation at the site that realizes it.
  - Keep each ruling your brief names. A `preserve` behavior stays
    unchanged for its users across the boundary. A `migrate` behavior
    lands its migration in this stage. A `rewrite` behavior brings
    every user the notes list along.
  - Where your code changes a behavior a user can observe and the
    notes list no such change, record it: `tasks item add --pool
    divergences --key <your key> --field kind=call --body "unlisted
    behavior change: <path::symbol>; before: <...>; after: <...>;
    users: <...>" --task <task>`. Sprint certification judges it.
  - Completeness is the floor. Deliver every outcome the brief
    promises, or close `blocked` naming what stops you. A stub, a
    `TODO`, or a no-op standing in for an outcome is an undelivered
    outcome.
  - Run the project's checks (`.ok-planner/review/config.json` `checks`
    lists them) on every file you changed, in the foreground, and close with no
    process of your own still running. Leave the tree runnable.

  ### The coding rules

  {{CONVERGE-CODING-RULES}}

  ### Calls, forks, and what you notice

  Where the sprint is silent, make the most plausible call, continue,
  and record it: `tasks item add --pool divergences --key <your key>
  --field kind=call --body "<the call>" --task <task>`. Where the
  sprint and corpus do not decide and reasonable owners diverge, build
  the reading you judge best and record the fork with its options:
  `--field kind=fork --state fork`. Sprint certification settles every
  fork: one the sprint or corpus decides becomes work or nothing, and
  the rest become questions for the owner.

  A defect you meet outside your files is recorded once and left;
  sprint certification reads it as a report: `tasks item add --pool
  divergences --key <your key> --state noticed --field kind=noticed
  --field file=<path> --body "<the site; the harm>" --task <task>`. A site outside your files that your own
  change must reach (a caller of a definition you changed) is yours:
  stage what you built and close `partial` with a result that starts
  `outside files: <path>: <site>`.

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
| C3 | Delta not landed | A corpus delta whose artifact (under `.ok-planner/design/`, or under `.ok-planner/subjects/` or `.ok-planner/practices/` for a subject or practice) does not match the delta's final-form body byte for byte, or is not deleted for a retirement. | the delta; the artifact; the first differing line |
| C4 | Commitment contradicted | Code in the change contradicts a commitment a corpus artifact states that the sprint's deltas or work items name. | the artifact and its sentence; the code site; what the code does instead |
| R1 | Preserved behavior changed | A `preserve` behavior change whose users across the boundary now observe a difference. | the B-id; before and after, from the code at the base and now |
| R2 | Migration not as ruled | A `migrate` behavior change whose old users neither keep working nor get the refusal its ruling states. | the B-id; the ruling; what an old user gets now |
| R3 | Rewrite left a user behind | A `rewrite` behavior change with a user in the release the change did not update, whose goal now fails. | the B-id; the user; its goal and source; what it gets now |
| R4 | Unlisted change breaks a user | A behavior change the notes do not list, with a user in the release whose goal now fails on some path. | the changed site; the user; its goal and source; the trigger, old outcome, new outcome |
| R5 | Boundary user not ruled | A behavior change with a user across a boundary that no ruling covers: the notes do not list the change, or list it without naming that user. | the changed site or B-id; the boundary and its user; before and after |
| M1 | Check fails | A check `.ok-planner/review/config.json` names fails on a file the change touched. Filed by the session. | the check; the file; the output |

An unlisted behavior change that meets every user's goal is not a
defect; it is recorded for the owner as a `kind=unlisted` call. A
change a work item or delta asks for is not a regression; the
completion classes cover it. A story the sprint adds or amends is
checked by the drive, and the merge agent sorts its failures.

#### How to state a report

State the failure, not the edit: the fixer chooses the fix, and a
report that names an edit narrows the fix to that edit. One report per
failure; two paths that fail through one site the same way are one
report.
```

<!-- Materialized by ok-planner v24.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
