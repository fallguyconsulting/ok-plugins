---
decision: workers-sized-per-machine
---

# Each machine keeps its own worker count, with the reason for each change

## Choice

A record outside the committed tree, kept on the machine, holds one machine's measured resources (its cores, its memory, its
Docker memory, and the memory other containers hold), the worker
count chosen for that machine, and a dated history of each change,
with the constraint and the evidence behind it, such as a failed round
or a preflight refusal. Where the record exists, `tests run` runs the
record's count in place of the budget's, and never more than the
budget's (see also: test-stack-budgeted-as-one-resource). A run
given a worker count runs that count, never more than the budget's,
so the flaky fixer reproduces a round at the count it ran. `tests
machine` measures the machine and prints the record. The preflight and
the budget planner read the record, and where the machine cannot carry
the budget's workers, they write a lowered count with its reason
instead of closing `blocked`. The flaky fixer is one writer of the
record (see also: flaky-tests-traced-through-the-round-window).

## Rationale

One committed count runs the same load on every machine that runs the
suite. On one project the budget named 8 workers. The preflight closed
`blocked` while the developer's own stack held 5.46 GiB of Docker
memory against a 6.5 GiB bound, and the first round after it failed 22
tests with services not answering, 19 of which passed alone. Each such
failure becomes a fixer task, so an overloaded machine costs fix
rounds as well as the failed round (see also:
story:suite-fits-the-machine-it-runs-on). A record kept on the machine
starts its next run from what the last run learned, and each change's
reason tells the next agent why the count stands where it does. A
record outside the committed tree changes no other machine's count. A
count above the budget's would run more workers than the stack's
sizing carries.

## Alternatives

- A committed range and a sizing rule, from which each run picks a
  count by measuring the machine at its start: every run measures
  again, and a count that failed a round on this machine is not kept.
- One committed count the preflight may lower for one sprint: the
  lowered count and its reason end with the sprint, and a machine that
  overloads in a round has no way to lower it.
- One committed count for every machine: a machine below the budget
  fails tests that pass alone, and each failure costs a fixer.
