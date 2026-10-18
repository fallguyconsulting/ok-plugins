# Plan-docs core

The blocks `/plan-docs` and the documentation sprint use: the edit rules, the claim definition, the planner's prompt, and the three task prompts. `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a value the session fills before it dispatches or registers the prompt. Tokens from `skills/_shared/dispatch-discipline.md` resolve only where the token stands alone on its line.

---

### {{DOC-EDIT-RULES}}

```
A writer edits a documentation file only where one of these rules
fires, and every edit names its rule:

| Rule | Edit |
|---|---|
| A claim is false against the tree. | Rewrite the claim to match the tree. |
| A public element of a class the docspec's `## Lists` names is missing. | Add an entry for it in the shape. |
| An element the surface intent keeps internal appears. | Remove it. |
| A sprint closed since the docspec's stamp changed what a user can do through the docspec's references, and the text does not say so. | Add or change the text that covers it. |
| A file departs from the docspec's `## Shape`, or from the layout its `## Where` states. | Restructure it. |
| A claim the tree cannot settle, such as one about speed or an outside service. | Cut it. |

Every other sentence stays as written. A file the docspec's layout
calls for and the tree lacks is written whole, in the shape, from the
tree as it stands.
```

---

### {{DOC-CLAIM-DEFINITION}}

```
A claim is a sentence, or a part of an example, that says what the
project does, accepts, returns, prints, or requires. A sentence that
only says why, or tells the reader where to look, makes no claim. A
link makes a claim: that its target exists. A documentation file
makes a finite number of claims, and each holds or does not against
the tree as it stands.

A claim is checked the strongest way that applies:

1. Run it. An example, a command, or a code sample runs, and its
   output must match what the documentation shows.
2. Ask it. A claim about a flag or an option is checked against the
   program, through its `--help` or its argument parser.
3. Read it. Any other claim is checked by reading the code it
   describes, naming the symbol read.

A link is checked by resolving it to a file, a heading in it, or
another document.
```

---

### {{DOC-CALL-RULE}}

```
Where the docspec, its worked example, and the rules above do not
decide a choice, make the most plausible one, go on, and record it,
for the owner's veto in the completion report: `tasks item add --pool
calls --key <slug> --field site=<file> --field choice="<one line>"
--body "<the call and what you weighed>" --task <task>`.
```

---

### {{DOC-PLANNER-PROMPT}}

One dispatch per docspec in the window, all in one message.

```
Agent (general-purpose, model: opus):
  ## Plan one docspec's documentation

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Say which files under one docspec's `## Where` a documentation
  sprint writes, changes, or drops, and which rules fire on each, from
  what changed since the docspec's stamp. The writers edit a file only
  where a rule you name fires, so name every rule that fires and the
  fact that fires it.

  ### Inputs

  Docspec: `.ok-planner/docspec/[SLUG].md`. Read it whole.
  Its window entry, from `.ok-planner/bin/docs window --json`:
  [WINDOW ENTRY]
  Commit: [COMMIT]. Read the tree as it stands.

  Read the files under the docspec's `## Where` as they stand. For each
  reason the entry gives, read what changed since the stamp: `git diff
  <stamp> -- <path>`. Where the docspec has a `## Lists` section, read
  the surface intent at `.ok-planner/surface/surface.md` and each file
  it names as declaring a listed class, whole, and list each class's
  public elements as the intent's rule and exceptions decide. Read
  each sprint the entry names as closed since the stamp: its Intent,
  its Work items, and its Implementation notes, for what the change
  meant to give a user. Read the ledger claims whose sources changed:
  `.ok-planner/bin/docs claims [SLUG] --stale`.

  {{DOC-EDIT-RULES}}

  {{DOC-CLAIM-DEFINITION}}

  ### The plan

  1. Per file under the Where, find each rule that fires and the
     fact that fires it: a stale claim the tree now contradicts, a
     public element the file lacks, an internal one it lists, a
     sprint's change it does not cover, a departure from the shape or
     layout. A file the layout calls for and the tree lacks is a
     `write`; a file the layout no longer calls for is a `drop`; a file
     a rule fires on is a `change`.
  2. A file no rule fires on is a `check` where the stale list names a
     claim in it, or where the window entry names it as changed since
     the stamp, such as by a person's direct edit: a checker checks
     it, and no writer touches it. Any other file is not an item.
  3. For a docspec with no stamp, every file the layout calls for and
     the tree holds is a `change` or a `check` under the steps above,
     and the run checks every claim in it; only a missing file is
     written whole.
  4. Per item, list the ledger claims in that file the stale list
     names, by id, as claims to check again.
  5. Find each unexplained change: a change in the window to what the
     docspec describes that no sprint closed since the stamp made or
     explains. Name its commit, its files, and what it changes for the
     docspec's reader.
  6. Where the docspec's state records no worked example, and the owner
     has not declined one, draft one
     entry, or one section, in the docspec's shape, from the tree, as
     a candidate the owner may approve.
  7. Name what keeps the docspec from being planned well: no `## Shape`,
     a Where the tree does not match, a listed class the surface intent
     does not name, a `## Generator` that does not say whether its
     output is committed. Only `/plan-sprint` changes a docspec.

  ### Output

  Status line first: `Status: <n> items, <u> unexplained changes`.

  Then one line per item, ordered as the layout orders the files:
  `` - `<file>`: write | change | drop | check. Rules: <rule: fact; ...>, or none for a check. Claims to check again: <the claim ids, or none>. ``

  Then `Unexplained:` and one line per unexplained change: `<commit> —
  <files> — <what it changes for the reader>`, or `none`.

  Then `Example draft:` and the draft, with the file its entry belongs
  in, or `none`.

  Then `Reshape:` and one line per gap step 6 found, or `none`.
