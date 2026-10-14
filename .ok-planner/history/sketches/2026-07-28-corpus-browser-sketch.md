# Corpus browser — Design Sketch

**Date:** 2026-07-28
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

The implementation-audit corpus already carries a mechanically verifiable
map from durable design artifacts down to the code that satisfies them:
every live story and decision has an audit, and every audit anchors its
reasoning to real spans, files, and graph nodes. That map is currently
readable only by grepping audit files and mentally resolving citations.

This sketch proposes a **read-only advisory browser**: a local web
application that renders the corpus as navigable views — story and
decision lists that drill into detail pages excerpting the code they
claim, and a code browser that traces the same relation backwards,
showing which regions of a file carry attribution and to what. Its
purpose is comprehension, not enforcement: it writes nothing, judges
nothing, and produces no artifact.

Under `concept:materialized-artifact` this is a **read-only advisory
verb** — one of the two classes the boundaries permit to run from the
front door's carried payload, "falling back with an announcement".

## Shape

### Distribution

A skill inside the **ok-planner family**, not a new family. It has no
estate of its own: no declared configuration, no corpus, no
determination records. It reads the estate ok-planner already owns.

The frontend is a **Svelte SPA, built at release** and carried in the
family payload. Svelte rather than React because the built artifact is
distributed to every consumer project rather than deployed once; React
ships `react` + `react-dom` into the bundle regardless of application
size, and that fixed weight buys nothing this application needs.

Delivery reuses what the estate already carries. `.ok-planner/CLAUDE.md`
holds a `Materialized by ok-planner vX.Y.Z` stamp and
`.ok-planner/bin/audit-check` holds `VERSION = "X.Y.Z"`, so the project's
pinned suite version is already recorded, and `.ok-planner/` is already
the committed discovery marker under
`decision:filesystem-discovery-markers`. Converge reads that stamp and
places the matching build under a gitignored `.ok-planner/browser/`.
No additional manifest is required. Earlier versioned builds remain
retrievable so a project pinned to an older suite version keeps working
against the corpus format of its own era.

The ignore file is suite-owned and lives inside the dot-directory, the
shape `ok-workspaces` already uses for `.ok-workspaces/.gitignore` on
the stated grounds that "a `.gitignore` governs only its own directory".
Because `source-graph` asks git what is ignored, an ignored bundle never
enters the graph, is never hashed, and never becomes content of the
corpus it renders.

### Service

A **stdlib-only Python program** in the same distribution shape as
`audit-check` and `source-graph` — no install step, no dependency tree,
no build. It serves the built SPA as static files and answers JSON
requests on loopback.

Its defining property is that it **imports the project's own pinned
`.ok-planner/bin/audit-check` as a module** rather than reimplementing
citation resolution. That binary is stdlib-only behind a clean
`if __name__ == "__main__"` guard and exposes exactly the primitives
required:

| primitive | job |
|---|---|
| `locate_anchor` | anchor text → line indices (returns all hits) |
| `mask_release_metadata` | the release-mutable masking rule |
| `span_hash`, `masked_file_hash`, `normalize` | hash arithmetic |
| `load_graph` | committed graph node rows for a source file |
| `parse_frontmatter` | audit determination, `artifact-hash`, `issue:` link |

Reimplementation is the trap this avoids. The masking rule alone covers
version stamps, `VERSION` assignments in materialized executables, and
`plugin.json` version fields — deliberately, so that a release changing
only versions voids no audit. A resolver that diverged from it would
report staleness the certification gate calls clean. Importing the
project's own pinned copy guarantees the browser and that project's gate
always agree.

This was verified before writing: loading the vendored `audit-check`
(v11.1.1) and resolving a real `cite-span` from the
`deterministic-source-graph` story audit located it at lines 487–535 of
`scripts/source-graph` with a computed span hash matching the hash the
audit recorded.

### Views

**Story list / decision list → detail.** Each artifact shows its audit's
determination (`satisfied` | `violated`), any linked intake issue, and
its claimed code territory. Detail pages excerpt the cited code inline
with foldable hierarchy, preferring `cite-node` declared-unit identities
over `cite-span` line ranges where both are available: a node identity
like `SKILL.md#certify-the-work-the-change-scoped-gate.process` is a
dotted declaration chain, so the enclosing and nested units are
derivable from the graph without hand-authored structure. `cite-span`
citations remain the fallback and resolve to exact line ranges.

**Code browser, tracing backwards.** Two distinct mark types that must
not be conflated:

- **Evidence marks** in the gutter — `cite:` and `cite-span:`, a
  specific line or range an audit's reasoning turns on.
- **Population badges** at file level — `cite-file:` and whole-file
  `cite-node:` identities, meaning "read whole as a population source",
  not "every line here serves this story".

Rendering a population pin as per-line attribution would assert
something the corpus never claimed.

