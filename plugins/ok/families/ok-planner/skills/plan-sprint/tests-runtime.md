# Test planning: runtime

The block sprint execution's test planning procedure, in `tests.md`, uses for the runtime planner's task prompt. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint whose tests the run plans.

---

### {{TEST-RUNTIME-PLANNER-PROMPT}}

The task prompt for the runtime planner, one task. `[SPRINT PATH]` is the sprint whose tests the run plans.

```
Task prompt (profile ok-opus):
  ## Plan the runtime scenarios

  {{LEAF-AGENT-RULE}}

  You plan the runtime scenarios for the sprint at [SPRINT PATH].
  The sprint is not yet built: you plan the tests for the code as its
  work items leave it. You write no file in the project.

  The sprint plans the runtime parts its work reaches with no offer,
  and asks the owner nothing about them. Its test scope, the groups
  file beside the sprint, `-groups.json` in place of `.md`, names
  them: `parts` lists each runtime part the work items add, change,
  or remove, by its slug, `runtime_brief` says what you plan, and
  `frozen` says whether `testing.enabled` is `frozen`.

  - Where `frozen` is false, plan each part `parts` lists and every
    runtime part with no recorded scenario, and sort every recorded
    runtime scenario.
  - Where `frozen` is true, plan only the rewrites and retirements
    each part `parts` lists needs, and plan no `new` scenario. Leave
    out of your items every recorded runtime scenario whose `part`
    `parts` does not list: it stands as recorded, and `tests plan`
    refuses a `rewrite`, `retire`, or `gap` of it.

  Your brief names the unguarded programs the sprint records and the
  program questions this run raised, each an entry point no story
  serves. Plan no `new` or `rewrite` whose entry is one of them, or a
  path the scenario list records as unguarded: the plan holds no test
  for such a program until a story or an unguarded record stands.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-RUNTIME-CLASSES}}

  ### Read

  1. The accept list at `.ok-planner/review/catalog/accept.md`.
  2. The scenarios the list records whose source is `runtime`, and
     the programs it records as unguarded: `.ok-planner/bin/tests
     scenarios --json`. Read each runtime scenario's test whole.
  3. The groups file: its `parts`, `runtime_brief`, and `frozen`.
     Then what the sprint changes in the code each runtime test
     reaches, and each runtime part it adds, changes, or removes: the
     sprint's Work items and its Implementation notes, whose **Runtime
     parts** list under each work item names the parts. The notes say
     what the code will do once built.
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

  Per runtime part you plan, name each class that applies, and per
  class each accept-list harm that follows when the part fails that
  way. Each pairing the code can meet is a scenario. Record each one,
  and sort each recorded runtime scenario as the story planner's
  table sorts a story's: `keep`, `retire` where the part is gone, `new`, or
  `rewrite`. A scenario whose outcome the sprint changes is a
  `rewrite` to the outcome the sprint states, and one whose code the
  sprint removes while its part still stands is a `retire` with `gap`
  true; for each, record a call of kind `scope` naming the work item
  that changed the outcome or removed the code. You ask the owner
  nothing. Name a new one `runtime--<part>--<class>`,
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
  or a code stage builds, a test never changes product code to cause
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

  {{TEST-LOCKS-RULE}}

  Where `frozen` is false, sort every recorded runtime scenario; where
  it is true, sort each one whose `part` `parts` lists.

  {{TEST-REVISION-RULE}}

  ### Record

  Per runtime scenario: `tasks item add --pool scenarios --key runtime
  --field id=<id> --field source=runtime --field part="<part>" --field
  class="<class>" --field harm=<A1 to A9> --field action=<action>
  [--field path=...] [--field name=...] [--field 'test_support=[...]']
  [--field entry=<the program's path>] [--field kind=<such as unit,
  cli, browser, stack>] [--field setup="<such as a scratch folder, a
  running stack, a browser>"] [--field 'locks=[{"name": ...,
  "mode": ...}, ...]', on a rewrite only, carrying the locks the
  scenario list records for it] [--field waits="<event: ... |
  control: ... | clock: ...>"] [--field reach="<how it causes the
  condition and what it checks>"] [--field gap=true, for a retire
  whose code the sprint removes while its part stands] --body "<the
  outcome the scenario checks>" --task <task>`. A `new` and a
  `rewrite` name their entry, kind, setup, and waits. You declare no
  lock of your own: a `new` records no `locks`, and a `rewrite`
  records the locks the scenario list records for it, none where it
  records none.

  Per time control item: `tasks item add --pool controls --key
  control--<slug> --field id=control--<slug> --field form=<trigger |
  clock | setting> --field site=<path::symbol of the timer> --field
  'files=["<path>", ...]' [--field gate=<the gate setting's key, for a
  trigger or a clock>] --body "<what the time control does>" --task
  <task>`. A story planner that names the same time control records
  it with the same form, site, files, and gate: `tests plan` refuses
  one id recorded with different fields. The session files each time
  control item as a build task of the sprint, a code stage that builds
  it before the test stages run.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> runtime scenarios"`.
```
