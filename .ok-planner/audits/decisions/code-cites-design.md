---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-27T12:23:17Z
artifact-hash: sha256:b4e9ff32eb78
---

# Whether reference between code and corpus is fixed one-way, and whether the incremental annotation rollout the Choice claims actually reaches the sessions it names

## Claims

**Title — "Code cites design; design never cites code."** Both halves hold; each
is checked separately below rather than inferred from the other.

**"code carries kind-plus-slug annotations at load-bearing sites."** Honored, and
the form is exactly kind-plus-slug with no path, line number, or quotation
anywhere: the repo's maintenance checks each carry the `@decision:` slug of the
choice they enforce (`checks/activation-guard` → `slash-only-activation`,
`checks/owned-paths` → `whole-file-ownership`, `checks/vendored-layer` →
`vendored-skills`, `checks/hub-rows` → `@concept: skill`), the family converge
cores and the workspaces/plumbline machinery carry theirs, and the three proof
harnesses carry `@story:` slugs. Population enumerated from reality, from the
generated catalogs pinned below rather than from the artifact's examples: of the
twenty live decisions, thirteen are annotated somewhere in the tree and seven are
not (`adversarial-implementation-audits`, `closing-commit-baseline`,
`code-cites-design`, `content-addressed-src-tag`, `declared-stack-profile`,
`lockstep-suite-version`, `teardown-gates-in-git-flags`); of the sixteen live
stories, fifteen are annotated and one is not (`corpus-audit`). Under the
Choice's own rollout clause — which claims incrementality, not completeness —
partial coverage is the state the Choice describes, not a refutation of it. The
adversarial question is therefore not "is coverage total?" but "does the rollout
rule reach anyone?", answered below.

**"corpus bodies are self-contained — no file paths, no symbol citations, no
quoted code, with slugs and invariant IDs the only sanctioned citation forms."**
Honored, checked exhaustively rather than by sampling: a sweep of every file
under `design/concepts/`, `design/stories/`, and `design/decisions/` for
backticked path shapes, source-file extensions, `code:` / `pkg:` citation forms,
and bare URLs returns exactly one hit, and it is a false positive — the phrase
"a source of truth with the same weight as code: it describes the project as it
stands" in `concept:design-corpus`, where "code:" is prose punctuation, not a
citation form. No artifact carries a `references:` frontmatter field.
Cross-artifact references are slug-form throughout (`see also: <slug>`,
`<kind>:<slug>`). The rule itself is canonically stated once in the shared
definitions file and is enforced by the design-doc compliance reviewer both
certify gates run.

**"design never cites code."** Holds, per the same exhaustive sweep. The only
path-carrying files under `design/` are the generated catalog tables of contents
(which cite sibling corpus files, not code) and the `_discover/` scaffolding,
which the self-containment rule explicitly exempts as point-in-time discovery
material.

