# The Plumbline Manifesto

## Code that runs true under agentic maintenance.

This document explains why codebases maintained primarily by AI coding agents require different design priorities than traditional human-maintained code, and what those priorities are.

---

## What is Plumbline?

**Plumbline** is a methodology for writing code that AI coding agents can safely maintain in parallel, across model generations, and at scale.

The name comes from the plumb line: a weight on a string that shows true vertical regardless of who is looking, what time of day it is, or how the wall was poured. A Plumbline codebase holds itself to constraints the same way — each one verifiable mechanically by lint, by test, by type, or by conformance suite, and so true the same regardless of which agent reads it, in what session, in which model generation.

The condition Plumbline addresses: AI agents have no persistent memory of your codebase between sessions, work in parallel without seeing each other's edits, and arrive with no history of how the code evolved. Plumbline treats per-session discipline as the weakest link and converts load-bearing conventions into mechanical checks instead.

---

## The Cost Model

Discipline does not compose across sessions; checks do.

A convention — "keep these two copies in sync," "follow the layering rules," "use the new error style" — must be re-obeyed by every agent in every session forever, including sessions running in parallel that never see each other's work. A check — a compiler error, a lint rule, a failing test — is written once and holds against every future agent, every workflow fan-out, and every model generation.

As agent capability grows, the codebase's ambition grows with it, and the number of concurrent agents grows with the harness. The correct response is to trust per-session discipline *less* over time, not more, and to convert every load-bearing convention into a mechanical check.

---

## The Three Goals

Plumbline code should, in priority order:

1. **Make wrong edits fail mechanically.** Every load-bearing constraint — a layering rule, an invariant, a wire contract, a style decision — should have a check that fails when an agent violates it: a compile error, a lint rule, a test. A constraint that exists only as prose is a constraint that will eventually be violated silently.

2. **Isolate blast radius and make it enumerable.** Modifying one feature should not risk breaking others through hidden coupling — and where coupling is deliberate (shared code), the full set of affected consumers must be statically discoverable, so verification has a known scope.

3. **Be understandable where it is written.** An agent (or human reviewer) should understand what code does by reading it, not by reconstructing a mental model of runtime wiring. Comprehension is cheap only when behavior is visible and findable.

---

## The Principles

### 1. Locality of Behavior

> Coined by Carson Gross (creator of HTMX), derived from Richard Gabriel's *Patterns of Software*. Adopted directly.

Code should be understandable where it is written, not where it is called from or where its abstractions are defined. Behavior visible in the function; dependencies as explicit parameters.

### 2. Strict DRY, Through Statically-Resolvable Abstraction

Semantically identical logic lives in **one place**. Shared code is welcome — a large body of common code is an asset, because it gives every edit a single target whose blast radius the compiler can enumerate.

The property that makes an abstraction agent-friendly is not its depth or its layer count. It is whether it **resolves statically**: from any call site, an agent must be able to reach the behavior by symbol search and by following declared types, and from any definition, the toolchain must be able to enumerate every consumer.

**Friendly (static) abstraction:**
- Named functions and methods, called directly
- Interfaces with a statically enumerable set of implementations
- Explicit composition — dependencies passed as parameters
- Generics with visible instantiation sites

**Hostile (dynamic) indirection:**
- String-built dispatch, reflection-driven wiring
- Dependency-injection containers resolving by type at runtime
- Convention-based registration ("this file's path determines its route")
- Code-generated names that appear nowhere in source
- Behavior-modifying decorators and implicit middleware chains

Dynamic indirection is forbidden not because it is hard to read but because it is invisible to grep, to the type checker, and to static analysis — it defeats exactly the machinery that makes shared code safe to edit.

Plumbline is strict DRY without exception. There is no "this similar-looking code is intentionally separate" carve-out — if two sites must change together they share; if they don't, they aren't duplicating a behavior in the first place.

### 3. Every Contract Has a Mechanical Check

When you write down a constraint — an invariant, a layering rule, a wire contract, a guarantee — ask: **what mechanically fails if an agent violates this?** If the answer is "nothing," that is the gap to close.