```

---

### {{DOC-WRITE-PROMPT}}

The task prompt for a writer, and for a fixer of false claims. `[DOC SPRINT PATH]` is the documentation sprint.

```
Task prompt (profile ok-opus):
  ## Write one file of a documentation sprint

  {{LEAF-AGENT-RULE}}

  You write one file of the documentation sprint at [DOC SPRINT PATH]:
  the file your task's files name, under the docspec your brief names.
  Your brief says whether you write it new, change it, or drop it; the
  rules that fire on it and the facts that fire them; the claims to
  check again; and the worked example. A brief that starts `fix:`
  names false claims a checker recorded; fix those and nothing else.
  A brief that starts `generate:` runs the docspec's `## Generator`
  command in the project and stages the output it writes, the files
  your task's files name; it edits nothing else.

  ### Read

  1. The docspec at `.ok-planner/docspec/<slug>.md`, whole. Its
     `## Where` says where the file sits and how the folder is laid
     out. Its `## Reader`, `## Covers`, `## Shape`, and `## Notes` say
     what the file holds and for whom.
  2. The worked example your brief names, `git show <sha>:<path>`, or
     the draft under the docspec's heading in the documentation sprint.
     Model the file's order and voice on it.
  3. The writing standard, `.ok-planner/docs/technical-writing.md`.
  4. The file as it stands, and the code, corpus artifacts, and
     sprints your brief's facts name. For a docspec with `## Lists`,
     the surface intent at `.ok-planner/surface/surface.md` and each
     file it names as declaring a listed class, whole.
  5. On a fix brief: each claim it names, `tasks item list --pool
     claims --key <slug> --json`, with the checker's `found` field.

  ### Edit only where a rule fires

  {{DOC-EDIT-RULES}}

  {{DOC-CLAIM-DEFINITION}}

  Write every claim so a checker can settle it from the tree. Where the
  docspec's Where starts `in code:`, edit only the doc comments on
  declarations in the file, in the comment form its `## Generator`
  reads, and change no code. A doc comment on an internal element
  goes.

  On a fix brief, per false claim: rewrite the sentence so it states
  what the tree does, as the checker's `found` says, then `tasks item
  set <id> --state open --field rewrite="<the new sentence>"`. Where
  the tree cannot settle the claim, or nothing true belongs in its
  place, cut it, then `tasks item set <id> --state cut --field
  reason="<why>"`. A false claim that an element is missing is fixed
  by adding its entry in the shape, with `rewrite` naming the entry and
  `--field added=true`, so the checker checks every claim the entry
  makes.

  ### Record

  Per edit: `tasks item add --pool edits --key <slug> --state recorded
  --field file=<file> --field rule="<the rule>" --body "<the edit, in
  one line>" --task <task>`.

  {{DOC-CALL-RULE}}

  ### Close

  Stage the file by name: `git add <file>`, or `git rm <file>` for a
  drop. Never run `git checkout`/`restore`/`reset`/`stash`/`clean`.
  Close: `tasks close <task> --outcome done --result "<file>: <n>
  edits; <the rules>" --staged <file>`. A file you could not finish
  closes `partial` with where you stopped.
