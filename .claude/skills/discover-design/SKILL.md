---
name: discover-design
description: "ONLY activated by explicit /discover-design slash command. Never auto-triggered by conversation content. Autonomous two-phase bootstrap of the design corpus: as-is discovery scaffolding, then extraction of the concept, story, and decision catalogs, filing judgment questions to the issue intake; aborts rather than overwrite human-edited artifacts."
---

# Discover Design

Two-phase autonomous pass that produces (1) a thorough as-is description of the project's design — the load-bearing concepts and how the code embodies them — and (2) a catalog of where the as-is design is sloppy, unspecified, unclear, overloaded, or in conflict with itself.

The run is end-to-end, with no user prompts; the final report is the only thing the user sees. Each phase runs a produce → review → fix loop. Judgment questions the run surfaces — ambiguities in the as-is design, the run's own confessed uncertainty — become issue files under `.ok-planner/issues/`; `/verify-issues` makes each ruling-ready, and sprints close them.

The corpus this skill bootstraps is the project's durable identity: concepts (load-bearing nouns), stories (durable user expectations), decisions (technical tradeoffs), plus the issue intake. `../_shared/artifact-definitions.md` defines all four and the "what design means" framing. Code references the corpus via `@concept:` / `@story:` / `@decision:` annotations; the corpus owns the definitions. Discrepancies between code and prose are issues to record, never to resolve.

## Inputs

Read everything the project allows. Code is ground truth for what the system does; prose (CLAUDE.md, READMEs, `docs/`, CHANGELOG, prior sprints, sketches) is ground truth for what the project thinks the concepts mean.

## When to invoke

- A project without `.ok-planner/design/concepts/`.
- A project with `_discover/` scaffolding from a prior run: phase 1 expands it, phase 2 runs against the expanded set.
- After architectural work that changed the concept surface, only while no sprint has produced human-approved artifacts. Once refined artifacts exist, the skill aborts rather than overwrite them; sprints keep the corpus aligned from then on.

## Where the output lives

```
.ok-planner/design/
  _discover/        — phase 1 scaffolding (raw thorough descriptions)
  concepts/         — phase 2 concept docs (one per file)
  stories/          — phase 2 story docs (one per file)
  decisions/        — phase 2 decision docs (one per file)
.ok-planner/issues/ — open questions for the owner (one file each)
```

`_discover/` is scaffolding: wide, detailed, redundancy allowed — the trail of what was observed. The three catalogs are the durable outputs, still as-is, never prescriptive. Issue files this skill writes carry `kind: "discover"` and `status: open`. Two flavors share the intake: muddiness in the codebase (the ordinary categories) and the run's confessed uncertainty about the extracted artifacts (category `other` unless a sharper one fits).

## Process

Each phase loops producer → reviewer → producer-with-feedback, capped at 3 review cycles (initial + 2 fix passes). Findings still open at the cap become issue files (`kind: "discover"`, `status: open`). After phase 2, one back-edge may run: a focused re-discovery of areas the phase 2 reviewer named as too thin, then re-extraction and re-review of the affected artifacts only.

1. Run `mkdir -p .ok-planner/sprints .ok-planner/sketches .ok-planner/issues .ok-planner/history/sprints .ok-planner/history/sketches .ok-planner/history/issues`.
2. Create `.ok-planner/design/_discover/`, `concepts/`, `stories/`, and `decisions/` if absent.
3. Detect state:
   - Empty `_discover/` → phase 1 starts from scratch.
   - Non-empty `_discover/` → phase 1 expands existing entries and adds new ones.
   - Non-empty `concepts/`, `stories/`, or `decisions/` → abort. Tell the user to delete the non-empty durable directories for a full rerun (keeping `_discover/` makes phase 1 incremental). Never overwrite human-edited artifacts.
4. **Phase 1 (Discovery):**
   a. Dispatch the discoverer (Phase 1 Discoverer Prompt). It writes and expands `_discover/<slug>.md`.
   b. Dispatch the reviewer (Phase 1 Reviewer Prompt): `Approved | Issues Found` with specifics.
   c. On `Issues Found`, re-dispatch the discoverer with the findings prepended as `### Reviewer findings to address (cycle N)`; loop to (b). Cap at 3 cycles.
   d. Findings still open at the cap → issue files.
