---
issue: design-notes-unmarked-superseded
kind: discover
category: vestigial
artifacts:
  - decision:no-execution-engine
status: verified
opened: 2026-07-25T02:17:33Z
---

# Retired-architecture design notes are never marked superseded

## Problem

In-plugin design notes describe the flip-gated engine's skills, escalation kinds, and file paths, none of which exist anywhere today; they are the largest block of dead prose in the plugin and carry no superseded marking.

## Candidates

- Retire the notes to an archive location via a sprint and record the lineage only in git history
- Mark the notes superseded in place with a pointer to the current execution model

## Discussion

The question: should the in-plugin `design-notes/` files describing the retired flip-gated execution engine be moved to an archive location, or marked superseded in place — since they currently carry no marking at all and describe machinery that no longer exists?

Where it comes from: filed against decision:no-execution-engine. Re-verified against current code: `plugins/ok-planner/design-notes/` contains two files, `2026-06-05-flip-gated-execution.md` (415 lines) and `2026-06-06-completeness-contract.md` (99 lines), totaling 514 lines — confirmed the largest block of prose in the plugin describing machinery not otherwise documented. The first file's own header names its scope as "`write-plan`, the workflow execution engine (reclaiming the name `execute-plan`), `execute-plan-in-worktree`, and the `ok-planner` skill table" — none of which exist in the current plugin (a search of `plugins/ok-planner/skills/` finds no `write-plan`, `execute-plan`, or `execute-plan-in-worktree` skill directories). Neither file carries any top-level "superseded," "retired," or "deprecated" marker at the file or header level (a grep finds only internal, mid-body uses of "superseded" describing one internal mechanism replacing another within the old design, not the file's status as a whole). No skill in the plugin references `design-notes/` at all (the only hit for that string in the codebase is the file's own self-reference) — confirming the files are inert, unread by any current process.

What the corpus says: decision:no-execution-engine's Rationale states plainly "This reverses the suite's own earlier flip-gated execution engine, whose verification burden moved into the corpus itself (proofs with exhibited falsifiers) and the terminal gates," and its Alternatives names "A workflow engine with plan documents, gate pre-flight, and escalation taxonomy — the suite's own pre-4.0 architecture, retired" as the rejected alternative. So the corpus already records, at decision altitude, that the engine these design notes describe was built and then retired — the fact the issue is concerned with is not missing from the corpus. What the decision does not address is what should happen to the specific in-plugin `design-notes/` files that predate it — it has no occasion to, since `design-notes/` is plugin-development scaffolding, not a design-corpus artifact the decision would cite (self-containment forbids a decision from naming plugin file paths in the first place). concept:design-corpus's Boundaries confirm the discovery scaffold (`_discover/`) is the one exempted, point-in-time location the current-state-only rule doesn't apply to — `design-notes/` is a different, older kind of scaffolding not covered by that exemption at all. concept:estate and concept:sketch (also surfaced for this batch) describe consumer-project-side content (the `.ok-planner/` estate, and sketches within it) and have no bearing on an in-plugin-source design note — the wrong altitude entirely for this question.

What the code does today: 514 lines of unmarked, unread, pre-4.0 design prose sit in the plugin's own source tree, describing a `write-plan`/`execute-plan`/`execute-plan-in-worktree` engine and an escalation taxonomy that decision:no-execution-engine confirms was deliberately retired suite-wide.

Candidates as filed: retire the notes to an archive location via a sprint and record the lineage only in git history (git already has the full history; nothing is lost by deletion or by moving the two files under, say, a `design-notes/_retired/` or out of the plugin source entirely); mark the notes superseded in place with a pointer to the current execution model (e.g. a one-line header banner on each file pointing at decision:no-execution-engine, keeping the files as a readable historical record for anyone who stumbles onto them).

What the ruling must decide: whether these two design-note files should be removed from the live plugin tree (relying on git history and decision:no-execution-engine as the record) or kept in place with an explicit superseded marker pointing at the decision that replaced them.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