**Coverage as a first-class view.** `concept:source-graph` already
supplies the vocabulary: a node "either breaks a cited hash, lies inside
some claimed closure, or lies in no closure at all". The third case is
residue, and it is the more interesting half of the map — at the time of
this sketch only 80 of 247 graph-covered files carry any citation at
all. Coverage is presented as a view, not hidden as a gap.

### Scope boundary

Only the mechanically derived **story→code** and **decision→code**
edges are in scope.

`concept→code` and `story→decision` are deliberately excluded. No design
artifact references another — zero `kind:slug` references across all 27
concepts, 17 stories, and 22 decisions — and every cross-artifact link in
the corpus lives inside audit prose as free text. Concepts have no audits
at all; their only path to code is the annotation, which
`decision:two-layer-invalidation` strips of any scope or invalidation
duty. The owner's stated direction is to keep foundation artifacts
loosely coupled and generate bindings through agentic judgment rather
than declared references, so inferring those edges is left to a later
pass.

### Corpus census at time of sketch

Moving — a `/certify-all` run was in flight when this was written.

| form | count | resolves to |
|---|---|---|
| `cite:` | 357 | one line |
| `cite-span:` | 274 | a line range |
| `cite-node:` | 136 | 119 whole-file, 17 declared-unit |
| `cite-file:` | 15 | a whole file |

Graph: 249 `.graph` files, 249 `file` rows, 831 `node` rows, 133 `ref`
edges. Of 631 line-level citations, 625 resolve to a unique line, 5
match multiple lines, and 1 matches nothing.

## Open questions

- Adding `.ok-planner/.gitignore` collides with an invariant of
  `concept:estate`: "Whether the estate is tracked in git is the project
  owner's decision **where the family has no gitignore of its own**."
  Giving ok-planner a gitignore removes a decision the concept currently
  reserves for the owner. Either the invariant is amended or the bundle
  lives somewhere that does not trigger it.
- `concept:materialized-artifact` holds that "a vendored executable is
  proven to run at materialization time; one that cannot run is worse
  than none." How converge proves a fetched bundle is intact, and what
  it does when the fetch fails or the machine is offline, is unresolved.
- Where versioned builds are hosted and by what mechanism they are
  retrieved is undecided. No suite tool currently makes a network call
  of any kind, so this introduces a first.
- `concept:skill` holds that "administration is not a skill surface:
  families expose converge cores and administration documents, not
  lifecycle verbs." That places the fetch in converge and leaves the
  skill as the launch verb only — but the split has not been drawn.
- Whether the browser renders the working tree or a committed ref.
  Citations resolve against files on disk, so the working tree is the
  natural default, but that makes the view unstable mid-edit.
- How the service chooses and reports its loopback port, and whether
  concurrent instances across projects are expected.
- What the announcement required by `decision:per-project-pinning`
  looks like in a graphical surface rather than command output.

## Risks / unknowns

- **The graph's edges are thinner than the "browse the DAG" framing
  suggests.** All 133 `ref` edges target whole files, not node
  identities — zero ref targets carry a `#`. Containment is implicit in
  the dotted chain prefix rather than an explicit edge. So a claim's
  downward closure is fine-grained through containment and coarse
  through reference, and 133 edges over 831 nodes is sparse. A graph
  view built today would be mostly an inventory.
- **The corpus moves.** During the conversation that produced this
  sketch, the project went from no committed graph and zero `cite-node`
  citations to 249 graph files and 136 node citations. A browser built
  against one corpus shape can render an older project as empty. This
  is the reason for per-project pinning, and it is a live risk rather
  than a theoretical one.
- **Ambiguity and staleness are states, not errors.** `locate_anchor`
  returns all matches; 5 citations currently match more than one line
  and 1 matches nothing. These must render as legible states or the
  browser will look broken when it is merely reporting the truth.
- **A gitignored bundle means a fresh clone cannot browse offline** until
  something fetches it. Acceptable for an advisory viewer, but it breaks
  the property every other suite tool has, where a contributor with
  nothing installed can still run what the project was converged to.
- **Version skew in the other direction.** The browser is fetched for the
  project's pinned version, but a project can be converged to a version
  whose corpus predates a citation form the browser expects.
- **Sparse coverage may read as failure.** With 80 of 247 files carrying
  citations, a naive coverage view could imply the corpus is
  under-audited when selective citation is the intended design.

## What this is not

- Not a replacement for `audit-check`, `/prove`, or the certification
  gates. It renders their inputs and outputs; it never judges.
- Not a writer. It does not edit the corpus, file issues, or record
  determinations.
- Not a concept browser in this pass — `concept→code` is out of scope
  above.
- Not a diff or change-review tool. The reconciliation ledger and change
  inspection belong to certification.
- Not authorization to build. The path from here is `/plan-sprint`.
