# The sprint document

The planning session's terminal artifact, defined once. `/plan-sprint` writes every sprint from this template and never restates it.

`{{SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to execute this sprint** and **Completion contract** sections are fixed boilerplate: copy them verbatim into every sprint. The how frames the executor's approach; the contract is the stop condition; sprint certification (`/converge sprint`) discharges the contract. Every executor — `/goal`, an orchestrator, an inline session — works from the same brief.

The template carries no approval mark, so a draft never has one. The planning session writes the mark once the owner approves the sprint: YAML frontmatter above the title, a `---` line, `approved: <date>`, and a `---` line. Every executor refuses an unmarked sprint that has no base file beside it.

---

### {{SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Sprint: <title>

## Intent

<What this sprint is for, in a few sentences. A sprint with no single
theme says so. List the ids of the issues promoted into this sprint,
if any.>

## Corpus deltas

<Authored per {{CORPUS-DELTA-FORM}} in `artifact-definitions.md`.
Each delta sits under a heading naming the operation and target:>

### New story: <slug>
### Amend concept: <slug>
### Retire decision: <slug>
### New docspec: <slug>
### Amend surface intent

<Every delta is a complete final-form body. New artifacts and
amendments carry the whole file content; a retirement carries only
its heading. Large bodies go in the sidecar folder beside this file
(`<sprint-name>-deltas/<kind>s/<slug>.md`, a docspec at
`<sprint-name>-deltas/docspecs/<slug>.md`, the surface intent at
`<sprint-name>-deltas/surface/surface.md`), and the line under the
heading reads `body: in the sidecar`. No delta carries a diff, a base
pin, or a derivation.>

## Work items

<The implementation units that realize the deltas: a flat, unordered
list. Each names the stories and decisions it makes true (by slug)
and describes the outcome, not the method. Each changes the product:
its code, configuration, documents, or design corpus. An item that
consists of using what the sprint builds is reshaped into the
feature, script, or seed asset that lets a user reach the outcome.
No item needs a person during execution or certification; a story
whose benefit passes through a party outside the product gets a work
item that builds its local stand-in. State real dependencies between
items. Sequencing is the executor's job.>

## Tests

<Written by the planning session's Test planning step. One line names
the testing state `tests enabled` printed: `on`, `frozen`, or `off`.
Under `off` the section holds that line alone, and the sprint has no
test plan. Under `on` or `frozen` the section then records:>

- **Groups taken:** each offer group the owner took at Frame, by its
  key from `tests offers`, and each story the owner named to widen.
- **Re-planned stories:** each tested story whose behavior the work
  items change, as code planning listed it and the notes review
  checked it.
- **Owner's test answers:** each programs question, outcome-changed
  question, and code-removed question, with the owner's answer.
- **Counts:** the counts `tests plan` printed when it wrote the plan:
  scenarios by action, legacy tests by sort, unguarded programs,
  calls, and test files kept.
- **Plan:** the path of `<sprint-name>-plan.json` beside this file.
  Where the `tests plan --show` output is too long to read in the
  session, the session writes that output to `<sprint-name>-plan.md`
  beside this file, and this line names that file too.

## Paths outside the project root

<Only where a work item changes files outside the project root: one
line per folder, a bullet holding the path relative to the project
root in backticks, such as:>

- `../runtime`

<Omit the section when every work item stays inside the project root.
Sprint certification reviews, checks, and fixes the files under each
listed path beside the files under the project root.>

## Implementation notes

<Written by the planning session's code planning, in the form
{{IMPLEMENTATION-NOTES-FORM}} in `.claude/skills/plan-sprint/core.md`:
the commit the notes were planned against, then per work item the
code changes, the improvements the sprint takes, and every behavior
change with its users and ruling.>

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues.jsonl`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner. Where `/goal` handed you this file, its checker is
   a separate model that reads only the session: it opens no file and
   runs no command. State its stop condition in your first message,
   in these words: "This goal is met when `.ok-planner/bin/review
   certified --sprint <this sprint's path>` prints `SPRINT COMPLETE`
   in this session. The goal also ends, unmet, when that command
   prints `SPRINT STOPPED` in this session: the run stopped, and the
   owner takes up the reason. Archiving and committing are the
   owner's acts, not goal terms." Then, where the stop record
   `<sprint-name>-stopped.txt` stands beside this file, delete it
   before the run goes on, so this goal takes the run up again.

