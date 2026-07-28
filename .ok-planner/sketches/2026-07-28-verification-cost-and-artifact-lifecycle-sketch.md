# Verification Cost and Artifact Lifecycle — Design Sketch

**Date:** 2026-07-28
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Every project the suite governs eventually meets the same two
problems, and the suite currently names neither: a verification suite
that grows slow because its tests wait rather than compute, and a
verification-artifact population that grows without bound because
nothing retires it. Both were hit in a single whole-corpus
certification run on a consumer project — a 15-minute proof suite
where 98% of wall clock was idling, and ~70 accumulated
content-addressed images that exhausted the host disk and corrupted a
run mid-flight.

Neither is a new domain. Each extends a principle a suite already
holds, and the seam between them is one unstated fact: **a proof is a
test that carries a design annotation.** The planner owns the
annotation. Nothing owns the test.

## Shape

**1. Proofs are tests, and test-authoring conventions govern them.**
The planner defines a proof as a story's deterministic integration
test, discovered by its `@story:` annotation, executed by `/prove`,
and judged for adequacy by the implementation audit. All three are
questions about *design intent* — which story a proof exhibits,
whether every live story has one, whether a green proof spans its
story's acceptance. None is a question about how the test is written.
That belongs to plumbline, which already holds "check speed is a
placement criterion" and "shared code carries a fast contract suite
runnable in isolation." The division: planner owns the link and the
adequacy judgment; plumbline owns authoring; proofs are subject to
both.

**2. Tests establish facts by signal, never by waiting.** A test that
proves absence by burning a timeout is the pure form of the problem —
the deadline is not a bound on failure, it is the guaranteed cost of
success. One consumer suite carried 15 such sites at 8 to 120 seconds
each. The rule shape: a test may wait for a positive signal it expects
to arrive, but must not wait out a clock to conclude that nothing
arrived. Where absence genuinely must be asserted, the discipline is a
sentinel — publish a later record whose arrival proves the earlier one
never will — which converts a timeout into an arrival. Fixed sleeps
and long negative polls are the lint-visible surface.

**3. A test's population is derived, never stipulated.** The
same consumer run found eleven violated design determinations while
the suite was green, and the recurring mechanism was a test whose
subject list was hand-written: a dependency check whose module list
included the modules that would have failed it, a no-retry assertion
that counted objects after object keys became content-addressed, a
conformance property whose sample omitted a field and so short-
circuited eight of its ten cases. Each ran, passed, and certified
nothing. The counter-discipline already exists in the same codebase —
tests that read the command registry, the shipped-adapter registry,
the reserved-name tuple — and generalizes: enumerate from the
artifact under test, and fail when the population changes. This is
plumbline's mechanical-check model applied to test subjects rather
than to code.

**4. Verification is a lifecycle: build, verify, retire.** Workspaces
already commits the first two beats — build outputs tagged by
source-tree hash, harnesses resolving artifacts by that tag, no
mutable tag in a verification path, staleness unrepresentable rather
than avoided. The third beat is missing, and it is not optional: a
rule that mints one immutable artifact per source state and never
retires any is a monotonic disk leak by construction. The shape is a
retirement policy the workspace owns — superseded tags for a given
workspace are reclaimable once no runtime references them — plus the
audit sweep noticing when a population has grown past a threshold.
`/close` already performs job-scoped teardown; artifact retirement is
its missing sibling.

**5. Cheap re-verification is a first-class outcome, not an
optimization.** The build beat currently rebuilds unconditionally even
when the content-addressed tag already exists and the runtime already
runs it. Content-addressing makes the skip decidable — same tag, live
stack, no rebuild — which turns the everyday inner loop from minutes
into seconds without weakening any guarantee. Combined with **2** and
**3**, the target is a suite whose cost tracks the work done rather
than the number of things waited for.

## Risks / unknowns

- The idling rule is easy to state and hard to lint precisely: a
  legitimate wait-for-arrival and an illegitimate wait-out-the-clock
  differ by intent, not by syntax. The lint may only be able to flag
  fixed sleeps and long deadlines, leaving the discrimination to
  review — acceptable if the rule is stated well enough to argue from.
- Derived populations are strictly better but not free: deriving from
  a registry couples the test to that registry's shape, and a badly
  chosen source can be as stipulated as a list. The rule needs to
  name *which* source is legitimate — the artifact under test, not a
  convenience constant beside it.
- Artifact retirement touches a rule whose whole point is that
  staleness is unrepresentable. Any policy must not create a path
  where a verification resolves a tag that was reclaimed mid-run;
  retirement is safe only against tags no live runtime references.
- Parallelizing a suite that shares one substrate surfaces hidden
  statefulness as failures. That is a benefit — the failing set is the
  isolation audit — but it front-loads work before any speedup lands,
  and consumers should be told that rather than surprised by it.

## What this is not

- Not authorization to build any of the above.
- Not a change to what proofs *are* or to the planner's ownership of
  the design corpus; the planner keeps the story link, the coverage
  question, and the adequacy judgment.
- Not a fourth suite. Every rule here lands inside an existing one,
  and that each extension fits an existing tooling model — plumbline's
  lint, the workspaces audit — is the evidence the division is right.
- Not a performance-tuning guide. The claim is that idling tests and
  unbounded artifacts are *discipline* failures with mechanical
  checks, not local inefficiencies to be optimized per project.
