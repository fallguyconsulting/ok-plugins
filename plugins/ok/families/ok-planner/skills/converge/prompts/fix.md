## Fix a group of defects

{{LEAF-AGENT-RULE}}

{{PROSE-SCOPE-RULE}}

{{FIX-LINE-RULE}}

Your brief lists defects from the run's defect list, grouped because their fixes touch the same files. You fix each one at its root, in every file the fix reaches, in this task. A verifier reads your change next, against each defect and against the accept list; so make each fix complete and make it change nothing else.

You do not hunt. The defects in your brief are your whole job.

### Read

1. Each defect in your brief: `tasks item list --pool defects --key gate --state fixing --json`, the items your brief names. Where a defect has a `note` from a verifier, a fix of yours was sent back: the note says why, and your fix answers it.
2. The code at each site, whole functions, and every caller or reader your fix will reach: `rg` for the symbol and every literal that restates it; for references, load the LSP tool once with `ToolSearch("select:LSP")`, then call it.

### Fix

For each defect:

1. Confirm it is real and covered by the accept list, pasted below, or, for a defect whose `entry` names a sprint class (C1 to M1, and T1 to T4 for a defect whose `source` is `suite`, in the sprint catalog of `.claude/skills/_sprint/shared.md`), by that class, whatever the defect's `source`. A defect whose `source` is `suite` is fixed as "A failing test" below says, and is never declined: its test checks a promise. A defect from a skill surface is fixed by making the skill text, or the script or tool it calls, deliver what the story promises. A defect from a `stuck` story is fixed by making the product deliver what the story names: where the defect names a message or a help text, make it tell the user what went wrong or what to do next; where the story names a page, a verb, or a flow the product does not offer, build it. A defect you find is not real, or whose harm the list leaves standing, is declined: `tasks item set <id> --state declined --field choice="<one line: why it stands>" --note "<why, with the code that shows it>"`. A defect that is the same flaw as another in your brief, or as another on the list, is a duplicate: `tasks item set <id> --state duplicate --field same_as=<the defect id> --field choice="duplicate of <the defect id>" --note "<the defect id it duplicates>"`. A verifier checks every decline and duplicate, and the run's calls table shows each one in one row.
2. Fix it where the flaw is, not where it shows. Where the fix changes what a function takes, returns, or raises, bring every caller along in this task. Where the fix reaches a file another open task holds (`.ok-planner/bin/review held --task <your task> <paths>` exits 2), add those paths to the defect's files so the next round groups it with them (`tasks item set <id> --field 'files=[<its files and the new paths>]'`), finish every other defect, then close `partial` with a result that starts `outside files: <the paths>`.
3. Change nothing the defect does not need: no rename, no reshaping, no fix of something you happened to notice.
4. `tasks item set <id> --state fixed --note "<what you changed, where, and why that removes the harm; every file you changed>"`.

A defect whose `entry` is C3 is a delta of the sprint at [SPRINT PATH] that did not land, and you land it. Read the delta's body from the sprint, under its heading, or from its sidecar beside the sprint where the line under the heading reads `body: in the sidecar`: `<sprint-name>-deltas/<kind>s/<slug>.md`, or `<sprint-name>-deltas/surface/surface.md` for the surface intent. Copy the body into the artifact's file with no edit, or delete the file for a retirement. Then run `python3 .ok-planner/bin/catalog-toc` and stage the artifact and every TOC it rewrote, the docspec index among them (`git add <paths>` stages a deletion too). This copy and these TOCs are the one corpus write the fix line rule above allows.

Where you notice a defect that is not in your brief, leave it and record it once: `tasks item add --pool calls --key gate --field kind=noticed --field file=<the file> --body "<the site; the harm, in an accept entry's terms>" --task <task>`. The next run's hunt reads code, not this note; the note reaches the owner.

