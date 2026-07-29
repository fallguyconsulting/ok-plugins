---
audit: trace-corpus-to-code
artifact: story:trace-corpus-to-code
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:f51163818df1
---

# Which code each live story and decision claims, and which sources nothing claims

## Confirmation

Satisfied. The corpus view (`scripts/corpus-view`, started by the `/browse`
verb) serves both directions of the relation from the project's own design
corpus, audits and source graph, and the suite exercises it over a real
HTTP surface against a fixture project carrying both artifact kinds.

- **Which code each live story and decision claims.** The live population is
  enumerated by walking `design/stories` and `design/decisions`, so a new
  artifact enters the listing without registration; `artifact_summaries`
  carries each artifact with the determination its audit recorded, and
  `artifact_detail` groups the audit's resolved citations by target file and
  attaches one excerpt per claimed region. The suite asserts both kinds
  appear with their recorded determinations, that opening a story excerpts
  exactly the lines its audit's span cites, and that a plain anchor matching
  two lines yields both regions — excerpted on the artifact page and marked
  in the source view, so the two directions never disagree about one region.
- **The reverse direction.** `source_detail` marks each line with every
  artifact whose citation reaches it, and keeps a whole-file pin as a
  file-level `population` entry rather than a mark on every line. The suite
  asserts the claiming story, an unclaimed region beside it, and the
  file-level treatment of the whole-file claim.
- **Which sources nothing claims at all.** `_population` takes the committed
  source graph as the population when one exists and falls back to the same
  git-sourced walk the extractor uses, so an unclaimed file is a row of its
  own rather than an absence to infer. The suite asserts the orphan source
  is listed with zero line and file claims while its claimed neighbour
  counts one, and that the population switches to the graph once a graph is
  built — asked of the same long-lived server after the tree moved under it,
  because `corpus_now` re-reads the tree per request.
- **Without re-deriving it from audit prose.** Every region shown is
  resolved from the audit's citation lines through the project's own
  checker, and the suite asserts a deliberately broken citation reads stale
  in the view exactly as the checker reports it.

## Referrals

- referral: the rendered page a reader actually looks at — layout, gutter
    marks, foldable excerpts, navigation between the two directions
  clause: "I want to see which code each live story and decision claims"
  delivered: the committed Svelte build's views (artifact detail, source
    view) consume every data route the tests exercise, and the service
    serves that build from the estate
  discipline: ux

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def artifact_summaries(self, kind=None):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def artifact_detail(self, kind, slug):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def source_detail(self, rel):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _population(self):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def corpus_now(self):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _static(self, view, path):"
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md#browse-the-corpus @ sha256:52cd4dceb325
- cite-node: plugins/ok/families/ok-planner/browser/src/lib/api.js @ sha256:12ecd77eaa01
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte @ sha256:d16c5f5b6628
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte @ sha256:668c4c1edbda
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: the listing carries every live story and decision with its audit determination"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: opening a story excerpts the code its audit cites"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: the file shows the claiming story, an unclaimed region, and the whole-file claim as file-level"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: a source nothing claims is listed as its own row, not left implicit"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: coverage is reported over the committed graph once one exists"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: a broken citation reads stale in the view exactly as the project's own checker reports it"
