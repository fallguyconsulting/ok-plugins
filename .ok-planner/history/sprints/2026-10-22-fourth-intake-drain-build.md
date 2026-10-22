Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

  This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

  You build one stage of the sprint at .ok-planner/sprints/2026-10-22-fourth-intake-drain.md. Your brief names
  the work items the stage lands, the corpus deltas it applies, the
  behavior changes it carries by id with their rulings, and where the
  code is. Your task's files are the paths you may edit. Read the
  sprint's intent, its deltas, the work items you land, and their
  implementation notes before you write.

  ### The stage

  - Write the code the notes name. Apply each corpus delta the stage
    carries: copy the final-form body verbatim (from the sidecar where
    the heading points there) into its home, `.ok-planner/design/` for
    a concept, story, or decision, `.ok-planner/subjects/` or
    `.ok-planner/practices/` for a subject or practice,
    `.ok-planner/docspec/` for a docspec, and
    `.ok-planner/surface/surface.md` for the surface intent, or delete
    the file for a retirement. After every delta but a surface intent
    delta, run `python3 .ok-planner/bin/catalog-toc` to regenerate
    that collection's TOC, the docspec index `.ok-planner/docspec.md`
    after a docspec delta.
  - Every new or amended story implemented in code carries the
    `@story:` annotation at the site that realizes it.
  - Where the stage adds or changes an input of a script
    `.ok-planner/review/project.md` lists, update that script's entry
    in the same stage, keeping every limit the file's `## What no agent
    of this loop ever runs` section sets.
  - Keep each ruling your brief names. A `preserve` behavior stays
    unchanged for its users across the boundary. A `migrate` behavior
    lands its migration in this stage. A `rewrite` behavior brings
    every user the notes list along.
  - Where your code changes a behavior a user can observe and the
    notes list no such change, record it: `tasks item add --pool
    divergences --key <your key> --field kind=call --field
    site=<path::symbol> --field choice="<one line>" --body "unlisted
    behavior change: <path::symbol>; before: <...>; after: <...>;
    users: <...>" --task <task>`. Sprint certification judges it.
  - Record each improvement the stage lands, by its I-id: `tasks item
    add --pool divergences --key <your key> --field kind=improvement
    --field site=<path::symbol> --field choice="I<n>: <one line>"
    --body "<what the code does now>" --task <task>`.
  - Completeness is the floor. Deliver every outcome the brief
    promises, or close `blocked` naming what stops you. A stub, a
    `TODO`, or a no-op standing in for an outcome is an undelivered
    outcome.
  - Run the project's checks (`.ok-planner/review/config.json` `checks`
    lists them) on every file you changed, in the foreground, and close with no
    process of your own still running. Leave the tree runnable.
  - Write no documentation and no doc comment: a documentation sprint
    writes them after the code settles. Leave every file under the
    `## Where` of a docspec at `.ok-planner/docspec/<slug>.md` as it
    stands, and every doc comment, save one on a declaration the stage
    removes, which goes with it.
  - Add, edit, delete, and run no test: a test sprint owns the tests.
    Leave every file at a test path as it stands. Where a check fails
    only because a test reaches code the stage changed or removed,
    record it as a call naming the test, and go on: the next test
    sprint settles the test.

  ### The coding rules

  Follow `.claude/rules/plumbline-coding.md` rules 1, 3, 4, 6, 7, and
  9, and rule 5 before you delete anything, together with
  `.claude/rules/plumbline-cheatsheet.md` and
  `.ok-planner/docs/events.md`, on every line you write: enumerate
  before you edit, walk every exit of a function that holds state,
  one state change in one transaction, import never copy, and before
  you delete a route, verb, column writer, helper, or branch, list
  what it alone provides and record a fork where the deletion
  removes the only writer or the only site that realizes something
  the corpus still claims. Rule 2, copy the sibling's shape, does not
  bind you, and rule 9.4's sibling citation is void with it, so your
  note carries the enumeration alone. The standard fixes the shape of
  a handler, an emission, a teardown, a lock, or a retry; where the
  standard leaves a choice open, keep the shape the file you are
  editing already uses for that job, or choose and record a call
  where it has none. Never read a sibling file to decide a shape. The
  rules govern what you write; they do not send you sweeping for
  anything your brief marks as another loop's. To learn what a shell
  construct does, test the construct alone, with throwaway functions,
  in the foreground.

  ### Calls, forks, and what you notice

  Every item you add to the divergences pool carries `--field
  site=<path::symbol>`, the site it concerns, and `--field
  choice="<one line>"`, what you chose there, so the completion
  report's calls table shows it in one row. Where the sprint is
  silent, make the most plausible call, continue, and record it:
  `tasks item add --pool divergences --key <your key> --field
  kind=call --field site=<path::symbol> --field choice="<one line>"
  --body "<the call>" --task <task>`. Where the sprint and corpus do
  not decide and reasonable owners diverge, build the reading you
  judge best and record the fork with its options: `--field kind=fork
  --state fork`, with the reading you built as its choice. Sprint certification settles every
  fork: one the sprint or corpus decides becomes work or nothing, and
  the rest become questions for the owner.

  A defect you meet outside your files is recorded once and left;
  sprint certification reads it as a report: `tasks item add --pool
  divergences --key <your key> --state noticed --field kind=noticed
  --field file=<path> --field site=<path::symbol> --field
  choice="<one line>" --body "<the site; the harm>" --task <task>`. A site outside your files that your own
  change must reach (a caller of a definition you changed) is yours:
  stage what you built and close `partial` with a result that starts
  `outside files: <path>: <site>`.

  A harm whose fix lies in a part the project does not own — a file
  the suite owns, a library the project depends on, an outside tool or
  service — is the one issue you file, and the intake the one write
  outside your task's files. Every read and write of the intake goes
  through `.ok-planner/bin/issues`. First look for an open issue on the
  same harm: `.ok-planner/bin/issues list` prints every open issue's
  id, state, category, and title, and `.ok-planner/bin/issues show
  <id>` prints one whole. Where one stands, file nothing and name its
  id in your close result. Otherwise file one issue with
  `.ok-planner/bin/issues file --from -`, one JSON object on stdin in
  the format of the `{{ISSUE-FILE-FORMAT}}` block of
  `.claude/skills/_shared/artifact-definitions.md` (open that file and
  read the block): kind `sprint`, `category: upstream`, the `problem`
  naming the foreign part as the project sees it (the package and its
  version, the tool, or the file's path as it sits in the project,
  never a path to a local checkout), the site, the harm, and the
  evidence, and the `upstream` draft ready to file. Call the suite
  "the ok suite". Where `.ok-planner/bin/issues` refuses the filing, name the
  harm and its message in your close result instead. Stage
  `.ok-planner/issues.jsonl` and list it under `--staged`.

  ### Rules

  - Never destroy uncommitted work. Stage the paths you touched by
    name as you finish (`git add <paths>`). Never run `git
    checkout`/`restore`/`reset`/`stash`/`clean`. Fix a bad edit
    forward by editing again. The owner commits.
  - Read files before editing.

  ### Close

  Close with every path you touched under `--staged`, every site your
  searches returned under `--sites` (`path[:locator]`, `=standing`
  after one that already had the shape), and one line in the result
  naming what the stage now does. A stage you could not finish closes
  `partial` with where you stopped and what is staged.
