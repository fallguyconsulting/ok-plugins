---
issue: orchestrator-not-fixer-inside-loop
kind: human
category: inconsistent
artifacts:
  - story:certify-completion
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T01:03:06Z
---

# Nothing tells the certification orchestrator it must not do fixer work itself

## Problem

The review-fix loop's no-discretion sentence enumerates only
list-handling verbs — "it does not summarize, filter, reorder, or
defer findings; it moves verbatim lists… and it counts cycles" —
and never says the orchestrator doesn't edit. The cap rule's "the
certification is finished out manually" supports reading "manually"
as "the orchestrator does it itself"; the intended reading — the
owner directs the remainder — is not the plainer one.

Observed: an orchestrating session promoted itself to fixer for two
rounds and both of its own fixes went green while being wrong,
whereas the dispatched fixer cycles' fixes held. Its own post-mortem:
the orchestrator carries the whole history including the pull toward
flipping a determination — precisely the bias author separation
exists to keep out — and, having built the code, is the worst-placed
party to verify a fix against it.

The suite states author separation explicitly where it is cheaper
(the auditor "is always a fresh dispatch, never the session that
implemented the work") and omits it where it is most needed: in the
standard inline case the certification orchestrator IS the session
that implemented the sprint. Lineage pulls the wrong way too — the
retired execute-plan told its orchestrator the opposite ("a concrete,
fixable defect… IS your job to fix directly and resume").

## Candidates

- Add one sentence to the loop preamble: the orchestrator never edits
  code or corpus inside the loop; every fix, however small, is a
  dispatch.
- Rewrite "finished out manually" as "handed to the owner to direct."

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29).
The loop preamble now states it outright: the orchestrator never
edits code or corpus inside the loop — every fix, however small, is
a dispatch — with the why recorded in place (the orchestrator is
often the implementing session, the worst-placed party to fix or
verify its own work). The second candidate is moot: the
cap-remainders ruling removed the "finished out manually" terminal
entirely (the cap now resolves through another cycle or escalation
to the intake). Stays open for the next sprint to ratify; ships with
the next release/re-vendor.
