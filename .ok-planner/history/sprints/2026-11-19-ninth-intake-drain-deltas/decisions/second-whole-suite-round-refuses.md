---
decision: second-whole-suite-round-refuses
---

# A second whole-suite round of one sprint refuses while the first runs

## Choice

A second whole-suite round of one sprint refuses at once while another
is under way: it names that run and its results file, and tells the
user to run again once that run ends. A run of chosen tests takes no
part in this refusal (see also: runs-lock-what-their-tests-declare).

## Rationale

A second whole-suite round would repeat the round under way, so it
refuses at once and names the run to wait for.

## Alternatives

- A second whole-suite round waits for the first: the caller's session
  holds for a whole round to run what that round already runs.
- Two whole-suite rounds run side by side: the second repeats the
  first's work and doubles the load on the shared test stack.
