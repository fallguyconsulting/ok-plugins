# Design-doc compliance review

The rules and the task prompts of the planning session's sign-off review, which checks a sprint's delta bodies (concepts, stories, decisions, subjects, practices, docspecs, and the surface intent) against the artifact rules. Its consumers are the sign-off run's root, reader, merge, and fix tasks, per `decision:sign-off-finds-then-fixes-once` and `decision:sign-off-runs-on-the-task-tracker`.

The review checks two things: that an artifact body has the right shape, and that its claims about this repository are true. Rationale is the owner's record of why they decided: verify it where it asserts repository facts and accept it otherwise.

## How consumers use this file

The planning session's sign-off step opens a sign-off run beside the sprint. It writes `{{DESIGN-DOC-COMPLIANCE-RULES}}`, its transclusions resolved, to `.ok-planner/sprints/<sprint-name>-sign-off-rules.md`, the rules file. It writes each of the four task prompts below, its transclusions resolved and `[SPRINT PATH]` and `[RULES PATH]` filled, to `.ok-planner/sprints/<sprint-name>-sign-off-<role>.md`, and registers each with `.ok-planner/bin/tasks prompt register sign-off-<role> <that path>`: `{{DESIGN-DOC-COMPLIANCE-ROOT-PROMPT}}` as `root`, `{{DESIGN-DOC-COMPLIANCE-READER-PROMPT}}` as `read`, `{{DESIGN-DOC-COMPLIANCE-MERGE-PROMPT}}` as `merge`, and `{{DESIGN-DOC-COMPLIANCE-FIX-PROMPT}}` as `fix`. The rules exist once, in the rules file: every prompt names the file, and none holds a copy of the rules.

The rules block transcludes `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, `{{CONCEPT-DEFINITION}}`, `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}`, `{{DOCSPEC-DEFINITION}}`, `{{SURFACE-INTENT-DEFINITION}}`, and `{{DECIDABILITY-BOUNDARY}}` from `skills/_shared/artifact-definitions.md`. The prompts transclude `{{LEAF-AGENT-RULE}}`, `{{FORK-PER-ITEM-RULE}}`, and `{{READ-ONLY-REVIEWER-RULE}}` from `skills/_shared/dispatch-discipline.md`. Replace each `{{...}}` with the body of the matching block. The subject and practice rules live in `.ok-planner/practice-definitions.md`, which is not a token-definitions file: the rules send the reader to read it whole and transclude nothing from it.

## The set block

The session cuts the bodies into sets and writes one block per set. The root's brief holds every set's block, and the root files each block whole as the brief of that set's reader task:

```
set: <n>
bodies:
- <delta heading> (<kind>): <its sidecar path, or inline>; amends <the live file, or none>
stated:
[STATED]
settled:
[SETTLED]
```

`<kind>` is `concept`, `story`, `decision`, `subject`, `practice`, `docspec`, or `surface intent`. A reader task the session files for a gap carries the set's block followed by one line per pair the merge found with no verdict:

```
missing:
- <delta heading>: <rule>
```

## How to substitute `[SETTLED]`

`[SETTLED]` in a set's block lists each finding an earlier checklist raised on the set's bodies that the owner answered or the session settled as a call, one line per finding:

```
- <delta heading or file>: <the finding's one-line summary>. <The owner's answer, or the call and what decides it.>
```

The first checklist passes `none`. A mechanical fix is not listed: the draft already holds it.

## How to substitute `[STATED]`

`[STATED]` in a set's block lists each prohibition the owner stated in the set's bodies, by delta and quote, and each other prohibition the drafter wrote there, by delta and quote, with the harm it guards against as its reason. The fixer's brief holds every line, for every set. A prohibition the owner stated comes from the session's dialogue or from a ruling the sprint carries. A suggested prohibition a discovery recorded carries the discovery's reason. One line per prohibition:

```
- <delta heading or file>: stated: "<the owner's prohibition, quoted>"
- <delta heading or file>: suggested: "<the sentence, quoted>" Reason: <the harm it guards against>.
```

Pass `none` where the session knows of no prohibition in the bodies. Every checklist passes the lines as the draft then stands.

## The rules

The rules file holds this block, its transclusions resolved; it has no placeholder.

### {{DESIGN-DOC-COMPLIANCE-RULES}}

```
## Design-doc compliance rules

