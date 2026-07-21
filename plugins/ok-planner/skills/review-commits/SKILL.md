---
name: review-commits
description: "ONLY activated by explicit /review-commits slash command. Never auto-triggered by conversation content."
---

# Review Commits

Help the user select a commit range to review, then dispatch a reviewer.

## Steps

1. Determine the commit range to review:

   - **If a range was supplied as a skill argument** (e.g., this skill
     was invoked by `ok-planner:merge` with `HEAD^1..HEAD`), use it
     directly and skip the interactive picker below.
   - Otherwise, show recent commit history and ask the user:
     ```bash
     git log --oneline -20
     ```
     Offer common options:
     - "Last N commits" (e.g., last 3)
     - "Since branching from main" (`git merge-base main HEAD`..HEAD)
     - "Specific range" (user provides SHAs)

2. Once the range is determined, dispatch a reviewer subagent:

```
Agent (general-purpose):
  ## Review Commit Range

  ### Range
  Run `git diff [BASE]..[HEAD]` to see all changes.
  Run `git log --oneline [BASE]..[HEAD]` to see the commits.
  If `git status` shows modified submodules, also run `git diff --submodule=diff [BASE]..[HEAD]` to include submodule changes. Submodule changes are part of the review scope — do not skip them.

  Read modified source files in their entirety for context.

  ### Review Focus
  - Correctness: bugs, edge cases, off-by-one errors
  - Safety: data loss, security issues, resource leaks, irreversible operations
  - State integrity: can we get stuck in a state? Double-execute? Skip steps?
  - Load-bearing properties upheld: name the properties the code is meant to guarantee — durability, completeness, atomicity, ordering, idempotency, no-data-loss, "this record is canonical," "this path must not block" — and check each survives, not just on the happy path. The dangerous regression is code that works under light load but silently trades a property away for a local optimization (e.g. a write made async-and-droppable to save latency, downgrading a record that's supposed to be complete). A property the code is meant to guarantee but no longer does is an issue even when nothing looks broken — review the property, not just the diff.
  - Test coverage: do tests verify real behavior? Any gaps?
  - Dead code, unused imports, stale comments
  - Pre-existing issues: if you find bugs, stale references, or inconsistencies in any file you read — even if they predate the commits being reviewed — report them. If an issue points to problems in files outside the diff, follow the trail and report those too.

  ### Design log (if present)
  If `.ok-planner/design/concepts/` exists, consult it before
  forming findings:

  1. Read `.ok-planner/design/concepts.md` (the TOC).
  2. For files in the diff, `rg '@concept:' <path>` for inline
     citations.
  3. Read `concepts/<slug>.md` for concepts surfaced by (1) or (2).

  Don't flag code that a concept documents as the intended shape.
  Cite the concept file when a finding genuinely contradicts one.
  Findings matching an open `tensions/<slug>.md` are duplicates —
  note the tension slug.

  **Annotate-on-consult (read-only variant):** When you consulted a
  concept and the load-bearing site has no `@concept:` annotation,
  note "consulted concept: <slug> (annotation missing at
  <file:line>)" in the finding so the fixer adds it.

  If `.ok-planner/design/concepts/` doesn't exist, ignore this
  section.

  ### Output Format

  List every issue found with:
  - File:line reference
  - What's wrong
  - Why it matters
  - How to fix

  Do not categorize by severity. Every issue needs fixing.
```

3. If the reviewer found issues, invoke `ok-planner:review-cleanup` with the reviewer's full output. Do NOT process, filter, or triage the output yourself.
