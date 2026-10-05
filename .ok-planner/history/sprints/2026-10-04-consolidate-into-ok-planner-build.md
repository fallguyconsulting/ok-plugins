Task prompt (profile ok-opus):
  ## Build one stage of the sprint

  You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

  This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

  The documents the release regenerates are out of scope. They are
  every file at a target a declared document type names under
  `.ok-planner/surface/documents/` (a folder target covers the folder)
  and everything under `.ok-planner/documentation/`. `/document`
  rewrites them whole at the next release. Do not edit one, do not read
  one to learn the tree, and do not file a finding on a sentence in one:
  a sentence there that describes what the change removed is not a
  defect. Rule files under `.claude/rules/`, infrastructure files, and
  every other prose file stay in scope.

  You build one stage of the sprint at .ok-planner/sprints/2026-10-04-consolidate-into-ok-planner.md. Your brief names
  the work items the stage lands, the corpus deltas it applies, the
  behavior changes it carries by id with their rulings, and where the
  code is. Your task's files are the paths you may edit. Read the
  sprint's intent, its deltas, the work items you land, and their
  implementation notes before you write.

  ### The stage

  - Write the code the notes name. Apply each corpus delta the stage
    carries: copy the final-form body verbatim (from the sidecar where
    the heading points there) into its home, `.ok-planner/design/` for
    a concept, story, or decision and `.ok-planner/subjects/` or
    `.ok-planner/practices/` for a subject or practice, or delete the
    file for a retirement. After a subject or practice delta, run
    `python3 .ok-planner/bin/catalog-toc` to regenerate that
    collection's TOC.
  - Every new or amended story implemented in code carries the
    `@story:` annotation at the site that realizes it.
  - Keep each ruling your brief names. A `preserve` behavior stays
    unchanged for its users across the boundary. A `migrate` behavior
    lands its migration in this stage. A `rewrite` behavior brings
    every user the notes list along.
  - Where your code changes a behavior a user can observe and the
    notes list no such change, record it: `tasks item add --pool
    divergences --key <your key> --field kind=call --body "unlisted
    behavior change: <path::symbol>; before: <...>; after: <...>;
    users: <...>" --task <task>`. Sprint certification judges it.
  - Completeness is the floor. Deliver every outcome the brief
    promises, or close `blocked` naming what stops you. A stub, a
    `TODO`, or a no-op standing in for an outcome is an undelivered
    outcome.
  - Run the project's checks (`.ok-planner/review/config.json` `checks`
    lists them) on every file you changed, in the foreground, and close with no
    process of your own still running. Leave the tree runnable.

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

  Where the sprint is silent, make the most plausible call, continue,
  and record it: `tasks item add --pool divergences --key <your key>
  --field kind=call --body "<the call>" --task <task>`. Where the
  sprint and corpus do not decide and reasonable owners diverge, build
  the reading you judge best and record the fork with its options:
  `--field kind=fork --state fork`. Sprint certification settles every
  fork: one the sprint or corpus decides becomes work or nothing, and
  the rest become questions for the owner.

  A defect you meet outside your files is recorded once and left;
  sprint certification reads it as a report: `tasks item add --pool
  divergences --key <your key> --state noticed --field kind=noticed
  --field file=<path> --body "<the site; the harm>" --task <task>`. A site outside your files that your own
  change must reach (a caller of a definition you changed) is yours:
  stage what you built and close `partial` with a result that starts
  `outside files: <path>: <site>`.

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
