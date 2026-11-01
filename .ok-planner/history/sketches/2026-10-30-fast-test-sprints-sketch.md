# Fast, deterministic test sprints — Design Sketch

**Date:** 2026-10-30
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Make a test sprint's suite run in minutes and give the same verdict
every time. Linescout's first test sprint planned 505 tests whose full
suite took 3.5 hours per round, and the fix loop reran the full suite
after every batch of fixes. The sprint cannot close. The owner settled
the changes below in discussion on 2026-10-30. They work as one
design: the test plan budgets the whole suite and its shared stack,
the product gives tests a way to force each event instead of waiting
for it, and no tuning value hides in code where a change for tests
can leak into production.

## Shape

### What went wrong in linescout

Linescout's own session transcripts and its test sprint files under
`.ok-planner/test-sprints/2026-10-22-tests*` show five causes:

| Cause | Evidence |
|---|---|
| The suite's runner runs one process per test, one after another, and records the round only at the end. | `scripts/tests` `cmd_run` builds `results = [run_one(...) for sid, test in targets]`; `run_one` starts one `subprocess.Popen` per test. Session fixtures took about 21 s of each 22 s test. |
| The plan told tests to wait. | 224 of 505 planned `reach` texts call for a poll, a deadline, a wait, or a sleep. The written tests held 223 sleeps, 187 in polling loops. |
| The product gave tests nothing to force. | Timers with no trigger: a 30 s access-hub refresh, a 15 s lake pass, a 300 s key cache, a 180 s silence window, a hard-coded 60 s rate window. Waits and slow calls took about 60% of round 3's 13,159 test-seconds. |
| The plan sent almost every test through the full stack. | About 434 of 505 `reach` texts start the stack; about 21 say "No stack". Tests on an injected `VirtualClock` ran 8 tests in 4 s. |
| The fix loop reran everything. | Three full serial rounds took 10.5 wall hours; the fixers and verifiers took 3.4 agent-hours. |

The session's workarounds then showed the next layer. Its own runner
ran 8 workers on one shared stack, and 179 of 456 shared tests failed:
Trino and Keycloak ran out of memory, an 8-connection pool ran dry,
deployment-wide limits refused parallel work, one test's authority
removal restarted the MQTT broker under every worker, and tests leaked
authorities and images. Its speed work changed product defaults that
now reach production deployments, such as a 1 s device-poll interval
and an open clock socket.

### 1. No defaults in code

A new rule in the coding rules (`docs/plumbline-coding.md`), with its
ambient copy in the cheatsheet (`docs/plumbline-cheatsheet.md`), binds
every project the suite manages:

- **A setting has no default in code.** A setting is a value an
  operator could sensibly want to differ between deployments: an
  interval, a limit, a threshold, a size, a timeout, an address. Code
  reads every setting from the project's configuration. Code that
  finds a setting missing refuses to start and names the missing key.
- **A hardcoded tuning value is a setting.** A literal such as
  `poll_seconds = 60` moves to configuration.
- **A constant stays a constant** where the product's design or an
  outside rule fixes it: a set of presets the user picks from (16, 24,
  48, 64), a value a spec or protocol fixes (an HTTP status, an MQTT
  QoS level), a value math fixes (1024 bytes per KiB), a value a data
  format fixes (a hash length).
- **Deployments keep their behavior.** The change that removes a
  default updates every deployment script and configuration file the
  project owns to set that key, with the former default as its value.

The test stack's configuration then sets its own values, and the
production configuration sets its own. A change to one cannot reach
the other. Accept-list entry A8 already counts "code that breaks a
rule the project states" as a defect, so review flags a default in
code once the rule stands in `plumbline-coding.md`.

### 2. Every timer has a seam

A seam is a real product interface that lets a caller force an event
or set the time: a manual trigger (an operator command or an admin
route that runs a tick, a pass, or a refresh now), an injectable
clock, or an exposed setting.

- **A coding rule requires it.** Every timer, schedule, or
  threshold-driven event the product runs has a manual trigger or
  takes its clock from outside. The rule binds all code, existing code
  included, so the next `/converge analysis` reports each old timer
  with no seam as an A8 defect.
- **A seam that changes time or forces events has its own on-off
  setting**, such as `clock.control.enabled`. Under section 1 the key
  has no default. Production configuration sets it to `false`; the
  test stack's configuration sets it to `true`.
