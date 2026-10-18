# Design-doc compliance reviewer prompt

The prompt for the design-doc compliance reviewer subagent. Its one consumer is the planning session's sign-off review, at draft scope: a sprint's deltas (concepts, stories, decisions, subjects, practices, docspecs, and the surface intent) plus any live file a delta amends.

The reviewer checks two things: that an artifact body has the right shape, and that its claims about this repository are true. Rationale is the owner's record of why they decided: verify it where it asserts repository facts and accept it otherwise.

## How consumers use this file

The planning session's sign-off step computes the **draft scope** — the sprint's deltas (inline, or in the sidecar folder where a heading points there) plus any live file one of them amends — and substitutes that set for `[REVIEW SCOPE]`.

The prompt transcludes `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, `{{CONCEPT-DEFINITION}}`, `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}`, `{{DOCSPEC-DEFINITION}}`, `{{SURFACE-INTENT-DEFINITION}}`, and `{{DECIDABILITY-BOUNDARY}}` from `skills/_shared/artifact-definitions.md` and `{{LEAF-AGENT-RULE}}`, `{{READ-ONLY-REVIEWER-RULE}}` from `skills/_shared/dispatch-discipline.md`. Replace each `{{...}}` with the body of the matching block. The subject and practice rules live in `.ok-planner/practice-definitions.md`, which is not a token-definitions file: the prompt sends the reviewer to read it whole and transcludes nothing from it.

## How to substitute `[REVIEW SCOPE]`

`[REVIEW SCOPE]` is one or more lines listing the artifact files or in-sprint delta blocks to review, with a one-line note above naming the mode:

```
Review the deltas in the sprint at <path> (each a complete
final-form body — inline, or one file per artifact in the sprint's
sidecar folder), plus these live files the deltas amend:

- .ok-planner/design/concepts/claim-handle.md
- .ok-planner/design/stories/claim-co-holder.md
- .ok-planner/practices/catch-at-owner-frame.md
- .ok-planner/docspec/readme.md
- .ok-planner/surface/surface.md

