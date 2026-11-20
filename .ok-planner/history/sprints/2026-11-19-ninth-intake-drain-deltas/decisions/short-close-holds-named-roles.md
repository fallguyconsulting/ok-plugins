---
decision: short-close-holds-named-roles
---

# A short close holds its waiters for the roles a run names

## Choice

A run names the roles whose short close holds the tasks that wait on
it. Where a task of a named role closes `partial` or `blocked`, the
task tracker counts each wait on it as open while the task stands
closed short with no refile; a refile's waiters then wait on the
refile, and a task issued again in place frees them when it closes
`done`. Sprint execution
names its build role (see also: build-task-per-stage). Every other run
names none, and there a task that closes short frees its waiters as a
`done` close does. The tracker acts only on the outcome the closing
agent recorded, by the rule the run declared (see also: task-tracker).

## Rationale

A build stage builds on the stages it waits on, so it must not start
on unfinished work. Under a rule that frees waiters on any close, one
sprint run saw three waiting stages claimed within 11 seconds of a
`partial` close, before the session could refile the short stage.
`/converge`'s fix chains and confirm-drive relays want a short close
to free their waiters: a fixer that closes `partial` because its
change reaches files outside its own passes its defects to the next
round with no refile, and a blocked confirm
driver is never refiled, so a rule that frees waiters only on `done`
would stall both. Naming the roles per run gives each run the rule
its work needs, and the tracker stays mechanical: it applies a rule
the run declared. The cost: one more run setting, and a sprint run
holds a short stage's waiters until the session refiles it or issues
it again.

## Alternatives

- The tracker meets a wait only on a `done` close or on a refile, with
  an explicit release for `/converge`'s fix chains and drive relays —
  rewrites both `/converge` loops to fix a harm only sprint execution
  shows.
- The tracker frees waiters on any close, and sprint execution refiles
  a short build stage or holds the drain before the next claim — the
  drain loop must then judge an outcome, which its own rule forbids.
