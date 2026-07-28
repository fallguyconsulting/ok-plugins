# Source-Graph Extensions — Design Sketch

**Date:** 2026-07-27
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

The source-graph certification sprint builds the substrate: a
committed, deterministic, syntax-derived graph of a project's sources
(nodes with structural identity and content hashes, edges from
syntactic reference and containment), audits citing node frontiers,
a two-layer re-audit trigger, and a recorded-adjudication ledger.
This sketch holds what was deliberately deferred — the capabilities
the substrate enables but the sprint does not deliver.

## Shape

**1. Further language adapters.** The sprint ships adapters for this
repo's own languages (JavaScript, shell, markdown). Consumer projects
need Go, TypeScript, Python, Swift, and eventually C++. Tree-sitter is
the intended parser class: one core, per-language grammars, pure
function of file bytes, error-tolerant. The open distribution question
is vendoring — tree-sitter needs native bindings or wasm grammar
bundles, and vendored planner tooling is stdlib-only today. Options:
web-tree-sitter with committed wasm grammars (megabytes per project),
a host-installed parser the vendored tool shells out to (breaks
self-containment), or per-language stdlib-lexical adapters in the
audit-check style (cheapest, coarser). Decide when the first consumer
project wants graph-backed certification.

**2. LSP-precision edges.** Lexical reference resolution
over-approximates. Language servers (gopls, tsserver, pyright,
sourcekit-lsp, clangd) resolve real semantic references and call
hierarchies. An optional refinement adapter could replace lexical
edges with resolved ones where a project's toolchain is available —
but LSP output depends on build configuration and versions, so it can
never be the deterministic baseline the committed graph regenerates
from. Design question: whether refined edges are a second committed
edge kind or an ephemeral overlay computed at certification time.

**3. DRY candidate pairing.** The graph cannot see duplication —
two near-identical leaves with fan-in 1 are topologically identical to
two unrelated ones. What it gives is the narrowed candidate space:
leaves hanging under the same claim root are where copy-paste
convergence happens. A similarity pass (textual or AST-shape) over
root-sharing leaf sets, reported like the oscillation detector
(report, never block). Bonus queries from the same structure: high
fan-in nodes as the hotspot/risk-concentration list; post-merge
fan-in deltas as recorded consolidation wins.

**4. Dead-code and ungoverned-capability workflows.** The substrate
makes the residue enumerable: nodes reachable from no claim root
through either edge kind. Classifying residue needs judgment —
support code (alive, serving a governed mechanism transitively),
ungoverned capability (canonize-or-remove: an intake issue proposing
the missing story or decision), or genuinely dead (removal
candidate). A periodic residue walk — perhaps a `/certify-all`
appendix — that presents the classified queue to the owner. Connected
ungoverned subgraphs (reachable only from other unclaimed code) are
the strongest canonize-or-remove signals.

**5. Symbol-granularity upgrades where v1 is coarse.** Node identity
is designed to grow from `path` to `path#declaration-chain` without
breaking audit references. Where a v1 adapter emits coarse nodes
(long unheaded prose sections, bash helper clusters), finer extraction
tightens closures without redesign. Anonymous/closure nodes stay
interior by convention — auditors cite named frontiers.

## Risks / unknowns

- Wasm grammar vendoring may be unacceptably heavy for small consumer
  repos; the stdlib-lexical fallback may prove good enough
  indefinitely.
- Similarity scoring invites exactly the interpretive quibbling the
  convergence work exists to kill; the DRY pass must stay
  report-only, with consolidation always an owner-planned act.
- Residue classification volume on a first run against a mature
  codebase could be large; the walk needs batching and a "classified,
  revisit never unless edges change" memory to avoid re-litigating
  the same residue every cadence.

## What this is not

- Not authorization to build any of the above.
- Not a change to the certification discipline the sprint commits to —
  extensions ride on the substrate; they do not reshape it.
