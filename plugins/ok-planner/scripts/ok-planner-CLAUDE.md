# .ok-planner — project records (out of context by default), with one durable source-of-truth subdirectory

This directory holds two kinds of content with different lifecycles
and different rules for how agents should treat them.

**Project records, out of context by default** (`specs/`, `plans/`,
`sketches/`, `history/`): committed, versioned parts of the project —
but not the source of truth, and not to be pulled into context
unprompted. Reading `history/` (a past moment) or `sketches/` (a
speculative or in-progress future) without a directing goal is context
pollution when reasoning about the project as it is now. This is a
context-discipline rule, not a commit rule — these are committed; some
are temporary planning input removed after use; all stay out of
context until a goal directs you to them.

**Durable design docs** (`design/`): the project's canonical
durable model — four catalogs, each self-contained:
- **concepts** — load-bearing nouns with definitions, purposes,
  boundaries, and invariants
- **stories** — durable user-outcome stories (role, capability,
  acceptance, falsifier, proof) describing what the product does
- **decisions** — durable technical decisions (choice, rationale,
  alternatives) describing the architectural choices the project
  has made
- **tensions** — open ambiguities and unresolved tradeoffs

**A note on the name `design/`.** The directory name is a label,
not a load-bearing claim about content. "Design" here is shorthand
for the project's **durable identity / model** — the high-level,
general framing of what the project is and what it owes its users.
It is NOT a place for *specific* designs: interface grammars, route
shapes, schema details, implementation diagrams, or anything else
that prescribes how a particular piece of the product looks. Those
live in code, in `specs/`, and in other project documentation.
Concepts are general; stories are durable user expectations;
decisions are tradeoffs, not specs; tensions are open questions
about those three. If something in `design/` reads like a
specification of a specific interface or implementation, it's
out of place — it belongs elsewhere.

Code references the design (via `@concept:`, `@story:`,
`@decision:` annotations at points of enforcement), not the
other way around. The design docs are **a source of truth with
the same weight as code**: they describe the project as it
stands. Like code, they change only through plan execution —
`execute-plan` is the one skill that mutates them.
Source-of-truth, read freely — NOT an out-of-context record.

## Default behavior for agents

### Project records, out of context by default (`specs/`, `plans/`, `sketches/`, `history/`)

Unless the user or an active skill (e.g. `/brainstorm`,
`/write-plan`, `/execute-plan`, `/review-plan`, `/sketch`)
explicitly directs you here, keep these subdirectories out of context:

- **Do not consult these files to understand the project.** They
  reflect what someone was thinking at a moment in time. The
  codebase is the source of truth; these artifacts are not.
- **Do not include `.ok-planner/` files in general repository
  exploration**, codebase walkthroughs, or "how does this project
  work" research. Skip them the same way you would skip a build
  directory.
- **Do not propose updating, refreshing, or reconciling these files
  with the current state of the code.** Drift between an old plan
  and the current code is expected and fine. The artifact stays as
  it was written.
- **Do not edit, rename, move, or delete files here on your own
  initiative**, even if they look stale, redundant, or wrong.

#### When it is OK to read or touch these records

