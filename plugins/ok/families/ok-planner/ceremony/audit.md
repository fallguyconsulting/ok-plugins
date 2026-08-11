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

`.ok-planner/surface/surface.json` — the **surface declaration**: the
owner's committed list of the product's user-facing surface kinds.
Shape:

```json
{
  "kinds": [
    { "kind": "cli-verbs",
      "reads": "<one line naming what the derivation reads>",
      "expectedEmpty": false }
  ]
}
```

Every kind's population is derived agentically — there are no
per-kind enumerator commands — and lives as a **committed member
list** at `.ok-planner/surface/members/<kind>`, one member per line:
the mechanical face of the population, written only from the opening
walk. `reads` is required on every kind: one line naming what the
derivation reads (the route registrations, the CLI entry points, the
deploy manifests). `expectedEmpty` is optional and defaults to false;
a derivation that returns zero members fails loudly unless the kind
carries it. A declaration still carrying a legacy `enumerate` or
`derivation` field is a declaration error the reconciler rejects,
naming this schema.

`.ok-planner/surface/guidance.md` — the **surface guidance**: the
owner's prose rules for ruling any extracted element public or
private (general rules narrowed by exceptions; prose for judgment,
never a member inventory). Its **internal notations** — the
containers the owner has marked internal — double as the extraction's
pruning boundaries.

Both are owner-owned: extraction may propose a kind or a rule, only
the owner declares, and the files are written only as transcription of
the owner's explicit answers. Where they do not exist yet, the opening
extraction still runs and proposes candidate kinds at the walk — the
owner's declarations bootstrap the files as transcription. Where the
owner is not present to walk it (a goal-driven run on an unsettled
partition), the surface determination cannot settle: say so and stop,
per the goal file's guard clause; a run without a ruled surface calls
every story `implementation: unsupported` (its paragraph says the
surface partition was not settled at this tree) and audits decisions
and concepts normally.

## Layout

`mkdir -p .ok-planner/audits/concepts .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/audits/assumptions .ok-planner/audits/surface .ok-planner/surface/members .ok-planner/experiments .ok-planner/issues .ok-planner/history/issues .ok-planner/history/audits`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

## Surface

The run opens by settling the public-surface partition, per
`decision:owner-guided-surface-partition`: every extracted element
ruled public or private by applying the owner's guidance, no default,
nothing invisible. This is the run's **one interactive moment**; a
settled partition and ratified guidance pass it silently, so cadence
runs stay hands-free.

**Extract first — agentically, hierarchically, purpose-bound to the
ruling.** The extraction walks the project coarse-to-fine, from the
code and the deployment configuration and never from the design
corpus, and goes no deeper than classification requires:

- **Prune at the guidance's internal notations.** A module, service,
  or directory the guidance already marks internal is classified at
  its boundary and never descended into. In practice the walk is
  targeted — public modules, HTTP and RPC routes, environment
  variables, config files, protocol schemas, CLI commands — and most
  of the codebase sits behind an internal notation and is never
  walked.
- **Derive each declared kind's members** from what its `reads`
  names, and diff the result against the committed member list at
  `.ok-planner/surface/members/<kind>`. No drift → nothing to say.
  Drift is walked with the owner — one prose question per divergent
  member, batched where obviously parallel — and the committed list
  is updated only from that walk, never silently.
- **Carry novelty to the walk.** A module, service, protocol, or
  surface kind the guidance does not cover is a candidate: propose it
  to the owner at the walk, never auto-add it. An adopted kind is
  declared (with its `reads`), its members derived and committed; a
  rejected one lands in the guidance as a notation, so the next run
  passes that spot silently.
- **Escalate corpus contradictions, never walk them.** An artifact
  asserting a posture the observed element violates — an "every
  surface authenticates" Choice beside an unauthenticated published
  port — is not the walk's business: record it as an escalation for
  the run's judge, quoting the claim and the observed evidence.

Then run the vendored reconciler:

```bash
.ok-planner/bin/surface-reconcile
```

(If the project has not converged, fall back to the payload's
`scripts/surface-reconcile` and announce the fallback exactly as the
Check phase does for its checker.)

The tool reads the declaration, reads each kind's committed member
list, writes the fresh extraction to
`.ok-planner/audits/surface/extraction.json`, diffs it against the
membership the current ruling was computed from, and reports per
element — classified public, classified private, or unclaimed — plus
the guidance-anchor comparison: the current guidance blob hash against
the one the ruling recorded. Exit 0 means settled; exit 2 means
unclaimed elements or an unratified guidance change; exit 1 is an
error in the declaration or a member list, which is a loud failure the
run does not proceed past.

