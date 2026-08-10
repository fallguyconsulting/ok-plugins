# The audit run's goal file

Two readers, two sections. The **brief** is for the agent driving an
audit run under the native `goal` mechanism; the **goal rule** is for
whatever checker verifies the goal condition. The owner sets the goal
by pasting the one line the audit's opening walk hands them:

```
/goal the audit run described in .ok-planner/ceremony/audit-goal.md is complete — every term of its goal rule verifies against this repository
```

## The brief

**You are the orchestrator of an audit run.** You resolve scope,
drive the stages, and dispatch the agents; you determine nothing
yourself, and you file nothing of your own motion — the judge and the
distillation are the run's only filing paths. Everything you would
otherwise stop to tell the owner goes into the run report; nothing
pauses to say it.

**Guard clause.** This file governs the run only from the settled
surface walk onward. If the public-surface partition is not settled —
the reconciler does not exit 0, guidance changes are unratified,
member drift or unclaimed elements are unwalked — the goal was set
too early: say exactly that and stop. Never settle a partition
question alone; the walk is the owner's.

The course is written where it always was — follow it there, never
from a restatement:

- The vendored audit ceremony at `.claude/skills/audit/SKILL.md` —
  the spine, from the Enumerate stage on: the two Determine tracks
  through the worker pool, the terminal judge, the distillation,
  Check, Verify, the run report, the two close-out commits and the
  stamp.
- Each estate's ceremony contribution at
  `<estate>/ceremony/audit.md` — the instruments, prompts, record
  shapes, and paths for that estate.

End by composing the owner's wrap-up from the run report — the run
was driven precisely so that its ending is written down before its
context is long.

## The goal rule

The goal is met when all of the following verify against the
repository as it stands:

1. The audit corpora are complete for every estate in scope: one
   audit file per live artifact, per that estate's collections.
2. This run's assumption records exist, regenerated whole, each
   carrying a disposition.
3. The vendored `audit-check` exits clean.
4. The run report exists at its archive path
   (`.ok-planner/history/audits/<date>-<sha>-report.md`).
5. Both close-out commits have landed, and the stamps are present —
   every audit's `commit:`, the ruling's anchor, the report's name
   and body all naming the close-out commit.

**Met despite** — none of the following counts against the goal:
issues filed by the judge or the distillation; `unsupported` or
`unclear` determinations standing; trap dispositions recorded;
findings unfixed and issues unclosed. Fixing is a sprint's job, never
this run's, and a run that found real gaps and filed them is a
successful run.

**Not met**: `audit-check` failing; any stamp missing; the report
absent; any live artifact without an audit file.

**Too early**: an unsettled surface partition. That is not a failure
of the run — it means the goal was set before the walk finished; the
brief's guard clause says what to do.

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
