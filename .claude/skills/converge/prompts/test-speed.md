## Review one slow test for waste

{{LEAF-AGENT-RULE}}

{{READ-ONLY-REVIEWER-RULE}}

Your brief names one test of the sprint at [SPRINT PATH], which a
ranking chose by what each test costs the run's wall time under the
schedule `testing.schedule` records: a whole-suite round's ranking,
or the ranking the scenario list carries. The sprint works each such
test until it runs as quickly as it can while it still proves its
outcome. The brief names the scenario, the test, its test support
files, its reach, its entry, its waits, the shared resources it declares it
changes and those it declares it reads, the ranking, the schedule
and its workers, the test's rank, its median seconds, setup and
teardown included, and the count of passing whole-suite runs of its
test file as it stands that the median spans, what it costs the wall
time under that schedule, the git blob of its test file, and the
digest of its test support files. It also names each earlier speed review
that sent the test back or found it product-slow, with the reason.
You did not write the test, and you change no file in the project.
`.ok-planner/bin/tests plan --show` only reads, so run it.

{{TEST-WASTE-RULE}}

{{TEST-SILENCE-RULE}}

### Read

1. The test whole, and each test support file the brief names,
   whole.
2. The scenario the brief names, with its text and its source: the
   sprint's plan, which `.ok-planner/bin/tests plan --sprint
   [SPRINT PATH] --show` prints, or, for a scenario the plan does not
   list, the scenario list. Then its story at
   `.ok-planner/design/stories/<slug>.md` or the accept-list entry
   its source names.
3. The code the test reaches, from the entry the brief names along
   the path its reach says, far enough to see what each part of the
   test's setup, run, and teardown buys.
4. The testing standard at `.ok-planner/docs/testing.md`.
5. `testing.setup` in `.ok-planner/config.json`: the project holds a
   seed only where it is a command that builds one, and holds none
   where it is `null`.

### Judge

The ranking chose the test you read.

{{TEST-SPEED-JUDGING}}

Where the test builds data it reads and never changes, such as
records or accounts made before each run, and the project holds a
seed that `testing.setup` builds, a seed entry may be the cheaper
form. The seed is read-only test data that `testing.setup` builds
once and reuses until the entry's own definition or the stored-data
layout files it names change. Name the entry, one the seed holds or a
new one, and each object it must hold for the test's outcome. Name a
seed entry only for data the test reads and never changes: a test
that changes its data builds its own copy. Where the project holds no
seed, name no seed: the cheaper form is data the test builds or reads
itself, such as a fixture.

### Record

Record your verdict in the `speed` pool, with the scenario, the
test, the blob of its test file as `digest`, the digest of its
test support files as `support`, its median seconds as `seconds`, and the
rank, each as your brief names it:

- Accept: `tasks item add --pool speed --key <id> --state accepted
  --field scenario=<id> --field test=<test path>[::<test name>]
  --field digest=<blob> --field support=<support digest> --field
  seconds=<median seconds> --field rank=<rank> --field
  reason="<where its time goes, and why its outcome needs it>"
  --body "<the same, in one line>" --task <task>`. The acceptance
  holds until the test file changes, or until a test support file
  changes and the test's median seconds rise above the seconds you record.
- Send back: `tasks item add --pool speed --key <id> --state
  sent-back --field scenario=<id> --field test=<test path>[::<test
  name>] --field digest=<blob> --field support=<support digest>
  --field seconds=<median seconds> --field rank=<rank> --field
  waste="<the waste>" --field reason="<the waste, and the cheaper
  form>" --body "<the same, in one line>" --task <task>`. Where the
  project holds a seed and a seed entry is the cheaper form, the
  reason names the entry and each object it must hold. Then send the test back to a test task through its
  scenario's latest item in the `tests` pool, which `tasks item list
  --pool tests --json` lists. Where the pool holds an item for the
  scenario, set the latest one: `tasks item set <item> --state
  sent-back --field by=speed --field reason="<the waste, and the
  cheaper form>"`. Where it holds none, as for a test the ranking the
  scenario list carries chose and no test task of this sprint wrote,
  add one: `tasks item add --pool tests --key <id> --field
  scenario=<id> --field path=<test path> [--field name=<test name>]
  --state sent-back --field by=speed --field reason="<the waste, and
  the cheaper form>" --body "<the same, in one line>" --task <task>`,
  with the path and the name the brief's `Test:` names, split at
  `::`. The next write stage
  files a test task for it, the verify stage verifies the rewrite,
  and the send-back settles once the verifier accepts it.
- Product-slow: `tasks item add --pool speed --key <id> --state
  product-slow --field scenario=<id> --field test=<test
  path>[::<test name>] --field digest=<blob> --field
  support=<support digest> --field seconds=<median seconds> --field
  rank=<rank> --field site=<path::function> --field does="<what the
  site does>" --field grows="<how its cost grows>" --field
  cheaper="<the cheaper behavior>" --body "<the same, in one line>"
  --task <task>`. Leave the scenario's `tests` item as it stands: the
  fix loop files a fixer for the site, keyed `perf:`, and once the
  fix is accepted the test gets a fresh speed read.

### Close

`tasks close <task> --outcome done --result "<id>: <accepted |
sent-back | product-slow>"`.

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
