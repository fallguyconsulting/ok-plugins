---
name: verify-issues
description: "ONLY activated by explicit /verify-issues slash command, or invoked by a certify gate after it files issues, or by plan-sprint when a legacy issues.jsonl needs converting. Drains every obvious issue and makes the rest ruling-ready: converts any legacy issues.jsonl, closes issues the design corpus already answers, repairs code-side gaps the rules fully determine, then — inline, in the main loop — rewrites each surviving issue as a single from-the-top narrative any engineer can read cold, ending in a marked generated or recommended ruling the owner accepts by silence or overrides."
---

# Verify the Issue Intake

Make every open issue **ruling-ready — and make sure it deserves a ruling at all**. Issues are filed raw — a slug, a problem statement, candidates — by `/audit`, `/discover-design`, `/plan-sprint`, and humans. Raw is not something to hand a project owner, and neither is a non-question: an issue whose resolution the corpus and its authoring rules already determine wastes the owner's reading time if it survives to the intake.

The work splits into two genuinely different tasks, staffed differently:

- **Investigation** — re-verify the filed evidence against current code and prose, read the bearing corpus artifacts, establish what the system actually does, enumerate the real options and their costs. Thoroughness is the virtue. This fans out to batched subagents.
- **Authorship** — turn each surviving issue's material into a story a stranger can follow, and call the ruling. Judgment is the virtue, and the writing *is* the analysis: a recommendation is only as good as the wrestling-into-clarity that precedes it. This runs **inline, in the main loop — never delegated**. The session's own model is the author and the recommender.

Runs autonomously — no owner prompts mid-run; the final report is the only thing the owner sees. Idempotent: verified, ruled, promoted, and retired issues are never touched again.

## Process

### 0. True up

Invoke `ok-planner:true-up` so `.ok-planner/issues/` and `.ok-planner/history/issues/` exist.

### 1. Convert a legacy `issues.jsonl`, if present

Projects that predate the file-per-issue intake carry `.ok-planner/issues.jsonl`, an append-only event log. Per `{{ISSUE-FILE-FORMAT}}` in `skills/_shared/artifact-definitions.md`:

1. Fold the log by `id`: an `open` row with no later `promote` / `retire` / legacy `resolve` row for the same id is open.
2. For each open id, write an issue file to `.ok-planner/issues/<YYYY-MM-DD-HHMMSS>-<id>.md` — timestamp derived from the row's `at`, frontmatter (`issue`, `kind`, `category`, `artifacts`, `status: open`, `opened` = the row's `at`), title from `summary`, `## Problem` from `detail`, `## Candidates` from `candidates`. Skip an id whose slug already has a file under `issues/`.
3. Move the log itself to `.ok-planner/history/issues.jsonl` — it is the receipt for every already-terminated id and is never edited. (An empty log is simply removed.)

Terminal ids are **not** expanded into files; their history lives in the archived log.

### 2. Collect the verification scope

The scope is every file under `.ok-planner/issues/` with `status: open`. Everything else is out of scope by construction: `verified` files already carry their narrative, a non-empty `## Ruling` belongs to the owner regardless of status, and `promoted` / `retired` / `answered` / `repaired` files are closed or committed. Zero open files → report and stop.

### 3. Investigate, batched

Dispatch investigator subagents over the open set **in batches of up to 10 issues per agent**, batches running in parallel. Batch related issues together where the grouping is obvious; otherwise split evenly. Before dispatching, run the corpus surfacer once per issue and paste its output (bearing concept/story/decision files) under that issue's entry:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 "${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus" .ok-planner/issues/<file>.md
```

The investigator prompt:

```
Agent (general-purpose, model: sonnet-5):
  ## Issue investigation (batch)

  ### Your job

  Investigate the raw design issues listed below — one at a
  time, each independently. Work economically: do ALL reading
  yourself with Read/Grep — NEVER spawn subagents. Read the
  design catalogs (`concepts.md` / `stories.md` / `decisions.md`)
  once, up front; reuse what you've already read across issues.

  Per issue, classify into one of four outcomes. The governing
  test: "do we want the docs/code to follow the rules?" is never
  a question — an issue reducible to it takes outcome 1, 2, or 3.
  Outcomes 1 and 2 you EXECUTE; outcomes 3 and 4 you REPORT as a
  brief — do not edit those issue files at all.

  1. **The design corpus already answers it** — a live concept,
     story, or decision squarely decides the question, or
     re-verifying shows the filed gap no longer exists. Replace
     the file's body (below the frontmatter) with a short
     closure note — the question in one plain sentence, then the
     answer with the deciding artifact's slug and section quoted
     (or what now holds) — set `status: answered`, and move the
     file to `.ok-planner/history/issues/` (same filename). The
     bar is *squarely*: the text decides the question without
     interpretation you'd have to defend. When in doubt, fall
     through.

  2. **The rules determine the fix, and it is code-side** — the
     corpus and its authoring rules leave exactly one compliant
     end state, and realizing it touches only code and tests
     (add a missing annotation, add the assertion a Proof field
     names) — never any file under `design/`. Repair it: make
     the change, run the affected package's type checks and
     tests (a repair that breaks the build is not a repair),
     replace the file's body with a short receipt — the question
     in one plain sentence, what rule determined the fix, what
     changed, how verified — set `status: repaired`, and move
     the file to `.ok-planner/history/issues/`. If the repair
     grows into redesign, stop: it is outcome 3 or 4.

  3. **The rules determine the resolution, but it is a corpus
     mutation** only a sprint may make. Do not edit the file.
     Return a brief (format below) marked `determined`, stating
     the forced resolution and the rule that forces it.

  4. **It genuinely needs judgment.** Do not edit the file.
     Return a brief marked `open`.

  ### The brief (outcomes 3 and 4) — your report, not the file

  Per issue, return a compact, factual brief the author will
  write from. Facts, not prose polish; include everything the
  final narrative and ruling will turn on, and nothing else:

  - `slug:` and outcome (`determined` | `open`)
  - **Evidence, re-verified**: what is true in the code/prose
    RIGHT NOW (note where the filed Problem has rotted). State
    behavior in plain terms; add code citations in parentheses.
  - **Mechanism**: the one or two cause-and-effect facts a
    stranger needs to understand why this matters (what talks
    to what, what breaks, who observes it).
  - **Corpus**: each bearing artifact by slug + the one clause
    that matters. Say plainly if the corpus is silent.
  - **Options**: each real option with its main cost. Drop
    strawmen. Note options the filer missed.
  - **Interactions**: sibling issues this should be ruled with,
    if any.

  ### Rules

  - Repairs: read files before editing, follow the project's
    code conventions, never touch `.ok-planner/design/`, never
    run git checkout/restore/reset/stash/clean, do NOT commit.
  - Do not touch any issue file outside outcomes 1-2.
  - NEVER spawn subagents.

  ### Report

  The closure/repair one-liners for outcomes 1-2, then the full
  briefs for outcomes 3-4.
