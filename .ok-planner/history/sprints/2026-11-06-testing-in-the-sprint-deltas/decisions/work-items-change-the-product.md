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
owner to perform. The rule binds every element of a sprint: each work
item, each call in the implementation notes, each line the notes have
the build write into the review facts, and the drive of each story.
The code planner checks each element it writes against the rule, and
sends back a work item that needs a person during execution or
certification. The notes review checks the notes and every story the
sprint adds or amends against the rule. A story the drive cannot
complete with only what the local stack gives is a notes review
finding. Where a story's benefit passes through a party outside the
product, such as a third party's sign-in or input only a real user
gives, the sprint builds a local stand-in for that party, which the
project's stack runs, the review facts name, and the drive and the
tests use. A stand-in replaces only a party outside the product, never
the product's own code. Planning never leaves work out of a sprint
because a step in it needs a person.

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

A step that needs a person can hide outside the work items, in a call
the notes make or in a line of the review facts. A check that reads
only work items lets such a step through. The run then stops when it
reaches the step. Everything a sprint builds lies inside the product,
so an agent can reach it. A party outside the product is the one thing
an agent cannot reach. A local stand-in gives the drive and the tests a
party they can reach, and leaves the product's own code unchanged.

## Alternatives

- The sign-off review checks every work item against the rule — it catches the item one step earlier but widens a review built for corpus deltas.
- State the rule with no check — no check fails on violation.
- Certification's owner list and triage also refuse an issue whose resolution is an act the owner performs on a running product — a real certification gap phrased as an owner act could be retired unread.
- The notes review flags each step that needs a person, and the owner rescopes the sprint at planning to what runs with no person — each story that passes through an outside party leaves the sprint until a stand-in exists.
- A story that needs a third party's sign-in is declared undrivable in the review facts, and certification sorts it as a limit of the environment — the sprint closes with that story never driven.
