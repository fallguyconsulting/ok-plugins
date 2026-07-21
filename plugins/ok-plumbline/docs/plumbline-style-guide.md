# Plumbline Style Guide

This guide defines how to write code for AI agent-assisted development under the Plumbline methodology. Follow these rules when writing new code or modifying existing code.

For the philosophy behind these rules, see the [Plumbline Manifesto](./plumbline-manifesto.md). The one-line summary: **comprehension is cheap for current agents; verification is not.** Every rule here either makes wrong edits fail mechanically, keeps blast radius enumerable, or keeps behavior visible where it is written.

---

## File Organization

### One Feature Per File

Each distinct feature, endpoint, or operation gets its own file. Group code by what it does, not by what technical role it plays.

```
features/
  orders/
    create.py          # POST /orders
    list.py            # GET /orders
    cancel.py          # POST /orders/:id/cancel
    types.py           # shared types for the orders feature
```

Do **not** split by abstraction layer (`controllers/`, `services/`, `repositories/`).

### Shallow, Feature-Shaped Directories

Keep the tree as shallow as the project's real structure allows. Directory structure should mirror the project's module and layer architecture (which dependency lint enforces) — never an abstraction taxonomy. `src/modules/features/orders/services/create/handler.py` is five levels of taxonomy; `features/orders/create.py` is the same code.

### Co-locate Related Files

Tests, types, and helpers live next to the code they support.

```
features/orders/
  create.py
  create_test.py
  types.py
```

Do not separate tests into a parallel directory tree.

---

## Code Structure

### File Length Guideline: ~500 Lines

A guideline, not a hard rule — semantic cohesion beats line counts. The rationale is **edit granularity, not readability**: agents read large files selectively without trouble, but a large file is a contention hotspot when multiple agents work in parallel, and a larger blast surface per edit. Split oversized files by sub-feature, never by abstraction layer.

### Function Length Guideline: ~100 Lines

Extract helpers into the same file when needed. A 120-line function that does one clear thing beats an artificial split.

### Maximum Nesting Depth: 3 Levels

Use early returns to flatten control flow.

```python
def process(data):
    if not data:
        return Error("no data")
    if not data.valid:
        return Error("invalid data")
    # ... actual logic at depth 1
```

---

## Abstraction and DRY

### One Place Per Behavior — Strict, No Exceptions

Semantically identical logic lives in exactly one place. When you find yourself writing logic that exists elsewhere, share it — do not copy it. The threshold for extraction is **semantic identity**, not a call-site count: if two sites must always change together, they are one behavior and belong in one definition.

Plumbline does not admit a "intentionally similar but separate" carve-out. If two pieces of code look alike enough to invite the question, they are duplicating one behavior — share them.

Do not extract trivia. A one-line comprehension inlined at two sites is not a shared behavior; wrapping it in a utility adds a hop for nothing.

### Shared Code Must Resolve Statically

Every abstraction must be reachable by symbol search and declared types — from any call site to the behavior, and from the definition to every consumer.

**Allowed:**
- Named functions and methods, called directly
- Interfaces whose implementations are statically enumerable
- Explicit composition — dependencies passed as parameters
- Generics with visible instantiation sites

**Forbidden:**
- Behavior-modifying decorators (`@retry`, `@cached`, `@transactional`)
- Dependency-injection containers and runtime wiring by type
- Reflection-driven dispatch, string-built symbol lookup
- Convention-based registration (file path determines route, name determines binding)
- Implicit middleware chains
- Base classes that must be read to understand a subclass's behavior; anything named "Base", "Abstract", or "Manager"

Deep call chains through *named, searchable* functions are fine. The forbidden list is about runtime wiring that grep and the type checker cannot see — not about depth.

### Shared Code Carries an Isolated Contract Check

Shared code earns its sharing by being verifiable without booting the world. Before extracting or widening shared code, ensure:

1. **A contract suite exists** — fast, unit-level tests at the abstraction boundary, runnable in isolation, pinning the behavior consumers rely on.
2. **Consumers are enumerable** — the type system or a symbol search yields the complete consumer set.

