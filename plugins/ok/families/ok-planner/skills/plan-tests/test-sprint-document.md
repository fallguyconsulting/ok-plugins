# The test sprint document

`/plan-tests`'s terminal artifact, defined once. `/plan-tests` writes every test sprint from this template and never restates it.

`{{TEST-SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to execute this test sprint** and **Completion contract** sections are fixed boilerplate: copy them verbatim into every test sprint. Every executor, `/goal` or an inline session, works from the same brief.

---

### {{TEST-SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Test sprint: <title>

## Window

Planned against commit `<sha>`.

<The stamp, or `none`, and each reason `.ok-planner/bin/tests window`
gave. Then each sprint closed since the stamp, each story changed
since it, and the count of test files no scenario claimed.>

## Owner answers

<The scope the plan covers, in the owner's words, and its paths.
Then each program no story serves and the owner's answer: the issue
filed for `/plan-sprint`, or no guard, with the reason. Then each
question the planners raised and the owner's answer, in the owner's
words: for a scenario whose outcome changed or whose code is gone,
retire, rewrite to the new behavior, or the issue filed so a sprint
restores the old one.>

## Plan

The plan is the file beside this one with `-plan.json` in place of
`.md`, which `.ok-planner/bin/tests plan` wrote and checked.
`.ok-planner/bin/tests plan --sprint <this file's path> --show` prints
it.

<The counts `tests plan` printed: scenarios per action, legacy tests
per sort, unguarded programs, and calls.>

## How to execute this test sprint

This test sprint is self-sufficient. Every executor runs the same
shape: record the base, build the time controls the plan lists, check
the test stack where the plan's budget names one, file the support,
test, and legacy tasks the plan names, verify each test written,
then loop: run the whole suite, fix the code for each failing test
and each grown leftover count, verify each fix, rerun only the
failing tests until they pass, then run the whole suite as the gate,
until every test passes or its failure waits on a promise change.
Then work each test the run wrote or modified until it runs as
quickly as it can: a speed reviewer reads those tests down the gate's
ranked list for waste, the run rewrites each one sent back and runs
the whole suite again, until a batch of them comes back accepted with
no send-back.
The run changes tests, the code they reach, the time controls the
plan lists, and the test stack's configuration the budget names, and
nothing else.

1. Read the test sprint whole first. It is the whole brief. Where
   `/goal` handed you this file, its checker is a separate model that
   reads only the session: it opens no file and runs no command.
   State its stop condition in your first message, in these words:
   "This goal is met when `.ok-planner/bin/tests complete --sprint
   <this file's path>` prints `TESTS COMPLETE` in this session.
   Archiving, committing, and the stamp are the owner's acts, not goal
   terms."

2. Follow `{{CEREMONY-RUN-RULES}}` in
   `.claude/skills/_sprint/shared.md` for the whole run.

3. Record the base. Where `git status --porcelain` lists a path
   outside `.ok-planner/`, name those paths to the owner and stop.
   Otherwise write the output of `git rev-parse HEAD` to the file
   beside this one with `-base.txt` in place of `.md`. From then until
   `.ok-planner/bin/tests complete` prints `TESTS COMPLETE` and writes
   its mark beside this file, the lint allows edits at test paths.

4. Open the run. `.ok-planner/bin/tasks`, `.ok-planner/bin/tests`, and
   the profile `ok-opus` under `.claude/agents/` are required; a
   missing one is the front door's administration (`/ok`) to
   materialize: say so and stop. `tasks init <name> --file
   .ok-planner/test-sprints/<name>-run.jsonl`, `tasks agent register
   ok-opus`, and for each of `{{TEST-CONTROL-PROMPT}}` as `control`,
   `{{TEST-PREFLIGHT-PROMPT}}` as `preflight`,
   `{{TEST-SUPPORT-PROMPT}}` as `support`,
   `{{TEST-WRITE-PROMPT}}` as `test`, `{{TEST-LEGACY-PROMPT}}` as
   `legacy`, `{{TEST-SWEEP-PROMPT}}` as
   `sweep`, `{{TEST-FIX-PROMPT}}` as `fix`, `{{TEST-VERIFY-PROMPT}}`
   as `verify`, and `{{TEST-SPEED-PROMPT}}` as `speed`, in
   `.claude/skills/plan-tests/core.md`, write the
   block, its transclusions resolved and `[TEST SPRINT PATH]` filled,
   to `.ok-planner/test-sprints/<name>-<role>.md`, and register it:
   `tasks prompt register <role> <that path>`. Declare the pools:
   `tasks config set item_states '{"tests": ["open", "accepted", "sent-back"], "helpers":
   ["open", "added"], "ports": ["open"], "controls": ["open"],
   "fixes": ["open", "accepted", "sent-back"], "promises": ["open",
   "held", "rejected"], "speed": ["accepted", "sent-back"], "calls":
   ["open"]}'`.

