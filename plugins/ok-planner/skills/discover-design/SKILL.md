---
name: discover-design
description: "ONLY activated by explicit /discover-design slash command. Never auto-triggered by conversation content."
---

# Discover Design

Two-phase autonomous pass that produces (1) a thorough as-is description
of the project's design — the load-bearing concepts and how the code
today embodies them — and (2) an explicit catalog of where the as-is
design is sloppy, unspecified, unclear, overloaded, or in conflict with
itself.

Runs end-to-end without user interruption. Each phase has its own
agentic produce → review → fix loop. Judgment questions the run
surfaces — ambiguities in the as-is design, the agent's own confessed
uncertainty — are appended to `.ok-planner/issues.jsonl` as open
rows; the human resolves them in `/sprint` sessions — each taking the
issues that bear on the work it plans, or the queue itself when
working the queue is the session's purpose.

## Why this exists

The design docs this skill bootstraps are the project's **durable
identity** — the high-level, general framing of what the project is
and what it owes its users. Three catalogs: concepts (load-bearing
nouns), stories (durable user expectations), decisions (architectural
tradeoffs) — plus the issue queue (open questions). Together they
answer "what kind of thing is this project, at the altitude above any
specific implementation?"

The directory is named `design/` for historical reasons. The label is
not load-bearing — `design/` does NOT hold specific designs of
interfaces, routes, CLI grammars, schema details, or implementation
diagrams. Those live in code, in `backlogs/`, and in other documentation.
See `skills/_shared/artifact-definitions.md` for the canonical
"What 'design' means" framing.

The relationship between design and code is **code references
design**, not the other way around: code at points of enforcement
carries an `@concept:` / `@story:` / `@decision:` annotation
back to the design slug, and the design owns the definition. A
refactor that moves files around does not invalidate the design;
a code path that diverges from a concept's stated boundary is a
defect.

Capturing the as-is design plus its open questions up front is useful
even before refinement: future reviewers can distinguish a design
choice from a defect, and the issue queue tells them what the project
itself considers unsettled. The skill runs autonomously because the
discovery work is grunt work — read code, read prose, summarize,
classify, cross-check — and the user's design judgment is better spent
resolving the queue in `/sprint`.

## Inputs

Read everything the project will let you read. Code is ground truth for
what the system actually does, but prose (CLAUDE.md, READMEs,
`docs/concepts/`, the cold-read docs, CHANGELOG, prior sprint backlogs,
design sketches) is ground truth for what the project *thinks* the
concepts mean. Discrepancies between code and prose are issues —
record them, do not resolve them.

## When to invoke

- A project that doesn't have `.ok-planner/design/concepts/` yet.
- A project that has `_discover/` scaffolding from a prior run (the
  skill picks up: phase 1 expands the existing scaffolding, phase 2
  runs against the expanded set).
- After major architectural work that materially changed the concept
  surface (new noun, retired noun, sharpened boundary), if and only if
  no sprint has yet produced human-approved concepts. Once there
  are refined concepts, do not re-run discovery against the same
  `concepts/` directory — the skill aborts to avoid clobbering
  them. Keep the design model aligned with the code through sprint
  backlogs (whose corpus deltas change docs and code as one unit).

## Where the log lives

```
.ok-planner/design/
  _discover/        — phase 1 scaffolding (raw thorough descriptions)
  concepts/         — phase 2 initial concept docs (one concept per file)
  stories/          — phase 2 initial story docs (one story per file)
  decisions/        — phase 2 initial decision docs (one decision per file)
.ok-planner/issues.jsonl — open questions for the human (appended)
```

- `_discover/` is **scaffolding**, not the artifact. It is wide and
  detailed and may include redundancy. It is the trail of what was
  observed.
- `concepts/`, `stories/`, and `decisions/` are the durable
  outputs. They are still **as-is**, not prescriptive — `/sprint`
  resolves issues with the owner and packages resolutions as corpus
  deltas; whoever executes the backlog applies them alongside the
  code changes.
- Issue rows this skill appends carry `kind: "discover"`. Two
  flavors share the queue: muddiness in the codebase itself
  (overloaded / unclear / conflicting / … categories) and the
  agent's own confessed uncertainty about the extracted artifacts
  (judgment calls, suspected-but-unconfirmed concepts, thin areas
  the loop could not close) — category `other` unless a sharper
  one fits.

## Process

The skill runs autonomously through both phases plus an optional
back-edge. No user prompts mid-run. Each phase uses an agentic loop:
producer → reviewer → (if not approved) producer-with-feedback →
reviewer → … capped at 3 review cycles per phase. If the reviewer is
still finding issues at cycle 3, the skill stops the loop, appends
each unresolved finding to `.ok-planner/issues.jsonl` (open rows,
`kind: "discover"`), and proceeds.

After phase 2 completes (approved or capped), the skill checks for a
phase-2 → phase-1 back-edge: if the phase 2 reviewer identified
specific areas where `_discover/` was too thin to support a real
concept, the skill dispatches a focused re-discovery for just those
areas, then re-runs the extractor and reviewer for the affected
concepts only. Capped at one back-edge per skill invocation.

1. Run `ok-planner:true-up` to ensure `.ok-planner/` layout exists.
2. Create `.ok-planner/design/_discover/`,
   `.ok-planner/design/concepts/`, `.ok-planner/design/stories/`,
   and `.ok-planner/design/decisions/` if absent.
