---
audit: deterministic-source-graph
artifact: story:deterministic-source-graph
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:effceb0cfdc9
---

# Whether the vendored graph tooling regenerates byte-identically, moves exactly the edited unit's hash, and flags its own drift — on the real tree, not a stub

The design artifact's hash is unchanged since the prior audit, so that audit's
reasoning binds absent moved reality, and it carried no `## Notes` ledger, so no
adjudication is open. What moved is not the tooling but this repo's own vendored
layer: `.ok-planner/bin/source-graph`, materialized here by an earlier converge
this session, was removed when the layer was restored to its pinned HEAD state.
Under `decision:per-project-pinning` the vendored layer changes only by a
deliberate, committed converge after a release, so this project simply has not
been converged onto the version that carries the extractor yet — a lag, not a
regression. The prior pass cited that ephemeral copy to make "vendored" literal;
that citation is re-homed below to the family source and to the converge
materialization that puts it in a consumer's estate, which is where the story's
claim actually lives. Every generator, checker and harness span verifies
unchanged, and every claim was re-run against the tree.

## Claims

**Title / Story — "my project's sources mapped into a committed graph
that regenerates identically from the same tree and flags its own drift,
so that what a change invalidates is computed from recorded structure
instead of re-guessed at every close."** Honored. The extractor writes one
`.graph` mirror per source file under `.ok-planner/graph/`, each carrying
a `file` node and a `node` row per declared unit with a structural
identity and a content hash, plus `ref` edges. The "so that" clause is
delivered by a real consumer rather than left aspirational: `audit-check`
resolves `cite-node:` citations through the committed graph, and the
certification gates compute the re-audit set from those citations and from
the change inspector reading the graph — the recorded structure, not a
re-guess.

**Acceptance 1 — "The owner (or a certifying session) runs the vendored
graph tooling → the committed graph appears or refreshes."** Honored, and
"vendored" is literal rather than aspirational — but the evidence for
"literal" is the distribution mechanism, not any one project's current disk.
The planner converge core materializes `scripts/source-graph` to
`.ok-planner/bin/source-graph`, version-stamped and `chmod 755`, and its
diagnose pass checks that rendering for staleness alongside `audit-check`;
both the materialize line and the diagnose call are cited. That is what makes
the tool vendored for every project the owner converges. `build` regenerates
wholesale, creating the mirror directories, rewriting only files whose body
differs, and removing orphaned graph files (with a re-listing bottom-up sweep
so a deep tree does not shed one directory level per run). Both gates name
`.ok-planner/bin/source-graph build` as the step that precedes judging
citations.

This repo's own estate does not currently carry the vendored copy, and that is
outside the claim rather than against it. Its vendored layer is pinned to the
last committed converge, which is the v11.0.0 release-era rendering, predating
this tooling; the copy that briefly existed here was a mid-flight converge and
was correctly restored away. Per-project pinning is the commitment that a
project runs what it was converged to until the owner deliberately converges
again, so the gap between this repo's estate and the family source is that
decision working. What Acceptance 1 requires is that the tooling *be* vendored
by the converge core when a project is converged onto this version, and the
materialization span below is that guarantee, drift-checked on the same terms
as its siblings.

**Acceptance 2 — "byte-identical across repeated runs on an unchanged
tree."** Honored, and exercised twice over. The generator is a pure
function of the tree: a sorted walk with a fixed exclusion set and no
symlink following, sorted node rows, a deduplicated set of `ref` rows
emitted sorted, and hashes over exact span bytes. The harness builds twice
on an unchanged fixture and compares the concatenated graph files.
Re-verified independently against reality this cycle rather than carried on
the prior pass's word, because the tree itself moved: two consecutive builds
of the family-source program over a scratch copy of this repository's tracked
tree (247 files) produced identical concatenated digests
(`278e7388c95e…`), and `check` exited 0 on the result. The scratch copy is
necessary because the project carries no committed graph and `build` would
otherwise write one into an estate that is not converged onto this version.

