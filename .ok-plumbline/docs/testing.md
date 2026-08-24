# Testing: the standard

This standard governs how a test in this project reaches its verdict
and which tests the project keeps. Code review enforces it: the
standing reviewer as each stage lands, and the certification gate's
cold reviewer over the whole change. No lint checks it and no audit
measures it.

## What a test proves

- A test proves a behavior a user or a story owes. Name it for that
  scenario, not for the implementation.
- Before adding a test, ask what it proves that no existing test
  proves. Extend an existing test where the new behavior belongs to
  its scenario. Add a test only where a new behavior needs proving.
- Remove a test that duplicates a proof or proves nothing. A test
  that checks the existence of static text, code, or prose proves
  nothing.
- Fix a flaky test at its cause. Never tune it — a wider tolerance, a
  retry, a longer wait — to pass.

## How a test reaches its verdict

- A test's verdict never depends on elapsed time. The same test
  passes on a loaded machine as on an idle one.
- A test waits on events the product emits, never on durations. No
  sleep, no deadline poll, no timeout as a verdict.
- The product exposes its progress as events a test can wait on. Where
  a test needs a signal the product does not emit, add the event to
  the product; the events standard says which sites emit.
- The product takes time and cadence from outside — a clock, a
  ticker, a scheduler — and the test drives them: it fires the tick
  and observes the outcome. Cadence runs at its minimum only where
  manual drive is impossible.
- One wall-clock exists in a run: a progress watchdog outside every
  test. It watches test events, not output. Its trip stops the run
  and waits for the owner. It is never a verdict.

## What stays the project's

Placement, tiers, shared harnesses, frameworks, and runners are the
project's own choices. The standard governs how a test reaches its
verdict and which tests the project keeps, not where a test lives.

<!-- Materialized by ok-plumbline v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
