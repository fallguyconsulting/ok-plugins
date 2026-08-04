# Certification core

Shared machinery for `certify-work`, the change-scoped certification gate. It holds the review-fix loop and its veto test, the sprint-alignment judge, the fixer and architect subagents, the code-review prompt, the presentation, and the close-out. Defining them here rather than inline keeps the gate's body about scope; per the single-source rule, the skill never restates these blocks.

Nothing here audits. Whether the corpus's stories and decisions are still supported by the codebase is the periodic `/verify-corpus` run's question, asked over the whole corpus on the owner's cadence — never at a close, and never against a change.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block below to use verbatim; `[...]` inside a block is a per-gate value the consuming skill fills. The prompts below also carry `{{LEAF-AGENT-RULE}}`, `{{READ-ONLY-REVIEWER-RULE}}`, and `{{DISPATCH-DISCIPLINE}}` — transclude those from `../_shared/dispatch-discipline.md`. The fix loop and presentation run in the consuming skill's own loop (Mode 2 — read and apply); the fixer and code-review prompts are subagent dispatches (Mode 1 — fill the placeholders and dispatch).

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

The workhorse of certification: one loop that drives every finding from every producer to **fixed** or **promoted**. **The orchestrator has no discretion inside it and never edits code or corpus itself**: it moves verbatim lists between the producers, the fixer, and the architect, and it counts cycles — dispatching and counting are its only tools. (It is often the very session that implemented the work under certification, which is exactly why every fix, however small, is a dispatch.)

**Producers.** The gate's review passes — sprint alignment, the project's test suites, the mechanical floor, code review — each report findings at the gate's scope. Producers are stateless reporters: they never file issues and never fix. Nothing here writes under `.ok-planner/audits/`. Any `mechanical`/`judgment` class a reviewer attaches is advisory context, not routing — every finding enters the same loop. A finding grounded solely in a qualitative clause is not a finding (per `{{DECIDABILITY-BOUNDARY}}` in `../_shared/artifact-definitions.md`): the fixer dissolves it, the architect checks the dissolution, and the rim is another discipline's, never the loop's.

**Phase A — initial review.** Run every producer at the gate's scope. Collect all findings.

**Phase B — the cycle: fixer → architect → re-review.**

