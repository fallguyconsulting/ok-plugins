---
decision: cold-boxed-synthesis
---

# Cold, boxed assumption synthesis

## Choice

Assumptions are formed by a single synthesizer agent whose inputs are
mechanically restricted to user-visible material, enforced in four
layers: the input set is exported into a scratch directory outside the
project tree (never a checkout, which would carry the source); the
agent launches with the box as its world — no repository path, no
shell, no network, read-only file tools; a tool-layer rule denies any
access resolving outside the box; and a gate scans the agent's
transcript afterward, voiding the output on any out-of-box access. The
brief is a fixed template shipped with the ceremony; the orchestrator
interpolates file paths and nothing else.

## Rationale

Traps live in the gap between developer knowledge and user expectation,
so the agent forming user expectations must not hold developer
knowledge — and instruction-only restriction demonstrably fails: in the
rimsky case study an orchestrator's composed briefs twice contaminated
agents with a false claim absorbed from a release note. Mechanical
layers fail independently: the export removes the target, denial
refuses the attempt, and transcript verification makes a successful
peek produce nothing usable. One synthesizer rather than many keeps the
strongest assumption source — symmetry across the whole surface —
visible, since it requires holding the full picture at once.

## Alternatives

- Instruction-only coldness: cheaper, and the case study already
  measured it failing twice.
- Per-source sweep agents: parallel single-purpose generators — lose
  cross-surface symmetry, the highest-yield source.
- Warm synthesis: let the generator read source and tests — collapses
  the user-vantage premise entirely; expectations formed from the
  implementation are the developer's, not the user's.
