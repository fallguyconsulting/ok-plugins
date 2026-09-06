---
issue: reviewer-out-of-footprint-defect-has-no-route-to-the-intake
kind: human
category: unclear
artifacts: []
status: answered
opened: 2026-09-05T01:46:00Z
---

# A defect the gate's reviewer finds outside the change has no route to the intake

## Problem

The certification gate confines findings to the change's footprint. `plugins/ok/families/ok-planner/skills/_shared/certification-core.md`'s code-review brief says a pre-existing defect is in scope only where the change touches or depends on it, and the planner's ceremony contribution says a finding outside the footprint "is not this gate's finding; a human files it to the intake where it matters". Nothing says which human, when, or how the observation reaches them. The reviewer's only outlets are the `findings` pool, which the loop treats as work to fix, and the `divergences` pool, which the presentation renders as calls for after-the-fact veto.

Observed on 2026-09-05 in `linescout/platform` certifying `2026-09-04-remove-line-topology` under v20.0.0: the round-5 verify reviewer found that `replace_aggregation` deletes and recreates an aggregation without deleting its consumer group, the same hazard the round's fix had just closed for bindings, and a contradiction of a live decision. It reported the defect in its task result as deliberately not filed, being outside the footprint. The orchestrating session recorded it as a `divergences` call and mentioned it in the presentation under Issues promoted as "yours to file". The owner replied that an issue hiding in the divergences is a process failure, and the session filed it to the intake only then.

## Candidates

- Give the reviewer a third outlet: file an out-of-footprint defect into the `divergences` pool with `--field kind=observation`, and have the gate's Present step write each observation to the intake as a raw issue before the planner contribution's Verify step runs `verify-issues`, so every observation is ruling-ready in the same run. The divergences list stays for calls.
- Have the reviewer file it as an ordinary finding with an advisory `out-of-footprint` class, and have triage settle such a finding straight to `promoted` with a raw issue file, dispatching no fixer. One pool, one ledger row, and the presentation's Issues promoted section already lists it.
- Keep the rule as written and add the missing sentence: the orchestrating session files each reviewer-reported out-of-footprint defect to the intake at the gate's Routing step, and the presentation lists it under Issues promoted as filed by the gate.

## Ruling

Answered on 2026-09-05: the reviewer files a defect the change did not introduce as an ordinary finding marked pre-existing, and the loop's triage checks the mark against the change's hunks and files it to the intake, dispatching no fixer; the divergences pool never holds a defect. See decision team-execution-cold-gate, Choice, and the certification core's review-fix loop, step 1.
