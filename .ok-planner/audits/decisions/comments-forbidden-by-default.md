---
audit: comments-forbidden-by-default
artifact: decision:comments-forbidden-by-default
determination: satisfied
audited: 2026-07-28T23:00:00Z
artifact-hash: sha256:77fd23bd8cc5
---

# Are comments forbidden by default in the lint, with exactly three structural exemptions, zero shipped citation tags, and delete as the default action?

Refreshed again. The design artifact's hash is unchanged, and the only
stale item is again the whole-file node pin on the family binary. Every
span and anchor this audit cites inside it — the exemption loop,
`machineDirectiveViolation`, `isPureCitationBlock`, `checkCitationResolution`,
`hasDocstringOptIn`, `isJsDocStyle`, `loadConfig`, `starterCmd`,
`suggestForViolation` — still hashes to the pinned value; none moved. The
edits since the last pass are the `types_or:`/ratchet-hook rewrite of the
`pre-commit` CI template (a second, `always_run: true` hook,
`plumbline-budget`, guarded on the same baseline-file existence test) and
the two worked examples added under `explain` for `comment-hygiene` and
`citation-unresolved` — both inside `CI_TEMPLATES`/`EXPLAIN_TOPICS`
territory, outside every exemption path this decision's claims rest on;
`decision:ratchet-over-soft-start`'s own re-audit covers the pre-commit
template's substance. Citation regenerated; nothing else touched.

Refreshed. The design artifact's hash is unchanged, no note is open, and the
only stale item was the whole-file node pin on the family binary; every
cited span and anchor inside it (the exemption loop, the directive table,
the docstring gate, the citation checks, `loadConfig`, `starterCmd`,
`suggestForViolation`) held its pinned hash. This cycle's further edits to
the file — a `types_or:`/ratchet-hook rewrite of the pre-commit CI template
and two new worked examples under `explain` — sit in `parseCitations`'
CI-template and topic-listing territory, outside every exemption path this
decision's claims rest on. Citation regenerated; nothing else touched.

Amended, not rewritten (second re-audit in a row). The design artifact's
hash is unchanged. This cycle's edit to the family binary is unrelated to
comment hygiene in substance but touches two of this audit's pinned spans
directly: `checkCommentHygiene` and `checkCitationResolution` each had their
violation's `code:` field changed from an inline string literal
(`'comment-hygiene'`, `'citation-unresolved'`) to a named module-level
constant (`CODE_COMMENT_HYGIENE`, `CODE_CITATION_UNRESOLVED`) declared to the
identical string value — read directly at both declaration and every call
site. The exemption logic itself (the four `continue`s, the directive table,
the citation-block test, the docstring gate) is untouched byte-for-byte
around that one-line change in each function; the refactor exists to support
the *unrelated* new `explain` verb, which now derives its check-code listing
from `CHECK_CODES = [CODE_COMMENT_HYGIENE, CODE_CITATION_UNRESOLVED]` rather
than hand-duplicating the strings — territory `decision:comments-forbidden-by-default`
does not speak to. The rest of the file's changes this cycle (the retired
`slug` verb, the new `explain`/CI-template features) touch neither pinned
span nor the whole-file population this audit reads clause 2's exemption
count from, which was re-counted off the loop body as it now stands and is
still exactly three. The determination stands; only the two touched claims
below and their citations were re-verified and re-pinned.

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

That is three exemptions, re-counted off the loop body as it now stands. No
environment variable, CLI argument, config key, or subcommand adds a fourth:
`loadConfig` returns only `citations`, `ignore`, and a boolean recording the
presence of a retired key, and this cycle's new `module-marker` subcommand
writes a fixed literal to stdout and exits — it never reaches the lint at all.
This cycle's own edit inside the loop body itself is a rename, not a new
path: `checkCommentHygiene`'s violation object now reads
`code: CODE_COMMENT_HYGIENE` where it read the inline string
`'comment-hygiene'`, with the constant declared to the identical value and
read at its one call site — no branch added, no exemption test touched. The
`ignore` list and the
`grammarFor` filter (`if (!grammar) continue` in the driver) exclude *files*
from being read at all; they are scope, not per-comment permission, and a file
inside scope gets no softer treatment for any reason. Honored.

**Choice clause 2a — "machine directives (tooling syntax such as license
headers, suppressions, build tags, shebangs)."** The directive table is a fixed
map of anchored regexes covering Go build tags and nolint, generated-file
headers, SPDX / copyright / dual-licensed / licensed-under openers, Python
type-ignore / noqa / pylint, shellcheck, C pragmas, the
eslint/tslint/biome/prettier/deno/ts suppression families, eslint globals,
TypeScript triple-slash references, shebangs, the family's own `@plumbline:`
marker, and the suite's materialization stamp — twenty-four entries counted off
the table itself this cycle, correcting the prior audit's count of twenty-three;
the table is byte-identical to the version that audit read, so the correction is
an enumeration error of that audit's, not a change in the code. Continuation
lines are admitted only after a license opener, from a second fixed list of six.
Each is matched by shape
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
comment earns its place. Re-verified this cycle after `checkCitationResolution`
went stale: the change is the same rename as clause 2a's, `code:
'citation-unresolved'` becoming `code: CODE_CITATION_UNRESOLVED` at both of
the function's two violation sites, constant declared to the unchanged
string — the file-template and glob resolution logic itself is untouched.
Honored.

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
suggestion. The artifact is unchanged from the last audit; this cycle's
staleness came from a violation-code refactor touching both
`checkCommentHygiene` and `checkCitationResolution` directly — an inline
string literal replaced by a named constant of the identical value, done to
support the new `explain` verb's check-code listing — which adds no skip
path, no config key, and changes no exemption test's behavior. Three
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

- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:5ae82d9e7276
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MACHINE_DIRECTIVE_PATTERNS = {"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCommentHygiene(filePath, content, grammar, config) {" +27 sha256:ade7bb7854cb
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    violations.push(...checkCommentHygiene(file, content, grammar, config));"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function machineDirectiveViolation(comment) {" +12 sha256:9d12538b6503
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isPureCitationBlock(comment, citations) {" +10 sha256:146d1850d161
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {" +56 sha256:c35ecf669164
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const DOCSTRING_OPT_IN_MARKER = '@plumbline:allow-docstrings';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function hasDocstringOptIn(content) {" +3 sha256:bbcaf74cbd61
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isJsDocStyle(comment, allLines, grammar) {" +9 sha256:ce7ce06bfbdb
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +43 sha256:7c2d8dc77c6b
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function suggestForViolation(v, fileCache) {" +29 sha256:7c7352054874
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-cheatsheet.md :: "- **Do not write comments.** Default to zero."
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-cheatsheet.md :: "- Everything else is residue. The default action for any other comment — yours or pre-existing — is **delete**."