On exit 2, in order:

1. **Ratify guidance changes.** If the guidance hash moved, read
   `git log` for `surface/guidance.md` since the ruling's stamped
   commit. A change carried by an approved sprint's execution is
   already ratified — the sprint's sign-off was the owner's approval;
   acknowledge it in one line. Any other change is walked with the
   owner now: confirm it stands (it is ratified by the confirmation)
   or the owner revises it on the spot. Ratification is detected by
   comparing anchors, never by tracked state.
2. **Classify the unclaimed.** Apply the guidance to every unclaimed
   element. An element the guidance settles is classified, with the
   governing rule noted in the walk summary. An element the guidance
   cannot settle reaches the owner as one prose question per element
   (batch the obviously-parallel ones); **every answer lands in the
   guidance** — transcribed as the owner's own text, a rule or an
   exception — never only in the ruling.
3. **Write the ruling.** Regenerate
   `.ok-planner/audits/surface/ruling.json` whole:

   ```json
   {
     "commit": "<stamped at close-out>",
     "guidanceHash": "<git hash-object .ok-planner/surface/guidance.md>",
     "kinds": [
       { "kind": "cli-verbs",
         "public": ["..."],
         "private": ["..."] }
     ]
   }
   ```

   Every extracted member appears in exactly one of `public`/`private`
   for its kind — the partition is total, and an element nobody ruled
   is a failure, never "private by omission". The two anchors — the
   commit (stamped at close-out, like every audit file) and the
   guidance hash — are what make staleness and ratification pure git
   questions. Re-run the reconciler after writing; it must exit 0.

**Nothing in the whole surface phase files.** Not the classification
walk, and not the engineering around it — a declaration you draft, a
member list you derive, a defect you find while proving a population
real. The walk's discoveries go to the owner by speaking to them; the
contradictions the extraction turns up go to the judge; everything
else goes in the run report.

**The goal handoff.** When the run was invoked à la carte, the settled
walk ends by handing the owner one line to paste:

```
/goal the audit run described in .ok-planner/ceremony/audit-goal.md is complete — every term of its goal rule verifies against this repository
```

The vendored goal file carries the driving brief and the goal rule;
the run then proceeds identically whether or not the owner sets the
goal.

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
support is measured from the user's side, through the ruled public
surface, never settled by reading or by citing a test. Order the story
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
filled with the ruling's public elements for the kinds the fed
stories drive. The instrument is **the experiments** at
`.ok-planner/experiments/` (one experiment per directory: the
runnable files plus a `record.md` — frontmatter `experiment:`,
`commit:`; body: what it ran against, what was observed):

- an archived experiment covering a claim is **re-run** at this tree;
- one the extraction diff makes suspect is **repaired first**, the
  diff steering the repair;
- a claim no archived experiment covers gets a **new** experiment;
- one whose surface elements are gone from the ruling is **retired**.

A story is `supported` only when passing runs driven through elements
the ruling classifies public demonstrate the capability and the
benefit. A failing run is never a finding — it dispatches diagnosis
(stale probe, wrong probe, or wrong assumption; the project's tests
may steer diagnosis but never stand as warrant). Conclusions never
carry: a prior run warrants nothing until re-run at this tree.

Each audit records **two independent axes**, per `{{AUDIT-DEFINITION}}`:
whether the artifact complies with its own authoring rules, and whether
the codebase supports what it claims. They genuinely come apart, and
both are written. Never one agent per artifact outside the pool's
one-item feeds, and never a subagent inside a worker.

## Synthesize, then measure the assumptions

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
   ruling's public members per kind, rendered as plain member lists,
   never the ruling file itself, which is a verification record; and
   the prior release's published documentation corpus (its
   publishable layer only), where one exists. Nothing else enters:
   decisions are developer material, and audits, the ruling file, the
   experiments, sprints, issues, sketches, history, code, and tests
   all stay out.
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
through the ruled public surface, affirmative-only warrants,
conclusions never carrying. A measured assumption's record closes
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

## Check

One mechanical floor, and it is deterministic: run
`.ok-planner/bin/audit-check`. If the project has not converged, fall
back to the payload's `scripts/audit-check` and **record the fallback
verbatim in the run report**, on its own line, before the findings:
`note: no vendored checker — using the payload's copy; /ok pins one to
this project`. An unpinned verdict is never delivered silently.

