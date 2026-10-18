---
decision: documentation-style-read-once
---

# Each changed documentation file gets one cold style read

## Choice

After the writers finish, an agent that did not write a file reads it
once, cold, and revises it against the docspec's shape, its worked
example, and the writing standard. It first reads what changed in the
file since the docspec's stamp and decides whether a review is needed,
and it records each skip with its reason. Nobody sends a style finding
back. The worked example is a document of the docspec that the owner
approved in planning, or a draft entry the owner approved for a
docspec with no document yet.

## Rationale

A writer rereading its own prose reads past what it meant, so the read
is cold. Prose review has no fixed end, so one pass with no send-backs
bounds it. The shape and an approved example give that one pass
something fixed to check, where the writing standard alone governs
sentences and not their order. Letting the agent decide from the diff
spends no review on a file whose change is a few claims rewritten in
place.

## Alternatives

- Review style until no finding remains — the prose converges, if
  ever, at the cost of a loop with no bound.
- Skip a file's style read by a digest of its text — mechanical, and
  every fact fixed in a later run invalidates the digest.
- No style read; the writer follows the standard — one agent fewer,
  and structure wanders with each writer.
