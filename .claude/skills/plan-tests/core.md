# Plan-tests core

The blocks `/plan-tests` and the test sprint use: the scenario definition, the runtime classes, the call rule, the revision rule, the six planning prompts, and the six run prompts. `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a value the session fills before it registers the prompt. Tokens from `../_shared/dispatch-discipline.md` resolve only where the token stands alone on its line.

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
- `scope`: it reads the plan's scope or what a story covers.
- `mechanics`: it says how a test reaches the code or sets up, or how
  a legacy test was sorted.

A call about one story also names it: `--field story=<slug>`.
`tests plan` refuses a planner's call with no kind or a kind outside
these four.
```

---

### {{TEST-REVISION-RULE}}

```
Where your brief says `revise task <id>`, the session found items of
that earlier task wanting and named each in your brief. Read every
item task <id> filed, in each pool this prompt records into: `tasks
item list --pool <pool> --json`, the entries whose `task` is <id>.
Refile each one under your own task as it was filed, with the same
`id` field, the same fields, and the same body, unless a failure or
finding in your brief names it. Change only what each failure or
finding names. Refile each question as it was filed, at state `open`:
the owner's answer stands for its scenario or program. Raise no new
question on a scenario or program the owner already answered.

Where task <id> planned stories your brief does not name, refile the
items of the stories your brief names alone: each one's `stories`
item, its scenarios, the questions on them, and the calls that name
it. The assembly takes every other story's items from task <id>.
```

---

### {{TEST-STORY-PLANNER-PROMPT}}

