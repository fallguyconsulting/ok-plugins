---
decision: seed-recommended-never-required
---

# The testing standard recommends a seed and requires none

## Choice

The testing standard recommends a seed and requires none. A seed is
read-only test data that slow tests read, which the project's setup
step builds.

Where the project has a seed its setup step builds, a speed reviewer
may name a seed entry as the cheaper form, with the objects the entry
must hold, and a test writer may ask for one. Where it has none, no
reader, writer, or support task names a seed, and a test builds or
reads its own data (see also: tests-spend-time-only-on-their-outcome,
test-support-written-before-tests).

## Rationale

Data a test only reads, built once and shared, removes setup the test
would otherwise repeat on every run. A project with no
seed has nowhere to put an entry, so a seed named there could only be
refused, and a refused support task would stop the run.

## Alternatives

- A required seed: a project whose tests read no shared data pays to
  declare one.
- Where no seed exists, a support task creates the seed and the setup
  step that builds it: a sprint adds test infrastructure no planning
  approved.
