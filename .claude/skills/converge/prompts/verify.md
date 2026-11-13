## Verify a group of fixes

{{LEAF-AGENT-RULE}}

{{PROSE-SCOPE-RULE}}

{{FIX-LINE-RULE}}

A fixer changed code or skill text to remove the defects your brief names, or declined a defect or named it a duplicate. You check the change, and only the change, and each decline's reason. You do not hunt the rest of the file: code the fix did not touch is the next run's hunt's business. You edit nothing.

Your brief names the defects, the fix tasks (a fix task and each refile of it, in filing order), and for each file those tasks staged, its content before the round as a git blob. Where your brief opens with `restore task`, it names a restoration in place of fixes: check it as "A restoration" below says, and skip "Read" and "Check each defect".

### Read

1. Each defect: `tasks item list --pool defects --key gate --json`, the items your brief names, with the fixer's note. A `declined`, `duplicate`, `at-fault`, or `promise` defect has no change of its own: read the code at its site as it stands, and for a duplicate, the defect its note names, with that defect's state.
2. The change: for each file, `git diff <before blob> $(git hash-object -w <path>)`. Other fixes of this round may have touched the same file; judge only the hunks your defects' notes describe. A file the fix deleted, such as a retired artifact a C3 fix removed, has no current content: its change is the deletion, and `git show <before blob>` prints what it removed.
3. The code around each hunk, and every caller of anything whose signature, return, or raise the hunk changed (`rg`, or the LSP: load the LSP tool once with `ToolSearch("select:LSP")`, then call it).

### Check each defect

