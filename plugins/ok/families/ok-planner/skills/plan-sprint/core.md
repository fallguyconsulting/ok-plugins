# Plan-sprint core

The blocks `/plan-sprint` uses: two formats and four subagent prompts. `{{TOKEN}}` names a block to use verbatim; `[...]` inside a block is a value the session fills before it dispatches. Tokens from `skills/_shared/dispatch-discipline.md` and `.claude/skills/_sprint/shared.md` resolve only where the token stands alone on its line.

---

### {{RELEASE-BOUNDARIES-FILE}}

The format of `.ok-planner/release-boundaries.md`. The file is the project's; the session writes it from the owner's answer, and the owner edits it between sprints. The stored-state boundary in `{{RELEASE-BOUNDARIES}}` applies without being written here.

```markdown
# Release boundaries

## <boundary name>

- **Across it:** <who uses the project's behavior from the far side,
  and when they update>.
- **What crosses it:** <the kinds of behavior those users depend on:
  routes, message topics and payloads, file layouts, configuration
  fields, command flags, library functions, stored data>.
- **Where to look:** <the paths or markers in the tree that define
  those behaviors, so a code planner can find them>.
```

---

### {{IMPLEMENTATION-NOTES-FORM}}

The body of the sprint's `## Implementation notes` section. The executing session cuts stages from it, and sprint certification checks the finished work against it.

```markdown
Planned against commit `<sha>`.

### <work item title>

Reading: <present only where the owner kept a kicked-back work item as
drafted: the reading the owner stated>

**Calls**
- <the call>. Decided by: <the rule, artifact, or ruling>.

**Changes**
- `<path>::<symbol>`: new | changed | removed. <What it does afterward.>

**Improvements**
- **I<n>** `<path>::<symbol>`: <the accept-list entry it removes, or
  the maintenance cost it ends>. Afterward: <what the code does>.

**Behavior changes**
- **B<n>** `<path>::<symbol>`. Before: <what a user observes now>.
  After: <what a user observes then>.
  Users: in the release: <`path::symbol`, ...>. Across <boundary>:
  <who>.
  Ruling: <one ruling>.
```

A work item with no behavior changes says under that heading: `None. Every change is new code no existing user reaches.` A work item with no improvements omits that heading, and one with no calls omits **Calls**. An improvement's own behavior changes are listed under Behavior changes like any other.

B-ids and I-ids are unique across the sprint and never reused: a re-run of code planning for a work item numbers its new entries after the highest id the sprint holds.

---

### {{OUT-OF-BAND-REVIEWER-PROMPT}}

One dispatch at Reconcile, over the window since the last closed sprint.

```
Agent (general-purpose, model: opus):
  ## Out-of-band change review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Decide which changes in a git window bear on the design corpus's
  commitments. The owner judges the changes and resolves them; you
  decide, per change, whether the corpus and the code still tell the
  same story.

  ### Inputs

  Window: [<closed-sha>..HEAD, plus the uncommitted tree]
  Enumerate it yourself: `git log --oneline <window>`,
  `git diff <closed-sha>`, and `git status --short` for anything
  uncommitted. Read changed files in full where the diff alone is
  ambiguous.

  The design corpus at `.ok-planner/design/` is the comparison
  pole: read the three catalog TOCs first, then the full body of
  every artifact a change plausibly touches.

  ### The test

  A change (or a coherent group — group by mechanism, not by
  commit) is BEARING if any of these hold:

  - It contradicts something a live artifact commits to — a
    boundary, a Choice, a promised outcome.
  - It retires, replaces, or bypasses a mechanism a live artifact
    names as how a commitment is delivered.
  - It adds capability or structure significant enough that the
    corpus is silent about something load-bearing.
  - It edits a file under `.ok-planner/design/` directly — a
    corpus mutation outside any sprint is always BEARING.

  A change is AMBIENT if every live artifact reads the same with
  or without it. When you cannot tell, answer BEARING.

  ### Output format

  Status line first: `Status: N bearing | ambient remainder`.

  Then one entry per bearing group: the commits/files involved,
  one sentence on what changed, and the artifact slugs it bears
  on with one sentence each on the collision.

  Report only the window against the corpus: list no ambient
  change, and grade, rank, or resolve nothing.
```

