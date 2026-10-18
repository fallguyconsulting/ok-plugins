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

<Each question the planners raised and the owner's answer, in the
owner's words: for a scenario whose outcome changed or whose code is
gone, retire, rewrite to the new behavior, or the issue filed so a
sprint restores the old one; for a program no story serves, the
issue filed for `/plan-sprint` or no guard, with the reason. Omit the
section when there are none.>

## Plan

The plan is the file beside this one with `-plan.json` in place of
`.md`, which `.ok-planner/bin/tests plan` wrote and checked.
`.ok-planner/bin/tests plan --sprint <this file's path> --show` prints
it.

<The counts `tests plan` printed: scenarios per action, legacy tests
per sort, unguarded programs, and calls.>

## How to execute this test sprint

This test sprint is self-sufficient. Every executor runs the same
shape: record the base, file the test and legacy tasks the plan
names, then loop: run every test, fix the code for each failing one,
and verify each fix, until every test passes or its failure waits on
a promise change. The run changes tests and the code they reach, and
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
   ok-opus`, and for each of `{{TEST-WRITE-PROMPT}}` as `test`,
   `{{TEST-LEGACY-PROMPT}}` as `legacy`, `{{TEST-SWEEP-PROMPT}}` as
   `sweep`, `{{TEST-FIX-PROMPT}}` as `fix`, and `{{TEST-VERIFY-PROMPT}}`
   as `verify`, in `.claude/skills/plan-tests/core.md`, write the
   block, its transclusions resolved and `[TEST SPRINT PATH]` filled,
   to `.ok-planner/test-sprints/<name>-<role>.md`, and register it:
   `tasks prompt register <role> <that path>`. Declare the pools:
   `tasks config set item_states '{"tests": ["open"], "ports":
   ["open"], "fixes": ["open", "accepted", "sent-back"], "promises":
   ["open", "held", "rejected"], "calls": ["open"]}'`.

5. Write. `.ok-planner/bin/tests tasks --sprint <this file's path>
   --stage write` files one test task per scenario the plan writes,
   rewrites, or retires, and one legacy task per legacy file it ports
   from or deletes from. Drain. Then `.ok-planner/bin/tests ports
   --sprint <this file's path>` adds each check the legacy tasks
   ported to `.ok-planner/review/config.json` `checks`. Then, while
   `.ok-planner/bin/tests stray --sprint <this file's path>` lists a
   file, `tests tasks --sprint <this file's path> --stage sweep` and
   drain.

6. The loop. `.ok-planner/bin/tests run --sprint <this file's path>`
   runs every test and records the round. While `.ok-planner/bin/tests
   failures --sprint <this file's path>` lists a failure:

   1. `tests tasks --sprint <this file's path> --stage fix` files one
      fix task per failing test with no fix pending, and `tests tasks
      --sprint <this file's path> --stage verify` one verify task per
      fix or promise that awaits its verifier. Fixers run one at a
      time, each after the last, and each keeps a snapshot of the files
      it edits before and after, so its verifier reads its change
      alone. Verifiers also run one at a time. A fix a verifier sends
      back is backed out of the tree when the next attempt is filed. Drain after
      each. Repeat both until neither files a task: every fix of the
      round is accepted, and every promise held. Where `--stage fix`
      refuses because a scenario's fix tasks closed `blocked` twice,
      that is a genuine blocker.
   2. Run every test again with `tests run --sprint <this file's
      path>`.

   The loop has no cap. A test that passed before can pass again,
   and a test whose fix needs a promise changed stays failing with
   the issue its verifier filed.

7. Report. Write the output of `.ok-planner/bin/tests report --sprint
   <this file's path>` to the completion report, beside this file with
   `-completion` before the extension. Then run `.ok-planner/bin/tests
   complete --sprint <this file's path>` and show its output whole.
   Where it prints `TESTS NOT COMPLETE`, work each failure it names; a
   failure you cannot work is a genuine blocker.

8. Present the completion report to the owner: each test written,
   rewritten, retired, or recorded as a gap, the legacy tests ported
   and deleted, each fix, each failure left with its issue, and each
   call an agent made, for the owner's veto. For each vetoed call,
   file one issue with `.ok-planner/bin/issues file --from -` in the
   format of the `{{ISSUE-FILE-FORMAT}}` block of
   `.claude/skills/_shared/artifact-definitions.md`: kind `human`,
   category `product-intent`, its problem the call. Then offer the
   archive and the commit:

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

1. Every test, legacy, sweep, fix, and verify task of the run, the
   latest for each key, closed `done`. Every scenario the plan writes,
   rewrites, or retires has its test task and its record, a test or a
   gap; every legacy file the plan ports from or deletes from has its
   legacy task; and every ported check stands in
   `.ok-planner/review/config.json` `checks`.
2. No test file stands that no planned test claims as its own or as
   support, no fix task staged a test path, and no fix or promise
   awaits its verifier.
3. The latest round ran after every test, legacy, sweep, and fix task
   closed, ran every live test, and every test passed or its failure
   has a held promise or an owner issue.
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
