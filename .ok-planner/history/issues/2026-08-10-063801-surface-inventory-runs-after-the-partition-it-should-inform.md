---
issue: surface-inventory-runs-after-the-partition-it-should-inform
kind: filed
category: conflicting
artifacts:
  - decision:owner-guided-surface-partition
status: promoted
sprint: 2026-08-10-audit-owns-measurement.md
opened: 2026-08-10T06:38:01Z
---

# The audit's surface-inventory sweep detects candidate surface kinds after the walk that would have declared them, and files nothing

## Problem

The audit ceremony orders its phases: Surface (step 3), then Enumerate,
Determine, Judge, Distill, then Sweep (step 8). The surface determination at
step 3 is the run's one interactive moment, where the owner declares surface
kinds and classifies unclaimed elements. The surface-inventory sweep at step 8
is the pass that builds an inventory of externally reachable surfaces from the
code and the deployment configuration alone.

The ok-planner audit ceremony surface states that what the sweep finds that no
declared kind's enumerator would produce "is also a candidate-kind report for
the opening walk's list". The opening walk has already happened by then. The
sweep's candidate kinds cannot reach the walk they are named for in the same
run.

Two failures follow, and a run of this audit on the GridIQ platform exhibited
both.

The walk classifies a partition the run later learns is incomplete. That run
declared four kinds covering 220 elements and settled them with the owner at
step 3. The step 8 sweep then found three externally reachable populations no
declared enumerator produces: the dashboard layer, the identity provider's
protocol endpoints, and the object-store presigned upload targets. The ruling
committed at close-out is total over the four declared kinds and silent about
three real surfaces, and the run's own output proves it silent.

The detection does not survive the run. The ceremony states that both
whole-corpus sweeps "report findings in-context" and that their findings are
"reported, never recorded and never filed". A candidate kind therefore lands
only in the report the ceremony prints, which is a chat message. The next run
re-derives the same candidates, so the finding is reproducible, but the owner's
disposition of it is not: a decision to adopt one candidate and reject another
is recorded nowhere, and the next walk asks from zero.

The two failures compound. The sweep is the only pass that reads reality rather
than the corpus, so it is the only pass that can catch a surface the corpus
never mentions — and its output is both too late for the partition and too
perishable to inform the next one.

## Candidates

- Move the surface-inventory sweep ahead of the surface determination, so the
  inventory it builds feeds the walk's candidate-kind list in the same run.
  This makes the sweep's cost part of every run's opening rather than its tail.
- Split the sweep: run its inventory-building half before the surface
  determination to supply candidate kinds, and keep its corpus-checking half at
  step 8 where the determinations it cross-checks already exist.
- Keep the ordering and make candidate kinds durable by filing them as intake
  issues, so the owner's disposition of each is recorded once instead of
  re-derived every run. This accepts one run's ruling being silent about a
  surface the same run detected.
- Keep the ordering and have the run re-open the surface walk when the sweep
  produces candidate kinds, making the surface determination the run's first and
  last act.

## Ruling

*(Transcribed from the owner's live decision, 2026-08-10 session. The
decision settles this issue and rules beyond it.)*

Mechanical enumerators are retired entirely. An enumerator is itself
unaudited software: it drifts, and it misses what was added
out-of-practice by design or accident — the same blind spot the sweep
existed to catch. Extraction becomes agentic, and the sweep dissolves
into it.

The settled design:

- **Extraction is one agentic, hierarchical pass, purpose-bound to the
  ruling.** Its only purpose is to give the partition members to rule
  on so the audit can proceed; it walks coarse-to-fine and goes no
  deeper than classification requires.
- **Known-internal is a pruning notation, not a finding.** A module or
  service the guidance already marks internal is notated and never
  descended into — classification happens at the container. In
  practice the pass is targeted: public modules, REST APIs, environment
  variables, config files, proto surfaces, CLI commands; most of the
  codebase sits behind internal notations and needs no extraction.
- **Novelty is the interactive trigger.** A module, service, protocol,
  or kind the guidance does not cover is what the agent brings to the
  opening walk; the owner's answer lands in the guidance as a new
  notation, so the next run passes that spot silently. This absorbs the
  sweep's discovery job — "what exists that nobody declared" becomes
  the extraction's own outer loop, at the opening, which resolves this
  issue's ordering defect directly.
- **The committed member lists and the diff-walk stay** as the
  between-runs record: re-derive each run, diff against the committed
  list, walk drift with the owner.
