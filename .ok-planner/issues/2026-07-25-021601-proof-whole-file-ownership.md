---
issue: proof-whole-file-ownership
kind: discover
category: proof
artifacts:
  - decision:whole-file-ownership
status: verified
opened: 2026-07-25T02:16:01Z
---

# Ownership rule has no violation-detecting check

## Problem

Diagnosis verifies plugin-owned fidelity, but nothing fails if a plugin edits a human-edited file such as the consumer rules file or memory file.

## Candidates

- Amend decision:whole-file-ownership Proof to name an ownership-boundary check once one exists
- Record the boundary as contract-prose-governed and retire the proof expectation

## Discussion

**The question.** `decision:whole-file-ownership` requires — by the corpus's own definition of what a decision artifact is — a mandatory `Proof:` field naming the mechanical check that fails if the choice is silently violated. Its choice has two halves — (a) a plugin overwrites its own files wholesale, never merges, and (b) a plugin never edits a file a human also edits (the consumer's root memory file, e.g. `CLAUDE.md`, and the consumer's own `.claude/rules/*.md` files it does not own). No check today detects a violation of half (b): nothing fails if a plugin's lifecycle verb writes into the consumer's memory file or a human-owned rules file. Does the decision get an enforcing check for half (b), or does the corpus formally accept that this half is governed by contract prose alone (with no proof), and is downgraded from "decision" to something un-enforced?

**Where it comes from, re-verified against current code.** The Problem statement holds up. I re-checked the three true-up implementations in this monorepo:
- `plugins/ok-planner/scripts/true-up` (bash): overwrites `.ok-planner/CLAUDE.md` and `.claude/rules/ok-planner-cheatsheet.md` only — both plugin-owned paths — but there is no diagnose step, before or after, that verifies it wrote nowhere else or that the consumer's own memory file / other rules files were untouched.
- `plugins/ok-workspaces/scripts/true-up.js` and its companion `diagnose.js`: `diagnose.js` is a genuine read-only drift report, but every check in it (`check('...')`) compares a plugin-owned artifact against its expected content/version — it verifies *fidelity of what the plugin owns*, never *absence of writes outside what it owns*.
- No `@decision:whole-file-ownership` (or any paraphrase) annotation exists anywhere in `plugins/` today — confirmed by a repo-wide grep. The decision's own `## Proof` field already says as much: "No enforcing check exists today... the boundary lives in contract prose and skill text. Filed to the intake queue for owner calibration" — i.e., the artifact itself already flags the gap the issue restates; nothing has rotted, the code and the artifact still agree.

**What the corpus says.** `decision:whole-file-ownership` states the choice and rationale but, per the above, its own Proof field already concedes no check exists — it does not resolve which of the two candidate directions to take, it only names the gap. `concept:materialized-artifact` Invariants say "Diagnosis verifies fidelity against the canonical copy for the installed version" — that protects direction (a) (plugin-owned files converge correctly) but says nothing about direction (b) (a plugin never writing outside what it owns). `concept:cheatsheet` Boundaries says "the project's other rules files are never touched, per the ownership rule (see also: whole-file-ownership under decisions)" — an assertion of the same untested boundary, not a check. `concept:decision-artifact` Invariants are unambiguous that "a decision for which no violation-detecting check can be named is either a default (delete it) or an unenforced intention (an issue is filed for owner calibration)" — which is exactly the state this decision is in, and exactly why this issue exists. None of the corpus artifacts decide between naming a future check and retiring the proof expectation; the corpus is silent on the resolution, not on the gap's existence.

**What the code does today.** Every current true-up/converge implementation (ok-planner's bash script, ok-workspaces' `true-up.js`) writes only to a small, hardcoded set of paths it owns (its own `.ok-planner/CLAUDE.md`, its own named cheatsheet file under `.claude/rules/`, its own materialized hooks/scripts directories). None of the three plugins in this repo currently write to the consumer's root memory file or to a rules file it doesn't itself name. So today the boundary holds by construction (every writer's target-path list is small and hand-audited) — but nothing mechanically enforces that a future or careless change stays within it.

**Candidates developed.**
- *Amend the Proof to name a check once one exists* (filed). Keeps the decision as a decision with the expectation deferred; requires someone to actually build the check before the Proof field can be truthfully filled in — until then the decision remains technically non-compliant with `decision-artifact`'s own invariant, which is the state it is in right now.
- *Retire the proof expectation, record the boundary as contract-prose-governed* (filed). Converts this half of the choice into an unenforced convention rather than a decision — `decision-artifact`'s invariant reads such a thing as "either a default (delete it) or an unenforced intention" rather than a decision proper; taken literally this would mean splitting or downgrading `whole-file-ownership` rather than merely editing its Proof field, since a decision without a provable falsifier is not really a decision by the corpus's own definition.
- *A third shape surfaced by this reading, not filed*: build the check as a monorepo-level static assertion over the true-up/converge implementations themselves (e.g., a lint or a proof script that enumerates each plugin's declared owned-path set — its materialized artifacts and its one cheatsheet — and fails if any writer touches a path outside that set, especially the consumer's root memory file or any rules file not in the set). This is concretely producible today: all three implementations already have small, enumerable target-path lists, confirmed above. It would give the decision a real falsifier (a writer target added outside the declared set turns it red) without requiring runtime detection inside every consumer project.

**What the ruling needs to decide.** Should `decision:whole-file-ownership` keep its proof obligation and get a real enforcing check (and if so, roughly what shape — consumer-side runtime detection, or a monorepo-level static check over the true-up implementations), or should the human-file-boundary half of the choice be recorded as contract-prose-governed with no proof (and if so, does that require splitting or reclassifying the decision per `decision-artifact`'s own invariant, or is amending its Proof field to say so sufficient)?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
