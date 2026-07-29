---
audit: trace-corpus-to-code
artifact: story:trace-corpus-to-code
determination: satisfied
audited: 2026-07-28T22:51:36Z
artifact-hash: sha256:2a7a690c46b8
---

# Does the corpus view actually show which code each story and decision claims — and which regions nothing claims?

Refreshed. The design artifact's hash is unchanged. The one stale citation is
the whole-file pin on `test/proofs.sh`, moved by unrelated conjunct growth
elsewhere in the file. This story's own cited proof-side lines — the fixture
build, the listing/artifact/source-detail assertions, the multi-hit and
line-wrapping checks — are all unchanged; none re-flagged stale. Citation
regenerated; nothing else touched.

## Claims

**Why this is a rewrite, not a refresh.** The design artifact's hash is
unchanged (`sha256:2a7a690c46b8`), so the previous cycle's precedent would
ordinarily bind. It does not, because the changed bytes land squarely on what
C3 and C8 rested on: the whole `corpus-view` node moved, the two spans and the
one anchor the previous determination cited as the defect no longer exist, the
artifact-detail view moved, and the proof file moved. Both failing claims were
re-derived from the current tree and both were re-exhibited against a running
service rather than read off the source.

**C1 — "every live story and decision is listed with its audit
determination."** Quantified over the live catalogs, enumerated from reality
rather than from the artifact: `.ok-planner/design/stories/` holds 20 files and
`.ok-planner/design/decisions/` holds 26, and both catalogs' tables of contents
are pinned whole below as the enumeration source, so a new artifact re-triggers
this audit. Membership is by construction, not by roster — the builder walks
each design directory and takes every `.md` file it finds; the one hardcoded
element is the pair of *kinds*, and it is exactly the two the claim names.
Exhibited on this repository's own corpus: the listing route returned 46 rows,
20 story and 26 decision, every one carrying a determination read verbatim from
its audit's frontmatter (42 satisfied, 4 violated), with an explicit "no audit"
state available where none exists. **Honored.**

**C2 — "opening one shows the code that audit cites, excerpted in place."** The
artifact detail groups an audit's resolved citations by target file and now
attaches an `excerpts` list — one excerpt per claimed region, each with two
lines of context and the cited lines flagged — and the page renders every one
of them open inside the group it was reached from, labelling each when a
citation reaches more than one. **Honored.**

**C3 — "from any source file the reader sees which stories and decisions claim
which of its regions, and which regions nothing claims."** This is the claim the
previous cycle refuted, and it is now honored.

Resolution records every location a citation reaches as a `regions` list —
1-based inclusive ranges, in file order — and that one list is what every
downstream consumer reads: the coverage tally in the corpus build, the per-line
marks in the source detail, and the excerpts on the artifact detail. The
first-occurrence-only `start`/`end` pair survives only as the convenience the
summary lines use, and the separate `hits` list nothing consumed is gone. A
file-scoped citation carries no regions at all, which is what keeps C5 true.

**Exhibited against a running service, not inferred.** On a scratch fixture
(one decision, one audit citing `cite: src/reg.py :: "register(handler)"`,
that anchor present on three lines), the artifact route returned
`regions [[2,2],[8,8],[13,13]]`, `detail "anchor appears on 3 lines; all are
marked"`, and three excerpts starting at 2, 8 and 13; the source route marked
lines 2, 8 and 13 and no others; and the sources route counted three claimed
lines for that file. The same fixture with an anchor that wraps across three
physical lines resolved to one region `[2,4]`, marked lines 2–4, and reported
`detail "anchor spans several lines"`. Every surface gives one answer about the
same region. This exhibition rests on the resolver span, the `regions`
contract, the two consumer lines and the artifact-detail excerpt loop cited
below; re-run it only if one of those moves.

**C4 — "the sources carrying no claim at all are reachable as a view of their
own rather than left implicit."** The corpus builds its source population from
the committed graph where one exists and from git's view of the working tree
where it does not — so a corpus claiming three files cannot read as fully
covered — and emits every source with its claim counts. Exhibited on this
repository: 291 sources, 181 of them claimed by nothing. The code view lists
them all with an explicit "only sources nothing claims" filter. **Honored.**

