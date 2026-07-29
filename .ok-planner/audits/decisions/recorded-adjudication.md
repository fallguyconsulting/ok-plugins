---
audit: recorded-adjudication
artifact: decision:recorded-adjudication
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:2eff7826e6e9
---

# Are certification's judgments recorded transactions the next run reads, with every hunk dispositioned and residue reaching the owner?

## Confirmation

Satisfied.

- **Nominations are written where the next run reads them.** The change
  inspector records each nomination as a provisional `class: adjudicated`
  registry entry naming the audit it implicates, with `adjudication: open`,
  and is forbidden to write into audit files; the auditor adjudicates every
  open entry naming its refs — promoted into a citation carried by the audit,
  or dismissed with a stated reason — writing the outcome back into the
  registry only. Audit files carry no note ledger and no history: a promoted
  nomination surfaces solely as a new citation.
- **The pointer is validated, not merely stored.** An `adjudicated` entry
  must carry an `audit:` ref naming a live audit file, or the registry is
  `inspection-malformed` and the entry disposes of nothing; a live one closes
  the floor exactly as residue does. Both are exercised, as is the rejection
  of any third class.
- **Entries bind by standing, not by temperament.** They are keyed to node
  identities and pinned to the graph's recorded hash, and `check_inspection`
  treats an entry as live only while its pin matches the committed graph, so
  a recorded adjudication stands until the code it names moves — exercised
  directly (a live adjudication covering its node, then lapsing after an edit
  to it). The auditor prompt states the binding force: departing from a
  recorded adjudication requires naming the cited reality that changed.
- **Closure and residue.** The gate does not present as clean while any hunk
  lacks a disposition — mechanical, adjudicated, or residue — and the floor
  enforces that mechanically over the change's nodes; residue is enumerated
  to the owner in the presentation as intake material and served to the
  project's own corpus view at `/api/inspection`, which the story-level suite
  drives with one entry of each judged class and asserts on class, audit ref,
  note, and liveness.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:e1cca8db580a
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The inspector also dispositions every hunk of the change"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "residue is reported to the owner in the presentation as intake material"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:d969820d9244
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Nominations and their adjudications live here and only here"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.the-prompt @ sha256:d77b1a67b4e1
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "recorded adjudications BIND you"
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def parse_inspection_registry(root, findings):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "adjudicated must carry audit: naming a "
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities,"
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def inspection_now(self):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "if path == "/api/inspection":"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/Overview.svelte @ sha256:c76108d97ac0
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: adjudicated entries close the floor as residue does""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an adjudicated ref naming no live audit is malformed""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a class outside the two judged ones is malformed""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a live adjudication covers its node""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an adjudication lapses when the node it names moves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: mechanical account""
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "inspection-registry: the view serves the standing residue and the recorded adjudications, each live against the committed graph"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "inspection-registry: an entry whose node moved reads lapsed while its untouched neighbour still stands"