- **fixed**: the harm is gone. Walk the trigger the defect names through the changed code: it no longer causes the harm, on every path the defect names. The change adds no accept-list harm of its own in the lines it changed (a new split write, a new catch that swallows, a new unbounded wait, a new write whose target input picks). Every caller of a changed contract was brought along. The change alters no behavior a user across a release boundary observes (`.ok-planner/release-boundaries.md`, stored state always, and every element `.ok-planner/surface/surface.md` made public: as it stood at the base commit the `-base.txt` file beside the sprint at [SPRINT PATH] records, or as it stands where that reads `none`; a change that removes only the harm the defect names keeps a public element's contract), unless a ruling of the sprint at [SPRINT PATH] allows it; where that reads `none`, no ruling does. The project's checks pass on the changed files (run them, in the foreground).
- **fixed**, for a defect whose `entry` is C3: the delta of the sprint at [SPRINT PATH] landed. The artifact's file matches the delta's body byte for byte, the body read from the sprint under the delta's heading, or from its sidecar beside the sprint where the line under the heading reads `body: in the sidecar` (`<sprint-name>-deltas/<kind>s/<slug>.md`, or `<sprint-name>-deltas/surface/surface.md` for the surface intent); for a retirement, the file is gone. `python3 .ok-planner/bin/catalog-toc --check` exits 0.
- **declined** or **duplicate**: the fixer's reason holds. A declined defect is not real, the accept list leaves it standing, or its fix lies only in a file the fix line rule above leaves alone; a duplicate names a defect that is itself `fixed` or `verified` for the same flaw.

Where a check holds for a `fixed` defect, `tasks item set <id> --state verified --note "<what you checked>"`. Where it holds for a `declined` or `duplicate` defect, the defect keeps its state: `tasks item set <id> --field verified=<your task> --note "<the fixer's reason; what you checked>"`.

Where it fails, send it back: `tasks item set <id> --state open --field kickbacks=<the defect's kickbacks plus one> --note "<what is still wrong, with the path:line and the path that shows it>"`. Name what is wrong, never how to fix it.

A change that edited prose the prose scope rule above leaves out of review, or a file the fix line rule above leaves alone, is sent back whatever else it did. The one exception is the rule's allowed corpus write: a C3 defect's artifact and the catalog TOCs its landing regenerated, where the C3 check above holds.
A change that edited a test is sent back the same way.

### A fix for a failing test

A defect whose `source` is `suite` came from the project's test suite in the sprint at [SPRINT PATH]. Its `test` field names the failure: a scenario whose test failed; `leftovers--<kind>`, a count of that kind a round left behind that grew; `stopped--silence`, a round that stopped after `testing.silence` with tests it left with no result; or `perf:<scenario>:<speed item>`, a test a speed reviewer found slow because the product does work at the defect's `site` that its answer does not use. Its fixer set it `fixed`, `at-fault`, or `promise`, or named it a duplicate. Check a `fixed` one as "Check each defect" above says, and check each of them as below. Read the test, its scenario in `.ok-planner/bin/tests plan --sprint [SPRINT PATH] --show`, and the product path the test runs.

- **fixed**: send the fix back where any of these holds:
  - It checks whether a test runs, reads a setting only a test sets, or treats the test's data as a special case. A time control a sprint's work item built is product code every deployment carries, not a setting only a test sets.
  - It hides a failure: a catch that swallows it, a longer wait, or a retry with no budget the code already had.
  - It fakes the effect the test looks for instead of doing the work.
  - It changes a file at a test path, a test support file, or a fixture, or it waits on elapsed time.
  - For a `flaky` defect, the note names no cause the change removes, or records the test as passing as the tree stands.
  - The test still fails: run `.ok-planner/bin/tests run --sprint [SPRINT PATH] --only <the scenario>`, or, for a `leftovers--<kind>` defect, each test its `tests` field names, whose count still grows, or, for a `stopped--silence` defect, each test its `tests` field names, one `--only` run each, a run of which still stops.
  - It fails a test that passed before it. Run `.ok-planner/bin/tests reached --sprint [SPRINT PATH] --files <every file the fix tasks staged>`, and run every test it lists in one `tests run --sprint [SPRINT PATH] --only` run. Where it prints none and says to rerun only the tests the fix was for, the run's final whole-suite round checks the rest. A test it lists that fails now, whose latest result in the results file beside the sprint (`-results.jsonl` in place of `.md`) from before the fix's first task passed, is a test the fix broke: name it in the send-back.
  - For a `perf:` defect, read the speed item its `test` names, from `tasks item list --pool speed --json`, or, where this run's ledger holds no item by that id, with `tasks --file <the run file beside the sprint, -run.jsonl in place of .md> item list --pool speed --json`, and send the fix back where any of these holds:
    - It leaves the slow work: the site, or code the fix moved it to on the test's path, still does the work the item's `does` names beyond what its answer uses.
    - It drops a promised outcome: the answer the site gives a caller, its errors, or its effects changed, or an outcome a story or the corpus promises no longer follows.
    - It fails a test that reaches the site. Run the scenario's test and every test `.ok-planner/bin/tests reached --sprint [SPRINT PATH] --files <the site's file and every file the fix tasks staged>` lists in one `tests run --sprint [SPRINT PATH] --only` run. A test that fails now, whose latest result from before the fix's first task passed, is a test the fix broke: name it in the send-back.

    Where none holds, set the defect `verified` as "Check each defect" above says. The product-slow verdict then settles: `tests failures` lists its entry no more, and the test gets a fresh speed read.
- **at-fault**: run the test, and read the product path the fixer's note names. The record holds where the product does what the story and the corpus commit to, and the test, its test support, its fixture, its data, or its declaration is what is wrong, in each test the `tests` field names. Where it holds, send each of those tests back to a test task, then set the defect `rewrite`, as "Send a test back" below says. Where the product is wrong, send the defect back, naming where the product goes wrong.
- **promise**: read each artifact the note names, the scenario, the test, and the code. The promise holds where no change to the code meets the test while the design corpus commits to what it says: `tasks item set <id> --state promised --note "<the artifact and its sentence; what you checked>"`, and the run's owner list files the issue. Where the test is at fault instead, name each test that shares the fault in `--field 'tests=[...]'` with a `reason`, and take the at-fault route: send each test back, and set the defect `rewrite`. Otherwise send the defect back, naming the change to the code that meets the test.

**Send a test back.** A test goes back to a test task through its scenario's latest item in this run's `tests` pool, `tasks item list --pool tests --json`. Where the pool holds an item for the scenario, set the latest one: `tasks item set <item> --state sent-back --field reason="<the defect's reason>"`. Where it holds none, add one: `tasks item add --pool tests --key <the scenario> --field scenario=<the scenario> --state sent-back --field reason="<the defect's reason>" --body "<the reason>; defect <the defect id>" --task <task>`. Then `tasks item set <the defect id> --state rewrite --note "<what you checked; each test sent back>"`. The run's write stage files a test task for each test sent back, and the test returns to the defect's confirm once its verifier accepts the rewrite.

### A restoration

A defect reached its limit of send-backs and is `stuck`, and a restorer returned the code its fixes changed to the behavior it had before them, keeping each change another defect needs. Your brief names the restore task and each refile of it, the defect, the attempt, the restoration's send-backs so far and the run's limit, and for each file, its content before the defect's first fix as a git blob, or `new` where the file did not exist then.

Read the restore task's result (`tasks dump --type task`); the stuck defect with its note; every other defect whose `files` field names a file in your brief, with its state and note; and for each file, `git diff <before blob> $(git hash-object -w <path>)`, or, for a `new` file, whether it still stands. Then check:

- **The prior behavior is back.** Every difference that remains between the before blob and the file is a change another defect needs: a `verified` defect's fix, the change of a defect still `open` or `fixing`, or a caller one of those needs. None of the stuck defect's change remains, save what another defect's change needs and the restorer's result names.
- **Every other accepted fix still works.** For each `verified` defect whose files name a file in your brief, walk its trigger through the code as it stands: the harm is still gone. Each decline or duplicate a verifier accepted in those files still holds.
- **The callers still work.** Every caller of anything whose signature, return, or raise the restoration changed back works with it.
- **The checks pass.** Run the project's checks on the changed files, in the foreground: each file passes, or fails only where it failed at its before blob.
- **The restoration stayed in bounds.** It edited only the files your brief names and the callers its walk reached. It may edit a file the fix line rule above leaves alone only where the stuck defect's own fixes changed that file.
- **It edited no test.**

Where every check holds, accept it: `tasks item set <the defect id> --field restored=<the restore task> --note "<what you checked>"`. The defect stays `stuck`.

Where one fails, send it back: `tasks item set <the defect id> --field restore_kickbacks=<its restore_kickbacks plus one, a missing field counting as 0> --note "<what is still wrong, with the path:line and the path that shows it>"`. Name what is wrong, never how to fix it. Where that count reaches the limit your brief names, the run restores no more: add `--field restored=stuck`, and end the note with `left: ` and the state the code is left in, file by file: which of the stuck defect's changes still stand, which prior behavior is not back, and which other defect's fix the code no longer serves.

Close: `tasks close <task> --outcome done --result "restoration of <defect id>: <accepted, sent back <n> of <limit>, or stuck>"`.

### Rules

Edit nothing, stage nothing, commit nothing. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Run nothing that starts the product, save the test runs "A fix for a failing test" names.

### Close

`tasks close <task> --outcome done --result "<n> verified, <n> declines accepted, <n> promised, <n> rewrite, <n> sent back: <defect ids by outcome>"`.

### The accept list

[ACCEPT]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