The task prompt for a story planner, one task per group of stories. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan a group of stories' scenarios

  {{LEAF-AGENT-RULE}}

  You plan the scenarios of each story your brief names, for the test
  sprint at [TEST SPRINT PATH]. You write no file in the project. You
  record each scenario as an item, and the session assembles the plan
  from the items.

  Your brief names each story with the reasons this run touches it:
  `new`, where no stamp stands and every story is planned; `changed`,
  where its file changed since the stamp; `cited <file>`, where a file
  that changed since the stamp cites it; `failed <scenario>`, where
  that recorded scenario's test failed in the last run; and `widen`,
  where the owner reopened the story for the outcomes an earlier
  plan's calls left out. Plan each story your brief names whole, save
  one whose only reason is `widen`, which you widen alone. Every story
  your brief does not name keeps its recorded scenarios.

  Your brief names the scope the owner set, in the owner's words and as
  its paths, and the owner's answer for each program no story serves.
  A file lies inside the scope where it equals a path, lies under a
  path that is a folder, or matches a path that is a glob, where `*`
  crosses `/`; `.` covers the project. Plan no `new` or `rewrite` whose
  test path, support files, or entry lie outside the scope, and none
  whose entry is a program the owner left unguarded: a path the stamp
  records as unguarded, or a no-guard answer your brief names.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  Steps 1, 2, 5, and 7 run once per story your brief names; steps 3,
  4, and 6 run once.

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
     takes. On each path, find each plausible way the implementation
     gives or refuses the benefit, and each distinct outcome a user or
     the product sees on it.
  6. The runner, in `.ok-planner/config.json`: `testing.run`, the
     command that runs one test, and `testing.timeout`, the time limit
     of one test in seconds, 600 where it is absent.
  7. For a story your brief marks `widen`, the calls the latest plan
     to plan it left for it: `.ok-planner/bin/tests calls <slug>
     --json`. Each is a choice a planner recorded that left a path out.

  ### Plan

  Record one item per scenario, recorded or new, with its action:

  | What you find | Action |
  |---|---|
  | The test passes, and its scenario is unchanged. | `keep` |
  | The story's text dropped a scenario the stamp recorded. | `retire` |
  | Code shows an outcome of the story that no scenario checks. | `new` |
  | The story names a way no code supports. | `gap` |
  | The stamp recorded a gap, and code now supports it. | `new` |
  | The outcome is unchanged, and only how the test reaches the code changed, such as a renamed command. | `rewrite`, with a call |
  | The test fails, and nothing in the window explains why. | `keep`: the run fixes the code |
  | The test fails, and the stamp marks it with an issue still open. | `keep`: it fails until a sprint settles the issue |
  | The outcome the scenario checks changed. | `keep`, and a question |
  | The code the scenario reaches is gone, and the story still stands. | `keep`, and a question |

  A way the story dropped that no scenario recorded gets no item.
  `keep`, `rewrite`, and `retire` sort only a scenario the stamp
  recorded, so a plan with no stamp records only `new` scenarios and
  gaps.

  A question is the owner's alone. The owner answers retire, rewrite
  to the new behavior, or file an issue so a sprint restores the old
  one. Decide none of these yourself.

  For a story your brief marks `widen`, read its recorded scenarios
  and the earlier calls together. For each outcome those calls left
  out, add a `new` scenario where the code supports it, or a `gap`
  where no code does: one scenario per distinct outcome, and none that
  checks an outcome a recorded or planned scenario checks through the
  same program. Where `widen` is the story's only reason, record only
  `new` and `gap` items and its `stories` item: each recorded scenario
  you name nowhere stands as recorded. Where the story has other
  reasons too, sort it whole and widen it in the same pass.

  Sort every recorded scenario of the story, whatever the scope. Where
  a `rewrite` would reach outside the scope, plan it `keep`, and record
  a call of kind `scope` that names the rewrite the scope left out.

  Name a new scenario `<story slug>--<a short slug for the outcome>`. An
  id is lower-case letters, digits, and hyphens, as `tests plan`
  requires. For `new` and `rewrite`, name the test's path under the
  project's test paths, its name inside the file where `testing.run`
  in `.ok-planner/config.json` holds `{name}`, its support files, its
  entry, the path of the program its test reaches, and how it reaches
  the code: the public entry point it calls, what it sets up, such as
  a scratch project in a folder `mktemp -d` makes or a stack run, and
  what it checks.

  Plan each `new` and `rewrite` test in a form `testing.run` runs
  within `testing.timeout`, where one exists, and name its kind, the
  kind of test it is, such as unit, cli, browser, or stack, and its
  setup, what it needs in place before it runs, such as a scratch
  folder, a running stack, or a browser. Where no form the command
  runs within the limit reaches an outcome, plan no test for it, and
  record a call of kind `untested` that names the outcome and what the
  command or the limit lacks.

  {{TEST-REVISION-RULE}}

  ### Record

  Per story you plan, one item, recorded even where the story yields
  no scenario: `tasks item add --pool stories --key <slug> --field
  story=<slug> --task <task>`. The assembly takes a story's items only
  from a task that records its `stories` item, and refuses a story
  your brief names that no task records.

  Per scenario: `tasks item add --pool scenarios --key <slug> --field
  id=<id> --field source=story:<slug> --field action=<action> [--field
  path=<test path>] [--field name=<test name>] [--field
  'support=["<path>", ...]'] [--field entry=<the program's path>]
  [--field kind=<such as unit, cli, browser, stack>] [--field
  setup="<such as a scratch folder, a running stack, a browser>"]
  [--field reach="<how it reaches the code>"] [--field call="<why, for
  a rewrite>"] --body "<the outcome the scenario checks, in one
  sentence>" --task <task>`. A `new` and a `rewrite` name their entry,
  kind, and setup. A `keep` needs no path: the stamp recorded it. A
  `keep` you raise a question on also names the test's path and name,
  its entry, its kind, its setup, and its reach as a rewrite to the
  new behavior would write them, so the owner's rewrite answer needs
  nothing more.

  Per question: `tasks item add --pool questions --key <id> --field
  scenario=<id> --field kind=<outcome-changed | code-removed> --body
  "<what changed, with the commit, and the three answers as they apply
  here>" --task <task>`.

  {{TEST-CALL-RULE}}

  Each call you record names its story: `--field story=<slug>`.

  ### Close

  `tasks close <task> --outcome done --result "<per story: <slug>: <n>
  scenarios: <the count per action>; <q> questions>"`.