- **Retired:** the per-kind enumerator commands in the surface
  declaration; the `derivation: agentic` marker (vacuous once all
  derivation is agentic); the "retire agentic kinds by making their
  populations mechanical" worklist — that retirement direction
  inverts. The sweep's remaining half, the corpus-contradiction check
  (an artifact's claimed posture versus observed reality), routes
  through the judge like every other escalation — the audit's one
  gated filing path; nothing is "reported, never recorded, never
  filed" anymore, and no sweep-shaped step survives.

Corpus deltas this implies (for the sprint that promotes this):
amendments to `decision:owner-guided-surface-partition` and
`concept:surface-declaration` (and the agentic-extraction decision's
retirement-direction language), plus the audit ceremony surface and
skill rewrite.

Vocabulary rulings from the same session, riding the same sprint:

- "Experiment harness" / "harness" is struck; the collection is simply
  **the experiments**. Skill and ceremony text updated accordingly;
  no new concept.
- **"Nomination"** replaces "promotion" for canonizing an experiment as
  a maintained test: a run nominates an experiment by filing an intake
  issue; the owner rules; a sprint adopts. "Promotion" remains the
  issue lifecycle's word alone.
- "Surface" belongs to the public-surface partition alone. The
  family-contribution files (`ceremony/<verb>.md`) and administration
  files stop being called "surfaces"; the sweep's reachability sense
  is dissolved by this ruling's extraction design.

Further rulings from the same session, riding the same sprint:

**Assumptions move into `/audit`.** Generation and verification both.
The run's sequence: surface determination → story audits →
cold-boxed synthesis of assumptions from the passing stories and the
ruled public surface → assumption audits on the same user-vantage
instrument (same auditor and experiment machinery as stories; the
claim is presumed rather than promised). Assumptions are
story-shaped records in their own estate folder beside the audit
corpora — not `design/`; the owner never committed to them —
regenerated each run under the no-carry rule. The cold box survives
unchanged: its export set (story catalog, published concept layer,
the ruling, the prior release's published corpus) exists in the
estate at audit time. The judge asymmetry: a confirmed story gap
files an issue (an unmet promise is work); a confirmed assumption
contradiction files nothing and records a **trap disposition**
(nothing was promised — that is documentation); where diagnosis
shows a story is also violated, that is a story finding on its own
track.

**The audit produces artifacts, and documentation is constructed
from them.** The audit folder holds stories, decisions, assumptions,
and the public-surface extraction and ruling; `/document` measures
nothing and is constructed from those artifacts with minimal
effort — not quite mechanically, but close: catalog projection over
the ruling, trap registry from the assumption dispositions, the
publishable/verification split, the stamped corpus.

Additional corpus deltas this implies: `cold-boxed-synthesis` (new
host), `document-composes-audit`, `full-reassessment-per-release`
(cadence anchor moves from release to stamp), `concept:assumption`
(home and lifecycle), both ceremony contributions and both skills.

**The completion ceremony: a run report as record, presentation
conditional on the caller.** After Check passes, the run writes a
report to `history/audits/<date>-<sha>-report.md` — the receipt
facts (per-estate artifact counts and dispositions, the check's
verdict, issues filed by path, the two shas) plus the run narrative
(dispatches, judge overturns, diagnoses, worker retirements). The
report rides the close-out commit and is stamped in the follow-on.
It is a record, never a channel: nothing lives only there —
everything durable is in artifacts and issues — and it is never
read to understand the project. Its one job: an à la carte run ends
by composing the owner wrap-up *from the report* (so a long
goal-driven run presents from what it wrote while fresh, not from
summarized context); a run invoked by `/document` ends silently at
the stamp, and `/document`'s own wrap-up covers both, reading the
same report as an input. The presentation's old sections die with
this: run-self-observations route to the judge like every other
escalation; compliance defects, overturns, and referrals are read
from the corpora they already live in.

**The goal file: a vendored brief whose path is the goal.**
Materialized by converge at `.ok-planner/ceremony/audit-goal.md`.
An à la carte walk's last act is handing the owner one line to
paste: `/goal the audit run described in
.ok-planner/ceremony/audit-goal.md is complete — every term of its
goal rule verifies against this repository`. Two sections, two
readers. The brief for the driving agent: role at the top (*you are
the orchestrator; you file nothing of your own motion; everything
you would tell the owner goes in the run report*), then the
post-walk course as pointers to the vendored skill and each
estate's ceremony contribution, never restating them. The goal rule
for the checker, sprint-style — met when: audit corpora complete
per estate in scope, assumption records regenerated, `audit-check`
clean, report at its `history/audits/` path, both commits landed,
stamps present. Explicitly met despite: issues filed by the judge;
`unsupported`/`unclear` determinations standing; findings unfixed
and issues unclosed (fixing is a sprint's job, never this run's).
Not met: check failing, any stamp missing, report absent. Guard
clause: the file governs the run only from the settled walk onward —
an unsettled partition means the goal was set too early; say so and
stop rather than settle it alone. The same shape yields
`document-goal.md` for the documentation run.

**The Determine stage becomes a worker pool where the harness
supports it.** N workers per instrument (readers for decisions and
concepts, measurers for stories and assumptions), spawned once and
fed one artifact at a time by SendMessage, locality-routed so a
worker keeps reusing the code it already holds; each worker writes
its audit file per item on completion. Retirement is by measured
context: each task notification carries the worker's token count
(`subagent_tokens`) — the primary meter, read at exactly the moment
the feed loop decides feed-or-retire — with the worker's transcript
(`<session-dir>/subagents/agent-<id>.jsonl`, last entry's `usage`:
cache_read + cache_creation + input tokens) as the direct secondary;
the two agree within one reply's output tokens (validated live
2026-08-10: spawn → stand by → feed by message → resume from
completed → measured 19.2k/20.6k/20.0k across three turns → retire
by message). The meter is per-request, not a running tally: it
measures the live context the worker carries, and it can dip on
resume because the harness prunes old tool results when rebuilding
the prompt — so the rule reads the current number each round, no
trend. **Retire when the worker finishes an item and its last round
exceeded ~300k**, spawning a replacement to hold N. The threshold
assumes a 1M-window model (~30% of the window); scale it
proportionally on smaller windows. A worker gone quiet is not a
finish — that is a liveness problem (stop it, redispatch its item),
never a retirement. One terminal judge,
unchanged. Where the harness lacks cross-agent messaging, fall back
to bounded batches: group stories/assumptions by driven surface
elements and decisions/concepts by code locality, five to ten per
batch, splitting any batch whose shared reading set is too large to
hold and genuinely read.
