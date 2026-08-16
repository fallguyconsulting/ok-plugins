# Plumbline Cheatsheet

Materialized by ok-plumbline v18.6.1. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

Actionable conventions for this codebase under the Plumbline methodology. This file is the complete rule set. Core idea: comprehension is cheap, verification is not — make wrong edits fail mechanically.

## File Organization

- One feature per file, organized by feature not layer
- Keep directories shallow and feature-shaped: the tree mirrors the project's module architecture, never an abstraction taxonomy (`features/orders/create.py`, not `src/modules/features/orders/services/create/handler.py`)
- Tests co-located next to source
- ~500 line file guideline (edit/merge granularity, not readability), ~100 line function guideline
- Max 3 levels of nesting depth (use early returns)

## DRY and Abstraction

- Strict DRY: semantically identical logic lives in ONE place — never copy what must change together
- Do not extract trivia: a one-line expression at two sites is not a shared behavior; wrapping it adds a hop for nothing
- Shared code must resolve statically: named symbols, enumerable interface implementations, explicit composition — reachable by grep and types
- Forbidden: DI containers, reflection-driven dispatch, convention-based registration, behavior-modifying decorators, base classes / "Manager" abstractions
- Shared code carries a fast contract suite runnable in isolation; multiple implementations of one interface share a conformance suite
- Check speed is a placement criterion: prefer placements covered by fast isolated tests; "only testable end-to-end" is a design smell

## Mechanical Checks

- Every written constraint needs a check that fails on violation: layering → dependency lint, invariant → assertion + test, wire contract → conformance suite, boundary shape → type
- Lint config is authoritative: if prose and lint disagree, lint wins

## Comments

- **Do not write comments.** Default to zero. No prose comments — no narration, no "this does X", no "TODO", no rationale lines. The exemptions below are not invitations; write a comment only when something other than your own judgment requires it. The lint will catch leftovers, but the rule is prevention, not cleanup.
- Load-bearing information — a constraint, an invariant, an intentional choice — belongs in a name, a type, an assertion with a message, or a test. Reaching for a comment is a signal to move the content into code instead.
- **Machine directives** are written only when tooling requires one in that exact spot: license headers (`SPDX-License-Identifier:`, `Copyright`, `Licensed under`, `Dual-licensed`), lint suppressions (`eslint-disable`, `ts-ignore` / `ts-expect-error` / `ts-nocheck`, `noqa`, `pylint:`, `shellcheck`, `nolint`, `biome-`, `prettier-`, `tslint:`, `deno-`), build tags (`go:`), generated-file markers, C-pragmas, shebangs. Never add one as commentary. A directive exempts its own line, never prose written under it — the one continuation allowed is standard license/generated-file boilerplate under its opening notice.
- **Configured citation tags** are written only when a separate standard (e.g. ok-planner's design citation convention, declared in the plumbline config's `citations` array) directs you to link this code to a specific design artifact. Never invent a tag, never add one on your own initiative as documentation. Each line is exactly `// @<tag>: <slug>` — no em-dash tail, no continuation prose, no trailing punctuation. Multiple clean lines may stack as one block (e.g. `// @concept: cascade` then `// @story: parker`). Each slug is independently resolved against the configured rule. Plumbline ships zero default citation tags.
- **Documentation comments** are written only in files already carrying the opt-in marker `// @plumbline:allow-docstrings` (or `# @plumbline:allow-docstrings`). Do not add the marker yourself to license writing docstrings — it's set when the file is a public-API surface that needs documentation.
- Everything else is residue. The default action for any other comment — yours or pre-existing — is **delete**.

## Technical Writing

Markdown you write — docs, reports, design artifacts — is technical writing under the project's writing standard, materialized at `.ok-plumbline/docs/technical-writing.md`. The standard, verbatim:

- Name an actor as the subject and its action as the verb.
- Use active voice.
- Write in plain language. Choose the shortest word that is exact.
- Prefer verbs to nouns made from verbs.
- Make one claim per sentence. Keep sentences short.
- Use the same term for the same thing every time, even when it seems repetitive.
- Say it once and only once.
- Lead with the answer, then explain.
- Delete any phrase whose removal changes nothing.
- Write literally. Use a metaphor only where no plain sentence carries the meaning, and keep the same metaphor while it lasts.
- Include an example only where the sentence is unclear without it.
- State instructions positively: say what to do.

A consented `PreToolUse` hook injects this same standard before every tool call, whatever the tool; a `Stop` hook has the agent review the prose it wrote before it stops. This section is the ambient copy.

