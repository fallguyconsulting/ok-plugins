# Plumbline Cheatsheet

Materialized by ok-planner v24.1.0. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

Actionable conventions for this codebase under the Plumbline methodology. This file is the complete rule set. Core idea: comprehension is cheap, verification is not — make wrong edits fail mechanically.

## File Organization

- One feature per file, organized by feature not layer
- Keep directories shallow and feature-shaped: the tree mirrors the project's module architecture, never an abstraction taxonomy (`features/orders/create.py`, not `src/modules/features/orders/services/create/handler.py`)
- ~500 line file guideline (edit/merge granularity, not readability), ~100 line function guideline
- Max 3 levels of nesting depth (use early returns)

## DRY and Abstraction

- Strict DRY: semantically identical logic lives in ONE place — never copy what must change together
- Do not extract trivia: a one-line expression at two sites is not a shared behavior; wrapping it adds a hop for nothing
- Shared code must resolve statically: named symbols, enumerable interface implementations, explicit composition — reachable by grep and types
- Forbidden: DI containers, reflection-driven dispatch, convention-based registration, behavior-modifying decorators, base classes / "Manager" abstractions

## Mechanical Checks

- Every written constraint needs a check that fails on violation: layering → dependency lint, invariant → assertion with a message, boundary shape → type
- Lint config is authoritative: if prose and lint disagree, lint wins

## Comments

