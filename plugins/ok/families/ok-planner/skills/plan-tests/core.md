# Plan-tests core

The blocks `/plan-tests` and the test sprint use: the scenario definition, the runtime classes, the call rule, the four planning prompts, and the five run prompts. `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a value the session fills before it registers the prompt. Tokens from `skills/_shared/dispatch-discipline.md` resolve only where the token stands alone on its line.

---

### {{TEST-SCENARIO-DEFINITION}}

```
A test checks one scenario, and a scenario exists in two cases only:

1. A story names it, and executable code carries it. Each way the
   story says its benefit comes is a candidate. Only the part a
   program does counts: a script, a service, a library, a tool. A
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

Each story's way of giving its benefit yields at most one scenario
per program that carries it, and each runtime pairing of part, class,
and harm yields one. A scenario's text states the outcome a user or
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
--field choice="<one line>" --body "<the call and what you weighed>"
--task <task>`.
```

---

### {{TEST-STORY-PLANNER-PROMPT}}

The task prompt for a story planner, one task per story. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan one story's scenarios

  {{LEAF-AGENT-RULE}}

  You plan the scenarios of the story your brief names, for the test
  sprint at [TEST SPRINT PATH]. You write no file in the project. You
  record each scenario as an item, and the session assembles the plan
  from the items.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The story at `.ok-planner/design/stories/<slug>.md`, whole.
  2. The scenarios the stamp recorded for it: `.ok-planner/bin/tests
     scenarios --json`, the entries whose source is `story:<slug>`.
     Read each one's test whole.
  3. The window: `.ok-planner/bin/tests window --json`. For each
     recorded scenario, read what changed since the stamp in the code
     its test reaches: `git diff <stamp> -- <path>`. Read each sprint
     the window names as closed since the stamp: its Intent, its Work
     items, and its Implementation notes, for what each change meant.
  4. The last run of the suite, at the path your brief names: each
     recorded scenario's pass or failure and its output tail.
  5. The code that carries the story. Find the programs a user runs to
     get the benefit, and read each entry point and the path it
     takes.

  ### Plan

  Record one item per scenario, recorded or new, with its action:

  | What you find | Action |
  |---|---|
  | The test passes, and its scenario is unchanged. | `keep` |
  | The story's text dropped the scenario. | `retire` |
  | Code supports a way the story gives its benefit, and no scenario covers it. | `new` |
  | The story names a way no code supports. | `gap` |
  | The stamp recorded a gap, and code now supports it. | `new` |
  | The outcome is unchanged, and only how the test reaches the code changed, such as a renamed command. | `rewrite`, with a call |
  | The test fails, and nothing in the window explains why. | `keep`: the run fixes the code |
  | The test fails, and the stamp marks it with an issue still open. | `keep`: it fails until a sprint settles the issue |
  | The outcome the scenario checks changed. | `keep`, and a question |
  | The code the scenario reaches is gone, and the story still stands. | `keep`, and a question |

  A question is the owner's alone. The owner answers retire, rewrite
  to the new behavior, or file an issue so a sprint restores the old
  one. Decide none of these yourself.

  Name a new scenario `<story slug>--<a short slug for the way>`. For
  `new` and `rewrite`, name the test's path under the project's test
  paths, its name inside the file where `testing.run` in
  `.ok-planner/config.json` holds `{name}`, its support files, and how
  it reaches the code: the public entry point it calls, what it sets
  up, such as a scratch project in a folder `mktemp -d` makes or a
  stack run, and what it checks.

  ### Record

  Per scenario: `tasks item add --pool scenarios --key <slug> --field
  id=<id> --field source=story:<slug> --field action=<action> [--field
  path=<test path>] [--field name=<test name>] [--field
  'support=["<path>", ...]'] [--field reach="<how it reaches the
  code>"] [--field call="<why, for a rewrite>"] --body "<the outcome
  the scenario checks, in one sentence>" --task <task>`. A `keep`
  needs no path: the stamp recorded it. A `keep` you raise a question
  on also names the test's path and name and its reach as a rewrite
  to the new behavior would write them, so the owner's rewrite answer
  needs nothing more.

  Per question: `tasks item add --pool questions --key <id> --field
  scenario=<id> --field kind=<outcome-changed | code-removed> --body
  "<what changed, with the commit, and the three answers as they apply
  here>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<slug>: <n> scenarios:
  <the count per action>; <q> questions"`.
