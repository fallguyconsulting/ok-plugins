# Certification core

Shared machinery for `/certify-work`, the change-scoped certification gate: the review-fix loop and its veto test, the sprint-alignment judge, the fixer and architect prompts, the code-review prompt, the presentation, and the close-out. The gate's own body is about scope and never restates these blocks. The build's task prompt lives here too, so the build and the gate read one file.

Every agent this file defines is a **task** in the task tracker at `.ok-planner/bin/tasks`, dispatched by the `execute-tasks` drain under a vendored profile. The reason is the prompt cache: every agent of one profile starts from the profile's system prompt and one fixed message, and `tasks claim` hands it its prompt, its brief, and the pool items it consumes as a tool result, after the cached prefix. No agent stands across rounds. Each task is one bounded piece of work; what it found or did goes into the run's pools, and the next task reads the pools, never a predecessor's context.

Nothing here audits. Whether the corpus's stories and decisions are still supported is the periodic `/audit` run's question, asked over the whole corpus on the owner's cadence — never at a close, never against a change.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a per-run value the consuming skill fills before it writes the prompt file. The prompts also carry `{{LEAF-AGENT-RULE}}` and `{{READ-ONLY-REVIEWER-RULE}}` from `../_shared/dispatch-discipline.md`; every task here is a leaf, under a profile that forbids subagents.

**The run.** One task run per sprint, at `.ok-planner/sprints/<sprint-name>-run.jsonl`, opened by the sprint's executor and reused by the gate; a bare gate with no sprint opens its own at `.ok-planner/tasks/certify-<date>.jsonl`. The run file is the record: it archives with the sprint, and the completion report is rendered from it. Opening a run:

1. `tasks init <name> --file <path>`. Every path a task closes with `--staged` is recorded on the task; `tasks round show` lists the paths the round's closed tasks staged, and the gate's exit test reads that list.
2. `tasks agent register ok-opus` and `tasks agent register ok-sonnet`.
3. Resolve each prompt block's transclusions and `[...]` values, write the body to `.ok-planner/.cache/sprint/<name>.md`, and `tasks prompt register <name> <path>`, for the prompts the consumer needs: the sprint's executor registers `build`; the gate registers `review-planner`, `gate-review`, `alignment`, `suite`, `fixer`, and `architect`. The directory is derived from the vendored shared files and ignored; every claim reads from it during the run, and the archive does not carry it. The run file records each prompt's sha256, and the vendored shared file at the closing commit is its text.

**The pools.** Three, and every agent writes to them with `tasks item add` and settles them with `tasks close --item <id>=<state>`:

| pool | key | what an item is |
|---|---|---|
| `findings` | the filing task's key during the build, for a defect a build task meets outside its files; `gate` at the gate, whose batching step takes the build's open items too | one finding: `--fingerprint <file:symbol or line span>`, `--field file=<path>`, `--producer <producer>`, the finding verbatim as the body. Its state is its outcome: `open`, `batched`, `fixed`, `verified`, `kickback`, `dissolve-claimed`, `refute-claimed`, `reversal` (the fixer's claims and triage's call, for the architect), `dissolved`, `refuted`, `reversal-ruled`, `promoted` (the architect's settlements, terminal), `repeat` and `recurrence` (triage's transient calls). |
| `divergences` | the filing task's key | one entry for the completion report's `## Divergences`: `--field kind=call` for a determined call, an overshoot, a shape-change, or a corpus edit; `--field kind=fork --state fork` for a claimed fork, the options and the reading built in the body. The architect settles a fork to `resolved` or `promoted`. Never a defect: a defect anyone meets goes to `findings`. |
| `batches` | `gate` | one batch of files for the judgment passes, filed by the round's review planner: `--field files=<the batch's paths as a JSON list>`, the body one line on what the batch holds. The session reads the round's items and files two judgment tasks per batch, each with the batch as its `files`. |

**The report is a rendering.** The session writes the completion report from the run before every dispatch and at the end: `tasks render --title "<the sprint's title>" --sprint <the sprint's path>` prints `## Stages` from the build tasks, `## Divergences` from the `divergences` pool with each item's id as the entry's identifier, and `## Certification ledger` from the `findings` pool at key `gate`; the session writes that output to the report file. Agents never edit the report; they file items. A session that dies leaves the run file, and a replacement renders the same report from it.

**Every task closes.** The profile's system prompt carries the claim and the close. A task that cannot finish closes `partial` with a result that says where it stopped and what is staged; the session refiles the remainder with `tasks refile <task>`.

---

### {{RELEASE-DOCUMENTS-RULE}}

Carried by every prompt in this file that reads or edits the tree: the build, the review planner, the review passes, the alignment judge, the fixer, and the architect. The rule is `decision:placed-documents-are-records` at the sites where a sprint could break it.

The documents the release regenerates are out of scope. They are every file at a target a declared document type names under `.ok-planner/surface/documents/` (a folder target covers the folder) and everything under `.ok-planner/documentation/`. `/document` rewrites them whole at the next release. Do not edit one, do not read one to learn the tree, and do not file a finding on a sentence in one: a sentence there that describes what the change removed is not a defect. Rule files under `.claude/rules/`, infrastructure files, and every other prose file stay in scope.

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

One loop drives every finding from every producer to a settled outcome. The orchestrator has no discretion inside it and never edits code or corpus itself: it files tasks, drains them, triages the `findings` pool, and counts rounds. Every fix is a task, the orchestrator's own included.