- The user explicitly asks (e.g. "update the spec at
  .ok-planner/specs/foo.md", "what did we decide about X — check
  the old plan").
- An ok-planner skill is running and directs you to read or write
  specific files here as part of its documented process.

In those cases, do exactly what the user or skill asked, then stop.
Do not expand the scope to "while I'm in here, I'll also fix..."

### Durable design docs (`design/`)

The `design/` subdirectory is **the exception**. It holds the
project's canonical durable model in four catalogs:
- **`concepts/`** — load-bearing nouns with definitions,
  purposes, boundaries, and invariants.
- **`stories/`** — durable user-outcome stories that describe
  what the product does (role, capability, business value,
  acceptance, falsifier, proof form).
- **`decisions/`** — durable technical decisions (choice,
  rationale, alternatives) capturing the architectural choices
  the project has made.
- **`tensions/`** — open ambiguities and unresolved tradeoffs
  awaiting resolution via `/refine-design`.

**Design docs change only through plan execution, like code.**
The reason: if the design docs and the code can change
independently, they drift, and the project ends up in an
inconsistent state. To prevent that, *all* design-doc changes
ride the same pipeline as code — a spec captures the change,
`write-plan` turns it into tasks, and `execute-plan` applies it.

Skills relate to the design docs in three modes:

1. **Modifier**: `execute-plan` is the one skill that mutates
   the design docs, carrying out plan tasks that the spec
   directs. (`discover-design` is the bootstrap exception: it
   creates initial design docs for a project that has none, or
   extends the catalog when new areas are discovered. It does
   not modify existing user-edited content.)

2. **Read-only oracle**: `review-holistic` reads the design
   docs as sacrosanct and uses them to drive whole-codebase
   convergence. There is no per-scope spec for that kind of
   review, so the design docs themselves are the source of
   truth.

3. **Read-only consumers**: every other skill reads the design
   docs without writing.
   - `brainstorm` and `refine-design` read them to understand
     "how the project is now," and capture any needed changes
     **in the spec they produce** (under a `## Design changes`
     section). The changes get applied later, by
     `execute-plan`.
   - `merge` reads the docs against a fresh merge or rebase
     and **surfaces merge-only inconsistencies** for the user
     — mechanical artifacts (slug collisions, broken
     annotations) and semantic conflicts (two branches
     editing the same artifact incompatibly). It does not
     look for code-vs-doc drift: the spec pipeline changes
     docs and code as one unit, so drift cannot accumulate
     when the pipeline is followed. Resolution is human-driven
     and goes through the spec pipeline; merge does not write
     fixes to the design docs itself.
   - `write-plan` reads to plan spec-directed mutations as
     first-class tasks.
   - `review-work` and `review-plan` read to verify that
     spec-directed mutations landed correctly. `review-work`
     additionally runs an independent design-doc compliance
     cycle that audits the design docs against the concept
     self-containment rule (see below).

Layout (created by `/discover-design`):
- `_discover/` — as-is scaffolding. Wide, detailed, possibly
  redundant. Discarded once the design stabilizes.
- `concepts/` — one concept per file. Mutated in place by
  `execute-plan` per the spec's `## Design changes` section.
- `stories/` — one story per file. Mutated in place by
  `execute-plan` per the spec's `## Design changes` section.
- `decisions/` — one decision per file. Mutated in place by
  `execute-plan` per the spec's `## Design changes` section.
- `tensions/` — one tension per file. Tensions move to
  `tensions/_resolved/` when `execute-plan` carries out a
  resolution-bearing spec.
- `review-notes.md` — agent-confessed uncertainty from the
  `/discover-design` run (judgment calls, suspected concepts,
  unresolved fix-loop issues). Consumed by `/refine-design`;
  not durable.

- **`review-holistic` consults `design/`** when forming
  judgments — a finding that contradicts a documented boundary,
  invariant, story acceptance, or decision needs an explicit
  "the documented design is wrong because..." rather than a flag
  against the code. `brainstorm` and `refine-design` consult to
  understand current state; the spec captures any needed
  changes. Other skills do not consult as oracle.
- **Concept, story, and decision files are MUTABLE during
  `execute-plan`.** Editing the body in place to reflect the
  new state is the normal mode — this is the prescriptive
  design, not an ADR journal and not a changelog. Mutations
  ride alongside the code changes that conform to them and
  stay reversible until the plan executes.
- **Current-state only.** Concept, story, decision, and
  tension bodies describe the project as it stands today.
  No `## Notes` / `## History` / `## Changelog` sections, no
  dated audit-trail entries, no "previously called X" /
  "used to live at Y" / "changed per spec Z" lines. No
  forward-looking content either — "we plan to", "will be
  replaced", "TODO", "deferred to V2", "open question for
  later" all belong elsewhere (open ambiguities go in
  `tensions/`; intended future changes go in a spec). Git
  carries the past; the spec/plan pipeline carries the
  future; the design doc is the present. The discovery
  scaffolding (`_discover/`, `review-notes.md`) is the only
  exception — those are explicitly point-in-time.
- **DO NOT delete concept, story, or decision files on your own
  initiative**, even if they look stale. The spec pipeline is
  the only mechanism for changes; surface drift concerns
  through `/brainstorm` or `/refine-design`.
- **DO NOT mutate `tensions/` entries outside the spec
  pipeline** — those entries record what the project considers
  unresolved.

#### Self-containment rule

Concept, story, and decision bodies are **self-contained**.
The design owns the definition; code references the design
via `@concept:`, `@story:`, and `@decision:` annotations, not
the other way around. A refactor that moves files around does
not invalidate an artifact, and an external doc that moves to
another repo does not orphan one. To make that durable,
citations in artifact body are restricted to forms that
survive the codebase moving.

**The rule applies to frontmatter as well as body.** A
`references:` frontmatter field that lists `_discover/...`
artifacts, spec paths, sketch paths, or any other file-form
citation is the same durability problem the rule exists to
prevent — those paths rot when the scaffolding is retired,
when specs are archived, or when the repo is reorganized.
Once an artifact is baked, the lineage that produced it lives
in the `_discover/` scaffolding (as history) and in the git
history of the artifact file itself; the artifact body and
frontmatter carry no lineage. Frontmatter is restricted to
slug-form metadata only: `concept:` / `story:` / `decision:` /
`tension:`, `status:`, `aliases:` (list of names), and for
tensions `category:` and `affects:` (list of slugs). Path-form
`references:` does not belong in any artifact's frontmatter;
if a `discover-design` or earlier-version run wrote one,
strip it.

