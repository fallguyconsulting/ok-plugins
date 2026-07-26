---
topic: plumbline-methodology
kind: concept
---

# The Plumbline methodology (code that runs true under agentic maintenance)

## Description

Plumbline is the methodology ok-plumbline packages: "a methodology for writing code that AI coding agents can safely maintain in parallel, across model generations, and at scale." Its premise is a **cost model**: "Discipline does not compose across sessions; checks do. ... The correct response is to trust per-session discipline *less* over time, not more, and to convert every load-bearing convention into a mechanical check." Three goals in priority order: make wrong edits fail mechanically; isolate blast radius and make it enumerable; be understandable where it is written.

Eight principles (manifesto): Locality of Behavior (credited to Carson Gross/Richard Gabriel); **strict DRY through statically-resolvable abstraction** ("no 'this similar-looking code is intentionally separate' carve-out"; friendly = named symbols, enumerable interfaces, explicit composition; hostile = DI containers, reflection dispatch, convention-based registration, behavior-modifying decorators — "forbidden not because it is hard to read but because it is invisible to grep, to the type checker, and to static analysis"); **every contract has a mechanical check** (the conversion table: layering→dependency lint, invariant→assertion+test, wire contract→conformance suite, boundary shape→type, style→lint; "If lint and prose disagree, lint wins"; "check speed is an architectural property" and a placement criterion); explicit over implicit; **uniformity by precedent** ("the first instance of any pattern is load-bearing"; "coexisting dialects compound rather than decay"; idiom improvements sweep the old idiom out "everywhere in the same change"; "Local cleverness is a cost, not a craft"); typed boundaries, flexible interiors; co-locate everything related; **code is the documentation; comments are residue**.

The comment rule is the sharpest edge: "**By default, comments are not permitted in source files.**" Three structural exemptions only: **machine directives** (license headers, lint suppressions, build tags, generated-file markers, shebangs — "tooling syntax, not prose"); **configured citation tags** (declared in the project config, slug-only form, each resolving structurally); **documentation comments** (JSDoc/GoDoc adjacent to declarations, only in files carrying the opt-in marker `@plumbline:allow-docstrings`). "Everything else is residue. The default action is delete, including in code you didn't write — it will be regenerated as precedent otherwise." Rationale is agent-specific: comments are "generation residue" and a drift hazard with a sharper edge for agents — "an agent weights comments as *intent signals* — a confidently wrong comment can pull an agent toward 'fixing' correct code to match it." The style guide adds the numeric conventions: ~500-line file guideline ("edit/merge granularity, not readability"), ~100-line functions, max 3 nesting levels, one-feature-per-file organized by feature not layer, tests co-located.

Lineage (README): Cold Read v1 (comprehension-optimized) → Cold Read v2 (verification-reweighted) → Plumbline v1; v0.2 added the lint with a tag vocabulary; v0.4 replaced the tag vocabulary with the strict no-comments rule because "experience showed the tag vocabulary was a judgment-call seam that agents reliably routed around. The new rule has only structural exemptions."

## Code surface

- `plugins/ok-plumbline/docs/plumbline-manifesto.md` (171 lines), `docs/plumbline-style-guide.md` (385 lines), `docs/plumbline-cheatsheet.md` (the materialized compact form).
- The rule mechanized: `bin/plumbline` comment-hygiene check (machine-directive pattern table, comment grammars per extension, docstring opt-in detection).

## Prose surface

- `plugins/ok-plumbline/README.md` ("The rule on comments", "Lineage"); the manifesto's "Addressing Objections" and Glossary (defines plumb, statically resolvable, mechanical check, generation residue, drift, citation tag, docstring opt-in marker).

## Adjacent topics

- `plumbline-lint`, `plumbline-config`, `annotation-convention` (ok-planner's tags as configured citations), `context-discipline` (a prose-discipline counterpoint inside the same suite).

## Observations

- The methodology's own standard applied to this repo is instructive: the suite's skills and hooks carry extensive prose comments (bash hook headers, JS hook rationale blocks) — plumbline's rule governs *consumer source files* under lint, and the plugin's `.plumbline.json` ignores only `test/fixtures/`, so its own JS files pass presumably via the machine-directive and structural exemptions or are simply not linted in this repo (no `.ok-plumbline/` estate here).
- The manifesto is the only document in the suite with external references (HTMX essay, Patterns of Software, Bogard, Pragmatic Programmer).
- "Plumbline is strict by default (no comments ...); there is no 'soft start' with checks disabled" (starter skill) — the budget ratchet, not check-disabling, is the sanctioned adoption easing.