5. **Phase 2 (Extraction):**
   a. Dispatch the extractor (Phase 2 Extractor Prompt). It writes the three catalogs and files an issue per genuine muddiness.
   b. Dispatch the reviewer (Phase 2 Reviewer Prompt). On its final pass it also files its confessed-uncertainty issues, and its report may carry a `## Thin discovery requests` block.
   c. Same fix loop, capped at 3 cycles.
   d. Findings still open at the cap → issue files.
6. **Back-edge (one per invocation).** If the phase 2 reviewer's latest report carries non-empty thin discovery requests and no back-edge has run:
   a. Dispatch the focused discoverer (Back-Edge Discoverer Prompt) with the requests. It expands only the named `_discover/` entries.
   b. Dispatch the focused extractor (Back-Edge Extractor Prompt). It updates the affected artifacts in place, files issues the new material surfaces, and adds new artifacts only where a request authorizes one.
   c. Dispatch the phase 2 reviewer once more, scoped to the affected artifacts. Further thin-discovery needs become issue files; the back-edge never loops.
7. **Regenerate the catalog TOCs.** For each of `concepts/`, `stories/`, `decisions/`, read every file and write the TOC beside it: `concepts/` → `concepts.md` (slug, optional aliases, first sentence of `## What it is`), `stories/` → `stories.md` (one line from the `As … I want …` statement), `decisions/` → `decisions.md` (one line from the Choice). The TOCs let skills know what artifacts exist without reading every body. Format, same shape for all three:

   ```markdown
   # <Concept|Story|Decision> catalog (auto-generated)

   Read first. Then either grep for the matching annotation
   (`@concept:` / `@story:` / `@decision:`) in the code under
   review, or read `<dir>/<slug>.md` for the full body. Generated
   by `discover-design` and refreshed whenever a sprint's
   deltas touch the catalog. Do not edit by hand — changes will
   be overwritten.

   ## <Concepts|Stories|Decisions>

   - `<slug>` — <one-sentence summary, ≤120 chars>
   - `<slug>` (aliases: <comma-list>) — <one-sentence summary>
   ```

   Sort alphabetically by slug. Omit `(aliases: ...)` when there are none.
8. **Final report:** counts of `_discover/` entries, concepts, stories, decisions, and issue files by category; whether a back-edge ran; and the next step — `/verify-issues` to make the intake ruling-ready, then `/plan-sprint` (a freshly discovered intake is usually worth its own session).

## Shared rule blocks (transclude into dispatches)

The prompts below carry `{{TOKEN}}` placeholders. Replace each with the body of the matching `###` block in `../_shared/artifact-definitions.md` (the prose, not the heading); `[...]` marks a per-run value. Each subagent is its own dispatch and sees only its own prompt, so the shared blocks travel into every prompt that needs them.

Tokens used:

- `{{CONCEPT-DEFINITION}}`, `{{CONCEPT-TEMPLATE}}`
- `{{STORY-DEFINITION}}`, `{{STORY-TEMPLATE}}`
- `{{DECISION-DEFINITION}}`, `{{DECISION-TEMPLATE}}`
- `{{ISSUE-DEFINITION}}`, `{{ISSUE-FILE-FORMAT}}`
- `{{SELF-CONTAINMENT-RULE}}`
- `{{CURRENT-STATE-ONLY-RULE}}`
- `{{LEAF-AGENT-RULE}}`, `{{DISPATCH-DISCIPLINE}}` — from `../_shared/dispatch-discipline.md`

## Phase 1 — Discoverer Subagent Prompt

