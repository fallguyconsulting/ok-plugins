---
decision: locks-grow-from-observed-failures
---

# A writer declares the locks its own test shows, and observed failures add the rest

## Choice

A test writer declares the locks its own test code shows: the shared
things the test sets up or checks, and the locks its test support
declares. A planner plans before any test code exists, so it
declares no lock of its own: a re-plan carries the locks a writer or a
fixer recorded for the scenario. Planners make no search for every
other test that might disturb a test. The planning reviewer checks
that a re-plan carries the recorded locks, and the test verifier
checks only the locks the test's own code shows. Every other lock but a
converted one comes from a failure: where a test that failed in a round passes alone, the flaky
fixer reads the round's window, and where it finds the test that
disturbed it, it adds the lock to both tests or to their test support,
with the evidence (see also:
flaky-tests-traced-through-the-round-window). The set of locks grows
only from these findings and from what writers see in their own code,
save true-up's one conversion of the earlier form: each name a test
declared as a shared resource it changes becomes that name held
`exclusive`, and each name it declared as one it only reads is
dropped, adding no `shared` lock.
Each lock a writer or a fixer adds reaches the completion report as a
call.

A race that makes a test pass falsely leaves no record, so
observation cannot add its lock. A new random order every round, the
reset in setup, and the check before and after an action narrow that
case (see also: tests-run-in-a-new-random-order,
shared-outcomes-checked-for-a-new-instance).

## Rationale

A search up front for every test that might disturb another grows
without end and still misses. On one project 514 of 583 test tasks
only rewrote declarations, at over 40 million tokens, while 41 of 44
whole-suite failures passed when rerun alone. A writer sees what its
own test sets up and checks, so that declaration is cheap and right.
A disturbing test shows itself in the window of a failing round,
among the tests that ran beside the failing test or before it. A lock
added from that window names a pair that did disturb each other, so
every lock beside the converted ones is one a run showed it needs or a
writer saw in its own code. A declared resource named a shared thing a
test changed, which the earlier schedule kept apart, so converting it
keeps that separation on the first round. The declared reads came from
the search up front, so the conversion drops them.

## Alternatives

- Planners search the suite for every test that might disturb each
  planned test, and verifiers check the lists: the lists grow faster
  than any run shows they need, and most test tasks only rewrite them.
- Derive each test's locks from what it contacts during a run: a
  measurement to build and keep, and contact does not tell a test that
  cares what others do from one that does not.
- No lock beyond what the writer sees: a pair that disturbs each other
  fails a round now and then, and no route keeps the two apart.
- Convert each declared read to a `shared` lock as well: the lists the
  search up front grew return as locks no run showed.
- Drop every earlier declaration, and start the set empty: a
  converted project's first round meets each separation the earlier
  schedule kept.
- Planners predict each test's locks at planning time: a planner sees
  no test code, so each lock it names is a guess the writer must check
  against the code.
