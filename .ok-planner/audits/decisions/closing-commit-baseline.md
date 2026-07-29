---
audit: closing-commit-baseline
artifact: decision:closing-commit-baseline
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:244d58f57a2a
---

# Is the close recorded as a commit stamp on the archived sprint, and is it the planning ceremony's baseline?

## Confirmation

Satisfied. Both halves are realized in prose — the stamp is written by the shared
close-out block the certification gates run, the baseline is resolved by the
planning ceremony — so the evidence is that text, cited narrowly, and no test is
owed.

- **The stamp, written after the archive commit.** The shared close-out block
  offers archival and commit as owner acts and, on the yes, *after the archive
  commit lands*, stamps the archived sprint with `closed: <sha of the archive
  commit>` in YAML frontmatter as one small follow-on commit, naming it as the
  baseline `/plan-sprint`'s out-of-band reconciliation reads.
- **Every certification gate does this.** The gates are the two skills that run a
  close-out — `/certify-work` and `/certify-all`, enumerated from
  `plugins/ok/families/ok-planner/skills/` and pinned below; each ends its process
  at step 6 by running `{{CERTIFY-CLOSE-OUT}}` from the shared certification core,
  so neither carries its own variant.
- **The baseline is the newest archived stamp.** `/plan-sprint` §1b takes the
  baseline to be the `closed:` stamp of the newest file under
  `.ok-planner/history/sprints/` that has one, and computes the reconciliation
  window as `git log --oneline <closed>..HEAD` plus the uncommitted tree.
- **No stamp yields no baseline.** With no archived sprint carrying a stamp, the
  ceremony says so and asks the owner once, in prose, whether to name a baseline
  ref or skip the walk — explicitly never guessing one.
- **The record lives on the artifact that defines the boundary.** The stamp sits
  in the archived sprint's own frontmatter; there is no second ledger, and this
  repo's own archive carries the stamps in that position.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-close-out @ sha256:511645a331fa
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md#sprint-planning.process.1b-reconcile-out-of-band-work @ sha256:6be9954f105f
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.** Every sprint closed by a certify gate carries the closing commit in its frontmatter: `closed: <sha>`, stamped at archival. The baseline is the `closed:` stamp of the newest file under `.ok-planner/history/sprints/` that has one. If no archived sprint carries a stamp (archives predating the mechanism), say so and ask the owner, once, in prose, whether to name a baseline ref or skip the walk this time — never guess one."
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:cd9e94f136a3
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:31db8a9edfad
- cite: .ok-planner/history/sprints/2026-07-28-ratify-inline-certification-repairs.md :: "closed: 4950be93c65e5bf3f9c769937b559b8d059f1f54"