```
Agent (general-purpose, model: sonnet):
  ## Discover-Design Phase 1: As-Is Discovery

  {{DISPATCH-DISCIPLINE}}

  ### Goal

  Read the codebase and the project's prose, and write a thorough
  as-is description of every load-bearing piece of structure to
  `.ok-planner/design/_discover/`, one file per topic. This is
  scaffolding, not the final artifact: be wide and detailed;
  redundancy is fine — phase 2 merges.

  ### What you can read

  Everything: source, tests, schemas, migrations, protos, build
  files, inline annotations, CLAUDE.md, READMEs, `docs/`,
  CHANGELOG, prior sprints under `.ok-planner/sprints/`, archived
  material under `.ok-planner/history/`. Code is ground truth for
  what the system does; prose for what the project thinks the
  concepts mean. When they disagree, capture both versions; phase 2
  catalogs the disagreement as an issue.

  ### Existing scaffolding

  Files already under `_discover/` are from earlier runs. For each:
  - Re-read the source it cites.
  - Expand it: more file:line citations, more on how the structure
    interacts with neighbors, explicit invariants and boundaries.
  - Pull in prose sources that corroborate or contradict it.
  - Bring it to the per-entry template below. The legacy ADR
    template (Decision / Rationale / Consequences) is replaced.
  - Keep every entry unless it describes something that does not
    exist in the code.

  Add new entries for structure the existing set does not cover.

  ### Reviewer findings to address (cycle N)

  (Empty on the first run. On fix cycles it carries the reviewer's
  findings; address every one before reporting back.)

  ### What to discover

  One entry per piece of load-bearing structure — something a
  reasonable engineer working here needs to know exists:

  - Concepts (nouns) the system traffics in: definition, behavior,
    where it lives, boundaries, neighbors.
  - Invariants the code maintains, however marked or unmarked.
  - Cross-cutting disciplines: opacity rules, transaction shapes,
    error-handling patterns, naming conventions, layering rules.
  - Schema-level commitments visible in migrations.
  - Module and package boundaries and their rules.
  - Choices with an identifiable alternative.
  - Negative choices: what the project deliberately does not do.
  - Aliases, deprecated names, transitional shims.

  ### Per-entry template

  Write each entry to `.ok-planner/design/_discover/<slug>.md`
  (kebab-case, no date prefix):

  ```markdown
  ---
  topic: <slug>
  kind: concept | invariant | discipline | schema | boundary | choice | alias
  ---

  # <Topic title>

  ## Description

  <Several paragraphs of as-is description: what it is, what it
  does, why the project has it, where it lives, how it interacts
  with neighbors. This is phase 2's raw material.>

  ## Code surface

  <Files / packages / line ranges where this is enforced or
  expressed. List liberally.>

  ## Prose surface

  <Where prose discusses this. Where code and prose disagree, note
  both with citations.>

  ## Adjacent topics

  <Other `_discover/` entries this one touches. Cross-reference
  liberally; phase 2 uses these to find boundary issues.>

  ## Observations

  <Issue candidates: aliases in use, vestigial bits, inconsistent
  spellings, double-duty concepts, code-vs-code or code-vs-prose
  disagreements. Record; do not classify.>
  ```

  ### How to find structure

  - Read entry points first (`cmd/*`, `main.*`, `bin/*`).
  - Read every file carrying an `@concept:` annotation, and grep
    for whatever tagging vocabulary the codebase uses.
  - Read interface declarations in shared infrastructure.
  - Read schema migrations end to end.
  - Read CLAUDE.md and any `docs/concepts/` material.
  - Search comments and prose for "rationale", "intentionally",
    "deliberately", "must not", "by design", "we chose",
    "decision".

  ### Anti-padding

  - No entries for trivial constants and one-line helpers.
  - Record what is; never speculate about future direction.
  - Record, do not evaluate.
  - Do not merge concepts or resolve disagreements — phase 2 does.

  ### Report

  - Entries produced (new): paths, one-line summaries.
  - Entries expanded: paths, what was added.
  - Areas surveyed but not written up.
  - Reviewer findings addressed (on a fix cycle): each finding and
    how.
  - Contradictions, dead annotations, suspected-but-unverifiable
    invariants — as observations.
```

## Phase 1 — Discovery Reviewer Subagent Prompt

```
Agent (general-purpose, model: sonnet):
  ## Discover-Design Phase 1 Review

  {{LEAF-AGENT-RULE}}

  ### Your job

  Review the scaffolding under `.ok-planner/design/_discover/` for
  completeness, depth, and correctness. Report `Approved` or
  `Issues Found` with specifics the producer can act on.

  ### What to check

  - **Template conformance**: every file uses the current template
    (Description / Code surface / Prose surface / Adjacent topics /
    Observations). A legacy ADR-template entry is a finding.
  - **Depth**: Descriptions are multiple paragraphs; Code surface
    lists file:line citations; Prose surface was consulted.
  - **Coverage**: every invariant the codebase carries has an
    entry or is folded into one; every top-level interface in
    shared infrastructure and every migration's structural intent
    is covered.
  - **Observations are concrete**: each cites file:line or
    prose:section evidence.
  - **Cross-references are real**: Adjacent topics name actual
    `_discover/` slugs.
  - **No resolution**: code-vs-prose disagreements are recorded,
    never resolved.
  - **No grading**: no "this is bad" or "should be refactored".

  ### How to check

  - Walk every file under `_discover/`.
  - Sample-verify file:line citations against the code.
  - Where the project uses a structured annotation vocabulary,
    cross-check coverage with `git grep -l <tag>` per tag.
  - Walk the top-level package list; confirm any package with a
    non-trivial public interface has coverage.

  ### Report format

  ```
  Status: Approved | Issues Found

  ## Findings

  (if Issues Found, one entry per issue:)

  ### <file>: <one-line summary>
  <What is wrong, what changes, where the missing content lives.>

  (if Approved:)

  (empty Findings section)

  ## Coverage summary

  - <bucket>: <count> entries
  - <areas with no coverage that need none>: <list>
  ```

  ### Anti-padding

  - Approve genuinely thorough scaffolding; manufacture nothing.
  - The bar is "phase 2 can extract concepts without reading code
    itself", not every conceivable detail.
  - Review structure and substance, not prose style.
```

## Phase 2 — Extractor Subagent Prompt

```
Agent (general-purpose, model: opus):
  ## Discover-Design Phase 2: Extraction & Issue Identification

  {{LEAF-AGENT-RULE}}

  ### Goal

  Read the `_discover/` corpus and produce:
  1. One concept file per load-bearing noun, under
     `.ok-planner/design/concepts/`.
  2. One story file per user-observable outcome the running
     product already delivers, under `.ok-planner/design/stories/`.
  3. One decision file per technical choice the project has made,
     under `.ok-planner/design/decisions/`.
  4. One issue file under `.ok-planner/issues/` per genuine
     muddiness (`kind: "discover"`, `status: open`, per the issue
     file format below; check the slugs already present and file
     only new ones).

  Everything is as-is: stories describe what the product does
  today; decisions describe choices made. Neither carries a
  verification or acceptance section — a story is its `## Story`
  statement alone; a decision is Choice, Rationale, Alternatives.
  The periodic audit verifies both. Never write a `## Proof`
  section, and never file an issue because a decision lacks an
  enforcing check — an unenforced Choice is what its audit will
  report. Do not propose resolutions, invent stories the product
  does not deliver, or propose decisions the project has not made.

  ### Inputs

  Every file under `.ok-planner/design/_discover/` (primary), and
  code or prose only to verify a citation.

  ### Reviewer findings to address (cycle N)

  (Empty on the first run. On fix cycles it carries the reviewer's
  findings; address every one before reporting back.)

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

  ### Issue file format

  {{ISSUE-FILE-FORMAT}}

  ### Current-state-only rule

  {{CURRENT-STATE-ONLY-RULE}}

  ### Anti-padding

  - File no issue a `_discover/` topic already makes clear.
  - One issue file per genuine muddiness; do not merge issues
    that share only a category.
  - Do not grade severity.
  - One file per artifact; merge duplicates.
  - No code-path citations in artifact bodies (self-containment
    rule above), and no path or symbol citations in an issue's
    Candidates (issue file format above).
  - No `## Notes` / `## History` / `## Changelog` sections and no
    forward-looking content (current-state-only rule above).

  ### Report

  - Concepts, stories, decisions written: slugs.
  - Issue files written, by category.
  - `_discover/` entries that produced no artifact (folded or
    noise — say which).
  - Reviewer findings addressed (on a fix cycle): each finding and
    how.
```

## Phase 2 — Extraction Reviewer Subagent Prompt

```
Agent (general-purpose, model: sonnet):
  ## Discover-Design Phase 2 Review

  {{LEAF-AGENT-RULE}}

  ### Your job

  Review the three catalogs and the issue files the extractor
  produced. Report `Approved` or `Issues Found`. On your final
  pass — approved or capped — also file your residual-uncertainty
  observations as issue files under `.ok-planner/issues/`
  (`kind: "discover"`, `status: open`, category `other` unless a
  sharper one fits).

  ### What to check on concepts

  - **One concept per noun**: two files describing the same thing
    is a finding (the extractor merges).
  - **Definition stands alone**: intelligible without code or
    `_discover/`.
  - **Boundaries name neighbors**: `see also:` neighbors listed,
    or the absence explained.
  - **The body defines and nothing more**: `What it is`,
    `Purpose`, `Boundaries`, optionally `Aliases`. An
    `## Invariants` section, or any other section, is a finding. A
    sentence stating a requirement, a prohibition, a guarantee, a
    mechanism, a constant, a command, or an instance is a finding;
    it goes, or it moves to the decision or the story that owns it.
  - **Aliases are live**: every alias surfaced in `_discover/`
    that appears in current code or prose is listed or has its own
    concept; a name no longer live anywhere is dropped.
  - **Open items are issues**: an "Open within this concept"
    section or similar is a finding.
  - **Current-state only** and **self-contained**, per the rules
    reproduced below. Pre-existing violations are still findings.

  ### What to check on stories

  - **One story per user-observable outcome**: two stories with
    one outcome through different surfaces are one story.
  - **The story line is** `As <role>, I want <capability>, so that
    <benefit>` with a substantive benefit; a missing or circular
    "so that" is a finding, and a body prescribing mechanism is a
    finding.
  - **As-is**: each story names a capability the running product
    delivers. A story for an unshipped feature is a finding.
  - **The statement alone**: any other section is a finding, and
    a story pinning a delivery surface (route, CLI verb, wire
    format, schedule, UI element) is a finding — surfaces are
    decisions.
  - **Current-state only** and **self-contained**, per the rules
    below.

  ### What to check on decisions

  - **One decision per choice**: lumped choices split.
  - **As-is**: each decision is visible in code, comments, or
    commit history.
  - **Choice explicit**: concrete and unambiguous.
  - **Rationale sourced**: from code, comments, or ADRs, or noted
    as the most plausible reading of the code's shape. A genuinely
    unclear rationale is an issue file, never fabricated.
  - **Alternatives real**: at least one identifiable alternative,
    else it is a default, not a decision.
  - **No verification section**: a `## Proof` section is a
    finding, and so is an issue filed because a decision lacks an
    enforcing check.
  - **Current-state only** (Alternatives lists options the project
    could have taken — that is the choice's shape, not
    forward-looking; "we may switch to X" is) and
    **self-contained**, per the rules below.

  ### What to check on issue files (this run's filings)

  - **Format**: frontmatter carries `issue` / `kind: "discover"` /
    `category` / `status: open` / `opened`; filename is
    `<YYYY-MM-DD-HHMMSS>-<slug>.md`; body is title, Problem,
    Candidates — no Discussion, no Ruling. The slug is a stable
    fingerprint.
  - **Category fits the content.**
  - **Detail is specific**: quotes files, lines, or `_discover/`
    entries.
  - **Candidates are durable corpus mutations**, path-free, never
    "decide what to do".
  - **No resolutions slipped in**: no winner picked, no options
    graded.
  - **No vague-unease issues**: each is resolvable in a sitting.
  - **No duplicates**, including against pre-existing open issues.

  ### Rules being enforced

  This reviewer runs as its own dispatch, so the rules are
  reproduced in full:

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  {{ISSUE-FILE-FORMAT}}

  ### Cross-check

  - Every listed alias appears in current code or prose. Where
    several live names point at one concept, an open issue file
    exists for the convergence question.
  - Every code annotation cited in `_discover/` lands in
    `concepts/` (as part of the definition) or the intake
    (vestigial / inconsistent).
  - Every `_discover/` entry is folded into an artifact or
    accounted for in the extractor's report.

  ### Final-pass uncertainty filing

  On your final review, file the extraction's residual uncertainty
  as issue files (`kind: "discover"`, `status: open`; skip slugs
  already present). These concern the extracted artifacts, not the
  codebase:

  - Judgment calls the extractor made that the owner should check.
  - Suspected-but-unconfirmed concepts.
  - Concepts merged that might want splitting, and vice versa.
  - Findings unresolved at the cycle cap.

  ### Thin discovery requests (back-edge input)

  Where thin `_discover/` material — not a missing design
  decision — is what blocks a sharper concept, put a structured
  block at the bottom of your report instead of filing an issue;
  the skill drives the one-shot back-edge from it. Include an item
  only when all of these hold:

  - You can name the code directory or files to re-read.
  - You can name the affected artifact slug(s), existing or new.
  - You can state what the thin material prevents the concept from
    saying.
  - The fix is "read more code". A fix that is "make a design
    decision" is an issue file.

  Do not use the block for findings already addressed, for
  owner-judgment issues, or for general "could be deeper" wishes.

  Format:

  ```markdown
  ## Thin discovery requests

  ### <affected-concept-slug>
  - Scope: <code paths to re-read, e.g. `modeling/qualityrule/eval/`>
  - Missing: <one sentence stating what the concept can't currently say>
  - Promote new concept: <name | none>
  ```

  Omit the block when no requests apply.

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
  - Issue files written, by category:
    - overloaded: <count>
    - unspecified: <count>
    - …
  - Thin discovery requests: <count>

  ## Thin discovery requests

  (Structured block per the format above. Omit if empty.)
  ```

  ### Anti-padding

  - Manufacture no issues for a clean catalog.
  - Review that definitions stand alone and are correct, not their
    prose quality.
  - Ask no one to make resolution calls.
  - Manufacture no thin-discovery requests: a concept that is
    shallow because its subject is shallow needs no more reading.
    The bar is "more discovery would meaningfully change what this
    concept says".
```

## Back-Edge — Focused Discoverer Subagent Prompt

```
Agent (general-purpose, model: sonnet):
  ## Discover-Design Back-Edge: Focused Re-Discovery

  {{LEAF-AGENT-RULE}}

  ### Goal

  Phase 2 review named areas where `_discover/` material is too
  thin to support a real concept. Expand the `_discover/` entries
  for only the listed areas: read the named code paths, deepen the
  named entries, and add a new entry only where a request
  authorizes one. This is scoped re-discovery, not a full re-pass:
  touch nothing else and survey nothing broadly.

  ### Thin discovery requests

  (Filled by the orchestrator from the reviewer's block. Each
  names the affected slug(s), the code paths to re-read, what the
  concept cannot currently say, and whether a new concept may be
  promoted.)

  ### What to read

  Only the named code paths; follow imports and call sites within
  them. Read prose only where it directly explains the named area.

  ### What to write

  Per request:
  - Find the `_discover/` entry (or entries) backing the affected
    concept. If none exists, add one under the slug the request
    implies, or report that one must be created.
  - Expand the Description with the missing material and add
    file:line citations to the Code surface.
  - Add new issue candidates to Observations.

  Keep each entry's `topic` and `kind` frontmatter. Touch no entry
  outside the requests.

  ### Per-entry template

  Same as phase 1 (Description / Code surface / Prose surface /
  Adjacent topics / Observations).

  ### Anti-padding

  - Stay in the requested scope; leave unrelated structure for a
    future run.
  - Record, do not evaluate.
  - Do not resolve disagreements.

  ### Report

  - Per request: the entry expanded or created, one line on the
    new material.
  - Requests you could not address, and why.
  - New observations that may become issues.

  Keep under 400 words.
```

## Back-Edge — Focused Extractor Subagent Prompt

```
Agent (general-purpose, model: opus):
  ## Discover-Design Back-Edge: Focused Re-Extraction

  {{LEAF-AGENT-RULE}}

  ### Goal

  The focused discoverer expanded specific `_discover/` entries.
  Update the affected catalog files to reflect the new material,
  file issues the expansion surfaces, and add a new artifact file
  only where the original request authorized "Promote new
  artifact".

  ### Thin discovery requests

  (Filled by the orchestrator. Each names the affected artifact
  kind and slug, the discoverer's expansion summary, and whether a
  new artifact may be promoted.)

  ### What to do per request

  - Re-read the affected artifact file and the expanded
    `_discover/` entry or entries.
  - Edit the artifact in place: a concept's What it is, Purpose,
    or Boundaries; a story's Story statement; a decision's Choice,
    Rationale, or Alternatives — whatever the request flagged as
    missing.
  - Where a new artifact is authorized, create it per the matching
    template; for a concept, update neighbors' `see also:`
    references.
  - Where the material surfaces a new issue, file it per the issue
    file format (`kind: "discover"`, `status: open`; skip slugs
    already present).

  Touch no artifact outside the affected slugs. Add no
  unauthorized artifact.

  ### Artifact templates

  {{CONCEPT-TEMPLATE}}

  {{STORY-TEMPLATE}}

  {{DECISION-TEMPLATE}}

  {{ISSUE-FILE-FORMAT}}

  ### Rules for the docs you touch

  This step runs as its own dispatch, so the rules are reproduced
  in full:

  {{SELF-CONTAINMENT-RULE}}

  {{CURRENT-STATE-ONLY-RULE}}

  ### Anti-padding

  - Stay in scope.
  - Do not merge or split unrelated concepts.
  - Record, do not evaluate.
  - Propose no resolutions in the issues you file.

  ### Report

  - Per request: the file updated, one line on the material
    incorporated.
  - New artifacts added: slug plus one line.
  - New issue files: slug, category, one line.

  Keep under 300 words.
```

## The `@concept:`, `@story:`, `@decision:` annotation convention

Code references the corpus via in-source annotations:

- `@concept: <slug>` — load-bearing site where a concept is expressed
- `@story: <slug>` — load-bearing site delivering a story's user-observable outcome
- `@decision: <slug>` — site embodying a technical decision

Each annotation marks a load-bearing site, not every file that touches the artifact. The three sit alongside any annotation vocabulary the project already runs. Two artifacts together replace an external index: the generated catalog TOCs (what exists, readable in one shot) and the annotations (`rg '@(concept|story|decision): <slug>'` answers both "which artifacts apply to this file" and "where is artifact X load-bearing"). Rollout is incremental — an agent that consults an artifact leaves the annotation at the load-bearing site — per the rule in `.ok-planner/CLAUDE.md`, which applies project-wide regardless of active skill. No bulk annotation pass is needed.

## Re-run discipline

Re-running is idempotent on `_discover/`: it deepens existing entries and adds new ones. The skill refuses to run while `concepts/`, `stories/`, or `decisions/` is non-empty — they may carry human-approved content. For a full rebuild the user deletes the non-empty durable directories first. After refinement, sprints keep the corpus aligned with the code, their deltas changing docs and code as one unit.

## What this skill does NOT do

- Prompts no one mid-run; the final summary is the only user-visible output.
- Proposes no resolutions; resolution is the owner's act, in `/plan-sprint`.
- Writes no prescriptive design; the outputs are as-is, and the prescriptive version arrives through sprint deltas.
- Grades no implementations and calls out no code defects.
- Adds no code annotations; that convention rolls out during ordinary work, per `.ok-planner/CLAUDE.md`.
- Overwrites no human-edited catalogs; it aborts instead.
- Edits or removes no existing issue file; it files new `status: open` issues and nothing else.

<!-- Materialized by ok-planner v19.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