2. Check that the run can start, then record the base. Every check
   here runs before the base is written; where one stops the run,
   stop it as step 11 says, with its message as the reason. First
   run `.ok-planner/bin/review approved --sprint <this sprint's
   path>`. Where it refuses, stop: this file may be a draft the owner
   never approved, or the review estate lacks the
   `.ok-planner/review/config.json` the command reads. Then check the
   task tracker at `.ok-planner/bin/tasks` and the profiles under
   `.claude/agents/`: a missing one is the front door's
   administration (`/ok`) to materialize, so stop and say so. Then,
   where `<sprint-name>-plan.json` stands beside this file, or
   `testing.enabled` in `.ok-planner/config.json` is `on`, the run
   opens its test stages (step 3), and `.ok-planner/bin/tests` is
   required too: where it is missing, stop and say so.
   Where the base file stands beside this sprint (the same filename,
   `-base` before the extension and `.txt` as the extension), the
   run stopped before and resumes: keep that base, skip the
   uncommitted-paths check, and go on to step 3. Where the
   `<sprint-name>-certified.txt` mark also stands, run
   `.ok-planner/bin/review certified --sprint <this sprint's path>`
   first and show its output whole. Where it prints `SPRINT
   COMPLETE`, the goal is met with no new certification: offer the
   archive and the commit below as one owner act, as step 13 does.
   Otherwise go on to step 3.
   Where no base stands, sprint certification reads the change from
   the base commit, so the tree holds nothing but this sprint's work
   from here on. The planning session leaves its own files
   uncommitted: this file, its delta sidecar,
   `.ok-planner/release-boundaries.md`, the intake's two files
   (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches and the
   discovery it archived. Where `git status --porcelain` lists a path
   outside `.ok-planner/`, stop, naming those paths, because
   certification would count them as this sprint's work. Otherwise
   write the output of `git rev-parse HEAD` to the base file.

3. Open the run. Where `.ok-planner/sprints/<sprint-name>-run.jsonl`
   stands, the run resumes: run `tasks use <that path>`, which also
   moves the tracker's pointer back from a `/converge` ledger, then
   `tasks retry --all`, which issues again every task that did not
   close `done` and every task an agent claimed and never closed.
   Otherwise run `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`. Either way, run
   every registration and config below, again on a resumed run:
   `tasks agent register ok-opus`, and register the `build` prompt:
   write it with
   `.ok-planner/bin/review prompt --name build --sprint <this sprint's
   path> --out .ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.
   Where step 2 found that the run opens its test stages, open them:
   a sprint with `<sprint-name>-plan.json` beside it plans tests, and
   under `testing.enabled` `on` the run opens them whether or not the
   sprint plans tests, for step 4's speed read. For each role and
   its template, `preflight` from `test-preflight`, `support` from
   `test-support`, `test` from `test-write`, `legacy` from
   `test-legacy`, `sweep` from `test-sweep`, `verify` from
   `test-verify`, and `speed` from `test-speed`, write the prompt with
   `.ok-planner/bin/review prompt --name <template> --sprint <this
   sprint's path> --out .ok-planner/sprints/<sprint-name>-<role>.md`,
   then `tasks prompt register <role> <that path>`. Declare the test
   pools: `tasks config set item_states '{"tests": ["open",
   "accepted", "sent-back"], "support": ["open", "made"], "ports":
   ["open"], "promises": ["open", "held", "rejected"], "speed":
   ["accepted", "sent-back", "product-slow"]}'`, and the fields their
   readers take as numbers: `tasks config set field_types '{"tests":
   {"silence": "integer"}, "speed": {"seconds": "number", "rank":
   "integer"}}'`. Select the test stages' calls for the completion
   report's `## Calls` beside the build's: `tasks config set calls
   '[{"pool": "divergences"}, {"pool": "calls"}]'`.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (`.ok-planner/design/concepts.md`,
   `stories.md`, or `decisions.md`, `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, or the docspec index
   `.ok-planner/docspec.md`, every one of which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.
   Where the run opened test stages, file them after the build tasks.
   They are not build tasks, and they change no product code. Run
   `.ok-planner/bin/tests tasks --sprint <this sprint's path> --stage
   write --after <the latest build task of each code stage whose files
   a planned scenario's entry or support reaches>`. Where no code
   stage's files hold one, run it with no `--after`, and the test
   stages run beside the code stages. Every `--stage write` takes the
   same `--after`: the stage follows each task it names to that
   task's latest refile, so a code stage refiled under step 7 needs no
   new `--after`. Where the plan's budget names a test stack, the
   stage files the preflight task alone first, and files the rest
   once it closed `done`: one support task per support file the
   scenarios name and per open `support` item, one test task per
   scenario the plan writes, rewrites, or retires, each after the
   support tasks for its files, and one legacy task per legacy file.
   Drain with step 7's loop. After each drain, run `tests tasks
   --sprint <this sprint's path> --stage verify`, which files one
   verify task per test or promise a test task recorded that awaits
   its verifier, and drain. The next `--stage write` files again each
   test a verifier sent back, with the reason, and each test task
   that closed `blocked` having filed a `support` item, after the
   support task that makes it. Repeat `--stage write`, `--stage
   verify`, and the drains until neither stage files a task. Then
   `.ok-planner/bin/tests ports --sprint <this sprint's path>` adds
   each check the legacy tasks ported to
   `.ok-planner/review/config.json` `checks`. Where it refuses because
   a ported command starts a test runner, it adds no check: refile
   each legacy task it names with the refusal, `.ok-planner/bin/tasks
   refile <task> --brief "<its brief>; revise: <the refusal>"`, drain,
   and run `tests ports` again, until it adds the checks. Then, while
   `.ok-planner/bin/tests stray --sprint <this sprint's path>` lists a
   file, run `tests tasks --sprint <this sprint's path> --stage sweep`
   and drain. Then, where `.ok-planner/bin/tests enabled` prints `on`,
   run `tests tasks --sprint <this sprint's path> --stage speed --from
   state` once. It files one speed task for each of the
   `testing.slowest` slowest tests in the ranking the scenario list
   carries that has no speed acceptance at its current test file.
   Drain. Where a speed reviewer sent a test back, run `--stage write`
   and `--stage verify`, and drain after each, until neither files a
   task, so the rewrites land before sprint certification starts.
   On a resumed run, file no stage twice. File no build task for a
   work item some build task's `--cites` already names; file a stage
   only for a work item no filed task cites. The test-stage verbs run
   again from `--stage write`, with the same `--after`, and each
   files only what the run lacks.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist. Create one entry
   per stage when the build tasks are filed. Mark an entry in progress
   when the drain that runs its build task starts, or when its agent
   claims the task where the session runs the drain by hand, and done
   when that task closes `done`. Add one entry for sprint
   certification when every stage's build task has closed `done`.
   Mark that entry in progress at step 12 and done at step 13.
   On a resumed run, build the checklist from the run: one entry per
   stage the run holds, each marked done where its latest build task
   closed `done`.
   The run file is the record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with `tasks refile <task>
   --files <its files and that path>`. A build that closes `blocked`
   is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.
   A test-stage task that closes `partial` or `blocked` is refiled
   the same way, save two the write stage files again itself, which
   you never refile by hand: a test a verifier or a speed reviewer
   sent back, and a test task that closed `blocked` having filed a
   `support` item. The write stage's refusals are genuine blockers
   under step 11: where `--stage write` refuses because the preflight
   closed `blocked` twice, a `support` item records a change other
   than `missing`, `changed`, `fixture`, or `seed`, a support task
   closed `done` and left its `support` item open, a scenario's last
   two test tasks closed `blocked` and neither filed a `support` item,
   or a task it would file or refile waits on a task that, followed
   to its latest refile, closed other than `done`, surface its
   message and stop. So is `--stage speed`
   refusing because a test's last two speed tasks closed short of
   `done` or with no verdict.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every drain: `##
    Stages` from the build tasks and `## Calls` from the run's
    `divergences` pool, one row per call an agent made without the
    owner. Build tasks record calls, forks, what they noticed, and
    the improvements they landed as items; the report is rendered,
    never hand-edited.
    Where the run opened test stages, `## Calls` also shows the run's
    `calls` pool, where the test stages record their calls, each
    legacy test a legacy task deleted or ported among them, as step
    3's `calls` setting selects.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. No step of execution
    or sprint certification waits on a person: no work item, no call,
    no line of the review facts, and no story's drive. File no task
    for the owner to perform. Where a story's benefit passes through
    a party outside the product, the drive and the tests use the
    local stand-in the review facts name for it. The archive and the
    commit after completion stay the owner's one act. Stop only on a
    genuine blocker: a credential or
    access you cannot obtain, a step impossible in the current state,
    a destructive or irreversible action not clearly authorized, a
    task closed `blocked` twice, or sprint certification being
    unrunnable for you. To stop, wait until no agent you started
    still runs, then write the stop record: the file
    `.ok-planner/sprints/<sprint-name>-stopped.txt` beside this file,
    holding the reason as plain text, one line per reason. Then run
    `.ok-planner/bin/review certified --sprint <this sprint's path>`,
    show its output whole, and stop. While the record stands, it
    prints `SPRINT STOPPED` with the reason, which ends the goal. A
    new `/goal` on this file resumes the run from its base and its
    task record. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`, and, where the run opened test stages, every test-stage
    task closed `done` at its latest filing, with neither `--stage
    write`, `--stage verify`, nor `--stage sweep` left to file a
    task. Then mark the checklist's sprint certification entry in
    progress, and run sprint certification immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what every story promises when a driver uses
    the running product, every delta landed, every ruling holds, no
    unlisted behavior change breaks a user, and the project's checks
    pass. It fixes each defect in the sprint's scope, a drive failure
    the sprint's change caused among them, and verifies each fix on
    its own diff. A drive failure in code the change did not reach,
    and any other defect outside the sprint's scope, goes to the
    intake as a `category: defect` issue for the next `/converge`,
    and a question only the owner can decide goes to the intake for
    the next `/plan-sprint`.
    It ends by presenting its return block.

13. Re-render the completion report whole with the certification's
    calls: write the output of `tasks --file
    .ok-planner/sprints/<sprint-name>-run.jsonl render --title
    "<this sprint's title>" --sprint <this sprint's path>
    --certification <the /converge run's ledger>` to the report
    file. `--file` names this sprint's run, because `/converge`
    moved the tracker's pointer to its own ledger. Then write the
    return block into the completion report, after its rendered
    sections, under a `# Sprint certification` heading, with the
    `/converge` run's ledger path. Nothing renders the report after
    this. Mark the checklist's sprint certification entry done. Then
    run `.ok-planner/bin/review certified --sprint <this
    sprint's path>` and show its output whole. It checks items 1 to 3
    of the completion contract against the repository, and prints
    `SPRINT COMPLETE`, or `SPRINT NOT COMPLETE` with each failure.
    Whichever it prints, present the completion report's `## Calls`
    table to the owner and follow `{{CEREMONY-VETO}}` in
    `.claude/skills/_sprint/shared.md`, with `<rows>` as the rows of
    the completion report's `## Calls` table and `<problem>` as the
    row. Then, where it printed `SPRINT NOT COMPLETE`, name each
    failure to the owner and stop the run as step 11 says, with each
    failure a line of the stop record, without offering the archive:
    it is a genuine blocker under step 11. Where it printed `SPRINT
    COMPLETE`, offer the archive and the commit below as one
    owner act. Walk nothing else with the
    owner: every defect the run could not fix and every question it
    raised is already in the intake, for the next `/converge` or
    `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Close each issue this sprint promoted: for each id that
   `.ok-planner/bin/issues list --sprint <this file's name>` prints,
   run `.ok-planner/bin/issues close <id> --as promoted`, which moves
   its record to `.ok-planner/history/issues.jsonl`.
2. Run `.ok-planner/bin/tasks split <path> ...` on this sprint's run
   file, its `-results.jsonl` file where one exists, and the
   `/converge` run's ledger, in place under
   `.ok-planner/review/runs/`, and show its output whole. It splits
   each file larger than `archive.part_bytes` in
   `.ok-planner/config.json` into numbered parts beside it,
   `<name>.part<n>.jsonl`, and removes the whole file from git's
   index and the disk; it leaves a smaller file whole. Split no other
   file: the intake's two files stay whole. Then move this file and
   every file and folder beside it that shares its filename to
   `.ok-planner/history/sprints/`: each one whose name is this
   sprint's name, a `-`, and a suffix, such as the completion report,
   the run file or that file's parts, the `-results.jsonl` file or
   its parts, the `-base.txt` file, the `-certified.txt` mark
   `review certified` writes, the `-stopped.txt` stop record where
   one stands, every prompt the run wrote, the test
   plan, and the delta sidecar. `ls -d
   .ok-planner/sprints/<sprint-name>-*` lists them; leave out the
   files of another sprint whose name starts with this one's. Use
   `git mv` for a tracked file and `mv` for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger or its parts and
   its folder, the intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`, and each sketch and each
   discovery file the planning session archived, at its old path and
   its new one: `git status --porcelain --untracked-files=all --
   .ok-planner/sketches .ok-planner/history/sketches
   .ok-planner/discoveries .ok-planner/history/discoveries` lists
   them: an `R  <old> -> <new>` line names both paths of a file
   `git mv` moved, a ` D <old>` or `D  <old>` line names a removed
   path, and a `?? <new>` line names a new path under
   `.ok-planner/history/`. Commit those paths alone with
   `git commit -- <paths>`, naming each path that exists and each
   removed path the last commit holds, a `git mv` source, a whole
   file the split removed, or a file a task removed with `git rm`
   among them, and no other, so nothing
   else standing in the index rides along.
4. Where `<sprint-name>-plan.json` stands beside the archived sprint,
   or `.ok-planner/bin/tests enabled` prints `on` or `frozen`, so
   sprint certification ran the suite, run `.ok-planner/bin/tests
   stamp --sprint .ok-planner/history/sprints/<this file's name>
   --commit <the
   commit's sha>` and show its output whole. It writes each planned
   story's test stamp, the scenario list, the speed ranking, the speed
   acceptances, and the `reaches` lists into
   `.ok-planner/test-state.json`. Then add `closed: <the commit's
   sha>` to the archived sprint's YAML frontmatter, beside its
   `approved:` mark, or as new frontmatter where the sprint has none.
   Commit both together, the archived sprint and, where the stamp
   ran, `.ok-planner/test-state.json`, with `git commit -- <those
   paths>`. The next planning session reads the `closed:` stamp to
   detect work done out of band, and its test planning reads the
   story stamps.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, and
   `.ok-planner/docspec/` for a docspec, each with its catalog TOC
   regenerated, the docspec index `.ok-planner/docspec.md` among
   them; and `.ok-planner/surface/surface.md` for the surface
   intent.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched, or fail
   only where sprint certification's return lists the failure as a
   `stuck` defect.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, `stuck`, or `promised`, with every `stuck` defect
   listed for the owner. Where the project has a story, the run's
   drive ran: drive commands unfilled or refused, or a stack that
   failed to start, mean it did not. Where `testing.enabled` in
   `.ok-planner/config.json` is `on` or `frozen`, the run's suite ran
   too: a whole-suite round ran after the last change, and every test
   that failed in it is `promised`, held by a `promised` defect or by
   an open issue on its scenario; every speed send-back is settled or
   returned to its last passing version; no code task, a build task
   or a certification fixer, staged a test path; and no stray test
   file stands, one no planned test claims and no plan kept.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
`.ok-planner/bin/review certified --sprint <this sprint's path>`
checks them there and prints `SPRINT COMPLETE` or `SPRINT NOT
COMPLETE`. While the stop record `<sprint-name>-stopped.txt` stands
beside this sprint, it prints `SPRINT STOPPED` with the record's
reason and checks nothing else: that line ends the goal while the
contract stays unmet, and the owner takes up the reason. Under `testing.enabled` `on` or `frozen`, it checks item
3's suite terms too: the whole-suite round after the last change,
every failure in it `promised`, every speed send-back settled or
returned to its last passing version, no test path a code task
staged, and no stray test file. Under `off`, the suite is no term. A
checker that reads only the session, as `/goal`'s does,
decides from that command's latest output in the session; a checker
that runs commands runs it. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open. A `promised` defect is
the owner's too, through the issue the run files for it, and holds
no term open either.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion, and none is a term of the
goal. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
```
