---
decision: subagent-model-follows-job
---

# Every subagent dispatch names its model, and the model follows the job

## Choice

Every dispatch — the Agent tool and every `agent()` call in a
Workflow script — names one of `opus`, `sonnet`, or `haiku`. The
session model is never a subagent model: an omitted model inherits it
and a fork always does, so both are refused. Investigation,
relevance, and compliance-reading jobs ride `sonnet`; coding, fixing,
writing, and review jobs ride `opus`; mechanical single-shot lookups
ride `haiku`. The rule lives in the ok cheatsheet and in the shared
dispatch discipline every ceremony transcludes, and a consented
`PreToolUse` hook on `Agent` and `Workflow` enforces it where the
owner has wired it.

## Rationale

The session runs the most capable model. Inheriting it into every
reader multiplies cost without changing the reading, and a fork
inherits both the model and the whole context. Naming the model per
job puts the expensive tier where judgment is produced — fixes,
reviews, writing — and the cheap tier where text is read. The hook
exists because the omission is silent at dispatch time and its cost
lands unseen.

## Alternatives

- Inherit the session model — the harness's default; every reader as
  expensive as the session.
- Rule only, no hook — the omission stays silent.
- Per-skill model choice — the same rule stated once per skill,
  drifting one skill at a time.