- **Do not write comments.** Default to zero. No prose comments — no narration, no "this does X", no "TODO", no rationale lines. The exemptions below are not invitations; write a comment only when something other than your own judgment requires it. The lint will catch leftovers, but the rule is prevention, not cleanup.
- Load-bearing information — a constraint, an invariant, an intentional choice — belongs in a name, a type, or an assertion with a message. Reaching for a comment is a signal to move the content into code instead.
- **Machine directives** are written only when tooling requires one in that exact spot: license headers (`SPDX-License-Identifier:`, `Copyright`, `Licensed under`, `Dual-licensed`), lint suppressions (`eslint-disable`, `ts-ignore` / `ts-expect-error` / `ts-nocheck`, `noqa`, `pylint:`, `shellcheck`, `nolint`, `biome-`, `prettier-`, `tslint:`, `deno-`), build tags (`go:`), generated-file markers, C-pragmas, shebangs. Never add one as commentary. A directive exempts its own line, never prose written under it — the one continuation allowed is standard license/generated-file boilerplate under its opening notice.
- **Configured citation tags** are written only when a separate standard (e.g. ok-planner's design citation convention, declared in the `citations` array of `.ok-planner/config.json`) directs you to link this code to a specific design artifact. Never invent a tag, never add one on your own initiative as documentation. Each line is exactly `// @<tag>: <slug>` — no em-dash tail, no continuation prose, no trailing punctuation. Multiple clean lines may stack as one block (e.g. `// @concept: cascade` then `// @story: parker`). Each slug is independently resolved against the configured rule. Plumbline ships zero default citation tags.
- **Documentation comments** are written only in files already carrying the opt-in marker `// @plumbline:allow-docstrings` (or `# @plumbline:allow-docstrings`). Do not add the marker yourself to license writing docstrings — it's set when the file is a public-API surface that needs documentation.
- Everything else is residue. The default action for any other comment — yours or pre-existing — is **delete**.

## Technical Writing

Markdown you write — docs, reports, design artifacts — is technical writing under the project's writing standard, materialized at `.ok-planner/docs/technical-writing.md`. The standard, verbatim:

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

This section is the standard's ambient copy: it is in context for every write.

## Subjects and Practices — what this codebase does

The conventions above are the Plumbline methodology's, and universal. **Subjects and practices are this project's own**: a durable record of the policies this codebase actually follows, authored by the owner in ok-planner's planning session (`/plan-sprint`) and cited from the sites they govern. The full authoring rules are in `.ok-planner/practice-definitions.md`; the short version:

- A **subject** (`.ok-planner/subjects/<slug>.md`) names an **enumerable population** of constructs — what a member is, and how a reader lists them. A population nobody can enumerate is not a subject; it is a topic.
- A **practice** (`.ok-planner/practices/<slug>.md`) says, affirmatively, what this codebase does about some members of one subject: what the code is, the condition under which the practice governs, and the maintenance operation it buys.
- **A departure is a competing practice, never an exemption.** No marker silences a check. A site that does not follow one practice cites a different one whose condition covers it — a claim a reviewer can check and be wrong about, where a suppression asserts nothing. Where two conditions match, the more specific governs.
- **Cite the practice at the site it governs**, in the strict citation grammar above: `// @practice: <slug>` on its own line, tag and slug and nothing else. Do it when you write the code — that is the moment you know what you are writing, and it is what the coverage audit later reads instead of tracing.
- **When no practice covers a construct a subject claims, that is a gap** — the owner's question, not yours to close by inventing one. Surface it; never write a practice on the owner's behalf.
- A site that departs from its practice is a **defect**, not a question: `/converge` fixes it, or files it as a `category: defect` issue outside its scope.

`@subject:` and `@practice:` resolve only where this project has declared them in `.ok-planner/config.json`.
If it has not, the tags are ordinary comments and the lint rejects them — declare them (via `/ok`) before citing.

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
- Catch an exception only where the catching code does something different because of it: it retries within a budget; it takes a different branch, or returns a value the caller acts on; it answers a specific response status or refusal the user acts on; or it releases what it acquired, then re-raises with a bare `raise`
- Every other raise propagates to an owner frame, the top of a unit of work: a CLI command body, a route handler, a message callback, a thread body, a process main. The owner frame catches the top-level type, the one place that is allowed, emits one event, and maps the raise to a recorded state: rest in error, retry within a budget, or continue
- The project's event helper attaches the stack trace to every caught-error event emitted while an exception is in flight, so the owner frame's event names the library, the type, and the line that failed; the project names that helper in its own rules
- A boundary wrapper (the frame that dials, queries, reads a file, spawns, or calls foreign code) lets its library's errors propagate to the owner frame; the tree needs no named tuple per library. An existing conversion stands where a caller catches the converted type by name
- Write no catch that only converts one exception type to another, only emits and re-raises, or logs and continues with a default
- Cleanup runs on every exit through `try/finally`
- A value an end user supplies through the public surface is checked where it enters and refused with a message the user can act on; a raise that reaches the owner frame is not an answer to a user's mistake
- In review, a library error escaping a function is not a defect. The defects are an owner frame with no catch-all, and a catch that swallows an error its caller never learns of

## Tests

- **Add no test, edit no test, run no test, and read no test as evidence.** An existing suite stays where it is; work as if it were not there. Never delete one either.
- A behavior is proven by the type checker, the lint, an assertion with a message at the enforcement site, and the audit's experiments driven through the public surface.
- The lint's `no-tests` check is structural and change-scoped: a file at a test path (`test/`, `tests/`, `spec/`, `__tests__/`, `*_test.*`, `*.test.*`, `*.spec.*`, `test_*`, and their kin; `tests` in `.ok-planner/config.json` replaces the defaults) that git reports as added or modified. A committed test is never reported. The edit hook blocks the write in the same turn.
- The fix for a `no-tests` violation is to revert the edit to an existing test, or to move a new file out of the test path and drop the test. Where a behavior needs a proof, write an assertion with a message at the site that enforces it.

## Events

Structured events you emit follow the project's events standard, materialized at `.ok-planner/docs/events.md`. This section is the ambient copy; read the standard for the full text.

- Emit an event at every error caught and every retry, each a construct a grep lists: a catch that stands under the Errors section emits on the caught path or ends in a bare `raise`, an owner frame's catch-all emits once per raise it disposes, and each retry attempt after the first emits. A state transition and a branch taken on external input are not sites
- A boundary crossing (I/O, RPC, process) is not a site of its own. The event for a failed crossing is the owner frame's event; a wrapper emits on a crossing only where its catch stands under the Errors section. A caught error that neither emits nor re-raises is a defect
- An event is a kind plus structured fields; prose lives in a field, never in the kind
- A kind is a raw string literal at the emitting site, declared nowhere else, in one convention: dotted namespaces in upper case, `SUBSYSTEM.NOUN.VERB`
- A kind is unique in meaning across the tree
- Library, transport, levels, sampling, and wire format are this project's own choices

## Repo-Wide Changes

- Shared-code change: edit the one definition, let the compiler and `rg` enumerate the blast radius, fix all consumers in the same change
- Idiom change: sweep all instances in the same change, add lint so the old idiom cannot return

## Tooling

ok-planner ships:

- `node .ok-planner/bin/plumbline <path>` — the lint. Exit 0 clean, 2 violations, 1 internal error. It runs each check the project leaves on:
  - `comment-hygiene`: the comment rule above.
  - `citation-resolution`: every configured citation's slug must resolve.
  - `no-tests`: no test file added or edited.
- `/ok` — the suite front door: installs or refreshes `.claude/rules/plumbline-cheatsheet.md` and `.claude/rules/plumbline-coding.md` (and the whole vendored layer) from the carried canonical versions, and walks the owner through declaring the citation tags. The cheatsheet governs the shape of the code; the coding rules govern the act of changing it, with the evidence each change leaves.
- `/audit` — the suite's periodic run. Beside the design corpus, it reports practice coverage per subject (the population checked, the members nothing accounts for), files each confirmed practice violation as a `category: defect` issue, and sweeps the lint over the whole project, clustering its violations by shape. It fixes nothing.
- `/plan-sprint` — ok-planner's planning session, where new subjects and practices are drafted as corpus deltas.
- A `PostToolUse` hook, `.ok-planner/hooks/post-edit.js`, on every tool call, runs the lint over the file an Edit/Write touched — violations block (exit 2) so the agent fixes them in the same turn, and a lint internal error (exit 1) shows its message and blocks nothing.
  A test written by Edit or Write is blocked the same way.
  It does nothing for a Bash call.
- Project config lives in `.ok-planner/config.json` (optional). `lint_checks` turns each check on or off; a check it does not name is on, and an off check's rules leave this file.
  The `citations` array adds project-specific structured-tag exemptions (each pairs a tag with a resolution rule); `ignore` adds paths to skip; `folders` names the folders the project owns beside its root, which the lint and its hook cover too.
  `tests` declares the test paths `no-tests` guards, replacing the defaults.
