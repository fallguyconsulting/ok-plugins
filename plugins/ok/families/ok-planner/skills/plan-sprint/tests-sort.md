# Plan-sprint test planning: sort

The block `/plan-sprint` uses for the sort task's prompt when it plans a sprint's tests. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint the session is planning.

---

### {{TEST-SORT-PROMPT}}

The task prompt for a sort agent, one task per batch of the test files no scenario claims in the legacy folders the owner took at Frame. `[SPRINT PATH]` is the sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Sort a batch of legacy tests

  {{LEAF-AGENT-RULE}}

  You sort the test files your brief names, for the sprint at
  [SPRINT PATH]. No scenario claims them yet: they are a legacy
  suite, or tests a person added. You write no file in the project.
  Your brief names the files, each in a legacy folder the owner took
  at Frame. Every other test file no scenario claims stays as it
  stands, and the plan records it as kept, for a later sprint that
  takes its folder. Read, run, and sort no file outside the files
  your brief names, even one a file in your batch imports, save to
  name the tests that read a support file, and record no entry for
  one.

  {{TEST-SCENARIO-DEFINITION}}

  ### Read

  1. Each file whole.
  2. The scenarios the story planners and the runtime planner
     recorded: `tasks item list --pool scenarios --json`, and the
     scenarios the list records: `.ok-planner/bin/tests scenarios
     --json`. A story this sprint does not plan keeps its recorded
     scenarios, which are not items in the run.
  3. The story catalog, `.ok-planner/design/stories.md`, and each
     story a test may check.
  4. The written rules a test may enforce: the decisions under
     `.ok-planner/design/decisions/`, the practices under
     `.ok-planner/practices/`, `.ok-planner/release-boundaries.md`,
     and the rules files under `.claude/rules/`. Where a test enforces
     a rule on the code's shape that no document states, infer the
     rule from the test, in one sentence.

  ### Sort

  Sort each test by its name, under any runner; a file that holds no
  test gets one entry by its path. Every file you are given gets at
  least one entry.

  | The test | Sort |
  |---|---|
  | It checks the outcome a recorded scenario states, as the scenario states it. | `adopt`, into that scenario |
  | It checks an outcome of a story that no scenario checks, and code carries it. | `adopt`, into a scenario you record |
  | It enforces a rule on the code's shape, written or not, such as a module boundary or a naming rule. | `port`, naming the written rule, or stating the rule you infer, and the check it becomes |
  | It checks the code against itself, or a behavior no story names and no rule on the code's shape covers, written or inferred. | `delete`, as an orphan |
  | Another test already checks the same scenario. | `delete`, as a duplicate |
  | It is a fixture, a helper, or a data file a test reads. | `support`, naming each test that reads it (`rg` the tree for its name or path) |

  Where `testing.named` in `.ok-planner/config.json` is `false`, the
  suite command runs a whole file, so a scenario's test is a whole file,
  and a file is adopted into one scenario at most. Adopt a file's
  tests into the one scenario most of them check. Sort each other test
  in it that checks a scenario as a duplicate, which that scenario's
  own new test replaces, and record the choice as a call.

  A test that checks an outcome the story no longer promises is an
  orphan, even where it passes. Judge each test by reading it beside
  its scenario and the code: planning runs no test, since tests run
  only in a sprint's test stages and certification. A test that checks
  what its scenario states stays adopted, whether or not the code
  passes it today: certification fixes the code. A test that expects
  what the scenario no longer states is an orphan, and the scenario
  gets a new test. Record your reason as a call.

  A port's check is a program outside every test path, such as
  `checks/<rule>`, that takes the changed files' paths as arguments,
  as `.ok-planner/review/config.json` `checks` commands do, and exits
  nonzero on a breach. A check never starts a test runner: `review
  checks` and `tests ports` refuse a command that does, so the check
  reads the code itself and runs no test suite.

  A port of an unwritten rule records `rule=inferred` and the rule you
  infer in `inferred`. The plan lists each inferred rule for the
  owner, and the next `/plan-sprint` writes it down as a practice or
  retires it with its check.

  A support entry names every test in the tree that reads the file,
  whatever batch that test falls in, as `<path>` or `<path>::<name>`.
  You do not decide whether the file stays: the assembly keeps a
  fixture only where a kept test uses it, as that test's support, and
  deletes it where none does.

  {{TEST-REVISION-RULE}}

  ### Record

  Per entry: `tasks item add --pool legacy --key <file> --field
  path=<file> [--field name=<the test's name as its file declares it;
  omitted for a file that holds no test>]
  --field sort=<sort> [--field
  scenario=<id>] [--field reason=<orphan | duplicate>] [--field
  rule=<kind:slug, the rules file, or inferred>] [--field
  inferred="<the rule you infer, one sentence>", with rule=inferred]
  [--field check=<the check's path>] [--field
  'users=["<path>[::<name>]", ...]', for a support entry] --body
  "<what the test checks, in one line>" --task <task>`.

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