**C5 — "A claim over a whole file is shown as the file-level claim it is, never
as a claim over each of its lines."** Whole-file pins resolve into a `file`
scope (`cite-file:`, and a `cite-node:` identity with no declaration chain) and
carry an empty `regions` list by construction, so they contribute no per-line
mark and no covered-line count. Exhibited: a `cite-file:` pin on a six-line
fixture file produced zero marked lines, one population entry, and
`claimed_lines 0`. Both surfaces say so in words as well. **Honored.**

**C6 — "The determinations, citations, and code are the project's real ones,
resolved by the project's own materialized audit checker, so the view never
contradicts what that project's certification gate reports."** Determinations
are read verbatim from audit frontmatter, never recomputed. Resolution is
delegated: the checker's own compiled citation patterns parse the lines, and
its anchor location, release-metadata masking, span hashing, whole-file hashing
and graph loading settle every verdict. The checker is loaded from the
project's own `.ok-planner/bin/audit-check` where the project has one, and
every request rebuilds the corpus from a fresh read of the tree after clearing
the checker's graph cache, so a long-lived server cannot report a citation
current that the gate already calls stale. **Honored,** with two boundaries
restated under Determination.

**C7 — the Falsifier.** All four disqualifying observations are absent. No
artifact is shown claiming code its audit does not cite; a whole-file claim is
not rendered as if every line served the artifact; uncited sources are not
invisible; and the view's staleness verdict does not depart from the checker's.
The half-clause the previous cycle had to reason around — code a citation
reaches left unmarked while the page said otherwise — no longer occurs at all.

**C8 — does the proof span the Acceptance?** The story's only annotated proof
is the harness section, and it now carries both live artifact kinds. The
fixture creates a story with its audit *and* a decision (`loopback-ports`) with
its own audit carrying a `violated` determination and an issue link, and the
section asks the listing route directly, asserting that both kinds are present
and that each carries the determination its audit recorded. It then drives the
decision's audit through the same route pair the story goes through — artifact
detail and source detail — asserting that the multi-hit anchor's two
occurrences are both excerpted on the artifact page and both marked in the
code, which is the conjunct the previous cycle found missing. Alongside those:
a story's cited code excerpted with the right lines flagged; the source file
showing that story's claim, an unclaimed region, and the whole-file pin held as
file-level; an uncited source as its own row; the graph adopted as the
population by a long-lived process after the tree moved under it; and a
deliberately broken citation reading stale in agreement with the checker. Run
on this tree, every conjunct passes. That spans C1 through C6. **Honored.**

Refreshed again. The design artifact's hash is unchanged. The one stale
citation is the whole-file pin on `test/proofs.sh`, moved by the
owner-ratified cap-rewording exhibitions added to the `certify-completion`
story's section elsewhere in the file. This story's own cited proof-side
lines — the fixture build, the listing/artifact/source-detail assertions,
the multi-hit and line-wrapping checks — are all unchanged; none re-flagged
stale. Citation regenerated; nothing else touched.

## Determination

**satisfied.** The two counts the previous cycle charged are both discharged,
and both were re-exhibited rather than read.

C3's defect was structural: a multi-hit `cite:` anchor recorded every
occurrence, then narrowed itself to the first before anything downstream saw
it, so the artifact page asserted every match was marked while the source page
marked one and showed the rest as claimed by nothing. The recorded occurrence
list is now the *only* thing downstream reads — the coverage tally, the marks
and the excerpts all iterate it — so the two directions cannot part company by
construction. Driving a running service over a three-occurrence anchor and a
line-wrapping anchor produced identical answers from the artifact route, the
source route and the coverage tally in every case.

C8's defect was coverage: the proof exercised neither the listing route nor a
decision at all, so half of the Acceptance's first clause was green by absence.
The fixture now carries a decision with its own audit and determination, the
listing is asserted for both kinds, and the decision is followed through the
same two routes the story is.

Two boundaries are recorded as true-but-narrow rather than as failures,
unchanged in substance from the previous cycle because the story's own wording
ties "real" to agreement with the gate rather than to byte-identity, and ties
resolution to a checker the project has:

- The code the view displays is the checker's **masked** text, not the file's
  bytes: a release-metadata line reads `0.0.0` where the file carries the real
  version. This is deliberate — it is what the gate compared — but it is
  undisclosed in the page, and on this repository it touches every materialized
  file's stamp line.
- Where a project has not converged, the checker is loaded from the front
  door's carried payload instead of the estate, announced in the terminal and
  in the page header. A project with no materialized checker has none to be
  "its own", and the proof's own fixture is such a project — so the pinned
  resolution path C6 names is exercised by this repository's live corpus rather
  than by the harness.

Also noted, outside the claims and unchanged: a citation line the gate reports
as `audit-malformed` does not parse into a citation here and is silently absent
from the view rather than surfaced. That is omission, not contradiction.

**What would have to change for this to stop holding.** C3 fails again the
moment any consumer stops reading `regions` and goes back to a single
`start`..`end` pair — the coverage `update`, the per-line `marks.setdefault`,
or the artifact detail's excerpt loop are the three sites, all cited. It also
fails if the resolver stops recording every occurrence, or if the
multi-hit detail text is reworded to promise something the regions do not
deliver. C1 stops holding if the design-kind map narrows or if listing stops
walking the directories (both cited); the two catalog pins re-trigger this
audit when the population itself moves. C5 fails if a file-scoped citation ever
acquires regions. C8 fails if the decision fixture, its audit, or the
listing-route assertion leaves the harness section.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-file: .ok-planner/design/decisions.md @ sha256:457a9c1af13a
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "DESIGN_KINDS = {"story": "stories", "decision": "decisions"}"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "for kind, folder in DESIGN_KINDS.items():"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _base(self, form, target, scope):" +12 sha256:bbb6631ab32d
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _set_regions(out, regions):" +5 sha256:75c9c003fd9d
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _resolve_anchor(self, target, anchor):" +9 sha256:98f6b0735e2a
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "out["detail"] = ("anchor appears on %d lines; all are marked""
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "covered.update(range(lo, hi + 1))"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "marks.setdefault(n, []).append({"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "entry["excerpts"] = ["
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def excerpt(self, rel, start, end, context=2):" +9 sha256:e6b2ec281298
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def source_detail(self, rel):"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _resolve_file_pin(self, target, pinned):" +6 sha256:dac1fa708611
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _population(self):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "listed = self.extractor.git_listed_files(self.root)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "lines = self.checker.mask_release_metadata(raw, rel).splitlines()"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "return Corpus(self.root, self.checker, self.extractor)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def resolve_citation(self, raw):"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "def load_tooling(root):" +4 sha256:98b2caa37c65
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte @ sha256:d16c5f5b6628
- cite: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte :: "{#each c.excerpts as ex (ex.start)}"
- cite: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte :: "return `${rs.length} regions — ${rs.map(span).join(', ')}`;"
- cite: plugins/ok/families/ok-planner/browser/src/views/ArtifactDetail.svelte :: "<strong>Whole file</strong> — read as a population source"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte @ sha256:668c4c1edbda
- cite: plugins/ok/families/ok-planner/browser/src/views/SourceView.svelte :: "That is a claim over the file, not over each of its lines: no line"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/SourceList.svelte @ sha256:538a2fda26a0
- cite: plugins/ok/families/ok-planner/browser/src/views/SourceList.svelte :: "only sources nothing claims"
- cite-node: plugins/ok/families/ok-planner/browser/src/views/ArtifactList.svelte @ sha256:76cde5e7ea19
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "cat > "$view_tmp/.ok-planner/audits/decisions/loopback-ports.md" <<FIXTURE"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "arts=$(fetch "$base/api/artifacts")"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "fetch "$base/api/artifact/decision/loopback-ports" > "$view_tmp/dec.json""
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "sys.exit(0 if (c["regions"] == [[2, 2], [8, 8]]"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "detail=$(fetch "$base/api/artifact/story/see-data")"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "src=$(fetch "$base/api/source?path=src/served.py")"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "srcs=$(fetch "$base/api/sources")"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "graphed=$(fetch "$base/api/meta")"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "broken=$(fetch "$base/api/artifact/story/see-data")"
