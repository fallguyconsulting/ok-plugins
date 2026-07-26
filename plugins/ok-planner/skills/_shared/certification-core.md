# Certification core

Shared machinery for the two certification gates: `certify-work` (change-scoped, the everyday close) and `certify-all` (whole-corpus, the periodic full gate). Both skills run the same review-fix loop, dispatch the same fixer, architect, and code reviewer, and end in the same presentation — only their **scope** differs. Defining the machinery once here is what keeps the gates from drifting apart; per the single-source rule, neither skill restates these blocks inline.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block below to use verbatim; `[...]` inside a block is a per-gate value the consuming skill fills. The prompts below also carry `{{LEAF-AGENT-RULE}}` and `{{DISPATCH-DISCIPLINE}}` — transclude those from `skills/_shared/dispatch-discipline.md`. The fix loop and presentation run in the consuming skill's own loop (Mode 2 — read and apply); the fixer and code-review prompts are subagent dispatches (Mode 1 — fill the placeholders and dispatch).

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

The workhorse of certification: one loop that drives every finding from every producer to **fixed** or **promoted**, ported from the discipline that a reviewer's findings must be driven to zero by a fixer, not triaged by the orchestrator. **The orchestrator has no discretion inside it** — it does not summarize, filter, reorder, or defer findings; it moves verbatim lists between the producers, the fixer, and the architect, and it counts cycles.

**Producers.** The gate's review passes — sprint alignment, `/prove`, the corpus checks, code review — each report findings at the gate's scope. Producers are stateless reporters: they never file issues and never fix. Any `mechanical`/`judgment` class a reviewer attaches is advisory context for the fixer and architect, not routing — every finding enters the same loop.

**Phase A — initial review.** Run every producer at the gate's scope. Collect all findings.

**Phase B — the cycle: fixer → architect → re-review.**

