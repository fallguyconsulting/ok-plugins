---
issue: verification-cost-work-has-no-measurement-discipline
kind: human
category: unspecified
artifacts:
  - story:corpus-proof
  - decision:prove-audit-audience-split
  - story:content-addressed-artifacts
status: verified
opened: 2026-07-28T10:31:38Z
---

# Making the tests faster isn't treated as performance work, and nothing measures them

The suite tells an agent how to write code, how to model a project, and how
to isolate a job — and says nothing about how to work on the verification
suite as an engineering artifact. The owner observed the resulting failure on
a consumer project: asked to cut a 15-minute proof suite to five, an agent
spent hours on three mechanism-first hypotheses — parallelization (made the
suite slower; the reported 9.4x was an artifact of 91 fast-failing tests),
sentinel signals for idle waits (~52 seconds), and pacing-constant tuning
(~44 seconds) — before running the profiler, which showed in one run that ten
tests doing real infrastructure work account for ~64% of the runtime and that
none of the three changes could ever have mattered. The same agent profiles
readily when product code is slow; the framing "make the tests faster" reads
as test work, and the measure-first reflex never fires. The skill exists; the
trigger is missing.

The absence has two halves that compound. First, no discipline: nothing in
the corpus says that changing a verification suite's cost is performance
engineering and follows its rules (profile before change, justify from the
profile, re-measure after). Second, no record: no verification run leaves a
durable timing artifact — verified for this repo's own harnesses too, none of
the three families' test runners emits per-test timings — so every cost
question requires another full run, which prices the right behavior
(measuring) above guessing. The corpus is genuinely silent on both:
`story:corpus-proof` commits to executing proofs and reporting four verdicts
(pass, missing, failing, unrunnable) with no timing field, and
`decision:prove-audit-audience-split` fixes who consumes findings, not what
runs cost. The nearest existing text is plumbline's style guide — "check
speed is a placement criterion... prefer placements covered by fast, isolated
suites" — an authoring-time heuristic about where a check lives, in advisory
docs prose no artifact or audit verifies, not suite-scope cost discipline.

The boundary question the ruling settles: is verification-suite cost the
suite's territory at all, and if so, which artifact owns the discipline and
which owns the record.

## Options

- **Extend `story:corpus-proof`'s acceptance** so every proof run's report
  carries per-proof timings and leaves them as a durable artifact the next
  session reads without re-running — cost: touches the prove pipeline and all
  three families' harnesses. (Option the filing missed; the story already
  owns "the proof run" and its structured report.)
- **Record a measure-first decision** — changing verification cost is
  performance engineering: profile first, change what the profile names,
  re-measure — cost: a discipline claim whose enforcement point is prompt
  text rather than a mechanical check.
- **Home either piece with plumbline** (widen its check-speed criterion) —
  cost: scope mismatch; plumbline's charter is comment/citation lint, not
  agent working discipline, and the style guide is unverified prose.
- **Home it with workspaces** (beside the build-and-verify lifecycle) —
  cost: comparable scope stretch; the workspace concept owns job isolation,
  not the proof suite's internals.
- **Rule it out of scope** — verification cost is each consumer project's own
  concern — cost: the documented failure (hours of thrash after an explicit
  owner request) stays unaddressed by design.

## Ruling

> Recommended ruling (/verify-issues): do both halves in the planner family,
> where verification already lives — (1) extend `story:corpus-proof`'s
> acceptance so every proof run reports per-proof timings and leaves them as
> a durable artifact readable without a re-run, and (2) record a decision
> committing verification-cost work to the measure-first discipline (a
> profile before any change, the profile as the justification for what
> changes, a re-measure after), grounded on the timing artifact the story
> then guarantees exists.
>
> Rationale: the two halves fail together — a measure-first rule is only
> cheap when the measurement already exists, and a timing artifact nobody is
> told to consult changes nothing — so a ruling that takes only one leaves
> the observed failure standing. The planner is the honest home: it owns the
> prove verb, its report, and the audit machinery; plumbline and workspaces
> placements both stretch a family's charter to reach the run. What makes it
> close: the decision's enforcement is prompt-level, not mechanical — if that
> weight worries the owner, the timing-artifact half alone is still worth
> carrying, and the discipline half can wait for evidence it's needed here
> and not just on the consumer project that surfaced it.

<!-- Owner: this is a recommendation, not your decision. Leave it as-is to
accept — the next /plan-sprint carries it, naming the recommended batch at
sign-off. Edit the text to redirect, empty the section to discuss live, or
delete this note to adopt the ruling as your own. -->