---

### {{RELEVANCE-PASS-PROMPT}}

One dispatch at Resolve on a feature-work sprint.

```
Agent (general-purpose, model: sonnet):
  ## Issue relevance pass

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Decide which open design issues bear on a drafted sprint's work.
  The owner resolves them; you decide, per issue, whether the owner
  must resolve it BEFORE this work is built.

  ### Inputs

  Draft sprint: [path]
  Unruled open issues (files under `.ok-planner/issues/` with
  status open or verified, a category other than `defect`, and an
  empty Ruling section):
  [one line per issue: the file path, then its frontmatter slug
  and the title line]

  Read each listed issue file in full — the Problem, Candidates,
  and any Discussion are your evidence for bearing.

  The design corpus at `.ok-planner/design/` is source of truth —
  read it freely. Read the code where an issue's bearing depends
  on what the code does.

  ### The test

  An issue BEARS on this sprint if any of these hold:

  - It concerns an artifact the sprint creates, amends, or
    retires.
  - Building a work item would encode an answer to the open
    question by default — the implementer would have to pick, and
    the pick would stand as the project's answer. (The central
    case.)
  - A plausible resolution of the issue would contradict,
    invalidate, or materially reshape a drafted delta or work
    item.
  - It concerns a neighbor artifact whose boundary a work item
    leans on — the work is only correct if the boundary falls one
    way.

  An issue is INDEPENDENT if the drafted work can be built and
  certified without answering it, AND answering it later cannot
  invalidate anything the sprint commits to.

  When you cannot tell, answer BEARS. A needless owner
  conversation costs a minute; a silently decided design question
  costs a rewrite.

  ### Output format

  Status line first: `Status: N bearing | M independent`.

  Then one line per issue in the list you were given, bearing ones
  first:

  `<id> — BEARS | INDEPENDENT — <one sentence: which delta or work
  item it touches, or why the work is indifferent to it>`

  Report bearing only: grade, rank, and resolve nothing, and leave
  the sprint's quality to the sign-off review.
```

---

### {{CODE-PLANNER-PROMPT}}

One per group of up to ten work items, dispatched together.

