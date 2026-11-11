## Verify one test, one fix, or one promise

{{LEAF-AGENT-RULE}}

Your brief names one item of the sprint at [SPRINT PATH]:
a test a test task recorded in the `tests` pool, a fix a fixer
recorded in the `fixes` pool, or a promise in the `promises` pool.
`tasks item list --pool <pool> --json` prints it whole. You did not
make it, and you change no file in the project. You run read-only
commands, the task tracker's verbs, and
`.ok-planner/bin/issues file`. For a fix or a promise you also run
the one test the item's scenario names, or for a grown leftover
count each test the item names. For a test you run nothing else.

Read the testing standard at `.ok-planner/docs/testing.md` before
you judge any item.

{{TEST-SILENCE-RULE}}

### A test

Read the `tests` item, the test it names, whole, its scenario in
`.ok-planner/bin/tests plan --sprint [SPRINT PATH] --show`, and
the scenario's `reach` and `waits`, which your brief also names. The
brief also names the test's seconds from the test task's own run,
the budget's workers, the shared resources the test changes
(`resources`), and the shared resources it reads and does not change
(`reads`). Send the test back where its
verdict waits on elapsed time: a sleep, a poll under a deadline, or
any wait other than on the event, the time control, or the clock
the scenario's `waits` names. Send it back where it checks an
outcome other than the one the scenario's text states: a record
never changes the outcome, and a change to it is a promise, which the
test task records in the `promises` pool. Otherwise judge where its
time goes:

{{TEST-SPEED-JUDGING}}

The brief names each change the item makes to the scenario's
declarations, `resources` and `reads`, with the values before and
after and each one added, and each change to its plan text, `reach`,
`entry`, `waits`, `kind`, and `setup`, before and after. Judge each
declaration change against the waste "a shared resource declared
where a cheaper design keeps the test isolated": send the test back
where a cheaper design, such as a clock the test injects, or a broker
or a record of its own, keeps it from changing or reading a resource
it declares, naming the design and each declaration the rewrite
drops. Send it back where its plan text no longer proves the
scenario's outcome through the same program, or where its `waits`
names anything other than an event, a time control, or a clock the
test moves.

Accept it: `tasks item set <item> --state accepted`. On accepting
it, record each declaration the item adds as a call, one per
resource, for the owner's veto: `tasks item add --pool divergences
--key <id> --field kind=call --field site=<test path>[::<test name>]
--field choice="<id> declares <resource> in <resources | reads>"
--body "<why no cheaper design keeps the test from changing or
reading it>" --task <task>`. Or send it back: `tasks item set <item>
--state sent-back --field reason="<what to change>"`, naming the
waste and the cheaper form for a waste. The next write stage files a
test task again for a test you send back.

Where you find the test product-slow, record the verdict in the
`speed` pool: `tasks item add --pool speed --key <id> --state
product-slow --field scenario=<id> --field test=<test
path>[::<test name>] --field seconds=<the seconds your brief names>
--field site=<path::function> --field does="<what the site does>"
--field grows="<how its cost grows>" --field cheaper="<the cheaper
behavior>" --body "<the same, in one line>" --task <task>`. Leave
out `seconds` where your brief names no run of the test. Then accept
the test as above: the slow work is the product's, so the test
stands, the fix loop files a fixer for the site, keyed `perf:`, and
once the fix is accepted the test gets a fresh speed read.

### A fix

Read the change: `.ok-planner/bin/tests diff --sprint [SPRINT PATH]
--key <the item's fix field>`, and the scenario and its test.
An item with `change=none` changed nothing: accept it where the test
passes. Send a fix back where any of these holds:

- It checks whether a test runs, reads a setting only a test sets,
  or treats the test's data as a special case. A time control the
  plan approved is not a setting only a test sets: it is product
  code every deployment carries, and each deployment's
  configuration sets its gate.
- It hides a failure: a catch that swallows it, a longer timeout, a
  retry with no budget the code already had.
- It fakes the effect the test looks for instead of doing the work.
- It changes a file at a test path, a support file, or a fixture.
- It breaks a rule in `.claude/rules/plumbline-coding.md`, or causes
  a harm the accept list at `.ok-planner/review/catalog/accept.md`
  names.
- The test still fails: `.ok-planner/bin/tests run --sprint [SPRINT PATH]
  --only <id>`.

Accept it: `tasks item set <item> --state accepted`. Or send it back:
`tasks item set <item> --state sent-back --field reason="<what to
change>"`.

Where the fix's test waits on elapsed time, judge the fix as above,
and send the test back too, as "Send a test back" below says, with
the reason "<the wait and what the test waits on instead>".

### A grown leftover count

An item whose scenario is `leftovers--<kind>` answers a count of
that kind that grew over a round, and in place of "the one test" you
run each test its `tests` field or its body names, alone, with
`.ok-planner/bin/tests run --sprint [SPRINT PATH] --only <id>`,
which prints the counts before and after its run.

- A fix that changed the product: judge it as a fix above, and send
  it back where a test it names still grows the count.
- An item with `change=none` and a `tests` field: accept it where
  each test it names grows the count when it runs alone, and send
  it back where one does not. On accepting it, send each test it
  names back, as "Send a test back" below says, with the reason "it
  leaves <kind> behind: <what the fixer found>".

### Send a test back

A test goes back to a test task through its scenario's latest item
in the `tests` pool, which `tasks item list --pool tests --json`
lists. Where the pool holds an item for the scenario, set the latest
one: `tasks item set <item> --state sent-back --field
reason="<the reason>"`. Where it holds none, as for a kept or
adopted test no test task wrote, add one: `tasks item add --pool
tests --key <id> --field scenario=<id> --field path=<test path>
[--field name=<test name>] --state sent-back --field reason="<the
reason>" --body "<the reason>" --task <task>`, with the path and the
name `.ok-planner/bin/tests run --sprint [SPRINT PATH] --only
<id>` prints for the test. The next write stage files a test task
for each test sent back.

### A promise

A fixer records a promise where the code can meet its test only by
changing what the design corpus commits to. A test task records one
where it finds the scenario's outcome must change, and writes its
test to the outcome as it stands. Read each artifact the promise
names, the scenario, the test, and the code. The promise holds where
no change to the code meets the test while the design corpus commits
to what it says, or, for an outcome a test task found must change,
where the corpus commits to the outcome the test task names in place
of the scenario's. Where it holds, file one
issue with `.ok-planner/bin/issues file --from -` in the format of
the `{{ISSUE-FILE-FORMAT}}` block of
`.claude/skills/_shared/artifact-definitions.md`: kind `sprint`,
category `product-intent`, the test, the failure or the two
outcomes, and the commitment as its problem, and two options. For a
fixer's promise: change the commitment, or retire the scenario. For a
test task's: change the scenario's outcome to the one the corpus
commits to, or retire the scenario. Then `tasks item set
<item> --state held --field issue=<the issue id>`. Otherwise `tasks
item set <item> --state rejected --field reason="<the change that
meets the test, or why the scenario's outcome stands>"`.

### Close

`tasks close <task> --outcome done --result "<item>: <accepted |
accepted, product-slow | sent-back | held | rejected>"`.

<!-- Materialized by ok-planner v31.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
