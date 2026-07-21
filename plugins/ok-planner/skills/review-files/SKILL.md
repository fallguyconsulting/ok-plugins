---
name: review-files
description: "ONLY activated by explicit /review-files slash command. Never auto-triggered by conversation content."
---

# Review Files

Deep-read specific files or directories and review them in context of their role in the codebase.

## Steps

1. If the user already specified files in conversation context, use those. Otherwise, show the project structure and ask what to review:
   - List top-level directories and key files
   - Ask which files or directories to focus on

2. For each selected file/directory, dispatch a reviewer subagent:

```
Agent (general-purpose):
  ## Deep File Review

  ### Files to review
  [List of files/directories]

  ### Your Job

  **Working-tree first.** Before forming any findings, run `git
  status` and `git diff` to confirm what is modified or deleted in
  the working tree relative to HEAD. Code deleted in the working
  tree is not in scope for findings even if it appears in HEAD; code
  added in the working tree is in scope even though it's
  uncommitted.

  Read each file in its entirety. For each file, understand:
  - What is this file's responsibility?
  - Who calls it? What does it depend on?
  - Is it well-structured for its role?

  Then review for:
  - Correctness: bugs, edge cases, off-by-one errors
  - Safety: data loss, security issues, resource leaks
  - Load-bearing properties upheld: identify the contract each file is meant to honor — durability, completeness, atomicity, ordering, idempotency, no-data-loss, "this record is canonical," "this path must not block" — and check it survives, not just on the happy path. The dangerous failure is code that works under light load but silently trades a property away for a local optimization (an async-and-droppable write where completeness was assumed, a sampled scan where the contract was exhaustive). A property the code is meant to guarantee but no longer does is an issue even when nothing looks broken.
  - Clarity: could someone understand this without reading its internals?
  - Interface quality: are the boundaries clean? Can internals change without breaking consumers?
  - Dead code, unused exports, stale comments
  - Test coverage: are the corresponding tests adequate?
  - Pre-existing issues: if you find bugs, stale references, or inconsistencies — even if they predate recent changes — report them. If an issue points to problems in files outside the initial review scope, follow the trail and report those too.

  ### Design log (if present)
  If `.ok-planner/design/concepts/` exists, consult it before
  forming findings:

  1. Read `.ok-planner/design/concepts.md` (the TOC).
  2. For each file under review, `rg '@concept:' <file>` for
     inline citations.
  3. Read `concepts/<slug>.md` for any concept surfaced by (1) or
     (2). For a file that implements the `frame` concept's
     machinery, `concepts/frame.md` is the authoritative shape.

  A finding that contradicts a stated boundary or invariant means
  either (a) the code drifted from the documented design (flag the
  code, cite the concept file), or (b) the documented concept
  itself is wrong (rare — surface as "documented concept at
  concepts/<slug>.md says X, code says Y; needs reconciliation").
  Do NOT flag something that the concept documents as the intended
  shape. Findings matching an open `tensions/<slug>.md` are
  duplicates — note the tension slug rather than re-litigating.

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
