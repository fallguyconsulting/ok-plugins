# Plan-sprint test planning: runtime

The block `/plan-sprint` uses for the runtime planner's task prompt when it plans a sprint's tests. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint the session is planning.

---

### {{TEST-RUNTIME-PLANNER-PROMPT}}

The task prompt for the runtime planner, one task. `[SPRINT PATH]` is the sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan the runtime scenarios

  {{LEAF-AGENT-RULE}}

  You plan the runtime scenarios for the sprint at [SPRINT PATH].
  The owner took the runtime group at Frame. The sprint is not yet
  built: you plan the tests for the code as its work items leave it.
  You write no file in the project.

  Your brief names the owner's answer for each program no story
  serves. Plan no `new` or `rewrite` whose entry is a program the
  owner left unguarded: a path the scenario list records as
  unguarded, or a no-guard answer your brief names.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-RUNTIME-CLASSES}}

  ### Read

  1. The accept list at `.ok-planner/review/catalog/accept.md`.
  2. The scenarios the list records whose source is `runtime`, and
     the programs it records as unguarded: `.ok-planner/bin/tests
     scenarios --json`. Read each runtime scenario's test whole.
  3. What the sprint changes in the code each runtime test reaches,
     and each runtime part it adds or removes: the sprint's Work items
     and its Implementation notes. The notes say what the code will do
     once built.
  4. The last run of the suite, where your brief names one: each
     recorded runtime scenario's pass or failure, its output tail, and
     its seconds, setup and teardown included.
  5. The code: list the runtime parts the product holds or depends on,
     as the sprint leaves them, and the executable entry points
     through which a test reaches each, as
     `.ok-planner/review/project.md`, the tree, and the notes from
     step 3 show them.
  6. The runner, in `.ok-planner/config.json`: `testing.run`, the
     project's suite command, which runs a list of tests in one run;
     `testing.named`, whether it runs a test by its name inside its
     file; `testing.setup`, the command that gets the test environment
     ready before the silence clock starts, or null; and
     `testing.silence`, the seconds with no result line and no output
     after which the run stops.

  ### Plan

  Per runtime part, name each class that applies, and per class each
  accept-list harm that follows when the part fails that way. Each
  pairing the code can meet is a scenario. Record each one, and sort
  each recorded runtime scenario as the story planner's table sorts a
  story's: `keep`, `retire` where the part is gone, `new`, `rewrite`,
  or `keep` and a question, naming in the question the work item that
  changed the outcome or removed the code. Name a new one `runtime--<part>--<class>`,
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
  written by the old version. Outside a time control the product has
  or a work item builds, a test never changes product code to cause
  its condition: where the condition waits on a timer the product
  cannot force, record a time control item, as the waits rule below
  says.

  Plan each `new` and `rewrite` test in a form the suite command runs,
  with `testing.setup` readying its environment, that prints a line
  of output or its result inside every `testing.silence` period, and
  name its kind, the kind of test it is, such
  as unit, cli, browser, or stack, and its setup, what it needs in
  place before it runs, such as a scratch folder, a running stack, or
  a browser. Where no form the suite command runs inside the silence
  period reaches an outcome, plan no test for it, and record a call of
  kind `untested` that names the outcome and what the command or the
  silence period lacks.

  {{TEST-WASTE-RULE}}

  {{TEST-WAITS-RULE}}

  {{TEST-RESOURCES-RULE}}

  Sort every recorded runtime scenario.

  {{TEST-REVISION-RULE}}

  ### Record

  Per runtime scenario: `tasks item add --pool scenarios --key runtime
  --field id=<id> --field source=runtime --field part="<part>" --field
  class="<class>" --field harm=<A1 to A9> --field action=<action>
  [--field path=...] [--field name=...] [--field 'support=[...]']
  [--field entry=<the program's path>] [--field kind=<such as unit,
  cli, browser, stack>] [--field setup="<such as a scratch folder, a
  running stack, a browser>"] [--field 'resources=["<slug>", ...]']
  [--field 'reads=["<slug>", ...]'] [--field waits="<event: ... |
  control: ... | clock: ...>"] [--field reach="<how it causes the
  condition and what it checks>"] --body "<the outcome the scenario
  checks>" --task <task>`. A `new` and a `rewrite` name their entry,
  kind, setup, resources and reads, each `[]` for an isolated test,
  and waits. A `keep` you raise a question on also names the test's
  path and name, its entry, its kind, its setup, its resources, its
  reads, its waits, and its reach as a rewrite to the new behavior
  would write them, so the owner's rewrite answer needs nothing more.

  Per time control item: `tasks item add --pool controls --key
  control--<slug> --field id=control--<slug> --field form=<trigger |
  clock | setting> --field site=<path::symbol of the timer> --field
  'files=["<path>", ...]' [--field gate=<the gate setting's key, for a
  trigger or a clock>] --body "<what the time control does>" --task
  <task>`. A story planner that names the same time control records
  it with the same form, site, files, and gate: `tests plan` refuses
  one id recorded with different fields. The session drafts each time
  control item as a work item of the sprint, which a code stage
  builds before the test stages run.

  Per question: `tasks item add --pool questions --key <id> --field
  scenario=<id> --field kind=<outcome-changed | code-removed> --body
  "<what changed, with the work item or the commit, and the three
  answers as they apply here>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> runtime scenarios;
  <q> questions"`.
```
