---
name: review-feature
description: "ONLY activated by explicit /review-feature slash command. Never auto-triggered by conversation content."
---

# Review Feature

Exploratory review: "Does this codebase implement X well?" You don't need to know which files or specs are involved — this review discovers the boundaries through investigation and dialogue.

## Steps

1. **Establish the feature.** Ask the user what feature or capability they want reviewed. Get a short description — not a file list or spec, just "the judging recovery system" or "how entry fees flow."

2. **Explore.** Dispatch an exploration subagent to map the feature:

```
Agent (Explore):
  Find all code related to: [feature description]

  Search for:
  - Entry points (API endpoints, handlers, schedulers)
  - Core logic files
  - Types and interfaces
  - Tests
  - Configuration
  - Documentation (CLAUDE.md, READMEs, specs)

  Report:
  - Which files implement this feature
  - How they connect (call graph, data flow)
  - What the boundaries are (where this feature starts and ends)
  - Any specs or plans that describe it
```

3. **Confirm understanding.** Present what was found to the user:
   - "Here's what I found for [feature]. These N files are involved, here's how they connect."
   - Ask: "Does this match your understanding? Anything missing or surprising?"

4. **Review.** Dispatch a reviewer with the mapped context:

```
Agent (general-purpose):
  ## Feature Review: [feature description]

  ### Files involved
  [List from exploration]

  ### How it works
  [Summary from exploration]

  ### Your Job
  Read every file involved. Evaluate the feature holistically:

  - **Completeness:** Does this feature do what it should? Are there obvious gaps?
  - **Correctness:** Bugs, edge cases, race conditions, error handling
  - **Load-bearing properties:** Name the properties the feature is meant to guarantee — durability, completeness, atomicity, ordering, idempotency, no-data-loss, "this record is canonical," "this path must not block" — and check each holds, not just on the happy path. The dangerous failure is a feature that works under light load but silently trades a property away for a local optimization (e.g. an async-and-droppable write where completeness was assumed). A property the feature is meant to guarantee but no longer does is a finding even when nothing looks broken.
  - **Coherence:** Does the implementation make sense as a whole? Are the pieces well-integrated?
  - **Overengineering:** Is anything more complex than it needs to be?
  - **Underengineering:** Are there shortcuts that will cause problems?
  - **Test coverage:** Are the important paths tested?
  - **Documentation:** Does the code match what docs say? Are there stale docs?
  - **Pre-existing issues:** If you find bugs, stale references, or inconsistencies in any file you read — even if they predate recent changes — report them. If an issue points to problems in files outside the initial scope, follow the trail and report those too.

  ### Design log (if present)
  If `.ok-planner/design/concepts/` exists, consult it before
  forming findings:

  1. Read `.ok-planner/design/concepts.md` (the TOC) — feature
     reviews typically span multiple concepts; the TOC helps pick
     which.
  2. For files identified during exploration, `rg '@concept:' <path>`
     for inline citations. Annotations across the feature's files
     name every concept the feature load-bearingly implements.
  3. Read `concepts/<slug>.md` in full for each surfaced concept;
     consult their Boundaries sections to understand which neighbor
     concepts the feature touches.

  Findings that contradict a documented boundary or invariant
  should cite the concept file alongside file:line. Findings
  matching an open entry in `.ok-planner/design/tensions/` are
  duplicates — note the tension slug. If a documented concept
  itself looks wrong, surface as "documented concept at
  concepts/<slug>.md says X, but..." rather than as a code defect.

  **Annotate-on-consult (read-only variant):** When you consulted a
  concept and the load-bearing site has no `@concept:` annotation,
  note "consulted concept: <slug> (annotation missing at
  <file:line>)" in the finding so the fixer adds it.

  If `.ok-planner/design/concepts/` doesn't exist, ignore this
  section.

  ### Output Format

  Organize findings by theme, not by file. For example:
  - "The recovery ladder has a gap: if X happens during Y..."
  - "The wallet expiration logic is duplicated in three places..."
  - "The spec says X but the code does Y..."

  For each finding:
  - File:line references
  - What's wrong or surprising
  - Why it matters
  - How to fix (if applicable)

  Do not categorize by severity. Every issue needs fixing.
```

5. **Discuss findings with user.** Some findings from a feature review may be intentional trade-offs. Present findings and discuss before fixing.

6. **Fix agreed-upon issues.** Invoke `ok-planner:review-cleanup` with the agreed issues. Do NOT process, filter, or triage the list yourself.
