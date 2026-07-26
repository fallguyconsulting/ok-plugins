---
issue: proof-lockstep-suite-version
kind: discover
category: proof
artifacts:
  - decision:lockstep-suite-version
status: verified
opened: 2026-07-25T02:16:01Z
---

# Lockstep suite versioning has no enforcing check

## Problem

Nothing fails if plugin manifests drift apart between releases or one is bumped alone; the release skill converges disagreement (picks the highest) rather than rejecting it.

## Candidates

- Amend decision:lockstep-suite-version Proof to name a new mechanical manifest-equality check once one exists
- Retire the Proof expectation and accept release-time convergence as the mechanism

## Discussion

**The question.** `decision:lockstep-suite-version` requires every plugin manifest to carry the same semantic version, but nothing anywhere fails if that stops being true — should the corpus keep this as an open enforcement gap (and name a check to eventually build), or accept that the choice is enforced only by the release procedure's own convergence behavior and stop claiming a check is owed?

**Where it comes from, re-verified.** The Problem's evidence still holds against current code. `.claude/skills/release/SKILL.md` step 2 ("Read the current suite version") reads every `plugins/*/.claude-plugin/plugin.json`'s `version` field; if they differ, it takes the **highest** and proceeds — it explicitly documents this as intentional ("Never pick a lower one: a plugin's version is Claude Code's update key, and lowering it strands existing installs on the old files") rather than as an error condition. Nothing aborts the release, and nothing outside `/release` ever inspects the manifests at all: there is no CI in this repo (`.github/workflows` does not exist) and no other script reads `plugin.json`. So a manifest hand-edited between releases, or a manifest that `/release` itself somehow skipped, would sit drifted indefinitely with no signal to anyone. The issue's evidence has not rotted — it describes the current release skill exactly.

**What the corpus says.** `decision:lockstep-suite-version`'s own Proof section already states the gap in these words: "No enforcing check exists today: nothing fails if a manifest is bumped alone or the versions drift apart between releases; the release procedure converges rather than rejects. Filed to the intake queue for owner calibration." — i.e. the decision does not resolve this itself; it names this exact issue as the open question. `concept:plugin`'s Invariants list "Every plugin carries the same suite version, stamped at release (see also: lockstep-suite-version under decisions)" as a stated invariant, without qualification — so the concept catalog currently asserts a stronger guarantee than the code enforces. `concept:decision-artifact`'s Invariants are explicit that an unenforceable decision has exactly two legitimate resting states: "a default (delete it)" or "an unenforced intention (an issue is filed for owner calibration)" — which is precisely the fork this issue exists to resolve; the corpus deliberately declines to pick between them and defers to the owner. No other artifact read (`concept:conduct`, `decision:no-execution-engine`, `decision:whole-file-ownership`, `concept:true-up`) bears on the mechanism, only on the general shape of "decisions may ship with no enforcing check yet, filed to intake" — a pattern this issue shares with its siblings `proof-no-execution-engine` and `proof-whole-file-ownership`, filed in the same batch.

**What the code does today.** All four plugin manifests currently agree at `8.0.0`. The only writer of `version` fields is `/release` step 5, which stamps the same new version into every manifest on every release — so drift can only appear from an out-of-band hand-edit, or from a bug in the release procedure itself, between releases. There is no periodic or CI-triggered check; drift, if introduced, would only surface the *next* time someone reads `/release`'s step 1/2 survey output (or reads the manifests directly), and even then `/release` treats it as something to converge past, not something to report as a defect worth fixing before proceeding.

**Candidates developed.**
- *Amend the Proof to name a new check, once built* (filed) — keeps the decision claiming enforcement is coming; doesn't resolve anything until that check is actually written, so the corpus keeps citing a future promise (which `{{CURRENT-STATE-ONLY-RULE}}` generally disfavors) unless a follow-on sprint is committed to promptly.
- *Retire the Proof expectation, accept convergence as the mechanism* (filed) — rewrites the Proof section to describe convergence itself as the discipline (self-healing rather than rejecting), and drops the "filed to intake" language. Honest about what exists today, but permanently accepts that a manifest can sit drifted between releases with zero signal — including the case of a hand-edit that nobody runs `/release` to fix.
- *Change the choice itself: make `/release` reject drift instead of converging* (not filed, surfaced by this reading) — add a preflight check to `.claude/skills/release/SKILL.md` step 2 that aborts if the manifests disagree at the start of a release, rather than silently taking the highest. This is mechanically the simplest of the three (manifest version equality is a trivial string comparison, unlike the harder-to-check absence-based decisions `no-execution-engine` and `whole-file-ownership`), and it would let the Proof section name a real, already-producible falsifier ("hand-edit one manifest to a different version, run `/release`, confirm it aborts"). The tradeoff: it changes `decision:lockstep-suite-version`'s Choice/Rationale, not just its Proof, since "converges disagreement (picks the highest)" is documented release behavior today and this candidate replaces it with "rejects disagreement." It also only catches drift at the next release, not the moment drift is introduced — a gap this repo has no CI to close today (nothing in `.github/workflows`), unlike `ok-plumbline`'s own `ci`/`budget` skills, which exist for consumer projects but are not wired up for this repo itself.

**What the ruling needs to decide.** Does this decision get a real enforcing check (and if so, does it live inside `/release`'s own preflight, rejecting drift instead of converging past it — which would also mean rewording the Choice, not only the Proof), or is the Proof section rewritten to describe release-time convergence itself as the accepted, permanent mechanism?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
