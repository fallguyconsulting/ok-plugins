# Sprint: Source-graph certification

## Intent

Rebuild certification's invalidation machinery around a committed,
mechanically derived source graph, so that what a change puts in
question is computed and recorded rather than re-derived from prose at
every close. The cascade and oscillation failure modes this addresses
share one root: judgments (which artifacts a change touches, whether a
prior determination still holds) are re-formed from scratch each run,
with annotation greps standing in for evidence. After this sprint:
audits cite graph nodes by structural identity and content hash;
re-audit is triggered by a mechanical citation floor plus a
judgment inspector reading the change itself; every adjudication is
recorded and binds later runs unless cited reality moved; every hunk
of a certified change receives a disposition; and an oscillation
detector reads the history for flips that reality cannot explain.

One issue is promoted into this sprint:
`materialized-artifact-stamp-fixed-content`.

**Self-hosting sequence, for the record:** this project certifies with
its own vendored copy of an earlier ok-planner version. The work below
edits the family source; this project's estate receives it only
through release → plugin update → front-door converge. The **genesis
pass** — one deliberate `/certify-all` that rewrites the whole audit
corpus onto node citations and pays down latent compliance debt in a
single transaction — is therefore an owner act sequenced *after* this
sprint closes and ships, not a work item this execution can complete.
The sprint's own close runs on the current vendored gate, which
remains fully functional throughout: nothing below retires the
existing citation forms or checker behavior before genesis re-homes
the corpus.

## Corpus deltas

Applying these deltas includes refreshing the three catalog TOCs.

### New concept: source-graph

```markdown
---
concept: source-graph
---

# Source graph

## What it is

A source graph is a project's committed, mechanically derived map of
its own sources: one node per file and per declared unit within a
file — a function, a type, a method, a heading-bounded section of
prose — each node carrying a structural identity derived from declared
names and a content hash over its exact span, with edges recording
syntactic reference and containment. A deterministic extractor
generates it wholesale; the same source tree always yields the
byte-identical graph.

## Purpose

The graph gives certification a computable answer to "what does this
change put in question?". Claims point into it from outside — an audit
cites the node frontier that delivers a claim, and the claim's
territory is that frontier's downward closure — so invalidation,
candidacy, and residue become topology: a changed node either breaks a
cited hash, lies inside some claimed closure, or lies in no closure at
all. Without the graph, that mapping is re-derived from prose at every
close, which is where over-sweeping and oscillation live.

## Boundaries

The graph is syntax, never semantics: it records what references what
as written and claims nothing about what executes — choosing which
nodes cover a dataflow is the auditor's judgment, expressed by citing
a higher frontier (see also: adversarial-implementation-audits under
decisions). It carries no audit content, no annotations, and nothing
hand-written; whatever points into it lives with the pointer's owner.
Annotations are a neighbor, not an input: they keep navigation and
proof registration and play no role in the graph or in invalidation
(see also: annotation). Prose sources are first-class — heading-bounded
sections are the declared units of a markdown file. The extractor and
checker are vendored, materialized tooling (see also:
materialized-artifact); the graph itself is generated project state
committed within the planner's estate (see also: estate,
design-corpus).

## Invariants

- The graph is a pure function of the source tree: identical trees
  yield byte-identical graphs, and regenerating it is always safe
  because nothing hand-written lives in it.
- Node identity derives from declared structure — the file's place in
  the tree plus the declaration or heading chain — never from line
  positions; a rename or move is an identity change by design.
- Every node's content hash covers its exact span bytes; any edit
  inside the span moves the hash.
- The graph never contains judgment: claims, adjudications, and
  citations point into it from their own records.
```

### New story: deterministic-source-graph

```markdown
---
story: deterministic-source-graph
---

# The source graph regenerates identically and catches its own drift

## Story

As a project owner, I want my project's sources mapped into a
committed graph that regenerates identically from the same tree and
flags its own drift, so that what a change invalidates is computed
from recorded structure instead of re-guessed at every close.

## Acceptance

The owner (or a certifying session) runs the vendored graph tooling →
the committed graph appears or refreshes, byte-identical across
repeated runs on an unchanged tree; after an edit inside one declared
unit, that unit's recorded hash moves and unrelated hashes do not;
with the committed graph out of date, the checker reports drift and
exits non-zero. The extractor and checker are real vendored tools
operating on the real source tree — not stubs.

## Falsifier

Two runs on an identical tree produce differing graphs; an edit inside
a declared unit leaves its recorded hash unchanged, or moves unrelated
hashes; a stale committed graph passes the checker silently.

## Proof

Proof — a deterministic harness case that builds the graph twice on an
unchanged fixture and byte-compares the results, edits one declared
unit and observes exactly that node's hash move, and corrupts the
committed graph to observe the checker exit non-zero.
```

