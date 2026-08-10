---
decision: cold-boxed-synthesis
---

# Cold, boxed assumption synthesis

## Choice

Assumptions are formed inside the audit run, after the story
determinations land: a single synthesizer agent whose inputs are
mechanically restricted to user-visible material — the story catalog
with the run's support determinations, the published concept layer,
the rendered public surface from the ruling, the prior release's
published corpus — enforced in four layers: the input set is exported
into a scratch directory outside the project tree (never a checkout,
which would carry the source); the agent launches with the box as its
world — no repository path, no shell, no network, read-only file
tools; a tool-layer rule denies any access resolving outside the box;
and a gate scans the agent's transcript afterward, voiding the output
on any out-of-box access. The brief is a fixed template shipped with
the ceremony; the orchestrator interpolates file paths and nothing
else. The synthesized assumptions are then verified by the same
user-vantage instrument as stories, in the same run.

## Rationale

Traps live in the gap between developer knowledge and user expectation,
so the agent forming user expectations must not hold developer
knowledge — and instruction-only restriction is not trusted to hold
it out: the orchestrator composing the briefs has read the source,
and one absorbed claim passing unnoticed is all contamination takes.
Mechanical layers fail independently: the export removes the target, denial
refuses the attempt, and transcript verification makes a successful
peek produce nothing usable. One synthesizer rather than many keeps the
strongest assumption source — symmetry across the whole surface —
visible, since it requires holding the full picture at once. The audit
hosts the synthesis because the instrument that verifies assumptions
is the audit's own story instrument: forming them where they are
measured keeps one measurement machinery in one ceremony, puts traps
on the audit's cadence instead of a release's, and costs the box
nothing — every export-set input exists in the estate at audit time.

## Alternatives

- Synthesis in the documentation run: the prior placement — the same
  measurement machinery then lives in two ceremonies, and an
  assumption waits for a release to be checked.
- Instruction-only coldness: cheaper, but rests the vantage line on
  nothing but compliance.
- Per-source sweep agents: parallel single-purpose generators — lose
  cross-surface symmetry, the highest-yield source.
- Warm synthesis: let the generator read source and tests — collapses
  the user-vantage premise entirely; expectations formed from the
  implementation are the developer's, not the user's.