These are the rules of a sprint's sign-off review. The review
checks each delta body the sprint carries against each rule
"The checklist" gives its kind, once, and records one verdict for
each body and rule.

### Bodies

A body is a delta's final-form body: inline under its heading in
the sprint, or in the sprint's sidecar folder where the heading
points there. A live file a body amends, and each artifact a body
cites, is input to the `agreement` and `cross-references` rules,
never a body of its own. A body replaces its artifact whole, so a
violation already standing in the live file is a failure of the
body that carries it. A retirement delta carries only its heading:
it is no body and gets no verdict. Report every violation as a
failure. Do not triage.

Out of scope:
- `.ok-planner/discoveries/` — a discovery is a record; a sprint
  carries each body it takes up in its own sidecar.
- The issue intake `.ok-planner/issues.jsonl` and the closed-issue
  file `.ok-planner/closed-issues.jsonl` — operational state and
  records, not design artifacts.
- The tables of contents (`concepts.md`, `stories.md`,
  `decisions.md`, `subjects.md`, `practices.md`) and the docspec
  index (`docspec.md`). `.ok-planner/bin/catalog-toc` generates each
  one from its collection's files, applying a delta regenerates it,
  and the next generation overwrites any hand edit. Each line
  projects an artifact's leading sentence, or a docspec's Where and
  References, so a finding on that text belongs to the artifact
  body.

### Rules to enforce

{{SELF-CONTAINMENT-RULE}}

{{CURRENT-STATE-ONLY-RULE}}

### Concept form

{{CONCEPT-DEFINITION}}

Enforce on every concept body: the body is `## What it is`,
`## Purpose`, `## Boundaries`, and optionally `## Aliases` — an
`## Invariants` section, or any other section, is a violation. A
sentence that states a requirement, a prohibition, a guarantee, a
mechanism, a constant, a command, or an instance is a violation;
the fix is to remove it, or to move it to the decision or the
story that owns it. An alias that is not live in code or prose is
a violation.

Apply the two tests in the definition to every concept body
and record the result whether or not it fails:

- Existence: quote the sentence that narrows the noun beyond what
  a competent engineer would assume from the word alone, or
  report `narrowing: none`. `none` is a violation, class
  `judgment`: the owner retires the concept or names the neighbor
  it merges into. A body that describes a part of the product — a
  page, a screen, a module, a table, a service — is the same
  violation: the part lives in code, and the question to the
  owner is which kind of thing, if any, the part embodies.
- Invariance: quote each sentence under `## What it is` or
  `## Boundaries` that some product meeting the same stories
  under other decisions could make false. Each is a violation.
  Class `mechanical` when stripping it leaves a definition that
  still passes existence; class `judgment` when nothing that
  passes existence remains, and then report it as an existence
  failure.

### Story form

{{STORY-DEFINITION}}

