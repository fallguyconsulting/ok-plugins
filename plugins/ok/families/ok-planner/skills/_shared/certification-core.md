# Certification core

Shared machinery for `/certify-work`, the change-scoped certification gate: the review-fix loop and its veto test, the review root and its pass tasks, the sprint-alignment pass, the fixer and architect prompts, the presentation, and the close-out. The gate's own body is about scope and never restates these blocks. The build's task prompt lives here too, so the build and the gate read one file.

Every agent this file defines is a **task** in the task tracker at `.ok-planner/bin/tasks`, dispatched by the `execute-tasks` drain under a vendored profile. The reason is the prompt cache: every agent of one profile starts from the profile's system prompt and one fixed message naming its task, and `tasks claim` hands it its prompt, its brief, and the pool items it consumes as a tool result, after the cached prefix. No agent stands across rounds. Each task is one bounded piece of work; what it found or did goes into the run's pools, and the next task reads the pools, never a predecessor's context.

Nothing here audits. Whether the corpus's stories and decisions are still supported is the periodic `/audit` run's question, asked over the whole corpus on the owner's cadence — never at a close, never against a change.

## How consumers use this file

Same conventions as `artifact-definitions.md`: `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a per-run value the consuming skill fills before it writes the prompt file. The prompts also carry `{{LEAF-AGENT-RULE}}`, `{{FORK-PER-ITEM-RULE}}`, and `{{READ-ONLY-REVIEWER-RULE}}` from `skills/_shared/dispatch-discipline.md`; every task here but the review root is a leaf, under a profile that forbids subagents. The review root, under `ok-review`, reads the change once, files one pass task per pass forked from its own task, closes its own task, and forks one agent per pass task; each fork claims its pass task, and a fork never forks.

**The run.** One task run per sprint, at `.ok-planner/sprints/<sprint-name>-run.jsonl`, opened by the sprint's executor and reused by the gate; a bare gate with no sprint opens its own at `.ok-planner/tasks/certify-<date>.jsonl`. The run file is the record: it archives with the sprint, and the completion report is rendered from it. Opening a run:

1. `tasks init <name> --file <path>`. Every path a task closes with `--staged` is recorded on the task; `tasks round show` lists the paths the round's closed tasks staged, and the gate's exit test reads that list.
2. `tasks agent register ok-opus`, `tasks agent register ok-sonnet`, and `tasks agent register ok-review`.
3. Resolve each prompt block's transclusions and `[...]` values, write the body to `.ok-planner/.cache/sprint/<name>.md`, and `tasks prompt register <name> <path>`, for the prompts the consumer needs: the sprint's executor registers `build`; the gate registers `review`, `pass`, `fixer`, and `architect`. The directory is derived from the vendored shared files and ignored; every claim reads from it during the run, and the archive does not carry it. The run file records each prompt's sha256, and the vendored shared file at the closing commit is its text.
4. The gate, whether it opened the run or the executor did, declares the pools' state vocabulary once, so an item add, a set, a close, a batch, or a triage naming a state outside it is refused: `tasks config set item_states '{"findings": ["open", "batched", "fixed", "verified", "kickback", "dissolve-claimed", "refute-claimed", "reversal", "dissolved", "refuted", "reversal-ruled", "promoted", "repeat", "recurrence"], "divergences": ["open", "fork", "resolved", "promoted"], "batches": ["open"]}'`.
5. Whoever opens the run declares the roles whose close carries a sweep, before the first task of such a role is filed: `tasks config set swept_roles '["build", "fix"]'`. The executor declares it at open; the gate declares it where it opens the run itself, and reads it back from `tasks status --json` under `run.config.swept_roles` where the executor did. A task of one of those roles closes `done` only with `--sites`, every site the search for its change returned as `path[:locator]`, and the tracker refuses the close when a site's path is not among the task's staged paths, unless the site ends in `=standing`, the mark for a member that already had the shape. The rule exists because the record shows a builder and a fixer edit fewer sites than their own search returned: a class of seven stale call sites in five files survived a stage whose work item said every site is amended, and one guard took three rounds to reach three sibling reads. The sites a round's tasks named are in `tasks round show`, so the next round's reader has the enumeration and not only the staged paths.

**The pools.** Three, and every agent writes to them with `tasks item add` and settles them with `tasks close --item <id>=<state>`:

| pool | key | what an item is |
|---|---|---|
| `findings` | the filing task's key during the build, for a defect a build task meets outside its files; `gate` at the gate, whose triage re-keys the build's items to it | one finding: `--fingerprint <file:symbol or line span>`, `--field file=<path>`, `--producer <producer>`, the finding verbatim as the body, and `--field severity=trivial` where the review brief's one-mark rule allows it. Its state is its outcome: `open`, `batched`, `fixed`, `verified`, `kickback`, `dissolve-claimed`, `refute-claimed`, `reversal` (the fixer's claims and triage's call, for the architect), `dissolved`, `refuted`, `reversal-ruled`, `promoted` (the architect's settlements, terminal), `repeat` and `recurrence` (triage's transient calls). |
| `divergences` | the filing task's key | one entry for the completion report's `## Divergences`: `--field kind=call` for a determined call, an overshoot, a shape-change, or a corpus edit; `--field kind=fork --state fork` for a claimed fork, the options and the reading built in the body. The architect settles a fork to `resolved` or `promoted`. Never a defect: a defect anyone meets goes to `findings`. |
| `batches` | `gate` | one area of the change for the judgment passes, filed by the round's review root: `--field files=<the area's paths as a JSON list>`, the body one line on what the area holds. The root names the item's id in the area's `correctness` pass task's brief and the item's files as that task's files, and the pass's findings name it under `--field batch=<id>`, so the tracker holds the record of what each pass was given. |

**The report is a rendering.** The session writes the completion report from the run before every dispatch and at the end: `tasks render --title "<the sprint's title>" --sprint <the sprint's path>` prints `## Stages` from the build tasks, `## Divergences` from the `divergences` pool with each item's id as the entry's identifier, and `## Certification ledger` from the `findings` pool at key `gate`; the session writes that output to the report file. Agents never edit the report; they file items. A session that dies leaves the run file, and a replacement renders the same report from it.