```

---

### {{TEST-RUNTIME-PLANNER-PROMPT}}

The task prompt for the runtime planner, one task. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan the runtime scenarios

  {{LEAF-AGENT-RULE}}

  You plan the runtime scenarios for the test sprint at [TEST SPRINT
  PATH], inside the scope your brief names. You write no file in the
  project.

  Your brief names the scope the owner set, in the owner's words and as
  its paths, and the owner's answer for each program no story serves.
  A file lies inside the scope where it equals a path, lies under a
  path that is a folder, or matches a path that is a glob, where `*`
  crosses `/`; `.` covers the project. Plan no `new` or `rewrite` whose
  test path, support files, or entry lie outside the scope, and none
  whose entry is a program the owner left unguarded: a path the stamp
  records as unguarded, or a no-guard answer your brief names.

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
     and the executable entry points through which a test reaches
     each, as `.ok-planner/review/project.md` and the tree show them.
  6. The runner, in `.ok-planner/config.json`: `testing.run`, the
     command that runs one test, and `testing.timeout`, the time limit
     of one test in seconds, 600 where it is absent.

  ### Plan

  Per runtime part, name each class that applies, and per class each
  accept-list harm that follows when the part fails that way. Each
  pairing the code can meet is a scenario. Record each one, and sort
  each recorded runtime scenario as the story planner's table sorts a
  story's: `keep`, `retire` where the part is gone, `new`, `rewrite`,
  or `keep` and a question. Name a new one `runtime--<part>--<class>`,
  and where one part and class carry two harms, end the id with the
  harm's entry in lower case, such as
  `runtime--query-engine--dependency-down--a7`. An id is lower-case
  letters, digits, and hyphens, as `tests plan` requires. `<part>` and
  `<class>` are short slugs in that form, such as `dependency-down`
  for "A dependency goes down". For `new` and `rewrite`, name the
  entry, the path of the program the test reaches, and say how the
  test causes the condition from outside the product: two processes
  at once, a process killed between two writes, a file made
  unreadable, a full disk in a small mounted folder, a stored file
  written by the old version. A test never changes product code to
  cause its condition.

  Plan each `new` and `rewrite` test in a form `testing.run` runs
  within `testing.timeout`, where one exists, and name its kind, the
  kind of test it is, such as unit, cli, browser, or stack, and its
  setup, what it needs in place before it runs, such as a scratch
  folder, a running stack, or a browser. Where no form the command
  runs within the limit reaches an outcome, plan no test for it, and
  record a call of kind `untested` that names the outcome and what the
  command or the limit lacks.

  Sort every recorded runtime scenario, whatever the scope. Where a
  `rewrite` would reach outside the scope, plan it `keep`, and record
  a call of kind `scope` that names the rewrite the scope left out.

  {{TEST-REVISION-RULE}}

  ### Record

  Per runtime scenario: `tasks item add --pool scenarios --key runtime
  --field id=<id> --field source=runtime --field part="<part>" --field
  class="<class>" --field harm=<A1 to A9> --field action=<action>
  [--field path=...] [--field name=...] [--field 'support=[...]']
  [--field entry=<the program's path>] [--field kind=<such as unit,
  cli, browser, stack>] [--field setup="<such as a scratch folder, a
  running stack, a browser>"] [--field reach="<how it causes the
  condition and what it checks>"] --body "<the outcome the scenario
  checks>" --task <task>`. A `new` and a `rewrite` name their entry,
  kind, and setup. A `keep` you raise a question on also names the
  test's path and name, its entry, its kind, its setup, and its reach
  as a rewrite to the new behavior would write them, so the owner's
  rewrite answer needs nothing more.

  Per question: `tasks item add --pool questions --key <id> --field
  scenario=<id> --field kind=<outcome-changed | code-removed> --body
  "<what changed, with the commit, and the three answers as they apply
  here>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> runtime scenarios;
  <q> questions"`.
```

---

### {{TEST-PROGRAMS-PROMPT}}

The task prompt for the programs pass, one task, before any planner runs. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Find the programs no story serves

  {{LEAF-AGENT-RULE}}

  You list the executable entry points inside the scope your brief
  names, for the test sprint at [TEST SPRINT PATH], and the stories
  each one serves. You write no file in the project. The owner answers
  each program no story serves before any planner runs, and every
  planner works inside those answers.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The scope in your brief, in the owner's words and as its paths. A
     file lies inside the scope where it equals a path, lies under a
     path that is a folder, or matches a path that is a glob, where
     `*` crosses `/`; `.` covers the project.
  2. The programs the stamp recorded as unguarded:
     `.ok-planner/bin/tests scenarios --json`, its `unguarded` list.
  3. The code: list the executable entry points inside the scope, as
     `.ok-planner/review/project.md` and the tree show them: each
     script, service, command, or library entry a user or another
     program runs.
  4. The story catalog, `.ok-planner/design/stories.md`, and each
     story an entry point may serve.

  ### Find

  Per entry point, name the stories it serves. Each entry point no
  story serves, and that the stamp does not record as unguarded, is a
  question for the owner. List no entry point outside the scope: it is
  not the plan's to guard.

  ### Record

  Per entry point no story serves: `tasks item add --pool questions
  --key <path> --field path=<path> --field kind=unguarded --body
  "<what the program does, and the two answers: an issue asking
  /plan-sprint for the story it serves, or no guard>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> entry points; <u>
  unguarded"`.
```

---

### {{TEST-SORT-PROMPT}}

The task prompt for a sort agent, one task per batch of test files no scenario claims and claimed test files a person edited. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Sort a batch of legacy tests

  {{LEAF-AGENT-RULE}}

  You sort the test files your brief names, for the test sprint at
  [TEST SPRINT PATH]. No scenario claims them yet: they are a legacy
  suite, or tests a person added. You write no file in the project.
  Your brief names the files. A file your brief marks `claimed` holds
  a test a scenario claims and changed since the stamp, under any
  runner. Sort each test in it that is no claiming scenario's own
  test: where `testing.run` holds `{name}`, each test no scenario
  names; where it holds no `{name}`, each test that checks none of the
  outcomes its claiming scenarios state. Where no such test stands in
  it, record one entry for the file with sort `claimed`. Your brief
  also names the plan's scope: it bounds the scenarios planners write,
  not your sort, so sort every file your brief names, whatever the
  scope.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. Each file whole.
  2. The scenarios the story planners and the runtime planner
     recorded: `tasks item list --pool scenarios --json`, and the
     scenarios the stamp recorded: `.ok-planner/bin/tests scenarios
     --json`. A story this run does not plan keeps its recorded
     scenarios, which are not items in the run.
  3. The story catalog, `.ok-planner/design/stories.md`, and each
     story a test may check.
  4. The written rules a test may enforce: the decisions under
     `.ok-planner/design/decisions/`, the practices under
     `.ok-planner/practices/`, `.ok-planner/release-boundaries.md`,
     and the rules files under `.claude/rules/`.

  ### Sort

  Sort each test by its name, under any runner; a file that holds no
  test gets one entry by its path. Every file you are given gets at
  least one entry.

  | The test | Sort |
  |---|---|
  | It checks the outcome a recorded scenario states, as the scenario states it. | `adopt`, into that scenario |
  | It checks an outcome of a story that no scenario checks, and code carries it. | `adopt`, into a scenario you record |
  | It enforces a written rule on the code's shape, such as a module boundary or a naming rule. | `port`, naming the rule and the check it becomes |
  | It checks the code against itself, or a behavior no story or rule names. | `delete`, as an orphan |
  | Another test already checks the same scenario. | `delete`, as a duplicate |
  | It is a fixture, a helper, or a data file a test reads. | `support`, naming each test that reads it (`rg` the tree for its name or path) |
  | It is a claimed file, and every test in it is a claiming scenario's own test. | `claimed` |

  Where `testing.run` in `.ok-planner/config.json` holds no `{name}`,
  the runner runs a whole file, so a scenario's test is a whole file,
  and a file is adopted into one scenario at most. Adopt a file's
  tests into the one scenario most of them check. Sort each other test
  in it that checks a scenario as a duplicate, which that scenario's
  own new test replaces, and record the choice as a call. Adopt no
  test of a claimed file: a scenario already holds the file.

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

  A support entry names every test in the tree that reads the file,
  whatever batch that test falls in, as `<path>` or `<path>::<name>`.
  You do not decide whether the file stays: the assembly keeps a
  fixture only where a kept test uses it, as that test's support, and
  deletes it where none does.

  {{TEST-REVISION-RULE}}

  ### Record

  Per entry: `tasks item add --pool legacy --key <file> --field
  path=<file> [--field name=<the test's name as its file declares it;
  omitted for a file that holds no test and for a `claimed` entry>]
  --field sort=<sort> [--field
  scenario=<id>] [--field reason=<orphan | duplicate>] [--field
  rule=<kind:slug, or the rules file>] [--field check=<the check's
  path>] [--field 'users=["<path>[::<name>]", ...]', for a support
  entry] --body "<what the test checks, in one line>" --task <task>`.

  A scenario you record for a test no scenario names: `tasks item add
  --pool scenarios --key <story slug> --field id=<story slug>--<outcome>
  --field source=story:<slug> --field action=adopt --field path=<file>
  [--field name=<test name>] --body "<the outcome it checks>" --task
  <task>`. An id is lower-case letters, digits, and hyphens, as `tests
  plan` requires.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> tests: <the count
  per sort>"`.
```

---

### {{TEST-PLANNER-REVIEW-PROMPT}}

The task prompt for a planner review, one task per planner task: each story group, each one-story re-plan, the runtime task, and each sort batch. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Review one planner task's items

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the items one planner task filed, for the test sprint at
  [TEST SPRINT PATH], before the owner approves the plan. Your brief
  names the task as `review task <task id> (<its key>)`, the stories
  whose items the assembly takes from it, and the scope and program
  answers every planner works inside. Another review checks the plan as a whole; you check this
  task's items alone.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-RUNTIME-CLASSES}}

  ### Read

  1. The task's items: in each of the pools `stories`, `scenarios`,
     `questions`, `legacy`, and `calls`, `tasks item list --pool
     <pool> --json`, the entries whose `task` is the task your brief
     names. For a story task, leave out the items of each story it
     planned that your brief does not name: that story's `stories`
     item, its scenarios, the questions on them, and the calls that
     name it. A later story task re-planned that story, the assembly
     takes its items from that task, and that task's own review checks
     them.
  2. Each story your brief names, at
     `.ok-planner/design/stories/<slug>.md`, whole, and the code that
     carries it: the programs a user runs to get its benefit, each
     entry point, and the path it takes.
  3. For a runtime task: the accept list at
     `.ok-planner/review/catalog/accept.md`, and the runtime parts the
     product holds or depends on, as `.ok-planner/review/project.md`
     and the tree show them.
  4. For a sort task: each test file its `legacy` items name, whole,
     and each written rule a `port` names.
  5. The scenarios the stamp recorded: `.ok-planner/bin/tests
     scenarios --json`.

  ### Check

  - Each scenario checks one distinct outcome a program shows for a
    plausible way the story's implementation gives or refuses its
    benefit, or a runtime pairing of part, class, and harm.
  - No two of the task's scenarios check one outcome through one
    program.
  - Each distinct outcome the code shows for a story your brief names,
    or a runtime part the task planned, has a scenario, or a call of
    kind `untested`.
  - Each scenario's text states an outcome, not how the code reaches
    it.
  - Each `new` and `rewrite` reaches the code through a public entry
    point, and names its kind, its setup, and its entry.
  - Each runtime `new` and `rewrite` causes its condition from outside
    the product.
  - Each legacy `port` names a written rule, and each `adopt` names a
    scenario whose text the test checks.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario or file> --field refile=<the task your brief
  names> --field fix="<what the planner must change>" --body "<what
  breaks which check>" --task <task>`. Close: `tasks close <task>
  --outcome done --result "<n> findings"`.
```

---

### {{TEST-PLAN-WIDE-REVIEW-PROMPT}}

The task prompt for the plan-wide review, one task, filed beside the planner reviews. `[TEST SPRINT PATH]` is the test sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Review a test sprint's plan as a whole

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the plan of the test sprint at [TEST SPRINT PATH] as a
  whole, before the owner approves it. A planner review checks each
  planner task's items; you check what no single planner's items
  show: the scenarios across planners, and the owner's answers.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The plan: `.ok-planner/bin/tests plan --sprint [TEST SPRINT
     PATH] --show`, and `--show --json` for each scenario's source,
     entry, and test.
  2. The test sprint whole, its Owner answers section above all: the
     scope, each program answer, and each scenario answer.
  3. The owner's answers as the run records them: `tasks item list
     --pool scope --json`, and `tasks item list --pool questions
     --state answered --json`.
  4. The planner task of each scenario: `tasks item list --pool
     scenarios --json`, the entry whose `id` field is the scenario's,
     from the latest done task that planned its story or, for a
     runtime scenario, the latest done runtime task.

  ### Check

  - No two scenarios across planners check one outcome through one
    program.
  - The scope holds in the plan as the owner gave it: no planned test
    path, support file, or entry lies outside it.
  - Each program answer holds as the owner gave it: no planned test
    enters a program the owner left unguarded, and each issue answer
    names the issue filed.
  - Each scenario answer holds as the owner gave it: a retire retires
    the scenario, a rewrite plans the outcome the owner stated, and an
    issue keeps the scenario's test and names the issue.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario or file> --field refile=<the planner task
  whose item it is, or none where no task of this run filed it>
  --field fix="<what the planner must change>" --body "<what breaks
  which check>" --task <task>`. Close: `tasks close <task> --outcome
  done --result "<n> findings"`.
```

---

### {{TEST-SUPPORT-PROMPT}}

The task prompt for a support task in the run, one per support file the written scenarios name, and one per later round of helpers a test task found missing. `[TEST SPRINT PATH]` is the test sprint.

```
Task prompt (profile ok-opus):
  ## Write one support file's helpers

  {{LEAF-AGENT-RULE}}

  You write one support file of the test sprint at [TEST SPRINT PATH]:
  the one file your task's files name. Your brief names the scenarios
  whose tests use it, each with the outcome it checks, its test, and
  how the test reaches the code. Where a test task found a helper
  missing, your brief names each `helpers` item it recorded instead.
  The test tasks run after you: each reads this file and changes none
  of it. You write no test and no product code.

  ### Read

  1. Each scenario in your brief, and its story at
     `.ok-planner/design/stories/<slug>.md`, or for a runtime scenario
     the accept-list entry it names.
  2. The code each scenario's reach names: the public entry point, and
     the path it takes, enough to call it as a user does.
  3. `testing.run` in `.ok-planner/config.json`: the command that runs
     one test, which every helper must suit.
  4. The file as it stands, and each live test that uses it:
     `.ok-planner/bin/tests plan --sprint [TEST SPRINT PATH] --show`
     lists the tests, and `tasks item list --pool tests --json` the
     support each test task recorded.

  ### Write

  - Write every helper the tests in your brief need to reach the code
    through its public entry point: the command, the route, the
    exported function.
  - Write every helper they need to set up in a folder `mktemp -d`
    makes, or on a stack run the project's stack tool opens, and to
    tear it down on every exit. A helper writes nothing into the
    project's tree when a test runs.
  - Keep every helper a live test already uses, as it works now.
  - Write no test, no product code, and no comment: the lint's comment
    rule covers support files too.
  - Per `helpers` item your brief names, add the helper it asks for,
    then mark it: `tasks item set <item> --state added`.

  {{TEST-CALL-RULE}}

  ### Close

  Stage your file by name: `git add <file>`. Never run `git checkout`/
  `restore`/`reset`/`stash`/`clean`. `tasks close <task> --outcome
  done --result "<file>: <n> helpers written, <h> helpers items
  added" --staged <file>`.
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
  reaches the code, and any owner ruling. You change only the files
  your task's files name: your test file, and for a rewrite at a new
  path its old test file. A support task wrote each support file
  before you ran: read them, and change none of them. You change no
  product code.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The scenario's story at `.ok-planner/design/stories/<slug>.md`,
     or for a runtime scenario the accept-list entry it names.
  2. The code the brief's reach names: the public entry point, and
     the path it takes, enough to call it as a user does.
  3. `testing.run` in `.ok-planner/config.json`: the command that runs
     one test, which your test must suit.
  4. For a rewrite or a retirement, the test as it stands.
  5. Each support file your brief names, whole.

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
  - Use the helpers your support files hold. Where a helper your test
    needs is missing, record one item per missing helper: `tasks item
    add --pool helpers --key <support path> --field path=<support
    path> --field scenario=<id> --body "<the helper and what it must
    do>" --task <task>`. Then write no test, and close `blocked`:
    `tasks close <task> --outcome blocked --result "<id>: <h> helpers
    missing"`. The next write stage files a support task that adds
    them, and files your task again after it.
  - For a retirement, delete the test and nothing else: the sweep
    deletes each support file no live test uses. For a rewrite at a
    new path, delete the old test the same way.

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

  Your brief names test files and support files that no planned test
  of the test sprint at [TEST SPRINT PATH] claims as its own or as
  support: a fixture, a helper, or a data file the deleted or retired
  tests used, or one an adopted or new test uses and no record names.

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

<!-- Materialized by ok-planner v29.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