3. Detect state:
   - Empty `_discover/` → phase 1 starts from scratch.
   - Non-empty `_discover/` → phase 1 expands existing entries and
     adds new ones (idempotent).
   - Non-empty `concepts/`, `stories/`, or `decisions/` → abort.
     Tell the user to delete the non-empty durable directories for
     a full rerun. Do not silently overwrite human-edited artifact
     files.
4. **Phase 1 (Discovery):**
   a. Dispatch the discoverer subagent with the Phase 1 Discoverer
      Prompt. It writes/expands `_discover/<slug>.md` files.
   b. Dispatch the discovery-reviewer subagent with the Phase 1
      Reviewer Prompt. It produces a structured report:
      `Approved | Issues Found (with specifics)`.
   c. If `Issues Found`: re-dispatch the discoverer with the
      reviewer's findings prepended to its prompt as
      `### Reviewer findings to address (cycle N)`. Loop back to
      (b). Cap at 3 cycles total (initial + 2 fix passes).
   d. If still `Issues Found` after cycle 3: append each unresolved
      finding to `.ok-planner/issues.jsonl` (open rows,
      `kind: "discover"`).
5. **Phase 2 (Concept / story / decision extraction + issue identification):**
   a. Dispatch the extractor subagent with the Phase 2 Extractor
      Prompt. It writes `concepts/<slug>.md`, `stories/<slug>.md`,
      and `decisions/<slug>.md` files, and appends issue rows
      (`kind: "discover"`) for each genuine muddiness.
   b. Dispatch the extraction-reviewer subagent with the Phase 2
      Reviewer Prompt. It produces a structured report and, on its
      final pass (whether approved or capped), appends its
      agent-confessed-uncertainty observations to
      `.ok-planner/issues.jsonl` as open rows.
      The reviewer's report may include a structured
      `## Thin discovery requests` block naming areas where phase 1
      `_discover/` material was too thin to support a real concept.
   c. Same fix loop as phase 1, capped at 3 cycles.
   d. If still `Issues Found` after cycle 3: append each unresolved
      finding to `.ok-planner/issues.jsonl` (open rows,
      `kind: "discover"`).
6. **Back-edge: focused re-discovery (one-shot).**
   - Check the phase 2 reviewer's most-recent report for a
     `## Thin discovery requests` block with non-empty entries.
   - If present AND no back-edge has run yet in this invocation:
     a. Dispatch the focused-discoverer subagent with the Back-Edge
        Discoverer Prompt and the thin-discovery requests as input.
        It expands the named `_discover/` entries (or adds new ones)
        with deeper code discussion for just the listed areas.
     b. Dispatch the focused-extractor subagent with the Back-Edge
        Extractor Prompt. It updates the affected `concepts/`,
        `stories/`, and `decisions/` files in place, appends issue
        rows surfaced by the new material, and (only when the
        request explicitly names a new artifact) adds new
        `concepts/<slug>.md`, `stories/<slug>.md`, or
        `decisions/<slug>.md` files.
     c. Dispatch the phase 2 reviewer one more time (using the same
        Phase 2 Reviewer Prompt) with scope restricted to the
        artifacts affected by the back-edge. The reviewer appends
        its residual uncertainty about the back-edge work to
        `.ok-planner/issues.jsonl` as open rows.
   - One back-edge per skill invocation. If the back-edge reviewer
     identifies further thin-discovery needs, they too become issue
     rows for the human — do not loop.