**Allowed in artifact body** (concepts / stories / decisions):
- Other artifact slugs across catalogs (`see also:
  claim-handle`, `concept:claim-handle`, `story:claim-co-holder`,
  `decision:persistence`).
- Invariant IDs the codebase uses, whatever the project's
  numbering convention is — the ID is stable across file moves,
  the file path is not. Code-referent annotations the project
  may carry for its own coding conventions are not cited here:
  those tags belong to the code layer, and design docs cite only
  design-owned identities (concept / story / decision slugs and
  invariant IDs).

**Disallowed in artifact body** (concepts / stories /
decisions):
- File or directory paths in any form (`foo/bar.go`,
  `services/widget/`, `pkg:github.com/...`, bare URLs,
  `code:foo.go::Symbol`, "the code at X" pointers).
- References to external documentation (`docs/...`, READMEs,
  CHANGELOG, sibling-repo paths).
- Quoted code, quoted lint-config allowlists, quoted external
  prose.
- "Owns / Does NOT own" sections that name code paths.
  Concept Boundaries is the in-vs-out section; it names
  neighbor concepts by slug.

**For tensions:** the same self-containment rule applies to
`## Resolution candidates` — resolutions become spec
instructions and live forward in time, so they must be
path-free. `## What is muddy` and `## Evidence` are
point-in-time snapshots and may cite code as evidence.

The canonical statement of the rule lives in
`ok-planner:discover-design`'s SKILL.md ("Self-containment
rule" and "Tension surface rule"). The `review-work` skill's
design-doc compliance cycle audits the live design docs
against this rule on every review.

#### Consulting the design docs: read `concepts.md` first

When `review-holistic`, `brainstorm`, or `refine-design` is
reading the design docs, the lookup pattern is:

1. **Read `.ok-planner/design/concepts.md` first** — a small
   auto-generated TOC of every concept with a one-sentence
   definition. It is the single artifact you can read in one
   shot to know what concepts the project traffics in.
2. **Grep for `@concept:`, `@story:`, and `@decision:`
   annotations in the code under consideration** — inline
   citations that say "this site implements concept / story /
   decision X." Use `rg '@(concept|story|decision):' <path>` to
   find them locally; use `rg '@story: <slug>'` (or analogous)
   to find every site load-bearing for a specific artifact.
3. **Read `concepts/<slug>.md`, `stories/<slug>.md`, and
   `decisions/<slug>.md`** for the full body of any artifact
   surfaced by step 1 or 2 that is load-bearing for the work
   at hand.

#### `@concept:`, `@story:`, `@decision:` annotations

Source-code annotations cite the design model at the points
the code is load-bearing for it:

- `@concept: <slug>` — this site is where a concept is
  enforced or expressed (an invariant guarded, a boundary
  drawn).
- `@story: <slug>` — this site is load-bearing for delivering
  the story's user-observable outcome (the wired entry point,
  the handler that produces the observable effect, the
  value-delivering component).
- `@decision: <slug>` — this site embodies a technical
  decision (the persistence call, the handler-registration
  mechanism, the chosen retry cadence).

Annotate where the design is enforced or expressed, not every
file that happens to touch it. No carpet-bombing.

- **`execute-plan`** adds or modifies annotations when a plan
  task explicitly directs (the spec usually surfaces this when
  a concept, story, or decision is being introduced or
  changed).
- **`discover-design`** can seed initial annotations on
  bootstrap.
- **`review-holistic`** notes "consulted <slug> (annotation
  missing at <site>)" in its findings; a subsequent
  `execute-plan` run leaves the annotation when applying the
  fix.

No other skill annotates on its own. Annotations accrete
through `execute-plan` runs.

## Layout

- `specs/` — active specs from `/brainstorm` and
  `/refine-design` (out of context by default)
- `plans/` — active plans from `/write-plan`, plus their
  `-completion-report.md` reports written by `/execute-plan`'s
  completion auditor (out of context by default)
- `sketches/` — design sketches from `/sketch` (out of context by default)
- `design/` — durable design docs (concepts + stories +
  decisions + tensions; mutated only by `/execute-plan` via
  spec-directed plan tasks; bootstrapped by `/discover-design`)
- `history/specs/` and `history/plans/` — specs and plans
  archived here automatically when an execute-* skill finishes
  a plan (out of context by default)
- `history/sketches/` — sketches archived here automatically by
  `/brainstorm` when it produces a spec from them (out of context by default)