The checker validates, across every estate that carries a corpus: audit
coverage, the audit files' shape on both axes, one-paragraph brevity,
the coverage shape's counts agreeing with the implementation verdict,
that each catalog's table of contents lists exactly its collection's
live slugs (the backstop `concept:catalog-toc` names), the
**assumption corpus** — every record under `audits/assumptions/`
carrying the record shape and one of the three dispositions — and,
where a surface ruling exists, the ruling itself: both anchors present,
the partition total against the cached extraction (no unclassified
member), and the recorded guidance hash agreeing with the guidance
file as of the stamped commit. At close it also checks the run report
exists at its archive path. Nothing else. A finding means the judge or
the surface determination left something unfinished; re-dispatch that
stage rather than editing a record by hand. Do not re-derive its
checks by reading; its output is authoritative.

**Annotation integrity** rides here too:
`rg -n '@(concept|story|decision):\s*\S+'` across the codebase; every
(kind, slug) pair must resolve to
`.ok-planner/design/<collection>/<slug>.md`. Dangling and kind-mismatched
annotations are mechanical findings — repoint to the renamed slug,
correct the kind prefix, or remove one pointing at a retired artifact.

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
Surface: <N elements over K kinds, P public / Q private; what the
walk settled, or "settled — passed silently">
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
   surface ruling and extraction, the walk's transcriptions into the
   guidance and the declaration, the committed member lists at
   `.ok-planner/surface/members/`, the experiments' changes, the run
   report, and any issue files, with a message naming the run and its
   counts.
2. Stamp that commit's short sha into every audit's `commit:` field,
   every assumption record's, the ruling's `commit` anchor, and the
   run report's `<sha>` name segment and body, and make one small
   follow-on commit. Each record then names the commit whose tree
   holds both the code it describes and the record itself — the same
   shape the sprint close-out's `closed:` stamp uses.

**The staleness rule consumers key on:** this run's output paths are
`.ok-planner/audits/` (the assumption records included),
`.ok-planner/experiments/`, `.ok-planner/issues/`,
`.ok-planner/history/audits/` (the run report),
`.ok-planner/surface/guidance.md` and
`.ok-planner/surface/surface.json` (the walk's transcriptions), and
`.ok-planner/surface/members/` (the derived member lists). The audit
is current for a later tree exactly when the diff from its stamped
commit touches only those paths — a path-scoped diff, no tracked
state.

Archive nothing else and offer nothing else: this run has no sprint,
and the issues it filed stay in the intake until a planning ceremony
closes them.

## Present

Only when the run was invoked à la carte: compose the owner's wrap-up
from the run report — the receipt's counts in a few lines, then what
deserves their eyes: the issues filed, the traps recorded, the judge's
overturns, and the driving observations that survived. Deliver it as
conversation, not by pasting the report. Invoked by `/document`, this
estate presents nothing — the run ends silently at the stamp, and
`/document`'s own wrap-up reads the same report.

## Boundaries

- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded in the
  audit file. There is no fixer, no architect, and no cycle cap,
  because there is no loop.
- **Files nothing of its own motion.** The judge and the distillation
  are this contribution's only filing paths. A defect the run
  discovers while driving — in the code, in a member list it derived,
  in the suite itself — is an escalation for the judge and a line in
  the run report, never written to `.ok-planner/issues/` directly.
  The opening surface walk is covered by the same rule, and says so
  where it runs.
- Does not run the project's test suites or build it; whether they pass
  is `/certify-work`'s business. The measurement instrument does
  execute the released product — through elements the ruling
  classifies public and through nothing else.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run; every experiment re-runs
  at this tree; the assumption set is re-synthesized whole.
- Does not touch `.ok-planner/design/`. The corpus's claims are the
  subject under audit, never the thing edited to make an audit pass.
- Writes the declaration and the guidance only as transcription of the
  owner's explicit answers in the opening walk: the guidance rules and
  notations the owner dictates, the kinds the owner adopts with their
  `reads`, and the member lists at `.ok-planner/surface/members/<kind>`
  together with the drift the owner accepts into them. It declares no
  kind and revises no derivation of its own motion; extraction
  proposes, only the owner declares.
- Does not read `.ok-planner/sprints/` or `history/`. Project records
  are out of context; the run report is append-only output into the
  archive, not a license to read what lives there.
- Does not ask the owner anything past the opening surface walk — the
  run's one interactive moment. After it, the run measures, judges,
  files, reports, and commits.