- **A public seam changes the surface intent.** An operator command or
  an admin route is a member of a public class. The sprint that adds
  it carries a surface intent delta, which the owner approves with the
  sprint.
- **Test-only code stays banned.** A fixer or verifier still sends
  back code that checks whether a test runs, treats a test's data as a
  special case, or fakes the outcome a test checks. A seam passes the
  check because every deployment carries it and the operator controls
  it through a setting.

### 3. Regular sprints build seams as they go

The `/plan-sprint` code planner (`skills/plan-sprint/core.md`) notes
each timer, schedule, or threshold a work item adds, and names the
seam that lets a test reach it without waiting. The seam, its on-off
setting, and any surface intent delta join that work item. The owner
approves them with the sprint. Sprint certification checks them under
section 2's coding rule.

### 4. A test sprint may build seams, with the owner's sign-off

Today `/plan-tests` forbids product changes. `skills/plan-tests/core.md`
says "A test never changes product code to cause its condition"
(line 348) and "Change no product code to make a condition possible"
(lines 801–802). The fixer and the verifier reject a fix that "reads a
setting only a test sets" (lines 971 and 1039). A test whose outcome
waits on a timer can only wait it out.

The change:

- **Planners list each missing seam.** For each planned test, the
  `reach` names the event, the tick, or the clock move the test waits
  on, and the seam that forces it. A seam the product lacks becomes a
  seam item in the plan, with its setting and any surface intent
  delta.
- **The owner approves the seam list with the plan**, in the one plan
  approval the owner already gives.
- **The test sprint builds seams first.** A seam stage runs before the
  test writers, as product work under section 2's rules. Test writers
  start once every seam exists.
- **The prompts narrow their ban.** Lines 348, 801–802, 971, and 1039
  keep their ban on test-only code and allow a seam the plan approved.

### 5. Each test takes the cheapest reach

A planning rule: each test uses the cheapest reach that still proves
its outcome.

- An outcome inside one service is tested through that service's
  exported function or command, with its clock injected.
- An outcome that crosses services is tested on the shared stack.
- Only an outcome about bringing up a deployment brings one up.

The planning reviewer sends back a stack test whose outcome a cheaper
reach proves. The test-writer rule "Mock nothing the scenario checks"
stays: a cheaper reach drops the services the outcome does not cross,
and never fakes the one it checks.

### 6. A required batch runner

The owner ruled `tests-tool-owns-the-per-test-run-loop`: the project
owns its suite run end to end, through one contract. The project
declares a command over a list of tests, which runs them in whatever
way its tools allow, and writes one result line per test as each
finishes. The round grows as results land. A planned test the stream
never reports reads as failed. The command is required: a serial
fallback nobody picked would be a hidden default.

This sketch adds two parts to that contract:

- **A watchdog replaces the per-test timeout.** The suite stops a run
  when no result line arrives for the period the project declares. A
  slow test no longer fails on time. `scripts/tests`
  `DEFAULT_TIMEOUT = 600` goes, under section 1.
- **Every round lists its slowest tests**, with each test's seconds,
  setup and teardown included. The list is a report, not a verdict.

The one-test command stays, for a fixer running its own test.

### 7. The plan budgets the shared stack

The plan treats the shared test stack as one resource the whole suite
spends. A planning reviewer reads the whole plan against four parts
before the owner approves it:

- **Each test gets a phase.** A shared test touches only data it
  created and named, and runs on parallel workers. A deployment test
  brings up its own platform, and runs one at a time beside the shared
  phase. A disruptive test restarts or reconfigures a shared service,
  moves the clock, or changes a deployment-wide limit, and runs alone
  after the shared phase. The batch command runs the phases.
- **The plan sizes the stack.** The plan names the worker count. The
  test stack's configuration sets memory, pools, and deployment-wide
  limits for that many workers. A preflight before any test task
  checks that the test stack runs alone with the memory it needs.
- **Scarce limits get a plan.** For each deployment-wide limit, such
  as one sign-in per user or eight fleet members, the plan says
  whether the test stack's configuration raises it, the workers split
  it, or a lease hands it out.
