---
decision: ratchet-over-soft-start
---

# Adoption eases by one-way ratchet, never by softened checks

## Choice

A project whose violation backlog is too large to clear at once records a baseline count in a budget file inside the plugin's estate — migrated there from any earlier root-level location by the lifecycle verb — and CI fails any change that increases it while accepting any that holds or decreases it: a one-way ratchet. The checks themselves stay strict from day one; there is no soft start, and the config schema exposes no switch that disables a check.

## Rationale

The ratchet separates "we have debt" from "we make new debt": work continues immediately, regression is mechanically impossible, and the baseline only ever moves down. Softening the checks instead would re-open exactly the judgment seams the methodology exists to close, and grandfathered leniency tends to become permanent — which is also why no disabling switch ships at all.

## Alternatives

- Disable checks until the backlog is cleared — a soft start that in practice never ends.
- Per-check config flags that skip a check outright — the rejected soft start in switch form.
- Per-violation suppression annotations — scatters permanent exemptions through the code as more residue.
- Big-bang cleanup before adoption — stops feature work and loses to drift racing the cleanup.

## Proof

The ratchet check exits nonzero whenever the current violation count exceeds the recorded baseline; introducing one net-new violation on a baselined project turns CI red, and the check is what CI templates run on every change.
