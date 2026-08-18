# The audit run's goal file

Two readers, two sections. The **brief** is for the agent driving the
autonomous portion of an audit run under the native `goal` mechanism;
the **goal rule** is for whatever checker verifies the goal condition.
The owner sets the goal with the line below once the interactive
intent stage lands. In a run `/document` invoked, the goal line is
`/document`'s own, handed over after the documentation walk.

```
/goal the audit run described in .ok-planner/ceremony/audit-goal.md is complete — every term of its goal rule verifies against this repository
```

## The brief

**You are the orchestrator of the autonomous portion of an audit
run.** The interactive intent stage has already landed
`.ok-planner/surface/surface.md` in conversation with the owner; from
here you resolve scope, drive the stages, and dispatch the agents.
You determine nothing yourself, and you file nothing of your own
motion — the judge and the surface extractor's intake issues for residual
ambiguity are the run's only filing paths.
Everything you would otherwise stop to tell the owner goes into the
run report; nothing pauses to say it. The interactive stage was an à
la carte run's one owner walk — a composed run's documentation walk,
right after the extractor, was its second and last — and the
autonomous portion never opens another.

The course is written where it always was — follow it there, never
from a restatement:

- The vendored audit ceremony at `.claude/skills/audit/SKILL.md` —
  the spine: the interactive intent stage (already run), the
  autonomous extractor dispatch (and, in a composed run, the
  documentation walk right after it), the two Determine tracks through
  the worker pool, the terminal judge, Verify, the
  run report, the two close-out commits and the stamp.
- Each estate's ceremony contribution at
  `<estate>/ceremony/audit.md` — the instruments, prompts, record
  shapes, and paths for that estate.

End by composing the owner's wrap-up from the run report, in the
shape the contribution's Present section defines. **That wrap-up is
the last thing you do.** It closes on the receipt: the run is complete
and committed, the two close-out shas, the report's archive path. Then
stop. Offer to archive or commit nothing, propose no follow-on work,
and ask nothing about what comes next. The gaps the run found are
issues in the intake, for the owner to rule on and a planning ceremony
to close.

## The goal rule

The goal is met when all of the following verify against the
repository as it stands:

1. The surface intent exists at `.ok-planner/surface/surface.md` —
   the file the interactive stage landed (or updated) before this
   goal was set.
2. The audit corpora are complete for every estate in scope: one
   audit file per live artifact, per that estate's collections.
3. This run's assumption records exist, regenerated whole, each
   carrying a disposition.
4. The surface extraction file exists at
   `.ok-planner/audits/surface/extraction.json`, produced by this
   run's extractor.
5. The run report exists at its archive path
   (`.ok-planner/history/audits/<date>-<sha>-report.md`).
6. Both close-out commits have landed, and the stamps are present —
   every audit's `commit:`, the extraction's `commit`, the report's
   name and body all naming the close-out commit.

Verify each condition by listing files and reading frontmatter. No
term of the goal depends on a tool's exit.

**Met despite** — none of the following counts against the goal:
issues filed by the judge or the surface extractor (for residual
ambiguity); `unsupported` implementation
verdicts standing; trap dispositions recorded; extraction entries
defaulted internal because the intent did not settle them; findings
unfixed and issues unclosed. Fixing is a sprint's job, never this
run's.

**Not met**: the surface intent missing; any stamp missing; the
report absent; the extraction absent; any live artifact without an
audit file.

<!-- Materialized by ok-planner v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
