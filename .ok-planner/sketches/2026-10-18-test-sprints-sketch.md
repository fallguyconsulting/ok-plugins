# Test sprints — Design Sketch

**Date:** 2026-10-18
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Bring tests back, bounded, as regression guards and nothing else. A
test checks one scenario: a way a story says its benefit comes, or a
runtime condition the project declares, such as a crash mid-write.
The corpus fixes the list of scenarios, so it fixes the number of
tests too. A new ceremony, `/plan-tests`, plans a **test sprint**
with the owner. The test sprint then runs unattended, as a loop that
ends only when every test passes or needs the owner's judgment.
Feature sprints write no tests. The test process finds and fixes
regressions however they got into the tree, and feature work is only
its most common source.

Agents can read code and review every change, so the case for tests
is narrow. A test runs the same check on every later change, at no
model cost, against code the change did not touch. Review reads the
change, so it misses breaks in the change's callers. A test earns
its place only when it checks the code against something outside the
code. Here that something is a story or a declared runtime class,
never the code's current behavior. A test that checks the code
against itself adds nothing, and it breaks on every intended change.
The author's intent at the level of one function belongs in the code
as types and assertions with messages, where it runs and cannot
drift.

## Shape

### Scope: executable code

Tests cover executable code alone: programs, scripts, services,
libraries. Prose has no tests: skill text, rules, docs, and the
design corpus. The drive and review keep covering skill text, as
they do today.

A scenario tests the executable code that supports a story, not the
whole story. A drive tries the whole story as a user would. A test
checks the part a program does. In this project, most stories are
offered through skills, and a skill is prose, so a test cannot drive
it. The scripts behind those skills are executable: `issues`,
`tasks`, `review`, `stack`, `ports`, `run-group`, `docker-sweep`,
`plumbline`, `catalog-toc`, `dashboard`, and `admin/true-up`. Each
script a story depends on gets the scenarios that story names, as
far as the script carries them. Two examples:

- `concurrent-stacks-without-port-collisions`: two concurrent
  `ports lease` calls get disjoint ports. The test checks the port
  lease, not a whole verification run.
- `turn-down-a-destructive-true-up`: `true-up` with a plan that holds
  a destructive step writes nothing until it gets `--go-ahead <plan
  id>`, and it refuses a stale plan id.

A tool, helper, or script with no story behind it gets no test. Two
fixes exist when such a tool matters: a story that names the need it
serves, or a judgment that the tool needs no regression guard. Both
are the owner's.

### Coverage: one test per scenario

A scenario exists in only two cases:

1. **A story names it**, and executable code carries it. Each way the
   story's own text says the benefit comes is a candidate. Only the
   part that runs in code counts, as above.
2. **A runtime class applies to a part the project declares.** The
   project declares its runtime parts, such as a database, a queue,
   a second host, or a long-running process. It also declares which
   classes apply to each part. A runtime scenario pairs one class
   with one harm from the accept list.

The runtime classes:

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

A class applies only where the project has the part it names. This
project's runtime parts are few: the intake's lock and its two files,
the task tracker's log and index, the stack registry and its port
leases, and the dashboard's service. Concurrency, crash
mid-operation, and version skew carry most of its runtime scenarios.

Coverage is a count. It is complete when every scenario has exactly
one test or a recorded gap, and every test names a live scenario. A
gap is a scenario the story names but the code does not support. It
gets no test, because a failing test does not build a feature. A
test that names no live scenario is an orphan, and a second test for
a covered scenario is a duplicate. The test sprint deletes both.

Support is decided once, when the test is written. After that, a
failing test is a regression. It never becomes evidence that the
scenario is unsupported.

### Pinned tests

A test changes only through a test sprint. Every other agent treats
tests as read-only, as `no-tests` does today for every test. A test
that exercises the public surface keeps passing, unchanged, until a
test sprint decides otherwise. Sprint certification and `/converge`
fix code, never a test.