**Acceptance 3 — "after an edit inside one declared unit, that unit's
recorded hash moves and unrelated hashes do not."** Honored, and the
harness asserts the negative half rather than only the positive: after
editing one line inside `side()`, exactly two `node` lines differ between
the before and after graph (the removed and added row for that one node),
the diff is confined to `src/app.js#side`, and the unrelated file's graph
is byte-identical. A second fixture pins the case that would have made
this claim false in the language the suite is mostly written in: a shell
function containing heredoc bodies with stray braces. Naive brace counting
would close the enclosing function early, so an edit after the heredoc but
inside the function would move no hash at all; `blank_sh_noise` blanks
heredoc bodies through their terminator (honoring both the quoted `<<'EOF'`
and the tab-stripping `<<-END` form), and the harness asserts the function
is neither split nor swallowed, that the post-heredoc edit does move its
hash, and that the neighbouring function's hash stands still.

The fixture's discriminating power was established adversarially in the prior
pass and that finding binds, its cited reality unmoved (both seeded body lines
and the enclosing spans verify unchanged this cycle). The finding, restated so
it is not re-derived: the two seeded heredoc bodies are deliberately
brace-*unbalanced* per line — a lone `}` in the quoted body, a lone `{` in the
tab-stripped one — where a balanced pair on one line would have cancelled under
per-line net counting and left a naive extractor accidentally correct. Run
through a copy of `source-graph` with the heredoc blanking removed, the
enclosing `emit` node's hash did **not** move across the post-heredoc edit
while `other`'s hash and the node structure were unharmed, so the harness's
second heredoc assertion flips to `bad` under that regression and only under
it. A genuine falsifier, correctly narrow: exactly one assertion discriminates,
and the seeded asymmetry is what makes it discriminate.

**Acceptance 4 — "with the committed graph out of date, the checker
reports drift and exits non-zero."** Honored on all three drift shapes the
checker distinguishes: `graph-missing` for a source file with no committed
graph, `graph-stale` for a committed graph that differs from the
regenerated one, and `graph-orphaned` for a graph file whose source is
gone. Exit is 2 whenever any finding exists. The harness exercises two
paths to non-zero — an in-unit edit before rebuilding, and a corrupted
graph file — and the same three findings are visible from the audit side,
where `audit-check` refuses to judge a `cite-node:` through a missing or
tree-divergent graph and reports `graph-missing` / `graph-stale` as its
own findings rather than passing silently (two more fixtures, both green
this cycle in the family harness at exit 0).

**Acceptance 5 — "The extractor and checker are real vendored tools
operating on the real source tree — not stubs."** Honored. They are one
stdlib-only python program, materialized into the estate by the converge
core in the same distribution shape as `audit-check`, with four real
adapters (markdown heading sections, JavaScript declarations and
require/import references, shell function declarations and
source/invocation references, and a generic explicit-path-reference
fallback that also runs for every text file) and a reference resolver that
emits an edge only when the token resolves to a file the walk actually
found. Verified against the real tree rather than only against fixtures:
run over this repository's 247 tracked files it produced a complete graph,
was byte-stable across runs, and checked clean. "Real vendored tool" is
carried by the converge core's materialize-and-diagnose pair, not by any
one project's current estate — see Acceptance 1.

Recorded as a boundary rather than a defect, because neither the story nor
the Acceptance claims it: the v1 adapter set has no python adapter, so
this repository's two python programs (`audit-check` and `source-graph`
themselves) receive a file node and no declared-unit nodes. The sprint that
built the tooling scopes adapters to JavaScript, shell and markdown and
names Python among the "later per-language additions" the adapter
interface admits without redesign, so this is deferred scope, not an
unfulfilled claim. The Acceptance's declared-unit conjunct is conditional
on a declared unit existing.

**Falsifier — "Two runs on an identical tree produce differing graphs; an
edit inside a declared unit leaves its recorded hash unchanged, or moves
unrelated hashes; a stale committed graph passes the checker silently."**
Each of the three is exercised in the negative by the harness, and the
third — the one that would be easiest to fake — is exercised twice, once
by an edit and once by corruption. The second is the one the heredoc
fixture guards, and it is demonstrated to be checkable rather than merely
asserted: with the heredoc handling removed, the falsifier's middle clause
obtains and the harness turns red.

**Proof — "a deterministic harness case that builds the graph twice on an
unchanged fixture and byte-compares the results, edits one declared unit
and observes exactly that node's hash move, and corrupts the committed
graph to observe the checker exit non-zero."** All three conjuncts are
exhibited, not modelled: the harness drives the actual program against a
real fixture tree it constructs, and every assertion is a consequence of
running it. The block is annotated `@story:
deterministic-source-graph` at the head of `test/proofs.sh` and runs green
on this tree (ten assertions across the two fixtures — seven and three —
with the whole harness at sixty-three assertions, exit 0). The proof
spans the Acceptance rather than a subset of it: the build/refresh, the
byte-identity, the in-unit hash movement with its unrelated-hash negative,
and the two non-zero drift paths are all covered, and the heredoc fixture
covers more than the Proof field literally asks. The one Acceptance clause
the harness exercises only against a fixture tree — "operating on the real
source tree" — was checked directly against a copy of the repository itself.

