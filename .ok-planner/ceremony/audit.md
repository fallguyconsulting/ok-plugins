# ok-planner — audit ceremony contribution

What the suite's periodic audit does about this family's estate. The
ceremony owns the spine — surface, enumerate, determine, judge,
distill, check, verify, report, close out, present; this file owns
everything ok-planner contributes to it. Materialized into consumer
projects at `.ok-planner/ceremony/audit.md`; the ceremony reads it
there when `.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root. Without a design corpus
there is nothing here to audit: say so, point at `/discover-design`,
and let the other estates' phases run.

`.ok-planner/surface/surface.md` — the **surface intent**, per
`concept:surface-intent`: one prose document naming which classes of
element are public by default and which specific elements depart from
those rules. Produced and maintained in the interactive intent stage
below, an à la carte audit's one owner walk; the owner may also edit the file
directly between audits. Where it does not exist yet, the interactive
stage authors it from zero.

## Layout

`mkdir -p .ok-planner/audits/concepts .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/audits/assumptions .ok-planner/audits/surface .ok-planner/surface/documents .ok-planner/experiments .ok-planner/issues .ok-planner/history/issues .ok-planner/history/audits`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

## Surface

Two sub-stages, per `decision:owner-guided-surface-partition`: an
**interactive intent stage** with the owner, then the **autonomous
extractor dispatch** against what that stage landed — and, only when
`/document` invoked the run, a third: the **documentation walk**
against the extraction just written
(`decision:documentation-walk-in-composed-audit`). The interactive
stage is the one place an à la carte `/audit` walks the owner, and
the reason the ceremony is interactive at all; everything after the
surface stage is autonomous against documents the run has just
committed to.

### Interactive intent

You and the owner produce or update the intent document at
`.ok-planner/surface/surface.md` — the source of truth for what the
project's user-facing surface is meant to be. The conversation runs
top-down and stops when the intent is landed; nothing dispatches
until it is.

- **Read the current document if it exists.** Summarize it back to
  the owner in a few lines — the general rules and the specific
  exceptions — and ask what has changed. A short "still current"
  passes the stage; edits and additions get transcribed as you go.
- **Author from zero if it does not.** Open with the class question,
  not the element question: "What is user-facing at all — which
  modules, services, or entry points?" Then, for each class the
  owner names user-facing, "is every one of these public, or are
  there specific exceptions?"
- **Work at classes first, elements only as exceptions.** "Every CLI
  verb under `plugins/*/skills/` is public except the `_shared/`
  bodies" is intent; a bullet listing 47 verb names is not, and it
  would drift the moment a verb is added. Enumerating what a class
  rule already covers is a form defect; only the exceptions worth
  naming get named.
- **Get more specific only where a class does not have a clean
  rule.** Elements the owner cannot cover with a rule or an
  exception get flagged with a one-line note and become intake
  issues *after* the extractor finds them (see the extractor's
  rules below). Do not turn the interactive stage into an
  element-by-element walk.
- **Land the document.** Write the final text to
  `.ok-planner/surface/surface.md`, show the owner the diff, and
  confirm they approve. This is the moment the intent is landed for
  the run.

The interactive stage is an à la carte run's only owner
conversation, and a composed run's first of two. Do not open other
topics — driving observations, prior audit findings, sprint plans —
here; those belong in the run's report or, where they warrant a
ruling, in the judge's escalations.

### The goal handoff

Once the intent is landed, hand the owner one line to paste — the
run proceeds hands-free from there. In a run `/document` invoked,
the handoff is `/document`'s own, and it comes after the
documentation walk below; this line is for the à la carte run:

```
/goal the audit run described in .ok-planner/ceremony/audit-goal.md is complete — every term of its goal rule verifies against this repository
```

The vendored goal file carries the driving brief and the goal rule;
the run then proceeds identically whether or not the owner sets the
goal.

### Autonomous extraction

Dispatch the **surface extractor subagent**. The subagent reads
`.ok-planner/surface/surface.md` (the intent the interactive stage
just landed, or the file on disk if the owner edited it directly
since the last audit), walks the code and the deployment
configuration purpose-bound to classification, and writes
`.ok-planner/audits/surface/extraction.json` — one entry per element
the walk found. Each entry names the element's kind (discovered by
the walk, not pre-declared: CLI verbs, HTTP routes, environment
variables, config keys, ports, published files, protocol schemas, or
whatever the codebase actually exposes), its identifier, its location
in the tree, whether the intent placed it public or internal, and —
for a defaulted-internal element — that the classification was
defaulted. The extraction is a per-run artifact; nothing carries
between runs.

The subagent's rules:

- **Read the intent, walk the tree, join the two.** The walk is
  targeted — routes, verbs, env vars, config keys, ports, published
  files, protocol schemas — and goes no deeper than classification
  requires. The intent's general rules cover most elements; its named
  exceptions cover the rest.
- **Residual ambiguity is asymmetric.** Where the just-landed intent
  does not clearly settle an element the walk suspects may be public
  — a class the interactive stage did not reach, an element added
  since the last intent walk, an exception easier to see from the
  code than from the owner's memory — default it to internal for
  this run, mark the entry as defaulted, and file one intake issue
  per genuinely ambiguous element by the ordinary intake conventions
  (category `unclear`) asking the owner to amend the intent. Do not
  page the owner; the interactive stage has already spent that
  attention. Do not stall.
- **Escalate corpus contradictions, never walk them.** An artifact
  asserting a posture the observed element violates — an "every
  surface authenticates" Choice beside an unauthenticated published
  port — is an escalation for the run's judge, quoting the claim and
  the observed evidence, not the extractor's business to resolve.

The orchestrator dispatches the subagent, consumes what it returned,
and moves on. **No mid-run walk with the owner beyond the
interactive intent stage above — except the documentation walk a
composed run adds below. No reconciler tool. No committed member
lists. No guidance hash. No stamped ruling partition.** The
extraction file is the record; the intent file is the source of
truth; both are stamped with the closing commit at close-out, so
freshness is a git question anyone can answer.

**Nothing in the surface phase files of its own motion beyond the
intake issues the extractor files for residual ambiguity.** The
contradictions the walk turned up go to the judge; everything else
goes in the run report.

### The documentation walk (composed runs only)

When `/document` invoked this run, immediately after the extractor
returns and before Enumerate, run the **documentation walk** defined
under Walk in `.ok-planner/ceremony/document.md` — the one body,
called here against the extraction just written. It reads the
extraction's public side against the document types declared under
`.ok-planner/surface/documents/` (`concept:document-type`), raises
only the deltas with the owner, and lands the types they approve; a
type left unsettled is left out for the run and filed as an intake
issue by the walk's own rule. An à la carte run does not run it: the walk belongs to the
documentation ceremony, and this hook exists so a composed run keeps
the owner's attention in one stretch — intent, extraction,
documentation — before the hands-free portion. Once the walk lands,
hand the owner `/document`'s goal line (naming
`.ok-planner/ceremony/document-goal.md`, per that file). Everything
after the walk is autonomous.

## Enumerate

Every file under `.ok-planner/design/concepts/`,
`.ok-planner/design/stories/`, and `.ok-planner/design/decisions/` is in
scope — there is no subset. **Concepts are audited like decisions**,
because the compliance axis is a reading of any artifact against its own
authoring rules and a concept has rules of its own: the altitude bar, the
self-containment restrictions, and the no-implementation-enumeration
tightening. Its support axis is its Invariants read against the code,
exactly as a decision's Choice is.

**Stories are enumerated apart from the other two**, because their
instrument differs (`decision:user-vantage-story-audits`): story
support is measured from the user's side, through the public surface
the extraction records, never settled by reading or by citing a
test. Order the story
feed by the surface elements the stories' ways drive, and the
reading feed by code locality, so consecutive items reuse what a
worker already holds. Say how many artifacts ride each instrument
before dispatching. Assumptions are not enumerated here — they do not
exist yet; the synthesis below creates this run's set after the story
verdicts land.

## Determine

Two instruments, one collection, the same two words. Both tracks run
through the ceremony's worker pool where the harness supports
cross-agent messaging (`{{WORKER-POOL-RULE}}` from
`.claude/skills/_shared/dispatch-discipline.md`), and as bounded
batches of five to ten otherwise.

**Decisions and concepts — adversarial reading.** Workers run
`{{IMPLEMENTATION-AUDITOR-PROMPT}}` from
`.claude/skills/_shared/implementation-auditor.md`, with `[AUDIT
SET]` filled with the items fed so far — one ref per feed message in
pool mode, the whole batch in batch mode. Each writes its audit files
to `.ok-planner/audits/<bucket>/<slug>.md` and reports one line per
artifact.

**Stories — user-vantage measurement.** Workers run
`{{STORY-AUDITOR-PROMPT}}` from the same file, with `[SURFACE]`
filled with the public elements the run's extraction records —
`.ok-planner/audits/surface/extraction.json` — for the kinds the fed
stories drive. The instrument is **the experiments** at
`.ok-planner/experiments/` (one experiment per directory: the
runnable files plus a `record.md` — frontmatter `experiment:`,
`commit:`; body: what it ran against, what was observed):

- an archived experiment covering a claim is **re-run** at this tree;
- one the extraction diff makes suspect is **repaired first**, the
  diff steering the repair;
- a claim no archived experiment covers gets a **new** experiment;
- one whose surface elements are gone from the extraction is **retired**.

A story is `supported` only when passing runs driven through elements
the extraction records public demonstrate the capability and the
benefit. A failing run is never a finding — it dispatches diagnosis
(stale probe, wrong probe, or wrong assumption; the project's tests
may steer diagnosis but never stand as warrant). Conclusions never
carry: a prior run warrants nothing until re-run at this tree.

Each audit records **two independent axes**, per `{{AUDIT-DEFINITION}}`:
whether the artifact complies with its own authoring rules, and whether
the codebase supports what it claims. They genuinely come apart, and
both are written. Never one agent per artifact outside the pool's
one-item feeds, and never a subagent inside a worker.

### Synthesize, then measure the assumptions

After the story verdicts land, the run forms this run's
**assumptions** — user-vantage priors, per `concept:assumption` — and
measures them on the same instrument as the stories. Synthesis is
cold and boxed, per `decision:cold-boxed-synthesis`:

1. **Build the box.** Export into a scratch directory outside the
   project tree — never a checkout — exactly the user-visible
   material: every story body under `design/stories/` and the story
   TOC, each annotated with this run's implementation verdict; every
   concept body under `design/concepts/` and the concept TOC — the
   published concept layer; the **rendered public surface** — the
   extraction's public entries per kind, rendered as plain member
   lists, never the extraction file itself, which is a verification
   record; and the prior release's published documentation corpus
   (its publishable layer only), where one exists. Nothing else
   enters: decisions are developer material, and audits, the
   extraction file, the experiments, sprints, issues, sketches,
   history, code, and tests all stay out.
2. **Dispatch one synthesizer** with the fixed brief below, the box
   as its world: no repository path, no shell, no network, read-only
   file tools. Interpolate the box path and nothing else.
3. **Gate the output.** Scan the synthesizer's transcript for any
   access resolving outside the box; an out-of-box access voids the
   output, and the synthesis re-runs in a fresh box.
4. **Record the set.** Write each assumption as a story-shaped record
   to `.ok-planner/audits/assumptions/<slug>.md` — frontmatter
   `assumption:`, `commit:` (stamped at close-out), `disposition:
   unverified`; body: the prior as the user would hold it, and its
   source (a name's promise, sibling symmetry, a convention of the
   craft, a published concept, an ecosystem prior). The set is
   re-derived whole every run; no standing registry is maintained.

Then feed the records through the measurement track exactly as
stories, using `{{ASSUMPTION-AUDITOR-PROMPT}}` from
`.claude/skills/_shared/implementation-auditor.md`: experiments
through the public surface the run's extraction records,
affirmative-only warrants, conclusions never carrying. A measured assumption's record closes
with `disposition: held` (passing runs demonstrate the prior),
`disposition: trap` pending the judge (a run demonstrates the product
contradicting it), or `disposition: unverified` (no run could be
taken). Every synthesized assumption ends the run carrying one of the
three — never silently dropped.

### The synthesizer brief

```
Agent (general-purpose, model: opus):
  ## Assumption synthesis — user vantage only

  You are working inside a closed box of user-visible material:
  [BOX PATH]. It is your entire world. You have no repository, no
  shell, and no network; do not attempt to read outside the box.

  ### Your job

  From this material alone, write down what a reasonable user would
  take to be true about this product before checking — the priors
  the material invites. You are not verifying anything: expectations
  only, written before measurement, so they cannot be softened to
  match what is found.

  ### Where assumptions come from

  Work the enumerable sources, in order, over the whole surface:
  - Names that promise observable behavior.
  - Symmetry between sibling elements: what exists for one, a user
    assumes for its siblings.
  - Conventions of the craft the product's shape invokes.
  - Expectations the published concepts license.
  - Ecosystem priors: what products of this kind normally honor.

  ### Output

  One assumption per record, story-shaped: the user role, the prior
  they would hold, and why they would hold it (its source above).
  Concrete enough that a run through the public surface could
  demonstrate or contradict it. Skip what no run could ever observe.
  Return the records as your final output; you write no files.
```

## Judge

Collect every escalation: each ref an auditor returned as
`unsupported`, each measured assumption contradiction, each corpus
contradiction the extraction surfaced, and the orchestrator's own
driving observations — defects noticed in the project, the estate,
the suite, or the run's instruments. None → skip this stage and say
so in the report. Otherwise dispatch `{{AUDIT-JUDGE-PROMPT}}` from
`.claude/skills/_shared/implementation-auditor.md` with the full
list — each item, its kind, its instrument, and its one-line reason,
verbatim.

The judge is terminal, and its outcomes are asymmetric by what was
escalated, per `decision:audit-audience-split`:

- **A story or decision/concept gap** — confirmed: `unsupported`
  stands, and the judge files an intake issue by the ordinary intake
  conventions (nothing is stamped back into the audit; the corpus
  and the intake are independent). Overturned: rewritten `supported`.
  An unmet promise is work, so it reaches the intake.
- **An assumption contradiction** — confirmed: the record's
  disposition becomes `trap`, and **nothing is filed** — nothing was
  promised, and a trap is documentation, not work. Overturned: the
  disposition becomes `held`. Where the judge's diagnosis shows a
  story is also violated, that is a story finding on the story's own
  track, escalated and filed there.
- **An extraction contradiction or driving observation** — confirmed:
  intake issue filed (category `conflicting` for a posture
  contradiction). Refuted: dropped, recorded in the run report.

The compliance axis never escalates. A form defect is mechanical by
construction — the rules determine the compliant text — so it is
recorded in the audit file and fixed by a future sprint's work, never
by this run.

## Distill

Experiments this run had to **build**, passing at the stamp, that
would have to be maintained to keep, are **nomination** candidates:
file each as an intake issue per the estate's issue-file
conventions — never a failed run, never an opinion of the product.
Nomination is how an experiment enters the project's own suites (as
an ordinary test, or an expected-fail test encoding a standing trap):
the owner rules on the issue, and a sprint adopts. Canonizing an
experiment is never this run's act, and the distillation files
nothing else.

## Verify

If the judge or the distillation filed any, invoke `verify-issues`; it
makes each one ruling-ready per its own process. Zero filings → skip,
silently.

## Report

Write the run report to
`.ok-planner/history/audits/<date>-<sha>-report.md` (`<sha>` stamped
with the close-out commit, like every audit file). It is a record,
never a channel — nothing lives only there; everything durable is in
the corpora and the intake — and it is never read to understand the
project. Its one job is to let the run's ending be composed from what
was written while fresh. Shape:

```
# Audit run — <project> at <short sha or "working tree">

## Receipt
Estates: <the ones in scope, and the artifact count each contributed>
Stories: <supported / unsupported out of N>
Decisions and concepts: <the same split out of N>
Assumptions: <held / trap / unverified out of N synthesized>
Text: <all compliant | the noncompliant refs, one line each>
Surface: <N elements over K kinds discovered by the extractor, P
public / Q internal; D of Q defaulted internal because the intent did
not settle them (each such element filed as an intake issue)>
Experiments: <re-run / repaired / built / retired counts>
Check: <clean, or the findings and the re-dispatch that cleared them>
Issues filed: <every issue, by path, with the verify pass's outcome —
or "none">
Commits: <the two shas>

## Narrative
<The run as it actually went: dispatches and feed order, worker
retirements, judge outcomes with the overturns called out (the run's
own error rate), diagnoses behind failing runs, instruments repaired,
and every driving observation — escalated ones with the judge's
verdict, the rest as the record of what was noticed.>
```

## Close-out

The run commits its own output — that is what makes an audit a
statement about a commit rather than about a moment. Two commits, both
the ceremony's own act, covering every estate's audits together:

1. Commit the audit corpora, this run's assumption records, the
   surface extraction, the document types a composed run's walk
   landed, the experiments' changes, the run report, and any issue
   files, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field,
   every assumption record's, the extraction's `commit` field, and the
   run report's `<sha>` name segment and body, and make one small
   follow-on commit. Each record then names the commit whose tree
   holds both the code it describes and the record itself — the same
   shape the sprint close-out's `closed:` stamp uses.

**The staleness rule consumers key on:** this run's output paths are
`.ok-planner/audits/` (the assumption records and the surface
extraction included), `.ok-planner/surface/` (the intent this run's
interactive stage produced or updated, and the document types a
composed run's walk landed), `.ok-planner/experiments/`,
`.ok-planner/issues/`, and `.ok-planner/history/audits/` (the run
report). The audit is current
for a later tree exactly when the diff from its stamped commit
touches only those paths — a path-scoped diff, no tracked state. An
edit to `surface.md` between audits (the owner amending the intent
directly) moves the tree and warrants a fresh extraction on the same
rule as any other output-path edit.

Archive nothing else and offer nothing else: this run has no sprint,
and the issues it filed stay in the intake until a planning ceremony
closes them.

## Present

Only when the run was invoked à la carte: compose the owner's wrap-up
from the run report — never from summarized context — and deliver it
as conversation rather than by pasting the report. Sections:

```
# Audit — <project> at <close-out sha>

Status: complete and committed

## What was determined
<The receipt's counts, a line each: estates and the artifact count
each contributed, stories, decisions and concepts, assumptions,
surface, experiments.>

## What deserves your eyes
<The issues filed, by path, with the verify pass's outcome per
issue; the traps recorded; the judge's overturns; the driving
observations that survived. "None" per empty category.>

## Receipt
<The two close-out shas, and the run report's archive path.>
```

**The wrap-up is the run's last act.** It ends on the receipt and the
turn ends there. There is nothing to archive — the run report was
written straight to `.ok-planner/history/audits/` — and nothing to
commit: the close-out above already made both commits and stamped
them, and the receipt is where the owner sees that. So offer neither,
propose no follow-on work, name no next step, and ask no closing
question. Every gap the run found is already an issue in the intake,
which is a planning ceremony's business and not this run's.

Invoked by `/document`, this estate presents nothing — the run ends
silently at the stamp, and `/document`'s own wrap-up reads the same
report.

## Boundaries

- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded in the
  audit file. There is no fixer, no architect, and no cycle cap,
  because there is no loop.
- **Files nothing of its own motion.** The judge, the distillation,
  and the surface extractor's intake issues for ambiguous elements
  are this contribution's only filing paths. A defect the run
  discovers while driving — in the code, in an extraction entry, in
  the suite itself — is an escalation for the judge and a line in the
  run report, never written to `.ok-planner/issues/` directly.
- Does not run the project's test suites or build it; whether they pass
  is `/certify-work`'s business. The measurement instrument does
  execute the released product — through elements the run's extraction
  records public and through nothing else.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run; every experiment re-runs
  at this tree; the assumption set is re-synthesized whole; the
  extraction is re-derived whole.
- Does not touch `.ok-planner/design/`. The corpus's claims are the
  subject under audit, never the thing edited to make an audit pass.
- **Writes the surface intent only through the interactive intent
  stage.** `.ok-planner/surface/surface.md` is the source of truth
  and the owner is its authority; the interactive stage co-authors
  it with the owner in-session, and the autonomous extractor never
  writes it — the extractor reads it, records the join, and files
  intake issues where the just-landed intent still does not settle
  an element. Between audits, the owner edits the file directly.
- Does not read `.ok-planner/sprints/` or `history/`. Project records
  are out of context; the run report is append-only output into the
  archive, not a license to read what lives there.
- **Does not stall the autonomous portion for the owner.** The
  interactive intent stage is an à la carte run's only owner walk,
  and a composed run's documentation walk right after the extractor
  is its last; once those land, the extractor's residual ambiguities
  become defaulted-internal entries and intake issues, and the run
  finishes hands-free.
- **Does not roll into follow-on work.** The presentation ends on the
  receipt and stops. Proposing a sprint, offering to fix a gap or
  close an issue, offering to archive or commit anything further, and
  asking what to do next all re-open a run that is finished.

<!-- Materialized by ok-planner v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