The conversion table:

| Constraint | Check |
| --- | --- |
| Import / layering rules | Dependency lint (e.g. depguard). If lint and prose disagree, lint wins. |
| Behavioral invariant | An assertion with a message at the enforcement site, **plus** a test that fails when the invariant is violated. The test's name carries the rule. |
| Wire / protocol contract | A conformance suite runnable against any implementation. |
| Data shape at a boundary | An explicit type — the compiler conscripted as the check. |
| Style and idiom decisions | Formatter and lint rules, not review-time vigilance. |

**Check speed is an architectural property.** An agent's working loop is edit → check → edit; the friendliness of any piece of code is largely the cost of the cheapest check that catches a wrong edit to it. Shared code earns its sharing by carrying a contract checkable **in isolation** — fast unit-level tests at the abstraction boundary — so that editing it gets a verdict from the cheap suite and the expensive integration pass becomes confirmation, not discovery. When deciding where logic lives, "what is the cheapest check that covers it there?" is a legitimate placement criterion, on par with cohesion.

### 4. Explicit Over Implicit

Magic does not merely defeat a reading agent — it defeats grep, static analysis, and dependency lint, the exact machinery principle 3 relies on. Implicit behavior is unverifiable behavior.

Prefer explicit function calls, parameters passed directly, explicit route registration, and configuration as visible objects. Avoid behavior-modifying decorators, DI containers, metaprogramming, and convention-based anything.

### 5. Uniformity by Precedent

One idiom per job, everywhere in the repo.

Agents write by precedent: new code is generated to resemble surrounding code, and the existing corpus outweighs any rules file. Two consequences follow:

- **The first instance of any pattern is load-bearing.** An error-handling shape, a test layout, a config-loading approach — the first one written becomes a template that propagates whether or not it deserved to.
- **Coexisting dialects compound rather than decay.** A human team carries history ("old style predates the refactor"); an agent arrives with none, sees two live idioms, reads both as sanctioned, and perpetuates each in proportion to how often it appears. Style drift in an agent-maintained repo grows unless mechanically stopped.

Therefore: idiom decisions are repo-level decisions, never file-level ones. When an idiom is improved, the old one is swept out **everywhere in the same change** — never left to coexist with the new. And whatever can be lint-enforced should be, because lint is the only thing that holds uniformity across sessions that never met each other.

Local cleverness is a cost, not a craft, in agent-maintained code. A clever construction that a human expert would savor is, to an agent, a second dialect to keep correctly separated from the first — and the expressiveness gains nothing, because an agent does not experience tedium reading the plain version. The friendly repo is boringly regular.

### 6. Typed Boundaries, Flexible Interiors

The type at a boundary is not documentation — it is the compiler conscripted as the contract's check. Required at API inputs/outputs, database models, interfaces between features, external service contracts, and configuration. Pragmatic flexibility inside a feature.

### 7. Co-locate Everything Related

Tests, types, constants, and helpers for a feature live with that feature, not in a parallel tree.

### 8. Code Is the Documentation; Comments Are Residue

Prose comments do not help agents read code — agents parse code directly, and well-named idiomatic code is its own explanation. Worse, comments are a drift hazard with a sharper edge for agents than for humans: a human reading a stale comment shrugs and trusts the code, but an agent weights comments as *intent signals* — a confidently wrong comment can pull an agent toward "fixing" correct code to match it.

Most comment volume in agent-written code is **generation residue**: narration addressed to the reviewer of the change ("handle the error case", "this ensures the lock is released"), worthless the moment the change lands. And by principle 5 it compounds — a repo that accumulates narration teaches every subsequent session to narrate.

The rule:

