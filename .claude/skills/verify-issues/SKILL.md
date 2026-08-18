---
name: verify-issues
description: "ONLY activated by explicit /verify-issues slash command, or invoked by a certify gate after its architect promotes issues, or by plan-sprint when a legacy issues.jsonl needs converting. Makes every open issue ruling-ready without changing code or the corpus: converts any legacy issues.jsonl, closes issues the design corpus already answers, then — inline, in the main loop — rewrites each surviving issue as a single from-the-top narrative any engineer can read cold, ending in a marked generated or recommended ruling the owner accepts by silence or overrides; where the rules fully determine the fix, the ruling names that fix rather than applying it."
---

# Verify the Issue Intake

Make every open issue ruling-ready, and make sure it deserves a ruling at all. Issues arrive raw — a slug, a problem statement, candidates — from certification's architect, `/discover-design`, `/plan-sprint`, and humans. An issue the corpus already squarely answers is closed here rather than handed to the owner.

**This skill changes nothing but issue files.** It edits no code and nothing under `.ok-planner/design/`, even when the rules leave exactly one compliant end state. The verifier's job there is to say *the rules force this, and here is the fix* — in the ruling, for `/plan-sprint` to draft and execution to apply.

The work splits into two tasks, staffed differently:

- **Investigation** — re-verify the filed evidence against current code and prose, read the bearing corpus artifacts, establish what the system does, enumerate the real options and their costs. This fans out to batched subagents.
- **Authorship** — write each surviving issue for an engineer who does not know the project, and call the ruling. This runs inline, in the main loop, never delegated: the session's own model is the author and the recommender.

Runs autonomously — no owner prompts mid-run; the final report is the only thing the owner sees. Idempotent: verified, ruled, promoted, and retired issues are never touched again.

## Process

### 0. Ensure the layout

Run `mkdir -p .ok-planner/issues .ok-planner/history/issues`; estate convergence is the front door's administration (`/ok`), not this skill's.

### 1. Convert a legacy `issues.jsonl`, if present

Projects that predate the file-per-issue intake carry `.ok-planner/issues.jsonl`, an append-only event log. Per `{{ISSUE-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`:

1. Fold the log by `id`: an `open` row with no later `promote` / `retire` / legacy `resolve` row is open.
2. For each open id, write an issue file to `.ok-planner/issues/<YYYY-MM-DD-HHMMSS>-<id>.md` — timestamp from the row's `at`, frontmatter (`issue`, `kind`, `category`, `artifacts`, `status: open`, `opened` = the row's `at`), title from `summary`, `## Problem` from `detail`, `## Candidates` from `candidates`. Skip an id whose slug already has a file.
3. Move the log to `.ok-planner/history/issues.jsonl` — the receipt for every terminated id, never edited. Remove an empty log.

Terminal ids are not expanded into files; their history lives in the archived log.

### 2. Collect the verification scope

The scope is every file under `.ok-planner/issues/` with `status: open`. Everything else is out of scope: `verified` files carry their narrative, a non-empty `## Ruling` belongs to the owner regardless of status, and `promoted` / `retired` / `answered` files — plus `repaired`, a terminal status earlier layouts wrote — are closed. Zero open files → report and stop.

### 3. Investigate, batched

Dispatch investigator subagents over the open set in batches of up to 10 issues, batches in parallel; group related issues where the grouping is obvious. Before dispatching, run the corpus surfacer once per issue and paste its output (the bearing concept / story / decision files) under that issue's entry:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 .ok-planner/scripts/surface-corpus .ok-planner/issues/<file>.md
```

The investigator prompt:

```
Agent (general-purpose, model: sonnet):
  ## Issue investigation (batch)

  ### Your job

  Investigate the raw design issues listed below, one at a time,
  each independently. Do ALL reading yourself with Read/Grep —
  NEVER spawn subagents. Read the design catalogs (`concepts.md` /
  `stories.md` / `decisions.md`) once, up front; reuse what you
  have read across issues.

  Per issue, classify into one of three outcomes. The governing
  test: "do we want the docs/code to follow the rules?" is never a
  question — an issue reducible to it takes outcome 1 or 2, never
  3. Outcome 1 you EXECUTE, and its issue file is the only file
  you may write; outcomes 2 and 3 you REPORT as a brief and leave
  the files untouched.

  1. **The design corpus already answers it** — a live concept,
     story, or decision squarely decides the question, or
     re-verifying shows the filed gap no longer exists. Replace
     the file's body below the frontmatter with a short closure
     note — the question in one plain sentence, then the answer
     with the deciding artifact's slug and section quoted (or what
     now holds) — set `status: answered`, and move the file to
     `.ok-planner/history/issues/` (same filename). The bar is
     *squarely*: the text decides the question without
     interpretation you would have to defend. In doubt, fall
     through.

  2. **The rules determine the resolution** — the corpus and its
     authoring rules leave exactly one compliant end state, so
     the owner has nothing to weigh. This covers the
     intent-preserving case (a missing annotation, a missing
     assertion in a cited test, a stale TOC line, a stale sentence
     the code and the counterpart artifact both contradict) and
     the intent-level case (a retirement, a Choice rewritten, an
     invariant added or dropped, a claim widened or narrowed).
     You apply neither: verify the fix against the current tree,
     then hand it over. Return a brief marked `determined`, naming
     the rule that forces the resolution and the fix itself —
     what changes, in which artifact or behavior, and to what —
     concretely enough that nobody downstream re-derives it.

  3. **It genuinely needs judgment.** Return a brief marked
     `open`.

  ### The brief (outcomes 2 and 3) — your report, not the file

  Per issue, return a compact, factual brief the author will write
  from: everything the body and ruling will turn on, and nothing
  else.

  - `slug:` and outcome (`determined` | `open`)
  - **The fix** (`determined` only): the one compliant end state
    and the rule that forces it, written to be applied, not
    re-derived.
  - **Evidence, re-verified**: what is true in the code and prose
    now (note where the filed Problem has rotted), with code
    citations in parentheses.
  - **Mechanism**: the one or two cause-and-effect facts the
    reader needs — what talks to what, what breaks, who
    observes it.
  - **Corpus**: each bearing artifact by slug plus the one clause
    that matters. Say plainly where the corpus is silent.
  - **Options**: each real option with its main cost. Drop
    strawmen; note options the filer missed.
  - **Interactions**: sibling issues this should be ruled with.

  ### Rules

  - You are read-only everywhere except the outcome-1 closure.
    Never edit code, never edit anything under
    `.ok-planner/design/`, never run git, never commit. A fix you
    can see is a fix you write down.
  - Touch no issue file outside outcome 1.
  - NEVER spawn subagents.

  ### Report

  The closure one-liners for outcome 1, then the full briefs for
  outcomes 2–3.