**Every task closes.** The profile's system prompt carries the claim and the close. A task that cannot finish closes `partial` with a result that says where it stopped and what is staged; the session refiles the remainder with `tasks refile <task>`.

**No task leaves a process running.** A build, fixer, or architect task runs its checks in the foreground and closes with no process of its own still running: no background poller, no `sleep` loop watching a file, no server it started. The drain stops nothing; a process a task leaves behind runs until the session finds it.

---

### {{RELEASE-DOCUMENTS-RULE}}

Carried by every prompt in this file that reads or edits the tree: the build, the review root and its pass tasks, the alignment pass among them, the fixer, and the architect. The rule is `decision:placed-documents-are-records` at the sites where a sprint could break it.

The documents the release regenerates are out of scope. They are every file at a target a declared document type names under `.ok-planner/surface/documents/` (a folder target covers the folder) and everything under `.ok-planner/documentation/`. `/document` rewrites them whole at the next release. Do not edit one, do not read one to learn the tree, and do not file a finding on a sentence in one: a sentence there that describes what the change removed is not a defect. Rule files under `.claude/rules/`, infrastructure files, and every other prose file stay in scope.

---

### {{CERTIFY-REVIEW-FIX-LOOP}}

One loop drives every finding from every producer to a settled outcome. The orchestrator has no discretion inside it: it files tasks, drains them, triages the `findings` pool, and counts rounds. It never edits code or corpus itself, with one exception, the trivial hatch below: a round whose open findings are nits only ends with the session fixing them inline and the loop exiting. Every other fix is a task, the orchestrator's own included.

**Producers.** The gate's review passes — sprint alignment, the mechanical floor, code review — each report findings at the gate's scope. A mechanical producer is an `exec` task (`tasks file --kind exec --command "<the command>" --key gate`); the drain runs it and closes it with the exit code and the output tail, and the orchestrator files one `findings` item per failure with the command as the producer. Code review and sprint alignment are one **review root** task under `ok-review` (`{{CERTIFY-REVIEW-ROOT-PROMPT}}`) and its **pass tasks** (`{{CERTIFY-REVIEW-PASS-PROMPT}}`): the root reads the change once, files one pass task per pass forked from its own task, closes its own task, and forks one agent per pass task; each fork claims its pass task, files its findings under it, and closes it with its report line. Producers never file issues and never fix. Nothing here writes under `.ok-planner/audits/`. A `mechanical`/`judgment` class a reviewer attaches is advisory; every finding enters the same loop. A finding grounded only in a qualitative clause is not a finding, per `{{DECIDABILITY-BOUNDARY}}` in `skills/_shared/artifact-definitions.md`: the fixer dissolves it and the architect checks the dissolution.

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

**The round.** Every round has one shape, the first included: review, triage, the trivial hatch, batch and fix, rule, test for the exit. No round reads what an earlier round read. The enumeration pass reads the whole change every round; the judgment passes read the whole change in round 1 and, in a round after fixes, the files the previous round's fixer and architect staged, so a fix is verified by the pass that reads its site and files nothing there, and a defect one round missed in a file a fix touched is in front of the next round's reader.