### New decision: two-layer-invalidation

```markdown
---
decision: two-layer-invalidation
---

# Re-audit triggers are citations plus judged change inspection, never annotations

## Choice

What forces an audit to be re-derived is two layers reading the same
source graph. The mechanical layer needs no review: a cited node
identity that no longer resolves, a cited content hash that moved, or
a design artifact whose own hash changed invalidates the audit
outright. The judgment layer covers what anchors cannot see: an
inspector reads the change under certification — the diff itself,
working tree or commit range — and nominates the audits whose claimed
closures contain changed nodes; nominations are recorded on the audits
they implicate and adjudicated by the auditor, never auto-invalidating.
Code annotations play no part in either layer.

## Rationale

Citations alone under-invalidate: work added beside a cited span
breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited. Annotation-derived
triggers err in both directions at once, because they trust
self-reporting — a mis-tagged file invalidates strangers, an untagged
one invalidates nothing, and at file granularity one incidental tag
sweeps unrelated artifacts into every close. The change visible to git
is the only ground truth about what work happened, and mapping it to
the claims it bears on requires judgment — so an agent renders that
judgment, and what the gate consumes is the recorded adjudication,
never a tag. The two layers bound each other: the mechanical floor
fires regardless of anyone's opinion, and the judged layer's variance
is bounded by being candidacy — the auditor, not the inspector,
decides.

## Alternatives

- Annotation-derived touched sets — mechanical to compute, but
  inherits every annotation mistake and over-sweeps at file
  granularity.
- Pure citation staleness — fully deterministic, but blind to
  violations introduced in uncited code until the next whole-corpus
  pass.
- Re-deriving every audit at every close — sound and unaffordable;
  whole-corpus re-derivation is deliberately an owner-cadence act.
```

### New decision: recorded-adjudication

```markdown
---
decision: recorded-adjudication
---

# Certification judgments are recorded transactions, not per-run derivations

## Choice

Every judgment the certification gate consumes is written down where
the next run reads it. An inspector's nomination lands as a
provisional note on the audit it implicates; the auditor adjudicates
each note — promoted into a citation, or dismissed with a stated
reason — and the notes and their adjudications are part of the audit
record. A recorded adjudication binds later runs: departing from one
requires naming the cited reality that changed. The gate closes only
when every hunk of the change carries a disposition — mechanically
accounted, adjudicated, or residue — and residue (change no claim
accounts for) is reported to the owner as intake material, never
silently dropped.

## Rationale

Oscillation lives in re-derivation: two readings of unchanged reality
can disagree, and when nothing records the first reading, the second
is free to flip it. Recording adjudications makes convergence a
property of the record rather than of agent temperament — a flip must
point at changed reality — and the closure requirement turns "was
everything considered?" from a hope into a checkable invariant, at a
bookkeeping cost proportional to the change.

## Alternatives

- Fresh judgment at every run — maximally open-minded, and the same
  interpretive seam re-litigates at every close without ever settling.
- Precedent as prompt discipline only ("read the prior audit") —
  cheaper, but binding by temperament: nothing distinguishes a
  justified departure from an arbitrary one.
- Disposition tracking without recorded reasons — the ledger closes,
  but dismissals cannot bind the next run, so candidacy re-litigates
  anyway.
```

### Amend decision: adversarial-implementation-audits