- **The suite checks for leaks.** The project names the resources to
  count. After each round, the suite compares each count with the
  count before the round. A leak fails the round, and its fix joins
  the fix loop.

### 8. The fix loop reruns only failing tests

Step 6 of `skills/plan-tests/test-sprint-document.md` reruns every
test after each fix batch. The new loop:

1. Run the full suite once, and record the round.
2. Fix and verify every failure, as today.
3. Rerun only the tests that failed. Repeat steps 2 and 3 until they
   all pass.
4. Run the full suite as the gate. A new failure is a regression a fix
   caused, and returns to step 2.
5. The sprint completes only when a full round passes.

### 9. Tests never wait on the wall clock

The owner ruled `test-sprints-write-tests-that-wait-on-the-wall-clock`:
restore the testing standard as a suite standards document, condense
it into the cheatsheet's Tests section, cite it from the test-writing,
fix, and verify prompts, and widen the verifier to send back any test
or fix whose verdict waits on elapsed time. Sections 2, 4, and 5 give
that standard the means to hold.

### Suite files the work touches

- `docs/plumbline-coding.md` and `docs/plumbline-cheatsheet.md`: the
  no-defaults rule and the seam rule.
- `skills/plan-sprint/core.md`: the code planner's seam notes.
- `skills/plan-tests/core.md`: the seam items, the narrowed bans, the
  cheapest-reach rule, the phases, the stack budget, and the planning
  reviewer's checks.
- `skills/plan-tests/test-sprint-document.md`: the seam stage, the
  preflight, the leak check, and the new fix loop.
- `scripts/tests`: the batch runner contract, the watchdog, the
  slowest-tests list, the leak check, and failing-only reruns.

## Open questions

- How the project declares its leak counts. Assumed: a command that
  prints one count per resource, declared beside the batch command.
- Whether the planner names each test's phase or the batch command
  derives it. Linescout's runner derives it from each test's static
  reach. Assumed: the planner names it in the plan, and the batch
  command reads it.
- Whether the no-defaults rule reaches settings of a library the
  project depends on, such as PyJWT's 300 s key cache. Assumed: where
  the project passes the value, it passes it from configuration.
- Whether a trigger that forces no event and changes no time, such as
  a read-only status call, needs its own on-off setting. Assumed: no.
- How a consumer outside the project, running its own deployment with
  its own configuration, meets a newly required key. Assumed: the
  startup refusal names the key, and the release notes of the
  project's deployment say which keys each release adds. This touches
  the release boundary.
- Whether the cheatsheet should say that review counts as the check
  for a rule only judgment decides. The no-defaults rule and the seam
  rule both take judgment: whether a value is a setting, and whether
  a timer has a seam. No lint can decide either, so review under A8
  is their check, and this sketch plans no lint for them. The
  cheatsheet's Mechanical Checks section says "Every written
  constraint needs a check that fails on violation", which a reader
  could take as a demand for a lint.
- How linescout restarts: a fresh `/plan-tests` under these rules,
  and what happens to its 386 uncommitted paths and its open test
  sprint.

## Risks / unknowns

- The seam rule and the no-defaults rule bind existing code, so the
  first `/converge analysis` in each project after true-up may report
  a large batch of defects.
- A seam in production widens what an operator, or an attacker with
  operator access, can do. The on-off setting is the only guard.
- Common test runners may not write one result line per test as each
  finishes without a plugin the project maintains. The runner ruling
  names that as its flip case.
- The cheapest-reach rule could push planners toward tests that skip
  the joins between services where real defects live. Section 5 keeps
  cross-service outcomes on the stack, and the planning reviewer must
  hold that line.
- Sizing a stack for N workers may need more memory than a developer
  machine has. Linescout's write stage ran its dev stack, its test
  stack, and deployment tests in 8 GB, and services died.

## What this is not

- It does not run fixers in parallel. Fixers stay one at a time, each
  with its own snapshot, because shared-stack restarts make parallel
  fixes hard to verify.
- It sets no time budget as a verdict. The slowest-tests list reports
  time and decides nothing.
- It adds no per-language lint for sleeps or polls. The wall-clock
  ruling rejected that option until a test sprint run under the
  restored standard still ships tests that sleep or poll.
- It does not plan linescout's own cleanup. Linescout restarts from
  `/plan-tests` once the suite carries these changes.
