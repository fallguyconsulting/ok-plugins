---
issue: vendored-fallback-soft-edge
kind: discover
category: inconsistent
artifacts:
  - decision:per-project-pinning
status: verified
opened: 2026-07-25T02:17:33Z
---

# Prefer-vendored skills silently fall back to the plugin copy

## Problem

Several skills prefer the vendored binary but fall back to the installed plugin's copy on an unintegrated project with only a note — a soft edge on an otherwise strict pinning discipline that can run rules the project never pinned.

## Candidates

- Amend decision:per-project-pinning Choice to make the fallback an explicit consent point or a hard stop
- Record the fallback as sanctioned bootstrap behavior in the decision's Choice

## Discussion

**The question.** Several ok-plumbline skills fall back to running the installed plugin's own lint binary, with only a comment, when a project has no vendored copy. Does this fallback conform to the per-project-pinning discipline, and if it's a genuine exception, should it become an explicit consent point, a hard stop, or a named, sanctioned exception?

**Where it comes from, re-verified against current code.** `plugins/ok-plumbline/skills/explain/SKILL.md` (and identically `suggest`, `patterns`, `slug`) carries:
```
# Prefer the project's vendored binary so the explanation matches the rules
# this project actually lints against.
bin=".ok-plumbline/bin/plumbline"
[ -x "$bin" ] || bin="${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline"
```
— a silent fallback to the plugin-root binary, gated only by a comment explaining intent, with no consent question and no report line telling the owner it happened. This is exactly what the Problem describes and it is still live.

**What the corpus says.** `decision:per-project-pinning`'s Choice is unambiguous on its face: "everything downstream prefers the project copy over the installed plugin's, and only the lifecycle verb's entry point and pre-estate bootstrap verbs legitimately run from the plugin root." `explain`, `suggest`, `patterns`, and `slug` are none of those two things by name — they are neither `true-up` (the lifecycle verb) nor bootstrap verbs in the sense `starter` is (proposing a config before one exists). Read literally, the decision already forbids what these four skills do, which would make this a mechanical compliance finding rather than an issue — except the decision's own Rationale is about *reproducibility of what got audited*, and these four verbs are explicitly read-only, non-authoritative, exploratory tools (`explain` shows canonical definitions, `slug` turns prose into a slug) usable meaningfully even before a project has ever run `true-up` — arguably closer in spirit to "pre-estate bootstrap" than to the lint-enforcement path the decision is really guarding. Nothing in the corpus states which reading governs, which is exactly why this needs owner judgment rather than a mechanical fix. `concept:materialized-artifact`'s Boundaries repeat the same two-exception shape ("the only thing that legitimately runs from the plugin copy is the lifecycle verb's own entry point, plus bootstrap verbs that by definition run before anything is vendored") without settling the ambiguity either. `story:edit-time-lint-enforcement` and `decision:ratchet-over-soft-start` don't bear on this directly — both concern the *enforcement* verb (the post-edit hook, which the code confirms sources only `.ok-plumbline/hooks/post-edit.js`, no fallback found there) and the backlog-adoption ratchet, a different kind of "softness" (accepting existing debt) than a silent binary-source fallback.

**What the code does today, precisely.** The blocking enforcement path (`post-edit.js`, materialized) has no fallback — it simply no-ops on an unintegrated project per `decision:filesystem-discovery-markers`. The fallback exists only in four *advisory* verbs (`explain`, `suggest`, `patterns`, `slug`), all read-only and none of them the thing that actually blocks an edit. So the "soft edge" cannot silently change enforcement outcomes; at most it can make an advisory tool's output reflect the plugin's newer rules rather than the project's older pinned ones, on a project that has adopted plumbline but has a stale or missing vendored copy — or one that hasn't adopted it at all.

**Candidates and their tradeoffs, undecided:**
- *Make the fallback an explicit consent point or a hard stop.* Closes the ambiguity cleanly and matches the letter of `decision:per-project-pinning`, but adds friction to genuinely exploratory, low-stakes verbs (`slug`, `explain`) that arguably exist precisely to be usable before or around adoption; a hard stop in particular would make these tools unusable on any project that hasn't (yet) run `true-up`.
- *Record the fallback as sanctioned bootstrap behavior in the decision's Choice.* Matches actual current behavior and the tools' non-authoritative nature with zero code change, but stretches "pre-estate bootstrap verbs" to cover four skills that aren't literally bootstrapping anything (they don't write an estate), which may itself invite the next reader to ask the same question again.

**What the ruling must decide.** Whether `explain`/`suggest`/`patterns`/`slug` falling back to the plugin's own binary on an unintegrated or unvendored project is legitimate pinned-bootstrap-adjacent behavior to name explicitly in `decision:per-project-pinning`, or a discipline gap that needs a consent question or a hard stop.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
