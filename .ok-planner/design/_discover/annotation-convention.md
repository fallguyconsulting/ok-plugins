---
topic: annotation-convention
kind: discipline
---

# The @concept: / @story: / @decision: annotation convention

## Description

Code links back to the design corpus with three in-source annotations: `@concept: <slug>` ("load-bearing site where a concept is enforced or expressed"), `@story: <slug>` ("load-bearing site for delivering a story's user-observable outcome — the wired entry point, the handler that produces the observable effect, the value-delivering component"), `@decision: <slug>` ("site that embodies a technical decision"). Each annotation "marks a load-bearing site, not every file that happens to touch the artifact."

The integrity rule (`{{ANNOTATION-INTEGRITY-RULE}}`): every annotation's slug MUST resolve to a live artifact at the corresponding path (`design/<kind>s/<slug>.md`). Two failure modes: **dangling** (slug exists at no kind — never written, renamed, or retired without sweeping) and **kind-mismatch** (slug exists at a different kind). "The slug stamped into the code is the *exact* basename of the design artifact's filename. Paraphrasing ... is dangling, even when the short form reads naturally." Checked by `/audit` whole-corpus via `rg -n '@(concept|story|decision):\s*\S+'`; dangling/mismatched annotations are mechanical findings fixed in-cycle. Rationale: "an annotation either resolves to an artifact of the named kind, or it should not exist at all."

Two artifacts together replace an external index: the auto-generated catalog TOCs (what exists) and the grep-able annotations (where each artifact is load-bearing). **Rollout is incremental by rule**: "any time an agent consults an artifact to understand or modify a file, it leaves the annotation at the most-specific load-bearing site so the next agent doesn't have to re-do the lookup. ... No bulk greenfield annotation pass is needed" — documented in the materialized `.ok-planner/CLAUDE.md` so it applies project-wide. discover-design explicitly does *not* introduce annotations ("That's a separate convention introduced after the prescriptive design is stable").

The convention is bridged to ok-plumbline: under plumbline's no-comments rule, these annotations survive as **configured citation tags** — the starter config wires `@concept:`/`@story:`/`@decision:` with `file_template: ".ok-planner/design/<kind>s/{slug}.md"` when it detects `.ok-planner/`, and plumbline's `citation-resolution` check then enforces slug resolution mechanically on every edit (the lint-side twin of audit's integrity pass). Citation-comment form is strict: "Each line is exactly `// @<tag>: <slug>` — no em-dash tail, no continuation prose, no trailing punctuation."

## Code surface

- `artifact-definitions.md` `{{ANNOTATION-INTEGRITY-RULE}}`; discover-design "The `@concept:`, `@story:`, `@decision:` annotation convention" section.
- Audit pass 2 "Annotation integrity (mechanical)"; sketch step 3 (grep `@concept:` during light context check).
- `plugins/ok-plumbline/bin/plumbline` citation-resolution check; `skills/starter/SKILL.md` (ok-planner sibling detection); `plugins/ok-plumbline/README.md` example config.
- `scripts/ok-planner-CLAUDE.md` (the incremental-rollout rule as materialized).

## Prose surface

- `plumbline-cheatsheet.md` Comments section (citation-tag form rules); plumbline manifesto glossary ("Citation tag").

## Adjacent topics

- `design-corpus` (annotations are the coverage link), `audit-verb`, `plumbline-config`, `self-containment-rule` (the reverse direction: design never cites code).

## Observations

- The annotation search commands vary in exclusion lists: audit pass 2 excludes "`.ok-planner/`, `.git/`, build outputs, vendored dependencies"; audit's integrity sweep says "skipping `_retired/`". The exclusions live in prompt text, re-stated per skill.
- ok-planner declares "ok-planner has no opinion on that vocabulary" about projects' other structured annotations, while plumbline *does* have an opinion (any non-configured tag is residue) — composition works only when the project declares its tags in the plumbline config.
- Whitespace tolerance differs between the two enforcement layers in principle (audit's `\s*` regex vs plumbline's exact-line rule); no live conflict observed.