```

---

### {{TEST-RUNTIME-PLANNER-PROMPT}}

The task prompt for the runtime planner, one task. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan the runtime scenarios and find the unguarded programs

  {{LEAF-AGENT-RULE}}

  You plan the runtime scenarios for the test sprint at [TEST SPRINT
  PATH], and you find each program no story serves. You write no file
  in the project.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-RUNTIME-CLASSES}}

  ### Read

  1. The accept list at `.ok-planner/review/catalog/accept.md`.
  2. The scenarios the stamp recorded whose source is `runtime`, and
     the programs it recorded as unguarded: `.ok-planner/bin/tests
     scenarios --json`. Read each runtime scenario's test whole.
  3. The window, `.ok-planner/bin/tests window --json`, and what
     changed since the stamp in the code each runtime test reaches.
  4. The last run of the suite, at the path your brief names.
  5. The code: list the runtime parts the product holds or depends on,
     and the executable entry points, as `.ok-planner/review/project.md`
     and the tree show them.
  6. The story catalog, `.ok-planner/design/stories.md`, and each
     story an entry point may serve.

  ### Plan

  1. Per runtime part, name each class that applies, and per class
     each accept-list harm that follows when the part fails that way.
     Each pairing the code can meet is a scenario. Record each one, and
     sort each recorded runtime scenario as the story planner's table
     sorts a story's: `keep`, `retire` where the part is gone, `new`,
     or `rewrite`. Name a new one `runtime--<part>--<class>`, with the
     harm's entry where one part and class carry two harms. For `new`
     and `rewrite`, say how the test causes the condition from outside
     the product: two processes at once, a process killed between two
     writes, a file made unreadable, a full disk in a small mounted
     folder, a stored file written by the old version. A test never
     changes product code to cause its condition.
  2. Per executable entry point, name the stories it serves. Each
     entry point no story serves, and that the stamp does not record
     as unguarded, is a question for the owner.

  ### Record

  Per runtime scenario: `tasks item add --pool scenarios --key runtime
  --field id=<id> --field source=runtime --field part="<part>" --field
  class="<class>" --field harm=<A1 to A9> --field action=<action>
  [--field path=...] [--field name=...] [--field 'support=[...]']
  [--field reach="<how it causes the condition and what it checks>"]
  --body "<the outcome the scenario checks>" --task <task>`.

  Per unguarded entry point: `tasks item add --pool questions --key
  <path> --field path=<path> --field kind=unguarded --body "<what the
  program does, and the two answers: an issue asking /plan-sprint for
  the story it serves, or no guard>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> runtime scenarios;
  <u> unguarded entry points"`.
```

---

### {{TEST-SORT-PROMPT}}

The task prompt for a sort agent, one task per batch of test files no scenario claims. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Sort a batch of legacy tests

  {{LEAF-AGENT-RULE}}

  You sort the test files your brief names, for the test sprint at
  [TEST SPRINT PATH]. No scenario claims them yet: they are a legacy
  suite, or tests a person added. You write no file in the project.
  Your brief names the files. A file your brief marks `claimed` holds
  a test a scenario claims and changed since the stamp: sort only the
  tests in it no scenario names, and where every test in it is a
  scenario's or a support's, record one entry for the file with sort
  `claimed`.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. Each file whole.
  2. The scenarios the story planners and the runtime planner
     recorded: `tasks item list --pool scenarios --json`.
  3. The story catalog, `.ok-planner/design/stories.md`, and each
     story a test may check.
  4. The written rules a test may enforce: the decisions under
     `.ok-planner/design/decisions/`, the practices under
     `.ok-planner/practices/`, `.ok-planner/release-boundaries.md`,
     and the rules files under `.claude/rules/`.

  ### Sort

  Sort each test: each test by its name where `testing.run` in
  `.ok-planner/config.json` holds `{name}`, each file otherwise. Every
  file you are given gets at least one entry.

  | The test | Sort |
  |---|---|
  | It checks the outcome a recorded scenario states, as the scenario states it. | `adopt`, into that scenario |
  | It checks a way a story gives its benefit that no scenario names, and code carries it. | `adopt`, into a scenario you record |
  | It enforces a written rule on the code's shape, such as a module boundary or a naming rule. | `port`, naming the rule and the check it becomes |
  | It checks the code against itself, or a behavior no story or rule names. | `delete`, as an orphan |
  | Another test already checks the same scenario. | `delete`, as a duplicate |
  | It is a fixture or a helper that an adopted test uses. | `support`, naming the scenarios it serves |
  | It is a claimed file, and every test in it belongs to a scenario. | `claimed` |

  A test that checks an outcome the story no longer promises is an
  orphan, even where it passes. Before you adopt a test, run it once:
  `.ok-planner/bin/tests run --from <a file in a folder mktemp -d
  makes, holding [{"path": ..., "name": ..., "scenario": ...}]>`. A test
  that fails because the code breaks its scenario stays adopted, and
  the run fixes the code. A test that fails because it expects what
  the scenario no longer states is an orphan, and the scenario gets a
  new test. Record your reason as a call.

  A port's check is a program outside every test path, such as
  `checks/<rule>`, that takes the changed files' paths as arguments,
  as `.ok-planner/review/config.json` `checks` commands do, and exits
  nonzero on a breach.

  ### Record

  Per entry: `tasks item add --pool legacy --key <file> --field
  path=<file> [--field name=<test name>] --field sort=<sort> [--field
  scenario=<id>] [--field reason=<orphan | duplicate>] [--field
  rule=<kind:slug, or the rules file>] [--field check=<the check's
  path>] [--field 'scenarios=["<id>", ...]'] --body "<what the test
  checks, in one line>" --task <task>`.

  A scenario you record for a test no scenario names: `tasks item add
  --pool scenarios --key <story slug> --field id=<story slug>--<way>
  --field source=story:<slug> --field action=adopt --field path=<file>
  [--field name=<test name>] --body "<the outcome it checks>" --task
  <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> tests: <the count
  per sort>"`.