1. **Dedup.** Subtract findings already promoted — this run's promotions and issues already in the intake, matched by fingerprint slug per `{{ISSUE-FILE-FORMAT}}`. Nothing left → the loop is clean; exit.
2. **Fixer.** Dispatch `{{CERTIFY-FIXER-PROMPT}}` with the full, verbatim remaining list. The fixer fixes everything the veto test allows and kicks back the rest, each kickback claiming a genuine fork with the diverging options stated.
3. **Architect.** If there are kickbacks or dissolutions, dispatch `{{CERTIFY-ARCHITECT-PROMPT}}` with both lists, verbatim. The architect adversarially tests each kickback claim while roleplaying the reasonable owner: refuted → it names the resolution and makes the fix itself; confirmed → it **promotes** — writes the issue file to the intake and authors the fork. (Certification's "promote" — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
4. **Re-review.** Re-run each producer whose findings were worked or whose subject a fix touched, at its **original scope**. The loop never widens a producer's scope; a producer that reported clean and whose subject nothing touched stands. New and remaining findings feed the next cycle.
5. **Exit.** Clean per step 1 → done. After **3 fixer passes** without a clean review, the cap is reached: the run stops and puts exactly two steps to the owner — **another cycle** (cap reset by the owner's word), or **escalate the remainders**: file each remaining finding to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem, the attempted fixes as evidence), then continue to `/verify-issues` and the presentation like any other run. **The choice is the owner's alone; the run takes neither step itself and waits for their word — attended or not, with no default.** A run parked at the cap is a legal in-flight state: not done, not failed.

**Two paths reach the intake, and the owner is never asked live mid-cycle.** Certification creates issues only through the architect's confirmed forks and the owner's cap escalation; the pre-presentation `/verify-issues` pass makes both ruling-ready. Everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, refuted kickbacks — surfaces in the presentation's Divergences for after-the-fact veto.

---

### {{SPRINT-ALIGNMENT-PROMPT}}

The corpus-change judge. The sprint is the one instrument that changes what the corpus commits to, so its realization gets its own producer. Dispatched only when a sprint is in scope; the consuming gate fills `[SPRINT PATH]`.

```
Agent (general-purpose, model: sonnet-5):
  ## Sprint alignment — the corpus change, realized and coherent

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  The sprint at [SPRINT PATH] is a change-order against the design
  corpus. Judge three things, and report findings for each:

  1. **Every corpus delta applied verbatim.** The artifact under
     `.ok-planner/design/` matches the delta's final-form body (or
     is deleted, for a retirement). A mismatch is a finding —
     mechanical where a byte comparison settles it.
  2. **Every work item's outcome realized, not undershot.** No
     stub, no-op, `TODO`, deferred handler, declared-but-unemitted
     error, or accepted-but-ignored flag standing in for a promised
     outcome. An undershoot is a BLOCKING finding even when every
     test is green — that is how spec'd work ships unbuilt. The
     outcome must be observable, not merely its mechanism present.
  3. **The changed corpus is coherent with the live corpus.** Read
     the changed/new artifacts in full plus the three catalog TOCs;
     flag any contradiction with a live artifact (reading the
     counterparty in full only when the catalogs suggest a
     collision). Corpus edits made mid-cycle by the fixer or
     architect are in scope here too — check them against the
     canonical authoring rules in
     `../_shared/artifact-definitions.md` (transcluded rules
     apply; whole-corpus hygiene is /ok-planner-audit's, not yours).

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  ### Output

  Findings only, one per line: what is wrong, where (file plus the
  delta or work item it fails), and why it matters. Do not grade
  severity. Advisory mechanical/judgment class per the transcluded
  rule. No findings → report "clean".
```

---

### {{CERTIFY-FIXER-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Fix Every Finding

  {{DISPATCH-DISCIPLINE}}

  Review passes found the following findings. Fix ALL of them, or —
  for the rare genuine fork — kick back. Do not skip, defer, or
  assess priority; no finding is "acceptable", "cosmetic",
  "pre-existing", "out of scope", "minor", or "not blocking", and
  code you didn't write is still yours to fix. If a fix requires
  reading more files, read them; if it requires an architecture
  change, make it. If the determined fix lands in a design doc
  under `.ok-planner/design/`, make it there: a rules-determined,
  intent-preserving corpus repair — a stale TOC line, a stale
  sentence the code and the counterpart artifact both contradict —
  is an ordinary fix, not a reserved act. If the right fix depends
  on intent the finding leaves open, resolve it from the sprint and
  the design corpus; where they are silent, make the best
  engineering call and record it — do not stop to ask.

  There are exactly two legal non-fixes. The first is a DISSOLVE:
  a finding whose ONLY basis is a qualitative clause of a story or
  decision — correct (of prose), canonical, clear, helpful,
  well-designed — per the decidability boundary in
  `../_shared/artifact-definitions.md` ({{DECIDABILITY-BOUNDARY}}).
  Such a finding asks for a quality judgment no procedure can
  settle; it is neither fixed nor kicked back — report it as
  DISSOLVED with the clause quoted, and it will be adversarially
  checked. If any decidable basis exists alongside the qualitative
  one, fix the decidable part; dissolution never covers it.

  The second legal non-fix is a KICKBACK, gated by the veto test:
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
  - If genuinely blocked (a credential you lack), say so
    specifically — that is the only acceptable non-fix.

  ### Completion check
  Re-read the finding list and confirm every one has a corresponding
  fix, kickback, or dissolution and none were skipped or deferred.
  Report DONE with a numbered finding→fix map, a CALLS MADE list
  (every call you made beyond what the sprint/corpus spell out, one
  line each — empty if none), a CORPUS EDITS list (every file under
  `.ok-planner/design/` you edited, one line each with what changed
  — empty if none; the gate surfaces these in its presentation's
  Divergences), a KICKBACKS list (per kickback: the finding
  verbatim, why the fork is genuine under the veto test, and the
  diverging options — empty if none), and a DISSOLVED list (per
  dissolution: the finding verbatim and the qualitative clause it
  rests on, quoted — empty if none; these go to the architect with
  the kickbacks); or BLOCKED with the specific blocker and which
  findings it stops.
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

  The fixer's DISSOLVED list rides with the kickbacks and gets the
  same adversarial treatment under the decidability boundary
  ({{DECIDABILITY-BOUNDARY}}): a dissolution is a claim that the
  finding's only basis is a qualitative clause no procedure can
  settle. If ANY decidable basis exists — an enumerable coverage,
  a named source, an observable behavior — the dissolution is
  refuted: make the decidable fix yourself under the fixer's rules.
  If the finding truly rests on quality judgment alone, uphold the
  dissolution; it is neither fixed nor promoted, and the rim it
  names is another discipline's work, not the intake's.

  ### Kickbacks and dissolutions

  [PASTE THE FIXER'S KICKBACKS AND DISSOLVED LISTS VERBATIM — per
  kickback: the finding, the fixer's reasoning, the diverging
  options; per dissolution: the finding and the qualitative clause
  it rests on]

  ### Rules
  - Read the sprint (when one is in scope) and the bearing corpus
    artifacts before ruling on any kickback.
  - Read files before editing. Never destroy uncommitted work: fix
    bad edits forward, never with git
    checkout/restore/reset/stash/clean. Do NOT commit.

  ### Report
  Per kickback, one line: REFUTED (the named resolution, what you
  changed, how verified) or PROMOTED (the issue file path, why the
  fork is genuine). Per dissolution, one line: UPHELD (the
  qualitative clause, quoted) or OVERTURNED (the decidable basis
  you found and the fix you made). These lines surface in the
  certification presentation — REFUTED and OVERTURNED lines under
  Divergences, PROMOTED lines under Issues promoted, UPHELD lines
  under Dissolved.
```

---

### {{CERTIFY-CODE-REVIEW-PROMPT}}

The consuming gate fills `[REVIEW SCOPE]` (what is under review, how to enumerate it, and how far findings may reach beyond it — this is where the gates genuinely differ) before dispatching.

```
Agent (general-purpose, model: sonnet-5):
  ## Code Review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

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
    (Completeness against the sprint's promised outcomes is the
    sprint-alignment producer's charter, not yours — you defend the
    code, it defends the corpus change.)
  - Test coverage: do tests verify real behavior? Behavior you judge
    untested — no end-to-end exercise for something the change
    delivers — is an ordinary finding: the fixer writes the test,
    and the test surface grows through the loop.
  - Dead code, unused imports, stale comments.
  - Findings rest on decidable defects. A quality judgment over
    prose or design — documentation that might be wrong, an
    explanation that could be clearer, a surface that feels
    unpolished — is not a finding unless a procedure can settle it
    (a named source contradicted, an enumerable case missing).
    The qualitative rim of a story is another discipline's
    business, not review material.

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

The strong closing step: the outcomes, and any divergences, put in front of the user. With a sprint in scope, the composed presentation is first **written into the sprint's completion report** — the file beside the sprint (same filename with `-completion`) that the executor kept during the work; create it if the executor did not — finishing that record, and then walked with the owner in the session; the report is archived together with the sprint at close-out, and the sprint's completion contract requires it finished. Compose it in full (it is a report and a file deliverable, so it is delivered whole, not paced). Sections:

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with issues promoted

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

## Dissolved
<Every finding the fixer dissolved and the architect upheld this
run — a claim resting only on a quality judgment no procedure can
settle: per line, the finding and the clause it rested on. These
show where this gate's jurisdiction ends. Omit the section when
there are none.>

## Issues promoted
<Every issue this run created, listed by file path with the verify
pass's outcome per issue: answered by the corpus (and closed with
the citation), or verified and awaiting your ruling at the bottom of
the file. Two kinds, each labeled: forks the architect confirmed
(with its why-genuine line), and remainders escalated at the cap
(with the finding and what the fix cycles tried). These are the next
sprint's business, not this run's.>

<Every presentation ends with the close-out offer, in one or two
sentences, per {{CERTIFY-CLOSE-OUT}} below.>
```

---

### {{CERTIFY-CLOSE-OUT}}

If a sprint was in scope and everything certified clean, end the presentation with the standing offer: **archive the sprint** — move it to `.ok-planner/history/sprints/`, together with its completion report and every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names it (promoted receipts, moving to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word; the sprint stays at its `sprints/` path until then, so a `/goal` keyed to that path can verify completion, and an uncertified sprint gets no offer at all. On the yes, after the archive commit lands, stamp the archived sprint with the closing commit — `closed: <sha of the archive commit>` in YAML frontmatter, one small follow-on commit — the baseline `/plan-sprint`'s out-of-band reconciliation reads. Remainders the owner escalated at the cap are verified issues like any others; the presentation and close-out proceed normally.

---

### {{CERTIFY-GATE-BOUNDARIES}}

- Does not triage or defer findings: every finding enters the review-fix loop, and the intake is reached only by the architect's confirmed forks and the remainders the owner escalates at the cap.
- Does not ask the owner questions mid-cycle: forks are promoted and everything else is fixed; the cap is the run's one stop, and it waits there for the owner's choice.
- Does not archive or commit on its own initiative: the presentation offers both, and only the owner's word triggers either.
- Does not plan or build new scope: a gap the loop cannot drive to clean is surfaced, never filled with work no sprint promised.

<!-- Materialized by ok-planner v14.4.0 — suite-owned; overwritten on converge; do not hand-edit. -->