1. **Start the round, then review.** `tasks round start`, so the edit test below reads this round alone. File the review root, `tasks file --role review --prompt review --agent ok-review --key gate --brief "review"`. It reads the change from git at the gate's scope, deletions included, the sprint and its delta sidecars, every corpus artifact the change touches, cites through an annotation, or a delta names, and every file its judgment passes cover, in full; it cuts those files into areas and files one `batches` item per area; it files one pass task per pass under the `pass` prompt, forked from its own task (`--fork-of`): `references` over the whole change, `correctness` per area, and, with a sprint in scope, `alignment`, which reads the completion report's Divergences after its reading and puts each recorded call under the veto test; each claimed fork stands at `fork` in the pool for the architect. The root closes its own task, then forks one agent per pass task in one message; each fork claims its pass task. The root and the code-review passes never read the report, so an unrecorded divergence surfaces as a fresh finding. In round 1 the judgment passes cover the whole change; in a round after fixes they cover only the paths the previous round's tasks staged, which the root reads from `tasks round show --previous`, and the whole change again where that list is empty. Every pass enumerates its population before it judges, files every finding into the pool under its own task, and closes its task with its checked population as the result. File the mechanical producers as exec tasks. Drain with `tasks next --all`; every task runs together, since every one reads the tree and none edits it. `next` never issues a pass task while a fork may hold it; a pass task it lists under `waiting` with `fork-of` once the root's agent has returned is an orphan: `tasks retry <task>` on each, then drain again, and the drain issues it to a fresh `ok-review` agent that reads its population cold. `next` never lists a closed task, so a pass task closed `partial` appears only on `tasks status`'s retryable line: read that line after every drain, retry each pass task on it the same way, and drain again. The round's review is complete when every pass task is closed `done`. File the exec failures as findings.
2. **Triage against the ledger.** The orchestrator triages. It dispatches nobody. Run `tasks item triage --pool findings --key gate`. Its first step re-keys every finding that reached the pool under another key or none — a build task's finding under its stage key, a profile's filing with no key, in any state — to `gate`, so triage and the ledger see it and a settled one is history for the fingerprints after it. Its second folds duplicates: two open findings with one fingerprint, whichever round filed each, keep the first filing `open` and mark the rest `repeat` of it, the first's `repeats` rising by one each; an open finding a blocked fixer left behind is the live row for its defect, so a later round's identical filing folds onto it. Then per fingerprint: a fresh fingerprint stays `open`; a fingerprint whose prior row is settled (`refuted`, `promoted`, `dissolved`, `reversal-ruled`) becomes a **repeat**, subtracted, and the prior row's `repeats` rises by one; a fingerprint whose prior row is in any other state — `fixed`, `verified`, `batched`, `kickback`, a claim awaiting the architect — is a **recurrence**; and a row at `fixed` whose fingerprint no open finding names becomes **verified**, since the passes read its site on the tree and filed nothing there. Then read each recurrence: the finding asks for the opposite of what that fix did → a **reversal**, `tasks item set <id> --state reversal`, for the architect with both findings, never the fixer; the finding asks for the same thing again → a regression in the fix, back to `open` on that same site. A fresh fingerprint whose slug the intake already carries per `{{ISSUE-FILE-FORMAT}}` → `--state promoted --note <issue file>`, and nobody is dispatched. A fresh finding filed with `--field origin=pre-existing` claims the change did not introduce it; the mark changes nothing about what happens next. The item stays `open`, the fixer fixes it like any other, and the presentation counts it under the pre-existing defects the run fixed, so the owner sees where the sprint reached beyond its change. Where a fingerprint match is uncertain, treat the finding as new.
3. **The trivial hatch.** Read the open findings, `tasks item list --pool findings --key gate --state open --json`. Where every one carries `severity=trivial`, the round ends here and the loop exits: the session fixes each one inline under the fixer's rules, runs the project's lint once, stages the paths it touched by name, and closes each item `fixed` with the fix in its note (`tasks item set <id> --state fixed --note "<the fix>"`). A marked finding whose fix turns out to need a function body or a corpus commitment is not fixed inline and restarts nothing: file it to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem), set it `tasks item set <id> --state promoted --note <issue file>`, and the loop still exits. Where any open finding is unmarked, continue with every open finding, the marked ones included. The mark exists to stop the rounds when a review reads the tree and finds nits only; it changes nothing else.
4. **Batch, then fix.** The orchestrator batches; it dispatches nobody for that, and it is the one judgment it makes inside the loop. Read the pool whole, `tasks item list --pool findings --key gate --state open --json`, and group by **blast radius**, never by file: a shared definition with its callers, one defect class across its sites, one surface's files. Split a group that would exceed what one fixer can hold. File one fix task per group: `tasks batch --pool findings --key gate --items <the group's ids> --files <every path the group reaches> --prompt fixer --agent ok-opus --role fix --brief "<what the group's findings share, and where the callers and siblings are>"`, with `--after <task>` where two groups name a common path. The items are marked `batched`, and the task's `files` is the union of the items' files and the `--files` given. Groups with disjoint files run together. A fixer that staged a path outside its `files` is recorded by the tracker on its close, and the next batch's chaining reads staged paths as well as declared ones. Skip where the pool holds no open item. Drain. The fixer fixes everything the veto test allows and takes one of three legal non-fixes on the rest: DISSOLVE, KICKBACK, or REFUTE, closing each item to `fixed`, `dissolve-claimed`, `kickback`, or `refute-claimed`. A fixer task that closed `blocked` or `partial` left its items at `batched`: set each back to `open` (`tasks item set <id> --state open`) before the next step.
5. **Architect.** Where any item stands at `kickback`, `dissolve-claimed`, `refute-claimed`, or `reversal`, or any `divergences` item stands at `fork`, file one architect task: `tasks file --role architect --prompt architect --agent ok-opus --key gate --brief "rule" --consumes findings:kickback findings:dissolve-claimed findings:refute-claimed findings:reversal 'divergences:fork:*'`. Drain. The architect settles every item it consumed to a terminal state: `fixed`, `refuted`, `reversal-ruled`, `promoted`, or `dissolved` on a finding, or `open` where it hands one back; `resolved` or `promoted` on a fork. (Certification's promote — a finding becoming an intake issue — is distinct from `/plan-sprint`'s promote, which stamps an intake issue into a sprint.)
6. **Exit, or the next round.** Apply the edit test: `tasks round show` lists the paths staged this round, and `tasks item list --pool divergences --json` shows each item's `round`. The loop ends at **the first round in which neither the fixer nor the architect edited any file** (code, corpus, or the report's `## Divergences`) **and no finding stands open**: `round show` lists no staged path, no `divergences` item carries the round, and `tasks item count --pool findings --key gate --state open` prints zero. All three are terms of the test; a round whose fixer closed `blocked` and left its items at `open` does not exit. Every finding that round was a repeat, an upheld refutation, a promotion, or a ruled reversal, and the round's forks read the tree as it stands and filed nothing the loop fixed. The producers confirm the same event: every code-review pass task closed `done` with `DRY` in its result, the alignment pass task closed with `clean`, and the exec tasks close `done`. Otherwise raise `rounds_touched` by one on every finding the round's fixer or architect edited, and start the next round at step 1.
7. **The cap, a thrash guard.** After **8 rounds** in which the fixer or the architect edited a file, the run stops. It reports every ledger row whose `rounds touched` reached three, and puts two steps to the owner — **another round**, or **escalate the open remainders**: file each item still at `open` to the intake per `{{ISSUE-FILE-FORMAT}}` (kind `audit`, the finding verbatim as the Problem, the attempted fixes as evidence), set it `promoted`, then continue to `/verify-issues` and the presentation. The choice is the owner's alone. The run takes neither step itself and waits, attended or not, with no default. A run parked at the cap is a legal in-flight state: not done, not failed.