```

---

### {{TEST-PLAN-REVIEW-PROMPT}}

The task prompt for the plan's review, one task. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Review a test sprint's plan

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the plan of the test sprint at [TEST SPRINT PATH] before
  the owner approves it. Print it: `.ok-planner/bin/tests plan
  --sprint [TEST SPRINT PATH] --show`. Read the test sprint whole, and
  each story the plan names.

  {{TEST-SCENARIO-DEFINITION}}

  ### Check

  - Every scenario names a story's way of giving its benefit, as far
    as a program carries it, or a runtime pairing of part, class, and
    harm. No story way yields two scenarios for one program.
  - Every scenario's text states an outcome, not how the code reaches
    it.
  - Every owner answer in the test sprint's Owner answers section
    holds in the plan as the owner gave it.
  - Every `new` and `rewrite` says how its test reaches the code
    through a public entry point, and every runtime one how it causes
    its condition from outside the product.
  - Every legacy `port` names a written rule, and every `adopt` a
    scenario whose text the test checks.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario or file> --field fix="<what the planner must
  change>" --body "<what breaks which check>" --task <task>`. Close:
  `tasks close <task> --outcome done --result "<n> findings"`.
```

---

### {{TEST-WRITE-PROMPT}}

The task prompt for a test task in the run. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Write, rewrite, or retire one scenario's test

  {{LEAF-AGENT-RULE}}

  You work one scenario of the test sprint at [TEST SPRINT PATH]. Your
  brief names the scenario, its action, the outcome it checks, its
  source, its test's path and name, its support files, how the test
  reaches the code, and any owner ruling. You change test files only:
  the files your task's files name. You change no product code.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The scenario's story at `.ok-planner/design/stories/<slug>.md`,
     or for a runtime scenario the accept-list entry it names.
  2. The code the brief's reach names: the public entry point, and
     the path it takes, enough to call it as a user does.
  3. `testing.run` in `.ok-planner/config.json`: the command that runs
     one test, which your test must suit.
  4. For a rewrite or a retirement, the test as it stands.

  ### Write

  - Check the scenario's outcome, and nothing else. Reach the code
    through its public entry point: the command, the route, the
    exported function. Mock nothing the scenario checks.
  - Cause a runtime condition from outside the product, as the reach
    says. Change no product code to make a condition possible.
  - Set up in a folder `mktemp -d` makes, or on a stack run the
    project's stack tool opens, and tear it down on every exit. Write
    nothing into the project's tree when the test runs.
  - Write no comment: the lint's comment rule covers test files too.
  - For a retirement, delete the test, and each support file no other
    test uses. For a rewrite at a new path, delete the old test the
    same way.

  Run the test once: `.ok-planner/bin/tests run --sprint [TEST SPRINT
  PATH] --only <id>` runs it without recording a round, once your
  record below names it. Where it fails because the code never did
  what the scenario says, and never supported it, the scenario is a
  gap: delete the test, and record the gap. Where it fails because the
  code broke what it once did, keep the test: the run's fixers fix the
  code.

  ### Record

  `tasks item add --pool tests --key <id> --field scenario=<id> --field
  path=<test path> [--field name=<test name>] --field 'support=["<path>",
  ...]' --body "<what the test does, in one line>" --task <task>`. For
  a retirement: `--field scenario=<id> --field retired=true`. For a
  gap: `--field scenario=<id> --field gap=true --body "<why no code
  supports it>"`.

  {{TEST-CALL-RULE}}

  ### Close

  Stage every file you changed by name: `git add <file>`, or `git rm
  <file>` for a deletion. Never run `git checkout`/`restore`/`reset`/
  `stash`/`clean`. `tasks close <task> --outcome done --result "<id>:
  <written | rewritten | retired | gap>" --staged <file> ...`.