```

### 4. Author, inline — the main loop writes every surviving issue

For each brief (outcomes 3 and 4), YOU — in the main loop, never a subagent — rewrite the issue file and call the ruling. Read the original file and the brief; open the cited corpus artifacts or code only where the brief leaves a causal question you cannot answer plainly.

**Replace the file's entire body below the frontmatter** — title included, if a plainer one tells the story better. The filer's raw Problem/Candidates sections are superseded (git history preserves them); the verified file is ONE narrative, not sections that restate each other. Set `status: verified`.

**The narrative contract — write like a journalist, from the top:**

- **The lede tells the whole story.** First paragraph: what this is, why it's broken (or contested), and what's at stake — in plain language a competent engineer who has never opened this repo follows cold. If the lede works, a reader can stop there and know what the issue is.
- **The nut graf explains the mechanism, causally.** What talks to what, why the current shape produces the problem, who observes it. Gloss every project term in a clause on first use; a concept/story/decision slug may be cited only after the plain statement it labels; never let a bare function or file name carry meaning (citations trail in parentheses). The test: no obvious "why can't they just…" is left hanging — if the reader would ask it, answer it in place.
- **Then the state of play**: what's already handled, what gaps remain — one breath each.
- **`## Options`**: each real option with its one honest cost. Only options a reasonable owner might pick.
- **Close with what the ruling decides**, one sentence if possible.
- Say what needs saying once, clearly, and not chattily. Brevity comes from choosing facts, never from compressing into project shorthand. Implementation mechanics appear only where the ruling turns on them.

**Then write the `## Ruling`.** One recommendation — the resolution that best serves the project's intent, its invariants, and the grain of decisions already made; never the least-effort or most-deferential option. For a `determined` brief, mark it generated; for an `open` brief, mark it recommended:

    ## Ruling

    > Generated ruling (/verify-issues): <the rules-forced resolution,
    > stated as the corpus mutation to make>.

    -- or --

    > Recommended ruling (/verify-issues): <the resolution, stated as
    > what /plan-sprint should carry — the corpus mutation, the work
    > item, or "retire: <reason>">.
    >
    > Rationale: <why this over the other options, briefly, grounded
    > in the project's intent or a corpus precedent>.

    <!-- Owner: this is a recommendation, not your decision. Leave it
    as-is to accept — the next /plan-sprint carries it, naming the
    generated/recommended batches at sign-off. Edit the text to
    redirect, empty the section to discuss live, or delete this note
    to adopt the ruling as your own. -->

The blockquote must read against the narrative alone — plain language first, project shorthand only after the narrative has introduced it. If you truly cannot pick between options, say so in the report and leave that Ruling empty rather than writing a non-recommendation — but that is the exception, not a hedge to reach for.

### 5. Report

- Converted from legacy log: N files (or "no legacy log").
- **Answered by the corpus and closed**: each with slug and the deciding artifact — veto surface.
- **Repaired and closed**: each with slug and a one-line what-changed — veto surface; repairs sit uncommitted for review.
- **Verified with generated rulings**: slug + one-line resolution each.
- **Verified with recommended rulings**: slug + one-line recommendation each — the owner's review list; skimming it is the whole review.
- Already ruled and waiting for the next `/plan-sprint`: count.

## What this skill does NOT do

- Does not delegate authorship or recommendation — investigation fans out; writing and judgment stay in the main loop.
- Does not decide anything against the owner: every generated/recommended ruling is marked, reported, and overridable by an edit or an emptying; `/plan-sprint` names both batches at sign-off.
- Does not promote or retire — those are `/plan-sprint` acts.
- Does not overwrite owner-written Ruling text or touch any verified/promoted/retired file.
- Does not write corpus deltas or any file under `design/` — repairs are code-side only; determined corpus mutations become generated rulings, drafted as deltas by `/plan-sprint`.
- Does not ask the owner anything mid-run. The report is the only touchpoint.
