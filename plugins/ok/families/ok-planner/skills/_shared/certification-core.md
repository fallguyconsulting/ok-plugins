# Certification core

Shared machinery for `/certify-work`, the change-scoped certification gate: the review-fix loop and its veto test, the sprint-alignment judge, the fixer and architect prompts, the code-review prompt, the presentation, and the close-out. The gate's own body is about scope and never restates these blocks. The build's two task prompts live here too: the build task and the build review, which wraps the same code-review brief the gate runs cold, so review during the build and review at the gate apply one brief.

Every agent this file defines is a **task** in the task tracker at `.ok-planner/bin/tasks`, dispatched by the `execute-tasks` drain under a vendored profile. The reason is the prompt cache: every agent of one profile starts from the profile's system prompt and one fixed message, and `tasks claim` hands it its prompt, its brief, and the pool items it consumes as a tool result, after the cached prefix. No agent stands across rounds. Each task is one bounded piece of work; what it found or did goes into the run's pools, and the next task reads the pools, never a predecessor's context.

Nothing here audits. Whether the corpus's stories and decisions are still supported is the periodic `/audit` run's question, asked over the whole corpus on the owner's cadence — never at a close, never against a change.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a per-run value the consuming skill fills before it writes the prompt file. The prompts also carry `{{LEAF-AGENT-RULE}}` and `{{READ-ONLY-REVIEWER-RULE}}` from `skills/_shared/dispatch-discipline.md`; every task here is a leaf, under a profile that forbids subagents.

**The run.** One task run per sprint, at `.ok-planner/sprints/<sprint-name>-run.jsonl`, opened by the sprint's executor and reused by the gate; a bare gate with no sprint opens its own at `.ok-planner/tasks/certify-<date>.jsonl`. The run file is the record: it archives with the sprint, and the completion report is rendered from it. Opening a run:

1. `tasks init <name> --file <path>`, then `tasks config set staged_pool staged`, so every path a task closes with `--staged` becomes an item in the `staged` pool, keyed by the task's key, at state `unread`. A review task consumes those items and reads exactly the paths the builds and fixes before it touched.
2. `tasks agent register ok-opus` and `tasks agent register ok-sonnet`.
3. Resolve each prompt block's transclusions and `[...]` values, write the body to `.ok-planner/.cache/sprint/<name>.md`, and `tasks prompt register <name> <path>`, for the prompts the consumer needs: the sprint's executor registers `build` and `review`; the gate registers `gate-review`, `alignment`, `fixer`, and `architect`. The directory is derived from the vendored shared files and ignored; every claim reads from it during the run, and the archive does not carry it. The run file records each prompt's sha256, and the vendored shared file at the closing commit is its text.

**The pools.** Three, and every agent writes to them with `tasks item add` and settles them with `tasks close --item <id>=<state>`:

| pool | key | what an item is |
|---|---|---|
| `findings` | the stage key during the build; `gate` at the gate | one finding: `--fingerprint <file:symbol or line span>`, `--field file=<path>`, `--producer <producer>`, the finding verbatim as the body. Its state is its outcome: `open`, `batched`, `fixed`, `verified`, `kickback`, `dissolve-claimed`, `refute-claimed`, `reversal` (the fixer's claims and triage's call, for the architect), `dissolved`, `refuted`, `reversal-ruled`, `promoted` (the architect's settlements, terminal), `repeat`, `recorded`. |
| `divergences` | the filing task's key | one entry for the completion report's `## Divergences`: `--field kind=call` for a determined call, an overshoot, a shape-change, or a corpus edit; `--field kind=fork --state fork` for a claimed fork, the options and the reading built in the body. The architect settles a fork to `resolved` or `promoted`. |
| `staged` | the closing task's key | one path a task staged, flipped to `unread` by the tracker on every close; a review task sets each to `read`. |

**The report is a rendering.** The session writes the completion report from the run before every dispatch and at the end: `## Stages` from the build tasks (`tasks dump --type task` prints each task's key, cites, brief, state, and outcome), `## Divergences` from the `divergences` pool with each item's id as the entry's identifier, and `## Certification ledger` from the `findings` pool at key `gate`. Agents never edit the report; they file items. A session that dies leaves the run file, and a replacement renders the same report from it.

**Every task closes.** The profile's system prompt carries the claim and the close. A task that cannot finish closes `partial` with a result that says where it stopped and what is staged; the session refiles the remainder with `tasks refile <task>`.

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

One loop drives every finding from every producer to a settled outcome. The orchestrator has no discretion inside it and never edits code or corpus itself: it files tasks, drains them, triages the `findings` pool, and counts rounds. Every fix is a task, the orchestrator's own included.

**Producers.** The gate's review passes — sprint alignment, the project's test suites, the mechanical floor, code review — each report findings at the gate's scope. A suite or a mechanical producer is an `exec` task (`tasks file --kind exec --command "<the command>" --key gate`); the drain runs it and closes it with the exit code and the output tail, and the orchestrator files one `findings` item per failure with the command as the producer. Code review and sprint alignment are agent tasks that file their findings themselves. Producers never file issues and never fix. Nothing here writes under `.ok-planner/audits/`. A `mechanical`/`judgment` class a reviewer attaches is advisory; every finding enters the same loop. A finding grounded only in a qualitative clause is not a finding, per `{{DECIDABILITY-BOUNDARY}}` in `skills/_shared/artifact-definitions.md`: the fixer dissolves it and the architect checks the dissolution.

**The finding ledger.** The `findings` pool at key `gate` is the ledger, and the orchestrator renders it as one table under `## Certification ledger` in the completion report before every dispatch, so a session that dies mid-round leaves the record on disk twice. It creates that section where the report lacks one. For a bare goal with no sprint, it prints the table in the presentation. One row per item:

| column | what it holds |
|---|---|
| `id` | the item's id, numbered continuously across rounds |
| `site` | the fingerprint: the file plus the sentence, symbol, or line span the finding names |
| `producer` | the producer that reported it |
| `round entered` | the round that first held it |
| `outcome` | the item's state: `fixed <pass>`, `refuted`, `reversal-ruled`, `promoted <issue file>`, `dissolved`, or `open` |
| `repeats` | how many repeats of this row triage has subtracted, starting at 0 |
| `rounds touched` | how many rounds the fixer or the architect edited this site, starting at 0 (`--field rounds_touched=<n>`) |
| `note` | one line on what was done |

The code reviewer never reads the ledger: it reads no report. The fixer reads the pool for the sites its batch names. The architect reads every row it needs to rule.

**Two writers, two sections.** The orchestrator owns `## Certification ledger` and renders it from the pool. The fixer and the architect own `## Divergences`: they file `divergences` items, and the orchestrator renders them there. Each side writes only its own pool.

**Phase A — the exhaustive first sweep.** `tasks round start`. File the code reviewer, `tasks file --role gate-review --prompt gate-review --agent ok-opus --key gate --brief "sweep"`: it enumerates the change with git, reads every changed file in full, files every finding into the pool, and closes with its file ledger in the result. With a sprint in scope, file the sprint-alignment judge, `tasks file --role alignment --prompt alignment --agent ok-sonnet --key gate --brief "judge"`: it reads the completion report's Divergences and puts each recorded call under the veto test; each claimed fork stands at `fork` in the pool for the architect. The code reviewer never reads the report, so an unrecorded divergence surfaces as a fresh finding. File the mechanical producers and the test suites as exec tasks. Drain with `tasks next --all`; every task runs together. File the exec failures as findings.

**Phase B — the round.** One round is one pass: triage, fixer, architect, re-verification.

1. **Start the round, then triage against the ledger.** `tasks round start`, so the edit test below reads this round alone. The orchestrator triages. It dispatches nobody. Run `tasks item triage --pool findings --key gate`: a fresh fingerprint stays `open`; a fingerprint whose prior row is settled (`refuted`, `promoted`, `dissolved`, `reversal-ruled`) becomes a **repeat**, subtracted, and the prior row's `repeats` rises by one; a fingerprint whose prior row is in any other state — `fixed`, `verified`, `batched`, `kickback`, a claim awaiting the architect — is a **recurrence**. Then read each recurrence: the finding asks for the opposite of what that fix did → a **reversal**, `tasks item set <id> --state reversal`, for the architect with both findings, never the fixer; the finding asks for the same thing again → a regression in the fix, back to `open` on that same site. A fresh fingerprint whose slug the intake already carries per `{{ISSUE-FILE-FORMAT}}` → `--state promoted --note <issue file>`, and nobody is dispatched. Where a fingerprint match is uncertain, treat the finding as new.
2. **Fixer.** `tasks batch --pool findings --key gate --state open --group-by fields.file --size 8 --prompt fixer --agent ok-opus --role fix`: one fixer task per file group, the items marked `batched`, each task's `files` set from the items. Skip where the pool holds no open item. Fixer tasks run one at a time, because a fix may reach any file: chain each printed task after the one before it, `tasks task set <next> --field 'after=["<previous>"]'`. Drain. The fixer fixes everything the veto test allows and takes one of three legal non-fixes on the rest: DISSOLVE, KICKBACK, or REFUTE, closing each item to `fixed`, `dissolve-claimed`, `kickback`, or `refute-claimed`. A fixer task that closed `blocked` or `partial` left its items at `batched`: set each back to `open` (`tasks item set <id> --state open`) before the next step.
3. **Architect.** Where any item stands at `kickback`, `dissolve-claimed`, `refute-claimed`, or `reversal`, or any `divergences` item stands at `fork`, file one architect task: `tasks file --role architect --prompt architect --agent ok-opus --key gate --brief "rule" --consumes findings:kickback findings:dissolve-claimed findings:refute-claimed findings:reversal 'divergences:fork:*'`. Drain. The architect settles every item it consumed to a terminal state: `fixed`, `refuted`, `reversal-ruled`, `promoted`, or `dissolved` on a finding, or `open` where it hands one back; `resolved` or `promoted` on a fork. (Certification's promote — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
4. **Re-verify.** Apply the edit test first: `tasks round show` lists the paths staged this round, and `tasks item list --pool divergences --json` shows each item's `round`. Where no path was staged and no `divergences` item carries the current round, skip re-verification and go to step 5. Otherwise raise `rounds_touched` by one on every finding the round edited. Then file a verification review, `tasks file --role gate-review --prompt gate-review --agent ok-opus --key gate --brief "verify" --consumes staged:unread findings:fixed`: it verifies each fixed finding on the tree, re-reads every staged path in full, files every new finding, and sets each fixed item to `verified` or back to `open`. With a sprint in scope, file the alignment judge again with the changed files in its brief. Re-file the mechanical producers and the test suites as exec tasks. Drain. A finding sent back to `open` returns to the fixer on its own row.
5. **Exit.** The loop ends at **the first round in which neither the fixer nor the architect edited any file** (code, corpus, or the report's `## Divergences`): `round show` lists no staged path, and no `divergences` item carries the round. Every finding that round was a repeat, an upheld refutation, a promotion, or a ruled reversal. The tree did not move, so re-verification would read the same tree. The producers confirm the same event: the reviewer's sweep closes with nothing new, the judge reports clean, the exec tasks close `done`, and no item stands at `open`.
6. **The cap, a thrash guard.** After **8 rounds** in which the fixer or the architect edited a file, the run stops. It reports every ledger row whose `rounds touched` reached three, and puts two steps to the owner — **another round**, or **escalate the open remainders**: file each item still at `open` to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem, the attempted fixes as evidence), set it `promoted`, then continue to `/verify-issues` and the presentation. The choice is the owner's alone. The run takes neither step itself and waits, attended or not, with no default. A run parked at the cap is a legal in-flight state: not done, not failed.

**Two paths reach the intake, and the owner is never asked live mid-round.** Certification creates issues only through the architect's confirmed forks and the owner's cap escalation; the pre-presentation `/verify-issues` pass makes both ruling-ready. Everything the executor recorded and everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, overturned kickbacks, upheld refutations, ruled reversals — surfaces in the presentation's Divergences for after-the-fact veto.

---

### {{SPRINT-ALIGNMENT-PROMPT}}

The corpus-change judge, one task per pass. Filed only when a sprint is in scope; the consuming gate fills `[SPRINT PATH]` when it writes the prompt file. A verification pass names the changed files in the task's brief.

```
Task prompt (profile ok-sonnet):
  ## Sprint alignment — the corpus change, realized and coherent

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

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
     `skills/_shared/artifact-definitions.md`. Whole-corpus hygiene
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

  Your brief says `judge` or names the files that changed since the
  last pass. On `judge`, judge the four questions over the whole
  change. On a file list, judge them again over those files only.

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

  Review passes found the findings your claim printed. Fix all of
  them, or take one of the three legal non-fixes. Your task's files
  line names where the batch's findings sit; the prompt widens it: a
  fix may edit any file the correct fix requires, the restatement
  sweep included. A defect you meet that is not a fix of your batch
  is not yours: file it into the `findings` pool at key `gate` and
  keep going. Do not skip, defer,
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
  and fix them in the same batch. A fix that leaves a restatement
  standing is not done.

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
  `skills/_shared/artifact-definitions.md` ({{DECIDABILITY-BOUNDARY}}).
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
    modified. A fix that breaks the build is not done.
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
  and every path you touched under `--staged`. The result line
  carries the counts: fixed, a KICKBACK count, a DISSOLVED count,
  a REFUTED count, and CALLS MADE and CORPUS EDITS counts. Or close
  `blocked` with the blocker and which findings it stops.
```

---

### {{CERTIFY-ARCHITECT-PROMPT}}

```
Task prompt (profile ok-opus):
  ## Architect Review — the loop's escalations

  {{LEAF-AGENT-RULE}}

  You hold the owner's chair: the person whose intent the sprint (if
  one is in scope) and the design corpus under `.ok-planner/design/`
  record. Your task names no files; a fix you make may edit any file
  the correct fix requires. A defect you meet that no item names is
  not yours: file it into the `findings` pool at key `gate`.

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
  A claimed fork the build's reviewer raised carries no built
  reading. On OVERTURN, name the resolution and make the fix yourself.
  On CONFIRM, promote it; the tree stands as it is until the owner
  rules. Either way, rewrite the fork's `divergences` item: `tasks
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

### {{CERTIFY-CODE-REVIEW-PROMPT}}

`{{CODE-REVIEW-BRIEF}}` is the review brief with no dispatch header. This prompt wraps it in a task header and a sweep protocol: a sweep task reads the whole change once in full; a verification task re-reads what a round staged and verifies what the fixer resolved. The build's review task transcludes the same brief. The consuming gate fills `[REVIEW SCOPE]` — what is under review, how to enumerate it, and how far findings may reach beyond it — when it writes the prompt file.

```
Task prompt (profile ok-opus):
  ## Code Review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  Do not read the completion report beside the sprint. You review the
  code blind to the executor's account of it, so a divergence it did
  not record surfaces here as a fresh finding.

  You review the finished work, so every corpus delta a sprint in
  scope carries is due. Open each affected file under
  `.ok-planner/design/` and verify the delta landed.

  ### How the sweep runs

  Your brief says `sweep` or `verify`.

  On `sweep`:

  1. Enumerate the change with git first — `git status`, `git diff
     --stat`, and the diff at the scope above — and write down every
     changed file.
  2. Keep a file ledger over that list: one line per file, marked read
     or unread.
  3. Read every changed file in full. The diff shows what moved; the
     file shows what it means.
  4. File findings as you read, rather than holding them to the end:
     `tasks item add --pool findings --key gate --producer code-review
     --fingerprint "<file:symbol or line span>" --field file=<path>
     --body "<file:line, what is wrong, why it matters, how to fix>"
     --task <task>`.
  5. Close with `LEDGER: n of m files read` in the result. Where n
     equals m, add `SWEEP: complete`; a sweep you could not finish
     closes `partial` with `SWEEP: in progress` and the files you
     closed since the sweep began, one path per line, so the next
     sweep task starts from the unread files. Add `DRY` where a
     complete sweep filed nothing new.

  On `verify`, the items your claim printed are the paths staged
  since the last review (`staged`, state `unread`) and the findings
  the fixer resolved (`findings`, state `fixed`). Re-read every
  staged path in full and set each to `read` on the close. Verify
  each resolved finding on the tree, never on the fixer's note:
  `VERIFIED` → close it `verified`; `STILL OPEN` → close it `open`
  with the reason in its note. File every new finding the changes
  introduced as on a sweep. Close with the counts in the result,
  and `DRY` where nothing new was filed.

  {{CODE-REVIEW-BRIEF}}
```

The reviewer is a producer: its findings drain through `{{CERTIFY-REVIEW-FIX-LOOP}}`. It files nothing into the intake.

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

The build's task prompt. The executing session files one build task per stage — the smallest change that makes progress toward the completion contract and leaves the tree runnable — and one fix task per batch of the review's findings, both under this prompt. `[SPRINT PATH]` is the sprint document, filled when the session writes the prompt file.

```
Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  {{LEAF-AGENT-RULE}}

  You build one stage of the sprint at [SPRINT PATH]. Your brief
  names the work items the stage lands, the corpus deltas it applies,
  and any collateral the planner captured for it; or, for a fix task,
  the items your claim printed are the review's findings on an
  earlier stage. Your task's files are the paths you may edit and the
  test modules you run. Read the sprint's intent, deltas, and the
  work items you land before you write.

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

  ### A fix task

  Fix every finding your claim printed. Do not skip, defer, or assess
  priority; code you did not write is still yours to fix. Your files
  line names where the findings sit; the prompt widens it: a fix may
  edit any file the correct fix requires. Where a finding's fix
  depends on intent the sprint and corpus leave open, record a fork
  (below) and build the reading you judge most plausible. Where a
  finding's premise is false, show it false in the item's note with
  what you ran or quoted, change nothing, and close it `fixed` all
  the same; the review verifies every fixed finding on the tree and
  reopens what still stands. Write each item's note with `tasks item
  set <id> --note "<the fix>"`, then close each `--item <id>=fixed`.

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
    your key and keep going.
  - Never destroy uncommitted work. Stage the paths you touched by
    name as you finish (`git add <paths>`). Never run `git
    checkout`/`restore`/`reset`/`stash`/`clean`. Fix a bad edit
    forward by editing again. Do not commit.
  - Read files before editing.

  ### Close
  Close the task with every path you touched under `--staged`, every
  finding you fixed under `--item`, and one line in the result naming
  what the stage now does. A stage you could not finish closes
  `partial` with exactly where you stopped and what is staged; the
  session refiles the remainder.
```

---

### {{BUILD-REVIEW-PROMPT}}

The build's review task — the read-only task the executing session files after each build task and after each fix task, consuming the paths that task staged. It carries `{{CODE-REVIEW-BRIEF}}` — the same brief the gate's cold reviewer runs — with the scope filled when the prompt file is written, the alignment judge's questions scoped to the stage's own work items and deltas, and the read-only per-stage producers each present family's ceremony contribution names under its **Build-review producers** heading. Nothing here is a producer of the terminal gate: the gate re-runs everything cold over the whole diff, blind to these findings.

`[SPRINT PATH]` is the sprint document; `[BUILD-REVIEW PRODUCERS]` is the concatenation of every present family's **Build-review producers** section, read from `.ok-<name>/ceremony/certify-work.md`; `[REVIEW SCOPE]` in the transcluded brief is "the paths this task consumed, read against the change so far; findings are confined to the increment and to what it breaks anywhere in the tree — an earlier stage, an untouched caller, a deployment or infrastructure file the increment's behavior depends on".

```
Task prompt (profile ok-opus):
  ## Build review — one stage

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review one landed stage of the sprint at [SPRINT PATH], under
  the same brief the certification gate runs cold at the end. You
  edit nothing, run no suite, and file nothing into the intake.

  ### The increment

  Your brief names the stage's work items and the deltas it lands.
  The `staged` items your claim printed are the paths the stage's
  build, or its latest fix, touched; the `findings` items at `fixed`
  are what that fix resolved. Read the increment in the context of
  the change so far — the tree as it stands, every earlier stage
  included — and confine findings to the increment and what it
  breaks anywhere in the tree: an earlier stage, a caller the
  increment does not touch, a deployment or infrastructure file the
  increment's behavior depends on, a load-bearing property the
  increment trades away. Following a reference out of the increment
  is in-brief; a file the increment neither touches nor reaches is
  not.

  ### The stage's corpus deltas

  The sprint applies each corpus delta as part of the stage that
  realizes it. Only the deltas this stage landed are due. Read each
  landed file under `.ok-planner/design/` against the sprint's delta
  body and file any difference. Leave every delta no stage has landed
  yet to the later stage that carries it.

  ### The stage's sprint alignment

  Judge the increment against the sprint as the certification gate's
  alignment judge will, scoped to what this stage lands:

  1. **Every work item the brief names is realized, not
     undershot.** No stub, no-op, `TODO`, deferred handler,
     declared-but-unemitted error, or accepted-but-ignored flag
     stands in for the item's promised outcome. The outcome must be
     observable, not only its mechanism present. An undershoot is a
     finding even when every test is green. Judge only the items the
     brief names; an item a later stage carries is not yet due.
  2. **Every corpus delta this stage landed is coherent with the
     live corpus.** Read the landed artifact against the three
     catalog TOCs and file any contradiction with a live artifact,
     reading the counterparty in full only when the catalogs suggest
     a collision.
  3. **Every divergence this stage recorded, under the veto test.**
     `tasks item list --pool divergences --key <your key>` shows the
     stage's calls and forks. For a recorded call — a determined
     reading, an overshoot, a shape-change — ask whether a reasonable
     owner, reading it as a one-line divergence report, would
     plausibly say "no — I meant the other thing". Might → a finding
     naming the call and the reading the owner might prefer. A
     claimed fork is not under the veto test here; the gate's
     architect settles it.

  ### Findings

  File each finding into the pool under the stage's key: `tasks item
  add --pool findings --key <your key> --producer build-review
  --fingerprint "<file:symbol or line span>" --field file=<path>
  --body "<file:line, what is wrong, why it matters, how to fix>"
  --task <task>`. Verify each `fixed` finding your claim printed on
  the tree, never on the fixer's note: close it `verified`, or `open`
  with the reason in its note. A build-review producer below may name
  one of its hits a claimed fork: file that as a `divergences` item,
  `--field kind=fork --state fork`, never as a finding, so nobody
  tries to fix it.

  ### The brief

  {{CODE-REVIEW-BRIEF}}

  ### Build-review producers

  Run these read-only checks over the increment. File each hit as a
  finding. Where a producer names its hit a claimed fork, file it as
  a fork instead.

  [BUILD-REVIEW PRODUCERS]

  ### Close
  Set every `staged` item you consumed to `read` on the close. Close
  with the counts in the result: findings filed, verified, still open.
```

**Per stage**, the session files the build task, then the review task `--after` it, consuming `staged:unread`. When the review closes, the session reads `tasks item count --pool findings --key <stage> --state open`. Zero → the stage is complete. Otherwise it files one fix task per batch, `tasks batch --pool findings --key <stage> --state open --group-by fields.file --size 8 --prompt build --agent ok-opus --role fix`, then one review task `--after` those fix tasks, consuming `staged:unread` and `findings:fixed`, and drains again. After **3 fix rounds** on one stage without an empty pool, the session stops and puts two steps to the owner — **another round**, or **record the remainders**: file each still-open finding as a claimed fork in the `divergences` pool (`--field kind=fork --state fork`, the finding as the body) and set the finding `recorded`, which hands it to the gate's architect. The choice is the owner's alone. The session takes neither step itself and waits, attended or not, with no default.

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
where nothing was found. Add one line for the loop's subtractions:
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
<Every issue this run created, by file path, with the verify pass's
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

- Triages and defers nothing: every finding enters the review-fix loop, and only the architect's confirmed forks and the owner's cap escalation reach the intake.
- Asks the owner nothing mid-round: forks are promoted and everything else is fixed; the cap is the run's one stop.
- Archives and commits nothing on its own: the presentation offers both, and only the owner's word triggers either.
- Plans and builds no new scope: a gap the loop cannot drive to clean is surfaced, never filled with work no sprint promised.
- Dispatches no agent directly: every reviewer, judge, fixer, and architect is a task in the run, dispatched by the drain under its profile.