```

---

### {{TEST-LEGACY-PROMPT}}

The task prompt for a legacy task in the run, one per legacy file the plan ports from or deletes from. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Port and delete the legacy tests of one file

  {{LEAF-AGENT-RULE}}

  You work one legacy test file of the test sprint at [TEST SPRINT
  PATH]. Your brief names the file, each test in it to delete with its
  reason, each test to port with the rule it enforces and the check it
  becomes, and each test to keep as written. You change only the files
  your task's files name.

  ### Work

  1. Read the file whole, and `.ok-planner/bin/tests plan --sprint
     [TEST SPRINT PATH] --show`, for the entries that name it.
  2. Per port: write the check at the path the brief names, outside
     every test path, as a program that takes the changed files' paths
     as arguments and exits nonzero, naming the file and the rule, on
     each breach. Make it check what the test checked. Run it over
     every file it applies to in the tree: it must pass on the tree as
     it stands, as the test did. Then delete the test.
  3. Per deletion: delete the test. Where nothing the brief keeps
     remains in the file, delete the file.
  4. Leave every test the brief keeps exactly as written, and keep
     what it needs from the file, such as its imports.

  Write no comment. The lint's comment rule covers checks and test
  files too.

  ### Record

  Per port: `tasks item add --pool ports --key <file> --field
  test=<file>[::<name>] --field rule=<the rule> --field
  command="<the command review checks runs, such as python3
  checks/<rule>>" --body "<what the check enforces>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  Stage every file you changed by name: `git add <file>`, or `git rm
  <file>`. Never run `git checkout`/`restore`/`reset`/`stash`/`clean`.
  `tasks close <task> --outcome done --result "<file>: <p> ported, <d>
  deleted" --staged <file> ...`.
```

---

### {{TEST-SWEEP-PROMPT}}

The task prompt for a sweep task in the run. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Settle the stray test files

  {{LEAF-AGENT-RULE}}

  Your brief names test files that no planned test of the test sprint
  at [TEST SPRINT PATH] claims as its own or as support: a fixture, a
  helper, or a data file the deleted tests used, or one an adopted or
  new test uses and no record names.

  Per file, find whether a live test uses it: `.ok-planner/bin/tests
  plan --sprint [TEST SPRINT PATH] --show` lists the tests, and `tasks
  item list --pool tests --json` the support each test task recorded.

  - Where a live test uses it, record it as that test's support: `tasks
    item add --pool tests --key <id> --field scenario=<id> --field
    path=<the test's path> [--field name=<the test's name>] --field
    'support=[<every support file the test uses>]' --body "support
    recorded by the sweep" --task <task>`. The latest record per
    scenario stands, so name the test and all its support.
  - Otherwise delete it: `git rm <file>`, or `rm` for an untracked one.

  {{TEST-CALL-RULE}}

  Never run `git checkout`/`restore`/`reset`/`stash`/`clean`. `tasks
  close <task> --outcome done --result "<s> recorded as support, <d>
  deleted" --staged <each deleted file>`.
