---
name: coverage
description: "ONLY activated by explicit /coverage slash command. Never auto-triggered by conversation content."
---

# Recover Acceptance Coverage

Find the use cases a project **claims** to support but does not **prove** it
supports, and turn each into an acceptance gap the normal pipeline can close.

For a project whose features shipped before acceptance scenarios existed — unit
and integration tests green, but the assembled product never driven end-to-end
through its real value path — this skill is the diagnostic that seeds recovery.
It reads the product's own claims, subtracts what is *really* covered, and emits
a transient coverage report: a ranked backlog of genuine gaps (each a proposed
acceptance scenario) and a list of drift symptoms (claims the product doesn't
actually back). You then drive each item through `brainstorm → write-plan →
execute-plan`, where the acceptance pass is now mandatory.

<HARD-GATE>
This skill produces a **report**, not code. Do NOT write tests, fix bugs, edit
the product, or remove claims while running it. It does not run the product
either — the acceptance tests that would run it don't exist yet; their absence
is the gap. Every fix is routed to a later cycle through the report. The skill's
only writes are the coverage report and (via `affirm`) the `.ok-planner/`
layout.
</HARD-GATE>

## Why this skill exists

The forward pipeline now makes working software emerge by construction: every
spec with user-observable behavior opens with a complete set of **user-outcome
stories** (see `brainstorm`'s "User outcomes"), and `write-plan` turns each into
a final **acceptance gate** that boots the real product with the value-delivering
component real, not stubbed. The accumulated per-story acceptance gates *are* the
project's end-to-end regression corpus — no registry is maintained by hand.

A project that shipped before those gates has none of them. Its real value loops
— the executor, sensor, subscriber, worker, or whatever the product exists to
run — have never actually run under test; the suite proves the skeleton and
stubs the muscle. This skill is the one-time convergence that brings such a
project onto the new invariant: **every supported use case has a real acceptance
gate.** After it, the forward pipeline keeps the corpus current; the skill is for
the backlog that predates it.

## Process

1. **Affirm layout** — invoke `ok-planner:affirm` so `.ok-planner/` exists.
2. **Enumerate claimed use cases** (claims-only) — Phase 1.
3. **Detect real acceptance coverage** for each — Phase 2.
4. **Classify** each claim: covered / real gap / drift symptom — Phase 3.
5. **Rank gaps and draft their acceptance scenarios** — Phase 4.
6. **Write the coverage report** — Phase 5.
7. **Hand off** — present the report, route gaps and drift symptoms into the
   normal pipeline. Do not implement — Phase 6.

Phases 1–5 run **autonomously** — this is analysis, not dialogue. The one
decision that is the user's, not yours — *is an uncovered claim a real gap to
build, or a non-feature to retract?* — is not resolved mid-run; it is **flagged
in the report** with the evidence and a recommendation, and the user settles it
when they drive the backlog. Do not stall the run to ask.

## Phase 1 — Enumerate from concrete claims only

Build the universe of use cases the project asserts it supports. Read, in
priority order:

1. **The product's own "what it's for"** — the README's capability/use-case
   statements, and any first-party docs the project ships.
2. **The invocable surface** — CLI verbs and their help text, the public API
   routes, the wire protocol's user-facing operations.
3. **The design concepts** — `.ok-planner/design/concepts/` (if present): each
   load-bearing noun's stated behavior and invariants is a claim about what the
   product does.

**Claims-only discipline (load-bearing).** Enumerate only capabilities the
project *concretely asserts*. Never infer a goal from "a platform like this
ought to support…", from a dependency's feature list, or from what a reasonable
user might expect. If you cannot point to the sentence, route, verb, or concept
that asserts the capability, it is not a claim — drop it. This discipline is the
whole reason a surfaced non-feature is a real drift signal and not skill noise:
if the skill invents goals, it manufactures phantom gaps and the diagnosis
becomes worthless. When unsure whether something is a claim, find its assertion
or drop it.

**Promised failure behavior is a claim too.** Negative-outcome behaviors the
product promises — "a failed unit is retried," "a held resource blocks a second
acquirer," "a lost heartbeat re-enqueues the work," "a malformed request is
rejected with «error»" — are use cases like any other. They go in the universe
and get the same coverage check. (Distinguish these *promised* negatives from
mere input guards with no promise behind them; both can warrant a test, but only
promised behavior is an acceptance use case — see `brainstorm`'s split.)

For each claim, record:

- **Capability** in product terms — what the running product does for a user.
- **Source** — cite where it's claimed (README line, route, verb, concept slug).
- **Real entry point** — the route / CLI verb / wire message a user would hit.
- **Real observable outcome** — the persisted state, response, downstream effect,
  or terminal the claim promises.
- **Value-delivering component** — the thing whose *real operation* the claim is
  about. This is the crux of the next phase: is the value the **orchestration
  itself** (routing, scheduling, persistence — provable with the real control
  plane and a stub worker), or is it a **specific component doing real work**
  (an executor / sensor / subscriber / worker whose output is the point — only
  provable with a real one)?

## Phase 2 — Detect *real* coverage (the crux)

For each claim, decide whether the suite already proves it. A claim is **really
covered** iff a test exists that meets all three:

- **(a) Drives the real entry point end-to-end** — the real route / CLI / wire
  path, or the assembled product, not a constructed handler call or an in-memory
  assembly of structs.
- **(b) Exercises the claim's value-delivering component *for real*** — if the
  value is a component doing real work, a stub or canned-success substitute for
  that component does **not** count; if the value is the orchestration itself, the
  real control plane suffices and a stubbed worker is fine. Judge this *relative
  to what the claim's value is* (Phase 1's last field).
- **(c) Asserts the real observable outcome** — a persisted row, a wire call, a
  returned status, a terminal reached, bytes written. Not the *shape* of a
  struct / proto / config, and not "returned without error."

**Nominal-but-not-real coverage to reject** (these read as coverage and aren't —
cite the offender when you find one):

- A test that is its own client *and* server (it posts to a fake it stood up and
  asserts the fake received it).
- A tautological assertion — asserting a value the test just set, or a
  getter/field on a proto the test constructed.
- A shape-only assertion — the test name implies an end-to-end outcome but the
  body only builds a value and checks its fields.
- A stub-driven scenario where the claim's value *is* the stubbed component (the
  spine runs for real, the muscle is canned — covers orchestration, not the
  component's work).
- A test that `Skip`s when its resource (Docker, a container, a network) is
  absent, so it proves nothing in the environments where it's skipped.

**Judge per claim, by reading the candidate tests — not suite-wide.** This is the
same "is this test theater?" judgment `review-plan` applies, raised to acceptance
altitude. **When in doubt, mark NOT covered.** A false "covered" is exactly the
failure this whole effort exists to prevent — it lets a use case look proven when
the real loop never ran.

Parallelize across claim clusters by dispatching a coverage-audit subagent per
area:

```
Agent (general-purpose):
  You are auditing whether a project's tests REALLY cover a set of claimed
  use cases. For each claim below, decide: really-covered | nominal-only |
  uncovered. Read the actual tests — do not trust test names.

  Claims (each with its real entry point, real observable outcome, and
  value-delivering component):
  [list for this cluster]

  A claim is really-covered ONLY if a test (a) drives the real entry point
  end-to-end (real route/CLI/wire/assembled product, not a constructed
  handler call or in-memory struct assembly); (b) exercises the claim's
  value-delivering component FOR REAL — if the claim's value is a component
  doing real work, a stub/canned-success stand-in does NOT count; if the
  value is the orchestration itself, the real control plane with a stubbed
  worker is fine; and (c) asserts the real observable outcome the claim
  promises — a persisted row, a wire call, a returned status, a terminal —
  NOT a struct/proto/config shape and NOT "no error".

  Reject as nominal-only, with the file:line: client-and-server-in-one
  tests; tautologies (asserting a just-set value or a constructed proto's
  getter); shape-only assertions; stub-driven scenarios where the claim's
  value is the stubbed component; tests that Skip without their resource.

  When uncertain, return uncovered — a false "covered" is the worst outcome.

  For each claim return: verdict, the test(s) you examined (file:line), and
  one sentence of evidence. If really-covered, name the single test that
  best proves it.
```

## Phase 3 — Classify each claim

Every enumerated claim resolves to exactly one of three dispositions:

- **Covered** — real coverage exists (Phase 2). It does **not** appear in the
  report's working sections; covered use cases are captured in their tests, which
  are the source of truth. (A brief ledger line goes in the report only as
  evidence the subtraction was done — not a list anyone maintains.)
- **Real gap** — the code clearly implements the capability (or its parts) but no
  *real* acceptance test proves it. → goes to the **gaps backlog** (Phase 4).
- **Drift symptom (non-feature)** — the claim has **no real implementation behind
  it**: the project asserts a capability it does not (and should not) back. The
  proposal exists only because *something claimed it*, and that something is the
  bug. → goes to the **drift symptoms** section.

For each drift symptom, name the cause — it determines the fix:

- **Over-claim** — the README, a doc, or a concept describes a capability the code
  never delivered. Fix: edit the claim to match reality.
- **Half-completed work** — a partially-wired surface (a dead-ending route, CLI
  verb, or config key) that looks like a feature from outside. Fix: delete the
  dead surface (or finish it, if it turns out to be a real gap — the user's call).
- **Concept drift** — a concept's Boundaries in `.ok-planner/design/concepts/`
  describe an old scope the code has moved past. Fix: correct the Boundaries.

**The hard middle is the user's call, not yours.** "Is this a real gap to build,
or a non-feature to retract?" is a product-scope decision. Classify confidently
where the evidence is one-sided — clearly-implemented-but-untested → gap;
clearly-claimed-but-absent → drift — and for the genuinely ambiguous (a
half-built surface that might be intended), put it in the report flagged
**needs-your-call** with the evidence and your recommendation. Do not decide it
unilaterally and do not stall the run to ask.

## Phase 4 — Rank gaps and draft their acceptance scenarios

**Rank** the gaps by **loudest-claim × weakest-coverage**: the capabilities the
product promises most prominently, with the thinnest real coverage, go first.
A headline use case with only nominal coverage outranks a peripheral one with
none — highest credibility risk first.

For each gap, **draft the acceptance scenario** exactly as `brainstorm`'s "User
outcomes" defines a story's acceptance: **«what the user does, in user terms» →
«what they observe happening»**, with the value-delivering component **real, not
stubbed**. Keep the scenario user-observable — do **not** pin the specific
delivery surface inside it (route shape, CLI flag syntax, wire format). The
surface is the **Real entry point** field captured back in Phase 1; it becomes
the `TD-` that pairs with the story when this gap is taken into the pipeline.
This prose scenario plus its entry-point field is the deliverable — together
they become one of the spec's user-outcome stories and one of its technical
decisions when the gap is taken into `brainstorm` / `write-plan`, and
`write-plan` turns the story into its mandatory acceptance gate.

**Do not write the test.** The scenario is a design artifact; the acceptance pass
(the executable gate) is written downstream by `execute-plan`, against the real
product. This skill discovers; the existing pipeline fixes.

## Phase 5 — The coverage report

Write to `.ok-planner/coverage/YYYY-MM-DD-coverage-report.md` (create the
`coverage/` directory if absent). The report is **transient**: regenerated whole
on each run, never appended, not a durable registry — safe to gitignore. A later
run re-enumerates, re-subtracts current coverage (including any acceptance tests
added since), and re-classifies from scratch.

```markdown
# Acceptance Coverage Report — <date>

## Summary
- Claims enumerated: N (sources: <README / routes / CLI / concepts>)
- Really covered: C
- Real gaps (uncovered): G
- Drift symptoms (non-features surfaced): D

## Coverage gaps (ranked)
For each gap, in rank order:
- **Capability** (product terms)
- **Source claim** (citation)
- **Value-delivering component**
- **Proposed acceptance scenario** — «what the user does, in user terms» → «what they observe» (delivery surface captured in the Real entry point field above; becomes a `TD-` when the spec is written)
- **Why current coverage is nominal, not real** — cite the test(s) and the gap
- **Rank rationale** — loudness × coverage-weakness

## Drift symptoms — remove the false signal
For each:
- **The claim** and where it's asserted (citation)
- **Cause** — over-claim / half-built surface / concept drift
- **Fix** — the false signal to remove (edit the claim / delete the surface /
  correct the Boundaries)
- **needs-your-call** — set if it's an ambiguous gap-vs-non-feature, with a
  recommendation

## Covered (ledger)
One line per really-covered claim with the single test that best proves it.
Evidence the subtraction was done — NOT a list to maintain.
```

## Phase 6 — Handoff

Present the report's **Summary** and the top of the ranked gaps to the user. The
report drives the recovery campaign; **this skill does not implement.** Then route:

- **Each gap → the normal pipeline.** Take it into `brainstorm` (or straight to
  `write-plan` for a simple, well-understood one) as a spec whose acceptance
  scenario is the one drafted in Phase 4. `write-plan` makes it the acceptance
  pass; `execute-plan` writes and runs it against the real product — and any real
  bug the acceptance run flushes out is fixed there, under the project's own fix
  discipline.
- **Each drift symptom → a small cleanup spec** that removes the false signal
  (edit the README/doc/concept, delete the dead surface), through the same
  `brainstorm → write-plan → execute-plan` path. This is **self-eliminating**:
  once the misleading claim is gone, a re-run of this skill never re-proposes it.
  There is no suppression list, because the project's self-description now tells
  the truth.

Do **not** auto-invoke the pipeline. Recovery is a campaign the user drives item
by item, highest-rank first, in sessions of their choosing. Tell the user the
report path, the gap and drift counts, and that re-running `/coverage`
anytime regenerates the report against current state.

**The health-signal property.** A non-feature appearing in the report is itself a
finding: the project's words and its behavior have diverged. A healthy project
enumerates clean — no drift symptoms, and a shrinking gaps list as the forward
pipeline accumulates acceptance passes. A noisy report is a drift detector;
convergence to an empty report is the goal.
