---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-27T22:10:00Z
artifact-hash: sha256:b4e9ff32eb78
---

# Whether reference between code and corpus is fixed one-way, and whether the incremental annotation rollout the Choice claims reaches the sessions it names

## Claims

**Title — "Code cites design; design never cites code."** Both halves hold; each
was checked separately rather than inferred from the other.

**"code carries kind-plus-slug annotations at load-bearing sites."** Honored, and
the form is exactly kind-plus-slug with no path, line number, or quotation
anywhere. Population enumerated from reality, from the generated catalogs pinned
below rather than from the artifact's examples: all twenty live decisions and all
sixteen live stories now carry at least one annotation somewhere in the tree
outside the estate. The sites are load-bearing rather than decorative — the
maintenance checks each carry the `@decision:` slug of the choice they enforce
(`checks/activation-guard` → `slash-only-activation`, `checks/token-resolution` →
`single-source-transclusion`, `checks/text-presence` → the four choices it
asserts), the audit checker carries `adversarial-implementation-audits` at its
masking table and at `check_audit`, the release skill carries
`lockstep-suite-version` at its mechanical-release section and at its
equality-assertion block, and the three families' converge cores and support
scripts carry theirs. Under the Choice's own rollout clause the census is not the
bar; that coverage is now complete is stronger than the clause requires.

**"corpus bodies are self-contained — no file paths, no symbol citations, no
quoted code, with slugs and invariant IDs the only sanctioned citation forms."**
Honored, checked exhaustively rather than by sampling. A sweep of every file
under `design/concepts/`, `design/stories/`, and `design/decisions/` for
backticked path shapes, source-file extensions, `code:` / `pkg:` citation forms,
bare URLs, and every dot-directory or `plugins/`-style path prefix returns
exactly one hit, and it is a false positive — the phrase "a source of truth with
the same weight as code: it describes the project as it stands" in
`concept:design-corpus`, where "code:" is prose punctuation. No artifact carries a
`references:` frontmatter field. Cross-artifact references are slug-form
throughout. The rule itself is canonically stated once in the shared definitions
file and enforced by the design-doc compliance reviewer both certify gates run.

**"design never cites code."** Holds, per the same exhaustive sweep. The only
path-carrying files under `design/` are the generated catalog tables of contents
— which cite sibling corpus files, not code, and are not artifact bodies — and
the `_discover/` scaffolding, which the self-containment rule explicitly exempts
as point-in-time discovery material.

**"Rollout is incremental: whoever consults an artifact while working on a file
leaves the annotation; there is no bulk pass."** Honored, with two enforcement
points, each in both its template and materialized form. The project-wide
`.ok-planner/CLAUDE.md` carries a dedicated **"Leave the annotation"** paragraph
addressed to exactly the population the clause names, stating incrementality
("not a bulk pass anyone runs"), the placement rule (the function, branch, or
block where the commitment is enforced), the citation-form restriction ("Kind
plus slug only: never a file path, a line number, or a quotation"), and the
idempotence rule. The always-in-context cheatsheet carries the short form beside
its statement of the citation direction. Both are template-plus-materialized
pairs whose spans hash identically (`sha256:bf4f272170ce` and
`sha256:b8de6498167e`), so this project's copies are not a hand-edit ahead of
what a consumer would receive; the converge core writes both from the templates
on every run, which is what makes the rule project-wide rather than skill-local.
The "no bulk pass" half remains true: no sweep exists and none has been run.
`/discover-design`'s pointer to that home is a true statement about the tree.

**Rationale — "Durability under motion: a refactor that moves files cannot
invalidate the design, and a doc that moves repos cannot orphan an artifact."**
Holds, and is a consequence of the self-containment half being real rather than
aspirational: because no artifact body names a path, no file move can invalidate
one. Recent history is the demonstration — the whole plugin layer moved from
`plugins/<name>/` to `plugins/ok/families/<name>/` and not one corpus artifact
needed a citation repair.

**Rationale — "The annotation grep plus the generated catalogs replace an
external index."** Holds. Both halves of the pair are present: the three
generated catalogs exist and are verified by the proof harness to list exactly
the files on disk, no external index exists anywhere to compete with them, and
the grep half now returns a hit for every live artifact.

**Rationale — "a code path diverging from a stated boundary becomes a defect
rather than an ambiguity."** Holds at the machinery level: the certify gates run
annotation integrity over changed files and a scoped consistency reviewer that
treats corpus/code disagreement as a finding, and `/plan-sprint`'s out-of-band
reviewer treats a change contradicting a live commitment as BEARING.

## Determination

**satisfied.** The one-way direction of reference is realized in both directions
of the claim. Corpus bodies are clean of code citations without exception across
an exhaustive sweep of all three catalogs; the annotation form, wherever it
appears, is kind-plus-slug with no paths or line numbers; the generated catalogs
stand in for an external index with nothing competing; and the incremental
rollout has a real, materialized enforcement point addressed to every session,
written from templates by the converge core so every converged project receives
it. Annotation coverage, which the Choice does not require to be complete, is in
fact complete for all twenty decisions and all sixteen stories.

This stops being true if: the "Leave the annotation" paragraph is dropped from
`scripts/ok-planner-CLAUDE.md` or the rollout sentence from
`scripts/ok-planner-cheatsheet.md` (either edit trips the pinned spans, and the
templates are the only thing standing between the clause and its previously
unenforced state); the converge core stops materializing either template into the
project; any artifact body acquires a file path, symbol citation, or quoted code
(the three catalog pins force a re-derivation whenever the corpus population
changes); a maintained external artifact-to-site index appears; or annotations
begin carrying paths or line numbers instead of kind plus slug.

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +10 sha256:bf4f272170ce
- cite-span: .ok-planner/CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +10 sha256:bf4f272170ce
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "annotations — and rollout is" +3 sha256:b8de6498167e
- cite-span: .claude/rules/ok-planner-cheatsheet.md :: "annotations — and rollout is" +3 sha256:b8de6498167e
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$TEMPLATE" > "${OK_DIR}/CLAUDE.md"" +6 sha256:63b5bec767c5
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Annotation rollout is incremental: any time an agent consults an" +8 sha256:7a59cc50bb4f
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Concept, story, and decision bodies are self-contained. The design owns the definition"
- cite: checks/activation-guard :: "# @decision: slash-only-activation"
- cite: checks/token-resolution :: "# @decision: single-source-transclusion"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "// @decision: code-cites-design"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "# @decision: adversarial-implementation-audits"
- cite-file: .ok-planner/design/decisions.md @ sha256:a49856e697e2
- cite-file: .ok-planner/design/stories.md @ sha256:25682d5ab708
- cite-file: .ok-planner/design/concepts.md @ sha256:fb41bd8fbc25