**Three paths reach the intake, and the owner is never asked live mid-round.** Certification creates issues only through the architect's confirmed forks, the owner's cap escalation, and the trivial hatch's finding whose fix proved non-trivial; the pre-presentation `/verify-issues` pass makes all three ruling-ready. Every defect the review finds is fixed in the loop, the ones the change did not introduce included: the fixer holds the code, and an issue filed for a defect that needs no ruling only defers the fix. Everything the executor recorded and everything the fixer and architect did beyond what the sprint and corpus spell out — calls made, corpus edits, overturned kickbacks, upheld refutations, ruled reversals — surfaces in the presentation's Divergences for after-the-fact veto.

---

### {{SPRINT-ALIGNMENT-PASS}}

The corpus-change judge, one pass task of the review root per round, with a sprint in scope: the second question, every work item realized and not undershot, is the completeness check the gate owes. The root files it beside the code-review passes and forks an agent to claim it; the fork inherits the root's reading of the sprint, the corpus, and the change, and reads the completion report only after that reading. The consuming gate fills `[SPRINT PATH]` when it writes the pass prompt file, and this block rides inside `{{CERTIFY-REVIEW-PASS-PROMPT}}`.

```
The alignment pass (inside the pass prompt):
  ## Sprint alignment — the corpus change, realized and coherent

  Your brief names `pass: alignment`. This is your one pass; the
  code-review rows above are other tasks' work.

  ### Your job

  The sprint at [SPRINT PATH] is a change-order against the design
  corpus. Judge four things and file a finding for each defect:

  1. **Every corpus delta applied verbatim.** The artifact under
     `.ok-planner/design/` matches the delta's final-form body, or
     is deleted for a retirement. A mismatch is a finding —
     mechanical where a byte comparison settles it.
  2. **Every work item's outcome realized, not undershot.** No
     stub, no-op, `TODO`, deferred handler, declared-but-unemitted
     error, or accepted-but-ignored flag stands in for a promised
     outcome. An undershoot is a blocking finding even when every
     check is green. The outcome must be observable, not only its
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
     test.** Read the report now, after your reading, beside the
     sprint (same filename with `-completion`); the root and the
     other passes never see it. Its `## Divergences` section holds one entry per
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

  Judge the four questions over the whole change as the tree stands
  now, every round; nothing from an earlier round's pass carries.

  The completion report carries the certification run's own record: a
  finding ledger and a presentation. The gate writes them while its
  loop still runs. That unfinished run is the gate's own state, not a
  finding. File nothing for it.

  ### Output

  File each finding into the pool: `tasks item add --pool findings
  --key gate --producer alignment --fingerprint "<file: the delta or
  work item it fails>" --field file=<path> --field pass=alignment
  --body "<what is wrong, where, and why it matters, with the advisory
  mechanical/judgment class>" --task <task>`. Mark
  `--field severity=trivial` only under the one-mark rule in the
  code-review brief's Output; grade nothing else. Close your task
  with one line as its result: `tasks close <task> --outcome done
  --result "alignment whole: <the count of findings filed>"`, or
  `alignment whole: clean`.
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
  sweep included. A defect you meet that no finding in your batch
  names is yours too: file it into the `findings` pool at key
  `gate`, with `--field origin=pre-existing` where the change did
  not introduce it and never with `--field severity=trivial`, a
  reviewer's mark alone, then fix it in this task under the same
  rules and close the item `fixed` with the rest. A defect left open for
  the next round is a round nobody needed. Do not skip, defer,
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

  **A finding is one member of a class. Enumerate the class before
  you edit.** Name the class the finding belongs to (an unguarded
  read of an operator-named path, a caller still passing a dropped
  flag, a sentence restating a retired rule), then run `rg` for the
  shape across code, templates, config lists, docs examples, and
  the design corpus, the release documents excepted. Write the
  list into your note before the first edit. Every site the search
  returned is yours in this batch: fix each one, or mark it
  `=standing` where it already has the shape. The record shows the
  failure this prevents: a guard added at the named site and not at
  its two siblings in the same file, so the same class returned for
  three rounds.

  **Copy the sibling's shape.** Before you write an error handler, an
  event emission, a transaction, a teardown, a lock, or a command
  body, find the nearest site in the same file or package that does
  the same job and match it: the exception tuple it catches, the
  wrapper it runs inside, the event it emits, the lock it holds, the
  order of its steps. Cite the sibling in your note. A fix that
  departs from the sibling's shape says why.

  **Fix the blast radius, never the site alone.** A fix that changes
  a function's signature or behavior lists every caller with `rg`
  and re-derives each caller's contract in the same batch: a flag a
  caller still passes that nothing reads any more is yours to fix
  now, not the next round's finding. A fix that restores or moves a
  capability makes it reachable from every surface the sprint left
  standing — the API, the CLI, the console — and you follow the
  route or the verb out with `rg` to check each one.

  **Check your own diff before you close.** Walk every exit of each
  function you touched and confirm cleanup runs on each. Confirm
  every read that decides a write, and every emit that reports a
  state, sits inside the lock that guards the state. Record the walk
  in your note.

  **Close with the sweep.** `tasks close <task> --outcome done
  --staged <every path you touched> --sites <every site the search
  returned, path[:locator] each, =standing after one you left as it
  stood>`. The tracker refuses a `done` close with no sites, and a
  close naming a site whose path you did not stage.

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
  with a reproduction you ran: a check you ran, a command you ran, or
  a file you quote with its line. Close it `refute-claimed`
  with the command or the quote and its output in its note. The
  architect re-runs your reproduction and hands the finding back as
  an ordinary fix where the reproduction fails. "Not worth fixing",
  "minor", and "pre-existing" refute nothing.

  ### Rules
  - Read files before editing.
  - Add no test, edit no test, run no test, and read no test as
    evidence. An existing suite stays as it stands; a write into a
    test path is a lint violation the edit hook blocks. Where a
    finding asks for a proof, the fix is an assertion with a message
    at the site that enforces the behavior.
  - Run the project's type checks and lint for the packages you
    modified and for every package a caller you changed lives in. A
    fix that breaks the build is not done.
  - Run every check in the foreground. Start no background process,
    and close with no process of your own still running.
  - Never destroy uncommitted work: fix bad edits forward, never
    with git checkout/restore/reset/stash/clean. Do not commit.
  - If blocked (a credential you lack), say so specifically. That
    is the only other acceptable non-fix.

  ### Completion check
  Re-read your batch and every finding you filed, and confirm each
  one has a fix, a kickback, a dissolution, or a refutation. First write each item's note with
  `tasks item set <id> --note "<...>"`: the fix; or, for a kickback,
  why the fork is genuine under the veto test and the diverging
  options; or the qualitative clause quoted; or the reproduction
  command or quote and its output. Then close the task naming every
  item's outcome — `--item <id>=fixed`, `--item <id>=kickback`,
  `--item <id>=dissolve-claimed`, or `--item <id>=refute-claimed` —
  and every path you touched under `--staged`, one flag with every
  path after it. The result line carries the counts: fixed, a
  KICKBACK count, a DISSOLVED count, a REFUTED count, CALLS MADE and
  CORPUS EDITS counts, and `CHECKED:` the callers, surfaces, and
  class members you enumerated (`CHECKED: 3 callers of
  delete_device, 3 force flags, 2 surfaces`). Or
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
  yours too: file it into the `findings` pool at key `gate`, with
  `--field origin=pre-existing` where the change did not introduce
  it and never with `--field severity=trivial`, a reviewer's mark
  alone, then fix it in this task under the fixer's rules and
  settle the item `fixed`.

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
  - Run every check in the foreground. Start no background process,
    and close with no process of your own still running.

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
  Close the task with every item's state under `--item`, the items
  you filed and fixed among them, every path you touched under
  `--staged`, and the counts in the result.
