---
audit: inspection-registry
artifact: decision:inspection-registry
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:9fff34ce4cb0
---

# Is the change inspection's state a permanent node-keyed registry whose closure floor the vendored checker enforces?

## Confirmation

Satisfied.

- **One committed, node-keyed, hash-pinned file.** The judgment layer's
  state is `.ok-planner/audits/inspection.md`, written only by
  certification's change inspector (the inspector prompt orders it there and
  forbids writing into audit files; the registry's format is fixed in the
  shared definitions). `parse_inspection_registry` accepts an entry only as
  `- node: <identity> @ sha256:<pin>` plus fields.
- **Only the judged classes are storable.** `INSPECTION_CLASSES` is exactly
  `residue` and `adjudicated`; an `adjudicated` entry must carry an `audit:`
  ref naming a live audit file, and any other class — `mechanical`
  included — is `inspection-malformed`. All three are exercised: adjudicated
  entries closing the floor, an adjudicated ref naming no live audit, and a
  stored `mechanical` class rejected.
- **Precedent semantics.** `check_inspection` counts an entry as live only
  while its pinned hash still matches the committed graph, so an entry rides
  forward untouched until the node it names moves and each pass works only
  the unclassified remainder. Exercised for both classes — a residue entry
  that lapses after its unit is edited, an adjudication that lapses the same
  way, and the corpus view reporting one entry lapsed while its untouched
  neighbour still stands.
- **The floor is mechanical, and a skipped pass fails it.** Every node whose
  recorded hash moved between the baseline graph and the current one — at
  unit granularity where the file declares units, plus the file node whenever
  the region outside every declared unit moved — must be mechanically
  accounted (a tripped citation) or covered by a live entry, else
  `inspection-unclassified`; changed nodes with no registry at all are
  `inspection-missing`, and a commit-range run judges against the passed base
  ref. The checker harness exercises each of these, and the story-level suite
  drives this repository's own vendored `.ok-planner/bin/audit-check` against
  a seeded repository: the skipped pass fails the clean bar, and the same
  tree passes once the disposition is recorded.
- **Standing residue reaches the owner and the corpus view.** The
  presentation enumerates residue as intake material (prose); the corpus view
  parses the registry per request and serves it at `/api/inspection`, where
  the built page renders the standing-residue panel. The suite writes a
  registry exactly as the inspector writes it — one entry of each judged
  class — and asserts both reach the view with their class, note, audit ref,
  and liveness.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:d969820d9244
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "stands while its pin holds"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "parseable by tooling (the dashboard reads its residue)"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:e1cca8db580a
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "residue is reported to the owner in the presentation as intake material"
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "INSPECTION_CLASSES = ("residue", "adjudicated")"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def parse_inspection_registry(root, findings):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "adjudicated must carry audit: naming a "
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities,"
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def inspection_now(self):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "if path == "/api/inspection":"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/Overview.svelte @ sha256:c76108d97ac0
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: missing registry""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: unclassified node""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: residue entries cover a new file whole""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: mechanical account""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a file-node entry covers the outside-units region""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: lapsed entry trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: adjudicated entries close the floor as residue does""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an adjudicated ref naming no live audit is malformed""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a class outside the two judged ones is malformed""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an adjudication lapses when the node it names moves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: the range-scoped floor sees the committed change""
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "certify-completion: a skipped judgment pass fails the gate"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "certify-completion: the same tree passes once the judgment pass recorded its disposition durably"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "inspection-registry: the view serves the standing residue and the recorded adjudications, each live against the committed graph"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "inspection-registry: an entry whose node moved reads lapsed while its untouched neighbour still stands"
