---
decision: work-items-change-the-product
---

# Every sprint work item changes the product

## Choice

Every sprint work item changes the product: its code, its
configuration, its documents, or its design corpus. A work item that
consists of using what the sprint builds is reshaped into the feature,
script, or seed asset that lets a user reach the outcome. The code
planner sends back a work item that changes no file. Execution and
sprint certification need no owner action and file no task for the
owner to perform.

## Rationale

An unsupervised executor cannot build an act of using the product, and
certification judges the tree and a fresh stack of its own, so it
cannot see what such an act leaves behind. The feature, script, or
seed asset that lets a user reach the outcome is a change both can
judge. The code planner already reads every work item against the code
it touches and already sends back an item it cannot build, so an item
that changes no file fails a check that exists, before approval, with
no new scope at sign-off. The intake is a holding area, not a work
tracker, so a task left for the owner at the close has no place to
wait.

## Alternatives

- The sign-off review checks every work item against the rule — it catches the item one step earlier but widens a review built for corpus deltas.
- State the rule with no check — no check fails on violation.
- Certification's owner list and triage also refuse an issue whose resolution is an act the owner performs on a running product — a real certification gap phrased as an owner act could be retired unread.
