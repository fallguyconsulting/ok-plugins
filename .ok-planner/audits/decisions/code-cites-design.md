---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:2478a5f439ea
---

# Is reference between code and corpus fixed one-way — kind-plus-slug annotations in code, self-contained bodies in the corpus — with rollout incremental and no bulk pass?

Amended, not rewritten. The design artifact's hash is unchanged. Three
citations went stale this cycle: both catalog population pins (seven new
artifacts added — three stories, four decisions) and the `checkCitationResolution`
span in the plumbline binary, which turns out to be a pure rename
(`code: 'citation-unresolved'` → `code: CODE_CITATION_UNRESOLVED`, same
string value, done in service of the new unrelated `explain` verb) rather
than a change to the resolution logic clause 2 rests on. Clause 3's enlarged
population was swept whole rather than assumed clean.

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
check then fails any slug whose substituted path does not exist.

Re-derived from reality this cycle rather than carried. Enumerating every
annotation in the tracked tree yields 53 distinct kind-plus-slug pairs, and each
resolves to a live artifact of the matching kind except for the same class of
exceptions the previous cycle traced, which I re-traced individually:
`@concept: cascade`, `@story: parker` and `@concept: claim-holder-guard` are
illustrative slugs inside the lint's own help text, style guide, and cheatsheet;
`@concept: foo` and `@concept: missing` are the two lint fixtures that exist to
exercise the resolved and unresolved cases; `@story: alpha` and `@story: beta`
are strings the planner's proof harness writes into throwaway fixture files.
Three further apparent misses turned up in the sweep and are not code sites at
all: `@decision: append-only-issue-queue` appears only inside an archived sprint
record describing the sweep that removed it, `@concept: front-door` only inside
an archived issue file proposing a slug that was never written, and the string
matching `@decision: annotation` is the prose heading "the @concept: / @story: /
@decision: annotation convention" in the point-in-time discovery scaffold. No
live code site claims a design artifact that does not exist. The sprint under
certification supplies fresh instances of the convention working as stated: the
new source-graph extractor carries `@concept: source-graph` at its head, and the
shared certification core carries `@decision: two-layer-invalidation` and
`@decision: recorded-adjudication` at the block that states the trigger — both
placed by the session that consulted those artifacts, at the site where the
commitment is expressed. This cycle's own work supplies eight more fresh
instances, checked directly rather than assumed from the sweep above: the new
`corpus-view` script carries `@story: trace-corpus-to-code`,
`@decision: local-web-surface` and `@decision: resolution-through-pinned-checker`;
`browse/SKILL.md` carries the first two of those same three; the new
`proof-timings` recorder and all six test harnesses this cycle instrumented
carry `@story: corpus-proof` / `@decision: measure-first-verification-cost`
at their timing-emission code; the plumbline binary carries
`@story: explain-lint-rules` and `@story: pipeline-check-wiring` at the
verbs those stories describe; and the release skill carries
`@decision: built-bundle-fetched-at-pin` at its new build step. Every one of
these resolves to a live artifact of the matching kind. Honored.

**Choice clause 3 (quantified) — "corpus bodies are self-contained — no file
paths, no symbol citations, no quoted code, with slugs and invariant IDs the
only sanctioned citation forms."** The population is every live artifact in the
three catalogs, re-enumerated this cycle from the generated tables of contents
and reconciled against the files on disk: 27 concepts, 20 stories, 26
decisions — 73, up seven from the previous cycle (no new concept, three new
stories — `explain-lint-rules`, `pipeline-check-wiring`, `trace-corpus-to-code`
— and four new decisions — `built-bundle-fetched-at-pin`, `local-web-surface`,
`measure-first-verification-cost`, `resolution-through-pinned-checker`), with
the catalog slug sets equal to the on-disk basename sets in each of the
three, not merely equal in count. All three catalogs are pinned below, so the
next catalog change forces this population to be re-enumerated.

