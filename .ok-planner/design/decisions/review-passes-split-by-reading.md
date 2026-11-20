---
decision: review-passes-split-by-reading
---

# Sprint certification's review passes split by what each must read

## Choice

The passes of sprint certification's review split by what each needs
to read: a completion pass per group of work items that share code,
walking each outcome and every failure path off it; a regression pass
per group of changed definitions that share users, judging each
behavior change against the implementation notes' rulings; and one
alignment pass over the whole sprint, which compares each delta with
its applied artifact, checks the change against the commitments the
sprint names, and alone reads the build's divergences. A completion
group holds up to five work items. No file budget splits a group or
merges two. How each pass reads and closes is a decision of its own
(see also: review-forks-own-pass-tasks).

## Rationale

A completion pass follows an outcome from its entry point, so its
group is the work items whose paths share code. A regression lands in
a user the diff does not show, so a regression pass reads each changed
definition's users, grouped by the users they share. A split costs
twice, since a definition split from its callers leaves the pass that
receives the callers paying to learn the definition. Only the
alignment pass reads the executor's account, so the code passes judge
blind to it and a divergence the executor did not record surfaces as
a report. A cap of five work items bounds one fork's reading on a
large sprint.

## Alternatives

- One code reviewer over the whole diff with the full brief — one
  agent's coverage is the set of files it read times what it
  noticed, and the trial showed it missing a class's siblings.
- A file budget on a pass — a budget of about ten files produced
  twelve one-file batches in one round, each paying the fixed reading
  to review one file.
- No cap on a completion group — a group of many work items that
  share code hands one fork a reading as large as the sprint's.
