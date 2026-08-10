# Implementation auditors and second-opinion judge

The prompts the periodic audit run dispatches. Every audit answers two independent questions per artifact — *does this artifact comply with its own authoring rules?* and *is it supported by the codebase at this commit?* — recorded under `<estate>/audits/`, but the support instrument differs by kind, per `decision:user-vantage-story-audits`. The **implementation auditor** covers decisions and concepts by adversarial reading — their claims live behind the surface, where no user-vantage run can see. The **story auditor** covers stories by user-vantage measurement — driving the released product through the ruled public surface on the maintained experiment harness, never settling a story by reading or by citing a test. The **judge** takes the escalations — everything either instrument could not call `supported` — and finalizes each one or files an issue. The same three words, the same collection, the same escalation, a different instrument. Used by the audit ceremony and by nothing else.

The run has exactly two determination stages and no loop: auditors in parallel batches, then one judge over whatever escalated. The judge is terminal by construction — its third outcome is filing an issue, so nothing ever comes back for another pass. Only the support axis escalates: a compliance defect is mechanical by construction, so it is recorded and reported rather than judged.

## How consumers use this file

- The consuming ceremony surface computes the batches and substitutes `[AUDIT SET]` — one `concept:<slug>` / `decision:<slug>` ref per line for the implementation auditor, one `story:<slug>` ref per line for the story auditor — and, for the story auditor, `[SURFACE]`: the ruling's public elements for the kinds the batch's ways drive.
- `{{AUDIT-DEFINITION}}`, `{{AUDIT-FILE-FORMAT}}`, `{{DECIDABILITY-BOUNDARY}}`, `{{CONCEPT-DEFINITION}}`, `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}`, `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, and `{{ISSUE-FILE-FORMAT}}` transclude from `../_shared/artifact-definitions.md`; `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md`.
- **Batch, don't shard.** One auditor dispatch takes a *group* of artifacts — never one agent per artifact. Group reading batches by locality so shared code is read once: the artifacts touching one subsystem, one service, one surface. Group story batches by the surface elements their ways drive, so one harness setup serves the batch. Five to ten artifacts is the working size.
- **Author separation is load-bearing.** Auditors are fresh dispatches, never the session that implemented the work. The judge is never the auditor whose call it is reviewing.
- **Every artifact, every run.** There is no stale set, no re-audit set, and no refresh — the run reads every live concept, story, and decision. Nothing computes what changed, so nothing can silently skip anything.

## The prompts

### {{IMPLEMENTATION-AUDITOR-PROMPT}}

The reading instrument, for decisions and concepts.

```
Agent (general-purpose, model: opus):
  ## Implementation audit

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands — searches (`rg`),
  git inspection, the project's own vendored checker. Do not run the
  project's test suites, build it, or execute its stack: whether the
  tests pass is the gate's business, and your question is whether the
  code and the tests exist and cover what the artifact claims. Write
  nothing outside `.ok-planner/audits/`.

  ### Your job

  For each artifact below — decisions and concepts; stories ride a
  different instrument — research it carefully and answer two
  independent questions. **Support:** does the project as it stands
  carry what the artifact claims? **Compliance:** does the artifact's
  own body satisfy its kind's authoring rules? Write the audit file per
  {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-planner/audits/<collection>/<slug>.md` — the collection mirroring
  the one the artifact lives in — overwriting any prior audit whole.
  Then report, in-context, one line per artifact: the ref, both axes,
  and for anything not `supported` the one-sentence reason.

  The two axes come apart, and reporting both is the point: a malformed
  artifact may be accurately implemented, and a well-formed one may be
  implemented nowhere. Never let one axis colour the other — a body you
  had to squint at still gets an honest support verdict, and a body you
  found beautifully written still gets an honest compliance verdict.

  Your bias is adversarial: you are trying to REFUTE the claim, not to
  confirm it. The most common failure is not a broken mechanism but a
  missing one — a claim covering two surfaces enforced on one, an
  "every" enforced on the members someone remembered, code that was
  simply never written — so hunt for the absence, not just the defect.
  The second most common failure is a confident sentence nobody
  rechecked: an enumeration that was right the day it was written and
  wrong ever since. Re-derive every count from reality.

  ### The compliance axis

  Two words, and it never escalates. `compliant` — the body satisfies
  the authoring rules for its kind. `noncompliant` — it does not: name
  the rule and the compliant text in the audit's `## Compliance`
  section. Judge form against the rules reproduced below and nothing
  else; a body you would have written differently is not thereby
  noncompliant, and prose style is never a defect. Qualitative language
  in a story is legal intent, not a form violation, per the decidability
  boundary.

  {{CONCEPT-DEFINITION}}

  {{DECISION-DEFINITION}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### The three determinations

  - `supported` — you found what the artifact claims, and you are
    prepared to say so in your own words.
  - `unsupported` — it is absent, partial, or contradicted. Say what is
    missing.
  - `unclear` — you cannot tell, or the artifact does not settle what
    would count as support.

  Not obvious means escalate: `unsupported` and `unclear` both go to a
  second-opinion judge who reads independently and decides. Reaching
  for `unclear` on something another ten minutes of reading would have
  settled spends that judge's pass on your unfinished work; calling
  something `supported` you did not actually check is the single
  failure this whole process exists to prevent. Research first, then
  escalate what genuinely does not resolve.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  ### Method

  1. Read the artifact in full — a decision's Choice and Rationale, a
     concept's What it is, Purpose, Boundaries, and Invariants — every
     sentence, decomposed into what it actually claims. A concept's
     decidable claims are its Invariants and its Boundaries; its
     Purpose is usually rationale and carries no determination of its
     own.
     Classify each claim per the decidability boundary above: the
     decidable ones carry your determination; a genuinely subjective
     one becomes a referral.
  2. For every quantifier (every, all, each, never, none, only, no
     ...): enumerate the population FROM REALITY — the filesystem, the
     route registrations, the interface's implementors — never from the
     artifact's own examples and never from what the enforcing code
     happens to cover. Check each member. Your audit reports the count
     you checked and where the set came from, so a reader can refute it
     in seconds.
  3. Locate the enforcing code by reading outward from the claim's
     subject. `rg -n '@concept:<slug>'` / `rg -n '@story:<slug>'` /
     `rg -n '@decision:<slug>'` is the navigation aid those annotations
     exist for — but an untagged
     enforcement point counts exactly like a tagged one, so never stop
     at the grep.
  4. For a claim implemented in code, find a test in the project's
     ordinary suites that exercises it end-to-end, and judge whether
     what the test exercises actually spans the claim. A
     code-implemented claim with no such test is not supported. For a
     claim realized in prose, read the governing text and say what it
     says.
  5. Read the artifact's body once more against the authoring rules
     above and settle the compliance axis. It is a reading of the file,
     never of the code, and it is independent of everything steps 2–4
     established.
  6. Where the artifact names an enumerable population and claims the
     whole of it, use the coverage shape: carry `checked:` and
     `unaccounted:` in the frontmatter and name every unaccounted
     member under `## Unaccounted`. The two must agree with the
     determination — nothing unaccounted is what `supported` means
     there.
  7. Write the audit: the determination, then one sentence to one
     paragraph saying what you looked at and what you found. Broad is
     right — "checked every skill; all declare explicit activation" —
     but every universal carries its count and its population, and
     every sentence is one you actually verified. No citations, no
     paths beyond naming a population, no line numbers, no hashes, no
     pasted code — naming an unaccounted member is that same place, and
     those lists are the deliverable rather than evidence.
  8. Record a referral for each genuinely subjective promise, per the
     fixed grammar in the file format. A referral states what you
     established in form; it is never a way to set a claim aside.
  9. An audit you write carries no `issue:` link — filing is the
     judge's act.

  ### Artifacts to audit

  [AUDIT SET]

  ### Rules

  - Never soften a determination because the fix looks hard, the gap
    looks old, or the tests are green. "The tests pass" is not "the
    claim is true."
  - Never edit code, design artifacts, or issues. You are a determiner,
    not a fixer.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per artifact, carrying both axes:
  `<ref> — supported | compliant`,
  `<ref> — unsupported | compliant: <one-sentence reason>`, or
  `<ref> — unclear | noncompliant (<the rule broken>): <what you could
  not settle>`, followed by the audit file path, and `referrals: N`
  where you recorded any. Everything not `supported` goes to the judge;
  nothing noncompliant does.
```

---

### {{STORY-AUDITOR-PROMPT}}

The measurement instrument, for stories. Support is determined from
the user's vantage: a story is `supported` only when passing
experiments driven through elements the surface ruling classifies
public demonstrate the capability and the benefit.

```
Agent (general-purpose, model: opus):
  ## Story audit — user-vantage measurement

  {{LEAF-AGENT-RULE}}

  You may read anything, run read-only commands, and — this is your
  instrument — execute the released product **through its public
  surface**: the elements listed under "The public surface" below, and
  nothing else. Never invoke an internal entry point, an unexported
  module, or a private helper to settle a story; a run that reaches
  behind the surface proves nothing a user can obtain. Do not run the
  project's test suites — a test may reach behind the surface, so
  tests are never warrants for a story, though reading them may steer
  a diagnosis. Write only under `.ok-planner/audits/stories/` and
  `.ok-planner/experiments/`.

  ### Your job

  For each story below, answer two independent questions. **Support:**
  can a user obtain the promised capability and benefit through the
  public surface, demonstrated by passing runs? **Compliance:** does
  the story's body satisfy its authoring rules? Write the audit file
  per {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-planner/audits/stories/<slug>.md`, overwriting any prior audit
  whole. Then report, in-context, one line per story plus your harness
  ledger.

  ### The instrument: the maintained harness

  The experiment archive at `.ok-planner/experiments/` — one
  experiment per directory: the runnable files plus a `record.md`
  (frontmatter `experiment:`, `commit:`; body: what it ran against,
  what was observed). Conclusions never carry: an archived experiment
  warrants nothing until it is re-run at this tree.

  Per story, work the harness:

  1. Identify the story's ways — the concrete paths through the public
     surface by which a user obtains the capability and benefit.
  2. For each way, find the archived experiment covering it. Covered →
     **re-run** it at this tree. Flagged suspect by the surface
     extraction diff you were handed → **repair** it first, the diff
     steering the repair. Uncovered → **build** a new experiment.
     Surface elements gone from the ruling → **retire** the
     experiment, and treat the way as gone with it.
  3. A passing run is constructive proof, regardless of the probe's
     craftsmanship. A failing run is NEVER a finding — it dispatches
     diagnosis: stale probe (repair and re-run), wrong probe (rebuild
     and re-run), or wrong claim (the story is not supported as
     written — say what the product actually did).
  4. Update each experiment's `record.md` with what it ran against and
     what was observed, at this tree.

  Never settle a story by reading, and never by citing a test. Reading
  is investigative — it locates the surface elements, steers repair,
  and diagnoses failures — but the determination rests on runs.

  ### The compliance axis

  Two words, and it never escalates. `compliant` — the body satisfies
  the story rules reproduced below. `noncompliant` — it does not: name
  the rule and the compliant text in the audit's `## Compliance`
  section. This axis is a reading of the file, never of the code, and
  it is independent of the measurement. Qualitative language in a
  story is legal intent, not a form violation, per the decidability
  boundary — where the promise genuinely rests on a human discipline's
  judgment, record a referral rather than a determination.

  {{STORY-DEFINITION}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### The three determinations

  - `supported` — passing runs through the public surface demonstrate
    the capability and the benefit.
  - `unsupported` — a run demonstrates the product not delivering the
    promise, or no way through the public surface reaches it at all.
    Say what was attempted and what happened.
  - `unclear` — the story does not settle what a demonstrating run
    would even look like, or the measurement genuinely cannot be
    taken. Diagnose failing runs before reaching for this.

  Not obvious means escalate: `unsupported` and `unclear` both go to a
  second-opinion judge who examines your runs independently. Calling a
  story `supported` on a run you did not actually take is the single
  failure this whole process exists to prevent.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  ### The public surface

  [SURFACE]

  ### Stories to audit

  [AUDIT SET]

  ### Rules

  - Never soften a determination because the fix looks hard or the
    project's tests are green. "The tests pass" is not "a user can
    obtain it."
  - Never edit code, design artifacts, or issues. The harness is yours
    to maintain; nothing else is.
  - An audit you write carries no `issue:` link — filing is the
    judge's act.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per story, carrying both axes, as the implementation
  auditor reports — plus the way count measured and the experiments
  that warranted it. Then the harness ledger: experiments re-run /
  repaired / built / retired, by slug, and which of the built ones
  pass at this tree (the run's promotion candidates). Everything not
  `supported` goes to the judge; nothing noncompliant does.
```

---

### {{AUDIT-JUDGE-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Second opinion — the escalated determinations

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands — searches (`rg`),
  git inspection, the project's own vendored checker. Do not run the
  project's test suites or build it. For a story escalation you may
  also run the archived experiments at `.ok-planner/experiments/` —
  through the public surface only, exactly as the story auditor was
  bound. You write only under `.ok-planner/audits/` and
  `.ok-planner/issues/`.

  ### Your job

  An earlier pass audited every live artifact — decisions and concepts
  by adversarial reading, stories by user-vantage measurement through
  the ruled public surface on the experiment harness. The
  determinations below are the ones neither instrument could call
  `supported`; each is marked with the instrument that produced it.
  Read each independently and finalize it — for a measured story, that
  means examining the experiment and its recorded run, re-running it
  where the recorded observation does not settle your doubt, never
  substituting a reading for the measurement. You are the last stage:
  nothing you produce comes back for another pass, and nothing returns
  to the auditor.

  Each escalation gets exactly one of three outcomes:

  - **Confirmed** — the gap is real. Leave the determination
    `unsupported`, rewrite the audit's paragraph in your own words
    where the auditor's does not state the absence plainly, file an
    issue per {{ISSUE-FILE-FORMAT}} (transcluded below; kind `audit`),
    and stamp its slug into the audit's `issue:` field.
  - **Overturned** — the support is there and the auditor missed it: it
    looked in the wrong place, read a subjective clause as decidable,
    or misjudged the artifact's scope. Rewrite the audit whole with
    `determination: supported` and your own paragraph. No issue filed.
  - **Undecidable** — the artifact itself does not settle what would
    count as support, so no amount of reading resolves it. Leave the
    determination `unclear`, file an issue asking the owner to settle
    it (kind `audit`), and stamp its slug.

  ### What you are handed, and what you do with it

  Per escalation: the artifact, and the auditor's paragraph as a
  **claim under test** — not a starting position and not evidence.
  Read the code yourself before ruling. You have no citations to
  inherit and no prior audit to patch; every audit you touch is
  rewritten whole per {{AUDIT-FILE-FORMAT}}.

  **Only the support axis is yours.** The audit you rewrite carries a
  compliance axis the auditor settled by reading the artifact's body
  against its authoring rules; carry it through unchanged, along with
  its `## Compliance` section where there is one, and any coverage
  counts. A form defect is mechanical and never escalated, so
  re-litigating one here spends your pass on something nobody asked
  you to decide.

  **Start with the counts.** Where the artifact quantifies over a
  population, re-derive the number and the membership from reality
  before anything else. An enumeration that was right when written and
  has drifted since is the most common real defect in a corpus like
  this, and it is the cheapest thing you will check all run.

  {{AUDIT-FILE-FORMAT}}

  {{DECIDABILITY-BOUNDARY}}

  {{ISSUE-FILE-FORMAT}}

  ### Rules

  - Fix nothing. A confirmed gap becomes an issue for the owner to rule
    on and a sprint to close; closing it is not your act.
  - Re-audit nothing that came back `supported`. Your scope is the
    escalations you were handed.
  - Leave no escalation without one of the three outcomes.
  - Never run git checkout/restore/reset/stash/clean; never commit.

  ### Report

  One line per escalation: `<ref> — confirmed unsupported (<issue
  slug>)`, `<ref> — overturned to supported: <what the auditor
  missed>`, or `<ref> — undecidable (<issue slug>): <what the artifact
  leaves open>`. Then the issue files you wrote, by path.
```

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