**"Rollout is incremental: whoever consults an artifact while working on a file
leaves the annotation; there is no bulk pass."** Honored, and this is the clause
that had no enforcement point at the previous audit; it now has two, in both
their template and materialized forms. The project-wide `.ok-planner/CLAUDE.md`
carries a dedicated **"Leave the annotation"** paragraph addressed to exactly the
population the clause names — "any time you consult a concept, story, or decision
to understand or modify a file, leave `@concept:` / `@story:` / `@decision:` plus
the slug in a comment at the most-specific load-bearing site in that file" —
stating incrementality ("not a bulk pass anyone runs"), the placement rule (the
function, branch, or block where the commitment is enforced), the citation-form
restriction ("Kind plus slug only: never a file path, a line number, or a
quotation"), and the idempotence rule. The always-in-context cheatsheet carries
the short form of the same rule beside its statement of the citation direction.
Both are template-plus-materialized pairs whose spans hash identically
(`sha256:bf4f272170ce` and `sha256:b8de6498167e`), so this project's copies are
not a hand-edit ahead of what a consumer project would receive; the converge core
writes both from the templates on every run, which is what makes the rule
project-wide rather than skill-local. The "no bulk pass" half remains true: no
sweep exists and none has been run. `/discover-design`'s pointer — the rule "is
documented in `.ok-planner/CLAUDE.md` (materialized by the front door's
administration) so it applies project-wide regardless of which skill is active" —
is now a true statement about the tree rather than a dangling reference.

**Rationale — "Durability under motion: a refactor that moves files cannot
invalidate the design, and a doc that moves repos cannot orphan an artifact."**
Holds, and is a consequence of the self-containment half being real rather than
aspirational: because no artifact body names a path, no file move can invalidate
one. This working tree is itself the demonstration — the entire plugin layer
moved from `plugins/<name>/` to `plugins/ok/families/<name>/` in this change, and
not one corpus artifact needed a citation repair.

**Rationale — "The annotation grep plus the generated catalogs replace an
external index."** Holds. Both halves of the pair are present: the generated
catalogs exist (`design/concepts.md`, `design/stories.md`, `design/decisions.md`,
each verified by the proof harness to list exactly the files on disk), no
external index exists anywhere to compete with them, and the grep half now has a
mechanism feeding it — the rollout paragraph above — rather than being starved by
a rule nobody was told. The claim is about what replaces an index, not about
census completeness, and the replacement is in place.

**Rationale — "a code path diverging from a stated boundary becomes a defect
rather than an ambiguity."** Holds at the machinery level: the certify gates run
annotation integrity over changed files and a scoped consistency reviewer that
treats corpus/code disagreement as a finding, and `/plan-sprint`'s out-of-band
reviewer treats a change contradicting a live commitment as BEARING.

## Determination

**satisfied.** The one-way direction of reference is realized in both directions
of the claim: corpus bodies are clean of code citations without exception across
an exhaustive sweep, the annotation form where present is kind-plus-slug with no
paths or line numbers, and the generated catalogs stand in for an external index
with nothing competing. The clause that previously failed — the incremental
rollout — now has a real enforcement point: the instruction addressed to
"whoever consults an artifact while working on a file" lives in the project-wide
`.ok-planner/CLAUDE.md` and, in short form, in the always-in-context cheatsheet,
both materialized from templates by the converge core so every converged project
receives them, and `/discover-design`'s pointer to that home is now accurate.
Coverage is still partial (seven of twenty decisions and one of sixteen stories
unannotated), which is what an incremental rollout looks like part-way through
and is what the Choice's own text describes; the previous audit's objection was
that nothing was positioned to reduce that number, and that is no longer the
case — the number moved from nine and eight to seven and one in this change.

This stops being true if: the "Leave the annotation" paragraph is dropped from
`scripts/ok-planner-CLAUDE.md` or the rollout sentence from
`scripts/ok-planner-cheatsheet.md` (either edit trips the pinned spans, and the
templates are the only thing standing between the clause and its previous
unenforced state); the converge core stops materializing either template into the
project; any artifact body acquires a file path, symbol citation, or quoted code;
a maintained external artifact-to-site index appears; or annotations begin
carrying paths or line numbers instead of kind plus slug.

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +10 sha256:bf4f272170ce
- cite-span: .ok-planner/CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +10 sha256:bf4f272170ce
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "annotations — and rollout is" +3 sha256:b8de6498167e
- cite-span: .claude/rules/ok-planner-cheatsheet.md :: "annotations — and rollout is" +3 sha256:b8de6498167e
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$TEMPLATE" > "${OK_DIR}/CLAUDE.md"" +6 sha256:63b5bec767c5
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Annotation rollout is incremental: any time an agent consults an" +8 sha256:7a59cc50bb4f
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Concept, story, and decision bodies are self-contained. The design owns the definition"
- cite: checks/activation-guard :: "# @decision: slash-only-activation"
- cite-file: .ok-planner/design/decisions.md @ sha256:861b9f930c18
- cite-file: .ok-planner/design/stories.md @ sha256:25682d5ab708
