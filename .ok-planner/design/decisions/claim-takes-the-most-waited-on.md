---
decision: claim-takes-the-most-waited-on
---

# A claim takes the issued task the most tasks wait on

## Choice

An agent's claim names no task, save a fork's, which claims the pass
task its prompt names (see also: review-forks-own-pass-tasks). Every
other claim takes the issued task of its profile that the most tasks
wait on, directly or through a chain of
tasks each building on the last, and the oldest among those that tie.
The task tracker decides the order at the claim.

## Rationale

A claim of the oldest task starved the run's bottleneck: on one
project, the test support tasks some 360 test tasks waited on sat
behind older tasks until the session claimed them by id. The task
the most tasks wait on frees the most work when it closes. The
tracker decides the order at the claim, so every agent of a profile
still starts from one identical message (see also:
no-execution-engine).

## Alternatives

- Claim the oldest issued task — fair by age, and a task many others
  wait on waits behind every older one.
- Name the task in each agent's message — the session sets the order,
  and every agent rewrites its profile's cached prefix.
