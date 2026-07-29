---
issue: cap-decision-reserved-to-owner
kind: human
category: unspecified
artifacts:
  - story:certify-completion
  - decision:prove-audit-audience-split
  - concept:completion-contract
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T08:58:43Z
---

# The cap's two-step choice belongs to the owner alone — an unattended run must wait, not escalate

## Problem

The ratified cap design says an unattended certification run, on
reaching the fix loop's cycle cap, escalates the remainders as intake
issues by default ("with an unattended run escalating by default" in
story:certify-completion's acceptance; "taken on the owner's word on
an interactive run and by default on an unattended one" in
decision:prove-audit-audience-split's Choice; implemented in the
certification core's exit rule). The owner rejects the default: the
net effect of auto-escalation is that the in-flight sprint wraps up
without them, and resuming the escalated remainders then requires
planning and starting a fresh sprint — costly — when they would
rather return, direct another cycle or the wrap-up themselves, and
finish out the sprint in flight. The choice between the cap's two
steps is a decision the agent absolutely must not make on the owner's
behalf, whether the wait is a minute or a day.

A waiting cap also collides with the goal machinery: the completion
contract's goal rule recognizes exactly two met-states (archived with
a closed stamp, or all terms verifying), so a run parked at the cap
awaiting the owner's word satisfies neither, and a goal-keyed
unattended run has no legal way to stop and wait.

## Candidates

- Amend story:certify-completion's acceptance (and the matching
  Choice clause in decision:prove-audit-audience-split, plus the
  certification core's exit rule and both gates): at the cap the run
  always stops and puts the two steps to the owner — another cycle,
  or escalate-and-verify — waiting for their word however long that
  takes; the escalation path itself is unchanged once chosen.
- Amend concept:completion-contract's goal rule (and the sprint
  boilerplate) to add a third recognized state: parked at the cap
  awaiting the owner's direction — a legal stopping point for a
  goal-keyed run, not a failure to converge and not grounds to
  fabricate completion.

## Ruling

Owner decision, 2026-07-29, transcribed from the live session:
"unattended runs escalate by default" is out. Hitting the cap stops
the cycle and gives the owner the option to either run more cycles
or to wrap up — in which case the issues get filed and then
verified, with the sprint proceeding from there. The agent waits for
the owner's instruction; they will eventually return, and they would
rather finish the in-flight sprint than be forced to start a fresh
one. The goal signal must be amended to include that waiting
scenario. Stated strongly: the agent absolutely must not make the
cap's choice for the owner, whether the wait is a minute or a day.