For an amendment, read the delta against the live artifact it amends.
What changed is what the owner is signing off on: catch a claim it
introduces and anything it silently drops.
```

## The prompt

Replace `[REVIEW SCOPE]`; everything else is invariant.

### {{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}

```
Agent (general-purpose, model: opus):
  ## Design-doc compliance review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Review the design-doc content in scope for compliance with the
  artifact rules — self-containment, current-state-only, concept
  form, story form, decision form, subject form, practice form,
  docspec form, and surface intent form, reproduced or named under
  "Rules to enforce" and the form sections after it — and for the
  truth of the repository claims the bodies make. Report every
  violation as a finding. The caller fixes mechanical findings and
  files judgment findings to the intake. Do not triage. Pre-existing
  violations in files within scope are in scope.

  ### Scope

  [REVIEW SCOPE]

  Out of scope:
  - `.ok-planner/design/_discover/` — phase 1 scaffolding may cite
    code paths.
  - The issue intake `.ok-planner/issues.jsonl` and its archive
    `.ok-planner/history/issues.jsonl` — operational state and
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

  Enforce on every in-scope concept: the body is `## What it is`,
  `## Purpose`, `## Boundaries`, and optionally `## Aliases` — an
  `## Invariants` section, or any other section, is a violation. A
  sentence that states a requirement, a prohibition, a guarantee, a
  mechanism, a constant, a command, or an instance is a violation;
  the fix is to remove it, or to move it to the decision or the
  story that owns it. An alias that is not live in code or prose is
  a violation.

  Apply the two tests in the definition to every in-scope concept
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

  Enforce on every in-scope story: the `## Story` line follows
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

  Enforce on every in-scope decision: Choice, Rationale, and
  Alternatives present; no verification section of any kind;
  Alternatives real (a decision with no plausible alternative is a
  default — flag it for retirement). A Rationale sentence claiming a
  capability or property that no Choice clause commits to is a
  violation: the claim moves into the Choice or goes.

  ### Subject form

  Where a subject or a practice is in scope, read
  `.ok-planner/practice-definitions.md` whole first. It states the
  authoring rules for both kinds, and its templates give their
  shape. Enforce every rule it states for a subject and a practice,
  quoting the rule's sentence in the finding; this prompt does not
  restate them.

  Enforce on every in-scope subject: frontmatter `subject: <slug>`
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
    `mechanical` when an in-scope practice on the subject already
    states it, and the fix strips it; class `judgment` when none
    does, and the owner says whether it becomes a practice.

  A missing or extra section, or frontmatter that does not match, is
  a violation, class `mechanical`.

  ### Practice form

  Enforce on every in-scope practice: frontmatter `practice: <slug>`,
  its slug the file's name, and `subject: <slug>`, naming a live
  subject or one a delta in scope adds; the body is a title,
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
  - Collision: two in-scope or live practices on one subject whose
    conditions are equally specific, both claim one member, and say
    conflicting things. Name the member. Each is a violation, class
    `judgment`: a collision is the owner's question.

  A missing or extra section, frontmatter that does not match, or a
  `subject:` that resolves to no subject is a violation, class
  `mechanical`.

  ### Docspec form

  {{DOCSPEC-DEFINITION}}

  Enforce on every in-scope docspec: frontmatter `docspec: <slug>`
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
    or as a delta in scope amends it. A class it does not name is a
    violation, class `judgment`: the owner adds the class to the
    surface intent by a delta, or drops it from the docspec. A
    `## Lists` on documentation that is not reference documentation
    is a violation, class `judgment`.
  - Paths: each path under `## Where` and each code path or glob
    under `## References` matches a path the tree holds or one a
    work item in scope adds. One that matches neither is a
    violation, class `mechanical` where the tree holds an obvious
    successor, `judgment` otherwise.

  ### Surface intent form

  {{SURFACE-INTENT-DEFINITION}}

  Enforce on the in-scope surface intent: it is one prose document
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
    that match a file the tree holds or one a work item in scope
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

  Whenever a docspec delta or a surface intent delta is in scope, read
  the surface intent at `.ok-planner/surface/surface.md` with the
  surface intent delta in its place, and every docspec under
  `.ok-planner/docspec/` with each docspec delta in its place, a
  retired one removed. Every class a rule makes public, and every
  class an exception draws a public member from, is named under the
  `## Lists` of a reference docspec. A guide, a tutorial, or any
  docspec without `## Lists` does not count. A class no reference
  docspec lists is a violation, class `mechanical`: the fix drafts a
  `### New docspec` delta from the reference shape template that lists
  it, or, where a delta in scope dropped the class from a reference
  docspec, restores it there.

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
  in an in-scope body, every practice's `subject:` frontmatter, and
  every slug bullet under a docspec's `## References` resolves to an
  artifact of the matching kind: a live file
  (`.ok-planner/design/<kind>s/<slug>.md`,
  `.ok-planner/subjects/<slug>.md`, or
  `.ok-planner/practices/<slug>.md`), or one a delta in scope adds.
  A reference to an artifact a delta in scope retires does not
  resolve. One that does not resolve is a violation: repoint it or
  remove it.

  ### How to scan

  Walk every in-scope file or delta block. Record per violation:
  - File path (or sprint delta heading)
  - Line number or section heading
  - The offending text, quoted
  - Which rule it violates
  - Class: `mechanical` or `judgment`. `mechanical`: the rules
    determine the compliant text and writing it changes nothing the
    project commits to — a forbidden section to strip, a dangling
    cross-reference with an obvious live successor, a heading
    brought to shape, a mechanism tail stripped from a story whose
    commitment survives. `judgment`: compliance requires
    the owner to decide something — a boundary that cannot be stated
    without naming a file, a story with no honest benefit clause, a
    decision whose violation no reading could detect.
  - How to fix (mechanical), or the question the owner must answer
    (judgment)

  ### Output format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found, one entry per violation:)

  ### <file>:<line-or-section> — <one-line summary>
  Class: mechanical | judgment
  <Quoted offending text, which rule it violates, how to fix
  or what the owner must decide.>

  (if Approved:)

  (empty Findings section)
  ```

  ### Anti-padding

  - Flag nothing under `_discover/`.
  - Flag nothing outside the scope above; the scope is exhaustive.
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
  - Grade no severity. Every violation is in scope.
```
