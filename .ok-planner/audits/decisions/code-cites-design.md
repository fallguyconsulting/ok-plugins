---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:2478a5f439ea
---

# Is reference between code and corpus fixed one-way — kind-plus-slug annotations in code, self-contained bodies in the corpus — with rollout incremental and no bulk pass?

Amended, not rewritten. The design artifact's hash is unchanged
(`sha256:2478a5f439ea`, the same value the prior two passes carried), no note
is open, and exactly two citations went stale: the concept and decision
catalog population pins. Two artifacts were added — `concept:completion-report`
and `decision:inspection-registry` — so clause 3's population grew from 73 to
75 and had to be re-swept and its new members read individually. Clause 2's
annotation population was re-enumerated from reality as well, since it moves
without breaking any pin. Every other cited anchor, span, and node was
re-verified unchanged by the checker and is carried.

One genuinely new candidate refutation arrived with this cycle's machinery and
is tested below rather than waved through: the **inspection registry**, a
committed file that maps source-graph node identities to the audits implicated
in them — read uncharitably, the "maintained external index" the Alternatives
rejected.

Amended again. The subsequent fix cycle added one `residue` entry to the
inspection registry (a hub-row repair no audit's territory covered); the
population pin was the only stale citation, and the registry's entry count in
the Rationale evidence below is corrected from four to five. The registry's
character — node-keyed, hash-pinned, judged-classes-only — is unchanged by
gaining a residue member; nothing about the determination moves.

Amended a third time. The change inspector's next run added twelve more
`adjudicated` entries to the registry (five distinct audits' territory, none
of them this one) and left the standing `residue` row untouched; the
population pin was again the only stale citation, and the Rationale evidence
below is corrected from five entries to seventeen (sixteen `adjudicated`,
one `residue`). The registry's character — node-keyed, hash-pinned, exactly
the two judged classes the format defines — is unchanged by the growth;
nothing about the determination moves.

## Claims

**Title + Choice clause 1 — "The direction of reference between code and the
design corpus is fixed one-way."** Both directions are enforced by separate
machinery: code→corpus by the lint's citation-resolution check, corpus→code by
the self-containment rule and the reviewer that applies it. Neither direction is
merely conventional. Honored.

**Choice clause 2 — "code carries kind-plus-slug annotations at load-bearing
sites."** The lint's citation mechanism admits an annotation only as a declared
tag followed by a bare kebab-case slug, and the starter wires exactly the three
kind→path templates when a planner estate is detected, so `@concept:`,
`@story:` and `@decision:` resolve to their catalogs' files. The resolution
check then fails any slug whose substituted path does not exist. All four
plumbline spans that carry that mechanism re-verified byte-identical this
cycle (the checker flagged none of them), so the mechanism itself did not move.

Re-derived from reality rather than carried, because no citation form pins the
annotation population: sweeping every annotation in the tree (including
git-ignored paths, checked separately and identical) yields **62** distinct
kind-plus-slug pairs, up from 53. Fifty of them resolve to a live artifact of
the matching kind. The twelve that do not were each traced to its site
individually:

- **Illustrative slugs in prose** — `@concept: cascade`, `@story: parker` and
  `@concept: claim-holder-guard` appear only in the lint's own help text, its
  style guide, and its cheatsheet, as examples of the annotation form.
- **Lint fixtures** — `@concept: foo` and `@concept: missing` are the two
  fixture files that exist precisely to exercise the resolved and unresolved
  cases; the unresolved one is required to stay unresolved.
- **Throwaway proof fixtures** — `@story: alpha`, `@story: beta` and, new this
  cycle, `@story: mixed-pass` / `@story: mixed-fail` are strings the planner's
  own proof harness *writes into* temp files at runtime to exercise the
  timing recorder's one-harness-two-stories shape. They are string literals in
  a generator, not annotations on code.
- **Not code sites at all** — `@decision: annotation` is the prose heading "the
  @concept: / @story: / @decision: annotation convention" in the point-in-time
  discovery scaffold. `@concept: front-door` and
  `@decision: append-only-issue-queue`, which the prior pass traced to an
  archived issue and an archived sprint, now appear **nowhere in the tree except
  inside this audit file's own prose** — the records that carried them are gone,
  so the class shrank rather than grew.

No live code site claims a design artifact that does not exist. Honored.

The two artifacts new this cycle carry no annotation anywhere, which is not a
finding but the clause working: rollout is incremental (clause 4), so a
brand-new artifact's first annotation lands whenever a session next consults it
while working the enforcing file — there is no bulk pass to have missed.

**Choice clause 3 (quantified) — "corpus bodies are self-contained — no file
paths, no symbol citations, no quoted code, with slugs and invariant IDs the
only sanctioned citation forms."** The population is every live artifact in the
three catalogs. Enumerated from the three generated tables of contents and
reconciled against the files on disk, slug set against basename set (not merely
count against count): **28 concepts, 20 stories, 27 decisions — 75**, up two
from 73. All three catalogs are pinned below, so the next catalog change forces
this population to be re-enumerated.

Sweeping all 75 bodies for the disallowed forms returns nothing: no
extension-bearing filename, no directory path, no backticked path fragment, no
URL or loopback address, no fenced code block, no `code:`/`pkg:`/`src:`/`path:`
citation form, and no `@concept:`/`@story:`/`@decision:` tag (design does not
cite code even in the annotation's own vocabulary). The single lexical hit
across the whole corpus is the word "code" followed by a colon in ordinary
prose in one concept body — the same non-citation the previous two cycles
recorded. The canonical rule that defines the prohibited forms is transcluded
into the design-doc compliance reviewer, which runs over the corpus as a
certification pass, so the property is checked and not merely asserted.

The two new artifacts were read individually against the rule rather than
trusted to the sweep, since they are the members most likely to have descended
— and both describe file-shaped things, which is the risky case.
`concept:completion-report` describes its subject as "one file beside the sprint
document, named for it" and "same filename with `-completion`" appears nowhere
in it; it names no path, no directory, and no script.
`decision:inspection-registry` describes "one committed registry file in the
audit corpus" and "the vendored checker" — capabilities and locations in prose,
never `.ok-planner/audits/inspection.md` or `audit-check`. Both use `see also:`
slug cross-references, which is the sanctioned form. Honored.

**Choice clause 4 — "Rollout is incremental: whoever consults an artifact while
working on a file leaves the annotation; there is no bulk pass."** The
instruction is materialized into every consumer's estate guide as a standing
session rule — leave the annotation at the most-specific load-bearing site, kind
plus slug only, never a file path or line number or quotation — and explicitly
disclaims a bulk pass, bounding annotations to exactly two jobs (navigation and
proof registration) with no part in certification scope or audit invalidation.
That span is unchanged this cycle. Correspondingly, no verb in any family sweeps
the tree adding annotations: the corpus audit's annotation pass reports dangling
and kind-mismatched annotations and fixes nothing, no converge core writes an
annotation, the source-graph extractor reads declared structure rather than
tags, and the change inspector — new machinery this cycle that *does* read the
whole change — keys its output to graph node identities, never to annotations.
The absence is the claim, and the absence holds. Honored.

**Rationale — "Durability under motion: a refactor that moves files cannot
invalidate the design, and a doc that moves repos cannot orphan an artifact."**
The capability follows from clause 3 as implemented: since no body names a path,
there is nothing in a body a file move can invalidate. The converse direction is
protected too — an annotation is checked by slug against the artifact's
basename, so moving the code file does not break the link. Honored.

**Rationale — "The annotation grep replaces an external index."** Honored, and
this is the clause the cycle's new machinery put under real pressure. The
annotations remain greppable by a fixed two-token form, and the estate holds no
artifact-to-code index file *of the rejected kind*. Three candidates were tested
against the Alternatives' stated cost — "a second source of truth that drifts
from both":

- The **source graph** is code-about-code: nodes and hashes over the source
  tree, carrying by its own concept's boundary "no audit content, no
  annotations, and nothing hand-written". It indexes sources, not artifacts.
- The **audit corpus** associates an artifact with code sites through its
  Citations block. An audit's citations cannot drift silently — a moved hash or
  a broken anchor is a mechanical staleness finding that forces re-derivation.
  A verification record whose citations rot loudly is not a navigation index
  maintained in parallel.
- The **inspection registry**, new this cycle, is the sharpest candidate: a
  committed file whose entries pair a source-graph node identity with the audit
  implicated in it. It fails to be the rejected alternative on all three counts.
  Its direction is code→judgment, not artifact→site: entries are keyed by node
  and merely *name* the audit carrying a note, so it answers "is this change
  accounted for", never "where is this concept enforced". Its staleness is not
  merely detectable but *enforced* — every entry carries the node's recorded
  hash, an entry lapses the moment that hash moves, and the checker's closure
  floor fails the gate rather than serving a stale row. And nothing reads it for
  navigation; it is written only by the change inspector and read only by the
  checker and the corpus view. The registry as it stands holds seventeen
  entries: sixteen `adjudicated`, spanning five audits (story:explain-lint-rules,
  decision:no-execution-engine, decision:two-layer-invalidation,
  decision:prove-audit-audience-split, decision:adversarial-implementation-audits),
  all hash-pinned, plus the one `residue` entry carried from the prior pass
  (a hub-row repair the inspector could not match to any audit's claimed
  territory) — the same node-keyed, hash-pinned shape: exactly the two judged
  classes the format defines, unchanged by this pass's growth, rather than a
  drift toward the rejected alternative.

None of the three refutes the clause.

**Rationale — "a code path diverging from a stated boundary becomes a defect
rather than an ambiguity."** The mechanism that converts divergence into a
defect is the annotation-integrity rule plus the lint's resolution check: a slug
that no longer resolves is a lint violation at the code site, and a
kind-mismatched annotation is a reported finding with a determined fix. Honored.

## Determination

**satisfied.** The one-way direction is enforced from both ends. Code-side, the
lint admits only slug-only citation blocks and fails any slug that does not
resolve to its kind's artifact file; all 62 annotations in this tree were
re-enumerated from reality and every one either resolves or was traced
individually to prose, a lint fixture, or a runtime-generated proof fixture —
and the "unresolved but not a code site" class shrank this cycle rather than
grew. Corpus-side, all 75 live artifacts — enumerated from the three generated
catalogs, whose slug sets match the files on disk exactly — carry no path,
symbol, quoted code, URL, or external-doc citation, with the two artifacts new
this cycle read individually against the rule despite both describing
file-shaped subjects, and the rule that forbids them is transcluded into the
reviewer that audits the corpus. Rollout is left to the sessions that consult an
artifact, stated in the materialized estate guide, and no verb performs a bulk
annotation pass — including the change inspector, which keys its judgments to
graph nodes and never to tags. Decisions carry no proof obligation.

Amended, not carried whole: this audit went stale because two of the three
catalog pins moved on two added artifacts. The enlarged population was swept
whole and its new members read individually; both are self-contained. The
Rationale's anti-index clause was re-tested against the cycle's new inspection
registry — the strongest candidate this decision has faced — and the registry
turns out to be the opposite of the rejected alternative: hash-pinned, keyed by
node rather than by artifact, mechanically failed rather than silently drifting,
and read by no navigator. Nothing about the decision moved.

This stops holding if: an artifact body acquires a path, symbol, quoted code, or
external-doc citation (the catalog pins break on any catalog change, forcing a
re-sweep of the population); the citation check stops requiring slug-only blocks
or stops resolving slugs against the artifact path; the starter's three
kind→path templates change shape; the estate guide's incremental-rollout
instruction is replaced by a bulk sweep, or a verb begins writing annotations;
or an externally maintained artifact-to-code index appears beside the generated
catalogs — one whose staleness is not mechanically detectable, or whose keys are
artifacts rather than pinned code identities, would be exactly the alternative
this decision rejected. Note the standing blind spot: the annotation population
is pinned by nothing, so a future pass must re-sweep the tree rather than repeat
this count.

## Citations

- cite-file: .ok-planner/design/concepts.md @ sha256:66af22161c14
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-file: .ok-planner/design/decisions.md @ sha256:457a9c1af13a
- cite: .ok-planner/design/concepts/completion-report.md :: "record of one execution, never a plan document"
- cite: .ok-planner/design/decisions/inspection-registry.md :: "The judgment layer's durable state is one committed registry file in"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +43 sha256:7c2d8dc77c6b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function parseCitations(filePath, content, citations) {" +18 sha256:c8d1a51919df
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {" +56 sha256:c35ecf669164
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isPureCitationBlock(comment, citations) {" +10 sha256:146d1850d161
- cite: plugins/ok/families/ok-plumbline/test/fixtures/citation-file-unresolved/code.go :: "@concept: missing"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: mixed-pass"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "# @story: trace-corpus-to-code"
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "<!-- @story: trace-corpus-to-code -->"
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "# @story: corpus-proof"
- cite: .claude/skills/release/SKILL.md :: "<!-- @decision: built-bundle-fetched-at-pin -->"
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "// @story: edit-time-lint-enforcement"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "# @concept: integration-contract"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "# @concept: source-graph"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "<!-- @decision: two-layer-invalidation -->"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Disallowed in artifact body** (concepts / stories / decisions):" +6 sha256:34ee37902fd7
- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "### {{ANNOTATION-INTEGRITY-RULE}}" +8 sha256:901319e22fd4
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Written only by certification's change inspector, never hand-edited"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "    self-containment rule — no paths, no external-doc refs."
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +15 sha256:dcd22692a06c
- cite: .ok-planner/design/concepts/source-graph.md :: "It carries no audit content, no annotations, and nothing"
- cite-file: .ok-planner/audits/inspection.md @ sha256:17a84ac660cb
