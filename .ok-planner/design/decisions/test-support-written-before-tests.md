---
decision: test-support-written-before-tests
---

# A test sprint writes each support file before the tests that use it

## Choice

A test sprint writes each support file its planned tests name in a
support task of its own, before any test that uses the file. The
support task's brief carries every scenario that names the file, with
the outcome the scenario checks and how its test reaches the code, and
the task writes every helper those tests need. Each test task waits on
the support tasks for the files it names, reads those files, and holds
only its own test file, so test tasks run beside each other. A test
task that finds a helper missing reports the helper and writes no
test, and a support task adds the helper before the test task runs
again.

## Rationale

Two writers never hold one file at once (see also:
decision:team-execution-cold-gate). Where each test task also holds
every support file it uses, a support file most tests use puts nearly
every test task in one chain. On one project a fixture file sat in 404
of 500 test tasks, the longest chain ran 412 tasks, and the run
averaged about 1.2 agents at once where the drain allows 8. Writing
support first keeps one writer per file and lets the test tasks run at
once. One writer per support file also writes each shared helper once,
where hundreds of tasks adding to one file invite near-duplicate
helpers. The cost: support is written before any test shows what it
lacks, so a missing helper costs a follow-up support task and a second
run of its test task.

## Alternatives

- Each test task holds its test file and every support file its scenario names: one writer per file, and a widely shared file chains nearly every task.
- Several test tasks edit one support file at once under a lock: two writers hold one file, and concurrent edits need a merge rule.
- One test task per group of scenarios that share support files: a file most scenarios share makes one huge task, and one failure holds back the group.
- Each scenario names the support files it reads and those it adds to, and only an add holds a file: adds still chain, and a test can run before the task that adds the helper it needs.