When multiple implementations satisfy one interface, the contract suite runs against **all** of them (a conformance suite). This is what keeps parallel implementations honest.

### Check Speed Is a Placement Criterion

When deciding where logic lives, ask: *what is the cheapest check that covers it there?* Logic placed where only a slow integration suite exercises it forces every future edit through that slow loop, and slow loops make agents batch changes, which makes failures harder to attribute. Prefer placements covered by fast, isolated suites; treat "only testable end-to-end" as a design smell.

---

## Mechanical Checks

Every written-down constraint needs a check that fails when an agent violates it. The conversion table:

| Constraint | Required check |
| --- | --- |
| Import / layering rules | Dependency lint (e.g. depguard). Lint config is authoritative; if prose and lint disagree, lint wins. |
| Behavioral invariant | An assertion with a message at the enforcement site, **plus** a test that fails when the invariant is violated. The test's name carries the rule. |
| Wire / protocol contract | Conformance suite runnable against any implementation. |
| Data shape at a boundary | Explicit type or schema — the compiler is the check. |
| Style and idiom | Formatter + lint rules, not reviewer vigilance. |
| Comment hygiene | Plumbline's lint — comments are not permitted in source files except machine directives, configured citation tags, and JSDoc/GoDoc in opt-in files. |

### Invariants Go in Code, Not Comments

Cross-cutting correctness properties belong in:

- An assertion at the enforcement site (`assert holder_id == claim.claimant_id, "release_claim invariant: only the holder may release"`).
- A test whose name carries the rule (`test_only_holder_may_release_claim`).
- A type that makes the wrong shape unrepresentable, where possible.

```python
def release_claim(db, claim_id, claimant_id):
    claim = db.fetch_claim(claim_id)
    assert claim.claimant_id == claimant_id, (
        "release_claim invariant: only the holder recorded on the claim row may release it"
    )
    ...
```

```python
def test_only_holder_may_release_claim():
    # exercise the invariant
    ...
```

The assertion message is the documentation; the test pins the rule. A future agent that "simplifies away" the assertion sees the test fail. A comment claiming the invariant holds is the failure mode this rule eliminates — comments do not enforce anything.

---

## Comments and Citations

### The Rule: No Comments

Code is the documentation. **Do not write comments** — no narration, no rationale lines, no "this does X", no TODOs. The exemptions below are not invitations; a comment is permitted only when something other than the author's own judgment requires it (tooling needs a directive; an external standard names a tag this code must carry; the file is a public-API surface with the docstrings marker already set). The lint catches leftovers, but the rule is prevention, not cleanup.

Most comment volume in agent-written code is **generation residue** — narration addressed to the change's reviewer rather than the code's next reader ("handle the error case", "this ensures X"). Some small share names a real load-bearing fact. That share belongs in code: an assertion, a test, a type, a name. None of it belongs in a comment.

The default action for any comment-hygiene violation — yours or pre-existing — is **delete**.

### Exemption 1 — Machine Directives

Tooling syntax is not prose. The lint exempts comments whose first significant line matches:

- License headers: `SPDX-License-Identifier:`, `Copyright`, `Licensed under`, `Dual-licensed`.
- Lint suppressions: `eslint-disable` / `eslint-enable`, `ts-ignore` / `ts-expect-error` / `ts-nocheck`, `noqa`, `pylint:`, `nolint`, `tslint:`, `biome-`, `prettier-`, `deno-`.
- Build tags: Go `go:` directives.
- Generated-file markers: `Code generated`.
- C-style pragmas: `pragma`.
- Shebangs.

These can be added freely — they encode tooling state, not prose.

### Exemption 2 — Configured Citation Tags

Projects that need a code-to-design link declare citation tags in `.plumbline.json`. Each entry pairs a tag with a structural resolution rule.

**Write a citation comment only when a separate standard directs you to link this code to a specific design artifact** — e.g. an ok-planner project whose convention is to cite the concept/story/decision that drove the code. Never invent a tag, never add one on your own initiative as a substitute for the prose comment you would have written otherwise. The exemption exists to carry a link the external standard requires; it is not a license to annotate.