**Producers.** The gate's review passes — sprint alignment, the project's test suites, the mechanical floor, code review — each report findings at the gate's scope. A mechanical producer is an `exec` task (`tasks file --kind exec --command "<the command>" --key gate`); the drain runs it and closes it with the exit code and the output tail, and the orchestrator files one `findings` item per failure with the command as the producer. The test suites are a **suite runner** task under `ok-sonnet` (`{{SUITE-RUNNER-PROMPT}}`): it runs the project's documented full-suite command and files one finding per failure itself, so the orchestrator never reads suite output. The command is read from the project's own docs (CLAUDE.md, README, Makefile, package manifest), never invented, and recorded once in the run — `tasks config set suite_command "<command>"` — so every round and every later gate on the run runs the same instrument. Code review passes and sprint alignment are agent tasks that file their findings themselves. Producers never file issues and never fix. Nothing here writes under `.ok-planner/audits/`. A `mechanical`/`judgment` class a reviewer attaches is advisory; every finding enters the same loop. A finding grounded only in a qualitative clause is not a finding, per `{{DECIDABILITY-BOUNDARY}}` in `../_shared/artifact-definitions.md`: the fixer dissolves it and the architect checks the dissolution.

**The finding ledger.** The `findings` pool at key `gate` is the ledger, and `tasks render` prints it as one table under `## Certification ledger`, which the orchestrator writes into the completion report before every dispatch, so a session that dies mid-round leaves the record on disk twice. For a bare goal with no sprint, it prints the table in the presentation. One row per item:

| column | what it holds |
|---|---|
| `id` | the item's id, numbered continuously across rounds |
| `site` | the fingerprint: the file plus the sentence, symbol, or line span the finding names |
| `producer` | the producer that reported it |
| `round entered` | the round that first held it |
| `outcome` | the item's state: `fixed`, `verified`, `refuted`, `reversal-ruled`, `promoted`, `dissolved`, or `open`; the pass that fixed it or the issue file it became is in `note` |
| `repeats` | how many repeats of this row triage has subtracted, starting at 0 |
| `rounds touched` | how many rounds the fixer or the architect edited this site, starting at 0 (`--field rounds_touched=<n>`) |
| `note` | one line on what was done |

The code reviewer never reads the ledger: it reads no report. The fixer reads the pool for the sites its batch names. The architect reads every row it needs to rule.

**Two writers, two sections.** The orchestrator owns `## Certification ledger` and renders it from the pool. The fixer and the architect own `## Divergences`: they file `divergences` items, and the orchestrator renders them there. Each side writes only its own pool.

**The round.** Every round has one shape, the first included: plan the review, review the whole change, triage, batch and fix, rule, test for the exit. No round reads what an earlier round read. Every round's passes read the tree as it stands, so a defect one round missed is in front of the next round's reader, and a fix is verified by the passes that read its site and file nothing there.

