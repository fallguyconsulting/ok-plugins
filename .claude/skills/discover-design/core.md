# Discover-design machinery

The blocks `/discover-design` transcludes: what a finding is, and the task prompts of its five roles. A `{{TOKEN}}` names the block of that name here, in `../_shared/artifact-definitions.md`, or in `../_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[DISCOVERY PATH]` is the discovery the session is writing, `.ok-planner/discoveries/<name>.md`, `[DELTAS PATH]` its deltas folder, `.ok-planner/discoveries/<name>-deltas`, and `[RUN PATH]` its run, `.ok-planner/discoveries/<name>-run.jsonl`.

---

### {{DISCOVER-FINDING-FORMS}}

```
The audit reads the code and the corpus, and never assumes which side
is wrong. A corpus is out of date in three ways: an artifact breaks a
rule it was not written under, the code holds something no artifact
records, or an artifact says one thing and the code does another.
Every finding takes one of three forms:

- A form-only delta. The fix changes no commitment: a reader of the
  old body and the new one would expect the same of the product.
  Stripping a `## History` section, removing a file path from a body,
  and rewording a sentence that breaks a rule without changing what
  it says are form-only.
- A promise-change delta the code settles. The fix changes what the
  corpus commits to, and the code decides how. A new artifact for
  something the code holds and no artifact records, a retirement, a
  story split into several, and a concept's rule moved into a new
  decision are promise changes. A concept that fails the existence
  test is one too: read the code for the narrowing its body lacks.
  Where the code narrows the noun, the delta adds the narrowing.
  Where it does not, the delta retires the concept.
- A question. The code and the corpus disagree, and only the owner
  can say which is right. A question names the artifact, quotes what
  it says, says what the code does with the files that show it, and
  drafts both answers: the corpus is stale, and its answer is a delta;
  or the code is wrong, and its answer is a work item a sprint builds.
  Where no artifact records the thing yet, the question names the
  artifact the audit proposes for it and quotes the text at issue
  instead: the prose the code disagrees with, such as a README's
  sentence, or the drafted sentence the code does not settle. Both
  answers draft the artifact's body: the stale answer is the `new`
  delta of that artifact, its body as the code has it, and the wrong
  answer's work item comes with the artifact's body as the text at
  issue has it once the code matches.

