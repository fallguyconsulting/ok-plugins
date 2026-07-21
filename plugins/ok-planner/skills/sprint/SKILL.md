---
name: sprint
description: "ONLY activated by explicit /sprint slash command. Never auto-triggered by conversation content."
---

# Sprint Planning

The planning ceremony. An interactive session with the project owner that (1) drains the issue queue — design must be stable before new work is planned — and (2) produces a **sprint spec**: a change-order against the design corpus, expressed as final-form artifact deltas plus the work items that realize them, terminated by a fixed completion contract.

A sprint does not have to be about any particular feature. Its output is a list of work items that will create or amend concepts, stories, and decisions (and their implementation). The implementation itself happens elsewhere — an orchestrator or worker consumes the spec; this skill never hands off to a planning or execution pipeline.

Read `skills/_shared/artifact-definitions.md` before authoring anything. Every delta this skill drafts must already comply with the canonical artifact rules — the sign-off review below checks exactly that.

## Process

### 0. Affirm

Invoke `ok-planner:affirm` so the layout and the issue queue exist.

### 1. The gate — drain the issue queue

Fold `.ok-planner/issues.jsonl` by `id` (an `open` row with no later `resolve` row for the same id is open). **While any issue is open, no new work items may be drafted.** This is the entry gate, not a suggestion: resolving the queue is what unblocks the planning the owner came to do.

Walk the open issues with the owner one at a time (never as a wall): present the issue's summary, detail, and candidates; the owner picks a resolution shape (one of the candidates, a different shape, or an explicit "won't fix — retire the question"). For each resolution:

- Append a `resolve` row to `issues.jsonl` (see `{{ISSUE-QUEUE-FORMAT}}` in the shared definitions for the shape; timestamp via `date -u +%Y-%m-%dT%H:%M:%SZ`). Only this session writes `resolve` rows — resolution is the owner-calibration act.
- If the resolution mutates the corpus (most do), capture it as a corpus delta in the spec being drafted, and record the spec's name in the `resolve` row's `spec` field.

An empty queue on entry means the gate passes silently — go straight to planning.

### 2. Intake dialogue

Discuss what this sprint should take on. The owner brings goals; you bring the corpus (read `design/` freely — it is source of truth). Ask questions in prose; surface every tradeoff explicitly — never resolve one silently on the owner's behalf. When spec content implies a story- or decision-intent change, run the proof dialogue gate from `{{PROOF-PROTECTION-RULE}}`: preserve the intent / shift the intent / remove the artifact — the owner picks, never you.

### 3. Draft the sprint spec

Write to `.ok-planner/specs/YYYY-MM-DD-<slug>.md`:

```markdown
# Sprint: <title>

## Intent

<What this sprint is for, in a few sentences. List the issue ids this
sprint's resolutions close, if any.>

## Corpus deltas

<The substantive body. Each delta is a FINAL-FORM artifact body — a
complete concept / story / decision file content per the templates in
`skills/_shared/artifact-definitions.md` — under a heading naming the
operation and target:>

### New story: <slug>
### Amend concept: <slug>
### Retire decision: <slug>

<Applying a delta IS updating the corpus: the implementer copies the
final form into place (or deletes, for retirements). No summarized or
partial deltas — if the artifact changes, its full new body appears here.>

## Work items

<The implementation units that realize the deltas. Each names the
stories/decisions it makes true (by slug) and describes the outcome,
not the method. Ordering constraints only where real.>

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories and
   decisions: every proof present, passing, and non-vacuous.
3. `/audit` has been run last: mechanical findings fixed in-cycle;
   judgment findings filed to `.ok-planner/issues.jsonl` for the next
   sprint.
```

The completion contract section is fixed boilerplate — include it verbatim in every sprint spec. It is the implementation orchestrator's stop condition, not advice.

### 4. Sign-off review

Before the owner signs off, dispatch the compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` in **draft mode**, scoped to the spec's corpus deltas plus any live artifacts they amend. Fix mechanical findings in the draft directly. Walk judgment findings with the owner now — this is the first of the two review opportunities, and a judgment finding resolved here never becomes an issue row. Re-dispatch until clean.

Then present the spec to the owner for sign-off. The spec is not final until they approve.

### 5. Terminal

The approved spec at `.ok-planner/specs/YYYY-MM-DD-<slug>.md` is this skill's terminal artifact. Hand-off to implementation is outside ok-planner (an orchestrator picks the spec up; on completion it archives the spec to `.ok-planner/history/specs/`). Do not begin implementing, do not invoke further skills, do not write plans.

## What this skill does NOT do

- Does not implement work items or mutate code.
- Does not mutate `design/` directly — corpus changes ride the spec's deltas and are applied by the implementer.
- Does not close issues without the owner (every `resolve` is an owner decision made in-session).
- Does not defer its own open questions silently — a question the owner explicitly postpones is appended to `issues.jsonl` as an `open` row with `kind: "sprint"`.