```

---

### {{CERTIFY-REVIEW-ROOT-PROMPT}}

The review root, one task per round, under `ok-review`. It reads the change once — the diff, the sprint, the corpus artifacts the change touches or cites, and every file its judgment passes cover — cuts those files into areas it files as `batches` items, files one pass task per pass forked from its own task, closes its own task, and forks one agent per pass task in one message. Every fork inherits the root's reading as a cached prefix, so no pass reads the change twice; each fork claims its pass task, files its findings under it, and closes it with its report line. The root judges nothing and files no finding itself. The pass tasks run under `{{CERTIFY-REVIEW-PASS-PROMPT}}`, registered as `pass`. The consuming gate fills `[REVIEW SCOPE]` — what is under review, how to enumerate it, and how far findings may reach beyond it — and `[SPRINT PATH]` when it writes the prompt file.

```
Task prompt (profile ok-review):
  ## Review the change

  {{FORK-PER-ITEM-RULE}}

  You judge nothing and file no finding yourself. Your job is the
  reading, the areas, the pass tasks, and the forks. You fork every
  pass however few areas the change cuts to: a change with one area
  still gets its forks.

  {{READ-ONLY-REVIEWER-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  Do not read the completion report beside the sprint. You and the
  code-review passes read the code blind to the executor's account
  of it, so a divergence it did not record surfaces as a fresh
  finding. Only the alignment pass reads the report, after its
  reading.

  You review the finished work, so every corpus delta a sprint in
  scope carries is due: a `correctness` pass opens each file under
  `.ok-planner/design/` in its area and verifies the delta to it
  landed.

  ### Scope

  [REVIEW SCOPE]

  ### Read once

  1. Enumerate the change with git — `git status`, `git diff --stat`,
     and the diff at the scope above, deleted files included — and
     read the diff whole. Write down
     every changed, added, and deleted file.
  2. With a sprint in scope, read the sprint at [SPRINT PATH], its
     delta sidecars, and every artifact under `.ok-planner/design/`
     the change touches, cites through an annotation, or a delta
     names, in full.
  3. Run `tasks round show --previous --json`. Where it prints no
     round, or its `staged` list is empty, this round's judgment
     passes cover the whole change. Otherwise they cover only the
     paths in that list that are in the change: the files the
     previous round's fixer and architect staged. The enumeration
     pass covers the whole change either way.
  4. Read every file the judgment passes cover in full, the release
     documents excepted; the diff shows what moved and the file
     shows what it means. A deleted file has nothing to read and
     goes in no area; the enumeration pass covers what its deletion
     left behind.

  ### Cut by area

  Cut the files the judgment passes cover into areas. An area is a
  package the change touched. A changed definition
  pulls its changed callers into its area, across packages where
  needed. A corpus delta rides with the area whose code it governs,
  so the pass that checks the delta landed is the one that read the
  code. Never split an area and never merge two: there is no file or
  line budget, and an area is as large as it is. Each file lands in
  exactly one area.

  File one item per area: `tasks item add --pool batches --key gate
  --body "<what the area holds, one line>" --field
  'files=["<path>","<path>"]' --task <task>`, the whole `--field`
  value in one quoted argument so the shell passes the list as one
  word. Where no file remains for a judgment pass — a change of
  deletions only, or one whose remaining files are all release
  documents — file no item and no `correctness` task; the
  enumeration pass is the round's code review.

  ### File the pass tasks

  File one task per pass, each on your own profile and forked from
  your task, so the tracker marks it issued for your fork and the
  drain leaves it alone while your fork holds it:

  - `references`, one task over the whole change:
    `tasks file --role pass --prompt pass --agent ok-review --key
    gate --fork-of <task> --brief "pass: references"`.
  - `correctness`, one task per area, its files the area's:
    `tasks file --role pass --prompt pass --agent ok-review --key
    gate --fork-of <task> --files <the area's paths> --brief "pass:
    correctness
    batch: <the area's item id>"`, the brief two lines.
  - `alignment`, one task, with a sprint in scope:
    `tasks file --role pass --prompt pass --agent ok-review --key
    gate --fork-of <task> --brief "pass: alignment"`.

  Write down every pass task's id with its pass and area.

  ### Close, then fork

  Close your task before you fork, so no fork of yours holds an
  open task: `tasks close <task> --outcome done --result "<one
  entry per pass task: its id, its pass, and its area item or
  whole; then the counts>"`. The counts: files the judgment passes
  cover, less the deleted files and the release documents; files in
  areas; areas filed. The first two are equal, since every other
  covered file lands in exactly one area; where they are not, do
  not close: cut again.

  Then fork one agent per pass task, every fork in one message, with
  `subagent_type` set to `fork`, each fork's prompt exactly this,
  its pass task's id in place of `<pass task>`:

    You are a fork of the review root. Everything the root read
    stands in your context; read nothing shared again. Claim your
    task and finish it.
    task: <pass task>

  Wait for every fork to return. A fork's return is its pass task's
  close; you re-run nothing and diagnose nothing. A pass task a
  fork left open or running is the drain's: it reissues the task to
  a fresh agent of your profile, which reads its population cold
  under the pass prompt. Your final message is the one line the
  profile defines.
```

The pass tasks are the producers: their findings drain through `{{CERTIFY-REVIEW-FIX-LOOP}}`. They file nothing into the intake.

---

### {{CERTIFY-REVIEW-PASS-PROMPT}}

One review pass, one task, under `ok-review`, registered as `pass`. The round's review root files one per pass, forked from its own task, and forks an agent to claim each; the fork's context holds the root's reading, so it reads nothing shared again. A pass task the fork left open or running is reissued by the drain to a fresh agent of the profile, and this prompt tells that agent what to read. The brief names the pass on its first line — `pass: references`, `pass: correctness`, or `pass: alignment` — and a `correctness` brief adds `batch: <item id>`, its area's `batches` item, with the area's files as the task's files. `{{CODE-REVIEW-BRIEF}}` is the brief every code-review pass applies and `{{SPRINT-ALIGNMENT-PASS}}` the alignment pass's body; both ride inside this prompt. The consuming gate fills `[REVIEW SCOPE]` and `[SPRINT PATH]` when it writes the prompt file.

```
Task prompt (profile ok-review):
  ## Run one review pass

  You are one pass of the round's review. You fork nothing and spawn
  nothing. You judge your population, file each finding into the
  pool as you meet it, and close your task with your report line.
  Your brief's first line names your pass.

  {{READ-ONLY-REVIEWER-RULE}}

  {{RELEASE-DOCUMENTS-RULE}}

  ### Your reading

  Where you are a fork of the review root, its reading is in your
  context — the diff at the gate's scope, the sprint and its
  sidecars, the corpus artifacts the change touches, and the files
  the judgment passes cover, each read in full — and you read
  nothing shared again. Where you are not — a fresh agent the drain
  dispatched on a reissued pass task — read now what the root read:
  enumerate the change with git (`git status`, `git diff --stat`,
  and the diff at the scope the brief below names under Scope,
  deleted files included) and read the diff whole; with a sprint in
  scope, read the sprint at [SPRINT PATH], its delta sidecars, and
  every artifact under `.ok-planner/design/` the change touches,
  cites through an annotation, or a delta names, in full; and on a
  `correctness` pass read your task's files in full. Read the
  completion report only on the alignment pass, and only where its
  body says to.

  ### The passes

  Your pass covers what its row says and nothing else; the other
  rows are other tasks' work. The enumeration pass covers the whole
  change. A judgment pass covers the area its task names; the other
  areas are other tasks' work. The enumeration row widens the
  brief's own headings with the populations it lists. The brief's
  last rule, that a finding rests on a decidable defect, binds every
  pass. The alignment pass follows its own body at the end of this
  prompt.

  | pass | what the pass covers |
  |---|---|
  | `references` | Dead code, unused imports, stale comments. Every name the change deletes or renames — symbol, column, table, route, verb, option, template block, config key, constant, annotation slug — grepped across the tree for a remaining reference. Every symbol the change leaves whose callers it deleted. Every parameter or flag left threaded through a call chain but read by nothing. Every operator-facing sentence, rule file, and infrastructure file outside the release documents that still describes what the change removed. Every `@story:`, `@concept:`, and `@decision:` slug in a changed file resolving under `.ok-planner/design/`. Every file the change adds or edits at a test path, and every line it adds that declares a test or imports a test framework in a product file, whichever tool wrote it; the fix is to revert the edit or drop the test, never to delete an existing one. |
  | `correctness` | Correctness. Safety. State integrity. Load-bearing properties upheld. Events. |

  ### On a code-review pass

  1. Your population: on the enumeration pass, the whole diff,
     deleted files included; on a judgment pass, your task's files,
     read in full, and their diff.
  2. Enumerate your population before you judge: the names, symbols,
     flags, slugs, or properties your headings apply to. Where a
     heading names a class of site — every force flag, every list
     route, every caller of a changed function — list every member
     with `rg` and judge each one. A defect on one member is filed
     on every member that shares it, one finding each, so the fixer
     holds the class whole.
  3. On the enumeration pass, follow every reference out of the
     change; the defect is in the file the change did not touch. A
     defect you meet that the change did not introduce — the same
     code stands at the scope's base, `git show <base>:<path>` — is
     still a finding: file it with `--field origin=pre-existing`,
     and the loop fixes it like any other; the mark only tells the
     presentation where the run reached beyond the change. Never
     drop a defect for being pre-existing, and never widen your
     reading to hunt for them: your population is the change and
     what it reaches.
  4. File findings as you read, rather than holding them to the end:
     `tasks item add --pool findings --key gate --producer code-review
     --fingerprint "<file:symbol or line span>" --field file=<path>
     --field pass=<pass> --body "<file:line, what is wrong, why it
     matters, how to fix>" --task <task>`, with `--field
     batch=<the item id from your brief>` on a judgment pass and
     `--field severity=trivial` only under the brief's one-mark
     rule.
  5. Close your task with the report line as its result: `tasks
     close <task> --outcome done --result "<pass> <item id, or
     whole>: CHECKED: <count and what it counts, one per heading>"`,
     `DRY` appended where the complete pass filed nothing new
     (`references whole: CHECKED: 56 deleted names grepped, 11
     orphaned symbols, 4 threaded flags; DRY`); or `--outcome
     partial --result "<pass> <item id, or whole>: partial: <the
     members you did not check>"`, and the orchestrator reads it
     from `tasks status` and retries the pass.

  {{CODE-REVIEW-BRIEF}}

  {{SPRINT-ALIGNMENT-PASS}}
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
to fix. **One finding per site, never one finding per class.** When
a defect you find is one member of a class — a dropped flag other
callers still pass, a guard the sibling reads lack, a term restated
in other files — run `rg` for the shape, list every member, and file
each member as its own finding with its own fingerprint, naming the
class in each body. The record shows why: a fixer clears a filed
list in one round and clears a named class one site per round.
Every finding needs fixing. One mark is yours to set:
`--field severity=trivial`, only when the fix touches one file and
changes no runtime behavior — a doc sentence,
a comment, a name, a stale catalog line, an unused import, a missing
annotation slug, a blank line. A fix that edits a function body or
a corpus commitment is never trivial. Grade
nothing else. Where
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
  are the paths you may edit. Read the
  sprint's intent, deltas, and the work items you land before you
  write.

  ### The stage

  - Write the code. Apply each corpus delta the stage carries: copy
    the final-form body into `.ok-planner/design/` verbatim (from the
    sidecar where the heading points there), or delete the file for
    a retirement.
  - Every new or amended story implemented in code carries the
    `@story:` annotation at the site that realizes it.
  - Run the project's type checks and lint on what you built, in the
    foreground: start no background process, and close with no
    process of your own still running. Leave the tree runnable: what
    you touched builds, and nothing is half-wired.
  - Leave `.ok-planner/audits/` and `.ok-planner/experiments/`
    untouched: only a running `/audit` reads or writes them.
  - Completeness is the floor. Never stub, defer, narrow, no-op, or
    leave a `TODO` in place of a promised outcome. Deliver every
    outcome the brief promises in full, or close `blocked` naming
    what stops you.
  - Enumerate before you edit. A change to a definition — a
    signature, a constant, a name, a module, a term, a column, a
    config list — lists every site that reads or restates it with
    `rg` before the first edit: callers, templates, config, rules,
    docs examples, the design corpus, operator-facing
    text outside the release documents. Every site on the list is
    taken in the same stage, or filed as a finding under your key
    where it is outside your files. A deletion lists every reference
    to the deleted name the same way, and every symbol only the
    deleted name used goes with it.
  - Copy the sibling's shape. Before you write an error handler, an
    event emission, a transaction, a teardown, a lock, or a command
    body, find the nearest site in the same file or package that
    does the same job and match its exception tuple, wrapper, event,
    lock, and order of steps.
  - Add no test, edit no test, run no test, and read no test as
    evidence. An existing suite stays as it stands; a write into a
    test path is a lint violation the edit hook blocks. Where a
    behavior needs a proof, write an assertion with a message at the
    site that enforces it.

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
  flag with every path after it; every site your searches returned
  under `--sites`, `path[:locator]` each, `=standing` after one that
  already had the shape; and one line in the result naming what the
  stage now does. The tracker refuses a `done` close with no sites,
  and a close naming a site whose path you did not stage. A stage
  you could not finish closes `partial` with exactly where you
  stopped and what is staged; the session refiles the remainder.
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
the change. Add one line for the findings the session fixed inline
at the trivial hatch, each with its file. Add one line for the loop's subtractions:
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
or verified and awaiting your ruling. Three kinds, each labeled:
forks the architect confirmed (with its why-genuine line),
remainders escalated at the cap (with the finding and what the fix
rounds tried), and findings the trivial hatch found non-trivial (with
the finding and what its fix needs). These are the next sprint's
business.>

<End with the close-out offer, in one or two sentences, per
{{CERTIFY-CLOSE-OUT}}.>
```

---

### {{CERTIFY-CLOSE-OUT}}

If a sprint was in scope and everything certified clean, end the presentation with the standing offer: **archive the sprint** — move it to `.ok-planner/history/sprints/` with its completion report, its run file (`<sprint-name>-run.jsonl`), its delta sidecar folder where it has one, and every issue file under `.ok-planner/issues/` whose `sprint:` names it (to `.ok-planner/history/issues/`) — and **commit the work**. Both are owner acts, performed only on the owner's word. The sprint stays at its `sprints/` path until then; where it sits is no term of the completion contract's goal rule. An uncertified sprint gets no offer. On yes, after the archive commit lands, stamp the archived sprint with `closed: <sha of the archive commit>` in its frontmatter, one small follow-on commit; `/plan-sprint`'s out-of-band reconciliation reads it. Remainders the owner escalated at the cap are verified issues like any others; the presentation and close-out proceed as normal.

---

### {{CERTIFY-GATE-BOUNDARIES}}

- Triages and defers nothing: every finding enters the review-fix loop and is fixed there, the defects the change did not introduce included; only the architect's confirmed forks, the owner's cap escalation, and the trivial hatch's findings whose fix proved non-trivial reach the intake.
- Asks the owner nothing mid-round: forks are promoted and everything else is fixed; the cap is the run's one stop.
- Archives and commits nothing on its own: the presentation offers both, and only the owner's word triggers either.
- Plans and builds no new scope: a gap the loop cannot drive to clean is surfaced, never filled with work no sprint promised.
- Dispatches no agent directly: every reviewer, judge, fixer, and architect is a task in the run, dispatched by the drain under its profile, or a fork of the review root on a pass task the root filed.