```markdown
---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project implements what a story or decision claims is
determined by an adversarial implementation audit: a durable,
per-artifact determination (`satisfied` or `violated`) recorded in a
fourth corpus collection, written only by a certification producer
that did not implement the work under audit, and never hand-edited.
Audits cite the source graph by node identity and content hash — span
anchors within a node where finer resolution carries the verdict — and
pin quantified claims' population sources whole; a deterministic
checker flags any audit whose design artifact or cited nodes have
changed, and the re-audit set is that stale set plus the
change-inspection nominations the auditor adjudicates (see also:
two-layer-invalidation under decisions). The checker masks
release-mutable metadata — the suite-version stamp lines
materialization writes and the plugin manifests' version fields —
before hashing anything a citation or pin covers, so a release that
changes only versions voids no audit. Stories additionally carry
deterministic integration-test proofs; decisions carry no test
obligation. A negative determination stands in place until a re-audit
flips it, and blocks certification unless linked to an intake issue
awaiting the owner's ruling.

## Rationale

The claims that go wrong in practice are disproportionately
structural, negative, or quantified — a transport a decision's text
never reached, a rationale selling a property nothing delivers, an
"every" enforced on the members someone remembered — and for those the
honest verification is an adversarial reading against reality, with
the population enumerated from the compose file or route table rather
than from the artifact's own examples. Mandating a test per claim buys
determinism at the cost of test-side machinery per claim and still
misses the claims that are not runtime-observable; an audit covers
every normative sentence at the cost of trusting a reader, and that
trust is bounded three ways: the reader is never the author of the
work, the determination is a citation-carrying record that can be
re-derived and compared, and staleness is mechanical — the fixer
cannot satisfy an audit by any means except changing the code it
cites, which moves the hashes of the nodes it cites and forces a fresh
adversarial read. Structural node identities and content hashes rather
than line numbers make the tripwire survive unrelated edits;
whole-source pins on population sources make a new member re-open the
exact audits whose quantifiers it threatens; and the judged inspection
layer covers the one blindness citations keep — work added beside a
cited span breaks no hash, so an agent reads the change itself and its
nominations reach the auditor as recorded, adjudicable candidates (see
also: recorded-adjudication under decisions). Version stamps sit
inside otherwise-cited bytes and must change on every release, so
masking them is what keeps the tripwire meaningful: staleness signals
substantive change, never the release act, while any edit beyond the
masked patterns still breaks its anchor.

## Alternatives

- Test mandates with registered falsifier exhibits per claim —
  deterministic and unfoolable where it applies, but a per-claim
  authoring and maintenance layer, and structurally blind to claims
  that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same
  class once, but leaves nothing to go stale, so nothing triggers the
  re-read when the code moves.
- Diff-scoped review as the only reader — reviews the change, so a
  claim whose code was never written produces nothing to review;
  absence has no diff.
- Hashing stamped bytes as-is and re-auditing at release time — every
  release voids whichever audits cite stamped files and buys an
  agentic re-read that can only confirm version strings changed.
```

### Amend concept: materialized-artifact

```markdown
---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a family-canonical file — a skill file, support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the front door's administration, version-stamped with the suite version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the front-door plugin changes nothing anywhere until each owner converges deliberately, and editing the suite's source cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are suite-owned whole files, never hand-edited. Hooks execute from the project's own materialized copies, reached through wiring transcribed into the project's committed harness settings — never from the front door's carried payload (see also: vendored-skills under decisions). The things that legitimately run from the payload are the administration process itself — diagnosis, bootstrap, and converge run before or while the project copies are being written — and read-only advisory verbs falling back with an announcement (see also: true-up under concepts; per-project-pinning under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the payload that wrote it, except a fixed-content artifact — one whose bytes never vary across suite versions — whose fidelity diagnosis verifies by exact content instead; content equality outperforms what the stamp exists to provide.
- Diagnosis verifies fidelity against the canonical copy for the carried version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is proven to run at materialization time; one that cannot run is worse than none.
```

## Work items

- **Source-graph tooling** (makes true story:deterministic-source-graph;
  bears on concept:source-graph). A vendored, dependency-free
  extractor-and-checker (same distribution shape as the existing
  `audit-check`: stdlib-only, materialized into `.ok-planner/bin/` from
  the family payload at `plugins/ok/families/ok-planner/scripts/`).
  Builds the committed graph under the planner estate, mirroring the
  source tree; node identity is `path#declaration-chain` (heading
  chains for markdown), content hashes over exact span bytes; edges
  from syntactic reference and containment. Language adapters for what
  this repo is made of — JavaScript (requires/imports, function and
  class declarations), shell (function declarations, invocations and
  sourcing of explicit repo paths), markdown (heading sections,
  transclusion markers, explicit repo-path references) — plus a
  generic explicit-path-reference fallback. The adapter interface
  admits later per-language additions (Go, TypeScript, Python, Swift,
  C++ via tree-sitter-class parsing) without redesign. Deterministic,
  byte-identical output on identical trees. Harness proof cases per
  the story's Proof field, annotated `@story:deterministic-source-graph`.