## Subjects and Practices — what this codebase does

The conventions above are ok-plumbline's, and universal. **Subjects and practices are this project's own**: a durable record of the policies this codebase actually follows, authored by the owner through the planning ceremony and cited from the sites they govern. The full authoring rules are in `.ok-plumbline/practice-definitions.md`; the short version:

- A **subject** (`.ok-plumbline/subjects/<slug>.md`) names an **enumerable population** of constructs — what a member is, and how a reader lists them. A population nobody can enumerate is not a subject; it is a topic.
- A **practice** (`.ok-plumbline/practices/<slug>.md`) says, affirmatively, what this codebase does about some members of one subject: what the code is, the condition under which the practice governs, and the maintenance operation it buys.
- **A departure is a competing practice, never an exemption.** No marker silences a check. A site that does not follow one practice cites a different one whose condition covers it — a claim a reviewer can check and be wrong about, where a suppression asserts nothing. Where two conditions match, the more specific governs.
- **Cite the practice at the site it governs**, in the strict citation grammar above: `// @practice: <slug>` on its own line, tag and slug and nothing else. Do it when you write the code — that is the moment you know what you are writing, and it is what the coverage audit later reads instead of tracing.
- **When no practice covers a construct a subject claims, that is a gap** — the owner's question, not yours to close by inventing one. Surface it; never write a practice on the owner's behalf.
- Violations of a ruled practice are **work**, not questions: they become remediation in a future sprint, never issues.

`@subject:` and `@practice:` resolve only where this project has declared them in `.ok-plumbline/config.json`. If it has not, the tags are ordinary comments and the lint rejects them — declare them (via `/ok`) before citing.

## Uniformity

- One idiom per job, repo-wide; never introduce a second way to do something
- When improving an idiom, sweep the old one out everywhere in the same change — no coexisting dialects
- Prefer plain over clever; lint-enforce whatever uniformity can be

## Explicit Code

- Explicit parameters over dependency injection
- Explicit registration of routes/handlers/bindings — never path- or name-derived
- Configuration as visible objects, not scattered env lookups

## Types

- Required at boundaries: API inputs/outputs, DB models, feature interfaces, config
- Flexible internally

## Errors

- Return errors explicitly (error returns or result types) for expected failure cases
- Catch specific exception types; re-raise what you cannot handle — never catch a bare top-level type

## Testing

- Name tests for the scenario, not the implementation (`test_create_order_fails_when_inventory_insufficient`) — test names are the load-bearing documentation for invariants and deliberate choices
- Each test file runs independently: no shared fixture files a reader must understand to read the tests

## Repo-Wide Changes

- Shared-code change: edit the one definition, let compiler + contract suites enumerate blast radius, fix all consumers in the same change
- Idiom change: sweep all instances in the same change, add lint so the old idiom cannot return

## Tooling

The ok-plumbline family ships:

- `plumbline <path>` — the lint binary; runs two checks: `comment-hygiene` (the rule above) and `citation-resolution` (every configured citation's slug must resolve). Exit 0 clean, 2 violations, 1 internal error.
- `/ok` — the suite front door: installs or refreshes `.claude/rules/plumbline-cheatsheet.md` (and the whole vendored layer) from the carried canonical version, and walks the owner through declaring the citation tags.
- `/audit` — the suite's periodic run. Over this estate it reports practice coverage per subject (the population checked, the members nothing accounts for) and sweeps the lint over the whole project, grouping findings into a remediation plan. It fixes nothing.
- `/plan-sprint` — the suite's planning ceremony, where new subjects and practices are drafted as corpus deltas.
- A `PreToolUse` hook, on every tool call, injects the writing standard as context — the main session and dispatched subagents alike, a Bash heredoc as much as a Write.
- A `PostToolUse` hook, on every tool call, runs the lint over the file an Edit/Write touched — violations block (exit 2) so the agent fixes them in the same turn — and detects prose the call wrote: file content, `new_string`, a heredoc's target, a commit message. Detection flags the agent's turn; it blocks nothing.
- A `Stop` and `SubagentStop` hook reads that flag. When the agent wrote prose this turn, it blocks the stop once with one instruction: review every sentence written since the last user message against the standard, rewrite what fails, then stop. The retry stops cleanly. The agent judges its own prose, in its own context; no second model is called.
- Project config lives in `.ok-plumbline/config.json` (optional). The `citations` array adds project-specific structured-tag exemptions (each pairs a tag with a resolution rule); `ignore` adds paths to skip.
