# Certification core

Shared machinery for `/certify-work`, the change-scoped certification gate: the review-fix loop and its veto test, the sprint-alignment judge, the fixer and architect prompts, the code-review prompt, the presentation, and the close-out. The gate's own body is about scope and never restates these blocks. The standing reviewer's brief lives here too: the sprint's execution shape dispatches it during the build, wrapping the same code-review prompt the gate runs cold, so review during the build and review at the gate apply one brief.

Nothing here audits. Whether the corpus's stories and decisions are still supported is the periodic `/audit` run's question, asked over the whole corpus on the owner's cadence — never at a close, never against a change.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a per-gate value the consuming skill fills. The prompts also carry `{{LEAF-AGENT-RULE}}`, `{{READ-ONLY-REVIEWER-RULE}}`, and `{{DISPATCH-DISCIPLINE}}` from `skills/_shared/dispatch-discipline.md`. The fix loop and presentation run in the consuming skill's own loop; the fixer, architect, alignment, and code-review prompts are subagent dispatches.

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

One loop drives every finding from every producer to **fixed** or **promoted**. The orchestrator has no discretion inside it and never edits code or corpus itself: it moves verbatim lists between the producers, the fixer, and the architect, and it counts cycles. Every fix is a dispatch, the orchestrator's own included.

**Producers.** The gate's review passes — sprint alignment, the project's test suites, the mechanical floor, code review — each report findings at the gate's scope. Producers never file issues and never fix. Nothing here writes under `.ok-planner/audits/`. A `mechanical`/`judgment` class a reviewer attaches is advisory; every finding enters the same loop. A finding grounded only in a qualitative clause is not a finding, per `{{DECIDABILITY-BOUNDARY}}` in `skills/_shared/artifact-definitions.md`: the fixer dissolves it and the architect checks the dissolution.

**Phase A — initial review.** Run every producer at the gate's scope. Collect all findings. With a sprint in scope, the sprint-alignment judge reads the completion report's Divergences: each recorded call goes under the veto test, and each claimed fork comes back as a finding tagged `CLAIMED FORK`. The code reviewer never reads the report — an unrecorded divergence surfaces as a fresh finding.

**Phase B — the cycle: fixer → architect → re-review.**