1. **Start the round, then plan the review.** `tasks round start`, so the edit test below reads this round alone. File the review planner, `tasks file --role plan-review --prompt review-planner --agent ok-sonnet --key gate --brief "plan"`, and drain. It reads the change from git at the gate's scope, lists every changed and added file plus every file the scope adds, cuts the list into batches, and files one `batches` item per batch with the batch's paths under `files`. It reads nothing from an earlier round: the batches are the change as it stands now.
2. **Review the whole change.** Read the round's batches, `tasks item list --pool batches --key gate --json`, taking the items whose `round` is this round; each item's `fields.files` is the batch's path list. Per batch, file the two judgment passes with the batch as the task's files: `tasks file --role gate-review --prompt gate-review --agent ok-opus --key gate --brief "correctness" --files <the batch's paths>`, and the same with `test-substance`. Where the planner filed no batch — a change of deletions only, or one whose remaining files are all release documents — file no judgment pass; the enumeration passes are the round's review. File the two enumeration passes once each over the whole change, with no files: `tasks file --role gate-review --prompt gate-review --agent ok-sonnet --key gate --brief "references"`, and the same with `test-inventory`. Every pass enumerates its population before it judges, files every finding into the pool, and closes with its checked population in the result. With a sprint in scope, file the sprint-alignment judge, `tasks file --role alignment --prompt alignment --agent ok-opus --key gate --brief "judge"`: it reads the completion report's Divergences and puts each recorded call under the veto test; each claimed fork stands at `fork` in the pool for the architect. The passes never read the report, so an unrecorded divergence surfaces as a fresh finding. File the mechanical producers as exec tasks. File the suite runner, `tasks file --role suite --prompt suite --agent ok-sonnet --key gate --brief "<the run's suite_command>"`, reading the command back from `tasks status --json` under `run.config.suite_command`. Drain with `tasks next --all`; every task runs together, since every one reads the tree and none edits it. File the exec failures as findings.
3. **Triage against the ledger.** The orchestrator triages. It dispatches nobody. First re-key every finding that reached the pool under another key or none — a build task's finding under its stage key, a profile's filing with no key — to `gate`, `tasks item set <id> --key gate`, so triage and the ledger see it. Then run `tasks item triage --pool findings --key gate`: a fresh fingerprint stays `open`; a fingerprint whose prior row is settled (`refuted`, `promoted`, `dissolved`, `reversal-ruled`) becomes a **repeat**, subtracted, and the prior row's `repeats` rises by one; a fingerprint whose prior row is in any other state — `fixed`, `verified`, `batched`, `kickback`, a claim awaiting the architect — is a **recurrence**; and a row at `fixed` whose fingerprint no open finding names becomes **verified**, since the passes read its site on the tree and filed nothing there. Then read each recurrence: the finding asks for the opposite of what that fix did → a **reversal**, `tasks item set <id> --state reversal`, for the architect with both findings, never the fixer; the finding asks for the same thing again → a regression in the fix, back to `open` on that same site. A fresh fingerprint whose slug the intake already carries per `{{ISSUE-FILE-FORMAT}}` → `--state promoted --note <issue file>`, and nobody is dispatched. A fresh finding filed with `--field origin=pre-existing` claims the change did not introduce it; the mark changes nothing about what happens next. The item stays `open`, the fixer fixes it like any other, and the presentation counts it under the pre-existing defects the run fixed, so the owner sees where the sprint reached beyond its change. Where a fingerprint match is uncertain, treat the finding as new.
4. **Batch, then fix.** The orchestrator batches; it dispatches nobody for that, and it is the one judgment it makes inside the loop. Read the pool whole, `tasks item list --pool findings --key gate --state open --json`, and group by **blast radius**, never by file: a shared definition with its callers, one defect class across its sites, one surface's files, one failing suite's cause. Split a group that would exceed what one fixer can hold. File one fix task per group: `tasks batch --pool findings --key gate --items <the group's ids> --files <every path the group reaches> --prompt fixer --agent ok-opus --role fix --brief "<what the group's findings share, and where the callers and siblings are>"`, with `--after <task>` where two groups name a common path. The items are marked `batched`, and the task's `files` is the union of the items' files and the `--files` given. Groups with disjoint files run together. A fixer that staged a path outside its `files` is recorded by the tracker on its close, and the next batch's chaining reads staged paths as well as declared ones. Skip where the pool holds no open item. Drain. The fixer fixes everything the veto test allows and takes one of three legal non-fixes on the rest: DISSOLVE, KICKBACK, or REFUTE, closing each item to `fixed`, `dissolve-claimed`, `kickback`, or `refute-claimed`. A fixer task that closed `blocked` or `partial` left its items at `batched`: set each back to `open` (`tasks item set <id> --state open`) before the next step.
5. **Architect.** Where any item stands at `kickback`, `dissolve-claimed`, `refute-claimed`, or `reversal`, or any `divergences` item stands at `fork`, file one architect task: `tasks file --role architect --prompt architect --agent ok-opus --key gate --brief "rule" --consumes findings:kickback findings:dissolve-claimed findings:refute-claimed findings:reversal 'divergences:fork:*'`. Drain. The architect settles every item it consumed to a terminal state: `fixed`, `refuted`, `reversal-ruled`, `promoted`, or `dissolved` on a finding, or `open` where it hands one back; `resolved` or `promoted` on a fork. (Certification's promote — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
6. **Exit, or the next round.** Apply the edit test: `tasks round show` lists the paths staged this round, and `tasks item list --pool divergences --json` shows each item's `round`. The loop ends at **the first round in which neither the fixer nor the architect edited any file** (code, corpus, or the report's `## Divergences`) **and no finding stands open**: `round show` lists no staged path, no `divergences` item carries the round, and `tasks item count --pool findings --key gate --state open` prints zero. All three are terms of the test; a round whose fixer closed `blocked` and left its items at `open` does not exit. Every finding that round was a repeat, an upheld refutation, a promotion, or a ruled reversal, and the round's passes read the whole change as it stands and filed nothing the loop fixed. The producers confirm the same event: every pass closes `DRY`, the judge reports clean, and the exec tasks close `done`. Otherwise raise `rounds_touched` by one on every finding the round's fixer or architect edited, and start the next round at step 1.
7. **The cap, a thrash guard.** After **8 rounds** in which the fixer or the architect edited a file, the run stops. It reports every ledger row whose `rounds touched` reached three, and puts two steps to the owner — **another round**, or **escalate the open remainders**: file each item still at `open` to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem, the attempted fixes as evidence), set it `promoted`, then continue to `/verify-issues` and the presentation. The choice is the owner's alone. The run takes neither step itself and waits, attended or not, with no default. A run parked at the cap is a legal in-flight state: not done, not failed.

**Two paths reach the intake, and the owner is never asked live mid-round.** Certification creates issues only through the architect's confirmed forks and the owner's cap escalation; the pre-presentation `/verify-issues` pass makes both ruling-ready. Every defect the review finds is fixed in the loop, the ones the change did not introduce included: the fixer holds the code, and an issue filed for a defect that needs no ruling only defers the fix. Everything the executor recorded and everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, overturned kickbacks, upheld refutations, ruled reversals — surfaces in the presentation's Divergences for after-the-fact veto.

---

### {{SPRINT-ALIGNMENT-PROMPT}}

The corpus-change judge, one task per pass, under `ok-opus`: the second question, every work item realized and not undershot, is the completeness check the gate owes and a judgment the cheaper profile misses. Filed only when a sprint is in scope, once per round; the consuming gate fills `[SPRINT PATH]` when it writes the prompt file.