5. Write. Where the plan lists time controls, the first
   `.ok-planner/bin/tests tasks --sprint <this file's path> --stage
   write` files one control task per time control alone, which builds
   it as product code at its site, behind its gate setting where it
   forces an event or moves time, and writes its setting into every
   deployment configuration the project owns; drain. A control task
   that closes short of `done` is filed again by the next `--stage
   write`, and where `--stage write` refuses because a control task
   closed `blocked` twice, that is a genuine blocker. Once every
   control task closed `done`, every task the stage files runs after
   them. Where the plan's budget names a test stack, the next
   `--stage write` files the preflight task alone, which sizes the
   test stack as the budget says, starts it alone, checks its sizing
   and each limit's handling, and stops it; drain. A preflight that closes
   short of `done` is filed again by the next `--stage write`, and
   where `--stage write` refuses because the preflight closed
   `blocked` twice, that is a genuine blocker. Once the preflight
   closed `done`, or where the budget names no stack,
   `--stage write` files one support task per support file the
   scenarios it writes or rewrites name, then one test task per
   scenario the plan writes, rewrites, or retires, each after the
   support tasks for its files, then one legacy task per legacy file
   it ports from or deletes from. Drain. After each write drain, run
   `tests tasks --sprint <this file's path> --stage verify`, which
   files one verify task per test a test task recorded that awaits its
   verifier, each free to run beside the others, and drain. A verifier
   reads the test against the testing standard and sends back a test
   whose verdict waits on elapsed time or that spends time on a named
   waste; the next `--stage write` files its test task again with the
   reason. Repeat `--stage write`, `--stage verify`, and the drains
   until neither stage files a task. A test task that closes `blocked`
   with a `helpers` item is filed again by `--stage write`, after the
   support task that adds the helper; do not refile it by hand. Where
   `--stage write` refuses because a scenario's test tasks closed
   `blocked` twice, or a support task closed `done` and left a
   `helpers` item open, that is a genuine blocker. Then
   `.ok-planner/bin/tests ports --sprint <this file's path>` adds each
   check the legacy tasks ported to `.ok-planner/review/config.json`
   `checks`. Where it refuses because a ported command starts a test
   runner, it adds no check: refile each legacy task it names with the
   refusal, `.ok-planner/bin/tasks refile <task> --brief "<its brief>;
   revise: <the refusal>"`, drain, and run `tests ports` again, until
   it adds the checks. Then, while `.ok-planner/bin/tests stray --sprint <this
   file's path>` lists a file, `tests tasks --sprint <this file's
   path> --stage sweep` and drain.

6. The loop. `.ok-planner/bin/tests run --sprint <this file's path>`
   runs the whole suite, runs `testing.leftovers` before and after it,
   and records the round. A failing test is a failure, and so is each
   kind of leftover whose count grew over the round, which
   `.ok-planner/bin/tests failures --sprint <this file's path>` lists
   as `leftovers--<kind>`. While it lists a failure:

   1. `tests tasks --sprint <this file's path> --stage fix` files one
      fix task per failure with no fix pending, `tests tasks --sprint
      <this file's path> --stage verify` one verify task per test, fix,
      or promise that awaits its verifier, and `tests tasks --sprint
      <this file's path> --stage write` one test task again per test a
      verifier sent back. Fixers run one at a
      time, each after the last, and each keeps a snapshot of the files
      it edits before and after, so its verifier reads its change
      alone. The verifiers of fixes and promises also run one at a
      time. A fix a verifier sends back is backed out of the tree when
      the next attempt is filed. A fix verifier that finds the fix's
      test waiting on elapsed time sends the test back too. Drain after
      each. Repeat the three until none files a task: every fix of the
      round is accepted, every promise held, and every test accepted. Where `--stage fix`
      refuses because a scenario's fix tasks closed `blocked` twice,
      that is a genuine blocker. A fix for a grown count fixes the
      product where it leaks, or names the tests that leave the
      resource behind, which its verifier sends back to a test task.
   2. Rerun the failing tests alone: `tests run --sprint <this file's
      path> --failing` reruns each test the latest round lists as
      failing, as a rerun round, and `tests failures` then lists that
      round's failures. Repeat 1 and 2 while it lists a failing test.
      Where the latest round's failures are grown counts alone,
      `--failing` refuses: go to 3.
   3. The gate: run the whole suite again with `tests run --sprint
      <this file's path>`. A test that fails there, or a count that
      grows, is a failure a fix caused, and the loop takes it up.

   Once a whole-suite round lists no failure, review its slowest
   tests:

   4. `tests tasks --sprint <this file's path> --stage speed` walks
      that round's tests the run's test tasks wrote or modified,
      ranked by what each test adds to the run's wall time,
      `testing.slowest` at a time. It files one speed task per test in
      the first batch that holds a test no speed reviewer accepted in
      its current form; a rewrite of the test or its support files
      clears an acceptance. It walks past a batch whose tests are all
      accepted where any was sent back, and stops at a batch accepted
      with no send-back, or at the end of the list. Speed reviewers
      run beside one another; drain. A speed reviewer reads where the
      test's time goes, and sends back a test whose time goes to a
      named waste, naming the waste and the cheaper form, or accepts
      it; no count of send-backs makes it accept. Where a speed
      reviewer sent a test back, run `--stage write` and `--stage
      verify`, and drain after each, until neither files a task; then
      run the whole suite again, and the loop goes on.

   The loop ends when a whole-suite round lists no failure and
   `--stage speed` files no task. It has no cap. A test that passed
   before can pass again, and a test whose fix needs a promise changed
   stays failing with the issue its verifier filed. No time budget
   decides a verdict: the ranking picks the tests a speed reviewer
   reads, and the reviewer judges the waste.

