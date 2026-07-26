---
topic: ok-conduct
kind: concept
---

# The ok-conduct output style and the conduct version

## Description

`ok-conduct` is an output style shipped by ok-planner (`output-styles/ok-conduct.md`, frontmatter `keep-coding-instructions: true`): "Fall Guy Consulting code of conduct for Claude Code agents — layered on top of Claude Code defaults." The contract classifies it as "an additional, optional delivery-style layer, not the rules layer." Its rules, in order: **Keep it brief but clear**; **No time estimates** (absolute, relative, effort-framings, duration-based sequencing — "argue from what the work involves"); **Ask questions in prose, not forms** (no `AskUserQuestion`-class tools; options as plain text); **no ad hoc internal labels** when speaking to the user ("F3", "section 4.2" → say what it is); **ground every claim before you send**; **Compose in full, then deliver one concept per turn** (the longest rule — the unit of delivery is the turn; a segmentation pass on already-composed text; "Don't classify — cut"; a question counts as a concept; volume is never a license; two explicit licenses for a comprehensive message: the user asked for the full form, or the deliverable is a file/artifact); **Lists stay tight** (scannable lines; an item that grows a paragraph is the seam); **Run unsupervised** (defined genuine blockers; ambiguity is not one); **Completeness is the floor — overshoot, never undershoot** (the necessity test; "A deferral is a non-completion"; only overshoot is a legal divergence); **Never destroy uncommitted work** (fix forward; staging is not committing — "checkpointing into the index to protect the work is yours"); **Auto mode silences permission prompts, nothing more**; **Don't pull `.ok-planner/` into context unless directed there**.

The conduct carries its own **independent version**: "Conduct version: 1.10.0 (Jay)" as the first body line. Rules: "bump (and advance the animal one letter) only when the conduct body changes. The stamp must stay in the body (frontmatter is stripped from the system prompt) and keep its prefix (the session-start hook and `/ok-version` grep it)" (plugin CLAUDE.md). It is "hand-managed, untouched by a release" — `/release` only warns when the body changed without a bump. The true-up script reads the line at materialization time and stamps it into the project's hooks, so a project's banner reports the conduct it was trued up to, while `/ok-version` reports the conduct actually governing the session (from the live output style).

Because output styles load once and decay in attention, ok-planner's per-turn UserPromptSubmit hook re-injects a compressed reminder every prompt (see `session-context-injection`). Several conduct rules are deliberately duplicated into sprint boilerplate and skill prompts (never-destroy-work in prove and the fixer prompt; run-unsupervised and completeness in the sprint's how-to-execute) so non-conduct sessions still receive them. The conduct explicitly yields to skills with their own dialogue protocols ("Skills that explicitly call for user-facing dialogue ... follow the skill") and to autonomous-scope skills ("If a running skill explicitly directs you to make decisions autonomously within a defined scope (e.g., `ok-planner:discover-design`) ... follow the skill").

## Code surface

- `plugins/ok-planner/output-styles/ok-conduct.md` (146 lines).
- Version plumbing: `scripts/true-up` (CONDUCT_VERSION extraction), `scripts/hooks/session-start` banner, `skills/ok-version/SKILL.md`, `.claude/skills/release/SKILL.md` step 4 (warn-only check).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` Versioning ("Two **independent** version numbers"); README Versioning final paragraph; contract conformance note (optional layer).

## Adjacent topics

- `session-context-injection` (the refresher hook), `version-echo-verbs`, `suite-versioning`, `context-discipline` (the final rule), `certify-gate`/`sprint` (rule duplication into execution surfaces).

## Observations

- The animal codename advances one letter per bump (currently Jay = J); the convention is stated only as "advance the animal one letter."
- The conduct text has a typo ("for every sentence that asserts something, verify it. For any clain, you should be able to cite...") — "clain" for "claim" — in the grounding rule.
- The completeness rule and the sprint boilerplate/certify undershoot language are near-verbatim twins; the conduct is the behavioral layer, the skills the procedural layer, of the same 2026-06-06 design note.
- The conduct is delivered as an output style the user must opt into; nothing in true-up or /ok activates it, and no skill depends on it being active.