```
Task prompt (profile ok-opus):
  ## Sprint alignment — the corpus change, realized and coherent

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  ### Your job

  The sprint at [SPRINT PATH] is a change-order against the design
  corpus. Judge three things and file a finding for each defect:

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
     collision. Corpus edits the fixer or architect made mid-round
     are in scope: check them against the authoring rules in
     `../_shared/artifact-definitions.md`. Whole-corpus hygiene
     is `/audit`'s, not yours.
  4. **The completion report's Divergences, each under the veto
     test.** Read the report beside the sprint (same filename with
     `-completion`). Its `## Divergences` section holds one entry per
     recorded call and per claimed fork, each opening with its
     identifier, the id of its item in the run's `divergences` pool.
     For each recorded call — a determined reading the executor
     made where the sprint was silent, an overshoot, a shape-change
     — ask whether a reasonable owner, reading it as a one-line
     divergence report, would plausibly say "no — I meant the other
     thing". Would not → nothing to report; the presentation carries
     it. Might → a finding naming the call and the reading the owner
     might prefer. A **claimed fork** — an entry with its options
     and, where the executor built one, the reading it built — is
     the architect's: it stands at state `fork` in the pool and the
     loop routes it there; file nothing for it. An entry that names
     an issue file, or that states the resolution the architect
     made, is settled: report nothing for it. A missing report is a
     finding. A report with no `## Divergences` section is a finding
     too.

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  ### The pass

  Your brief says `judge`. Judge the four questions over the whole
  change as the tree stands now, every round; nothing from an
  earlier round's pass carries.

  The completion report carries the certification run's own record: a
  finding ledger and a presentation. The gate writes them while its
  loop still runs. That unfinished run is the gate's own state, not a
  finding. File nothing for it.

  ### Output

  File each finding into the pool: `tasks item add --pool findings
  --key gate --producer alignment --fingerprint "<file: the delta or
  work item it fails>" --field file=<path> --body "<what is wrong,
  where, and why it matters, with the advisory mechanical/judgment
  class>" --task <task>`. Do not grade severity. Close the task with
  the count of findings filed, or `clean`.
