---
decision: subagent-model-follows-job
---

# Every subagent dispatch names its model, and the model follows the job

## Choice

Every dispatch — the Agent tool and every `agent()` call in a
Workflow script — names one of `opus`, `sonnet`, or `haiku`. The
session model is never a subagent model: an omitted model inherits it
and is refused, and the session never forks. A subagent whose vendored agent
profile pins one of the three may fork itself, and
spawns nothing else: a fork inherits the profile's pinned model and
the caller's whole context, so a group of items shares one reading,
and each fork claims a task of its own that its root filed.
Every analytical job rides `opus`: investigation, relevance,
enumeration, discovery, classification, compliance reading, the
surface extractor, and the document Method's leaf agents. Review,
coding, fixing, writing, and architectural-ruling jobs ride `opus`
too: sprint certification's review root with its pass tasks,
`/converge`'s fixers and verifiers, every reviewer a skill
dispatches, and a sprint's build tasks. Mechanical single-shot
lookups ride `haiku`. No suite instruction sends a job to `sonnet`,
and the suite vendors no `sonnet` profile. The rule lives in the
suite's rules files and in the shared dispatch discipline. A consented `PreToolUse` hook on `Agent` and `Workflow`
enforces, where the owner has wired it, that a dispatch names one of
the three models; the instructions decide which one.

## Rationale

The session runs the most capable model. Inheriting it into every
reader multiplies cost without changing the reading, and a fork from
the session inherits both the model and the session's whole context.
Naming the model per job puts `opus` wherever a result is built on
and `haiku` on lookups whose answer is mechanical. An investigation or
enumeration result is what a planning session builds on: a missed
artifact or a wrong reading becomes a corpus delta or a work item
that contradicts the code, and nothing later re-reads the source to
catch it. So the cheaper read costs more than it saves. Twice in one
planning session the owner stopped a `sonnet` investigation and had
it rerun on `opus`. Review rides `opus` on what it finds: two
reviewers with one brief over one staged change of 106 files returned
seven defects on `sonnet` and fourteen on `opus`, and the `sonnet`
reviewer cleared a lint check that the `opus` reviewer showed fails
open under a symlinked path and ignores a two-segment directory
pattern. The `opus` round costs more than half again per task, and a
defect a review clears is the round that finds it later. A fork from a
pinned profile is allowed because it is the cheapest way for several
passes to share one reading: the profile's model is fixed, and the
context the fork inherits is a cached prefix.
The hook exists because the omission is silent at dispatch time and
its cost lands unseen. The hook still allows `sonnet` because it
checks only that a model is named; which model a job gets is the
instructions' choice, and a hook that refused `sonnet` would decide
it a second time.

## Alternatives

- Inherit the session model — the harness's default; every reader as
  expensive as the session.
- Rule only, no hook — the omission stays silent.
- Per-skill model choice — the same rule stated once per skill,
  drifting one skill at a time.
- Refuse every fork — a group of passes over one change then reads
  the change once per pass, and the reading is the cost.
- Investigation, relevance, and enumeration on `sonnet` — under half
  the cost per task, and a miss becomes a delta or a work item that
  nothing re-reads.
- Review on `sonnet` — under half the cost per review task, and the
  measured comparison shows it clearing defects `opus` finds.
- A project setting for the analytical model, defaulting to `opus` —
  a project could choose `sonnet`'s cost without editing suite-owned
  files, at the price of a second place the model choice is made.
- The hook refuses `sonnet` — the hook would decide what the
  instructions already decide.
