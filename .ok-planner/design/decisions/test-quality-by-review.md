---
decision: test-quality-by-review
---

# Test quality is enforced by code review, never by lint or audit

## Choice

The suite carries one testing standard, materialized in the plumbline
estate as a document of its own, with the cheatsheet's Testing
section as its ambient copy. The standard's rules: a test's verdict
never depends on elapsed time. A test waits on events the product
emits, never on durations. The product exposes its progress as events
a test can wait on. The product takes time and cadence from outside,
and the test drives them: it fires the tick and observes the outcome;
cadence runs at its minimum only where manual drive is impossible.
The one wall-clock in a run is a progress watchdog outside every
test; it watches test events, and its trip stops the run and waits
for the owner — never a verdict. A test proves a behavior a user or a
story owes. The reviewer reports a test that duplicates a proof or
proves nothing; the fix removes or merges it. The builder fixes a
flaky test at its cause and never tunes it to pass. Placement, tiers,
and shared harnesses are the project's own choices and no part of the
standard.

Review alone enforces the standard. The certification code-review
brief carries it as a focus. Substance comes first: is the test
substantive or specious, does it prove a behavior something owes,
should it extend an existing test, does the suite grow only where a
new behavior needs proving. The standard's rules come second. The
standing reviewer applies the same brief as each stage lands; the
gate's cold reviewer applies it over the whole diff. No lint check
and no audit role: the plumbline lint's charter stays comments and
citations, and the audit measures the public surface.

## Rationale

The mechanically decidable subset — sleeps, deadline polls, timeout
flags — is language-specific and a poor proxy for the standard. A
lint over it is frail and restrictive, and it teaches agents to route
around it. The tradeoff `decision:steering-over-prose-lint` made for
prose holds for tests. Only a reader with the code open can decide
the half that matters: is the test substantive, should it stand
alone, does the suite need it.

Review at write time is where drift is cheapest to catch: the builder
still holds what the test was for. The gate's cold reviewer is the
second read. Suites in projects under the suite have grown without
constraint; a review that asks each test what it proves is what
constrains them.

## Alternatives

- A test-hygiene lint check with a `/budget` ratchet — the decidable
  subset only, per-language pattern tables, false positives.
- The audit measuring test quality — the audit is the public-surface
  instrument and fixes nothing.
- Prescribing placement and tiers — project-specific; the standard
  governs how a test reaches its verdict, not where it lives.
- A dedicated test reviewer in the team
  (`decision:team-execution-cold-gate`).