Two resolution modes:

- **`file_template`**: a path containing the literal `{slug}`. The slug from the comment is substituted in, and the resulting path must exist (relative to the repo root).
- **`appears_in_glob`**: a comma-separated set of globs (`**`, `*` supported). The slug must appear (word-boundary match) in at least one file matching one of the globs.

Example `.plumbline.json` for a project using ok-planner:

```json
{
  "citations": [
    { "tag": "@concept:",  "file_template": ".ok-planner/design/concepts/{slug}.md" },
    { "tag": "@story:",    "file_template": ".ok-planner/design/stories/{slug}.md" },
    { "tag": "@decision:", "file_template": ".ok-planner/design/decisions/{slug}.md" }
  ]
}
```

**Citation comments are slug-only.** Each line in a citation comment block has the form `// @<tag>: <slug>` and nothing else — no em-dash tail, no continuation prose, no trailing punctuation. The slug names the design artifact; the artifact holds the explanation. Multiple clean citation lines may stack as one block:

```go
// @concept: cascade
// @story: parker
func resolveStaleFrame(...) { ... }
```

Each line's slug is independently checked for resolution. Mixing a citation line with a prose continuation line fails comment-hygiene — the prose belongs in the design doc, the code carries the link only.

```go
// WRONG — em-dash prose tail
// @concept: cascade — staling propagates through structural edges

// WRONG — citation line followed by prose continuation
// @concept: cascade
// staling propagates through structural edges

// RIGHT — slug-only
// @concept: cascade
```

A comment in source carrying `// @concept: claim-holder-guard` is allowed only when `.ok-planner/design/concepts/claim-holder-guard.md` exists. If the file does not exist, the lint reports `citation-unresolved`.

Slug format: kebab-case (`[a-z0-9][a-z0-9-]*`). Lowercase, digits, hyphens.

This is the only way to add project-specific allowed comment forms. There is no way to declare a tag without a resolution rule — every citation must come with a check, which closes the seam the older tag vocabulary admitted.

### Exemption 3 — Documentation Comments (Opt-In)

Files that document a public API surface may opt in to JSDoc/GoDoc-style documentation comments by carrying this marker as a comment near the top:

```
// @plumbline:allow-docstrings
```

(or `# @plumbline:allow-docstrings` for hash-comment languages.)

With the marker present, JSDoc-style block comments adjacent to a TS/JS declaration (function, class, interface, type, const/let/var, enum, namespace, methods, fields) and GoDoc-style line comments adjacent to a Go declaration (func, type, var, const, package) are exempt. Without the marker, they are not.

The opt-in is intentional: most files in a codebase are not public-API surfaces and should not carry documentation comments. The marker is for the cases where they should.

### Everything Else Is Residue

Any comment that doesn't fit the three exemptions is residue. Delete on sight — including in code you didn't write (it will be regenerated as precedent otherwise).

---

## Uniformity

### One Idiom Per Job

Agents write by precedent: new code is generated to resemble the surrounding corpus, so every pattern in the repo propagates. Consequences:

- **Idiom decisions are repo-level decisions.** Never introduce a second way to do something one way already exists for — error shapes, test layout, config access, logging — however locally appealing.
- **The first instance of a new pattern is load-bearing.** Write it as the template it will become.
- **No coexisting dialects.** When an idiom is improved, sweep the old one out everywhere in the same change. Two live styles read to a cold agent as two sanctioned options, and drift compounds.
- **Prefer plain over clever.** A clever construction is a second dialect; the plain version costs an agent nothing to read.

Whatever uniformity can be lint-enforced, lint-enforce — lint is the only thing that holds style across sessions that never met each other.

---

## Explicit Code

### Dependencies as Parameters

```python
def create_order(db: Database, cache: Cache, data: OrderInput) -> Order:
    ...
```

Not injected fields, not ambient globals, not container-resolved.

### Explicit Registration