```

---

### {{TEST-FIX-PROMPT}}

The task prompt for a fix task in the run. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Fix the code for one failing test

  {{LEAF-AGENT-RULE}}

  One test of the test sprint at [TEST SPRINT PATH] fails. Your brief
  names its scenario, the round, the test, its output's tail, and,
  where a verifier sent the last attempt back, why. You fix the code
  so the scenario's outcome holds. You did not write the test, and you
  change no test: no file at a test path, no support file, no fixture.

  ### Read

  1. The scenario, `.ok-planner/bin/tests plan --sprint [TEST SPRINT
     PATH] --show`, and its story or its accept-list entry.
  2. The test whole, to learn what fails. The test is right: it checks
     the outcome the scenario states.
  3. The code the test reaches, and the coding rules at
     `.claude/rules/plumbline-coding.md`.

  ### Fix

  Before you first edit a file, keep it as it stands:
  `.ok-planner/bin/tests snapshot --sprint [TEST SPRINT PATH] --key
  <your task's key> <file> ...`. Your verifier reads your change from
  that snapshot, and fixers run one at a time.

  Change the code so it does what the scenario says, for every user,
  not for the test. Never write code that checks whether a test runs,
  reads a setting only a test sets, treats the test's data as a
  special case, hides a failure behind a catch that swallows it, a
  longer timeout, or a retry, or fakes the effect the test looks for.
  Run the project's checks, `.ok-planner/review/config.json` `checks`,
  on every file you changed. Run the test: `.ok-planner/bin/tests run
  --sprint [TEST SPRINT PATH] --only <id>`.

  Where the code can meet the test only by changing what the design
  corpus commits to, change nothing, and record a promise: the test
  stays failing until a sprint settles it.

  ### Record

  A fix: `tasks item add --pool fixes --key <id> --field scenario=<id>
  --field round=<round> --field fix=<your task's key> --field
  'files=["<each file you changed>"]' --body "<what was wrong, and
  what you changed>" --task <task>`. Where the test passes before you
  change anything, as when a fix for another test fixed it too, record
  that instead: `--field 'files=[]' --field change=none --body "<the
  test passes as the tree stands>"`. Before you close, keep each file
  you changed as you leave it: `.ok-planner/bin/tests snapshot
  --sprint [TEST SPRINT PATH] --key <your task's key> --after <file>
  ...`. Where a verifier sent an earlier attempt back, the tool backed
  that attempt's change out before it filed you, and your brief says
  so.

  A promise: `tasks item add --pool promises --key <id> --field
  scenario=<id> --field round=<round> --field 'artifacts=["<kind:slug>",
  ...]' --body "<what the test needs, and the commitment that stands
  in its way>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  Stage every file you changed by name. Never run `git checkout`/
  `restore`/`reset`/`stash`/`clean`. `tasks close <task> --outcome
  done --result "<id>: fixed in <files> | promise" --staged <file>
  ...`.
```

---

### {{TEST-VERIFY-PROMPT}}

The task prompt for a verify task in the run. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Verify one fix or one promise

  {{LEAF-AGENT-RULE}}

  Your brief names one item of the test sprint at [TEST SPRINT PATH]:
  a fix a fixer recorded in the `fixes` pool, or a promise in the
  `promises` pool. `tasks item list --pool <pool> --json` prints it
  whole. You did not make it, and you change no file in the project.
  You run read-only commands, the one test the item's scenario names,
  the task tracker's verbs, and `.ok-planner/bin/issues file`, and
  nothing else.

  ### A fix

  Read the change: `.ok-planner/bin/tests diff --sprint [TEST SPRINT
  PATH] --key <the item's fix field>`, and the scenario and its test.
  An item with `change=none` changed nothing: accept it where the test
  passes. Send a fix back where any of these holds:

  - It checks whether a test runs, reads a setting only a test sets,
    or treats the test's data as a special case.
  - It hides a failure: a catch that swallows it, a longer timeout, a
    retry with no budget the code already had.
  - It fakes the effect the test looks for instead of doing the work.
  - It changes a file at a test path, a support file, or a fixture.
  - It breaks a rule in `.claude/rules/plumbline-coding.md`, or causes
    a harm the accept list at `.ok-planner/review/catalog/accept.md`
    names.
  - The test still fails: `.ok-planner/bin/tests run --sprint [TEST
    SPRINT PATH] --only <id>`.

  Accept it: `tasks item set <item> --state accepted`. Or send it back:
  `tasks item set <item> --state sent-back --field reason="<what to
  change>"`.

  ### A promise

  Read each artifact it names, the scenario, the test, and the code.
  The promise holds where no change to the code meets the test while
  the design corpus commits to what it says. Where it holds, file one
  issue with `.ok-planner/bin/issues file --from -` in the format of
  the `{{ISSUE-FILE-FORMAT}}` block of
  `.claude/skills/_shared/artifact-definitions.md`: kind `sprint`,
  category `product-intent`, the test, the failure, and the
  commitment as its problem, and two options: change the commitment,
  or retire the scenario. Then `tasks item set <item> --state held
  --field issue=<the issue id>`. Otherwise `tasks item set <item>
  --state rejected --field reason="<the change that meets the test>"`.

  ### Close

  `tasks close <task> --outcome done --result "<item>: <accepted |
  sent-back | held | rejected>"`.
```