```
Agent (general-purpose, model: opus):
  ## Plan the code for a sprint's work items

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  For each work item you are given, say what must change in the code
  to realize its outcome, list every existing behavior those changes
  alter with its users, and propose the improvements the sprint could
  make in the code it changes anyway. The executing session cuts
  stages from your notes against the tree as it stands then, so name
  what changes and what it does afterward.

  ### Inputs

  Sprint: [SPRINT PATH]. Read the intent, every delta (from the
  sidecar where a heading points there), and every work item.
  Your work items: [WORK ITEMS].
  Commit: [COMMIT]. Read the code at this commit, and the working tree
  where it differs.
  Start B-ids at B[NEXT B] and I-ids at I[NEXT I].
  The accept list: `.ok-planner/review/catalog/accept.md`, whole,
  including what it leaves standing.
  The project's facts: `.ok-planner/review/project.md`.
  The design corpus under `.ok-planner/design/` is the source of
  truth. Read the artifacts your work items and the deltas name.

  {{RELEASE-BOUNDARIES}}

  {{BEHAVIOR-CHANGE-DEFINITION}}

  {{BEHAVIOR-RULINGS}}

  {{OWNER-QUESTION-TEST}}

  ### Per work item

  1. Find the code the outcome runs through: its entry points and the
     definitions they reach. Use the LSP tool for definitions and
     references where it is available, and `rg` for text that is not
     a symbol.
  2. List the changes: each definition, file, configuration key,
     schema, or stored layout the outcome needs added, changed, or
     removed, and what each does afterward.
  3. List the behavior changes: for each changed or removed thing that
     exists at the commit, what a user observes before and after.
  4. Find the users of each behavior change, including users across
     each boundary (read the boundary's Where to look).
  5. Rule where the boundaries decide. Every user ships in the same
     release: rule `rewrite`, and add each user that must change to
     Changes. A user across a boundary: rule `preserve` or `migrate:
     <how>` marked `(call)` where the rules, the corpus, or the
     sprint's owner rulings determine it, and add the migration's
     code to Changes; write `Ruling: owner (<boundary>)` only where
     the test above holds.
  6. Make every other determined choice yourself and list it under
     **Calls** with what decides it: a field name, an error path, a
     retry, what an unlisted surface shows.
  7. Propose improvements, within the definitions step 2 lists as
     changed and nothing wider. Two kinds qualify: a harm an
     accept-list entry names that the definition can cause today, and
     a shape that makes a named maintenance operation double or wrong
     there (one mechanism built twice, a responsibility in a module
     that does not own its state). For each, name the site, the entry
     or the cost, and what the code does afterward, and list its
     behavior changes as in steps 3 to 5.
  8. Kick the work item back where it cannot be built as drafted: the
     code contradicts a delta or the work item, a prerequisite does
     not exist and no work item builds it, or two work items need
     conflicting changes to one definition.

  ### Output

  Status line first: `Status: <work items> work items, <n> behavior
  changes, <o> for the owner, <p> improvements proposed, <k>
  kickbacks`.

  Then one section per work item, with every proposed improvement
  under **Improvements** and a ruling on each behavior change:

    ### <work item title>

    **Calls**
    - <the call>. Decided by: <the rule, artifact, or ruling>.

    **Changes**
    - `<path>::<symbol>`: new | changed | removed. <What it does
      afterward.>

    **Improvements**
    - **I<n>** `<path>::<symbol>`: <the accept-list entry, or the
      maintenance cost>. Afterward: <what the code does>.

    **Behavior changes**
    - **B<n>** `<path>::<symbol>`. Before: <...>. After: <...>.
      Users: in the release: <...>. Across <boundary>: <who>.
      Ruling: rewrite | preserve (call) | migrate: <how> (call) |
      owner (<boundary>).

  A work item with no behavior changes says under that heading:
  `None. Every change is new code no existing user reaches.`

  Then the kickbacks, one per line: `<work item> — <the code fact, as
  path::symbol> — <the delta or work item it contradicts>`.

  ### Scope

  Report what the work items need and the improvements step 7 allows.
  A defect in a definition the sprint does not change belongs to
  `/converge`'s next run.
```

---

### {{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}

One dispatch per review, scoped on a re-dispatch to the work items whose notes changed.

```
Agent (general-purpose, model: opus):
  ## Implementation notes review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Check the sprint's implementation notes against the sprint and the
  code. The compliance review already settled the deltas; judge the
  notes.

  ### Inputs

  Sprint: [SPRINT PATH]. Read the intent, the deltas, the work items,
  and the `## Implementation notes` section. Scope: [SCOPE].
  Commit: [COMMIT]. Read the code at this commit, and the working tree
  where it differs.
  Settled by the owner, and not raised again: [SETTLED].
  The accept list: `.ok-planner/review/catalog/accept.md`.

  {{RELEASE-BOUNDARIES}}

  {{BEHAVIOR-CHANGE-DEFINITION}}

  {{BEHAVIOR-RULINGS}}

  {{OWNER-QUESTION-TEST}}

  ### The checks

  One pass. Look for two things only:

  1. An unexpected behavior change: a change a user can observe that
     the notes do not list, or list with the wrong users, where the
     change is an unintended consequence of a delta, a work item, or a
     taken improvement.
  2. A compatibility break the notes miss: a change that an older or
     newer part within the same major version, or stored data, could
     not work with, and whose ruling does not keep it working.

  Everything else you notice (a wrong symbol, a missing change, a
  detail the build must settle) goes under Build notes: one line each,
  for the builders to handle as calls. Chase it no further.

  ### Output

  Status line first: `Status: clean` or `Status: <n> findings`.

  Then one line per finding: `<mechanical | judgment> — <work item,
  and the id or change> — <what is wrong, with the code fact>`.

  Then `Build notes:` and one line per item for the builders.

  A finding is judgment only when it meets the owner question test
  above. Every other finding is mechanical, including a missed
  behavior change or user whose ruling the rules determine: state the
  fix, and for a choice the rules leave open, state the most
  plausible call and what decides it.
```