```

### 4. Author, inline — the main loop writes every surviving issue

For each brief (outcomes 2 and 3), YOU — in the main loop, never a subagent — rewrite the issue file and call the ruling. Read the original file and the brief; open the cited corpus artifacts or code only where the brief leaves a causal question unanswered.

**Replace the file's entire body below the frontmatter**, title included where a plainer one fits. The filer's Problem and Candidates are superseded (git history preserves them). Set `status: verified`.

**What the verified file contains.** The reader is an engineer who does not know the project and must evaluate the ruling. The body carries, in this order:

- The defect: what the tree does or lacks, and which commitment that breaks.
- The mechanism: what talks to what, why the current shape produces the problem, who observes it.
- The state of play: what is handled, what gaps remain.
- `## Options` — each real option a reasonable owner might pick, with its one cost.
- One sentence naming what the ruling decides.

Include a project term only when evaluating the ruling requires it, and cite a concept / story / decision slug only after the words it labels. Include implementation mechanics only where the ruling turns on them. Nothing in the body restates anything else in it.

**Then write the `## Ruling`.** One recommendation: the resolution that best serves the project's intent, its invariants, and the grain of decisions already made — never the least-effort or most-deferential option. It states what to do and why; it carries no artifact operations, no delta phrasing, no file paths. The ruling states intent; `/plan-sprint` drafts it into deltas and work items; the implementer owns the mechanics. For a `determined` brief, mark it generated; for an `open` brief, mark it recommended:

    ## Ruling

    > Generated ruling (/verify-issues): <the rules-forced resolution —
    > the fix itself, and which rule forces it. Verified against the
    > tree as it stands; nothing was applied.>

    -- or --

    > Recommended ruling (/verify-issues): <what to do and why;
    > "retire: <reason>" remains a valid resolution>.
    >
    > Rationale: <why this over the other options — by reference,
    > never re-describing them — grounded in the project's intent or
    > a corpus precedent. Then the flip case, always: what evidence
    > or observation would change this call.>

    <!-- Owner: this is a recommendation, not your decision. Leave it
    as-is to accept — the next /plan-sprint carries it, naming the
    generated/recommended batches at sign-off. Edit the text to
    redirect, empty the section to discuss live, or delete this note
    to adopt the ruling as your own. -->

The blockquote uses project shorthand only after the body has introduced it. Every surviving issue gets a ruling — never an empty one. When the call is close, pick anyway and let the flip case say what makes it close; "too close to call" is a report note, never an empty Ruling.

**A generated ruling states the fix, not a gesture at one.** It names what changes, in which artifact or behavior, and to what, at the concreteness of the brief that produced it — still no delta phrasing and no file paths — so `/plan-sprint` drafts it and execution applies it without re-deriving it.

### 5. Report

- Converted from legacy log: N files (or "no legacy log").
- **Answered by the corpus and closed**: each with slug and the deciding artifact — the veto surface.
- **Verified with generated rulings**: slug + one-line fix each; they ride the next `/plan-sprint`.
- **Verified with recommended rulings**: slug + one-line recommendation each — the owner's review list; skimming it is the whole review.
- Already ruled and waiting for the next `/plan-sprint`: count.

## What this skill does NOT do

- Does not delegate authorship or recommendation — investigation fans out; writing and judgment stay in the main loop.
- Does not decide anything against the owner: every generated or recommended ruling is marked, reported, and overridable by an edit or an emptying; `/plan-sprint` names both batches at sign-off.
- Does not promote or retire — those are `/plan-sprint` acts.
- Does not overwrite owner-written Ruling text or touch any verified, promoted, or retired file.
- Does not edit code or the design corpus, however mechanical the fix: every rules-determined resolution becomes a generated ruling naming the fix; `/plan-sprint` drafts it and execution applies it. Certification's in-cycle repair loop is a separate mechanism, unaffected.
- Does not ask the owner anything mid-run. The report is the only touchpoint.

<!-- Materialized by ok-planner v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
