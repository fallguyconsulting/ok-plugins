# Implementation auditors and second-opinion judge

The prompts the periodic audit run dispatches, and nothing else uses. Every audit answers two independent questions per artifact — text compliance and implementation support — per `{{AUDIT-DEFINITION}}`; the instrument differs by kind. The **implementation auditor** reads decisions and concepts against the code. The **story auditor** measures stories by driving the released product through the public surface the run's extraction records, on the maintained experiments. The **assumption auditor** measures the run's synthesized assumptions on the same instrument; its outcome is a disposition, not a verdict. The **judge** finalizes every escalation: `unsupported` verdicts from either instrument, measured assumption contradictions, corpus contradictions from the surface extraction, and the orchestrator's driving observations.

The run has two stages and no loop: workers over every live artifact, then one judge over what escalated. Nothing comes back for another pass. Only the `implementation:` axis escalates; a `text:` defect is recorded, not judged.

The audit corpus and the intake are independent. When the judge finalizes `unsupported`, it files an intake issue by the ordinary conventions and stamps nothing back into the audit.

## How consumers use this file

- The consuming ceremony contribution computes the feed order and substitutes `[AUDIT SET]` — one `concept:<slug>` / `decision:<slug>` ref per line for the implementation auditor, one `story:<slug>` per line for the story auditor, one assumption slug per line for the assumption auditor — and, for the two measurement prompts, `[SURFACE]`: the public elements the run's extraction records at `.ok-planner/audits/surface/extraction.json` for the kinds the fed items drive. The prompts feed two ways. In batch mode `[AUDIT SET]` carries the whole batch at dispatch. In pool mode the worker is spawned with `[AUDIT SET]` reading `items arrive one at a time by message; stand by`, and each feed message carries one ref plus any `[SURFACE]` additions it needs; the worker treats a fed item as a listed one, reports its line on completion, and stands by.
- `{{AUDIT-DEFINITION}}`, `{{AUDIT-FILE-FORMAT}}`, `{{DECIDABILITY-BOUNDARY}}`, `{{CONCEPT-DEFINITION}}`, `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}`, `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, and `{{ISSUE-FILE-FORMAT}}` transclude from `../_shared/artifact-definitions.md`; `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md`.
- **Batch, don't shard.** One worker handles a stream of artifacts, never one agent per artifact. Route reading feeds by locality so shared code is read once; route measurement feeds by the surface elements the items drive so one setup serves consecutive items. In batch mode, five to ten artifacts per dispatch.
- **Author separation.** Auditors are fresh dispatches, never the session that implemented the work. The judge is never the auditor whose call it reviews.
- **Every artifact, every run.** No stale set, no re-audit set, no refresh. The run reads every live concept, story, and decision.

## The prompts

### {{IMPLEMENTATION-AUDITOR-PROMPT}}

The reading instrument, for decisions and concepts.

```
Agent (general-purpose, model: opus):
  ## Implementation audit

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands: searches (`rg`)
  and git inspection. Do not run the project's test suites, build
  it, or execute its stack. Your question is whether the code and
  tests exist and cover what the artifact claims, not whether the
  tests pass. Write nothing outside `.ok-planner/audits/`.

  ### Your job

  For each artifact below — decisions and concepts — answer two
  independent questions. `implementation:` — does the project as it
  stands carry what the artifact claims? `text:` — does the
  artifact's body satisfy its kind's authoring rules? Write the
  audit file per {{AUDIT-FILE-FORMAT}} to
  `.ok-planner/audits/<collection>/<slug>.md`, the collection
  mirroring the artifact's, overwriting any prior audit whole. Then
  report one line per artifact: the ref, both axes, and for
  `unsupported` the one-sentence reason.

  Settle each axis on its own. A body you had to squint at gets an
  honest implementation verdict; a well-written body gets an honest
  text verdict.

  Your bias is adversarial: try to refute the claim. The most common
  failure is a missing mechanism, not a broken one — a claim over
  two areas enforced on one, an "every" enforced on the members
  someone remembered, code never written. Look for the absence. The
  second most common is an enumeration that was right when written
  and wrong since. Re-derive every count from reality.

  ### The `text:` axis

  `compliant` — the body satisfies the authoring rules for its
  kind. `noncompliant` — it does not: name the rule and the
  compliant text in `## Compliance`. Judge form against the rules
  reproduced below and nothing else. A body you would have written
  differently is not thereby noncompliant; prose style is never a
  defect. Qualitative language in a story is not a form violation,
  per the decidability boundary. This axis never escalates.

  {{CONCEPT-DEFINITION}}

  {{DECISION-DEFINITION}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### The `implementation:` axis

  - `supported` — you found what the artifact claims and can say so
    in your own words.
  - `unsupported` — the codebase does not carry the claim: absent,
    partial, contradicted, or the artifact's text does not settle
    what would count as support. Say what is missing, or what the
    artifact leaves undecidable.

  Every `unsupported` goes to a second-opinion judge who reads
  independently. Never call something `supported` you did not check.
  Research first; escalate what does not resolve.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  ### Method

  1. Read the artifact in full — a decision's Choice and Rationale,
     a concept's What it is, Purpose, and Boundaries — and decompose
     every sentence into what it claims. Read a concept as
     vocabulary: it has one live name, and the sites that cite it
     and the code around them agree with its What it is and its
     Boundaries. Its Purpose carries no determination. Classify
     each claim per the decidability boundary: decidable claims
     carry your verdict; a subjective one becomes a referral.
  2. For every quantifier (every, all, each, never, none, only, no
     ...): enumerate the population from reality — the filesystem,
     the route registrations, the interface's implementors — never
     from the artifact's examples and never from what the enforcing
     code covers. Check each member. Report the count and where the
     set came from.
  3. Locate the enforcing code by reading outward from the claim's
     subject. `rg -n '@concept:<slug>'` / `rg -n '@decision:<slug>'`
     is the navigation aid; an untagged enforcement point counts the
     same as a tagged one, so never stop at the grep.
  4. For a claim implemented in code, find a test in the project's
     ordinary suites that exercises it end-to-end, and judge whether
     the test spans the claim. A code-implemented claim with no such
     test is not supported. For a claim realized in prose, read the
     governing text and say what it says.
  5. Read the body once more against the authoring rules above and
     settle `text:`. It is a reading of the file, never of the code,
     independent of steps 2–4.
  6. Where the artifact names an enumerable population and claims
     the whole of it, use the coverage shape: `checked:` and
     `unaccounted:` in the frontmatter, every unaccounted member
     under `## Unaccounted`, agreeing with the implementation
     verdict.
  7. Write the audit: the verdict, then one sentence to one
     paragraph on what you looked at and found. Broad is right —
     "checked every skill; all declare explicit activation" — with
     every universal carrying its count and population, and every
     sentence one you verified. No citations, no paths beyond naming
     a population, no line numbers, no hashes, no pasted code.
  8. Record a referral for each subjective promise, per the fixed
     grammar in the file format. A referral states what you
     established in form; it never sets a claim aside.
  9. The audit carries no `issue:` field.

  ### Artifacts to audit

  [AUDIT SET]

  ### Rules

  - Never soften an implementation verdict because the fix looks
    hard, the gap looks old, or the tests are green. "The tests
    pass" is not "the claim is true."
  - Never edit code, design artifacts, or issues.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per artifact, carrying both axes:
  `<ref> — supported | compliant`,
  `<ref> — unsupported | compliant: <one-sentence reason>`, or
  `<ref> — unsupported | noncompliant (<the rule broken>): <the
  reason>`, followed by the audit file path, and `referrals: N`
  where you recorded any. Every `unsupported` goes to the judge;
  nothing noncompliant does.
```

---

### {{STORY-AUDITOR-PROMPT}}

The measurement instrument, for stories. A story is `supported` only when passing experiments driven through elements the run's surface extraction records public demonstrate the capability and the benefit.

```
Agent (general-purpose, model: opus):
  ## Story audit — user-vantage measurement

  {{LEAF-AGENT-RULE}}

  You may read anything, run read-only commands, and execute the
  released product **through its public surface**: the elements
  listed under "The public surface" below, and nothing else. Never
  invoke an internal entry point, an unexported module, or a private
  helper to settle a story. Do not run the project's test suites;
  a test may reach behind the surface, so tests are never warrants
  for a story, though reading them may steer a diagnosis. Write only
  under `.ok-planner/audits/stories/` and `.ok-planner/experiments/`.

  ### Your job

  For each story below, answer two independent questions.
  `implementation:` — can a user obtain the promised capability and
  benefit through the public surface, demonstrated by passing runs?
  `text:` — does the story's body satisfy its authoring rules? Write
  the audit file per {{AUDIT-FILE-FORMAT}} to
  `.ok-planner/audits/stories/<slug>.md`, overwriting any prior
  audit whole. Then report one line per story plus your experiments
  ledger.

  ### The instrument: the maintained experiments

  The experiments live at `.ok-planner/experiments/`, one per
  directory: the runnable files plus a `record.md` (frontmatter
  `experiment:`, `commit:`; body: what it ran against, what was
  observed, quantities named). Conclusions never carry: an archived
  experiment warrants nothing until re-run at this tree.

  **Every experiment is self-contained.** Its directory holds
  everything it needs beyond what an end user already has: the
  released product, its public surface, and stock tooling. It
  imports nothing from the project's source or test code, and
  nothing shared with another experiment — no helper module, no
  `_lib`, no common fixture. Two experiments that need the same
  steps each carry their own copy. A project keeps no shared code
  whose only use is its experiments. An experiment that seems to
  need such code is reaching behind the surface: rewrite it to drive
  the surface as a user would.

  **An archived experiment is a starting point, never a warrant.**
  Use what is there, and satisfy yourself it still drives the way
  before its run counts. The tree changes after an experiment is
  written: a helper matches a name the surface no longer spells that
  way, a selector reads an artifact whose shape changed, a route it
  swept is gone. A drifted instrument rarely fails. It measures a
  smaller claim, or nothing at all, and exits zero.

  Per story:

  1. Identify the story's ways — the concrete paths through the
     public surface by which a user obtains the capability and
     benefit.
  2. For each way, find the archived experiment covering it. Read it
     before you run it: what it drives, what it selects, and what
     its `record.md` says it observed last time. Then decide. Sound
     → run it at this tree. Drifted in any part → repair it first
     and say what you repaired. Uncovered → build a new experiment.
     Surface elements gone from the extraction → retire the
     experiment and treat the way as gone.
  3. Run it, then read what it did. A passing run proves what the
     run drove and no more. Establish that what it drove is the
     story's way at this tree: name the elements it exercised and,
     where it sweeps a population, the size of the population it
     swept. A run over an empty or shrunken population proves
     nothing about the way — repair the instrument and run again.
     Craftsmanship does not decide this: a scrappy experiment that
     drives the way is proof, and a polished one that drives nothing
     is not.
  4. Compare what you observed against what the `record.md` says the
     last run observed. Account for every divergence before you
     write the audit — the product changed, the surface changed, or
     the instrument drifted. The prior observation tells you where
     to look. It never stands as proof.
  5. A failing run is never a finding; it dispatches diagnosis:
     stale probe (repair and re-run), wrong probe (rebuild and
     re-run), or wrong claim (the story is not supported as
     written — say what the product did).
  6. Update each experiment's `record.md` with what it ran against
     and what was observed at this tree, quantities named: the
     elements driven, and the size of every population swept. The
     next run reads what you write to see whether the instrument
     still measures what it measured here.

  Never settle a story by reading or by citing a test. Reading
  locates surface elements, steers repair, and diagnoses failures;
  the determination rests on runs.

  ### Obtaining the deployment state an experiment needs

  Some experiments need the deployment in a state it is not in — a
  founding transition needs an unfounded deployment, an upgrade
  needs one pinned to an earlier release. Obtaining that state is
  the run's job. Decide by this order every time:

  1. **Drive the deployment already running** when the experiment's
     precondition holds against it.
  2. **Reset that deployment** when the experiment needs a state the
     project's own teardown produces. The project states how; the
     harness's error messages usually name the command. A reset
     destroys every other experiment's session, so run every
     reset-requiring experiment first, before any run that founds,
     seeds, or otherwise dirties the deployment.
  3. **Provision a second deployment** only when neither works: the
     experiment drives two deployments at once, or needs a state
     resetting cannot produce.

  Whether the product offers a way back to a state is a question
  about the product. Whether this run can obtain a deployment in
  that state is a question about the harness. Answer them
  separately.

  A precondition the run cannot meet is a blocker, not a
  measurement. Escalate it to the judge, naming what stopped the run
  and which of the three routes were tried, and say in the audit
  body that the run observed nothing. Never write an audit that
  reads as a product failure when nobody drove the product.

  ### The `text:` axis

  `compliant` — the body satisfies the story rules reproduced below.
  `noncompliant` — it does not: name the rule and the compliant text
  in `## Compliance`. This axis grades the story's writing, never
  the code, independent of the measurement. Qualitative language is
  not a form violation, per the decidability boundary; where the
  promise rests on a human discipline's judgment, record a referral.
  This axis never escalates.

  {{STORY-DEFINITION}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### The `implementation:` axis

  - `supported` — passing runs through the public surface
    demonstrate the capability and the benefit.
  - `unsupported` — a run demonstrates the product not delivering
    the promise, no way through the public surface reaches it, or
    the story does not settle what a demonstrating run would look
    like. Say what was attempted and what happened, or what the
    story leaves undecidable. Diagnose failing runs before
    concluding.

  Every `unsupported` goes to a second-opinion judge who examines
  your runs independently. Never call a story `supported` on a run
  you did not take.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  ### The public surface

  [SURFACE]

  ### Stories to audit

  [AUDIT SET]

  ### Rules

  - Never soften an implementation verdict because the fix looks
    hard or the project's tests are green. "The tests pass" is not
    "a user can obtain it."
  - Never edit code, design artifacts, or issues. The experiments
    are yours to maintain; nothing else is.
  - The audit carries no `issue:` field.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per story, carrying both axes as the implementation
  auditor reports, plus the way count measured and the experiments
  that warranted it. Then the experiments ledger: re-run / repaired
  / built / retired, by slug, and which built ones pass at this tree.
  Every `unsupported` goes to the
  judge; nothing noncompliant does.
```

---

### {{ASSUMPTION-AUDITOR-PROMPT}}

The measurement instrument, for the run's synthesized assumptions. The claim is a prior the user would hold, not a promise the owner made. The outcome is a **disposition** on the assumption record: no implementation verdict, no `text:` axis.

```
Agent (general-purpose, model: opus):
  ## Assumption audit — user-vantage measurement

  {{LEAF-AGENT-RULE}}

  You may read anything, run read-only commands, and execute the
  released product **through its public surface**: the elements
  listed under "The public surface" below, and nothing else. Never
  reach behind the surface, and never run the project's test
  suites. Write only under `.ok-planner/audits/assumptions/` and
  `.ok-planner/experiments/`.

  ### Your job

  Each record below is an assumption this run synthesized: a prior a
  reasonable user would hold about the product, written before
  anyone checked it. Measure each as a story is measured —
  experiments driven through the public surface, per the
  maintained-experiments protocol (read each covered experiment
  before running it, repair what no longer drives its claim, build
  uncovered, retire orphaned; update each `record.md`) — and close
  its record with what the runs showed. A passing run proves what
  the run drove and no more; conclusions never carry.

  ### The dispositions

  Update the record's `disposition:` field and append a paragraph
  saying what was run and what was observed:

  - `held` — passing runs demonstrate the product honoring the
    prior. Not a finding.
  - `trap` — a run demonstrates the product contradicting the
    prior. State what a user would expect and what happens. This
    escalates: the judge confirms every trap.
  - `unverified` — no run through the public surface can observe
    the prior either way. Say why.

  Nothing here is a defect and nothing files; nothing was promised.
  A contradicted assumption is material for the trap registry, not
  work. Where your diagnosis of a contradiction shows a story's
  promise is also violated, say so in your report line; routing it
  to the story track is the orchestrator's job.

  ### The public surface

  [SURFACE]

  ### Assumptions to measure

  [AUDIT SET]

  ### Rules

  - Never soften a disposition, and never reword the assumption to
    match what you found. The prior was written before measurement
    so it could not move.
  - Never edit code, design artifacts, or issues. The experiments
    are yours to maintain; nothing else is.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per assumption: the slug, the disposition, and for a trap
  or an unverified the one-sentence reason, plus any story a trap's
  diagnosis implicates. Then your experiments ledger, as the story
  auditor reports it.
```

---

### {{AUDIT-JUDGE-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Second opinion — the escalated verdicts

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands: searches (`rg`)
  and git inspection. Do not run the project's test suites or build
  it. For a story or assumption escalation you may run the archived
  experiments at `.ok-planner/experiments/`, through the public
  surface only, as the measuring auditor was bound. Write only under
  `.ok-planner/audits/` and `.ok-planner/issues/`.

  ### Your job

  An earlier pass audited every live artifact — decisions and
  concepts by reading, stories and synthesized assumptions by
  measurement through the public surface — while the surface
  extraction read reality and the orchestrator drove. The
  escalations below are everything the run could not settle; each is
  marked with its kind and the instrument that produced it. Read
  each independently and finalize it. For a measured story or
  assumption, examine the experiment and its recorded run, and
  re-run it where the recorded observation does not settle your
  doubt; never substitute a reading for the measurement. You are the
  last stage: nothing returns to the auditor.

  **A story, decision, or concept `unsupported` verdict** gets one of
  two outcomes:

  - **Confirmed** — the gap is real. Leave `implementation:
    unsupported`, rewrite the audit's paragraph in your own words
    where the auditor's does not state the absence plainly, and file
    an intake issue per {{ISSUE-FILE-FORMAT}} (kind `audit`). Stamp
    nothing back into the audit. Where the artifact's own text makes
    support undecidable, the confirmed gap is that: file the issue
    asking the owner to settle the artifact, and say so in the
    audit's paragraph.
  - **Overturned** — the support is there and the auditor missed it:
    wrong place, a subjective clause read as decidable, the
    artifact's scope misjudged. Rewrite the audit whole with
    `implementation: supported` and your own paragraph. No issue.

  **An assumption contradiction** files nothing either way:

  - **Confirmed** — the product contradicts the prior. The record's
    `disposition: trap` stands; rewrite its paragraph where the
    auditor's does not state the contradiction plainly. Where your
    diagnosis shows a story's promise is also violated, treat that
    story as a confirmed gap on its own track, as above.
  - **Overturned** — the runs, examined or re-run, show the prior
    honored or the probe wrong. Rewrite the record with
    `disposition: held` (or `unverified` where no run can observe
    it) and your own paragraph.

  **An extraction contradiction or a driving observation** — an
  artifact's claimed posture against observed reality, or a defect
  the orchestrator noticed while driving:

  - **Confirmed** — verify it against the tree yourself, then file
    an intake issue per {{ISSUE-FILE-FORMAT}} (category
    `conflicting` for a posture contradiction), stating the defect
    first, then the claim and the evidence.
  - **Refuted** — return it with your reason, for the run report.
    Nothing is filed or recorded.

  ### What you are handed

  Per escalation: the artifact (or, for an extraction contradiction
  or driving observation, the claim itself), and the escalating
  paragraph as a claim under test — not a starting position, not
  evidence. Read the code yourself before ruling. Rewrite every
  audit you touch whole per {{AUDIT-FILE-FORMAT}}.

  **Only the `implementation:` axis is yours.** Carry the `text:`
  axis, its `## Compliance` section, and any coverage counts through
  unchanged. A form defect is mechanical and never escalated.

  **Start with the counts.** Where the artifact quantifies over a
  population, re-derive the number and the membership from reality
  before anything else.

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  {{ISSUE-FILE-FORMAT}}

  ### Rules

  - Fix nothing. A confirmed gap becomes an issue for the owner and
    a sprint to close.
  - Re-audit nothing that came back `supported`. Your scope is the
    escalations you were handed.
  - Leave no escalation without an outcome.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per escalation: `<ref> — confirmed unsupported (<issue
  slug>)`, `<ref> — overturned to supported: <what the auditor
  missed>`; for an assumption, `<slug> — trap confirmed` /
  `<slug> — overturned to held`; for a contradiction or observation,
  `confirmed (<issue slug>)` / `refuted: <why>`. Then the issue
  files you wrote, by path.
```

<!-- Materialized by ok-planner v19.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
