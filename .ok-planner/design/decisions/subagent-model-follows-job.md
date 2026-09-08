---
decision: subagent-model-follows-job
---

# Every subagent dispatch names its model, and the model follows the job

## Choice

Every dispatch — the Agent tool and every `agent()` call in a
Workflow script — names one of `opus`, `sonnet`, or `haiku`. The
session model is never a subagent model: an omitted model inherits it
and is refused, and the session never forks. A subagent whose profile
under `.claude/agents/` pins one of the three may fork itself, and
spawns nothing else: a fork inherits the profile's pinned model and
the caller's whole context, so a group of items shares one reading.
Investigation, relevance, compliance-reading, enumeration, and
code-review jobs ride `sonnet`, the certification gate's review root
with its passes, its alignment fork, and its suite runner among them;
coding, fixing, writing, and architectural-ruling jobs ride `opus`,
the gate's fixer and its architect among them; mechanical single-shot
lookups ride `haiku`. The rule lives in the ok cheatsheet and in the
shared dispatch discipline every ceremony transcludes, and a
consented `PreToolUse` hook on `Agent` and `Workflow` enforces it
where the owner has wired it.

## Rationale

The session runs the most capable model. Inheriting it into every
reader multiplies cost without changing the reading, and a fork from
the session inherits both the model and the session's whole context.
Naming the model per job puts the expensive tier where a fix or a
ruling is produced and the cheap tier where text is read and judged.
Code review rides `sonnet` on cost: one measured gate run spent most
of its tokens on review tasks whose cost barely depended on what they
reviewed, and the `opus` round cost more than half again per task.
Whether `sonnet` finds what `opus` found on a fresh change is
unmeasured; `decision:team-execution-cold-gate` names the condition
under which the `correctness` pass reverts to `opus`. A fork from a
pinned profile is allowed because it is the cheapest way for several
passes to share one reading: the profile's model is fixed, and the
context the fork inherits is a cached prefix.
The hook exists because the omission is silent at dispatch time and
its cost lands unseen.

## Alternatives

- Inherit the session model — the harness's default; every reader as
  expensive as the session.
- Rule only, no hook — the omission stays silent.
- Per-skill model choice — the same rule stated once per skill,
  drifting one skill at a time.
- Refuse every fork — a group of passes over one change then reads
  the change once per pass, and the reading is the cost.
- Review on `opus` — measured at more than half again per review
  task, on a run whose review cost was mostly fixed overhead.