- **Node-cited audits** (bears on
  decision:adversarial-implementation-audits). The audit citation
  grammar gains node forms — node identity plus content hash, with
  in-node span anchors where finer resolution carries the verdict, and
  whole-node population pins. `audit-check` resolves node citations
  through the committed graph and its helper prints ready-made node
  citation lines. Existing `cite:` / `cite-span:` / `cite-file:` forms
  continue to verify unchanged until the genesis pass rewrites the
  corpus; nothing forces a mixed-form corpus to fail before then.

- **Two-layer trigger in the gates** (bears on
  decision:two-layer-invalidation). The family-source certification
  skill texts (`certify-work`, `certify-all`, the shared certification
  core, the implementation-auditor prompt) derive the re-audit set
  from mechanical staleness plus a shared change-inspector prompt that
  reads the diff (working tree or commit range) against the committed
  graph and the audit corpus and nominates implicated audits with
  stated reasons. Annotation-based touched-set derivation is removed
  from invalidation everywhere it appears; annotations retain proof
  registration (`@story:` on proof artifacts) and navigation. The
  inspector re-runs each fix cycle over the then-current diff in both
  gates.

- **Reconciliation ledger and closure invariant** (bears on
  decision:recorded-adjudication). Certification tracks a disposition
  for every hunk of the change — mechanically accounted, adjudicated,
  or residue — and the presentation reports the ledger: counts per
  disposition, and the residue enumerated as intake candidates. The
  gate does not present as clean while any hunk lacks a disposition.

- **Provisional notes and precedent in the audit record** (bears on
  decision:recorded-adjudication,
  decision:adversarial-implementation-audits). The audit file format
  carries the inspector's provisional notes and the auditor's
  adjudication of each — promoted to a citation, or dismissed with a
  reason. The auditor prompt carries the departure rule: a re-audit
  departs from a recorded adjudication only by naming the cited
  reality that changed; an amended design artifact (its hash moved)
  lapses precedent wholesale and the artifact is audited fresh.

- **Family context payloads updated** (bears on concept:source-graph,
  decision:two-layer-invalidation). The family's materialized
  cheatsheet and estate guidance (`ok-planner-cheatsheet.md`,
  `ok-planner-CLAUDE.md` in the family payload) describe the graph,
  node citations, the two-layer trigger, and the ledger — replacing
  the annotation-grep description of certification scope.

- **Oscillation detector** (repo maintenance material, not family
  payload). A deterministic script under the repo-root `checks/`
  (wired into `checks/run`) reading git history only: flags any audit
  whose determination flipped between commits while its artifact hash
  and citations stood still, and any design-file markdown section
  edited in consecutive close commits (the `closed:`-stamped archive
  frontmatter supplies the commit list). Reports findings; never
  blocks.

- **Fixed-content invariant applied** (concept:materialized-artifact).
  The amended concept delta lands with no code change: the plumbline
  module marker already verifies by exact content in diagnosis; this
  work item is the delta application plus TOC refresh.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work. The items above are a flat, unordered list; group
   them by theme, file surface, or dependency and order the groups so
   nothing is built on something not yet there. Staging lives in the
   executor's working state — a task list, an orchestrator's graph.
   It is never rewritten into a plan document: this sprint is the
   whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story gets its proof: a
   deterministic integration test (or demo) present, carrying its
   `@story:` annotation, and able to actually fail under the story's
   falsifier. Write the proof with the work, not at the end. Decisions
   carry no proofs — a decision's verification is the implementation
   audit certification writes.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, or a destructive/irreversible
   action not clearly authorized. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Close by running `/certify-work`. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope: `/prove` over the touched
   stories and decisions, change-scoped corpus checks over the
   touched artifacts and annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whole-corpus certification is `/certify-all`, run on the owner's
   cadence, not per close.) The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends by offering the close-out — archiving
   this sprint and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories: every
   registered proof present, passing, and runnable.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue.
4. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