7. Report. Write the output of `.ok-planner/bin/tests report --sprint
   <this file's path>` to the completion report, beside this file with
   `-completion` before the extension. Then run `.ok-planner/bin/tests
   complete --sprint <this file's path>` and show its output whole.
   Where it prints `TESTS NOT COMPLETE`, work each failure it names; a
   failure you cannot work is a genuine blocker.

8. Present the completion report to the owner: each time control
   built, each test written, rewritten, retired, or recorded as a gap, the legacy tests ported
   and deleted, each fix, each failure left with its issue, each speed
   review's verdict, and each call an agent made. Then follow `{{CEREMONY-VETO}}` in
   `.claude/skills/_sprint/shared.md`, with `<rows>` as the calls, the
   legacy tests deleted, and the legacy tests ported, and `<problem>`
   as the row. For a call, the problem is the call. For a deleted or
   ported legacy test, the problem names the test's path and name; the
   base commit the `-base.txt` file beside this one records, which
   still holds the test; its sort and its reason, or for a port its
   rule, marked as inferred and stated as the plan states it where no
   document states it, and its check; and that a later test sprint restores the test,
   and for a port also drops the check from
   `.ok-planner/review/config.json` `checks`. The close restores no
   test and drops no check: step 7's `tests complete` has closed the
   test paths, so the issue carries the veto to the test sprint that
   undoes it. Then offer the archive and the commit:

**The archive and the commit.** Follow `{{CEREMONY-ARCHIVE}}` in
`.claude/skills/_sprint/shared.md`, with `<folder>` as `test-sprints`,
`<also>` as `.ok-planner/config.json` and
`.ok-planner/review/config.json`, each where it changed since the
base, for the runner planning declared and the checks the port tasks
added, and `<stamp command>` as `.ok-planner/bin/tests stamp --sprint
.ok-planner/history/test-sprints/<this file's name> --commit <sha>`.
The stamp writes the scenario list the run leaves to
`.ok-planner/test-state.json` and adds `closed: <sha>` to this file.

## Completion contract

The work is done when all of the following hold, each verifiable from
the repository as it stands:

1. Every control, preflight, support, test, legacy, sweep, fix,
   verify, and speed task of the run, the latest for each key, closed
   `done`;
   every time control the plan lists has its control task and its
   record; and a preflight task ran where the plan's budget names a
   test stack. Every scenario the plan writes,
   rewrites, or retires has its test task and its record, a test or a
   gap; every legacy file the plan ports from or deletes from has its
   legacy task; and every ported check stands in
   `.ok-planner/review/config.json` `checks`.
2. No test file stands that no planned test claims as its own or as
   support, no fix or control task staged a test path, no test, fix,
   or promise awaits its verifier, no test a verifier or a speed
   reviewer sent back stands
   unrewritten, and no `helpers` item stands open.
3. The latest round ran the whole suite and closed, after every
   control, preflight, support, test, legacy, sweep, and fix task
   closed. It
   ran every live test, no kind of leftover grew over it, and every
   test passed or its failure has a held promise or an owner issue.
   A test task rewrote each test an accepted fix names as leaving a
   resource behind, after that fix's verifier accepted it. The speed
   stage's walk over it, down the tests the run wrote or modified,
   ranked by what each adds to the run's wall time, reaches its stop,
   and a speed reviewer accepted each test it walked in the form the
   test and its support files have now.
4. The completion report beside this file (same filename with
   `-completion`) exists.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1 to 4 verify against the repository as it stands.
`.ok-planner/bin/tests complete --sprint <this file's path>` checks
them and prints `TESTS COMPLETE` or `TESTS NOT COMPLETE`. A checker
that reads only the session, as `/goal`'s does, decides from that
command's latest output in the session; a checker that runs commands
runs it. Presenting the report, archiving, committing, and the stamp
follow completion, and none is a term of the goal. A test sprint
archived with a `closed:` stamp is terminal. Nothing else counts
either way.
```
