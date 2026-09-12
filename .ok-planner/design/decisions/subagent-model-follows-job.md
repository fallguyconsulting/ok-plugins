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
the caller's whole context, so a group of items shares one reading,
and each fork claims a task of its own that its root filed.
Investigation, relevance, and enumeration jobs ride `sonnet`: an
issue investigator, a relevance pass, a discoverer, the surface
extractor. Review, coding, fixing, writing, and architectural-ruling
jobs ride `opus`: the certification gate's review root with its pass
tasks, every reviewer a skill dispatches, the gate's fixer, and its
architect. Mechanical single-shot lookups ride `haiku`. The rule lives in the ok cheatsheet and in the
shared dispatch discipline every ceremony transcludes, and a
consented `PreToolUse` hook on `Agent` and `Workflow` enforces it
where the owner has wired it.

## Rationale

The session runs the most capable model. Inheriting it into every
reader multiplies cost without changing the reading, and a fork from
the session inherits both the model and the session's whole context.
Naming the model per job puts the expensive tier where a fix, a
ruling, or a finding is produced and the cheap tier where text is
gathered. Review rides `opus` on what it finds: two reviewers with
one brief over one staged change of 106 files returned seven
findings on `sonnet` and fourteen on `opus`, and the `sonnet`
reviewer cleared a lint check that the `opus` reviewer showed fails
open under a symlinked path and ignores a two-segment directory
pattern. The `opus` round costs more than half again per task, and a
defect a review clears is the round that finds it later. A fork from a
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
- Review on `sonnet` — under half the cost per review task, and the
  measured comparison shows it clearing defects `opus` finds.