Sweeping all 73 bodies for the disallowed forms returns nothing: no
extension-bearing filename, no directory path, no backticked path fragment, no
URL, no fenced code block, no `code:`/`pkg:` citation form, no external-doc
reference, and no `@concept:`/`@story:`/`@decision:` tag (design does not cite
code even in the annotation's own vocabulary). The single lexical hit across the
whole corpus is the word "code" followed by a colon in ordinary prose in one
concept body — the same non-citation the previous cycle recorded. The canonical
rule that defines the prohibited forms is transcluded into the design-doc
compliance reviewer, which runs over the corpus as a certification pass, so the
property is checked and not merely asserted.

The seven artifacts new this cycle were read individually against the rule
rather than trusted to the sweep, since they are the members most likely to
have descended: `explain-lint-rules` and `pipeline-check-wiring` describe
what a reader receives ("the canonical definition and examples," "ready-to-use
configuration") without naming the binary or its topic table;
`trace-corpus-to-code` names "the project's corpus view" and "the project's
own materialized audit checker" as capabilities, not paths; `local-web-surface`
names "a page served over loopback by a program the project runs" without a
script path; `built-bundle-fetched-at-pin` and `resolution-through-pinned-checker`
each describe a mechanism (build-once-per-release placement; calling "the
project's own materialized audit checker") without naming the converge core
or the corpus-view script by path; `measure-first-verification-cost` names a
discipline, not an implementation. None of the seven names a file, a symbol,
or quotes code. Honored.

**Choice clause 4 — "Rollout is incremental: whoever consults an artifact while
working on a file leaves the annotation; there is no bulk pass."** The
instruction is materialized into every consumer's estate guide as a standing
session rule — leave the annotation at the most-specific load-bearing site, kind
plus slug only, never a file path or line number or quotation — and explicitly
disclaims a bulk pass. The instruction was extended this cycle (which is why its
span hash moved) with a clause bounding what annotations are *for*: navigation
and proof registration only, playing no part in certification scope or audit
invalidation. That narrows the annotation's job without touching this decision's
claim, which was never about invalidation; and it removes the one mechanism that
could have created pressure for a bulk pass, since nothing now depends on
annotation completeness. Correspondingly, no verb in any family sweeps the tree
adding annotations: the corpus audit's annotation pass reports dangling and
kind-mismatched annotations and fixes nothing, no converge core writes an
annotation, and the new source-graph extractor reads declared structure, not
tags. The absence is the claim, and the absence holds. Honored.

**Rationale — "Durability under motion: a refactor that moves files cannot
invalidate the design, and a doc that moves repos cannot orphan an artifact."**
The capability follows from clause 3 as implemented: since no body names a path,
there is nothing in a body a file move can invalidate. The converse direction is
protected too — an annotation is checked by slug against the artifact's
basename, so moving the code file does not break the link. Honored.

**Rationale — "The annotation grep replaces an external index."** Honored. The
annotations are greppable by a fixed two-token form, and the estate holds no
artifact-to-code index file: the only things beside the three generated catalogs
under `design/` are the catalogs' own artifact directories and the point-in-time
discovery scaffold, none of which maps artifacts to code sites.

Two candidate refutations were tested this cycle rather than waved through,
because the sprint added machinery that maps things to code. The **source graph**
under the estate is code-about-code — nodes and hashes over the source tree,
carrying by its own concept's boundary "no audit content, no annotations, and
nothing hand-written" — so it indexes sources, not artifacts. The **audit
corpus** does associate an artifact with code sites through its Citations block,
and read uncharitably that is an artifact-to-code mapping. It is not the thing
the Alternatives rejected: that alternative's stated cost was "a second source of
truth that drifts from both", and an audit's citations cannot drift silently —
a moved hash or a broken anchor is a mechanical staleness finding that forces the
audit to be re-derived. An audit is a verification record whose citations rot
loudly by design, not a navigation index maintained in parallel. Neither refutes
the clause.

**Rationale — "a code path diverging from a stated boundary becomes a defect
rather than an ambiguity."** The mechanism that converts divergence into a
defect is the annotation-integrity rule plus the lint's resolution check: a slug
that no longer resolves is a lint violation at the code site, and a
kind-mismatched annotation is a reported finding with a determined fix. Honored.

## Determination

**satisfied.** The one-way direction is enforced from both ends. Code-side, the
lint admits only slug-only citation blocks and fails any slug that does not
resolve to its kind's artifact file, and every annotation in this tree resolves
except for illustrative and fixture slugs I enumerated individually — including
three apparent misses I traced to archived records and prose rather than to code
— corroborated further by eight fresh annotation sites this cycle's own work
added, every one resolving. Corpus-side, all 73 live artifacts — enumerated
from the three generated catalogs, whose slug sets match the files on disk
exactly — carry no path, symbol, quoted code, URL, or external-doc citation,
with the seven artifacts new this cycle read individually rather than swept, and
the rule that forbids them is transcluded into the reviewer that audits the
corpus. Rollout is left to the sessions that consult an artifact, stated in the
materialized estate guide, and no verb performs a bulk annotation pass.
Decisions carry no proof obligation.

Amended, not carried whole: this audit went stale because both catalog pins
moved (seven artifacts added — three stories, four decisions) and one cited
span in the plumbline binary changed. Both were checked against the claim
directly. The enlarged population was swept whole and its new members read
individually, each self-contained; the plumbline change is a bare rename
(`code: 'citation-unresolved'` → `code: CODE_CITATION_UNRESOLVED`, same
string value) that touches neither the resolution logic nor the citation
mechanism this clause depends on. Nothing about the decision moved.

This stops holding if: an artifact body acquires a path, symbol, quoted code, or
external-doc citation (the catalog pins break on any catalog change, forcing a
re-sweep of the population); the citation check stops requiring slug-only blocks
or stops resolving slugs against the artifact path; the starter's three
kind→path templates change shape; the estate guide's incremental-rollout
instruction is replaced by a bulk sweep, or a verb begins writing annotations;
or an externally maintained artifact-to-code index appears beside the generated
catalogs — one whose staleness is not mechanically detectable would be exactly
the alternative this decision rejected.

## Citations

- cite-file: .ok-planner/design/concepts.md @ sha256:e39bc5355eed
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-file: .ok-planner/design/decisions.md @ sha256:3df0ebb2f798
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +43 sha256:7c2d8dc77c6b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function parseCitations(filePath, content, citations) {" +18 sha256:c8d1a51919df
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {" +56 sha256:c35ecf669164
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "# @story: trace-corpus-to-code"
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "<!-- @story: trace-corpus-to-code -->"
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "# @story: corpus-proof"
- cite: .claude/skills/release/SKILL.md :: "<!-- @decision: built-bundle-fetched-at-pin -->"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isPureCitationBlock(comment, citations) {" +10 sha256:146d1850d161
- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Disallowed in artifact body** (concepts / stories / decisions):" +6 sha256:34ee37902fd7
- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "### {{ANNOTATION-INTEGRITY-RULE}}" +8 sha256:901319e22fd4
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "    self-containment rule — no paths, no external-doc refs."
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "**Leave the annotation.** Annotation rollout is incremental and it is" +15 sha256:dcd22692a06c
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "// @story: edit-time-lint-enforcement"
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "# @concept: integration-contract"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "# @concept: source-graph"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "<!-- @decision: two-layer-invalidation -->"
- cite: .ok-planner/design/concepts/source-graph.md :: "It carries no audit content, no annotations, and nothing"
