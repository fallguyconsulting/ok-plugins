---
issue: intake-queue-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:issue
status: verified
opened: 2026-07-25T02:26:48Z
---

# Decide whether the intake queue is its own concept or stays folded into issue

## Problem

The noun 'intake queue' is load-bearing across concept:issue, concept:finding, concept:sprint, decision:append-only-issue-queue, decision:prove-audit-audience-split, and several stories, and appears live in prose ('the intake queue the next plan-sprint draws from'), but the container got no artifact of its own: concept:issue owns row-and-fold semantics and the decision owns the storage shape, so a reader looking up 'intake queue' in the concept catalog finds it only inside neighbors.

## Candidates

- Promote an intake-queue concept owning the container (intake-not-tracker, who opens, who terminates) and re-point neighbors
- Amend concept:issue's What-it-is to explicitly own the queue container and record the fold as canonical

## Discussion

**The question.** "Intake queue" is a load-bearing noun across multiple artifacts and live prose without an artifact of its own — should it be promoted to its own concept, or is folding the container into `concept:issue` (as it stands today) the intended, canonical shape?

**A prior fact this issue's evidence needs re-read through: the intake's implementation changed underneath the corpus.** The plugin source that produced this corpus described (and `concept:issue` and `decision:append-only-issue-queue` still describe) a single append-only JSONL event log: `concept:issue`'s What-it-is says "Issues live as rows in the intake queue; an issue's current state is the fold of its rows by stable id"; `decision:append-only-issue-queue`'s Choice says "Issues live in a single append-only JSON-lines event log: one object per line, three event shapes (open, and the terminals promote and retire)." **That is no longer what the code does.** The current intake, per the shared `{{ISSUE-FILE-FORMAT}}` definition this very verification pass runs against, is one markdown file per issue under `.ok-planner/issues/`, named `<YYYY-MM-DD-HHMMSS>-<slug>.md`, with frontmatter `status:` moving forward through explicit values (`open` → `verified` → `promoted`/`retired`/`answered`) — there is no row, no fold-by-id, no JSONL file at all in the live mechanism. `decision:append-only-issue-queue`'s Proof ("The lifecycle verb's queue-integrity check fails on rows that do not parse...") and `concept:issue`'s Invariants ("Ids are stable fingerprints... writers fold first and append only genuinely new ids") describe machinery the project no longer runs. This drift is independent of, and prior to, the question this issue actually asks — but it means **whichever candidate is chosen, `concept:issue` and `decision:append-only-issue-queue` need their bodies rewritten to the file-per-issue reality regardless**; that rewrite is not itself a resolution of this issue.

**Where "intake queue" recurs as a noun, re-verified in the surviving prose (independent of the jsonl/file distinction):**
- `concept:issue`'s Boundaries: "the queue is intake, not a work tracker... The queue's storage shape is a decision (see also: append-only-issue-queue under decisions)."
- `decision:prove-audit-audience-split`'s Choice: "the audit produces work items for a human, appending judgment findings to the queue" and its Rationale: "an owner needs a durable, deduplicated agenda at calibration tempo."
- `concept:concept-artifact` doesn't itself use "intake queue," but is cited here as the artifact-kind definition the promotion candidate would have to conform to (one concept per noun, no instance enumeration, etc.) if a new concept file is written.
- Several stories (`plan-a-sprint`, `corpus-audit`) and this very batch's own instructions ("the intake queue the next plan-sprint draws from") use the phrase live.

So the noun is real and recurring regardless of storage-shape churn — the question of whether it deserves its own container concept survives the jsonl→file-per-issue change untouched; only the *content* of what such a concept (or the amended `concept:issue`) would say about storage needs updating to match.

**What a promoted concept would own that `concept:issue` currently doesn't cleanly separate.** Today `concept:issue` conflates two things: the *row/file* (what one issue is — category, lifecycle, kind) and the *container* (the intake directory as a whole — that it's intake-not-a-tracker, who may open into it, who alone may terminate out of it). A dedicated `intake-queue` concept would own the container-level claims — "many writers may open; only the planning ceremony terminates," the directory-as-agenda framing — while `concept:issue` would narrow to just the row/file shape. `decision:append-only-issue-queue` (once corrected for the file-per-issue reality) would remain the storage-shape decision either way, as a neighbor either concept points to.

**Candidates and their tradeoffs, undecided:**
- *Promote an intake-queue concept*, owning the container semantics and re-pointing `concept:issue`, `concept:finding`, `concept:sprint`, and the relevant decisions/stories at it. Gives "intake queue" a definition a reader can actually look up (today a catalog search for it finds nothing directly), cleanly separates row-shape from container-shape. Adds a fourth judgment-heavy rewrite to whatever sprint picks this up, on top of the mandatory jsonl-to-file-per-issue correction both `concept:issue` and `decision:append-only-issue-queue` already need.
- *Amend `concept:issue`'s What-it-is to explicitly own the container and record the fold as canonical.* Cheaper — one file changes instead of a new one plus several re-pointed neighbors — and keeps row and container together, which may be fine since in practice they're always discussed together. Leaves `concept:issue` doing double duty (defining what a single issue is *and* what the collection of them is), which is closer to what one Boundaries statement calling the fold "canonical" would need to justify explicitly rather than leave implicit.

**What the ruling must decide.** Whether "intake queue" gets its own concept file separating container semantics from `concept:issue`'s row semantics, or whether `concept:issue` is amended to explicitly own both — and, either way, that the same pass must correct `concept:issue` and `decision:append-only-issue-queue` from the retired JSONL-fold description to the current file-per-issue mechanism.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
