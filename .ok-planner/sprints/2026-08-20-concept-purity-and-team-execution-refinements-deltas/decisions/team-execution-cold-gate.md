---
decision: team-execution-cold-gate
---

# A builder and a standing reviewer execute a sprint; certification stays cold

## Choice

The sprint's execution shape names a team. The session orchestrates
it and never joins it as a worker: it relays messages between the
workers and reads their task notifications. It opens the completion
report with the staged list before the build and marks the closing
stages after the team retires; during the build it edits no file a
worker owns. It writes the reviewer's open ledger and the open
claimed forks to a sidecar beside the completion report on every
relay, so a replacement session resumes from disk, never from a
summary. The session dispatches the **builder** once and feeds it
one stage per message. The builder writes the code, tests what it built, keeps the
completion report, and fixes the reviewer's findings in its own
context. The session dispatches the **standing reviewer** once and
feeds it each landed stage's paths and the work items it lands. The
reviewer reads the increment under the certification gate's own
code-review brief and the gate's alignment questions scoped to the
stage, plus the read-only per-stage producers each family's ceremony
contribution names. It keeps a ledger of open findings and reports
back through the session. The session retires a worker only at a
stage boundary. A worker retires carrying roughly 300k–500k tokens of
measured context on a 1M-token window, scaled on a smaller window; at
each boundary the session projects the next stage's cost from its
staged paths and hands the stage over only when the worker will still
retire inside that band. A replacement builder reads the sprint and
the report; a replacement reviewer receives the open ledger. Where
the harness offers a file monitor, the session arms one on each
worker's output and takes its trip as the liveness signal; it never
polls by hand.

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
A stage's cost is unknown until it lands, so a fixed take-no-more
threshold cannot place the retirement where it belongs; a band states
the goal and leaves the boundary decision to the session, which holds
the staged paths. Subagents can message only agents they spawned, so
the session is the bus. A session that only relays keeps its own
context small across a long sprint. The ledger on disk closes the one
gap a relaying session leaves. The gate already writes its ledger
into the report before every dispatch; the build's open findings need
the same record, because a session death mid-build otherwise loses
every open line until the builder records it. A monitor turns
liveness into an event the harness delivers. Polling transcript
times by hand spends the session's own context on a question the
harness can answer.

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
- A fixed retirement threshold (~300k tokens) — the prior shape: a
  worker under it took any stage, and a stage that cost a whole
  builder left the worker far past it.
- The session holds the ledger in its own context only — the prior
  shape: lost with the session; the report carried the forks only
  once the builder recorded them.
- Liveness by reading the workers' transcript times by hand — the
  observed in-run practice: works, and spends the session's context
  on a check the harness's monitor answers for free.
- The standing reviewer promotes issues — the intake stays reachable
  only through the gate's architect and cap escalation.
- An architect standing during the build — forks are rare; the gate's
  architect reads claimed forks from the report.
