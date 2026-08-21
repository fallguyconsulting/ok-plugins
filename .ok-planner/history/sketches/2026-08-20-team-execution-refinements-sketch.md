# Team-Execution Refinements — Design Sketch

**Date:** 2026-08-20
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

A consumer project ran its first full sprint under the team execution
shape — standing builders and reviewers fed by message, retirement at
stage boundaries, the certification gate cold at the end — and the
shape held. The build's standing review caught 56 findings before the
gate, the gate's three-reviewer sweep caught 26 more, the two loops
showed 1 repeat and 0 reversals, and no worker hit harness compaction.
The same run also exposed five refinements. Each is an observed defect
or an instrument invented mid-run and carried by hand; this sketch
names them so a sprint can make them suite behavior.

The comparison that motivates the spend: the prior sprint on the same
project built inline (582 shell calls and 37 edits in the
orchestrator's own loop, no review during the build) and certified
clean through one reviewer in one cycle — and the intake that fed the
team-shaped sprint came from an audit over that certified work. The
single-pass gate undershot; the team shape caught the same defect
classes in-cycle, at roughly three times the token spend.

## Shape

**1. Scope the plumbline prose hook to file deliverables.**
The `Stop`/`SubagentStop` prose-review hook fired on workers' chat
replies and on Bash command text. Its forced rewrite pass appends a
message after the worker's report, and only a turn's last message
reaches the dispatching session — three reports were displaced this
way, each costing a resend round trip. The owner's ruling: the hook
binds written documents — files under the project root — never a
turn's conversational output or tool-call text. This removes the
failure at its cause. (The in-run workaround, a "restate the whole
report in your final message" line in every dispatch brief, becomes
unnecessary; keep it only if the hook keeps its current scope.)

**2. Retire into a band; decide at each boundary.**
The worker-pool rule names one number: retire a worker once its
measured context passes ~300k tokens. A stage's cost is unknown
until it lands, so a fixed take-no-more threshold cannot place the
retirement where it belongs. Three mass-conversion stages each cost a
whole builder (420–460k tokens), and two workers finished past 450k.
The rule should state the goal instead: a worker retires carrying
roughly 300k–500k tokens. At each stage boundary the session projects
the next stage's cost from its staged paths and decides whether the
worker takes it. A worker at 250k takes a stage projected at 150k
and retires near 400k; it does not take one projected at 400k. The
band lives in the worker-pool rule
(`_shared/dispatch-discipline.md`). The sprint boilerplate's
retirement bullet (`_shared/sprint-document.md`) cites it. Staging
stays as it is.

**3. Bake two reviewer instruments into the standing-reviewer brief.**
Both were invented mid-run, carried forward only through handoff
notes, and produced findings in every stage after their invention.

- *Cross-suite assertion check.* Container-backed suites boot real
  stacks and are not run per stage, so a stage that changes what an
  API answers can falsify an assertion in a file outside the stage's
  paths while every check the builder ran stays green. The
  instrument: when a stage changes behavior, `rg` the project's
  slow-suite trees for assertions about that behavior and read
  whether the change falsifies them — a read, which the read-only
  reviewer can do.
- *Out-of-population determinism sweep.* A wall-clock lint detects a
  fixed set of constructs; the testing standard bans any verdict
  that depends on elapsed time, in any spelling. Three spellings
  recur outside a detector set: an elapsed-time comparison inside an
  assertion; a timeout context feeding a call whose success the test
  asserts; a timer whose firing changes the outcome. The instrument:
  grep for those three shapes and read what the test asserts after
  each hit, with one judgment rule — a deadline that is the input
  under test is fine; a deadline whose expiry decides pass/fail is a
  finding.

Owner: `{{STANDING-REVIEWER-PROMPT}}` and `{{CODE-REVIEW-BRIEF}}` in
`_shared/certification-core.md`, phrased project-agnostically (the
brief already names the testing standard; these are its sharpest
known evasions).

**4. Persist the standing reviewer's ledger continuously.**
The session holds the ledger and the open claimed forks between
messages; a session death mid-build loses the open forks until the
builder records them in the completion report. The certification gate
already writes its ledger into the report before every dispatch. The
build's relay should do the same: write the standing ledger to a
sidecar beside the completion report on every relay, so a replacement
session resumes from disk, not from summary. The sidecar is its own
file, never a report section: the builder edits the report throughout
the build. One rule changes to make it legal. The sprint boilerplate
(`_shared/sprint-document.md`) says the session "during the build
edits nothing". The worker-pool rule already has the narrower form,
"it edits no file a worker owns". The boilerplate adopts that form.

**5. Wait on monitors, not polling.**
The relaying session idles between task notifications, and periodic
goal check-ins re-confirm liveness by hand (reading transcript
mtimes). Where the harness offers a file monitor, the session should
arm one on the workers' output files and drop the manual liveness
checks. Owner: the worker-pool rule's "Quiet is not finished" bullet
(`_shared/dispatch-discipline.md`), which names the liveness problem
and says nothing about how the session learns of it. One sentence
there: where the harness offers a file monitor, arm one on each
worker's output and treat its trip as the liveness signal; never poll
by hand. The sprint boilerplate already cites that rule.

## What stays as it is

The cold gate earns its redundancy: it re-found little in the
standing review's categories, and its full-sweep reviewers found 26
findings the build ledger never held — a release-path atomicity hole
among them. Retirement-and-replace also stands: cross-stage reviewer
memory caught a break in a file outside the changed stage's paths,
compounding handoff notes sharpened every later reviewer, and a
resumed fixer could not re-litigate settled rulings — the observed
reasons the loops did not oscillate.
