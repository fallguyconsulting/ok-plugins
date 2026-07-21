---
name: merge
description: "ONLY activated by explicit /merge slash command. Never auto-triggered by conversation content."
---

# Merge: Triage a Merge or Rebase

Two-stage review of a recently-merged-in change set. Stage 1
surfaces design-doc inconsistencies a merge can introduce — slug
collisions, broken annotations, and two-branch semantic conflicts
— as findings the user can feed into a follow-up brainstorm /
refine-design session that will produce a spec. Stage 2 runs a
code review of the merge diff via `ok-planner:review-commits`.

If the project has no design docs (`.ok-planner/design/concepts/`
does not exist), stage 1 is skipped silently and `/merge` is
effectively a wrapper around `/review-commits` over the merge
range.

## Why this exists

A merge or rebase can introduce design-doc inconsistencies that
no single branch's discipline can prevent. The two classes
`/merge` looks for are:

- **Mechanical artifacts** — two branches both authored a
  concept file under the same slug; one branch renamed a concept
  while another added new `@concept:` annotations pointing at the
  old slug; a template ended up malformed after a conflict
  resolution. These are the merge's own residue, not design
  drift.
- **Semantic conflicts** — two branches edited the same concept's
  prescriptive content (Definition / Purpose / Boundaries /
  Invariants, or a story's Acceptance / Falsifier / Proof, or a
  decision's Choice / Rationale / Alternatives) along
  incompatible lines, or two branches independently added concept
  files for arguably the same noun under different slugs.

`/merge` does not look for "drift" between the design docs and
code. If the pipeline is working — execute-plan changing docs
and code as one unit — drift cannot accumulate; the doc says
what the code does because they were authored together. A
`/merge` run that surfaced "Boundaries says X but code does Y"
would be papering over an execute-plan bug, not catching real
breakage.

`/merge` does not patch the design docs directly. It surfaces
findings; the user takes them through `/brainstorm` or
`/refine-design` to produce a reconciliation spec, which then
flows through write-plan and execute-plan as usual. Stage 2
applies the usual code-review surface to the merge diff.

## When to invoke

Right after a git merge or rebase that touched code. Optionally before
a merge as a dry-run by checking out the merge base and running with the
prospective tip as the comparison ref.

## Inputs

- `.ok-planner/design/` — the current design docs (post-merge), if present.
- The merge diff: `git diff <base>..HEAD`, where `<base>` defaults to
  `HEAD^1` if HEAD is a merge commit, else `main`. Override with the
  skill's optional argument: `/merge main`, `/merge HEAD~5`, etc.

## Process

1. **Resolve the base ref.** If HEAD is a merge commit and no
   argument given, use `HEAD^1`. Otherwise default to `main`.
   Allow the user to override.

2. **Stage 1 — Surface design-doc findings.** If
   `.ok-planner/design/concepts/` does not exist, skip this stage
   silently — the design docs are opt-in. Otherwise:

   a. Dispatch the design-doc triage subagent (prompt below) to
      surface findings in two classes:
      - **Mechanical** — slug collisions, malformed templates,
        and broken `@concept:` / `@story:` / `@decision:`
        annotations (a slug referenced in code that no longer
        exists in the catalog, typically because one branch
        renamed it while another added new references to the
        old name).
      - **Semantic conflicts** — two branches edited the same
        artifact's prescriptive content incompatibly, or added
        artifact files for arguably the same noun / outcome /
        choice under different slugs.

   b. Save the findings to
      `.ok-planner/_merge-findings-<date>.md` as a structured
      markdown report (the subagent prompt below specifies the
      format). The file lives at the `.ok-planner/` root, not
      under `design/`, because `/merge` is read-only against the
      design docs. Do NOT modify any file under
      `.ok-planner/design/` to apply the findings — design docs
      change only through plan execution.

   c. Walk the findings with the user briefly:
      - Confirm each finding makes sense (drop spurious ones).
      - For each kept finding, suggest the natural next step:
        * **Mechanical** → small targeted spec via `/brainstorm`,
          with a `## Design changes` section listing the fixes
          (rename to dissolve the collision, fix the broken
          annotation, fill the missing template section).
        * **Semantic conflicts** → suggest `/refine-design` after
          the user has at least one of the conflicting positions
          captured as a tension; or a follow-up `/brainstorm` if
          the user has already decided on a resolution.

      The user decides when to act. `/merge` does not invoke
      `/brainstorm` or `/refine-design` automatically.

   Single pass. No fix loop. No writes to the design docs.

3. **Stage 2 — Code review.** Invoke `ok-planner:review-commits`
   with the range `<base>..HEAD` as its skill argument so its
   interactive range-picker is bypassed. Let it run to completion
   via review-cleanup.

4. **End-of-run summary.** Report stage 1's findings counts and
   the path to the `.ok-planner/_merge-findings-<date>.md` report;
   report stage 2's findings + cleanup status. Remind the user that
   design-doc findings need a follow-up spec (via `/brainstorm`
   or `/refine-design`) to actually fix anything — `/merge` only
   surfaced them.

## Design-doc Triage Subagent Prompt

```
Agent (general-purpose):
  ## Triage Design Docs Against Merge

  ### Your job

  A merge or rebase has just landed. The design docs at
  `.ok-planner/design/` may now carry merge-only inconsistencies
  — slug collisions, broken annotations, or two-branch semantic
  conflicts. Surface them in two classes of finding for the
  orchestrator to walk with the user. **Do NOT modify any file
  under `.ok-planner/design/`** — design docs change only
  through plan execution. Your job is to draft findings, not
  apply them.

  Do NOT look for "drift" between the design docs and the
  current codebase (a Boundaries section that disagrees with
  the code, an Invariant the code no longer holds). If the
  pipeline is working, drift cannot exist: execute-plan
  changes docs and code as one unit. A "drift" finding here
  would be papering over an execute-plan bug, not a real
  merge artifact. Confine yourself to the two classes below.

  ### Inputs

  - Current design docs: read every file under
    `.ok-planner/design/concepts/`, `.ok-planner/design/stories/`,
    `.ok-planner/design/decisions/`, and
    `.ok-planner/design/tensions/`. Read `.ok-planner/design/concepts.md`,
    `stories.md`, and `decisions.md` (the auto-generated TOCs) for
    orientation.
  - Merge diff: `git diff <BASE>..HEAD` where BASE was supplied as
    `<BASE_REF>`. Read the diff in full; identify what code changed.
  - Optionally: `git log <BASE>..HEAD --oneline` for commit-level
    structure.

  Do NOT read existing docs (READMEs, narrative under `docs/`, etc.).
  The design docs are the authoritative record of intent for this
  skill's purposes.

  ### Two classes of finding

  #### 1. Mechanical

  Issues with specific, judgment-free resolutions an agent can
  carry out via a small targeted spec:
  - Slug collisions — two branches both added
    `concepts/<slug>.md`, `stories/<slug>.md`,
    `decisions/<slug>.md`, or `tensions/<slug>.md` with the same
    slug but different content.
  - Malformed templates — a concept, story, decision, or tension
    file missing required sections per `discover-design`'s
    templates.
  - Broken annotations — `rg '@(concept|story|decision):'` across
    the post-merge code turns up annotations whose slug doesn't
    exist in the corresponding catalog. The typical cause is one
    branch renaming or removing a slug while another branch
    independently added new references to the old name.

  For each, propose a specific resolution: rename file A to a new
  slug; fill in the missing section; correct the annotation's
  slug or remove it (if the referenced artifact was deliberately
  retired).

  #### 2. Semantic conflicts

  Two branches that both edited the same artifact's prescriptive
  content incompatibly, or added artifact files for arguably the
  same noun / outcome / choice under different slugs. Detect by:
  - Concept / story / decision files where both branches' diffs
    touched the prescriptive sections (Definition / Purpose /
    Boundaries / Invariants on concepts; Acceptance / Falsifier /
    Proof on stories; Choice / Rationale / Alternatives on
    decisions).
  - Boundaries that now contradict each other or overlap (e.g.,
    both A and B claim the same responsibility).
  - Slugs that are clear synonyms or near-synonyms of an existing
    artifact in the same catalog.

  For each semantic conflict, draft a `tensions/<slug>.md` entry per
  `discover-design`'s tension template:
  - A short slug naming the area of disagreement.
  - The competing positions, summarized one each.
  - The artifact files implicated.
  - The merge commit / range as the trigger.

  Do NOT pick a winner. The tension exists; capturing it is the
  point.

  ### Output format

  ```
  ## 1. Mechanical

  - <file-or-area> — <what's wrong> — <proposed fix>
  - ...

  ## 2. Semantic conflicts

  - Proposed tension slug: <slug>
    Artifact(s) implicated: <list>
    Position A: <one line>
    Position B: <one line>
    Drafted tension file:
    <full text of the proposed `tensions/<slug>.md`, per
    discover-design's template>
  - ...
  ```

  If a class is empty, write `(none found)`. Don't pad.
```

## What this skill does NOT do

- Does not modify any file under `.ok-planner/design/`. Findings
  are surfaced in a report; resolution is human-driven and rides
  through the spec pipeline.
- Does not auto-resolve semantic conflicts. Semantic disagreement
  goes into a follow-up `/refine-design` session as new tension
  entries (which get written by execute-plan, not by merge).
- Does not invoke `/brainstorm` or `/refine-design` automatically.
- Does not modify the merge commit. All changes are new working-tree
  edits (or new commits on top of HEAD, if the user chooses to commit
  them).
- Does not handle in-progress merge conflicts. Run `/merge` after a
  successful `git merge` or `git rebase`, not during conflict
  resolution.
