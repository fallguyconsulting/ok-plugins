---
decision: failed-speed-rewrite-returns-to-its-last-passing-version
---

# A failed speed rewrite returns to its last passing version

## Choice

A speed send-back settles when the verifier accepts the rewrite. A
speed rewrite that fails returns to its last passing version, and its
send-back stays open for the next sprint to take up (see also:
speed-read-at-three-points).

## Rationale

A failed rewrite that returns to its last passing version leaves the
test as fast as it was and passing, so speed work never costs a sprint
an extra whole-suite round. A speed walk that reruns the whole suite
after every batch until a batch comes back clean pays one round per
batch. The open send-back carries the waste the reader found to the
next sprint's speed read.

## Alternatives

- A speed walk at the end of sprint certification, batch by batch
  until a batch comes back clean: each batch's rewrites cost another
  whole-suite round.
