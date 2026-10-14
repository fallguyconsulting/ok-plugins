---
topic: plumbline-config
kind: schema
---

# The plumbline config and citation tags

## Description

Project config lives at `.ok-plumbline/config.json` (optional; the binary "reads `.ok-plumbline/config.json` first and falls back to a root-level `.plumbline.json` from an earlier layout, so a not-yet-migrated project keeps working"). Fields: **`citations`** — an array of citation-tag declarations, "the only way to declare project-specific allowed comment forms; each entry must pair a tag with a structural resolution rule" — either `file_template` (contains `{slug}`; the comment is allowed only when the slug resolves to that file) or `appears_in_glob`. "Plumbline ships zero default citation tags; projects declare them." **`ignore`** — path prefixes to skip. **`checks`** — enable flags for `comment_hygiene` and `citation_resolution` (both default-enabled; "there is no soft start").

The canonical citation example is the ok-planner bridge: `{"tag": "@concept:", "file_template": ".ok-planner/design/concepts/{slug}.md"}` (and story/decision equivalents) — which the `starter` subcommand auto-proposes "when it detects `.ok-planner/`" along with adding `.ok-planner/` to ignore. Citation comment form is strict slug-only: "Each line is exactly `// @<tag>: <slug>` — no em-dash tail, no continuation prose, no trailing punctuation. Multiple clean lines may stack as one block ... Each slug is independently resolved" (cheatsheet). "Never invent a tag, never add one on your own initiative as documentation."

Config contents are owner-declared per the ownership rule: true-up "never invented or edited by the skill's own judgment"; the starter's detection is presented in conversation and transcribed on consent ("transcription of explicit answers, never a field the owner didn't confirm"). The migration from root `.plumbline.json` is "a mechanical relocation — contents untouched"; both files existing at once is the one owner-consent conflict. The pre-migration root location is also ok-plumbline's documented discovery marker (see `dot-directory-and-discovery`).

## Code surface

- `plugins/ok-plumbline/bin/plumbline` (config loading with fallback; citation resolution; `starter` detection: go.mod/package.json/generated dirs/`.ok-planner/` sibling).
- `plugins/ok-plumbline/skills/true-up/SKILL.md` §3 (migration bash), §5 (conversational declaration); `skills/starter/SKILL.md`.
- Test fixtures: `test/fixtures/citation-{file,glob}-{resolved,unresolved}/.plumbline.json` (root-format configs exercising both rule shapes).
- Live root-format instance: `plugins/ok-plumbline/.plumbline.json` (`{"ignore": ["test/fixtures/"]}`).

## Prose surface

- `plugins/ok-plumbline/README.md` "Lint, config, and CI" (the example config block); cheatsheet Comments section; manifesto glossary ("Citation tag").

## Adjacent topics

- `annotation-convention` (the tags' upstream convention), `plumbline-lint`, `plumbline-methodology`, `ownership-and-consent`, `stack-profile` (the declaration pattern), `dot-directory-and-discovery`.

## Observations

- Every fixture and the plugin's own config use the root `.plumbline.json` name — the current `.ok-plumbline/config.json` layout has no in-repo instance at all; the new layout exists only in prose and in the binary's lookup order.
- The `checks` flags allow disabling either check in config, while the starter/cheatsheet insist "there is no soft start" — the knob exists mechanically but is doctrinally discouraged; nothing reconciles the two.
- The README example wires ok-planner citations with `file_template` paths into `.ok-planner/design/` — making the plumbline lint the only *mechanical* enforcement anywhere in the suite of ok-planner's annotation-integrity rule (audit's check is prompt-driven).
