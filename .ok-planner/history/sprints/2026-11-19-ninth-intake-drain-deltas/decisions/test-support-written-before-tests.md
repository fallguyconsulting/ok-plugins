---
decision: test-support-written-before-tests
---

# A sprint's test stages write test support before any test of the pass

## Choice

A sprint's test stages write each test support file its planned tests
name in a test support task of its own. The test support task's brief
carries every scenario that names the file, with the outcome the
scenario checks and how its test reaches the code, and the task writes
every helper those tests need. Each filing of the write stage is a
pass, and every test task of a pass waits on every test support task
of that pass, so test support runs as a phase of its own before any
test of the pass runs. A test task reads the test support files it
uses and holds only its own test files, so test tasks run beside each
other.

A test task that finds its test support short records what it needs, a
missing helper, a changed helper, a fixture, or, where the project has
a seed its setup step builds, a seed entry (see also:
seed-recommended-never-required), and writes no test; a test support
task makes the change before the test task runs again. Where several
send-backs share one cause in a test support file, one test support
task may fix the cause for all of them.

A rewrite of a test that a verifier or a speed reviewer sent back runs
after its test support exists. It holds its scenario's test support
files as well as its test file, and may change them.

## Rationale

Two writers never hold one file at once (see also:
decision:build-task-per-stage). Where each test task also holds
every test support file it uses, a test support file most tests use
puts nearly every test task in one chain. On one project a fixture
file sat in 404 of 500 test tasks, the longest chain ran 412 tasks,
and the run averaged about 1.2 agents at once where the drain allows
8. Writing test support first keeps one writer per file and lets the
test tasks run at once. One writer per test support file also writes
each shared helper once, where hundreds of tasks adding to one file
invite near-duplicate helpers.

A test reaches test support files its scenario does not name, through
an import from one test support file to another or through the shared
files every test loads, so a test task that waited only on the test
support tasks of the files its scenario names could start before a fix
to a file it imports. On one project seventeen test tasks closed
`blocked` that way, each on a test support file whose task was already
filed and closed minutes later. Test support tasks are few and run
first, and a broken shared test support file breaks every test that
loads it, so a test task waits on all of its pass's test support.

The cost: test support is written before any test shows what it lacks,
so a missing helper costs a follow-up test support task and a second
run of its test task. One test support task per shared cause fixes the
cause once, where a fix per test would repeat it in every test that
meets it. A send-back's cause may lie in a test support file the test
reads, so a rewrite that held only its test file could not fix it. Two
rewrites that hold one test support file chain, as any two tasks on
one file do.

## Alternatives

- Each test task holds its test file and every test support file its scenario names: one writer per file, and a widely shared file chains nearly every task.
- Each test task waits only on the test support tasks of the files its scenario names: a test that imports another test support file runs before that file's fix.
- The tests tool computes each test's import closure over the test paths, and the test task waits on the test support task of every file in it: a reader of imports per language, and a shared file every test loads still reaches every test.
- The planner follows imports from each test support file it names: a list written by hand misses the import it did not follow.
- Several test tasks edit one test support file at once under a lock: two writers hold one file, and concurrent edits need a merge rule.
- One test task per group of scenarios that share test support files: a file most scenarios share makes one huge task, and one failure holds back the group.
- Each scenario names the test support files it reads and those it adds to, and only an add holds a file: adds still chain, and a test can run before the task that adds the helper it needs.
- A rewrite holds only its test file: a send-back whose cause lies in a test support file needs a test support task first, and the rewrite waits on it.
- One test support task per send-back, each sharing a cause: the shared cause is fixed once per test, and every such task chains on one file.