Routes, handlers, subscriptions, and bindings are registered in visible code, in one findable place — never derived from file paths or naming conventions.

### Configuration as Visible Values

One explicit configuration object, read at the edge and passed in — not environment lookups scattered through logic.

```python
@dataclass
class OrderConfig:
    timeout: int = 30
    retries: int = 3
```

---

## Types at Boundaries

Define explicit types for API inputs and outputs, database models, interfaces between features, external service contracts, and configuration. The boundary type is the contract's mechanical check — the compiler enforcing what prose cannot.

Inside a feature, be pragmatic; typing every internal variable is not required.

---

## Error Handling

- Prefer explicit error returns (or result types) over exceptions for expected failure cases.
- Never catch a bare top-level exception type; catch specific errors, re-raise what you can't handle.

---

## Testing

- Test files live next to the code they test.
- Each test file is runnable independently — no shared fixture files that must be understood to read the tests.
- Name tests for the scenario, not the implementation: `test_create_order_fails_when_inventory_insufficient`. Test names that describe the rule are the load-bearing documentation for invariants and deliberate choices.
- Shared code's contract suite is fast and isolated; integration suites confirm, unit contracts discover.

---

## Repo-Wide Changes

### Changing Shared Code

1. Edit the single definition.
2. Let the toolchain enumerate the blast radius — compiler errors, contract-suite failures, caller searches.
3. Fix all consumers in the same change.

This is the normal, preferred mode of cross-cutting change. It produces mechanical failures that announce themselves, rather than silent drift.

### Changing an Idiom

1. Decide the new idiom once, repo-level.
2. Sweep every instance of the old idiom in the same change — no coexisting generations.
3. Add or update a lint rule so the old idiom cannot return.

---

## Enforcement

Configure lint/CI to check, at minimum:

- **Dependency direction and purity** — the project's layering rules as lint (depguard or equivalent)
- **Comment hygiene** — Plumbline's lint: no comments except machine directives, configured citations, and JSDoc/GoDoc in opt-in files
- **Citation resolution** — every comment using a citation tag has a slug that resolves per the configured rule
- **Formatter + style lint** — uniformity held mechanically
- **File length** — warn above the guideline

---

## PR Review Checklist

### Structure
- [ ] Features in their own files; no layer-split
- [ ] Files ~500 lines or less (or good reason); functions ~100 or less; nesting ≤ 3
- [ ] Dependencies are explicit parameters; registration is explicit
- [ ] Types at all boundaries

### DRY and Abstraction
- [ ] No semantically identical logic in two places
- [ ] New/changed shared code resolves statically (no dynamic indirection)
- [ ] Shared code has an isolated contract suite

### Checks
- [ ] Every new constraint has a mechanical check (lint / test / type / assertion)
- [ ] Cross-cutting invariants encoded as assertions with messages plus tests that pin the rule
- [ ] Fast isolated checks cover the changed logic; the change was verified with them

### Comments
- [ ] No comments except license headers, machine directives, slug-only citation tags whose slugs resolve, and JSDoc/GoDoc in files carrying the opt-in marker
- [ ] Any comment-hygiene violation cleared either by deleting or by converting the named constraint to an assertion / test / type / name

---

## Quick Reference

| Do | Don't |
| --- | --- |
| One place per behavior (strict DRY, no exceptions) | Copy logic between sites |
| Named, searchable abstraction | Reflection, DI containers, convention magic |
| Contract suite isolated at the boundary | Shared code testable only end-to-end |
| Constraint → assertion / test / type / lint | Constraint as prose comment |
| One idiom per job, swept on change | Coexisting style generations |
| No comments (delete on sight) | Narration, tagged prose, "deliberate" guards in comments |
| Citation tags only with structural resolution | Tags as a license to write prose |
| `@plumbline:allow-docstrings` on public-API files | Docstrings everywhere "for completeness" |
| Types at boundaries | Types on every internal variable |
| Explicit parameters and registration | Injected, ambient, or path-derived wiring |
| Co-located tests | Parallel test tree |
| Early returns | Deep nesting |