## Determination

**satisfied.** The tooling exists as a real program the converge core
vendors into a consumer estate, and delivers each Acceptance conjunct at a
citable point: a deterministic pure-function generator, a checker with three
distinguished drift findings and a non-zero exit, node identities derived
from declared structure rather than line positions, and content hashes over
exact span bytes. The proof exercises all three conjuncts of its Proof field
by running the real program, asserts the "unrelated hashes do not move"
negative rather than only the positive, and adds the heredoc case that guards
the one lexical shortcut that could have silently falsified the story.
Independently confirmed against this repository's own 247-file tracked tree:
deterministic across runs and clean under `check`.

The determination does not move on the changed reality, and the distinction it
turns on is worth stating because it will recur. "Vendored" is a property of
the distribution mechanism — the converge core materializes the extractor into
`.ok-planner/bin/`, stamped and executable, and diagnoses it for drift like
every other suite-owned file. It is not a property of any particular project's
current estate at a particular moment, because `decision:per-project-pinning`
deliberately holds a project's estate at the last committed converge. This repo
is presently behind that line and so does not carry the copy; a project
converged onto this version does, and the harness's own converged fixtures
exhibit it. What would falsify the conjunct is the converge core ceasing to
materialize the tool, and the span that pins that is cited and unmoved.

This determination stops holding if: `build` stops being a pure function of
the tree — an unsorted walk, an unsorted ref set, a timestamp, or a
mutable path in a hash would break byte-identity (the pinned `graph_for`,
`expected_graph`, `walk_sources` and `build` spans break first); `check`
stops distinguishing missing / stale / orphaned or stops exiting non-zero;
`blank_sh_noise` loses its heredoc handling, so a declared unit's span
stops surviving text the language does not read as code; the seeded
heredoc bodies are rebalanced or reduced to a single form, at which point
the fixture stops discriminating and the guard becomes decorative (the two
pinned body lines break first); the converge core stops materializing
`source-graph` into `.ok-planner/bin/`, making "vendored" false for
consumers (the pinned materialization span and the whole-file pin on the
converge core break); node identity is re-derived from line positions rather
than declared structure; or `test/proofs.sh` loses its
`deterministic-source-graph` block or its `@story:` annotation, at which point
the story's claims are asserted only as text.

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def graph_for(root, rel, fileset):" +49 sha256:7eb05d494b4d
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def expected_graph(root):" +3 sha256:cc355221871d
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def walk_sources(root):" +18 sha256:6b29d2b209f1
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def build(root):" +30 sha256:a6300c738da4
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def check(root):" +26 sha256:9f97ed446964
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def hash_pair(data, rel):" +9 sha256:67be9d7d4edd
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def blank_sh_noise(lines):" +8 sha256:8c646d3c0036
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "HEADER = "# source-graph v1 — mechanically generated; do not hand-edit.\n""
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "source-graph build|check [<project-root>]"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "    sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$SOURCE_GRAPH" > "${OK_DIR}/bin/source-graph"" +2 sha256:710a9e6e0dae
- cite: plugins/ok/families/ok-planner/admin/converge :: "    [ -f "$SOURCE_GRAPH" ] && check_rendered "$SOURCE_GRAPH" "${OK_DIR}/bin/source-graph" ".ok-planner/bin/source-graph""
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Implementation audit, two layers.**" +1 sha256:62a96e92cc0f
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "missing graph is a finding""
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: deterministic-source-graph"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# deterministic-source-graph: the vendored extractor builds the" +8 sha256:668af21ad84d
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- deterministic-source-graph: build twice, edit one unit, corrupt ---------" +63 sha256:fcc4649a6c64
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# A declared unit's span must survive text the language does not read as" +48 sha256:58072d2dac4c
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "a lone } closing brace, unbalanced, inside heredoc prose"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "	{ a lone opening brace in an indented heredoc body"
- cite-file: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:010bc19746e7
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:757afef3458e
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