```

---

### {{CERTIFY-FIXER-PROMPT}}

```
Task prompt (profile ok-opus):
  ## Fix Every Finding

  {{LEAF-AGENT-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  Review passes found the findings your claim printed. Fix all of
  them, or take one of the three legal non-fixes. Your task's files
  line names where the batch's findings sit; the prompt widens it: a
  fix may edit any file the correct fix requires, the restatement
  sweep included. A defect you meet that is not a fix of your batch
  is not yours: file it into the `findings` pool at key `gate`, with
  `--field origin=pre-existing` where the change did not introduce
  it, and keep going. Do not skip, defer,
  or assess priority. No finding is "acceptable", "cosmetic",
  "pre-existing", "out of scope", "minor", or "not blocking"; code
  you did not write is still yours to fix. Read more files or change
  architecture as the fix requires. A determined fix that lands under
  `.ok-planner/design/` — a stale TOC line, a stale sentence the code
  and the counterpart artifact both contradict — is an ordinary fix:
  make it there. Where the right fix depends on intent the finding
  leaves open, resolve it from the sprint and the corpus; where they
  are silent, make the best engineering call and record it. Do not
  stop to ask.

  ### The batch

  The items your claim printed are your batch, one finding each. Fix
  every one, run the checks that cover what you changed, record your
  calls and corpus edits, and close the task.

  Settled ledger rows for the sites your batch names are in the pool:
  `tasks item list --pool findings --key gate` shows every row and its
  state, and what earlier rounds did there. Read them before you fix.
  A site already `refuted`, `dissolved`, `promoted`, or
  `reversal-ruled` is settled. A finding that reopens it is a defect
  in the earlier fix: fix the defect and leave the settlement
  standing.

  **Sweep every restatement.** A fix at one site sweeps every site
  that restates the same sentence, term, or rule. Find them with `rg`
  and fix them in the same batch, the release documents excepted. A
  fix that leaves a restatement standing is not done.

  **Fix the blast radius, never the site alone.** A fix that changes
  a function's signature or behavior lists every caller with `rg`
  and re-derives each caller's contract in the same batch: a flag a
  caller still passes that nothing reads any more is yours to fix
  now, not the next round's finding. A fix that restores or moves a
  capability makes it reachable from every surface the sprint left
  standing — the API, the CLI, the console — and you follow the
  route or the verb out with `rg` to check each one. A finding that
  says nothing asserts a behavior is fixed by the assertion and the
  code together, never the code alone. A fix at one member of a class
  (one force flag, one list route, one caller of a deleted symbol)
  sweeps every member: list them, and fix each in this batch.

  **Record your calls and corpus edits.** Before you close, file every
  call you made and every corpus edit as one item each: `tasks item
  add --pool divergences --key gate --field kind=call --body "<the
  call, or the file under .ok-planner/design/ and what changed>"
  --task <task>`. Record those two things only. A batch with no call
  and no corpus edit files nothing. The run file survives a session
  that dies mid-round; your reply does not.

  You and the architect own `## Divergences`, through that pool. The
  orchestrator owns the report's `## Certification ledger` section.
  Edit the completion report itself never.

  ### The three legal non-fixes

  **DISSOLVE.** A finding whose only basis is a qualitative clause of
  a story or decision — correct (of prose), canonical, clear,
  helpful, well-designed — per the decidability boundary in
  `../_shared/artifact-definitions.md` ({{DECIDABILITY-BOUNDARY}}).
  Close it `dissolve-claimed` with the clause quoted in its note; the
  architect checks it. If any decidable basis exists beside the
  qualitative one, fix the decidable part.

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

  **REFUTE.** The finding's premise is false, and you show it false
  with a reproduction you ran: a check you ran, a test you wrote and
  ran, or a file you quote with its line. Close it `refute-claimed`
  with the command or the quote and its output in its note. The
  architect re-runs your reproduction and hands the finding back as
  an ordinary fix where the reproduction fails. "Not worth fixing",
  "minor", and "pre-existing" refute nothing.

  ### Rules
  - Read files before editing.
  - Run the project's type checks and tests for the packages you
    modified and for every package a caller you changed lives in. A
    fix that breaks the build is not done.
  - Never destroy uncommitted work: fix bad edits forward, never
    with git checkout/restore/reset/stash/clean. Do not commit.
  - If blocked (a credential you lack), say so specifically. That
    is the only other acceptable non-fix.

  ### Completion check
  Re-read your batch and confirm every finding has a fix, a kickback,
  a dissolution, or a refutation. First write each item's note with
  `tasks item set <id> --note "<...>"`: the fix; or, for a kickback,
  why the fork is genuine under the veto test and the diverging
  options; or the qualitative clause quoted; or the reproduction
  command or quote and its output. Then close the task naming every
  item's outcome — `--item <id>=fixed`, `--item <id>=kickback`,
  `--item <id>=dissolve-claimed`, or `--item <id>=refute-claimed` —
  and every path you touched under `--staged`, one flag with every
  path after it. The result line carries the counts: fixed, a
  KICKBACK count, a DISSOLVED count, a REFUTED count, CALLS MADE and
  CORPUS EDITS counts, and `CHECKED:` the callers, surfaces, class
  members, and test modules you enumerated (`CHECKED: 3 callers of
  delete_device, 3 force flags, 2 surfaces, 4 test modules`). Or
  close `blocked` with the blocker and which findings it stops.
```

---

### {{CERTIFY-ARCHITECT-PROMPT}}

```
Task prompt (profile ok-opus):
  ## Architect Review — the loop's escalations

  {{LEAF-AGENT-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  You hold the owner's chair: the person whose intent the sprint (if
  one is in scope) and the design corpus under `.ok-planner/design/`
  record. Your task names no files; a fix you make may edit any file
  the correct fix requires. A defect you meet that no item names is
  not yours: file it into the `findings` pool at key `gate`, with
  `--field origin=pre-existing` where the change did not introduce
  it.

  Five kinds of item reach you — kickbacks, dissolutions, claimed
  forks, refutations, and reversals. Rule on every one.

  The items your claim printed are this round's escalations: each
  finding's state names its kind (`kickback`, `dissolve-claimed`,
  `refute-claimed`, `reversal`), and each `divergences` item at state
  `fork` is a
  claimed fork. Rule on every item, settle each one on the close, and
  stop.

  ### Kickbacks and claimed forks

  A fixer kicked back a finding, claiming no fix exists a reasonable
  owner would wave through — the finding is a genuine fork in product
  intent. A claimed fork makes the same claim from the build: the
  executor found the sprint and corpus silent and recorded the
  options. Where it built a reading, it built the one it judged most
  plausible and continued. Test each claim adversarially. Your bias is
  to overturn; the intake is for genuine forks only.

  Per kickback, one of two outcomes:

  - **OVERTURN and fix.** A resolution exists that every reasonable
    owner would land on — the contradiction exists only under a
    strained reading, the missing clause has one honest value, the
    disambiguation loses nothing anyone could want. Name the
    resolution and make the fix yourself under the fixer's rules:
    run the affected checks; edits under `.ok-planner/design/` are
    legal only while no commitment changes (never retire an
    artifact, rewrite a Choice, add or drop an invariant, widen or
    narrow a claim). Settle the item `fixed`.
  - **CONFIRM and promote.** A reasonable owner might pick the other
    side — the fix would decide product intent, change what the
    corpus commits to, or build net-new scope no sprint authorized.
    Write the issue file per {{ISSUE-FILE-FORMAT}} (kind `audit`,
    category from the finding's nature, `status: open`, the
    diverging options as Candidates, fingerprint slug deduped
    against every slug in `.ok-planner/issues/`), record why the
    fork is genuine, and settle the item `promoted` with the issue
    file in its note.

  "It seems minor" overturns nothing; "it seems hard" confirms
  nothing. The one question is whether reasonable owners diverge.

  A claimed fork resolves the same two ways. OVERTURN when every
  reasonable owner lands on one reading: if the executor built that
  reading, leave the tree alone; if it built the other, make the fix.
  CONFIRM when reasonable owners diverge: promote it, and the built
  reading stands as the tree's current answer until the owner rules.
  Either way, rewrite the fork's `divergences` item: `tasks
  item set <id> --state resolved --note "<the reading that stands and
  how you resolved it>"` on OVERTURN, `--state promoted --note "<the
  issue file>"` on CONFIRM. The next alignment pass reads the
  rendered entry, so a resolved fork reaches you once.

  ### Dissolutions

  The fixer's `dissolve-claimed` items ride with the kickbacks under the
  decidability boundary ({{DECIDABILITY-BOUNDARY}}). A dissolution
  claims the finding's only basis is a qualitative clause. If any
  decidable basis exists — an enumerable coverage, a named source,
  an observable behavior — record DISSOLUTION OVERTURNED, make the
  decidable fix yourself under the fixer's rules, and settle the item
  `fixed`. If the finding rests on quality judgment alone, record
  DISSOLUTION UPHELD and settle it `dissolved`: neither fixed nor
  promoted.

  ### Refutations

  The fixer refuted a finding by showing its premise false with a
  reproduction. Re-run that reproduction yourself. Your bias here is
  to uphold the finding: the fixer is the party with the incentive
  not to fix. The reproduction holds → record REFUTED, settle the item
  `refuted`, and leave the tree alone. The reproduction fails → hand
  the finding back as an ordinary fix: settle it `open`, and say so
  in your result.

  ### Reversals

  Two findings name one site and ask for opposite things. An earlier
  round fixed the site one way; this round's finding asks for the
  other. Read both findings and the site's rows in the pool, then
  rule which reading holds under the sprint and the corpus. Settle the
  loser `reversal-ruled` with your ruling in its note, and leave the
  site with the reading you upheld. A reversal never returns to the
  fixer, unless you rule the earlier fix wrong: then settle it `open`
  once, carrying your ruling in the note.

  ### Rules
  - Read the sprint (when one is in scope) and the bearing corpus
    artifacts before ruling on any kickback.
  - The completion report sits beside the sprint, same filename with
    `-completion` before the extension. Its `## Divergences` section
    is rendered from the `divergences` pool, one entry per item,
    each opening with the item's id. Rewrite a resolved entry through
    its item, never in the file. Record your own calls and corpus
    edits as the fixer does: one `divergences` item each, `--field
    kind=call`. You and the fixer own that pool. The orchestrator
    owns the report's `## Certification ledger` section.
  - Read files before editing. Never destroy uncommitted work: fix
    bad edits forward, never with git
    checkout/restore/reset/stash/clean. Do not commit.

  ### Report
  Per kickback and per claimed fork, one line in the item's note:
  KICKBACK OVERTURNED (the resolution, what you changed, how
  verified) or PROMOTED (the issue file path, why the fork is
  genuine). Per dissolution, one line: DISSOLUTION UPHELD (the
  qualitative clause, quoted) or DISSOLUTION OVERTURNED (the
  decidable basis and the fix you made). Per refutation, one line:
  REFUTATION UPHELD (the reproduction you re-ran and its output) or
  REFUTATION OVERTURNED (why the reproduction fails, and the finding
  handed back). Per reversal, one line: REVERSAL RULED (both
  readings, which one holds, and why under the sprint and corpus).
  The presentation shows KICKBACK OVERTURNED, DISSOLUTION OVERTURNED,
  REFUTATION UPHELD, and REVERSAL RULED under Divergences, PROMOTED
  under Issues promoted, and DISSOLUTION UPHELD under Dissolved.
  Close the task with every item's state under `--item`, every path
  you touched under `--staged`, and the counts in the result.
```

---

### {{CERTIFY-REVIEW-PLANNER-PROMPT}}

The review planner, one task per round, under `ok-sonnet`. It reads the change from git and cuts the files the judgment passes read into batches, so every file in the change lands in exactly one judgment task's `files` and the tracker holds the record of what each pass was given. It judges nothing and files no finding. The consuming gate fills `[REVIEW SCOPE]` when it writes the prompt file.

```
Task prompt (profile ok-sonnet):
  ## Plan the code review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  ### Scope

  [REVIEW SCOPE]

  ### The job

  Cut the files under review into batches for the judgment passes.
  Each batch becomes two review tasks, one per judgment pass, and a
  task's `files` is its batch. You read the tree as it stands now and
  nothing from an earlier round: a round's batches are the whole
  change as of that round.

  1. Enumerate the change with git — `git status`, `git diff --stat`,
     and the diff at the scope above — and list every changed and
     added file, plus every file the scope above adds, minus every
     release document. A deleted file has nothing to read and goes
     in no batch; the enumeration passes cover what its deletion
     left behind.
  2. Cut the list into batches. A batch is what one reader holds in
     full: up to about ten files, fewer where the files are long. Put
     a changed definition and its changed callers in one batch, and a
     test with the code it proves, so a judgment pass sees both
     sides. A file lands in exactly one batch.
  3. File one item per batch: `tasks item add --pool batches --key
     gate --body "<what the batch holds, one line>" --field
     'files=["<path>","<path>"]' --task <task>`, the whole `--field`
     value in one quoted argument so the shell passes the list as
     one word.
  4. Close with the counts in the result: files listed for
     batching, files batched, batches filed. The first two counts
     are equal, since every file listed for batching lands in
     exactly one batch; where they are not, the task is not done.
```

---

### {{CERTIFY-CODE-REVIEW-PROMPT}}

`{{CODE-REVIEW-BRIEF}}` is the review brief with no dispatch header. This prompt wraps it in a task header and a pass protocol: every round is four passes, each applying the brief's headings its row names — two enumeration passes on `ok-sonnet` over the whole change, where the heading reduces to enumerate-then-grep, and two judgment passes on `ok-opus` per batch the review planner cut, where it is judgment. One prompt serves every pass; the task's brief names the pass, the task's profile is the row's, and a judgment task's `files` is its batch. The consuming gate fills `[REVIEW SCOPE]` — what is under review, how to enumerate it, and how far findings may reach beyond it — when it writes the prompt file.

```
Task prompt (profile: the pass's row):
  ## Code Review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  Do not read the completion report beside the sprint. You review the
  code blind to the executor's account of it, so a divergence it did
  not record surfaces here as a fresh finding.

  You review the finished work, so every corpus delta a sprint in
  scope carries is due. On a judgment pass, open each file under
  `.ok-planner/design/` in your batch and verify the delta to it
  landed.

  ### The passes

  Your brief names one pass from this table. A pass covers what its
  row says and nothing else; the other rows are other tasks' work.
  An enumeration pass covers the whole change, and its task names no
  files. A judgment pass covers the batch its task's `files` names,
  one batch of the change the review planner cut this round; the
  other batches are other tasks' work. The two enumeration rows
  widen the brief's own headings with the populations they list. The
  brief's last rule, that a finding rests on a decidable defect,
  binds every pass.

  | pass | profile | what the pass covers |
  |---|---|---|
  | `references` | ok-sonnet | Dead code, unused imports, stale comments. Every name the change deletes or renames — symbol, column, table, route, verb, option, template block, config key, fixture, constant, annotation slug — grepped across the tree for a remaining reference. Every symbol the change leaves whose callers it deleted. Every parameter or flag left threaded through a call chain but read by nothing. Every operator-facing sentence, rule file, and infrastructure file outside the release documents that still describes what the change removed. |
  | `test-inventory` | ok-sonnet | Fixtures, constants, and parametrize entries naming what the change removed. Every test the change deletes, and each behavior it proved that survives in the product with no proof left. Every `@story:`, `@concept:`, and `@decision:` slug in a changed file resolving under `.ok-planner/design/`. Suites the change did not run. |
  | `correctness` | ok-opus | Correctness. Safety. State integrity. Load-bearing properties upheld. Events. |
  | `test-substance` | ok-opus | Test coverage. Tests, substance first, under the testing standard. |

  On a pass:

  1. Enumerate the change with git first. On an enumeration pass:
     `git status`, `git diff --stat`, and the diff at the scope
     above, deleted files included; write down every changed file.
     On a judgment pass: the diff at the scope above for each file
     your task names, and nothing else; those files are your
     population.
  2. Enumerate your population before you judge: the names, symbols,
     flags, fixtures, slugs, properties, or tests your headings apply
     to. Where a heading names a class of site — every force flag,
     every list route, every caller of a changed function — list
     every member with `rg` and judge each one. A defect on one member
     is filed on every member that shares it, one finding each, so
     the fixer holds the class whole.
  3. Read every file in your batch in full on a judgment pass; the
     diff shows what moved and the file shows what it means. Follow every
     reference out of the change on an enumeration pass; the defect
     is in the file the change did not touch. A defect you meet that
     the change did not introduce — the same code stands at the
     scope's base, `git show <base>:<path>` — is still a finding:
     file it with `--field origin=pre-existing`, and the loop fixes
     it like any other; the mark only tells the presentation where
     the run reached beyond the change. Never drop a defect for
     being pre-existing, and never widen your reading to hunt for
     them: your population is the change and what it reaches.
  4. File findings as you read, rather than holding them to the end:
     `tasks item add --pool findings --key gate --producer code-review
     --fingerprint "<file:symbol or line span>" --field file=<path>
     --body "<file:line, what is wrong, why it matters, how to fix>"
     --task <task>`.
  5. Close with the checked population in the result, one `CHECKED:`
     line per heading, a count and what it counts (`CHECKED: 56
     deleted names grepped, 11 orphaned symbols, 4 threaded flags`).
     A pass you could not finish closes `partial` with the population
     it did check and the members it did not, so the next pass task
     starts from the unchecked members. Add `DRY` where a complete
     pass filed nothing new.

  {{CODE-REVIEW-BRIEF}}
```

The passes are producers: their findings drain through `{{CERTIFY-REVIEW-FIX-LOOP}}`. They file nothing into the intake.

---

### {{SUITE-RUNNER-PROMPT}}

The test suites as a task, so no session reads suite output. The gate fills the brief with the run's `suite_command`.

```
Task prompt (profile ok-sonnet):
  ## Run the suites and file every failure

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  Your brief is the command. Run it from the project root, whole,
  once. Do not narrow it to the changed files, do not rerun a failing
  test to see whether it passes a second time, and fix nothing.

  When it exits, read its output and the results file it writes where
  it writes one (a JUnit XML, a summary line). For every failing or
  erroring test, file one finding: `tasks item add --pool findings
  --key gate --producer "<the command>" --fingerprint "<test
  file>::<test id>" --field file=<test file> --body "<test id>: the
  assertion or error, the last frames of the traceback, and what the
  test asserts>" --task <task>`. A run the harness stopped before the
  end — a watchdog, a timeout, a crash — is one finding of its own,
  fingerprinted on the command, with the output's tail in the body.

  No failure is "pre-existing", "flaky", or "environmental" here.
  Every one is a finding, and the fixer decides what it is.

  Close the task with the counts in the result: passed, failed,
  errored, filed. Close `blocked` only where the command itself could
  not start, naming why.
```

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
  rather than fixed at its cause is a finding. Three shapes escape a
  fixed detector, so read for them: an elapsed-time comparison
  inside an assertion; a timeout context feeding a call whose
  success the test asserts; a timer whose firing changes the
  outcome. One rule judges all three — a deadline that is the input
  under test is fine, and a deadline whose expiry decides pass or
  fail is a finding.
- Suites the change did not run. For each one, `rg` for assertions
  about the behavior the change altered, then read whether the
  change falsifies them. An assertion the change breaks is a
  finding, whether or not anything ran it here.
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

### {{BUILD-TASK-PROMPT}}

The build's task prompt. The executing session files one build task per stage — the smallest change that makes progress toward the completion contract and leaves the tree runnable — under this prompt. No review runs during the build; the gate reviews the finished work. `[SPRINT PATH]` is the sprint document, filled when the session writes the prompt file.

```
Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  {{LEAF-AGENT-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  You build one stage of the sprint at [SPRINT PATH]. Your brief
  names the work items the stage lands, the corpus deltas it applies,
  and any collateral the planner captured for it. Your task's files
  are the paths you may edit and the test modules you run. Read the
  sprint's intent, deltas, and the work items you land before you
  write.

  ### The stage

  - Write the code. Apply each corpus delta the stage carries: copy
    the final-form body into `.ok-planner/design/` verbatim (from the
    sidecar where the heading points there), or delete the file for
    a retirement.
  - Every new or amended story implemented in code is exercised
    end-to-end by a test in the project's ordinary suites, carrying
    the `@story:` annotation. Write the tests with the work. No test
    checks the existence of static text, code, or prose.
  - Run the tests that cover what you built, never the full suites;
    the gate runs the regression. Leave the tree runnable: what you
    touched passes, and nothing is half-wired.
  - Leave `.ok-planner/audits/` and `.ok-planner/experiments/`
    untouched: only a running `/audit` reads or writes them.
  - Completeness is the floor. Never stub, defer, narrow, no-op, or
    leave a `TODO` in place of a promised outcome. Deliver every
    outcome the brief promises in full, or close `blocked` naming
    what stops you.
  - Remove the whole of what you remove. A deletion lists every
    reference to the deleted name with `rg` — callers, fixtures,
    templates, config, rules, operator-facing text outside the
    release documents — and takes each one in the same stage, or
    files the ones outside your files as findings under your key.

  ### Calls and forks

  You never file an issue and never stop to ask. Where the sprint is
  silent, make the most plausible call, continue, and record it:
  `tasks item add --pool divergences --key <your key> --field
  kind=call --body "<the call>" --task <task>`. Where the sprint and
  corpus do not determine the fix and reasonable owners diverge,
  record the fork with its options and the reading you built:
  `--field kind=fork --state fork`. The gate's architect reads both.

  ### Rules
  - Work only within your task's files. Anything you meet outside
    them is not yours to fix: file it into the `findings` pool under
    your key and keep going; the gate's batching step takes it.
  - Never destroy uncommitted work. Stage the paths you touched by
    name as you finish (`git add <paths>`). Never run `git
    checkout`/`restore`/`reset`/`stash`/`clean`. Fix a bad edit
    forward by editing again. Do not commit.
  - Read files before editing.

  ### Close
  Close the task with every path you touched under `--staged`, one
  flag with every path after it, and one line in the result naming
  what the stage now does. A stage you could not finish closes
  `partial` with exactly where you stopped and what is staged; the
  session refiles the remainder.
```

---

### {{CERTIFY-PRESENTATION}}

The closing step: the outcomes and any divergences, put in front of the owner. With a sprint in scope, first write the composed presentation into the sprint's completion report — the file beside the sprint, same filename with `-completion`, created if the executor did not — then walk it with the owner. Its `## Divergences` replaces the rendered section of that name: compose the merged list the template below describes, and keep each carried entry's identifier. Compose it in full; it is a file deliverable. Walk the sections in the order given, starting with `## Outcomes delivered`; name the sections the walk will cover before the first, and name the ones still to come as you go, at whatever pace the session's delivery rules set. Never start the walk on a divergence, a promoted issue, or a judgment item. Deliver every section. The walk ends with the close-out offer.

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
call the build recorded in the `divergences` pool that the architect
did not rewrite, and every call the fixer made where the sprint and
corpus were silent, merged into one list; every corpus repair under
`.ok-planner/design/` (file + what changed, one line each); every
architect KICKBACK OVERTURNED line (the resolution and what changed);
every architect DISSOLUTION OVERTURNED line (the decidable basis and
the fix it made); every finding the loop refuted (the finding and the
reproduction that showed its premise false); every reversal the
architect ruled (both findings and the ruling). Each named so the
owner can veto it after the fact. "None" if the work matched the
sprint and no calls, corpus edits, refutations, or reversals were
made. An undershoot never appears here — it was fixed.>

## Findings fixed
<Count and one-line summaries per producer. "Clean on first pass"
where nothing was found. Add one line for the pre-existing defects
the run fixed: the count of findings marked `origin=pre-existing`,
each with its file, so the owner sees where the run reached beyond
the change. Add one line for the loop's subtractions:
how many repeats the triage subtracted and how many reversals the
architect ruled. Add one line for the run's cost: the usage `tasks
status` totals, and the task count from `tasks report`.>

## The finding ledger
<With a sprint in scope, name this report's `## Certification ledger`
section; the table is already there, rendered from the run. For a
bare goal with no sprint, print the table here.>

## Dissolved
<Every finding the fixer dissolved and the architect upheld: per
line, the finding and the clause it rested on. Omit when none.>

## Issues promoted
<Every issue this run created, by file path, with `/verify-issues`'s
outcome per issue: answered by the corpus (closed with the citation),
or verified and awaiting your ruling. Two kinds, each labeled: forks
the architect confirmed (with its why-genuine line), and remainders
escalated at the cap (with the finding and what the fix rounds
tried). These are the next sprint's business.>

<End with the close-out offer, in one or two sentences, per
{{CERTIFY-CLOSE-OUT}}.>
```

---

### {{CERTIFY-CLOSE-OUT}}

If a sprint was in scope and everything certified clean, end the presentation with the standing offer: **archive the sprint** — move it to `.ok-planner/history/sprints/` with its completion report, its run file (`<sprint-name>-run.jsonl`), its delta sidecar folder where it has one, and every issue file under `.ok-planner/issues/` whose `sprint:` names it (to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word. The sprint stays at its `sprints/` path until then; where it sits is no term of the completion contract's goal rule. An uncertified sprint gets no offer. On yes, after the archive commit lands, stamp the archived sprint with `closed: <sha of the archive commit>` in its frontmatter, one small follow-on commit; `/plan-sprint`'s out-of-band reconciliation reads it. Remainders the owner escalated at the cap are verified issues like any others; the presentation and close-out proceed as normal.

---

### {{CERTIFY-GATE-BOUNDARIES}}

- Triages and defers nothing: every finding enters the review-fix loop and is fixed there, the defects the change did not introduce included; only the architect's confirmed forks and the owner's cap escalation reach the intake.
- Asks the owner nothing mid-round: forks are promoted and everything else is fixed; the cap is the run's one stop.
- Archives and commits nothing on its own: the presentation offers both, and only the owner's word triggers either.
- Plans and builds no new scope: a gap the loop cannot drive to clean is surfaced, never filled with work no sprint promised.
- Dispatches no agent directly: every reviewer, judge, fixer, and architect is a task in the run, dispatched by the drain under its profile.

<!-- Materialized by ok-planner v20.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