Enforce on every story body: the `## Story` line follows
`As <role>, I want <capability>, so that <benefit>` with a
substantive "so that" clause (missing, empty, or circular — "so
that it works" — is a violation); the body prescribes no
mechanism; the body is `## Story` alone — an `## Acceptance`
section, a verification section, or any other section is a
violation. Apply the three tests in the definition and report
each:

- Need: quote every surface element (a page, a screen, a view, a
  panel, a button, a link, a menu, a field, a layout), every
  interaction on one (click, open, navigate, select, scroll), and
  every clause that enumerates what a surface contains or what
  happens when the user acts on it. Each is a violation. Write
  the capability that remains after striking them as `a way to
  <do something>`, and name where each struck clause goes — a
  work item or a decision. Class `mechanical` when a capability
  remains; class `judgment` when nothing remains, and then the
  question to the owner is whether a need was ever there.
- One need: quote a capability clause that lists several
  capabilities, or a benefit clause that lists several outcomes.
  Each is a violation. Name the factoring: one story per
  capability, each with the benefit it serves, and one decision
  per item that says how and has an alternative. Class
  `mechanical` when every item has one home; class `judgment`
  when an item has no home, and then the question to the owner
  is whether it is kept.
- Invariance: quote each sentence a surface change or an
  implementation change could falsify. Each is a violation,
  classed as under the need test.

Qualitative language — correct, clear, helpful, canonical — is
not a form violation: the drafter writes the concrete version per
{{DECIDABILITY-BOUNDARY}}. Do not ask for a story to be rewritten
in mechanical phrasing.

### Decision form

{{DECISION-DEFINITION}}

Enforce on every decision body: Choice, Rationale, and
Alternatives present; no verification section of any kind;
Alternatives real (a decision with no plausible alternative is a
default — flag it for retirement). A Rationale sentence claiming a
capability or property that no Choice clause commits to is a
violation: the claim moves into the Choice or goes.

### Subject form

Where a set holds a subject or a practice, read
`.ok-planner/practice-definitions.md` whole first. It states the
authoring rules for both kinds, and its templates give their
shape. Enforce every rule it states for a subject and a practice,
quoting the rule's sentence in the failure; these rules do not
restate them.

Enforce on every subject body: frontmatter `subject: <slug>`
alone, its slug the file's name; the body is a title,
`## What it is`, and `## How to find them`, and no other section.
Record per subject:

- Enumeration: follow `## How to find them` against the tree as it
  stands and report the count it yields, or `count: none`. `none`
  is a violation, class `judgment`: the body names a topic, not a
  population, and the owner says how to enumerate it or retires
  it.
- Policy: quote each sentence that says what should be true of the
  members. Each is a violation: a subject defines the set. Class
  `mechanical` when a practice body or a live practice on the subject already
  states it, and the fix strips it; class `judgment` when none
  does, and the owner says whether it becomes a practice.

A missing or extra section, or frontmatter that does not match, is
a violation, class `mechanical`.

### Practice form

Enforce on every practice body: frontmatter `practice: <slug>`,
its slug the file's name, and `subject: <slug>`, naming a live
subject or one a delta of the sprint adds; the body is a title,
`## Practice`, `## When it governs`, and `## What it buys`, and no
other section. Record per practice:

- Affirmative: quote each prohibition and each exemption. Each is
  a violation, class `judgment`: the owner names the practice that
  governs the sites the prohibition or exemption was written for.
- Condition: name one member of the subject and apply
  `## When it governs` to it, reporting the yes or the no. A
  condition a reader cannot answer yes or no is a violation, class
  `judgment`.
- What it buys: quote the maintenance operation and how a reader
  settles whether it holds. A benefit only taste settles is a
  violation, class `judgment`.
- Collision: two practices on one subject, bodies or live, whose
  conditions are equally specific, both claim one member, and say
  conflicting things. Name the member. Each is a violation, class
  `judgment`: a collision is the owner's question.

A missing or extra section, frontmatter that does not match, or a
`subject:` that resolves to no subject is a violation, class
`mechanical`.

### Docspec form

{{DOCSPEC-DEFINITION}}

Enforce on every docspec body: frontmatter `docspec: <slug>`
alone, its slug the file's name; the body is a title, then
`## Where`, `## Reader`, `## Covers`, `## References`, `## Lists`
where the docspec governs reference documentation, `## Shape`,
`## Generator` where its Where starts `in code:`, and optionally
`## Notes`, in that order, and no other section. Record per
docspec:

- Where: the first non-blank line under `## Where` is one path, a
  file or a folder ending in `/`, or `in code:` and one or more
  backticked paths or globs, comma-separated. Anything else is a
  violation, class `mechanical`: the docspec index shows that line,
  and the lint reads an `in code:` line from it.
- Shape: `## Shape` gives one file's parts in order. A docspec
  without one is a violation, class `mechanical`: the fix copies the
  shape template under `.ok-planner/docs/shapes/` that fits its
  kind of documentation, which the owner may veto at approval. A
  `## Shape` or `## Where` that names a template instead of stating
  the shape is a violation, class `mechanical`: copy the template's
  text in.
- Generator: a docspec whose Where starts `in code:` and carries no
  `## Generator` is a violation, class `judgment`: the owner names
  the tool, or says `none`. A `## Generator` that names a command
  but not where its output goes, or not whether the output is
  committed, is a violation, class `judgment`. A `## Generator` on
  any other docspec is a violation, class `mechanical`.
- References: each bullet is `concept:<slug>`, `story:<slug>`,
  `decision:<slug>`, or one backticked code path or glob. A bullet
  in another form is a violation, class `mechanical`. A docspec
  with no bullet matches no work: a violation, class `judgment`,
  and the owner names what the documentation describes.
- Lists: each bullet names a class the surface intent names, live
  or as a delta of the sprint amends it. A class it does not name is a
  violation, class `judgment`: the owner adds the class to the
  surface intent by a delta, or drops it from the docspec. A
  `## Lists` on documentation that is not reference documentation
  is a violation, class `judgment`.
- Paths: each path under `## Where` and each code path or glob
  under `## References` matches a path the tree holds or one a
  work item of the sprint adds. One that matches neither is a
  violation, class `mechanical` where the tree holds an obvious
  successor, `judgment` otherwise.

### Surface intent form

{{SURFACE-INTENT-DEFINITION}}

Enforce on the surface intent body: it is one prose document
of class rules with named exceptions, and its last section is
`## Where each class is declared`. Record:

- Declaring section: a surface intent whose last section is not
  `## Where each class is declared` is a violation, class
  `mechanical` where the section stands elsewhere in the document,
  `judgment` where it is missing, and the owner names each class's
  declaring files.
- Inventory: quote each passage that lists the members of a class
  instead of stating its rule. Each is a violation, class
  `mechanical`: the fix states the class's rule and leaves the
  members to the tree.
- Declaring lines: each line under `## Where each class is
  declared` reads `` - <class>: `<path or glob>`[, `<path or glob>`] ``,
  names a class the rules above it name, and gives paths or globs
  that match a file the tree holds or one a work item of the sprint
  adds. A line in another form is a violation, class `mechanical`:
  `/converge` skips it. A class the rules do not name, or a path
  that matches neither, is a violation, class `mechanical` where
  the rules or the tree hold an obvious successor, `judgment`
  otherwise.
- Internal by default: quote each rule that classes a class as
  internal and anchors none of the intent's exceptions, and each
  passage that lists internal elements outside a public class's
  exceptions. Each is a violation, class `mechanical`: an element no
  rule or exception makes public is internal, so the fix deletes the
  passage and the class's line under `## Where each class is
  declared`. A rule that names an internal class only so an exception
  can make one of its members public stands.

### Reference coverage

On each docspec body and the surface intent body, read the
surface intent at `.ok-planner/surface/surface.md` with the surface
intent delta in its place, and every docspec under
`.ok-planner/docspec/` with each docspec delta in its place, a
retired one removed. Every class a rule makes public, and every
class an exception draws a public member from, is named under the
`## Lists` of a reference docspec. A guide, a tutorial, or any
docspec without `## Lists` does not count. A class no reference
docspec lists is a violation, class `mechanical`: the fix drafts a
`### New docspec` delta from the reference shape template that
lists it, or, where a delta of the sprint dropped the class from a
reference docspec, restores it there.

### Claim grounding

A Rationale records why the owner decided and needs no
verification to be legal; its one shape rule is the capability
rule under Decision form above (a Rationale sentence claiming a
capability no Choice clause commits to). The same holds for an
Alternatives bullet's account of why an option lost. Never flag
reasoning because it cannot be verified.

Verify only claims about this repository — what a file does, what
a script runs, what a config sets, what a dependency is pinned to,
what a vendored image contains — in whatever section they appear.
Read the file; run the grep. A claim the repository contradicts is
a finding, class `mechanical` where the repository determines the
correct text and no commitment changes. Accept everything else —
an external service's behavior, an ecosystem convention, the
owner's weighing of costs — without research; its unverifiability
is never a finding. Do not follow a claim beyond the repository,
and do not turn a grounding check into a code review.

### Cross-reference integrity

Every `see also: <slug>` and `concept:<slug>` / `story:<slug>` /
`decision:<slug>` / `subject:<slug>` / `practice:<slug>` reference
in a body, every practice's `subject:` frontmatter, and every slug
bullet under a docspec's `## References` resolves to an
artifact of the matching kind: a live file
(`.ok-planner/design/<kind>s/<slug>.md`,
`.ok-planner/subjects/<slug>.md`, or
`.ok-planner/practices/<slug>.md`), or one a delta of the sprint
adds. A reference to an artifact a delta of the sprint retires does not
resolve. One that does not resolve is a violation: repoint it or
remove it.


### Agreement

A body contradicts no other body the sprint carries that it cites
or that cites it, and no live artifact it cites or amends. Read an
amendment against the live artifact it amends: what changed is what
the owner signs off on, so a claim it introduces that contradicts
an artifact it cites is a violation, and so is anything it drops
silently. A drop is silent where no work item, ruling, or other
delta of the sprint names it. Class `mechanical` where the sprint's
work items, its rulings, or another body decides which text holds;
`judgment` otherwise, and the question to the owner names both
texts.

### Suggested prohibitions

Read every body for each sentence that forbids something: one that
says an actor never does a thing, must not or may not do it, or
that a thing is refused. A sentence the live artifact the delta
amends already states is the owner's, and so is one the `stated`
lines of your brief quote as stated. Every other forbidding sentence
is a suggested prohibition. Record each one as a `prohibitions`
item, with the reason the `stated` lines give for it, or
`no reason recorded`:

    .ok-planner/bin/tasks item add --pool prohibitions --key <key> --task <task> --state open --field body="<delta heading>" --field sentence="<the sentence, quoted>" --field reason="<the reason the stated lines give, or no reason recorded>" --body "<the line or section heading>"

Recording a suggested prohibition is not a failure. A suggested
prohibition with no reason recorded fails the body's `prohibitions`
rule, class `mechanical`: the fix gives the harm the sentence guards
against as its reason, or removes the sentence where it guards
against none.

### The checklist

Each kind of body owes one verdict for each rule its row names:

| Kind | Rules |
|---|---|
| concept, story, decision, subject, practice | `self-containment`, `current-state-only`, `form`, `grounding`, `cross-references`, `agreement`, `prohibitions` |
| docspec, surface intent | `current-state-only`, `form`, `grounding`, `cross-references`, `agreement`, `prohibitions`, `reference-coverage` |

`self-containment` and `current-state-only` are the two rules under
"Rules to enforce". `self-containment` skips a subject's
`## How to find them`. `form` is the section for the body's kind:
Concept form, Story form, Decision form, Subject form, Practice
form, Docspec form, or Surface intent form. `grounding` is Claim
grounding, `cross-references` is Cross-reference integrity,
`agreement` is Agreement, `prohibitions` is Suggested prohibitions,
and `reference-coverage` is Reference coverage.

Record each verdict as one `verdicts` item:

    .ok-planner/bin/tasks item add --pool verdicts --key <key> --task <task> --state passes --field body="<delta heading>" --field rule=<rule> --field set=<n> --body "<what the rule's section asks recorded, or one line naming what you checked>"
    .ok-planner/bin/tasks item add --pool verdicts --key <key> --task <task> --state fails --field body="<delta heading>" --field rule=<rule> --field set=<n> --field class=<mechanical|judgment> --body "<the record>"

A pair that passes holds one `passes` verdict. A pair that fails
holds one `fails` verdict per violation, each naming one passage,
and no `passes` verdict. A rule's section that asks a result
recorded whether or not it fails, such as a concept's narrowing or
a subject's count, puts the result in the verdict's body. The
fixer's check records its verdicts with `--field check=fix` in place
of `--field set=<n>`.

A `fails` verdict's body is the record:
- The line number or section heading
- The offending text, quoted
- The rule it violates, and the sentence of the rule where its
  section quotes one
- How to fix (mechanical), or the question the owner must answer
  (judgment)

Its class is `mechanical` or `judgment`. `mechanical`: the rules
determine the compliant text and writing it changes nothing the
project commits to — a forbidden section to strip, a dangling
cross-reference with an obvious live successor, a heading brought
to shape, a mechanism tail stripped from a story whose commitment
survives. `judgment`: compliance requires the owner to decide
something — a boundary that cannot be stated without naming a file,
a story with no honest benefit clause, a decision whose violation
no reading could detect.

Settled findings: where a pair's only failure is a finding a
`settled` line of your brief lists, record `passes` and name the
settlement in the verdict's body. A violation in text written after
the settlement is a new failure.

### Anti-padding

- Flag nothing under `.ok-planner/discoveries/`.
- Record verdicts only on the bodies your brief names. A live file
  or a cited artifact is read only as the rules above read it.
- Flag no prose style. The form rules are structural — which
  citations and sections are present. Claim grounding is about
  truth: flag a sentence for what it asserts, never for how it
  reads.
- Research no external service to settle a claim.
- Flag no concept for missing content the rule does not
  require; the concept form above, with its existence and
  invariance tests, is the whole requirement. The same holds for
  a subject, a practice, a docspec, and the surface intent: their
  forms above, with the practice definitions, are the whole
  requirement.
- Grade no severity. Every violation is a failure.
```

## The task prompts

Replace `[SPRINT PATH]` with the sprint's path and `[RULES PATH]` with the rules file's path; everything else is invariant.

### {{DESIGN-DOC-COMPLIANCE-ROOT-PROMPT}}

The root of one checklist: it reads the rules once and forks one reader per set.

```
Task prompt (profile ok-review):
  ## Sign-off review: read the rules once and fork one reader per set

  {{FORK-PER-ITEM-RULE}}

  Fork every set, however few: the session reads the review's
  coverage from the reader tasks you file, and a set you read
  yourself would be one no reader task holds. The fork-per-item
  rule's one-item clause does not apply to you. You record no
  verdict yourself.

  {{READ-ONLY-REVIEWER-RULE}}

  This review checks the delta bodies of the sprint at
  [SPRINT PATH]. Your brief holds one set block per set: its number,
  each body with its kind, its sidecar path or `inline`, and the live
  file it amends; then its `stated` lines and its `settled` lines.

  ### Read once

  - [RULES PATH], whole: the review's rules and its checklist.
  - `.ok-planner/practice-definitions.md`, whole, where a set holds a
    subject or a practice.
  - The `## Intent` section of [SPRINT PATH] and its delta headings.

  This reading is what every reader shares. Read no body: each
  reader reads its own set's.

  ### File one reader per set

  For each set block in your brief, file one task on your own
  profile, forked from your task, under your task's key, its brief
  the set's block whole:

      .ok-planner/bin/tasks file --role sign-off-read --prompt sign-off-read --agent ok-review --key <your task's key> --fork-of <task> --brief - <<'EOF'
      <the set's block, whole>
      EOF

  ### Close, then fork

  Close your task first: `tasks close <task> --outcome done --result
  "<one entry per reader task: its id and its set's number; then the
  counts: sets, bodies>"`.

  Then fork one agent per reader task, every fork in one message,
  with `subagent_type` set to `fork`, each fork's prompt exactly
  this, its reader task's id in place of `<reader task>`:

      You are a fork of the review root. Everything the root read
      stands in your context; read nothing shared again. Claim your
      task and finish it.
      task: <reader task>

  Wait for every fork to return, then run `tasks next`. Your final
  text is your own `closed` line followed by the whole output of that
  `tasks next`, as the profile defines.
```

### {{DESIGN-DOC-COMPLIANCE-READER-PROMPT}}

One reader per set: it records every rule's verdict for every body in its set.

```
Task prompt (profile ok-review):
  ## Sign-off review: check one set of delta bodies against the rules

  {{READ-ONLY-REVIEWER-RULE}}

  You fork nothing. This review checks the delta bodies of the
  sprint at [SPRINT PATH]. Your brief is one set block: its number,
  each body with its kind, its sidecar path or `inline` (under its
  heading in the sprint), and the live file it amends; then its
  `stated` lines, its `settled` lines, and, where the session filed
  you for a gap, its `missing` lines.

  ### Your reading

  Where you are a fork of the review root, its reading is in your
  context; read nothing shared again. Where you are a fresh agent the
  drain dispatched on a reissued task or the session filed for a gap,
  read now what the root read: [RULES PATH] whole,
  `.ok-planner/practice-definitions.md` whole where your set holds a
  subject or a practice, and the `## Intent` section and the delta
  headings of [SPRINT PATH]. A fresh agent then lists the verdicts
  your set already holds (`.ok-planner/bin/tasks item list --pool
  verdicts --key <your task's key> --json`, those whose `set` is your
  set's number), and records only the pairs none holds.

  Then read each body of your set whole, the live file it amends, and
  each artifact it cites, a live one or another body the sprint
  carries.

  ### Record

  For each body, apply each rule the checklist table gives its kind,
  and record each verdict as "The checklist" says, under your task's
  key. Where your brief holds `missing` lines, record only the pairs
  they name. Record each suggested prohibition a body writes as
  "Suggested prohibitions" says, under your task's key.

  Before you close, list your set's verdicts as above, and record a
  verdict for each pair your set owes that no verdict holds.

  ### Close

  `tasks close <task> --outcome done --result "<bodies> bodies,
  <verdicts> verdicts, <fails> failures, <prohibitions>
  prohibitions"`.
```

### {{DESIGN-DOC-COMPLIANCE-MERGE-PROMPT}}

The merge of one checklist: it checks coverage, folds the failures into findings, and lists the suggested prohibitions.

```
Task prompt (profile ok-opus):
  ## Sign-off review: check coverage, fold the failures, and list the prohibitions

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  This review checks the delta bodies of the sprint at
  [SPRINT PATH]. Read [RULES PATH] whole. Your brief names each set:
  its number, and each body with its kind. Your task consumes every
  `verdicts` item and every `open` `prohibitions` item of your key;
  `tasks claim` printed them. List the `gaps` items of your key with
  `.ok-planner/bin/tasks item list --pool gaps --key <key> --json`.
  Every item you record carries your task's key and
  `--task <task>`.

  ### Coverage

  Before you fold anything, list each set's pairs: each body with
  each rule the checklist table gives its kind. A pair holds a
  verdict where a `verdicts` item of your key names its body and its
  rule.

  - Set each `open` gap whose pair now holds a verdict to `filled`:
    `.ok-planner/bin/tasks item set <id> --state filled`.
  - For each pair that holds no verdict and that no `gaps` item
    names, record one:
    `.ok-planner/bin/tasks item add --pool gaps --key <key> --task <task> --state open --field body="<delta heading>" --field rule=<rule> --field set=<n>`.
  - Where you recorded any gap, fold nothing, and close `partial`
    with the result `gaps: <the count you recorded>`. The session
    sends each set with a gap back to one reader, once, and refiles
    you.

  A pair an `open` gap already names went back to a reader once: it
  stays `open` for the owner's approval, and you fold everything
  else.

  ### Fold

  Fold into one `findings` item the `fails` verdicts that name one
  passage, and the verdicts of two bodies that name one
  contradiction between them, so each `fails` verdict lands in one
  finding:

      .ok-planner/bin/tasks item add --pool findings --key <key> --task <task> --state <mechanical|judgment> --field bodies="<each delta heading>" --field folds="<each verdict id>" --field rule=<rule> --body "<the record, as the folded verdicts give it>"

  Set its state by the rules' class definitions. Where the folded
  verdicts disagree on the class, read the passage and decide by
  those definitions.

  Set each `prohibitions` item you consume to `listed`, or to
  `duplicate` where another item of your key already records the
  same sentence of the same body. The items at `listed` are the one
  list of suggested prohibitions the owner reads at approval.

  ### Close

  `tasks close <task> --outcome done --result "<verdicts> verdicts,
  <fails> failures, <findings> findings (<m> mechanical, <j>
  judgment), <listed> prohibitions listed, <filled> gaps filled,
  <open> gaps open"`.
```

### {{DESIGN-DOC-COMPLIANCE-FIX-PROMPT}}

The fixer of one checklist: it fixes each finding once, then checks each body it changed.

```
Task prompt (profile ok-opus):
  ## Sign-off review: fix each finding once, then check what you changed

  {{LEAF-AGENT-RULE}}

  You fix the delta bodies of the sprint at [SPRINT PATH]. Your
  task's files are the sprint and its sidecar folder. Read
  [RULES PATH] whole, and `.ok-planner/practice-definitions.md`
  whole where a finding names a subject or a practice. Your task
  consumes the `mechanical` and `judgment` findings and the `listed`
  prohibitions of your key; `tasks claim` printed them. Your brief
  holds every stated prohibition, one `stated` line each, as the
  rules read them. Every item you record carries your task's key and
  `--task <task>`.

  ### Fix each finding once

  - Change only the passage the finding cites, and leave the rest of
    its body as it stands.
  - A `mechanical` finding: write the compliant text its record
    names, and set it `fixed`. Where you cannot write it, set it
    `unsettled` with a note naming why.
  - A `judgment` finding: apply its `settled` field. Set it `fixed`
    where you changed text, `kept` where the settlement keeps the
    text, and `unsettled` where you cannot apply it. A judgment
    finding with no `settled` field is `unsettled`: you decide
    nothing that belongs to the owner.
  - A `prohibitions` finding on a sentence with no reason recorded:
    write the harm the sentence guards against into its
    `prohibitions` item's `reason`
    (`.ok-planner/bin/tasks item set <id> --field reason="<the harm>"`),
    or remove the sentence and set the item `removed`. Then set the
    finding `fixed`.

  Set each finding with `.ok-planner/bin/tasks item set <id> --state
  <fixed|kept|unsettled>`.

  ### Check what you changed

  Then run the checklist on each body you changed or drafted, and on
  no other body: each rule the checklist table gives its kind, one
  `verdicts` item per pair, as "The checklist" records them, with
  `--field check=fix`. Fix each failure in the same pass, at the
  passage the failure cites, and record its verdict as the text then
  stands. Record each failure you cannot settle as a `findings` item
  at `unsettled`, with the fields a merged finding carries. Record
  each suggested prohibition your change adds as a `prohibitions`
  item at `listed`, its reason the harm it guards against. This
  check runs once: no body is checked twice.

  ### Close

  Stage nothing: the planning session's files stay uncommitted until
  execution's base step. Close: `tasks close <task> --outcome done
  --result "<findings> findings: <f> fixed, <k> kept, <u> unsettled;
  <b> bodies checked, <c> check failures fixed, <n> left unsettled"
  --sites <each body you changed or drafted: its sidecar path, or
  [SPRINT PATH]:<its delta heading>>`.
```