- **By default, comments are not permitted in source files.** Load-bearing information — a constraint, an invariant, a deliberate-choice guard — belongs in a code form an agent cannot route around: an assertion with a message, a test whose name carries the rule, a type that enforces the shape, a function or variable name that carries the intent.
- **Three narrow exemptions.** Machine directives (license headers, lint suppressions, build tags, generated-file markers, shebangs) — these are tooling syntax, not prose. Project-configured citation tags from `.plumbline.json` in slug-only form — each pairs a tag with a structural resolution rule, and each line in a citation comment is `@<tag>: <slug>` and nothing else (no em-dash tail, no continuation prose, no trailing punctuation). The slug names the artifact; the artifact holds the explanation. Documentation comments — JSDoc/GoDoc adjacent to declarations, only in files carrying the opt-in marker `@plumbline:allow-docstrings`.
- **Everything else is residue.** The default action is delete, including in code you didn't write — it will be regenerated as precedent otherwise.

---

## Addressing Objections

### "Strict DRY means a lot of common code — what about separation of concerns?"

Separation of concerns is, at root, a worry about what one mind can hold responsibly. The agent-era version of that worry is *verification scope and contention*, and both are addressed by checks rather than by splitting code: a shared unit with an isolated, fast contract suite and statically enumerable consumers is safe at any size of consumer set. Share freely; pin the contract.

### "Won't shared code changes still break consumers?"

They can — but breaking a consumer of well-typed, conformance-tested shared code produces a *mechanical failure* (compile error, failing suite) that an agent fixes in the same change. The alternative — drift between copies — produces *silence*. Prefer the failure mode that announces itself.

### "Isn't banning all comments extreme?"

The rule is not a prohibition on documentation. Documentation lives in code: in function names, type names, assertion messages, test names, and (when a file documents a public API) JSDoc/GoDoc with the opt-in marker. What the rule eliminates is *prose narration in source files*, which is the thing experience identified as the actual harm — both the residue cost (most of it was generation noise) and the drift cost (stale comments mislead agents). Information that doesn't fit one of the structural forms wasn't documentation; it was narration that had no enforcement.

### "What about a constraint imposed from outside that the code can't express — Postgres lock ordering, a wire-format fact?"

Encode it as an assertion at the boundary where the constraint enters the system, with a message that names the external rule, plus a test that fails if the order is reversed. The assertion is the enforcement; the message is the documentation; the test pins the rule against future "simplifications." A comment naming the constraint without the assertion is the failure mode this rule exists to eliminate.

### "Won't future agents make this obsolete too?"

Probably parts of it. This document should be revisited with each significant capability generation. The durable bet is the cost model: checks compose across agents and time; discipline doesn't. Future revisions will likely move *more* weight onto mechanical verification, not less.

---

## Glossary

| Term | Definition |
| --- | --- |
| **Plumb** | Hanging true vertical; verifiably aligned. Code "runs plumb" when its mechanical checks confirm every load-bearing constraint still holds. |
| **Statically resolvable** | Reachable from call site to behavior (and definition to consumers) via symbol search and declared types, with no runtime wiring. |
| **Mechanical check** | A compiler error, lint rule, assertion, or test that fails automatically when a constraint is violated. |
| **Generation residue** | Narrative comments an agent writes while working, addressed to the change's reviewer rather than the code's next reader. |
| **Drift** | Unintentional divergence — between code copies, or between a comment and the code it describes. |
| **Citation tag** | A project-configured comment-prefix tag declared in `.plumbline.json`. Each tag pairs with a structural resolution rule; a comment using the tag is allowed only when the slug after it resolves. |
| **Docstring opt-in marker** | The literal comment `@plumbline:allow-docstrings` in a file enables JSDoc/GoDoc documentation comments adjacent to declarations in that file. Without it, those comments are not allowed. |

---

## References and Further Reading

- **Locality of Behavior** — Carson Gross: [htmx.org/essays/locality-of-behaviour](https://htmx.org/essays/locality-of-behaviour/); Richard Gabriel, [*Patterns of Software*](https://www.dreamsongs.com/Files/PatternsOfSoftware.pdf).
- **Vertical Slice Architecture** — [Jimmy Bogard](https://www.jimmybogard.com/vertical-slice-architecture/): organizing by feature rather than technical layer.
- **DRY** — Hunt & Thomas, [*The Pragmatic Programmer*](https://pragprog.com/titles/tpp20/the-pragmatic-programmer-20th-anniversary-edition/): the principle Plumbline maintains, under static-resolvability constraints.
