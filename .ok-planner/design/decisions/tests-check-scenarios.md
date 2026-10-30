---
decision: tests-check-scenarios
---

# A test checks one scenario, and the corpus bounds the scenarios

## Choice

A test checks one scenario, and a scenario exists in two cases only.
A story names it, and executable code carries it: each distinct
outcome a user or the product sees through a program, for any
plausible way the story's implementation gives or refuses its
benefit. Or a runtime
class applies to a runtime part of the product, such as a stored file
and its lock or an outside service, and a harm from the accept list
follows when the part fails that way: concurrency, a dependency down
or slow, a crash mid-operation, shutdown and restart, duplicate or
out-of-order delivery, resources running out, volume, time, version
skew, bad data from outside, or bad configuration. Two outcomes through one program are
distinct when the user or the product sees a different result: a
different reply, a different refusal, or a different state left
behind. One outcome that two programs show is an outcome of each
program, and yields one scenario per program. A second scenario that
checks an outcome another scenario checks through the same program is
a duplicate. Each pairing of part, class, and harm yields one scenario.

Tests cover executable code alone: programs, scripts, services, and
libraries. Skill text, rules, documents, and the design corpus are
prose and have no tests; the drive and review cover them. A scenario
a story names that no code supports is a gap, recorded with no test.
A test that checks no live scenario is an orphan, and a second test of
a covered scenario is a duplicate; the test sprint deletes both. A
program no story serves gets no test: the owner either asks a sprint
for the story it serves or records it as unguarded.

## Rationale

A test earns its place only when it checks the code against
something outside the code: a story the owner approved, or a failure
the product must survive. A test that checks the code against itself,
such as one function's current return value, breaks on every intended
change and catches nothing a type or an assertion would not. A
refusal or a variant the user sees lies outside the code just as a
success does, so each gets a scenario of its own, and a failing test
names the one outcome that broke. Tying
each test to a scenario makes the suite a count: complete when every
scenario has one test or a recorded gap, and bounded by the outcomes
the stories' programs show and by the runtime parts, not by how many
tests an agent thinks to write.
A failing test builds no feature, so a gap gets none.

## Alternatives

- Unit tests per function: the suite pins the code's current shape
  and grows with the code, not with the promises.
- A coverage target: rewards tests of whatever code is easiest to
  reach, and says nothing about what the product owes.
- A test for every program, story or not: tests a tool's current
  behavior, which no promise fixes, so every intended change breaks
  them.
- One scenario per way a story gives its benefit, per program, its
  variants and refusals checked as cases inside one test: one failing
  case fails the whole scenario, and one open issue covers several
  outcomes.
- One scenario per way, with each refusal a story names counted as a
  way of its own: refusals get scenarios, and variants and states stay
  merged.