### `/plan-tests`: the planning ceremony

`/plan-tests` is an interactive session with the owner, shaped like
`/plan-sprint`, with the same parts: a framing step, a reconcile
step, a draft, a self-review, a code-planning pass, and one approval
at the end.

1. **The window.** It reads what changed since the last closed test
   sprint's `closed:` stamp: the code, the corpus, and every feature
   sprint closed in between. The sprint records explain an intended
   change. Planning still works when no sprint explains a change,
   because every change in the window may have come out of band.
2. **The sort.** It lists the scenarios as the corpus now stands,
   and runs every test once. Then it sorts each test and each
   scenario:

   | What it finds | Sort | Who decides |
   |---|---|---|
   | The test passes, and its scenario is unchanged. | Unchanged | Nobody. The test stays. |
   | The scenario's story was retired, or its text dropped the scenario. | Orphan | The rules. The test sprint deletes it. |
   | A story names a scenario that code supports, and no test covers it. | New | The rules. The test sprint writes it. |
   | A story names a scenario that no code supports. | Gap | The rules. It gets recorded, with no test. |
   | The outcome is unchanged, and only how a test reaches the surface changed, such as a renamed route. | Surface moved | The planner. It lists the update as a call for veto. |
   | The outcome a scenario checks changed. | Outcome changed | The owner, in the session. |
   | The surface a scenario reaches is gone, and its story still stands. | Surface removed | The owner, in the session. |
   | The test fails, and nothing in the window explains why. | Regression | The rules. The loop fixes the code. |

   For each "outcome changed" or "surface removed" case, the owner
   picks one answer: retire the test, rewrite the test to the new
   behavior, or file an issue so the next feature sprint restores the
   original behavior. The planner decides none of these by itself.
   Feature sprints are deliberate and complete, so the test sprint
   settles these cases itself. Sending them to a later feature
   sprint would make a slow round trip.
3. **Code planning.** A planner reads the code each new or rewritten
   test reaches, and records how the test reaches it: the public
   entry point, the stack or scratch project it needs, and for a
   runtime scenario, how it causes the condition.
4. **The draft and the self-review.** The test sprint lists each test
   to write, rewrite, or delete, by scenario, with the owner's rulings
   and the planner's calls. A reviewer checks the list against the
   scenario count and the rulings before approval.

### The test sprint

A test sprint lives in `.ok-planner/test-sprints/`, apart from
feature sprints. It carries fixed boilerplate, uses the task tracker
and the drain loop, and runs under `/goal`. The separate folder keeps
`/plan-sprint`'s reconcile baseline correct. That baseline is the
newest closed feature sprint's `closed:` stamp, and a test sprint
reconciles nothing against the corpus.

**Execution is one loop:**

1. Test tasks write, rewrite, and delete the tests the plan names.
   A test task works from the scenario text and the public surface.
   The agent that writes a test is never the agent that fixes code
   for it.
2. A tool runs every test. A runtime test opens its own stack run,
   causes its condition, and takes the run down after.
3. Fix tasks fix the code for each failing test. A fix task never
   edits a test. A verifier reads each fix for hacks: code that
   checks whether a test runs, code that special-cases the test's
   data, code that hides a failure with a swallowing catch or a
   stretched timeout or a blind retry, and code that fakes the visible
   effect. The whole suite runs after every round.
4. The loop repeats with no fixed limit. A test that passed before
   can always pass again, so the loop has a way to finish. It ends
   when every test passes, or when a failing test needs a promise
   changed. That last case means real ambiguity: the code can meet
   the test only by changing what the corpus commits to. Such a test
   stays failing, the run files an issue for the next feature sprint,
   and the loop goes on with the rest.

The test sprint never stops to ask, as a feature sprint never does.

**The stop condition.** A tool command prints `TESTS COMPLETE` when:

