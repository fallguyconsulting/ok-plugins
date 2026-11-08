# Plan-sprint test planning: story

The block `/plan-sprint` uses for the story planner's task prompt when it plans a sprint's tests. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint the session is planning.

---

### {{TEST-STORY-PLANNER-PROMPT}}

The task prompt for a story planner, one task per group of stories. `[SPRINT PATH]` is the sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Plan a group of stories' scenarios

  {{LEAF-AGENT-RULE}}

  You plan the scenarios of each story your brief names, for the
  sprint at [SPRINT PATH]. The sprint is not yet built: you plan the
  tests for the code as its work items leave it. You write no file in
  the project. You record each scenario as an item, and the session
  assembles the plan from the items.

  Your brief names each story with the reasons this sprint plans it:
  `behavior`, where the sprint's work items change the story's
  implementation, as the implementation notes' **Tested stories**
  lists name it; `stale`, where the story's file differs from the
  version its test stamp names, or where it has recorded scenarios and
  no stamp; `untested`, where it has no recorded scenario and no
  recorded answer that leaves it unguarded; `new`, where a `New
  story:` delta of the sprint adds it, so no file holds it yet; and
  `widen`, where the owner reopened the story for the outcomes an
  earlier plan's calls left out. Plan each story your brief names
  whole, save one whose every reason is `widen`, which you widen
  alone. Every story your brief does not name keeps its recorded
  scenarios.

  Your brief marks the group `frozen` where `testing.enabled` is
  `frozen`. A `frozen` group gets no `new` scenario: `tests plan
  --frozen` refuses one. Plan only the `keep`, `rewrite`, `retire`,
  and `gap` items each story needs, with the questions the table
  below raises. For each outcome a `new` scenario would check, record
  a call of kind `untested` that names the outcome, so a later sprint
  under `on` finds it.

  Your brief also names the owner's answer for each program no story
  serves. Plan no `new` or `rewrite` whose entry is a program the
  owner left unguarded: a path the scenario list records as
  unguarded, or a no-guard answer your brief names.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  Steps 1 to 4 and 7 run once per story your brief names; steps 5 and
  6 run once.

  1. The story as the sprint leaves it, whole. Where the sprint
     carries a `New story:` or `Amend story:` delta for it, read the
     delta's body: in the sprint, or, where its heading reads `body:
     in the sidecar`, at
     `<the sprint's path without .md>-deltas/stories/<slug>.md`.
     Otherwise read `.ok-planner/design/stories/<slug>.md`. A story
     your brief marks `new` takes its slug from its delta's heading.
  2. The scenarios the list records for it: `.ok-planner/bin/tests
     scenarios --json`, the entries whose source is `story:<slug>`,
     and its test stamp, the blob id under `stamps`. Read each
     recorded scenario's test whole.
  3. How the story changed since a plan last planned it. Where it has
     a test stamp, read the planned version with `git cat-file -p
     <the stamp>`, and compare it with the story from step 1. Every
     difference is a change the plan answers.
  4. What the sprint changes in the code that carries the story: the
     sprint's Work items and its Implementation notes for each work
     item whose changes reach that code, and each work item whose
     **Tested stories** list names the story. The notes say what the
     code will do once built.
  5. The last run of the suite, where your brief names one: each
     recorded scenario's pass or failure, its output tail, and its
     seconds, setup and teardown included.
  6. The runner, in `.ok-planner/config.json`: `testing.run`, the
     project's suite command, which runs a list of tests in one run;
     `testing.named`, whether it runs a test by its name inside its
     file; `testing.setup`, the command that gets the test environment
     ready before the silence clock starts, or null; and
     `testing.silence`, the seconds with no result line and no output
     after which the run stops.
  7. The code that carries the story, as it stands, read beside the
     notes from step 4. Find the programs a user runs to get the
     benefit, and read each entry point and the path it takes. On each
     path, as the sprint leaves it, find each plausible way the
     implementation gives or refuses the benefit, and each distinct
     outcome a user or the product sees on it. For a story your brief
     marks `widen`, also read the calls the latest plan to plan it left
     for it: `.ok-planner/bin/tests calls <slug> --json`. Each is a
     choice a planner recorded that left a path out.

  ### Plan

  Record one item per scenario, recorded or new, with its action.
  Read "the code" in the table as the code the sprint leaves, and "the
  story" as the story step 1 reads.

  | What you find | Action |
  |---|---|
  | The scenario's outcome is unchanged, and its test reaches the code as it stands. | `keep` |
  | The story dropped a scenario the list records. | `retire` |
  | The code shows an outcome of the story that no scenario checks. | `new`, or, in a `frozen` group, a call of kind `untested` |
  | The story names a way no code supports. | `gap` |
  | The list records a gap, and the code now supports it. | `new`, or, in a `frozen` group, a call of kind `untested` |
  | The outcome is unchanged, and only how the test reaches the code changed, such as a renamed command. | `rewrite`, with a call |
  | The last run shows the test failing, and nothing the sprint changes explains why. | `keep`: certification fixes the code |
  | The test fails, and the scenario list marks it with an issue still open. | `keep`: it fails until a sprint settles the issue |
  | The outcome the scenario checks changed. | `keep`, and a question |
  | The code the scenario reaches is gone, and the story still stands. | `keep`, and a question |

  A way the story dropped that no scenario recorded gets no item.
  `keep`, `rewrite`, and `retire` sort only a scenario the list
  records, so a story with no recorded scenario gets only `new`
  scenarios and gaps.

  A question is the owner's alone. The owner answers retire, rewrite
  to the new behavior, or file an issue so a sprint restores the old
  one. Decide none of these yourself. Name in the question the work
  item, the delta, or the commit that changed the outcome or removed
  the code.

  For a story your brief marks `widen`, read its recorded scenarios
  and the earlier calls together. For each outcome those calls left
  out, add a `new` scenario where the code supports it, or a `gap`
  where no code does: one scenario per distinct outcome, and none that
  checks an outcome a recorded or planned scenario checks through the
  same program. Where every reason of the story is `widen`, record
  only `new` and `gap` items and its `stories` item: each recorded
  scenario you name nowhere stands as recorded. Where the story has
  other reasons too, sort it whole and widen it in the same pass.

  Name a new scenario `<story slug>--<a short slug for the outcome>`,
  with the slug step 1 gives. An id is lower-case letters, digits, and
  hyphens, as `tests plan` requires. For `new` and `rewrite`, name the
  test's path under the project's test paths, its name inside the
  file where `testing.named` in `.ok-planner/config.json` is `true`,
  its support files, its entry, the path of the program its test
  reaches, and how it reaches the code: the public entry point it
  calls, what it sets up, such as a scratch project in a folder
  `mktemp -d` makes or a stack run, and what it checks.

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
  [--field 'resources=["<slug>", ...]'] [--field 'reads=["<slug>",
  ...]'] [--field waits="<event: ... | control: ... | clock: ...>"]
  [--field reach="<how it reaches the code>"] [--field call="<why, for
  a rewrite>"] --body "<the outcome the scenario checks, in one
  sentence>" --task <task>`. A `new` and a `rewrite` name their entry,
  kind, setup, resources and reads, each `[]` for an isolated test,
  and waits. A `keep` needs no path: the list records it. A `keep` you
  raise a question on also names the test's path and name, its entry,
  its kind, its setup, its resources, its reads, its waits, and its
  reach as a rewrite to the new behavior would write them, so the
  owner's rewrite answer needs nothing more.

  Per time control item: `tasks item add --pool controls --key
  control--<slug> --field id=control--<slug> --field story=<slug>
  --field form=<trigger | clock | setting> --field site=<path::symbol
  of the timer> --field 'files=["<path>", ...]' [--field gate=<the
  gate setting's key, for a trigger or a clock>] --body "<what the
  time control does>" --task <task>`. Record one per story whose
  scenarios wait on it, each with the same form, site, files, and
  gate: `tests plan` refuses one id recorded with different fields.
  The session drafts each time control item as a work item of the
  sprint, which a code stage builds before the test stages run.

  Per question: `tasks item add --pool questions --key <id> --field
  scenario=<id> --field kind=<outcome-changed | code-removed> --body
  "<what changed, with the work item, the delta, or the commit, and
  the three answers as they apply here>" --task <task>`.

  {{TEST-CALL-RULE}}

  Each call you record names its story: `--field story=<slug>`.

  ### Close

  `tasks close <task> --outcome done --result "<per story: <slug>: <n>
  scenarios: <the count per action>; <q> questions>"`.
```
