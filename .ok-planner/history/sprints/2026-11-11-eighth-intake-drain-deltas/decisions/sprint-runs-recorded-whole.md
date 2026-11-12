---
decision: sprint-runs-recorded-whole
---

# Every run that names a sprint is recorded whole, at its end

## Choice

Each run of the tests tool gives its results stream a path of its own
and prints each line as it lands (see also:
project-owns-its-suite-command). Every run that names a sprint is
recorded in the sprint's results file, a run of chosen tests
included, as a round of kind `rerun` unless it runs the whole suite.
A run appends its whole round to the results file once, at its end,
under a short lock.

## Rationale

A stream per run keeps two runs' lines apart. Recording every run
that names a sprint, reruns included, gives each test's standing
result a record (see also: fixes-rerun-the-tests-they-reach).
Appending each round whole, at its run's end, under a short lock,
keeps runs side by side from mixing their lines; a run that crashes
loses its own lines and no other's.

## Alternatives

- One stream path for every run: two runs at once write their lines
  into one stream.
- Record only whole-suite rounds: a rerun's result reaches no record.
- Append each line to the results file as it lands: two runs side by
  side mix their lines in one file.
