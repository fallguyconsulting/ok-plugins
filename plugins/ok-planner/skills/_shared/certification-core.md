# Certification core

Shared machinery for the two certification gates: `certify-work` (change-scoped, the everyday close) and `certify-all` (whole-corpus, the periodic full gate). Both skills run the same fix loop, dispatch the same fixer and code reviewer, and end in the same presentation — only their **scope** differs. Defining the machinery once here is what keeps the gates from drifting apart; per the single-source rule, neither skill restates these blocks inline.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block below to use verbatim; `[...]` inside a block is a per-gate value the consuming skill fills. The prompts below also carry `{{LEAF-AGENT-RULE}}` and `{{DISPATCH-DISCIPLINE}}` — transclude those from `skills/_shared/dispatch-discipline.md`. The fix loop and presentation run in the consuming skill's own loop (Mode 2 — read and apply); the fixer and code-review prompts are subagent dispatches (Mode 1 — fill the placeholders and dispatch).

---

### {{CERTIFY-FIX-LOOP}}

Ported from the discipline that a reviewer's findings must be driven to zero by a fixer, not triaged by the orchestrator. **The orchestrator has no discretion here.** It does not summarize, filter, reorder, or defer findings; it hands the raw finding list to a fixer subagent and loops.

1. Dispatch the **fixer subagent** (`{{CERTIFY-FIXER-PROMPT}}`) with the producing check's full, verbatim finding list.
2. When the fixer reports done, **re-run the producing check** — the same prompt, the same scope it was first run with — to verify. A change-scoped check is re-run change-scoped; the fix loop never widens a check's scope.
3. Zero findings → that source is clean. New or remaining findings → back to step 1.
4. **Cap: 3 fix-review cycles per source.** If findings persist after three, stop looping that source and carry the remainder into the presentation for the user to direct — never silently accept or editorialize them away.

**The judgment bar is high, and the owner is never asked live.** A finding is *fixable* — the overwhelming default — when its correct end state is determined by the sprint, the corpus, or ordinary engineering judgment grounded in them. The fixer fixes it; any call it made beyond what those sources spell out is recorded and surfaced in the presentation's Divergences for after-the-fact veto. A finding is *judgment* only when it is really, truly unclear: the sprint and corpus are silent AND reasonable resolutions materially diverge on product intent. Judgment findings are never handed to the fixer and never put to the owner as a mid-run question — file each as an issue file per `{{ISSUE-FILE-FORMAT}}` in `skills/_shared/artifact-definitions.md` (kind `audit`, category from the finding's nature, Candidates from the finding, `status: open`) and list the files in the presentation; the pre-presentation `/verify-issues` pass makes them ruling-ready. `/audit` files its own; the gate files the truly-unclear remainder from its other sources. Certification never stalls on a question: by the time the presentation renders, every finding is fixed, filed, or stuck at the cap.

---