```

---

### {{DOC-STYLE-PROMPT}}

The task prompt for the style pass. `[DOC SPRINT PATH]` is the documentation sprint.

```
Task prompt (profile ok-opus):
  ## Style pass on one documentation file

  {{LEAF-AGENT-RULE}}

  You read one file of the documentation sprint at [DOC SPRINT PATH]
  once, cold, as its reader will, and revise it once. You did not
  write it. Nobody sends a style finding back.

  ### Read

  1. The docspec at `.ok-planner/docspec/<slug>.md`, whole.
  2. The worked example your brief names, `git show <sha>:<path>`, or
     the draft under the docspec's heading in the documentation sprint.
  3. The writing standard, `.ok-planner/docs/technical-writing.md`.
  4. What changed in the file since the docspec's stamp: `git diff
     <stamp> -- <file>`. For a docspec with no stamp, or a file new
     since it, the whole file changed.

  ### Decide

  Where the change only rewrites a few claims in place, and leaves
  each section's order and point as they stood, the file needs no
  review: record `skipped` with the reason, and close. Otherwise
  review it.

  ### Review

  Read the whole file, then revise it against the docspec's `## Shape`
  and layout, the worked example, and the writing standard:

  - Each section opens with its point.
  - Each term is defined where it first appears.
  - Each fact appears once, in the section that owns it.
  - The parts follow the shape's order.
  - A revision never makes a section longer than the facts it holds.

  Change what the file says about the project nowhere: keep every
  claim's meaning, add no claim, and cut none. Where the docspec's
  Where starts `in code:`, revise only doc comments.

  ### Record and close

  {{DOC-CALL-RULE}}

  `tasks item add --pool style --key <slug> --state recorded --field
  file=<file> --field verdict=<reviewed | skipped> --body "<what you
  changed, or why you skipped>" --task <task>`. Stage the file by name
  where you changed it. Close: `tasks close <task> --outcome done
  --result "<file>: <reviewed | skipped>" --staged <file>`, `--staged`
  omitted where you changed nothing.
```

---

### {{DOC-CHECK-PROMPT}}

The task prompt for a checker in the fact loop. `[DOC SPRINT PATH]` is the documentation sprint.

```
Task prompt (profile ok-opus):
  ## Check the claims of documentation files

  {{LEAF-AGENT-RULE}}

  You check claims in the documentation the sprint at [DOC SPRINT
  PATH] writes. You wrote none of them, and you edit no file in the
  project. Your brief names the docspec and, per file, which claims to
  check: every claim in a file the run changed, in a file changed
  since the stamp, or in any file of a docspec with no stamp; the
  ledger claims to check again in another file, by id (`.ok-planner/
  bin/docs claims <slug> --stale` prints each with its text); or, on a
  recheck, the claims by id that a fixer set `open`, each with its
  `rewrite` field.

  {{DOC-CLAIM-DEFINITION}}

  ### Check

  Read the docspec at `.ok-planner/docspec/<slug>.md` and each file
  whole. Check each claim the strongest way that applies. Run an
  example in a folder `mktemp -d` makes outside the project, or, where
  it needs the running product, on a stack run the project's stack
  tool opens, as `.ok-planner/review/project.md` says, taking the run
  down after. Run nothing that writes into the project's tree. Where
  your brief says to list the docspec's classes, list every public
  element of each class its `## Lists` names from the files the
  surface intent names as declaring it: each public element the
  documentation omits is a false claim, `missing: <element>`, in the
  file the layout gives it, and each listed element the intent keeps
  internal is false. Where your brief says to run the docspec's
  `## Generator` command, run it in the foreground with its output in
  a folder `mktemp -d` makes, through the output option the tool
  takes, or in a copy of the project made in that folder where it
  takes none. Record its run as a claim with `--field generator=true`:
  `held` where it succeeds, and `false` where it fails, with the
  output's tail as `found` and, as `file`, the source file the failure
  names, or the first path the docspec's `in code:` line names.

  A claim the tree cannot settle, such as one about speed or an
  outside service, is false, with `found` saying the tree cannot
  settle it.

  ### Record

  Per claim: `tasks item add --pool claims --key <slug> --state <held
  | false> --field file=<file> --field check=<run | ask | read | link>
  --field 'sources=["<each file the claim rests on>"]' --field
  scope=<file | stale> --field found="<for a false claim: what the
  tree shows>" --body "<the claim, quoted from the file>" --task
  <task>`. `sources` names the code you read, the program you ran or
  asked, or the link's target: the next run checks the claim again
  only once one of them changes. `scope` is `file` where you checked
  every claim in the file, `stale` otherwise. A ledger claim you check
  again adds `--field ledger=<its id>`. On a recheck, record the
  rewrite as a new claim with the old claim's scope, then `tasks item
  set <id> --state replaced` on the old one. Where the old claim
  carries `added=true`, the rewrite added text: check every claim the
  added text makes, and record each one.

  {{DOC-CALL-RULE}}

  ### Close

  Close any stack run you opened. `tasks close <task> --outcome done
  --result "<n> claims: <h> held, <f> false"`.
```
