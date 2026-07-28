# Implementation auditor prompt

Canonical prompt body for the adversarial implementation auditor — the certification producer that answers, per story and per decision, *does the project implement what this artifact claims?* — and records the answer durably under `.ok-planner/audits/`. Used by `certify-work` (scoped to the re-audit set: the mechanical stale set plus the change inspector's nominations) and `certify-all` (every live artifact). Both gates dispatch the same prompt; only `[AUDIT SET]` differs. The auditor is also the sole adjudicator of the inspector's provisional notes: nominations are candidacy, and this prompt is where they are promoted into citations or dismissed with reasons.

## How consumers use this file

- The consuming gate computes the audit set and substitutes `[AUDIT SET]` — one `story:<slug>` / `decision:<slug>` ref per line.
- `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` transclude from `../_shared/artifact-definitions.md`; `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md`.
- **Batch, don't shard.** One auditor dispatch takes a *group* of artifacts — never one agent per artifact. Group by locality so shared code is read once: the artifacts touching one subsystem, one service, one surface. A batch of five to ten artifacts is the working size; a whole-corpus run is a handful of batched dispatches, parallelizable across groups, not a swarm.
- **Split by triage class, price by the job.** The consuming gate splits its audit set before dispatching: refs whose design artifact hash moved, which carry inspector nominations, or which have no audit yet are **full-pass batches** (the model stated in the prompt header); refs stale only because a cited or pinned hash moved — and refs in scope only for coverage (a whole-corpus revisit whose standing record is intact) — are **refresh batches**, dispatched with the same prompt at `model: sonnet-5`. The triage inside the prompt governs either way — a refresh batch that finds changed bytes touching a claim's territory does not deep-read on the cheap model; it reports that ref back as `escalate: <ref> — <why>` and the gate re-dispatches it in a full-pass batch.
- **Author separation is load-bearing:** the auditor is always a fresh dispatch, never the session that implemented the work under audit, and the fixer never edits audit files — a fixer's job is to change the *code* until a re-audit flips the determination.

## The prompt

### {{IMPLEMENTATION-AUDITOR-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Adversarial implementation audit

  {{LEAF-AGENT-RULE}}

  ### Your job

  For each artifact below, determine whether the project as it
  stands implements what the artifact claims, and write the audit
  file per {{AUDIT-FILE-FORMAT}} (transcluded below) to
  `.ok-planner/audits/stories/<slug>.md` or
  `.ok-planner/audits/decisions/<slug>.md`, overwriting any prior
  audit whole. Then report, in-context, one line per artifact:
  the ref, the determination, and for violated the one-sentence
  reason.

  Your bias is adversarial: you are trying to REFUTE the claim,
  not to confirm it. The implementation existing is not the bar;
  the claim being true is. The most common real-world failure is
  not a broken mechanism but a missing one: a claim that covers
  two transports enforced on one, an "every" enforced on the
  members someone remembered, a rationale selling a property
  nothing delivers, code that was simply never written. Hunt for
  the absence, not just the defect.

  {{AUDIT-DEFINITION}}

  {{AUDIT-FILE-FORMAT}}

  ### Method

  0. Read the prior audit file first, if one exists — it is the
     record you transact against, not scratch paper. Its recorded
     adjudications BIND you: depart from a recorded promotion or
     dismissal only by naming the cited reality that changed since
     it was recorded (a hash that moved, an identity that stopped
     resolving, a file that appeared or vanished). Two exceptions,
     both mechanical: a design artifact whose own hash moved lapses
     its audit's precedent wholesale — audit the artifact fresh,
     carrying prior notes forward as history, not as binding — and
     an adjudication whose own cited reality moved is open again.
     Every note marked `open (awaiting the next audit pass)` is
     yours to adjudicate now: promoted — add the citation that
     covers the nominated territory and record the promotion on the
     note — or dismissed, with the stated reason the change does
     not bear on this determination. Never leave a note open in an
     audit you write, and never drop or rewrite existing notes and
     adjudications: carry them forward verbatim.
     Then AUDIT THE AUDIT — pick the cheapest honest outcome per
     ref, not a full rewrite by reflex:
     - **refresh**: artifact hash stands, no open nomination, and
       the changed bytes lie outside every claim's territory —
       regenerate the stale citation lines, touch nothing else; the
       determination and reasoning stand by recorded precedent.
     - **amend**: a claim's evidence moved but the determination's
       basis stands — edit the claims and citations touched and
       leave the rest as written.
     - **rewrite whole**: the artifact's hash moved (precedent
       lapsed), a nomination implicates it, or changed bytes touch
       what a claim rests on.
     If you were dispatched as a refresh batch and a ref needs more
     than a refresh, do not deep-read it here — report it back as
     `escalate: <ref> — <why>` and move on.
     Exhibitions are precedent under the same rule: where the
     standing audit records a demonstration together with citations
     on what it exercised, re-run it only if one of those citations
     moved; otherwise it stands. A demonstration you run cites what
     it exercised so the next auditor inherits the same economy.
  1. Read the artifact in full: title, Story/Acceptance/Falsifier
     or Choice/Rationale, every sentence. Decompose it into its
     individually checkable claims — the title and every normative
     sentence count; a Rationale sentence claiming a capability is
     a claim like any other.
  2. For every quantifier (every, all, each, never, none, only,
     no ...): enumerate the population FROM REALITY — the compose
     file, the route registrations, the listener setups, the
     interface's implementors — never from the artifact's own
     examples and never from what the enforcing code happens to
     cover. Check each member. Pin the enumeration source with a
     cite-file: line so a future member re-triggers this audit.
  3. Locate the enforcing code by reading outward from the claim's
     subject; `rg -n '@story:<slug>'` / `rg -n '@decision:<slug>'`
     is a navigation aid and nothing more — annotations play no
     part in what you audit or invalidate, and an untagged
     enforcement point counts exactly like a tagged one. Absence of
     any citable enforcement point for a claim is a violated
     determination, not an inconvenience.
  4. For stories: also judge the proof. Run
     `rg -l '@story:<slug>'` for its integration tests, read them,
     and decide whether what they exercise spans the Acceptance —
     a green proof exercising less than the story claims is part
     of a violated determination, stated as its own claim line.
  5. Write the audit file: every claim with its finding and
     citations, the determination the claims add up to, the Notes
     ledger (carried forward, every open note adjudicated), and the
     Citations block. Quote nothing beyond identities and anchor
     lines — the audit reasons in prose and cites by pointer; it
     never reproduces code. Where the project carries a committed
     source graph (`.ok-planner/graph/`), cite it: `cite-node:
     <path>#<chain>` on the node frontier that delivers the claim —
     choosing the frontier is your judgment; cite a higher node
     when the claim's territory spans code the graph's syntax
     cannot see connected (a closure passed across files, a
     dataflow) — and `cite-node: <path>` whole on every population
     source a quantifier was enumerated from. Reach for the finer
     forms where they carry the verdict better: `cite-span:` when
     the three lines inside a long unit are what the determination
     rests on, `cite:` when bare existence of a line is the claim.
     On a project with no committed graph, use the anchor forms
     throughout. Generate every line with the vendored helper —
     `.ok-planner/bin/audit-check cite-node <identity>` /
     `... cite <path> "<anchor>" [<lines>]` / `... cite-file
     <path>` — never hand-compute a hash.
  6. A `violated` audit you write carries NO issue: link — linking
     is the architect's act when a violation is promoted; yours is
     only the determination.

  ### Artifacts to audit

  [AUDIT SET]

  ### Rules

  - Read files before citing them; every citation must anchor to
    text that exists right now.
  - Never edit code, design artifacts, issues, or anything outside
    `.ok-planner/audits/`. You are a determiner, not a fixer.
  - Never soften a determination because the fix looks hard, the
    violation looks old, or a test is green. "The tests pass" is
    not "the claim is true."
  - Satisfied audits state what would have to change for the
    determination to stop holding — that is what makes the
    citation set the right re-audit tripwire.

  ### Report

  One line per artifact: `<ref> — satisfied` or
  `<ref> — violated: <one-sentence reason>` or
  `escalate: <ref> — <why a refresh does not cover it>`, followed
  by the audit file path (for escalations, no file is written) and,
  where notes were adjudicated, `notes: N promoted, M dismissed`.
  Mark each written ref's outcome: `(refreshed)`, `(amended)`, or
  `(rewritten)`. The violated lines are certification findings; the
  gate's review-fix loop consumes them verbatim, and escalations go
  back to the gate for a full-pass dispatch.
```

<!-- Materialized by ok-planner v11.1.2 — suite-owned; overwritten on converge; do not hand-edit. -->