Where the code and the design corpus do not decide what the fix should be, and reasonable owners would choose differently, build the reading you judge best and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=<the file> --body "<the site; the choice; the readings, and the one you built>" --task <task>`.

### A failing test

A defect whose `source` is `suite` came from the project's test suite in the sprint at [SPRINT PATH]. Its `test` field names the failure: a scenario, whose test failed; `leftovers--<kind>`, a count of that kind the round left behind that grew; `stopped--silence`, a round that stopped after `testing.silence` with no result and no output, which step 9 fixes in place of steps 2 to 4; or `perf:<scenario>:<speed item>`, a test a speed reviewer found slow because the product is slow, which step 8 fixes in place of steps 2 to 4. Its `round` names the round it failed in, and `flaky=true` says the test failed in that round and passed alone after it, with no change since. Start from the test being right, and follow the evidence.

1. **Read.** The test, whole, and its scenario, from `.ok-planner/bin/tests plan --sprint [SPRINT PATH] --show`, with its story under `.ok-planner/design/stories/` or the accept-list entry it names. The round in the results file beside the sprint (`-results.jsonl` in place of `.md`): its header, the test's result and output tail, and the start and arrival of every result in the round. The product path the test runs, from the entry point it calls to the result it checks.
2. **Run it alone.** `.ok-planner/bin/tests run --sprint [SPRINT PATH] --only <the scenario>`. The run records a rerun round, and prints the result and the leftover counts around the run.
3. **Route by what you find.**
   - **It fails.** Find where the product goes wrong, and fix the code there. A fix may change code to meet what the story promises, to make the code testable, or to make tests faster. It never makes the code check whether a test runs, read a setting only a test sets, treat the test's data as a special case, hide a failure, or fake the effect the test looks for.
   - **It passes, and the defect is `flaky`, or no change since its round reaches it** (`.ok-planner/bin/tests reached --sprint [SPRINT PATH] --files <each file changed since the round>` does not list it): the test is flaky, and broken until its cause is found. Never record it as passing as the tree stands. Read the tests that failed with it in the round and those that ran beside it, by their start and arrival, and the test stack's logs for that window, where the project's facts below name them. Reproduce the failure with `tests run --sprint [SPRINT PATH] --only <the test and the tests that ran beside it>`, which runs at the round's worker count, the budget's. Route the cause: the product failing under load takes a product fix; tests that share state or timing take a missing `resources` or `reads` declaration, or another fault of the test, which you record as below; and a test that leaves something behind takes a count `testing.leftovers` prints, whose command is a project file you fix where it misses that kind.
   - **It passes, and a change since its round reaches it**: another fix fixed it. Set it `fixed`, naming that change and your run.
4. **After a fix**, run the test again, and run every test `.ok-planner/bin/tests reached --sprint [SPRINT PATH] --files <every file you changed>` lists, in one `tests run --sprint [SPRINT PATH] --only` run. A test that passed before your change and fails after it means your fix is not done. Then set the defect `fixed` as "Fix" above says, naming each test you ran and its result.
5. **A test at fault.** Where the test, its test support, its fixture, or its data is at fault, a missing declaration included, and the product does what the story and the corpus commit to, change nothing. Name every other test that shares the fault: `tasks item set <id> --state at-fault --field 'tests=[<the test and each other test that shares the fault>]' --field reason="<what is wrong with each test, and what it must check or declare instead>" --note "<the evidence: the product path that shows the product right, path:line, and the test line that is wrong>"`. Where a speed rewrite changed the test file since the test last passed (a `speed` item in this run's ledger, `tasks item list --pool speed --json`, sent the test back, recording the test file's blob before the rewrite as its `digest`), the rewrite is at fault: the reason reads `return the test file to blob <the digest>, its last passing version: its speed rewrite fails, and the speed send-back stays open for the next sprint`.
6. **A promise.** Record one only where the commitment itself stands in the way: no change to the code meets the test while the design corpus commits to what it says. `tasks item set <id> --state promise --note "<the artifact and its sentence; what the test needs; why no change to the code meets both>"`. A test you find at fault is never a promise.
7. **A grown leftover count.** Where the defect's `test` is `leftovers--<kind>`, the round left more of that kind behind than it started with. Run the round's tests alone, one `--only` run each, starting with those whose output or reach touches that kind, until you find each test whose run grows the count. Where the product leaves it behind, fix the product, and set the defect `fixed` with `--field 'tests=[<each test that grew the count>]'`. Where a test or its test support leaves it behind, record it at fault, as step 5 says, with those tests.
8. **A slow product.** Where the defect's `test` is `perf:<scenario>:<speed item>`, its `entry` T3, a speed reviewer found the scenario's test slow because the product does work at the defect's `site`, a `path::function`, that its answer does not use. Read the speed item the `test` names, from `tasks item list --pool speed --json`, or, where this run's ledger holds no item by that id, from the sprint's run, the run file beside the sprint (`-run.jsonl` in place of `.md`): `tasks --file <that file> item list --pool speed --json`. Its `does`, `grows`, and `cheaper` fields say what the site does, how its cost grows, and the cheaper behavior.
   1. Run the test alone, `.ok-planner/bin/tests run --sprint [SPRINT PATH] --only <the scenario>`, and note its seconds.
   2. Change the product so the site does only the work its answer uses. Keep every outcome: the answer the site gives each caller, its errors, its effects, and each outcome a story or the corpus promises stay as they were. The limits step 3 sets on a fix hold.
   3. Run the test again, with every test `.ok-planner/bin/tests reached --sprint [SPRINT PATH] --files <the site's file and every other file you changed>` lists, in one `tests run --sprint [SPRINT PATH] --only` run, and note the test's seconds. A test that passed before your change and fails after it means your fix is not done.
   4. Set the defect `fixed` as "Fix" above says, naming the work the site no longer does, the test's seconds before and after, and each test you ran and its result.

   Where the site already does only the work its answer uses, and the test's time goes to waste of its own, record the test at fault, as step 5 says, with that waste as its reason.

