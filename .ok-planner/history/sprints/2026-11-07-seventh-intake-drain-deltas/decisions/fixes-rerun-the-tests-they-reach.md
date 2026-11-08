---
decision: fixes-rerun-the-tests-they-reach
---

# A fix reruns the tests it reaches

## Choice

Each live test has a standing result: its latest result since the
latest closed whole-suite round, with the digests of its test file and
its support files when it ran. `--failing` reruns every standing
failure, not only the latest round's. `--changed` reruns each test
whose test file or support files changed since it last ran. A round
that stops records each test it never reached as `not run`, not as
failed, and no fixer is filed for each; the stop of a whole-suite
round files one report (see also: stopped-round-files-one-report).

Which later round clears a failure that belongs to a whole round is a
rule of its own (see also: round-failure-cleared-by-a-later-round).

Each result line the suite command writes may carry `reaches`: the
product files the test ran, from a per-test coverage record, or, for a
stack test, the folders of the services it reached. A folder covers
every file under it. The tests tool keeps each test's latest
`reaches`, and every run of a test replaces it. The first whole-suite
run builds the map, and the scenario list keeps it across sprints (see
also: scenario-list-decided-once). A project records what its suite
command writes in `testing.reaches`, a required key that holds the
form, `files`, `folders`, or `none`, and the owner's words for it. The
key has no default in code (see also: settings-have-no-code-defaults).
While the key holds no words from the owner, the tests tool uses the
form the key names, as it does for the schedule (see also:
tests-isolated-unless-declared).

After a fix, the verifier reruns each test whose `reaches` names a
file the fix changed or a folder above one, and sends back a fix that
fails a test that passed before it. No record means rerun: a test with
no `reaches` reruns after every fix. A changed file no test's
`reaches` names, such as a configuration file, a template, a
migration, or a lockfile, reruns every test. These rules hold where
`testing.reaches` names `files` or `folders`. Under `none`, the
verifier reruns only the tests the fix was for, and the final
whole-suite round catches the rest. When a failing test that passes
alone counts as fixed is the test loop's rule (see also:
test-loop-fixes-code-never-tests).

## Rationale

A fix can break only a test that runs the code the fix changed, so a
coverage record per test names every test a fix can break and leaves
the rest unrun. Rerunning only the failing tests between fixes, with
the whole suite as the gate, finds a fix that breaks a passing test
only at the gate, a whole round later, and rerunning the whole suite
after every fix pays a round per fix. A missing record could hide a
regression, so a test with no `reaches` reruns, and so does every test
after a change to a file no record names, which can reach any test. A
stack test runs code in services the suite command cannot tie to one
test, so the folders of the services it reached stand in for its
files. A project whose suite command writes no coverage has no record
to read, and rerunning the whole suite after each of its fixes would
pay a round per fix, so its final whole-suite round is the one check
for a regression a fix causes. A record that a test's next run replaces stays as current as
the test's last run, and the first whole-suite round builds it at no
extra cost. A standing result that outlives its round keeps a failure
in view until a later run passes it. A round that stops early leaves
tests that never ran, and reading them as failed would file a fixer
for each.

## Alternatives

- Rerun only the failing tests between fixes, with the whole suite as
  the gate: a fix that breaks a passing test shows a round later.
- Rerun the whole suite after every fix: catches each regression at
  once, and pays a whole round per fix.
- Map tests to product files from the citations in their code: misses
  every file a test reaches through a service or a shared helper.
- Treat a test with no `reaches` as reaching nothing: a missing
  record hides a regression.
- Require per-test coverage of every project: a project whose runner
  writes none cannot run its suite at all.
- Read a stopped round's unreached tests as failed: files a fixer for
  each test that never ran.
