---
decision: team-execution-cold-gate
---

# A builder and a standing reviewer execute a sprint; certification stays cold

## Choice

The sprint's execution shape names a team. The session orchestrates
it and never joins it as a worker: it relays messages between the
workers and reads their task notifications. It opens the completion
report with the staged list before the build and marks the closing
stages after the team retires; during the build it edits nothing. The
session dispatches the **builder** once and feeds it one stage per
message. The builder writes the code, tests what it built, keeps the
completion report, and fixes the reviewer's findings in its own
context. The session dispatches the **standing reviewer** once and
feeds it each landed stage's paths. The reviewer reads the increment
under the certification gate's own code-review brief plus the
read-only per-stage producers each family's ceremony contribution
names. It keeps a ledger of open findings and reports back through
the session. The session retires a worker only at a stage boundary,
once the worker's measured context passes a threshold held below the
compaction window. A replacement builder reads the sprint and the
report; a replacement reviewer receives the open ledger.

The builder never files an issue. It makes every determined call and
records it in the report as a divergence. Where it meets a genuine
fork — the sprint and corpus do not determine the fix and reasonable
owners diverge — it records the fork with its options, builds the
reading it judges most plausible, and continues. The certification
loop's fixer role folds into the builder during the build; the
architect exists only at the terminal gate.

Code complete means the built work works and the reviewer's ledger is
empty. `/certify-work` runs immediately after and stays cold: it runs
the suites, the lint, and the whole-change checks, and one code
review of the whole diff by a reviewer holding no history. Its
sprint-alignment judge reads the report. The judge hands each
divergence to the veto test and each claimed fork to the architect.
Its cold reviewer stays blind to the report, so an unrecorded
divergence surfaces as a fresh finding.

## Rationale

In the prior shape the session built alone. The gate then ran every
producer cold over the whole diff and dispatched a fresh fixer,
architect, and reviewer per cycle, up to three cycles. Every cycle
re-read the same material from zero. Reviewing each increment as it
lands puts the review where the builder still holds why it wrote
what it wrote. A fix then costs no re-reading, and the terminal gate
usually converges in one cycle.

The gate stays cold because a reviewer that has watched the code grow
can drift toward the builder's framing. One fresh pass over the whole
diff is the check on that, and it is the pass that discharges the
completion contract.

Retirement below the compaction window is the only hand-off the
harness lets the suite control. Subagents compact under the same
threshold as the session. No parent can steer the summary or force a
hand-off mid-run. A retirement at a stage boundary with the report on
disk replaces a summary nobody wrote with a record the builder kept.
Subagents can message only agents they spawned, so the session is
the bus. A session that only relays keeps its own context small
across a long sprint.

## Alternatives

- The session implements alone and then certifies — the prior shape;
  every fix cycle re-reads the whole change cold.
- A dedicated test reviewer beside the code reviewer — forks the
  review dialect certification uses; a second instance of the same
  brief scoped to test files is a scaling call, not a role.
- The standing reviewer runs the suites and lint — the reviewer stays
  read-only; the builder tests what it built and the gate runs the
  regression.
- The builder retires by auto-compaction — the summary is the
  harness's, not the suite's.
- The standing reviewer promotes issues — the intake stays reachable
  only through the gate's architect and cap escalation.
- An architect standing during the build — forks are rare; the gate's
  architect reads claimed forks from the report.
