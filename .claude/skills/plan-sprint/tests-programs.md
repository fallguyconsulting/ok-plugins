# Test planning: programs

The block sprint execution's test planning procedure, in `tests.md`, uses for the programs task's prompt. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `../_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint whose tests the run plans.

---

### {{TEST-PROGRAMS-PROMPT}}

The task prompt for the programs pass, one task, before every other planner. `[SPRINT PATH]` is the sprint whose tests the run plans.

```
Task prompt (profile ok-opus):
  ## Find the programs no story serves

  {{LEAF-AGENT-RULE}}

  You list the executable entry points the sprint at [SPRINT PATH]
  reaches, and the stories each one serves. You write no file in the
  project. You run before every other test planner, and each later
  planner's brief names the programs you raise as programs the plan
  holds no test for, until a story or an unguarded record stands.

  Your brief names two sets of files: the files the sprint's work
  items name, and the test files of each legacy folder the owner took
  at planning. It also names the programs the sprint records as
  unguarded, with the owner's reasons. The entry points you list are
  the ones those files hold, and the ones the taken folders' tests
  run.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. The sprint's Work items, for what each work item does to the
     files it names.
  2. The programs the scenario list records as unguarded:
     `.ok-planner/bin/tests scenarios --json`, its `unguarded` list.
  3. The code: each file your brief names from the work items, and
     each program a taken folder's test runs. List their executable
     entry points, as `.ok-planner/review/project.md` and the tree
     show them: each script, service, command, or library entry a
     user or another program runs, including one a work item adds.
  4. The story catalog, `.ok-planner/design/stories.md`, each story
     an entry point may serve, and each story a delta of the sprint
     adds or amends, as its delta's body gives it.

  ### Find

  Per entry point, name the stories it serves. Each entry point no
  story serves, that the scenario list does not record as unguarded,
  and that your brief does not name as unguarded, is a question for
  the intake, which sprint certification's owner list files as an
  issue for the next `/plan-sprint`. List no entry point outside
  the files your brief names and the programs the taken folders' tests
  run: it is not this sprint's to guard.

  ### Record

  Per entry point no story serves: `tasks item add --pool questions
  --key <path> --field path=<path> --field kind=unguarded --body
  "<what the program does, and the two answers a later /plan-sprint
  gives: a story it serves, or a record that it stays unguarded>"
  --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> entry points; <u>
  unguarded"`.
```

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