### {{CERTIFY-FIXER-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Fix Every Finding

  {{DISPATCH-DISCIPLINE}}

  A review found the following findings. Fix ALL of them. Do not skip any.
  Do not assess priority. Do not defer. Do not mark any finding
  "acceptable", "cosmetic", "pre-existing", "out of scope", or "not
  blocking".

  If a finding is in code you didn't write, fix it anyway.
  If it predates the current work, fix it anyway.
  If it seems minor, fix it anyway.
  If fixing it requires reading more files, read them.
  If fixing it requires an architecture change, make it.
  If the right fix depends on intent the finding leaves open, resolve
  it from the sprint and the design corpus under `.ok-planner/design/`;
  where they are silent, make the best engineering call and record it —
  do not stop to ask. Only a finding that is really, truly unclear —
  sprint and corpus silent AND reasonable fixes materially diverging on
  product intent — may come back unfixed: mark it UNCLEAR with the
  diverging options stated.

  ### Findings to fix

  [PASTE THE PRODUCING CHECK'S FULL OUTPUT — do not summarize or filter]

  ### Rules
  - Read files before editing.
  - Run the project's type checks and tests for whatever packages you
    modified; a fix that breaks the build is not done.
  - Never destroy uncommitted work: fix bad edits forward, never with
    git checkout/restore/reset/stash/clean. Do NOT commit.
  - "Low priority" is never a valid reason to skip. If genuinely
    blocked (a credential you lack), say so specifically — that is the
    only acceptable non-fix.

  ### Completion check
  Re-read the finding list and confirm every one has a corresponding
  fix and none were skipped or deferred. Report DONE with a numbered
  finding→fix map, a CALLS MADE list (every call you made beyond what
  the sprint/corpus spell out, one line each — empty if none), and any
  UNCLEAR items with their diverging options; or BLOCKED with the
  specific blocker and which findings it stops.
```

---

### {{CERTIFY-CODE-REVIEW-PROMPT}}

The consuming gate fills `[REVIEW SCOPE]` (what is under review, how to enumerate it, and how far findings may reach beyond it — this is where the gates genuinely differ) before dispatching.

```
Agent (general-purpose, model: sonnet-5):
  ## Code Review

  {{LEAF-AGENT-RULE}}

  ### Scope

  [REVIEW SCOPE]

  ### Source of truth
  The sprint this work realizes (if one is in scope) — its
  deltas and work items — is what the work was meant to accomplish.
  Judge against it, not against the design corpus as an oracle. If the
  sprint has corpus deltas, open the affected files under
  `.ok-planner/design/` and verify each landed correctly — that is
  verifying directed work, not consulting the corpus as oracle.

  ### Review focus
  - Correctness: bugs, edge cases, off-by-one.
  - Safety: data loss, security, resource leaks, irreversible actions.
  - State integrity: stuck states, double-execution, skipped steps.
  - Load-bearing properties upheld: name the properties the sprint
    depends on — durability, completeness, atomicity, ordering,
    idempotency, no-data-loss, "this record is authoritative" — and
    verify the code still guarantees each, not only on the happy path.
    A property silently traded away for a local optimization is a
    finding even when nothing looks broken.
  - Completeness against the sprint's promised outcomes: every story
    or decision the sprint realizes must actually be delivered — its
    outcome observable, not merely its mechanism present. Flag any
    undershoot: a handler/route/class registered but doing nothing, an
    error class declared but never emitted, a flag accepted but
    ignored, a stub or no-op standing in for a promised outcome, a
    `TODO`/"out of scope"/"deferred" on a promised path. A promised
    outcome not really delivered is a blocking finding even when every
    test is green — that is how spec'd work ships unbuilt.
  - Test coverage: do tests verify real behavior? Gaps?
  - Dead code, unused imports, stale comments.

  ### Output
  Every finding with: file:line, what's wrong, why it matters, how to
  fix. Do not grade by severity — every finding needs fixing.
  Reserve a `## Unclear` heading for the rare finding that is really,
  truly unclear: the sprint and design corpus do not determine the
  fix AND reasonable resolutions materially diverge on product
  intent. State each with its diverging resolution candidates.
  "Plausibly intentional" is not the bar — if one resolution is
  clearly better engineering, it is an ordinary finding to fix.
```

The reviewer's findings drain through the fix loop. Its `## Unclear` entries are filed to the issue intake by the gate (Candidates from the entry) and listed in the presentation — never put to the owner as live questions.

---

### {{CERTIFY-PRESENTATION}}

The strong closing step: the outcomes, and any divergences, put in front of the user. Compose it in full (it is a report, so it is delivered whole, not paced). Sections:

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with issues filed | NOT certified (findings at cap)

## Outcomes delivered
<Each story/decision the work realized, and the user-observable
outcome now true. For a bare goal with no sprint: what the goal
asked and what now holds.>

## Divergences
<Where the built work departed from the sprint, if anywhere: an
overshoot (unstated-but-necessary work built to make an outcome
hold), a forced shape-change, a delta applied differently than
written — plus every call the fix loop made where the sprint and
corpus were silent, each named so the owner can veto it after the
fact. "None" if the work matched the sprint and no calls were made.
An undershoot must never appear here — it was fixed, not reported.>

## Findings fixed
<Count and one-line summaries per source. "Clean on first pass"
where nothing was found.>

## Issues filed
<Every judgment finding filed to the issue intake this run — audit's
own filings plus the truly-unclear findings the gate filed from its
other sources — listed by file path, with the verify pass's outcome
per issue: answered by the corpus (and closed with the citation), or
verified and awaiting your ruling at the bottom of the file. These
are the next sprint's business, not this run's. Nothing in this
section was asked live; nothing exists only in this report.>

## Not certified
<Only if findings remained at the fix-loop cap: what remains, per
source, without editorializing. No close-out is offered.>

<Certified presentations end with the close-out offer, in one or two
sentences: archive the sprint (and its promoted issue receipts) to
history, and commit the work — both awaiting the owner's word.>
```