7. **Regenerate the design catalog summaries.** For each of
   `concepts/`, `stories/`, and `decisions/`, read every file
   (skipping `_merged/` subdirectories if present) and produce a
   one-shot-readable TOC alongside it:

   - `concepts/` → `concepts.md` (entries: slug, optional aliases,
     first sentence of `## What it is`)
   - `stories/` → `stories.md` (entries: slug, one-line summary
     drawn from the story's `As ... I want ...` statement)
   - `decisions/` → `decisions.md` (entries: slug, one-line summary
     drawn from the decision's `Choice:` line)

   These TOCs are the one-shot-readable catalogs consulted by
   skills that read the design docs (sprint, audit, prove); they
   let agents know what artifacts exist without reading every
   full file. Generated; agents should not edit them by hand.

   Format (use the same shape for all three):
   ```markdown
   # <Concept|Story|Decision> catalog (auto-generated)

   Read first. Then either grep for the matching annotation
   (`@concept:` / `@story:` / `@decision:`) in the code under
   review, or read `<dir>/<slug>.md` for the full body. Generated
   by `discover-design` and refreshed whenever a sprint backlog's
   deltas touch the catalog. Do not edit by hand — changes will
   be overwritten.

   ## <Concepts|Stories|Decisions>

   - `<slug>` — <one-sentence summary, ≤120 chars>
   - `<slug>` (aliases: <comma-list>) — <one-sentence summary>
   ```

   Sort entries alphabetically by slug. Omit the `(aliases: ...)`
   parenthetical when there are no aliases. Aliases apply mainly
   to concepts; stories and decisions typically have none.

8. Final report to the user: number of `_discover/` entries,
   number of concepts, number of stories, number of decisions,
   number of issue rows appended grouped by category, whether a
   back-edge ran, and the next-step pointer (run `/sprint` — a
   freshly discovered corpus's queue is usually worth a session of
   its own).

The skill does not prompt the user mid-run. The final report is the
only thing the user sees during this skill's execution.

## Shared rule blocks (transclude into dispatches)

The canonical artifact definitions, templates, and rule blocks live in
`skills/_shared/artifact-definitions.md`. That file is the single source
of truth — every skill that authors, reviews, or mutates concepts /
stories / decisions / issues reads from it.

The embedded prompts below carry `{{TOKEN}}` placeholders. When you
assemble a subagent prompt for dispatch, replace each placeholder with
the **body** of the matching `###` block in
`skills/_shared/artifact-definitions.md` (the prose under the header,
not the header line) — the same substitution you already do for the
bracketed `[plan path]`-style values. The convention: `{{...}}` flags
a static block to inline; `[...]` flags a per-run value to fill.

Tokens used in this skill's dispatches:

- `{{CONCEPT-DEFINITION}}`, `{{CONCEPT-TEMPLATE}}`
- `{{STORY-DEFINITION}}`, `{{STORY-TEMPLATE}}`
- `{{DECISION-DEFINITION}}`, `{{DECISION-TEMPLATE}}`
- `{{ISSUE-DEFINITION}}`, `{{ISSUE-QUEUE-FORMAT}}`
- `{{SELF-CONTAINMENT-RULE}}`
- `{{CURRENT-STATE-ONLY-RULE}}`
- `{{PROOF-PROTECTION-RULE}}`

Multiple separately-dispatched subagents need these — the extractor
(which authors the docs), the extraction reviewer (which audits them),
the back-edge extractor (which mutates them). Each is its own dispatch
and sees only its own prompt, so defining the rules once in the shared
file and transcluding them keeps the wording from drifting between the
agent that writes and the agent that checks.

## Phase 1 — Discoverer Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Phase 1: As-Is Discovery

  ### Goal

  Read the codebase and the project's prose, and produce thorough
  as-is descriptions of every load-bearing piece of structure. Output
  goes to `.ok-planner/design/_discover/` as one file per topic.

  This is scaffolding, not the final artifact. Be wide and detailed.
  Redundancy is fine — phase 2 will merge.

  ### What you can read

  Everything. Source, tests, schemas, migrations, protos, build files,
  inline annotations, CLAUDE.md, READMEs, `docs/`, `cold-read/`,
  CHANGELOG, prior sprint backlogs under `.ok-planner/backlogs/`,
  archived material under `.ok-planner/history/` if present.

  Code is ground truth for what the system does. Prose is ground
  truth for what the project thinks the concepts mean. Capture both.
  When code and prose disagree, capture both versions — don't
  resolve. (Phase 2 will catalog the disagreement as an issue.)

  ### Existing scaffolding

  If `.ok-planner/design/_discover/` already contains files, those
  are from earlier runs (possibly from an earlier, narrower version
  of this skill that only read code). For each existing entry:
  - Re-read the source it cites.
  - Expand it with deeper code discussion (more file:line citations,
    more about how the structure interacts with neighbors, more
    explicit statement of invariants and boundaries).
  - Pull in prose sources that corroborate or contradict its claims.
  - Update the file format to match the per-entry template below
    (`Description / Code surface / Prose surface / Adjacent topics /
    Observations`). The legacy ADR template (Decision / Rationale /
    Consequences) is no longer used; replace it.
  - Do NOT delete or rename existing entries unless they describe
    something that turned out not to exist in the code.

  If the project clearly has structure that the existing `_discover/`
  set didn't cover, add new entries for it.

  ### Reviewer findings to address (cycle N)

  (This block is empty on the first run. On fix-loop cycles, it
  contains the reviewer's findings; address each one before
  reporting back. Do not consider yourself done while any reviewer
  finding remains unaddressed.)

  ### What to discover

  Each entry should describe one piece of load-bearing structure. The
  bar for "load-bearing" is: a reasonable engineer working on this
  codebase needs to know this exists and what it does. Concretely:

  - Concepts (nouns) the system traffics in: claim, frame, instance,
    template, node, executor, etc. For each, capture: definition,
    what it does, where it lives in code, what its boundaries are,
    what neighboring concepts it interacts with.
  - Invariants the code maintains — whether the project marks them
    with an annotation convention of its own, asserts them with a
    named test, or just enforces them without a label.
  - Cross-cutting disciplines: opacity rules, transaction shapes,
    error-handling patterns, naming conventions, layering rules
    enforced by lint configs.
  - Schema-level commitments visible in migrations: table layout,
    FK semantics, indexes, advisory locks.
  - Module / package boundaries and the rules that govern them.
  - Choices that are choices (one shape over an alternative), where
    the alternative is identifiable.
  - Negative choices: things the project deliberately does NOT do.
  - Aliases, deprecated names, transitional shims (these often
    become issues in phase 2).

  ### Per-entry template

  Write each entry to `.ok-planner/design/_discover/<slug>.md`
  (kebab-case, no date prefix — these are scaffolding, not dated
  decisions). Template:

  ```markdown
  ---
  topic: <slug>
  kind: concept | invariant | discipline | schema | boundary | choice | alias
  ---

  # <Topic title>

  ## Description

  <Several paragraphs of as-is description. What it is, what it
  does, why the project has it, where it lives in code, how it
  interacts with neighbors. Be thorough — this is the raw material
  phase 2 will work from. Multiple paragraphs is the norm, not the
  exception.>

  ## Code surface

  <Specific files / packages / line ranges where this thing is
  enforced or expressed. List liberally.>

  ## Prose surface

  <Where prose talks about this — CLAUDE.md sections, doc paths,
  backlog references. If code and prose disagree, note both with
  specific citations.>

  ## Adjacent topics

  <Other `_discover/` entries this one touches. Cross-reference
  liberally; phase 2 uses these to identify boundary issues.>

  ## Observations

  <Anything you noticed that didn't fit into Description but
  matters: aliases in use, vestigial bits, inconsistent
  spellings, places where the concept appears to be doing double
  duty, places where two parts of the code disagree about what
  this thing is, places where prose and code drift apart. These
  are issue candidates for phase 2 — do not classify them here,
  just record.>
  ```

  ### How to find structure

  - Read entry points first (`cmd/*`, `main.*`, `bin/*`).
  - Read every file already carrying an `@concept:` annotation;
    also any project-specific structured annotations in use (run
    a quick `grep` over the tree to surface what tagging vocabulary
    the codebase has, if any).
  - Read interface declarations in shared infrastructure.
  - Read schema migrations end to end.
  - Read CLAUDE.md, any `docs/concepts/` material, any `cold-read/`
    material.
  - Search comments and prose for "rationale", "intentionally",
    "deliberately", "must not", "do not", "by design", "we chose",
    "decision".

  ### Anti-padding

  - Don't write entries for trivial constants and one-line helpers.
  - Don't speculate about future direction. Record what IS.
  - Don't grade. Recording, not evaluating.
  - Don't merge concepts or resolve disagreements — phase 2 does
    that.

  ### Report

  When done, output a structured report:
  - Entries produced (new): file paths, one-line summaries.
  - Entries expanded (existing): file paths, what was added.
  - Areas surveyed but not written up (probably vanilla).
  - Reviewer findings addressed (if this was a fix cycle): list
    each finding and how it was addressed.
  - Anything notable you tripped over: contradictions, dead
    annotations, suspected-but-unverifiable invariants. Surface as
    observations.
```

## Phase 1 — Discovery Reviewer Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Phase 1 Review

  ### Your job

  Review the as-is discovery scaffolding under
  `.ok-planner/design/_discover/` for completeness, depth, and
  correctness. Produce a structured report: `Approved` or `Issues
  Found` with specifics. The producer will revise based on your
  findings; be specific enough that they can act.

  ### What to check

  - **Template conformance**: every file uses the current template
    (Description / Code surface / Prose surface / Adjacent topics /
    Observations). Legacy ADR-template entries (Decision / Rationale
    / Consequences) are issues — they need to be rewritten.
  - **Depth**: Description sections are substantive (multiple
    paragraphs), not one-liners. Code surface lists specific
    file:line citations. Prose surface is actually consulted, not
    skipped.
  - **Coverage**: every invariant the codebase carries — whether
    marked with a project-specific annotation, asserted with a named
    test, or enforced inline — has a corresponding `_discover/` entry
    or is folded into one. Every top-level interface in shared
    infrastructure packages has coverage. Every migration's
    structural intent is captured somewhere.
  - **Observations are concrete**: "this is an issue candidate"
    blurbs in the Observations section cite specific evidence
    (file:line or prose:section), not vague unease.
  - **Cross-references are real**: Adjacent topics name actual
    `_discover/` slugs, not invented ones.
  - **No resolution**: the discoverer must record disagreements
    between code and prose as observations, NOT resolve them.
    Resolving is the owner's territory, at the next sprint.
  - **No grading**: the discoverer must not say things like "this is
    bad" or "should be refactored". Recording, not evaluating.

  ### How to check

  - Walk every file in `.ok-planner/design/_discover/`.
  - Sample-verify a handful of file:line citations against the
    actual code — confirm they say what the discoverer claims.
  - If the project uses its own structured annotation vocabulary
    for invariants or contracts, cross-check coverage with a
    `git grep -l <tag>` per tag — every annotated site should map
    to an entry.
  - Walk the project's top-level package list and confirm any
    package with a non-trivial public interface has coverage.

  ### Report format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found, one entry per issue:)

  ### <file>: <one-line summary>
  <Specific actionable description. What is wrong. What needs to
  change. Where the missing content should live.>

  (if Approved:)

  (empty Findings section)

  ## Coverage summary

  - <bucket>: <count> entries
  - <bucket>: <count> entries
  - <areas with no coverage that the reviewer believes do not need
    coverage>: <list>
  ```

  ### Anti-padding

  - Don't manufacture issues. If the scaffolding is genuinely
    thorough, approve it.
  - Don't ask for unbounded perfection. The bar is "phase 2 can
    extract concepts from this without going back to read code
    itself" — not "every conceivable detail captured".
  - Don't review style. Sentence-level prose quality is not your
    job; structural and substantive completeness is.
```

## Phase 2 — Extractor Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Phase 2: Concept / Story / Decision Extraction & Issue Identification

  ### Goal

  Read the `_discover/` corpus and produce:
  1. One concept file per load-bearing noun, under
     `.ok-planner/design/concepts/`.
  2. One story file per user-observable outcome the running product
     already delivers, under `.ok-planner/design/stories/`.
  3. One decision file per technical choice the project has clearly
     made (one shape over an identifiable alternative), under
     `.ok-planner/design/decisions/`.
  4. One issue row appended to `.ok-planner/issues.jsonl` per case
     where the as-is design is sloppy, unspecified, unclear,
     overloaded, conflicting, or vestigial (append via Bash `>>`;
     `kind: "discover"`; fold the file first and skip ids already
     open).

  This is still as-is. Stories describe what the product does
  today; decisions describe what choices have been made. A
  decision's mandatory Proof field names the enforcing check that
  ALREADY exists (a lint rule, a dependency boundary, a test); if
  the choice has no enforcing check, write the decision without
  inventing one and file an issue (category `proof`) — the owner
  decides at the next sprint whether to make it enforceable. Do
  NOT propose resolutions to issues, do NOT invent stories the
  product does not yet deliver, and do NOT propose decisions the
  project has not yet made. Document the as-is; sprints evolve
  the model.

  ### Inputs

  - Every file under `.ok-planner/design/_discover/`. This is your
    primary source.
  - Code and prose only as needed to verify a citation.

  ### Reviewer findings to address (cycle N)

  (This block is empty on the first run. On fix-loop cycles, it
  contains the reviewer's findings; address each one before
  reporting back.)

  ### What is a concept?

  {{CONCEPT-DEFINITION}}

  ### Concept template

  {{CONCEPT-TEMPLATE}}

  ### Self-containment rule (concepts, stories, decisions)

  {{SELF-CONTAINMENT-RULE}}

  ### What is a story?

  {{STORY-DEFINITION}}

  ### Story template

  {{STORY-TEMPLATE}}

  ### What is a decision?

  {{DECISION-DEFINITION}}

  ### Decision template

  {{DECISION-TEMPLATE}}

  ### What is an issue?

  {{ISSUE-DEFINITION}}

  ### Issue queue format

  {{ISSUE-QUEUE-FORMAT}}

  ### Current-state-only rule

  {{CURRENT-STATE-ONLY-RULE}}

  ### Anti-padding

  - Don't manufacture issues. If a topic is clear in
    `_discover/`, the concept / story / decision file alone is
    enough.
  - Don't merge issues that share a category but are
    semantically separate. One issue row per genuine muddiness.
  - Don't grade severity.
  - Don't write more than one file for the same artifact (same
    concept, same story, same decision). Merge if you find
    duplicates.
  - Don't introduce code-path citations into concept, story, or
    decision bodies. The design owns the definition; code
    references it via `@concept:` / `@story:` / `@decision:`
    annotations. See the "Self-containment rule" above.
  - Don't introduce path or symbol citations into an issue's
    `candidates` entries — candidates become backlog text and must
    be stated as durable corpus mutations. See the issue queue
    format above.
  - Don't invent stories the product does not yet deliver, or
    decisions the project has not yet made. The phase 2 output
    is as-is.
  - Don't add a `## Notes`, `## History`, `## Changelog`, or
    any dated-audit-trail section to a concept, story, or
    decision. See the "Current-state-only rule" above.
  - Don't add forward-looking content ("we plan to", "will be
    replaced by", "TODO", "deferred", "open question for
    later"). Open ambiguities go in the issue queue.

  ### Report

  When done, output:
  - Concepts written: list of slugs.
  - Stories written: list of slugs.
  - Decisions written: list of slugs.
  - Issue rows appended, grouped by category.
  - `_discover/` entries that produced no artifact (folded into
    another, or noise — say which).
  - Reviewer findings addressed (if this was a fix cycle): list
    each finding and how it was addressed.
```

## Phase 2 — Extraction Reviewer Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Phase 2 Review

  ### Your job

  Review the concept, story, and decision catalogs and the issue
  rows produced by the extractor. Produce a structured report
  (`Approved` or `Issues Found`) AND, on your final pass (whether
  approved or capped), append your observations about the
  artifact's residual uncertainty to `.ok-planner/issues.jsonl`
  as open rows (`kind: "discover"`, category `other` unless a
  sharper one fits) — the human resolves them in a later sprint.

  ### What to check on concepts

  - **One concept per noun**: no duplicates across
    `concepts/<slug>.md`. If two files describe the same thing,
    flag as an issue (extractor must merge).
  - **Definition stands alone**: the What-it-is paragraph is
    intelligible without consulting code or `_discover/`.
  - **Boundaries name neighbors**: every concept either lists
    `see also:` neighbors or explains why it has none.
  - **Invariants are stated as properties**: not "the code at X
    does Y" but "this concept holds property Y, enforced by
    annotation Z".
  - **Aliases listed**: every alias surfaced in `_discover/` that
    actually appears in current code or prose is either listed
    here or has its own concept (if it actually refers to
    something else). Aliases that no longer appear anywhere live
    must not be listed — see the "Current-state-only rule"
    above.
  - **Open items are issues, not concept-body sections**:
    anything the as-is design leaves unresolved about this
    concept goes in the issue queue, not in a forward-looking
    section of the concept body. If the extractor wrote an
    "Open within this concept" or similar section into a concept
    file, flag it.
  - **Concept body is current-state only**: no `## Notes` /
    `## History` / `## Changelog` section, no dated audit-trail
    entries, no "previously called X" / "used to be Y" /
    "changed per spec Z" lines, no forward-looking "TODO" /
    "deferred" / "will be replaced" content. Lineage lives in
    git; open items live in the issue queue. See the
    "Current-state-only rule" under "Rules being enforced" below.
  - **Concept body is self-contained**: audit every concept body
    against the self-containment rule reproduced under "Rules
    being enforced" below. Pre-existing violations (in concept
    files the current extraction didn't author) are still issues
    — flag every one you find.

  ### What to check on stories

  - **One story per user-observable outcome**: no duplicates. Two
    stories that describe the same outcome through different
    surfaces are still one story (the surface is a technical
    decision, captured in `decisions/`, not story content).
  - **Story line is a non-prescription with a mandatory "so
    that"**: the `## Story` line reads `As <role>, I want
    <capability>, so that <benefit>` with a substantive benefit
    clause; a missing or circular "so that" is a finding, and a
    body that prescribes mechanism is a finding.
  - **As-is, not aspirational**: each story names a capability
    the running product already delivers, observable by driving
    the running product. A story for a feature the product does
    not yet ship is a finding — the extractor must drop it.
  - **Acceptance is user-observable and non-prescriptive**: a
    user action described in user terms producing a real
    observable outcome, with the value-delivering component named
    and not stubbed. Reject acceptance that pins a specific
    delivery surface (a particular HTTP route, CLI verb, wire
    format, job schedule, or UI element) — those are decisions,
    not story content.
  - **Falsifier is concrete and user-observable**: names a
    specific user-observable absence a reviewer could point at —
    the user takes the action and the result never appears, the
    result is unrelated to the input, or the underlying state is
    synthetic (a stubbed value-delivering component).
  - **Proof form named**: the Proof line specifies a form
    (demo / example / proof / all) and what it must exhibit.
  - **Story body is current-state only**: no `## Notes` /
    `## History` / `## Changelog` section, no dated audit-trail
    entries, no backward- or forward-looking phrasing. See the
    "Current-state-only rule" under "Rules being enforced" below.
  - **Story body is self-contained**: audit against the
    self-containment rule. No file paths or code citations in
    the body. Pre-existing violations are still issues.

  ### What to check on decisions

  - **One decision per choice**: no duplicates. Lumped items
    ("we chose X for persistence and Y for messaging") must be
    split into atomic decisions.
  - **As-is, not aspirational**: each decision names a choice
    the project has clearly made — visible in code, comments,
    or commit history. A decision the project has not yet made
    is a finding (it would be an issue row or simply absent).
  - **Choice is explicit**: the Choice section names the option
    adopted, concrete and unambiguous.
  - **Rationale present and sourced**: not "because we said so"
    — the rationale is sourced from code/comments/ADRs, or
    explicitly notes that it is the most plausible reading of
    the code's shape. A genuinely unclear rationale is an issue
    row, not a fabricated reason.
  - **Alternatives listed**: at least one identifiable
    alternative is named (otherwise the choice isn't a choice
    — it's the only option, and not worth recording).
  - **Proof present and honest**: the Proof section names an
    enforcing check that already exists (lint rule, dependency
    boundary, test, config assertion). A Proof that invents a
    check that doesn't exist is a finding; a decision with no
    existing enforcing check must instead have a corresponding
    issue row (category `proof`) — verify it does.
  - **Decision body is current-state only**: no `## Notes` /
    `## History` / `## Changelog` section, no dated audit-trail
    entries, no backward- or forward-looking phrasing. See the
    "Current-state-only rule" under "Rules being enforced"
    below. (Alternatives is the list
    of options the project *could* have taken — that's not
    forward-looking; it's the as-is shape of the choice. But
    "we may switch to alternative X" or "the chosen option was
    formerly Y" violates the rule.)
  - **Decision body is self-contained**: audit against the
    self-containment rule. No file paths or code citations in
    the body. Pre-existing violations are still issues.

  ### What to check on issue rows (this run's appends)

  - **Rows parse and follow the queue format**: valid JSON, one
    per line, `event: "open"`, `kind: "discover"`, required
    fields present, `id` a stable fingerprint (no line numbers,
    no dates).
  - **Category is correct**: an `overloaded` issue actually
    describes one name meaning multiple things; an
    `inconsistent` issue actually describes one thing
    implemented two ways; etc.
  - **Detail is specific**: quotes files, lines, or `_discover/`
    entries — not "somewhere in the codebase".
  - **`candidates` lists actual shapes, path-free**: concrete
    resolution shapes stated as durable corpus mutations (which
    artifact's sections would change), never file/symbol
    citations, never "decide what to do".
  - **No resolutions slipped in**: the extractor must not have
    picked a winning candidate or graded the options.
  - **No vague unease issues**: each issue is something the
    owner could resolve in a sitting. "The codebase feels
    complex" is not an issue.
  - **No duplicates**: no two open rows (including pre-existing
    open ids) describe the same muddiness.

  ### Rules being enforced

  The checks above hold against these. This reviewer runs as its
  own dispatch and does not see the extractor prompt, so the rules
  are reproduced here in full.

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  {{ISSUE-QUEUE-FORMAT}}

  ### Cross-check

  - **Every `concept.aliases` alias actually appears in current
    code or prose.** Aliases are a list of live names — not
    retired names, not historical names. If an alias does not
    appear anywhere live, drop it from the list. If multiple
    live names point at the same concept and the project
    should converge, that is an issue — verify a corresponding
    open row exists rather than convergence intent recorded in
    the concept body.
  - **Every code annotation cited in `_discover/` lands somewhere**
    in either `concepts/` (as an invariant) or the issue queue (as
    vestigial / inconsistent).
  - **`_discover/` entries are reflected**: each entry should be
    either folded into a concept or noted as deliberately not
    promoted (in the extractor's report — verify the report
    accounts for them all).

  ### Final-pass uncertainty filing

  On your final review (whether you approved or the loop was
  capped), append the artifact's residual uncertainty to
  `.ok-planner/issues.jsonl` as open rows (`kind: "discover"`;
  fold first, skip ids already open; append via Bash `>>`).
  Distinct from the muddiness issues the extractor filed — these
  are about the extracted artifacts themselves, not the codebase:

  - **Judgment calls made by the extractor** the human should
    sanity-check (what was decided, what the alternative was).
  - **Suspected-but-unconfirmed concepts**: nouns that might be
    load-bearing but weren't certain enough to promote.
  - **Concepts merged that might want splitting** (and vice
    versa).
  - **Unresolved findings** (when the fix loop was capped at 3
    cycles).

  Use category `other` unless a sharper category fits; put the
  decide-this question in `summary` and the specifics in
  `detail`.

  ### Thin discovery requests (back-edge input)

  Thin-discovery areas do NOT go to the issue queue while the
  back-edge can still address them. Use a structured block at
  the bottom of your
  report when you can identify specific code areas the discoverer
  missed and that, if expanded, would let the extractor produce a
  meaningfully sharper concept. The skill consumes this block to
  drive the one-shot back-edge (focused re-discovery + re-extraction
  + re-review).

  Include only items that meet ALL of these:
  - You can name a specific code directory or files the discoverer
    should re-read.
  - You can name the affected concept slug(s) (existing or new).
  - You can state what the thin material is preventing the concept
    from saying clearly.
  - The fix is "read more code", not "make a design decision". (If
    the fix is "make a design decision", it's an issue row, not a
    thin discovery request.)

  Do NOT use this block for findings the fix loop already
  addressed, for findings that are really owner-judgment issues,
  or for general "could be deeper" wishes.

  Format:

  ```markdown
  ## Thin discovery requests

  ### <affected-concept-slug>
  - Scope: <code paths to re-read, e.g. `modeling/qualityrule/eval/`>
  - Missing: <one sentence stating what the concept can't currently say>
  - Promote new concept: <name | none>
  ```

  Omit the block entirely if no requests apply.

  ### Report format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found:)

  ### <file>: <one-line summary>
  <Specific actionable description.>

  (if Approved:)

  (empty Findings section)

  ## Catalog summary

  - Concepts: <count>
  - Issue rows appended, by category:
    - overloaded: <count>
    - unspecified: <count>
    - …
  - Thin discovery requests: <count>

  ## Thin discovery requests

  (Structured block per the format above. Omit if empty.)
  ```

  ### Anti-padding

  - Don't manufacture issues for an already-clean catalog.
  - Don't review the prose-quality of definitions — only that they
    stand alone and are correct.
  - Don't ask the extractor to make resolution calls (it shouldn't,
    and you shouldn't either).
  - Don't manufacture thin-discovery requests. If a concept is
    genuinely shallow because the thing it describes is shallow,
    don't ask for more code-reading. The bar is: "more discovery
    would meaningfully change what this concept says".
  - If the fix is "make a design decision", it's an issue row,
    not a thin discovery request.
```

## Back-Edge — Focused Discoverer Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Back-Edge: Focused Re-Discovery

  ### Goal

  Phase 2 review identified specific areas where `_discover/`
  material is too thin to support a real concept. Your job is to
  expand the `_discover/` entries for ONLY the listed areas. Read
  the named code paths, then update the named entries with deeper
  discussion. If a request explicitly authorizes promoting a new
  `_discover/` entry, add it.

  This is scoped re-discovery — NOT a full re-pass. Do not touch
  other `_discover/` entries. Do not survey the codebase broadly.

  ### Thin discovery requests

  (Filled in by the skill orchestrator from the phase 2 reviewer's
  `## Thin discovery requests` block. Each entry names:
  - Affected concept slug(s)
  - Scope: code paths to re-read
  - Missing: what the concept can't currently say
  - Promote new concept: name | none)

  ### What to read

  Only the code paths named in the thin discovery requests. You may
  follow imports / call sites within those paths. Do not read prose
  surfaces unless they directly explain the named code area.

  ### What to write

  For each request:
  - Identify the `_discover/<slug>.md` entry that backs the
    affected concept. There may be more than one. If there is none,
    that's a signal to either (a) add a new entry under a slug the
    request implies, or (b) report back that no entry exists and
    one needs to be created.
  - Expand the entry's Description with the missing material.
    Specifically address what the request says the concept can't
    currently say. Add file:line citations to the Code surface.
  - Update Observations with any new issue candidates surfaced
    by the deeper read.

  Do NOT change the entry's `topic` or `kind` frontmatter.
  Do NOT touch entries that are not named in any request.

  ### Per-entry template

  Same as the phase 1 template (Description / Code surface / Prose
  surface / Adjacent topics / Observations). Your edits keep that
  shape.

  ### Anti-padding

  - Stay in the requested scope. If you notice unrelated
    interesting structure during this pass, leave it alone — it
    can be picked up by a future full `/discover-design` run.
  - Don't grade.
  - Don't resolve disagreements.

  ### Report

  Output a short structured report:
  - For each request: which `_discover/` entry was expanded (or
    created); a one-line summary of the new material.
  - Any request you could not address (and why).
  - New observations recorded that may become issues.

  Keep under 400 words.
```

## Back-Edge — Focused Extractor Subagent Prompt

```
Agent (general-purpose):
  ## Discover-Design Back-Edge: Focused Re-Extraction

  ### Goal

  The focused discoverer just expanded specific `_discover/`
  entries. Update the affected `concepts/`, `stories/`, and
  `decisions/` files to reflect the new material, and append
  issue rows surfaced by the expansion. Add new artifact files
  (`concepts/<slug>.md`, `stories/<slug>.md`,
  `decisions/<slug>.md`) ONLY when the original thin discovery
  request explicitly authorized "Promote new artifact".

  ### Thin discovery requests

  (Filled in by the orchestrator. Each request names the affected
  artifact kind (concept / story / decision), its slug, the
  discoverer's expansion summary, and whether a new artifact may
  be promoted.)

  ### What to do per request

  - Re-read the affected artifact file (`concepts/<slug>.md`,
    `stories/<slug>.md`, or `decisions/<slug>.md`) and the
    now-expanded `_discover/<slug>.md` entry/entries.
  - Edit the artifact file in place to incorporate the new
    material:
    - **Concept**: update `What it is`, `Purpose`, `Boundaries`,
      and `Invariants` to reflect what the request flagged as
      missing.
    - **Story**: update `Story`, `Acceptance`, `Falsifier`, or
      `Proof` to reflect what the deeper read revealed about the
      observable outcome.
    - **Decision**: update `Choice`, `Rationale`,
      `Alternatives`, or `Proof` to reflect what the deeper
      read revealed about the choice's shape, motivation, or
      enforcement.
  - If the request authorizes promoting a new artifact, create
    the file per the standard template for that kind (concept /
    story / decision). For concepts, update neighboring concepts'
    `see also:` / Adjacent references.
  - If the deeper material surfaces a new issue, append an open
    row to `.ok-planner/issues.jsonl` per the queue format
    (`kind: "discover"`; fold first, skip open ids).

  Do NOT touch artifact files unrelated to the affected slugs.
  Do NOT add new artifacts that weren't authorized.

  ### Artifact templates

  When creating a new artifact file (only when explicitly
  authorized by the request), use the matching template:

  {{CONCEPT-TEMPLATE}}

  {{STORY-TEMPLATE}}

  {{DECISION-TEMPLATE}}

  {{ISSUE-QUEUE-FORMAT}}

  ### Rules for the docs you touch

  Concept, story, and decision bodies you edit or create must
  follow these. This step runs as its own dispatch, so the rules
  are reproduced here in full.

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### Anti-padding

  - Stay in scope.
  - Don't merge or split unrelated concepts.
  - Don't grade.
  - Don't propose resolutions in the issue rows you append.

  ### Report

  Output a short structured report:
  - For each request: which concept file was updated, what new
    material was incorporated (one line).
  - New concepts added (with slug + one-line summary).
  - New issue rows appended (with id + category + one-line summary).

  Keep under 300 words.
```

## The `@concept:`, `@story:`, `@decision:` annotation convention

The design docs are the canonical source for what each artifact
means. Code references the design via in-source annotations:

- `@concept: <slug>` — load-bearing site where a concept is
  enforced or expressed
- `@story: <slug>` — load-bearing site for delivering a story's
  user-observable outcome (the wired entry point, the handler that
  produces the observable effect, the value-delivering component)
- `@decision: <slug>` — site that embodies a technical decision
  (the persistence call, the registration mechanism, the chosen
  cadence)

Each annotation marks a load-bearing site, not every file that
happens to touch the artifact. If the project already runs its own
structured annotation vocabulary for other purposes, these three
sit alongside it; ok-planner has no opinion on that vocabulary.

Two artifacts together replace the need for an external index:

- **`.ok-planner/design/concepts.md`** (and `stories.md`,
  `decisions.md`) — auto-generated summaries (this skill produces
  them). Agents read them in one shot at the top of any skill that
  reads the design docs to know what artifacts exist.
- **Annotations in source** — discoverable by
  `rg '@(concept|story|decision): <slug>'`. Answers both "which
  artifacts apply to this file?" (read the file) and "where is
  artifact X load-bearing?" (grep across the repo).

Annotation rollout is incremental: any time an agent consults an
artifact to understand or modify a file, it leaves the annotation
at the most-specific load-bearing site so the next agent doesn't
have to re-do the lookup. This rule is documented in
`.ok-planner/CLAUDE.md` (written by `ok-planner:true-up`) so it
applies project-wide regardless of which skill is active. No bulk
greenfield annotation pass is needed.

## Re-run discipline

The skill is idempotent on `_discover/`: re-running deepens existing
entries and adds new ones.

The skill refuses to re-run when `concepts/`, `stories/`, or
`decisions/` are non-empty, because they may contain human-approved
content from sprint deltas. To force a full rebuild, the user must
delete the non-empty durable directories first (preserving
`_discover/` if they want phase 1 to be incremental). After
refinement, the design model stays aligned with the code through
sprint backlogs, whose corpus deltas change docs and code as one unit.

## What this skill does NOT do

- Doesn't prompt the user mid-run. The only user-visible output during
  execution is the final summary.
- Doesn't propose resolutions to issues. Resolution is the owner's
  act, in `/sprint`.
- Doesn't write the prescriptive "as it should be" design. The outputs
  are as-is. The prescriptive version emerges when `/sprint` packages
  issue resolutions into a backlog's corpus deltas and whoever
  executes that backlog applies them.
- Doesn't grade implementations or call out defects in the code. The
  design describes what the project is and where it's muddy. Defects
  are found by the review skills.
- Doesn't introduce code annotations (`@concept:` etc.). That's a
  separate convention introduced after the prescriptive design is
  stable.
- Doesn't overwrite human-edited `concepts/`, `stories/`, or
  `decisions/`. Aborts rather than risk data loss.
- Doesn't edit or remove existing issue rows. Append-only, open
  events only.
