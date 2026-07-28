---
audit: comments-forbidden-by-default
artifact: decision:comments-forbidden-by-default
determination: satisfied
audited: 2026-07-28T00:35:18Z
artifact-hash: sha256:77fd23bd8cc5
---

# Are comments forbidden by default in the lint, with exactly three structural exemptions, zero shipped citation tags, and delete as the default action?

## Claims

**What changed this cycle, and what it obliges.** The repair rewrote one
Alternatives bullet and left the Rationale's remaining sentence intact: the
curated-tag-vocabulary alternative is now rejected on a standing structural
ground ("every classification boundary is a judgment call, and a judgment seam
is what agents route around rather than submit to") rather than on the
methodology's own history. The Choice section is byte-identical to the version
audited last cycle, so no normative obligation was added, removed, or reshaped;
the new bullet asserts nothing about the implementation that the Rationale's
"only structural exemptions leave no judgment seam" did not already assert.
Every claim below was nevertheless re-derived from the tree, not carried over.

**Title + Choice clause 1 — "Under the lint methodology, comments are not
permitted in source files by default."** The hygiene check walks every comment
the file's grammar admits and, for each, files a violation unless one of the
exemption tests returns. There is no permit-list and no per-comment
justification path: a comment matching nothing is a violation with no further
test. Exhibited rather than read — a fresh git repo containing `a.py` with the
single comment `# c` produced
`plumbline/comment-hygiene: comment is not permitted (not a machine directive,
not a configured citation, no docstring opt-in)` and exit 2 with no config
present. The materialized rules layer states the same rule normatively ("Do not
write comments. Default to zero."). Honored.

**Choice clause 2 (quantified) — "Exactly three structural exemptions exist."**
The population is every path in the hygiene loop that can skip a comment,
enumerated from the loop body read directly and cross-checked against the whole
binary (pinned below) for any second decision point. The loop has four
`continue`s:

1. `if (!first) continue` — a comment with no significant line. A no-op, not an
   exemption: there is nothing to permit.
2. `machineDirectiveViolation(c) === null` — the machine-directive exemption.
3. `isPureCitationBlock(c, config.citations)` — the citation exemption.
4. the docstring pair (`isJsDocStyle` / `isGoDocStyle`), reachable only inside
   `if (docstringsAllowed)`, which is `content.includes(DOCSTRING_OPT_IN_MARKER)`
   — one exemption behind one gate.

That is three exemptions. No environment variable, CLI argument, or config key
adds a fourth: `loadConfig` returns only `citations`, `ignore`, and a boolean
recording the presence of a retired key. The `ignore` list and the
`grammarFor` filter (`if (!grammar) continue` in the driver) exclude *files*
from being read at all; they are scope, not per-comment permission, and a file
inside scope gets no softer treatment for any reason. Honored.

**Choice clause 2a — "machine directives (tooling syntax such as license
headers, suppressions, build tags, shebangs)."** The directive table is a fixed
map of 23 anchored regexes covering Go build tags and nolint, generated-file
headers, SPDX / copyright / dual-licensed / licensed-under openers, Python
type-ignore / noqa / pylint, shellcheck, C pragmas, the
eslint/tslint/biome/prettier/deno/ts suppression families, eslint globals,
TypeScript triple-slash references, shebangs, the family's own `@plumbline:`
marker, and the suite's materialization stamp. Continuation lines are admitted
only after a license opener, from a second fixed list. Each is matched by shape
against the comment's first significant line; nothing asks whether a comment
"is documentation". Honored.

**Adversarial finding recorded against 2a — three patterns are looser than
their tooling syntax.** Probed with a fixture rather than by reading:
`// global state is shared across requests`, `// pragma about nothing`, and
`// Materialized by nothing v1 — not really` are all admitted, because
`eslintGlobals` is `/^\s*global\s/`, `cPragma` is `/^\s*pragma\s/`, and
`materializedStamp` is `/^\s*(?:Materialized|Vendored) by\s+\S+\s+v/`. Prose
that happens to open on one of those words is exempted with no tooling need.
This is a soundness gap in the machine-directive *shape test*, and I weighed it
as a candidate violation. It does not flip the determination, for two reasons
that are both about what the Choice actually commits to. First, it introduces
no fourth exemption and no new kind: the escaping comment is admitted by the
machine-directive test, under the exemption the Choice names. Second, and
decisively, tightening it is precisely the move the decision forbids — deciding
whether `// global state is shared` "is really an eslint globals directive" is
a classification boundary, i.e. the judgment seam the repaired Alternatives
bullet rejects by name. A mechanical shape test buys zero judgment seams at the
price of some false negatives; this decision explicitly makes that trade.
Honored, with the imprecision on the record.

**Choice clause 2b — "project-declared citation tags whose slugs resolve
structurally."** `isPureCitationBlock` requires *every* significant line of the
block to satisfy `isCleanCitationLine`: the line must start with a declared tag
and the remainder must match `/^\s+[a-z0-9][a-z0-9-]*\s*$/` — a bare kebab-case
slug and nothing else. An em-dash tail, continuation prose, or trailing
punctuation fails the whole block, and the failure produces the
citation-specific message rather than the generic one. Resolution is enforced
separately in `checkCitationResolution`: a `file_template` slug must substitute
into an existing path, an `appears_in_glob` slug must match on a word boundary
in some file matching the glob. Both are mechanical; neither weighs whether the
comment earns its place. Honored.

**Choice clause 2c — "documentation comments in files carrying an explicit
opt-in marker."** `hasDocstringOptIn` is a literal substring test for
`@plumbline:allow-docstrings` in the file's own content; without it,
JSDoc- and GoDoc-shaped comments are ordinary violations. The two shape tests
behind the gate are deterministic — grammar membership, block/line kind,
first-significant-line shape, and the adjacent declaration matched against
fixed pattern lists. The gate is a marker's presence, which is structural. The
family's fixtures pin both sides of the gate and run green on this tree.
Honored.

**Choice clause 3 (quantified) — "The methodology ships zero default citation
tags; projects declare their own."** `loadConfig` initializes `const citations
= []` and appends only entries the project's own `citations` array declares;
there is no default table anywhere in the binary. The asymmetry is deliberate
and visible in the same function — `ignore` *does* start from
`DEFAULT_IGNORE_PATTERNS`. Consequently `checkCitationResolution` returns
immediately on an empty citation list, and with no config the citation
exemption can never fire, which is exactly what the clause-1 exhibit above
showed. Re-confirmed live this cycle in both directions: `starter` run against
a bare repo emitted `"citations": []`; run against the same repo after
`mkdir -p .ok-planner/design/decisions` it emitted the three design tags — so
even the one place tags originate is conditioned on a detected planner estate,
and the verb prints the config for the owner rather than writing it. Honored.

**Choice clause 4 — "Everything else is residue whose default action is delete,
including in code you didn't write."** `suggestForViolation`'s fallback for a
comment-hygiene violation matching no heuristic is `action: 'delete the
comment'` with the reason given as the methodology's default; exhibited on the
clause-1 fixture, which printed `suggestion: delete the comment`. The
materialized rules layer states the authorship-neutral form directly — the
default action for any other comment, yours or pre-existing, is delete — and
the check is authorship-blind: it reads file contents and never consults blame
or history. Honored.

**Rationale — "Comments are generation residue and a drift hazard … only
structural exemptions leave no judgment seam, converting the convention into a
mechanical check."** The capability claimed is that no exemption requires a
human or agent judgment call. Each of the three reduces to a pattern match, a
marker's presence, or a filesystem / word-boundary lookup. The one config key
that could once have softened a check is honored nowhere and survives only as a
recorded boolean that diagnose surfaces as a warning to remove. Honored.

## Determination

**satisfied.** The check forbids by default and admits exactly three
exemptions, each decided mechanically: a fixed machine-directive pattern table,
project-declared citation tags whose blocks must be slug-only and whose slugs
must resolve, and docstrings gated on an explicit file-level marker. No default
citation tag ships, so a project with no config gets pure prohibition —
exhibited this cycle from a fresh repo, along with the delete-by-default
suggestion. The Choice text is unchanged from the last audit; the repaired
Alternatives bullet restates the rejection of a curated tag vocabulary on
structural rather than historical grounds and adds no obligation. Three
directive patterns are broader than the tooling syntax they exist for and will
exempt prose that opens on `global `, `pragma `, or a materialization stamp —
recorded above as a precision gap that the decision's own no-judgment-seam
trade accepts rather than as a breach of it. Decisions carry no proof
obligation; the family's fixtures nevertheless pin both sides of each exemption
and the suite run is green.

This stops holding if: a fourth skip path is added to the hygiene loop (the
whole-file pin catches any edit to the binary); the citation exemption is
loosened to admit a block mixing a tag line with prose; the docstring exemption
stops requiring the marker; a default citation entry is added to the config
reader; the suggestion fallback stops defaulting to delete; or the
machine-directive table gains a test that asks about a comment's meaning rather
than its shape — which would be the judgment seam the decision exists to
refuse, and unlike the over-breadth above would be a genuine breach.

## Citations

- cite-file: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:4f181feaed30
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCommentHygiene(filePath, content, grammar, config) {" +27 sha256:6bf8cc494b10
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    violations.push(...checkCommentHygiene(file, content, grammar, config));"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function machineDirectiveViolation(comment) {" +12 sha256:9d12538b6503
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isPureCitationBlock(comment, citations) {" +10 sha256:146d1850d161
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {" +56 sha256:1660625ac24f
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const DOCSTRING_OPT_IN_MARKER = '@plumbline:allow-docstrings';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function hasDocstringOptIn(content) {" +3 sha256:bbcaf74cbd61
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isJsDocStyle(comment, allLines, grammar) {" +9 sha256:ce7ce06bfbdb
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +43 sha256:7c2d8dc77c6b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function suggestForViolation(v, fileCache) {" +29 sha256:7c7352054874
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-cheatsheet.md :: "- **Do not write comments.** Default to zero."
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-cheatsheet.md :: "- Everything else is residue. The default action for any other comment — yours or pre-existing — is **delete**."
