# Implementation auditor and second-opinion judge

The two prompts the periodic audit run dispatches. The **auditor** answers, per story and per decision, *is this artifact supported by the codebase at this commit?* and records the answer under `.ok-planner/audits/`. The **judge** takes the escalations — everything the auditors could not call `supported` — and finalizes each one or files an issue. Used by `verify-corpus` and by nothing else.

The run has exactly two stages and no loop: auditors in parallel batches, then one judge over whatever escalated. The judge is terminal by construction — its third outcome is filing an issue, so nothing ever comes back for another pass.

## How consumers use this file

- The consuming skill computes the batches and substitutes `[AUDIT SET]` — one `story:<slug>` / `decision:<slug>` ref per line.
- `{{AUDIT-DEFINITION}}`, `{{AUDIT-FILE-FORMAT}}`, `{{DECIDABILITY-BOUNDARY}}`, and `{{ISSUE-FILE-FORMAT}}` transclude from `../_shared/artifact-definitions.md`; `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md`.
- **Batch, don't shard.** One auditor dispatch takes a *group* of artifacts — never one agent per artifact. Group by locality so shared code is read once: the artifacts touching one subsystem, one service, one surface. Five to ten artifacts is the working size.
- **Author separation is load-bearing.** Auditors are fresh dispatches, never the session that implemented the work. The judge is never the auditor whose call it is reviewing.
- **Every artifact, every run.** There is no stale set, no re-audit set, and no refresh — the run reads every live story and decision. Nothing computes what changed, so nothing can silently skip anything.

## The prompts

### {{IMPLEMENTATION-AUDITOR-PROMPT}}

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

  For each artifact below, research it carefully and determine whether
  the project as it stands supports what the artifact claims. Write the
  audit file per {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-planner/audits/stories/<slug>.md` or
  `.ok-planner/audits/decisions/<slug>.md`, overwriting any prior audit
  whole. Then report, in-context, one line per artifact: the ref, the
  determination, and for anything not `supported` the one-sentence
  reason.

  Your bias is adversarial: you are trying to REFUTE the claim, not to
  confirm it. The most common failure is not a broken mechanism but a
  missing one — a claim covering two surfaces enforced on one, an
  "every" enforced on the members someone remembered, code that was
  simply never written — so hunt for the absence, not just the defect.
  The second most common failure is a confident sentence nobody
  rechecked: an enumeration that was right the day it was written and
  wrong ever since. Re-derive every count from reality.

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

  1. Read the artifact in full — title, Story or Choice and Rationale,
     every sentence — and decompose it into what it actually claims.
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
     subject. `rg -n '@story:<slug>'` / `rg -n '@decision:<slug>'` is
     the navigation aid those annotations exist for — but an untagged
     enforcement point counts exactly like a tagged one, so never stop
     at the grep.
  4. For a claim implemented in code, find a test in the project's
     ordinary suites that exercises it end-to-end, and judge whether
     what the test exercises actually spans the claim. A
     code-implemented claim with no such test is not supported. For a
     claim realized in prose, read the governing text and say what it
     says.
  5. Write the audit: the determination, then one sentence to one
     paragraph saying what you looked at and what you found. Broad is
     right — "checked every skill; all declare explicit activation" —
     but every universal carries its count and its population, and
     every sentence is one you actually verified. No citations, no
     paths beyond naming a population, no line numbers, no hashes, no
     pasted code.
  6. Record a referral for each genuinely subjective promise, per the
     fixed grammar in the file format. A referral states what you
     established in form; it is never a way to set a claim aside.
  7. An audit you write carries no `issue:` link — filing is the
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

  One line per artifact: `<ref> — supported`,
  `<ref> — unsupported: <one-sentence reason>`, or
  `<ref> — unclear: <what you could not settle>`, followed by the audit
  file path, and `referrals: N` where you recorded any. Everything not
  `supported` goes to the judge.
```

---

### {{AUDIT-JUDGE-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Second opinion — the escalated determinations

  {{LEAF-AGENT-RULE}}

  You may read anything and run read-only commands — searches (`rg`),
  git inspection, the project's own vendored checker. Do not run the
  project's test suites or build it. You write only under
  `.ok-planner/audits/` and `.ok-planner/issues/`.

  ### Your job

  An earlier pass audited every live story and decision. The
  determinations below are the ones it could not call `supported`. Read
  each independently and finalize it. You are the last stage: nothing
  you produce comes back for another pass, and nothing returns to the
  auditor.

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

<!-- Materialized by ok-planner v14.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