- every scenario has one test or a recorded gap;
- every test names a live scenario;
- every test passes, or its failure has an issue this run filed.

Each condition is a count or a pass-or-fail result, so the tool
decides them without a model. The executing session states the stop
condition in its first message, as feature sprints now do with
`review certified`. The close stamps the archived test sprint with
`closed: <sha>`, and that stamp is the next `/plan-tests` window's
start.

### Changes to what stands

- `decision:tests-forbidden` gets replaced. Agents still add no
  test, edit no test, and read no test as evidence, except inside a
  test sprint's tasks. The `no-tests` lint check and the edit hook
  allow a write to a test path only from a test sprint task.
- The existing suite stops being untouchable. A project's first test
  sprint sorts its old tests like every other test. An old test that
  names no scenario is an orphan, and the test sprint deletes it.
  That answers `issue:existing-test-suite-cannot-be-retired`. A
  fitness check in the old suite that enforces a written rule belongs
  in the lint, not in a test.
- `concept:sprint` gains a boundary line: a test sprint is a sprint
  that changes no corpus, planned by `/plan-tests`.
- Feature sprints write no tests and run none. Sprint certification
  keeps its review, its checks, and its drive.

## Open questions

- **The test runner declaration.** The project needs to declare how
  to run one test and the whole suite, and where tests live. A
  `tests` block in `.ok-planner/config.json` beside `stack` seems
  likely. Today `tests` holds the test-path shapes `no-tests` guards.
- **How a test names its scenario.** A citation tag such as
  `@scenario: <story>/<variant>` and `@runtime: <class>/<part>/<harm>`
  would let the lint resolve it. Story variants have no ids today.
  The tool would need to number them, or the story text would need
  to name them.
- **Where the scenario list and the gaps live.** Options: generated
  from the stories on each run, or a committed file the test sprint
  rewrites. A committed file makes support decided once. A generated
  list makes it re-decided on every run.
- **Where runtime parts are declared.** A `runtime` block in the
  config, or a new corpus kind with deltas. Declaring a part changes
  what the tests must cover, so it may need owner approval in a
  sprint.
- **Whether `/converge` should run the suite as a finder** between
  test sprints. Leaning no: the test sprint is the one place tests
  run. A suite that lags behind the code would also report noise.
- **The script-to-story map in this project.** Some scripts serve
  several stories, and some serve none directly. `catalog-toc` is
  one; it may serve no story at all. The first `/plan-tests` here
  would show how many scripts fall outside every story.
- **The hack check.** It relies on a verifier reading each fix. A
  lint rule could ban product code that reads a test-only setting
  outright.

## Risks / unknowns

- **The loop has no hard limit.** The rule that a passing test can
  pass again holds only while the change that broke the test can
  coexist with the scenario. A planner that misses a real conflict
  sends the loop around until a fixer finds it. Watch the first runs.
- **A rewritten test can encode a bug.** When the owner rules
  "rewrite to the new behavior", the new expected outcome comes from
  current code. The owner's ruling is the only check on it.
- **Runtime tests are hard to write well.** Causing a crash between
  two writes, or a slow dependency, takes fault injection the stack
  tool does not offer today.
- **Partial-story scenarios blur the bound.** "The executable part of
  the story" leaves room to interpret. A planner could split one
  story variant into many script-level checks. The count stays
  bounded only if each story variant yields at most one test per
  script that carries it.
- **Two ceremonies to keep in step.** `/plan-tests` and `/plan-sprint`
  share boilerplate, review, and code planning. Shared text belongs in
  `_sprint/shared.md`, or the two will drift apart.

## What this is not

- Not unit testing. No test pins a function's current behavior.
- Not a defect hunt. Tests find regressions in promised behavior and
  nothing else. `/converge` keeps hunting defects.
- Not a replacement for the drive. The drive still tries every story
  the way a user would, skill text included.
- Not test selection by changed code. Every test runs every time
  until run cost says otherwise.