1. **Dedup.** Subtract findings already promoted — this run's promotions and issues already in the intake, matched by fingerprint slug per `{{ISSUE-FILE-FORMAT}}`. Nothing left → clean; exit.
2. **Fixer.** Subtract the findings tagged `CLAIMED FORK` from the remaining list. Dispatch `{{CERTIFY-FIXER-PROMPT}}` with what survives, verbatim. When nothing survives, skip the dispatch and go to step 3. The fixer fixes everything the veto test allows and kicks back the rest, each kickback claiming a genuine fork with the diverging options stated.
3. **Architect.** If there are kickbacks, dissolutions, or claimed forks, dispatch `{{CERTIFY-ARCHITECT-PROMPT}}` with all three lists, verbatim. A claimed fork is the executor's kickback: it recorded the fork in the report, built the reading it judged most plausible where it built one, and continued; the architect tests it the same way. The architect tests each kickback claim as the reasonable owner: refuted → it names the resolution and makes the fix; confirmed → it **promotes**: writes the issue file to the intake and authors the fork. It rewrites each claimed fork's entry in the report as it resolves it: a determined call on refute, the issue file named on promote. The re-run alignment judge reads the rewritten entry as settled and reports nothing for it, so a resolved fork reaches the architect once. (Certification's promote — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
4. **Re-review.** Re-run each producer whose findings were worked or whose subject a fix touched, at its original scope. The loop never widens a producer's scope; a producer that reported clean and whose subject nothing touched stands. New and remaining findings feed the next cycle.
5. **Exit.** Clean per step 1 → done. A cycle counts against the cap when it dispatched the fixer or the architect. After **3 counted cycles** without a clean review, the cap is reached: the run stops and puts two steps to the owner — **another cycle** (cap reset by the owner's word) or **escalate the remainders**: file each remaining finding to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem, the attempted fixes as evidence), then continue to `/verify-issues` and the presentation. The choice is the owner's alone. The run takes neither step itself and waits, attended or not, with no default. A run parked at the cap is a legal in-flight state: not done, not failed.

**Two paths reach the intake, and the owner is never asked live mid-cycle.** Certification creates issues only through the architect's confirmed forks and the owner's cap escalation; the pre-presentation `/verify-issues` pass makes both ruling-ready. Everything the executor recorded in the report and everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, refuted kickbacks — surfaces in the presentation's Divergences for after-the-fact veto.

---

### {{SPRINT-ALIGNMENT-PROMPT}}

The corpus-change judge. Dispatched only when a sprint is in scope; the consuming gate fills `[SPRINT PATH]`.

```
Agent (general-purpose, model: sonnet):
  ## Sprint alignment — the corpus change, realized and coherent

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  The sprint at [SPRINT PATH] is a change-order against the design
  corpus. Judge three things and report findings for each:

  1. **Every corpus delta applied verbatim.** The artifact under
     `.ok-planner/design/` matches the delta's final-form body, or
     is deleted for a retirement. A mismatch is a finding —
     mechanical where a byte comparison settles it.
  2. **Every work item's outcome realized, not undershot.** No
     stub, no-op, `TODO`, deferred handler, declared-but-unemitted
     error, or accepted-but-ignored flag stands in for a promised
     outcome. An undershoot is a blocking finding even when every
     test is green. The outcome must be observable, not only its
     mechanism present.
  3. **The changed corpus is coherent with the live corpus.** Read
     the changed and new artifacts in full plus the three catalog
     TOCs; flag any contradiction with a live artifact, reading the
     counterparty in full only when the catalogs suggest a
     collision. Corpus edits the fixer or architect made mid-cycle
     are in scope: check them against the authoring rules in
     `skills/_shared/artifact-definitions.md`. Whole-corpus hygiene
     is `/audit`'s, not yours.
  4. **The completion report's Divergences, each under the veto
     test.** Read the report beside the sprint (same filename with
     `-completion`). Its `## Divergences` section holds one entry per
     recorded call and per claimed fork, each opening with its
     identifier. For each recorded call — a determined reading
     the executor made where the sprint was silent, an overshoot, a
     shape-change — ask whether a reasonable owner, reading it as a
     one-line divergence report, would plausibly say "no — I meant
     the other thing". Would not → nothing to report; the
     presentation carries it. Might → a finding naming the call and
     the reading the owner might prefer. For each **claimed fork**
     — the report records a fork with its options and, where the
     executor built one, the reading it built — report a finding
     tagged `CLAIMED FORK` carrying the fork verbatim and its entry
     identifier; the loop routes it to the architect, never the
     fixer. An entry that names an issue file, or that states the
     resolution the architect made, is settled: report nothing for
     it. A missing report is a finding. A report with no
     `## Divergences` section is a finding too.

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  ### Output

  Findings only, one per line: what is wrong, where (file plus the
  delta or work item it fails), and why it matters. Do not grade
  severity. Attach the advisory mechanical/judgment class. No
  findings → report "clean".
```

---

### {{CERTIFY-FIXER-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Fix Every Finding

  {{DISPATCH-DISCIPLINE}}

  Review passes found the findings below. Fix all of them, or kick
  back the rare genuine fork. Do not skip, defer, or assess
  priority. No finding is "acceptable", "cosmetic", "pre-existing",
  "out of scope", "minor", or "not blocking"; code you did not write
  is still yours to fix. Read more files or change architecture as
  the fix requires. A determined fix that lands under
  `.ok-planner/design/` — a stale TOC line, a stale sentence the code
  and the counterpart artifact both contradict — is an ordinary fix:
  make it there. Where the right fix depends on intent the finding
  leaves open, resolve it from the sprint and the corpus; where they
  are silent, make the best engineering call and record it. Do not
  stop to ask.

  Two non-fixes are legal.

  **DISSOLVE.** A finding whose only basis is a qualitative clause of
  a story or decision — correct (of prose), canonical, clear,
  helpful, well-designed — per the decidability boundary in
  `skills/_shared/artifact-definitions.md` ({{DECIDABILITY-BOUNDARY}}).
  Report it as DISSOLVED with the clause quoted; the architect
  checks it. If any decidable basis exists beside the qualitative
  one, fix the decidable part.

  **KICKBACK**, gated by the veto test: would a reasonable owner,
  reading your fix as a one-line divergence report, plausibly say
  "no — I meant the other thing"? If every reasonable reading lands
  in one place, the fix is determined: make it. Kick back only when
  a reasonable owner might pick the other side — the fix would
  decide product intent, change what the corpus commits to (retire
  an artifact, rewrite a Choice, add or drop an invariant, widen or
  narrow a claim), or build net-new scope no sprint authorized. A
  kickback claims a genuine fork; the architect tests it. State the
  diverging options and why reasonable owners diverge. Inability is
  never grounds: "hard but determined" is a fix.

  ### Findings to fix

  [PASTE THE PRODUCING CHECK'S FULL OUTPUT — do not summarize or filter]

  ### Rules
  - Read files before editing.
  - Run the project's type checks and tests for the packages you
    modified. A fix that breaks the build is not done.
  - Never destroy uncommitted work: fix bad edits forward, never
    with git checkout/restore/reset/stash/clean. Do not commit.
  - If blocked (a credential you lack), say so specifically. That
    is the only other acceptable non-fix.

  ### Completion check
  Re-read the finding list and confirm every one has a fix, a
  kickback, or a dissolution. Report DONE with: a numbered
  finding→fix map; a CALLS MADE list (every call beyond what the
  sprint and corpus spell out, one line each); a CORPUS EDITS list
  (every file under `.ok-planner/design/` you edited, one line each
  with what changed); a KICKBACKS list (per kickback: the finding
  verbatim, why the fork is genuine under the veto test, the
  diverging options); a DISSOLVED list (per dissolution: the finding
  verbatim and the qualitative clause it rests on, quoted). Empty
  lists are stated as empty. Or report BLOCKED with the blocker and
  which findings it stops.
```

---

### {{CERTIFY-ARCHITECT-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Architect Review — kicked-back findings

  {{DISPATCH-DISCIPLINE}}

  A fixer has kicked back the findings below, and the sprint's
  executor may have recorded claimed forks in the completion report.
  Each kickback claims that no fix exists a reasonable owner would
  wave through — the finding is a genuine fork in product intent. A
  claimed fork makes the same claim from the build: the executor
  found the sprint and corpus silent and recorded the options. Where
  it built a reading, it built the one it judged most plausible and
  continued. You hold the owner's chair: the person whose intent the
  sprint (if one is in scope) and the design corpus under
  `.ok-planner/design/` record. Test each claim adversarially. Your
  bias is to refute; the intake is for genuine forks only.

  Per kickback, one of two outcomes:

  - **REFUTE and fix.** A resolution exists that every reasonable
    owner would land on — the contradiction exists only under a
    strained reading, the missing clause has one honest value, the
    disambiguation loses nothing anyone could want. Name the
    resolution and make the fix yourself under the fixer's rules:
    run the affected checks; edits under `.ok-planner/design/` are
    legal only while no commitment changes (never retire an
    artifact, rewrite a Choice, add or drop an invariant, widen or
    narrow a claim).
  - **CONFIRM and promote.** A reasonable owner might pick the other
    side — the fix would decide product intent, change what the
    corpus commits to, or build net-new scope no sprint authorized.
    Write the issue file per {{ISSUE-FILE-FORMAT}} (kind `audit`,
    category from the finding's nature, `status: open`, the
    diverging options as Candidates, fingerprint slug deduped
    against every slug in `.ok-planner/issues/`), and record why the
    fork is genuine.

  "It seems minor" refutes nothing; "it seems hard" confirms
  nothing. The one question is whether reasonable owners diverge.

  A claimed fork resolves the same two ways. REFUTE when every
  reasonable owner lands on one reading: if the executor built that
  reading, leave the tree alone; if it built the other, make the fix.
  CONFIRM when reasonable owners diverge: promote it, and the built
  reading stands as the tree's current answer until the owner rules.
  A claimed fork the standing reviewer raised carries no built
  reading. On REFUTE, name the resolution and make the fix yourself.
  On CONFIRM, promote it; the tree stands as it is until the owner
  rules. Either way, rewrite that entry in the completion report's
  Divergences. On REFUTE it becomes a determined call naming the
  reading that stands and how you resolved it. On CONFIRM it names
  the issue file you wrote. The next alignment pass reads the
  rewritten entry, so a resolved fork reaches you once.

  The fixer's DISSOLVED list rides with the kickbacks under the
  decidability boundary ({{DECIDABILITY-BOUNDARY}}). A dissolution
  claims the finding's only basis is a qualitative clause. If any
  decidable basis exists — an enumerable coverage, a named source,
  an observable behavior — overturn it and make the decidable fix
  yourself under the fixer's rules. If the finding rests on quality
  judgment alone, uphold it: neither fixed nor promoted.

  ### Kickbacks, dissolutions, and claimed forks

  [PASTE THE FIXER'S KICKBACKS AND DISSOLVED LISTS VERBATIM — per
  kickback: the finding, the fixer's reasoning, the diverging
  options; per dissolution: the finding and the qualitative clause
  it rests on — AND EVERY `CLAIMED FORK` FINDING THE ALIGNMENT JUDGE
  REPORTED, verbatim: the fork, its options, and the reading built]

  ### Rules
  - Read the sprint (when one is in scope) and the bearing corpus
    artifacts before ruling on any kickback.
  - The completion report sits beside the sprint, same filename with
    `-completion` before the extension. Its `## Divergences` section
    holds one entry per recorded call and per claimed fork, each
    opening with its identifier (`D<n>` or `F<n>`). Rewrite each
    resolved entry in place under its identifier.
  - Read files before editing. Never destroy uncommitted work: fix
    bad edits forward, never with git
    checkout/restore/reset/stash/clean. Do not commit.

  ### Report
  Per kickback and per claimed fork, one line: REFUTED (the
  resolution, what you changed, how verified) or PROMOTED (the issue
  file path, why the fork is genuine). Per dissolution, one line: UPHELD (the qualitative
  clause, quoted) or OVERTURNED (the decidable basis and the fix
  you made). The presentation shows REFUTED and OVERTURNED under
  Divergences, PROMOTED under Issues promoted, UPHELD under
  Dissolved.
```

---

### {{CERTIFY-CODE-REVIEW-PROMPT}}

`{{CODE-REVIEW-BRIEF}}` is the review brief with no dispatch header. This prompt wraps it in a dispatch header. The sprint's standing reviewer transcludes the same brief. The consuming gate fills `[REVIEW SCOPE]` — what is under review, how to enumerate it, and how far findings may reach beyond it — before dispatching.

```
Agent (general-purpose, model: opus):
  ## Code Review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  Do not read the completion report beside the sprint. You review the
  code blind to the executor's account of it, so a divergence it did
  not record surfaces here as a fresh finding.

  You review the finished work, so every corpus delta a sprint in
  scope carries is due. Open each affected file under
  `.ok-planner/design/` and verify the delta landed.

  {{CODE-REVIEW-BRIEF}}
```

The reviewer is a producer: its findings drain through `{{CERTIFY-REVIEW-FIX-LOOP}}`. It files nothing itself.

---

### {{CODE-REVIEW-BRIEF}}

#### Scope

[REVIEW SCOPE]

#### Source of truth
The sprint this work realizes (if one is in scope) — its deltas
and work items — is what the work was meant to accomplish. Judge
against it, not against the design corpus as an oracle. The
dispatch above names the corpus deltas you check.

#### Review focus
- Correctness: bugs, edge cases, off-by-one.
- Safety: data loss, security, resource leaks, irreversible actions.
- State integrity: stuck states, double-execution, skipped steps.
- Load-bearing properties upheld: name the properties the sprint
  depends on — durability, completeness, atomicity, ordering,
  idempotency, no-data-loss, "this record is authoritative" — and
  verify the code still guarantees each, off the happy path too.
  A property traded away for a local optimization is a finding
  even when nothing looks broken. Completeness against the
  sprint's promised outcomes is the sprint-alignment producer's,
  not yours.
- Test coverage: do tests verify real behavior? Behavior with no
  end-to-end exercise is an ordinary finding; the fix is a test.
- Tests, substance first: is each test substantive or specious —
  does it prove a behavior a user or a story owes, or only that
  the code runs? Should it extend an existing test whose scenario
  it belongs to, or stand alone? Does the suite grow only where a
  new behavior needs proving? A test that duplicates a proof, or
  proves nothing, is a finding; the fix is to remove or merge it.
  Then the testing standard (`.ok-plumbline/docs/testing.md`
  where the project carries it): a verdict that depends on elapsed
  time — a sleep, a deadline poll, a timeout as a verdict — is a
  finding; a wait on a duration where the product emits, or could
  emit, an event is a finding; a cadence the test could drive
  manually but lets run is a finding; a flaky test tuned to pass
  rather than fixed at its cause is a finding.
- Events, under the events standard (`.ok-plumbline/docs/events.md`
  where the project carries it): coverage at the named sites —
  every state transition, branch on external input, boundary
  crossed, retry, and error caught emits an event; a caught error
  that emits nothing is a finding. Each kind is a raw string
  literal in the declared convention, `SUBSYSTEM.NOUN.VERB`, with
  prose in a field and never in the kind. Each new kind is unique
  in meaning: `rg` the tree for the convention and treat a
  near-duplicate of an existing kind as a finding whose fix is to
  reuse the existing kind.
- Dead code, unused imports, stale comments.
- Findings rest on decidable defects. A quality judgment over
  prose or design — documentation that might be wrong, an
  explanation that could be clearer, a surface that feels
  unpolished — is a finding only where a procedure can settle it
  (a named source contradicted, an enumerable case missing).

#### Output
Every finding with: file:line, what is wrong, why it matters, how
to fix. Do not grade severity; every finding needs fixing. Where
you suspect a genuine intent fork (the sprint and corpus do not
determine the fix and reasonable resolutions diverge on product
intent), say so on the finding with the diverging candidates —
advisory context for the fixer, not a different bucket. You file
nothing and route nothing. "Plausibly intentional" is not the bar:
if one resolution is clearly better engineering, it is an
ordinary finding.

---

### {{STANDING-REVIEWER-PROMPT}}

The brief for the sprint's standing reviewer — the read-only worker the executing session dispatches once, at the start of the build, and feeds one landed stage per message. It carries `{{CODE-REVIEW-BRIEF}}` — the same brief the gate's cold reviewer runs — with the scope filled at dispatch, a finding ledger, and the read-only per-stage producers each present family's ceremony contribution names under its **Standing producers** heading. Nothing here is a producer of the terminal gate: the gate re-runs everything cold over the whole diff, blind to this reviewer's ledger.

**Dispatch once**, model `opus`, with the brief below. `[SPRINT PATH]` is the sprint document; `[STANDING PRODUCERS]` is the concatenation of every present family's **Standing producers** section, read from `.ok-<name>/ceremony/certify-work.md`; `[REVIEW SCOPE]` in the transcluded brief is "the paths this message names, read against the change so far; findings are confined to the increment and to what it breaks in earlier stages".

```
Agent (general-purpose, model: opus):
  ## Standing review — one stage at a time

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You are the standing reviewer for the sprint at [SPRINT PATH]. The
  session that dispatched you feeds you one landed stage per
  message and relays your findings to the builder. You review each
  increment as it lands, under the same brief the certification
  gate runs cold at the end. You edit nothing, run no suite, and
  file nothing.

  ### Per message

  Each message names a stage and lists the paths it touched. Read
  the increment in the context of the change so far — the paths of
  every stage you have already reviewed are yours to reopen — and
  confine findings to the increment and what it breaks. Do not
  re-review an earlier stage the message does not name unless the
  increment touches it.

  ### The stage's corpus deltas

  The sprint applies each corpus delta as part of the stage that
  realizes it. Only the deltas this stage landed are due. A stage that
  applied one lists the file under `.ok-planner/design/` among its
  paths. Read that file against the sprint's delta body and report any
  difference. Leave every delta no stage has landed yet to the later
  stage that carries it.

  ### The ledger

  Keep a ledger of open findings, one line each: stage, file:line,
  what is wrong. On every message, before reviewing the new stage,
  re-check each open line against the tree and close what the
  builder fixed. The builder may answer a line with a recorded fork
  rather than a fix. Read the completion report — beside the sprint
  file, same filename with `-completion` before the extension. Once
  its `## Divergences` section carries that fork with its options and
  the reading the builder built, close the line. Report the
  ledger whole at the end of every reply: the new findings, then the
  still-open lines, then the closed lines. The session holds your
  latest ledger and your open claimed forks; a replacement reviewer
  starts from both.

  A standing producer below may name one of its hits a claimed fork.
  Report that hit under a `Claimed forks` heading beside the ledger,
  for the builder to record in the completion report. Repeat it under
  that heading in every reply until the report's `## Divergences`
  section carries it, then drop it. Keep it out of the ledger: nobody
  fixes it, so it never closes.

  ### The brief

  {{CODE-REVIEW-BRIEF}}

  ### Standing producers

  Run these read-only checks over the increment on every message.
  Report each hit as a finding in the ledger. Where a producer names
  its hit a claimed fork, report it under `Claimed forks` instead.

  [STANDING PRODUCERS]
```

**Per stage**, the session sends one message: the stage's name, its paths, and the builder's one-line note on what it built. The reply is the ledger and the reviewer's claimed forks. The session relays the new and still-open lines to the builder as its next message, and every claimed fork the reply carries. The reviewer repeats each claimed fork until the report records it, so a fork the builder skipped comes back. The session holds the latest ledger and the open claimed forks for the reviewer's replacement. After the final stage, the session relays the ledger as a fix-only message and repeats that round until the reply carries an empty ledger. After **3 fix-only rounds** without an empty ledger, the session stops and puts two steps to the owner — **another round**, or **record the remainders**: the builder writes each still-open line into the completion report as a claimed fork, which closes the line in the ledger and hands it to the gate's architect. The choice is the owner's alone. The session takes neither step itself and waits, attended or not, with no default.

---

### {{CERTIFY-PRESENTATION}}

The closing step: the outcomes and any divergences, put in front of the owner. With a sprint in scope, first write the composed presentation into the sprint's completion report — the file beside the sprint, same filename with `-completion`, created if the executor did not — then walk it with the owner. Its `## Divergences` replaces the executor's section of that name: compose the merged list the template below describes, and keep each carried entry's identifier. Compose it in full; it is a file deliverable. Walk the sections in the order given, starting with `## Outcomes delivered`; name the sections the walk will cover before the first, and name the ones still to come as you go, at whatever pace the session's delivery rules set. Never start the walk on a divergence, a promoted issue, or a judgment item. Deliver every section. The walk ends with the close-out offer.

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with issues promoted

## Outcomes delivered
<Each story/decision the work realized, and the user-observable
outcome now true. For a bare goal with no sprint: what the goal
asked and what now holds.>

## Divergences
<Where the built work departed from the sprint: an overshoot
(unstated-but-necessary work built to make an outcome hold), a
forced shape-change, a delta applied differently than written; every
call the executor recorded in the completion report's Divergences
that the architect did not rewrite, and every call the fixer made
where the sprint and corpus were silent, merged into one list; every
corpus repair under `.ok-planner/design/` (file + what changed, one
line each); every architect REFUTED line (the resolution and what
changed). Each named so the owner can veto it after the fact.
"None" if the work matched the sprint and no calls, corpus edits, or
refutations were made. An undershoot never appears here — it was
fixed.>

## Findings fixed
<Count and one-line summaries per producer. "Clean on first pass"
where nothing was found.>

## Dissolved
<Every finding the fixer dissolved and the architect upheld: per
line, the finding and the clause it rested on. Omit when none.>

## Issues promoted
<Every issue this run created, by file path, with the verify pass's
outcome per issue: answered by the corpus (closed with the citation),
or verified and awaiting your ruling. Two kinds, each labeled: forks
the architect confirmed (with its why-genuine line), and remainders
escalated at the cap (with the finding and what the fix cycles
tried). These are the next sprint's business.>

<End with the close-out offer, in one or two sentences, per
{{CERTIFY-CLOSE-OUT}}.>
```

---

### {{CERTIFY-CLOSE-OUT}}

If a sprint was in scope and everything certified clean, end the presentation with the standing offer: **archive the sprint** — move it to `.ok-planner/history/sprints/` with its completion report, its delta sidecar folder where it has one, and every issue file under `.ok-planner/issues/` whose `sprint:` names it (to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word. The sprint stays at its `sprints/` path until then; where it sits is no term of the completion contract's goal rule. An uncertified sprint gets no offer. On yes, after the archive commit lands, stamp the archived sprint with `closed: <sha of the archive commit>` in its frontmatter, one small follow-on commit; `/plan-sprint`'s out-of-band reconciliation reads it. Remainders the owner escalated at the cap are verified issues like any others; the presentation and close-out proceed as normal.

---

### {{CERTIFY-GATE-BOUNDARIES}}

- Triages and defers nothing: every finding enters the review-fix loop, and only the architect's confirmed forks and the owner's cap escalation reach the intake.
- Asks the owner nothing mid-cycle: forks are promoted and everything else is fixed; the cap is the run's one stop.
- Archives and commits nothing on its own: the presentation offers both, and only the owner's word triggers either.
- Plans and builds no new scope: a gap the loop cannot drive to clean is surfaced, never filled with work no sprint promised.