1. **Dedup.** Subtract findings already promoted — this run's promotions and issues already in the intake, matched by fingerprint slug per `{{ISSUE-FILE-FORMAT}}`. Nothing left → the loop is clean; exit.
2. **Fixer.** Dispatch `{{CERTIFY-FIXER-PROMPT}}` with the full, verbatim remaining list. The fixer fixes everything the veto test allows and kicks back the rest, each kickback claiming a genuine fork with the diverging options stated.
3. **Architect.** If there are kickbacks, dispatch `{{CERTIFY-ARCHITECT-PROMPT}}` with them, verbatim. The architect adversarially tests each kickback claim while roleplaying the reasonable owner: refuted → it names the resolution and makes the fix itself; confirmed → it **promotes** — writes the issue file to the intake and authors the fork. (Certification's "promote" — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
4. **Re-review.** Re-run each producer whose findings were worked or whose subject a fix touched, at its **original scope** — the loop never widens a check's scope; a producer that reported clean and whose subject nothing touched stands. New and remaining findings feed the next cycle.
5. **Exit.** Clean per step 1 → done. After **3 fixer passes** without a clean review: on an interactive run, put the choice to the owner — more cycles, or proceed to verification and presentation with the remainder reported; on an unattended run (a goal hook, an orchestrator, any run with nobody watching), proceed — the remainder lands in the presentation as NOT certified, no close-out is offered, and the certification is finished out manually.

**The veto test** — the line between fix and kickback, applied by the fixer and adversarially checked by the architect: *would a reasonable owner, reading this fix as one Divergences line, plausibly say "no — I meant the other thing"?* If every reasonable reading lands in the same place, the fix is determined: make it — in code or in `design/` alike (per `{{MECHANICAL-VS-JUDGMENT-RULE}}` in `skills/_shared/artifact-definitions.md`, the line is intent, not file surface) — and record it. Kick back only when a reasonable owner might genuinely pick the other side: the fix would decide product intent, change what the corpus commits to, or build net-new scope no sprint authorized. Inability is never grounds — "hard but determined" is a fix, not a fork.

**Promotion is the loop's only path to the intake, and the owner is never asked live.** No producer files, and the gate files nothing on its own initiative: the architect's confirmed forks are the only issues certification creates, and the pre-presentation `/verify-issues` pass makes them ruling-ready. Everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, refuted kickbacks — surfaces in the presentation's Divergences for after-the-fact veto. Certification never stalls on a question mid-cycle: by the time the presentation renders, every finding is fixed, promoted, or stuck at the cap.

---

### {{CERTIFY-FIXER-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Fix Every Finding

  {{DISPATCH-DISCIPLINE}}

  Review passes found the following findings. Fix ALL of them, or —
  for the rare genuine fork — kick back. Do not skip any. Do not
  assess priority. Do not defer. Do not mark any finding
  "acceptable", "cosmetic", "pre-existing", "out of scope", or "not
  blocking".

  If a finding is in code you didn't write, fix it anyway.
  If it predates the current work, fix it anyway.
  If it seems minor, fix it anyway.
  If fixing it requires reading more files, read them.
  If fixing it requires an architecture change, make it.
  If the determined fix lands in a design doc under
  `.ok-planner/design/`, make it there: a rules-determined,
  intent-preserving corpus repair — a stale TOC line, a stale
  sentence the code and the counterpart artifact both contradict, a
  heading brought to canonical shape — is an ordinary fix, not a
  reserved act.
  If the right fix depends on intent the finding leaves open, resolve
  it from the sprint and the design corpus under `.ok-planner/design/`;
  where they are silent, make the best engineering call and record it —
  do not stop to ask.

  The one legal non-fix is a KICKBACK, gated by the veto test:
  *would a reasonable owner, reading your fix as a one-line
  divergence report, plausibly say "no — I meant the other thing"?*
  If every reasonable reading lands in the same place, the fix is
  determined — make it. Kick back only when a reasonable owner
  might genuinely pick the other side: the fix would decide product
  intent, change what the corpus commits to (retire an artifact,
  rewrite a Choice, add or drop an invariant, widen or narrow a
  claim), or build net-new scope no sprint authorized. A kickback
  is a claim that a genuine fork exists, and it will be
  adversarially checked — state the diverging options and why
  reasonable owners diverge. Inability is never grounds: "hard but
  determined" is a fix, not a kickback.

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
  fix or kickback and none were skipped or deferred. Report DONE with
  a numbered finding→fix map, a CALLS MADE list (every call you made
  beyond what the sprint/corpus spell out, one line each — empty if
  none), a CORPUS EDITS list (every file under `.ok-planner/design/`
  you edited, one line each with what changed — empty if none; the
  gate surfaces these in its presentation's Divergences), and a
  KICKBACKS list (per kickback: the finding verbatim, why the fork
  is genuine under the veto test, and the diverging options — empty
  if none); or BLOCKED with the specific blocker and which findings
  it stops.
```

---

### {{CERTIFY-ARCHITECT-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Architect Review — kicked-back findings

  {{DISPATCH-DISCIPLINE}}

  A fixer working through certification findings has kicked back the
  findings below. Each kickback is a claim: no fix exists that a
  reasonable owner would wave through — the finding is a genuine
  fork in product intent. You hold the owner's chair. For each
  kickback, roleplay the project owner — the person whose intent the
  sprint (if one is in scope) and the design corpus under
  `.ok-planner/design/` record — and adversarially test the claim.
  Your bias is to REFUTE: certification wants findings fixed, and
  the issue intake is for genuine forks only.

  Per kickback, exactly one of two outcomes:

  - **REFUTE and fix.** If there is a resolution every reasonable
    owner would land on — the "contradiction" only exists under a
    strained reading, the missing clause has one honest value, the
    disambiguation loses nothing anyone could want — the kickback
    is refuted. Name the resolution, then make the fix yourself,
    under the fixer's own rules: run the affected checks, and edits
    under `.ok-planner/design/` are legal only while no commitment
    changes (never retire an artifact, rewrite a Choice, add or
    drop an invariant, or widen or narrow a claim).
  - **CONFIRM and promote.** If a reasonable owner might genuinely
    pick the other side — the fix would decide product intent,
    change what the corpus commits to, or build net-new scope no
    sprint authorized — the fork is real. Write the issue file per
    {{ISSUE-FILE-FORMAT}} (kind `audit`, category from the
    finding's nature, `status: open`, the diverging options as
    Candidates, fingerprint slug deduped against every slug already
    present in `.ok-planner/issues/`), and record why the fork is
    genuine.

  "It seems minor" refutes nothing, and "it seems hard" confirms
  nothing: the only question is whether reasonable owners diverge.

  ### Kickbacks

  [PASTE THE FIXER'S KICKBACKS LIST VERBATIM — per kickback: the
  finding, the fixer's reasoning, the diverging options]

  ### Rules
  - Read the sprint (when one is in scope) and the bearing corpus
    artifacts before ruling on any kickback.
  - Read files before editing. Never destroy uncommitted work: fix
    bad edits forward, never with git
    checkout/restore/reset/stash/clean. Do NOT commit.

  ### Report
  Per kickback, one line: REFUTED (the named resolution, what you
  changed, how verified) or PROMOTED (the issue file path, why the
  fork is genuine). These lines surface in the certification
  presentation — REFUTED lines under Divergences, PROMOTED lines
  under Issues promoted.
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
  fix. Do not grade by severity — every finding needs fixing. Where
  you suspect a finding is a genuine intent fork (the sprint and
  design corpus do not determine the fix AND reasonable resolutions
  materially diverge on product intent), say so on the finding with
  the diverging candidates — advisory context for the fixer, not a
  different bucket; you file nothing and route nothing. "Plausibly
  intentional" is not the bar — if one resolution is clearly better
  engineering, it is an ordinary finding.
```

The reviewer is a producer: its findings, like every producer's, drain through `{{CERTIFY-REVIEW-FIX-LOOP}}` — fixer, then architect for any kickbacks. It files nothing itself.

---

### {{CERTIFY-PRESENTATION}}

The strong closing step: the outcomes, and any divergences, put in front of the user. Compose it in full (it is a report, so it is delivered whole, not paced). Sections:

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with issues promoted | NOT certified (findings at cap)

## Outcomes delivered
<Each story/decision the work realized, and the user-observable
outcome now true. For a bare goal with no sprint: what the goal
asked and what now holds.>

## Divergences
<Where the built work departed from the sprint, if anywhere: an
overshoot (unstated-but-necessary work built to make an outcome
hold), a forced shape-change, a delta applied differently than
written — plus every call the fixer made where the sprint and
corpus were silent, every corpus repair made under
`.ok-planner/design/` (rules-determined, intent-preserving fixes:
file + what changed, one line each), and every architect REFUTED
line (kickback overruled: the named resolution and what changed) —
each named so the owner can veto it after the fact. "None" if the
work matched the sprint and no calls, corpus edits, or refutations
were made. An undershoot must never appear here — it was fixed,
not reported.>

## Findings fixed
<Count and one-line summaries per producer. "Clean on first pass"
where nothing was found.>

## Issues promoted
<Every fork the architect confirmed and promoted to the issue
intake this run — listed by file path with the architect's
why-genuine line and the verify pass's outcome per issue: answered
by the corpus (and closed with the citation), or verified and
awaiting your ruling at the bottom of the file. These are the next
sprint's business, not this run's. Nothing in this section was
asked live; nothing exists only in this report; nothing reached the
intake without surviving both the fixer's veto test and the
architect's adversarial check.>

## Not certified
<Only if findings remained at the cap — three fixer passes without
a clean re-review: what remains, per producer, without
editorializing. The remainder is a stubborn defect list for the
owner to direct manually, never a promotion. No close-out is
offered.>

<Certified presentations end with the close-out offer, in one or two
sentences: archive the sprint (and its promoted issue receipts) to
history, and commit the work — both awaiting the owner's word.>
```