The audit decides no question, files no issue, and edits no file
outside the deltas folder.
```

---

### {{DISCOVER-CALL-RULE}}

```
Where the rules above and your brief do not decide a choice, make the
most plausible one, go on, and record it for the owner's veto: `tasks
item add --pool calls --key <kind:slug or area> --field site=<kind:slug
or area> --field choice="<one line>" --body "<the call and what you
weighed>" --task <task>`.
```

---

### {{DISCOVER-SURVEY-PROMPT}}

The task prompt for a survey agent, one task per area.

```
Task prompt (profile ok-opus):
  ## Survey one area for the corpus audit

  {{LEAF-AGENT-RULE}}

  You survey the files of the area your brief names, for the discovery
  at [DISCOVERY PATH]. You write no file. You record each candidate as
  an item, and later merge tasks fold them into the corpus.

  {{DISCOVER-FINDING-FORMS}}

  ### Read

  1. The area's files, which your brief lists after its name and
     shape. Read each file whole. A flow area names one file that
     declares a class of public entry point, such as a command table
     or a route table: read it, then follow each entry point it
     declares along the path it takes.
  2. The catalogs, `.ok-planner/design/concepts.md`, `stories.md`, and
     `decisions.md`, where they exist, so you name a candidate by the
     slug an artifact already uses.

  Read no test file, no file under `.ok-planner/sprints/`,
  `.ok-planner/history/`, or `.ok-planner/discoveries/`, and no file
  outside your area but one an import or a call in it leads to.

  ### What a candidate is

  {{CONCEPT-DEFINITION}}

  {{STORY-DEFINITION}}

  {{DECISION-DEFINITION}}

  Record three kinds of candidate, each in its own pool:

  - `nouns`: a noun the code or the prose narrows, so a reader who
    took the word in its plain sense would misread the code. Say
    what the narrowing is.
  - `outcomes`: something a user of the product gets, as far as the
    area shows it, stated as `As <role>, I want a way to <capability>,
    so that <benefit>`. Prose that says what the product does for its
    users counts.
  - `choices`: a technical choice the area makes where a plausible
    alternative exists. Say the choice, the alternative, and the
    tradeoff as the code or the prose shows it.

  Record what the area shows, not what it should show. Where prose and
  code in your area disagree, record the candidate once and say both
  in its body. Record nothing for a helper, a constant, or a name with
  its plain meaning.

  ### Record

  Per candidate: `tasks item add --pool <nouns | outcomes | choices>
  --key <the area's name> --field slug=<the slug an existing artifact
  uses, or a proposed one> --field 'files=["<path>", ...]' --body
  "<one paragraph: what it is, and what in the files shows it>" --task
  <task>`.

  {{DISCOVER-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<area>: <n> nouns, <o>
  outcomes, <c> choices"`.
```

---

### {{DISCOVER-CHECK-PROMPT}}

The task prompt for a check agent, one task per batch of existing artifacts.

```
Task prompt (profile ok-opus):
  ## Check a batch of corpus artifacts against the rules and the code

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You check the artifacts your brief lists, for the discovery at
  [DISCOVERY PATH]. Each line of the brief names one artifact by its
  item: its fields give its kind, slug, path, and scope. You write no
  file. You record each finding as an item, and later merge tasks
  draft the deltas and questions.

  {{DISCOVER-FINDING-FORMS}}

  ### The rules

  {{CONCEPT-DEFINITION}}

  {{CONCEPT-TEMPLATE}}

  {{STORY-DEFINITION}}

  {{STORY-TEMPLATE}}

  {{DECISION-DEFINITION}}

  {{DECISION-TEMPLATE}}

  {{DECIDABILITY-BOUNDARY}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  A subject or a practice follows `.ok-planner/practice-definitions.md`:
  read it once where your batch holds one. A docspec and the surface
  intent follow these:

  {{DOCSPEC-DEFINITION}}

  {{SURFACE-INTENT-DEFINITION}}

  ### Check each artifact

  1. Read it whole, and check it against its rules: the tests, the
     template's sections and no others, self-containment, and
     current state only. Each break is a finding.
  2. For scope `full`, a concept, story, or decision, read the code
     that realizes it. Find it by its annotations, `rg -n --hidden
     '@<kind>: <slug>\b'`, and by the survey's candidates of the same
     slug: `.ok-planner/bin/discover items --run [RUN PATH] --pool
     <nouns | outcomes | choices> --slug <slug> [<other slugs it may go
     by>]`. Each sentence the code
     contradicts is a finding. A concept that fails the existence
     test is a finding: say whether the code narrows the noun, and
     how.
  3. For scope `rules`, a subject, practice, docspec, or the surface
     intent, check the rules alone. These are policies the owner
     declares: the code shows no gap in them, and the audit drafts no
     new one. A break the rules decide the fix of is a form-only
     finding; any other break is a question.

  Read no test file, and no file under `.ok-planner/sprints/` or
  `.ok-planner/history/`.

  ### Record

  Per finding: `tasks item add --pool findings --key <kind:slug>
  --field artifact=<kind:slug> --field form=<form | promise |
  question> --field 'files=["<path>", ...]' --body "<what breaks which
  rule, or what the artifact says and what the code does instead,
  quoted>" --task <task>`. The form is your reading; the merge drafts
  the delta.

  Per artifact, whether or not it has findings: `tasks item add --pool
  checked --key <kind:slug> --field findings=<n> --body "<kind:slug>"
  --task <task>`.

  {{DISCOVER-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> artifacts; <f>
  findings: <the count per form>"`.
```

---

### {{DISCOVER-SORT-PROMPT}}

The task prompt for a sort agent, one task per kind: `concept`, `story`, `decision`, and `standards`, which covers subjects, practices, docspecs, and the surface intent. A kind's sort runs after every merge of the kinds before it.

```
Task prompt (profile ok-opus):
  ## Sort one kind's candidates into groups

  {{LEAF-AGENT-RULE}}

  You sort the candidates and findings of one kind into groups, for
  the discovery at [DISCOVERY PATH]. Your brief names the kind. A
  group is one artifact: a live one, or one a candidate proposes. The
  session then files one merge task per few groups, and each merge
  drafts only its own groups. You write no file, and you draft
  nothing: you read each item's slug and the first sentence of its
  body, and decide which artifact it belongs to.

  ### What an artifact of each kind is

  {{CONCEPT-DEFINITION}}

  {{STORY-DEFINITION}}

  {{DECISION-DEFINITION}}

  ### Read

  1. Your candidates, each one no sort has grouped yet:
     `.ok-planner/bin/discover items --run [RUN PATH] --pool <pool>
     --ungrouped`, the pool `nouns` for `concept`, `outcomes` for
     `story`, `choices` for `decision`, and none for `standards`.
  2. Your findings: `.ok-planner/bin/discover items --run [RUN PATH]
     --pool findings`, the items whose `artifact` is of your kind, or
     for `standards` of kind subject, practice, docspec, or surface.
  3. The groups that stand: `.ok-planner/bin/discover items --run
     [RUN PATH] --pool groups`.
  4. The live artifacts' slugs and one-line summaries: the catalogs
     `.ok-planner/design/concepts.md`, `stories.md`, and
     `decisions.md`, and for `standards` the file names under
     `.ok-planner/subjects/`, `.ok-planner/practices/`, and
     `.ok-planner/docspec/`, and `.ok-planner/surface/surface.md`.

  Read no code. Where a slug and a first sentence do not tell you
  which artifact an item belongs to, read the item's whole body.

  ### Sort

  - Candidates that name one thing share one group, even where their
    slugs differ. Survey agents saw only their own areas, so one noun
    often arrives under several slugs: folding them is your job.
  - A candidate that names a live artifact joins that artifact's
    group, named by the live slug.
  - A candidate that names nothing live joins a group under a
    proposed slug: the clearest of its candidates' slugs.
  - A candidate the definitions plainly refuse still gets a group:
    its merge drops it, with the reason.
  - A finding's group is its artifact.

  ### Record

  Per group not yet standing: `tasks item add --pool groups --key
  <kind>:<slug> --field merge=<concept | story | decision | standards>
  --field members=<n> --body "<kind>:<slug>: <one line saying what it
  is>" --task <task>`. Never add a group whose key stands; add your
  items to it.

  Per candidate: `tasks item set <item> --field group=<kind>:<slug>`.

  Per finding, no write: its `artifact` names its group, and the group
  must stand.

  {{DISCOVER-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<kind>: <g> groups
  (<n> new); <c> candidates and <f> findings sorted"`.
```

---

### {{DISCOVER-MERGE-PROMPT}}

The task prompt for a merge agent, one task per batch of groups of one kind. A kind's merges run together, after its sort.

```
Task prompt (profile ok-opus):
  ## Merge the audit's candidates and findings for one kind

  {{LEAF-AGENT-RULE}}

  You draft the deltas and questions of the groups your brief lists,
  for the discovery at [DISCOVERY PATH]. Each line of the brief names
  one group item: its key is the artifact, `<kind>:<slug>`, and its
  `merge` field the kind of merge. Other merges draft the other groups
  beside you. You write files only under [DELTAS PATH]/, and you
  record each delta and question as an item. A script assembles the
  discovery from your items.

  {{DISCOVER-FINDING-FORMS}}

  ### The rules

  {{CONCEPT-DEFINITION}}

  {{CONCEPT-TEMPLATE}}

  {{STORY-DEFINITION}}

  {{STORY-TEMPLATE}}

  {{DECISION-DEFINITION}}

  {{DECISION-TEMPLATE}}

  {{DECIDABILITY-BOUNDARY}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  For `standards`, read `.ok-planner/practice-definitions.md` once;
  these hold the docspec and the surface intent:

  {{DOCSPEC-DEFINITION}}

  {{SURFACE-INTENT-DEFINITION}}

  ### Read

  1. Your candidates: `.ok-planner/bin/discover items --run [RUN
     PATH] --pool <nouns | outcomes | choices> --group <your groups'
     keys>`.
  2. Your findings: `.ok-planner/bin/discover items --run [RUN PATH]
     --pool findings --artifact <your groups' keys>`.
  3. Each live artifact your groups name, whole, and the catalogs of
     the other live artifacts of your kind, so you know your
     neighbors.
  4. The code each candidate and finding names, where you need it to
     decide.

  ### Merge

  1. Each group is one artifact. Fold its candidates into one. Where
     a group's candidates name two things, draft each as its own
     artifact, and record a call.
  2. A group that names a live artifact matches its candidates to it.
     A group under a proposed slug is a gap: where the definitions
     admit it, it becomes a `new` delta, marked promise. Where its
     candidates say the prose and the code disagree, and the code does
     not settle which is right, it becomes a question on the proposed
     artifact instead, per step 6. A candidate
     the definitions refuse, such as a noun with its plain meaning or
     a choice with no alternative, is dropped, with the reason. For
     `standards`, draft no new artifact.
  3. Settle each finding into a delta or a question, per the three
     forms above. Read the code where a finding's form turns on it.
     A finding on one artifact joins the others on it: one delta per
     artifact, carrying every change it needs.
  4. Draft each body whole. A `new` or `amend` delta's body is the
     complete final file, per its template, at
     `[DELTAS PATH]/<kind folder>/<slug>.md`: `concepts`, `stories`,
     `decisions`, `subjects`, `practices`, or `docspecs`, and the
     surface intent at `[DELTAS PATH]/surface/surface.md`. An
     amendment starts from the live file and changes only what the
     findings name. A retirement has no body.
  5. Mark each delta `form` or `promise`. A `new` and a `retire` are
     promise changes. For `standards`, draft only form-only
     amendments; a break the rules do not decide is a question.
  6. Ask at most one question per artifact. Where an artifact holds
     two disagreements, fold them into one question whose answers
     settle both. Draft both answers. The stale answer is a delta,
     always drafted: name its operation and target, and where it
     needs a body, write the whole artifact as it would read at
     `[DELTAS PATH]/answers/<question>/<kind folder>/<slug>.md`. The
     wrong answer is one work item, stated so a sprint can build it.
     The artifact's other changes, which hold whichever way the owner
     answers, stand as its ordinary delta; the stale answer's body
     carries them too, since it takes that delta's place. For an
     artifact the audit proposes, the stale answer is `new` on that
     artifact, its body the artifact as the code has it. The wrong
     answer is the work item that makes the code match the text at
     issue, plus the artifact's whole body as the text at issue has
     it once the code matches, written per its template at
     `[DELTAS PATH]/answers/<question>/wrong/<kind folder>/<slug>.md`,
     its frontmatter naming the artifact. No ordinary delta stands
     beside the question.
  7. Where a retirement or a rename leaves code that cites the old
     slug, `rg -n --hidden '@<kind>: <slug>\b'`, name the work item
     that repoints each citation.
  8. Record deltas and questions only under your groups' keys, or
     under a new key of your kind that no group names, as when a
     story splits in two. Where your work shows something of a later
     kind, such as a concept's rule that is a choice with an
     alternative, or a story's prescribed surface, record it as a
     candidate of that kind for its sort: `tasks item add --pool
     <outcomes | choices> --key <your group> --field slug=<a proposed
     slug> --field 'files=["<path>", ...]' --body "<one paragraph>"
     --task <task>`. The kinds run concept, story, decision,
     standards. Where it shows something of an earlier kind, record a
     call.

  ### Record

  Per delta: `tasks item add --pool deltas --key <kind>:<slug> --field
  op=<new | amend | retire> --field mark=<form | promise> --field
  why="<one line: what changes, and for a promise change, what in the
  code settles it>" [--field work="<the work item, where code must
  change>"] --body "<the change, in a few sentences>" --task <task>`.
  The surface intent's key is `surface:surface`.

  Per question: `tasks item add --pool questions --key <a slug for the
  question> --field artifact=<kind:slug> --field says="<the artifact's
  sentence, or for an artifact the audit proposes the text at issue,
  quoted>" --field code="<what the code does, with the
  files>" --field stale="<the answer if the corpus is stale>" --field
  stale_op=<new | amend | retire> --field stale_target=<kind:slug>
  --field wrong="<the work item if the code is wrong>" --body "<the
  question, in one or two sentences>" --task <task>`.

  Per candidate and finding you read: `tasks item set <item> --state
  <drafted | matched | dropped> --note "<the delta or question it went
  into, the artifact it matched, or why it was dropped>"`. `matched`
  means a live artifact already says it and needs no change.

  A refiled merge records only what it changes. An item you record
  under a key replaces the one your merge, or the merge it refiles,
  recorded before under that key. To drop a delta or question, set the
  latest such item `withdrawn` with `tasks item set <item> --state
  withdrawn`, and remove its body unless another merge's delta under
  the same key stands.

  {{DISCOVER-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<g> groups: <d> deltas
  (<f> form-only, <p> promise), <q> questions; <n> candidates and
  findings settled"`.
```

---

### {{DISCOVER-REVIEW-PROMPT}}

The task prompt for the review of a discovery's drafts, one task per cycle.

```
Task prompt (profile ok-opus):
  ## Review a discovery's drafts

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the deltas and questions one merge task recorded, for the
  discovery at [DISCOVERY PATH], before it is assembled. Your brief
  names the merge task and its groups. Read `.ok-planner/bin/discover
  items --run [RUN PATH] --pool deltas` and `--pool questions`, the
  items that task recorded, each body under [DELTAS PATH]/ they name
  or either answer of a question names, each live artifact a delta amends or a question names, and the
  candidates and findings of its groups, through `discover items` with
  `--group` and `--artifact`.

  {{DISCOVER-FINDING-FORMS}}

  ### The rules

  {{CONCEPT-DEFINITION}}

  {{CONCEPT-TEMPLATE}}

  {{STORY-DEFINITION}}

  {{STORY-TEMPLATE}}

  {{DECISION-DEFINITION}}

  {{DECISION-TEMPLATE}}

  {{DECIDABILITY-BOUNDARY}}

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  Where the merge drafted a subject or practice, read
  `.ok-planner/practice-definitions.md` once. These hold the docspec
  and the surface intent:

  {{DOCSPEC-DEFINITION}}

  {{SURFACE-INTENT-DEFINITION}}

  ### Check

  - Every body meets its definition and template: a concept passes
    the existence and invariance tests, a story the need, one-need,
    and invariance tests, a decision names a real alternative.
  - Every delta marked `form` changes no commitment. One that changes
    what a reader would expect of the product is a finding: it is a
    promise change.
  - Every promise change says what in the code settles it, and the
    code says it. A promise change the code does not settle is a
    question.
  - Every question quotes its artifact, or for an artifact the audit
    proposes the text at issue, names the code that disagrees,
    and drafts both answers. Its stale answer's body carries every
    change the artifact's ordinary delta makes. For an artifact the
    audit proposes, both bodies, the stale answer's and the wrong
    answer's, meet the artifact's definition and template, and the
    wrong answer's body records the text at issue.
  - No candidate or finding was dropped or matched without a reason
    the definitions give.

  ### Record

  Per finding: `tasks item add --pool review --key <kind:slug or
  question> --field site=<kind:slug or question> --field merge=<the merge
  task your brief names> --field decided=<yes | no> --field fix="<what
  the merge must change>" --body "<what breaks which check>" --task
  <task>`. `decided` is `yes` where the rules leave one fix, which
  `fix` names, and `no` where they leave the owner a choice, which
  `fix` names with each answer. Close:
  `tasks close <task> --outcome done --result "<n> findings"`.
```

<!-- Materialized by ok-planner v29.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