9. **A stopped round.** Where the defect's `test` is `stopped--silence`, the round stopped after `testing.silence` seconds, or the longer silence a test still running declared, with no result and no output, and its results record each test it left with no result as `not run`: one of them hangs. Run those tests alone, one `.ok-planner/bin/tests run --sprint [SPRINT PATH] --only <the test>` run each, until you find each test whose run stops. Where every one passes alone, reproduce the stop with one `--only` run of those tests together, at the round's worker count, and route the cause as the flaky route in step 3 says. Where the product hangs, fix the product, run each of those tests again, and set the defect `fixed` with `--field 'tests=[<each test whose run stopped>]'`. Where a test or its test support hangs, record it at fault, as step 5 says, with those tests.

Change no file at a test path, no test support file, and no fixture: a test changes only through a test task, after a verifier accepts the fault you record. Code you change that a test runs, a tool under the project's control included, keeps the tests within the silence rule:

{{TEST-SILENCE-RULE}}

### Release boundaries and a sprint's rulings

A fix keeps every user across a release boundary working. Read `.ok-planner/release-boundaries.md` and `.ok-planner/surface/surface.md`, each where it exists.

{{RELEASE-BOUNDARIES}}

{{BEHAVIOR-CHANGE-DEFINITION}}

This run certifies the sprint at [SPRINT PATH], or no sprint where that reads `none`. Where it names one, read its implementation notes: a fix keeps every `preserve` behavior unchanged for its users across the boundary and every `migrate` behavior's migration, as the rulings below define them.

{{BEHAVIOR-RULINGS}}

A fix that must change a behavior a user across a boundary observes, where no ruling allows it, is declined with a question recorded: that change is the owner's to rule on.

### The coding rules

{{CONVERGE-CODING-RULES}}

<!-- lint-check: no-tests -->
Add, edit, and delete no test; run and read a test only where your brief names a failing one.
<!-- /lint-check -->
Run the project's checks on every file you changed, in the foreground, and close with no process of your own still running. Leave the tree runnable.

### Rules

- Never destroy uncommitted work. Stage every path whose content you changed, by name (`git add <paths>`). Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Fix a bad edit forward by editing again. Do not commit.
- Edit prose only where the prose scope rule above puts it in review. Edit no file the fix line rule above leaves alone, per the project's facts below, except the rule's one allowed corpus write: a C3 defect's artifact and the catalog TOCs its landing regenerates. Where a defect's fix lies only in such a file, decline the defect with a note naming the file and the kind `.ok-planner/bin/review owner` prints for it, and record it once as `noticed` with that file, so the owner list routes it.

### Close

`tasks close <task> --outcome done --staged <every path you changed> --sites <every site you changed, path[:locator]> --result "<n> fixed, <n> declined, <n> duplicate, <n> at-fault, <n> promise: <defect ids by outcome>"`. A `done` close refuses while any defect of your brief stands at `fixing`: set each one `fixed`, `declined`, `duplicate`, or, for a suite defect, `at-fault` or `promise`, or close `partial`. A group you could not finish closes `partial` with where you stopped and what is staged.

### The accept list

[ACCEPT]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]
