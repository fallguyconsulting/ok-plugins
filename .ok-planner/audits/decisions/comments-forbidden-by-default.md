---
audit: comments-forbidden-by-default
artifact: decision:comments-forbidden-by-default
determination: satisfied
audited: 2026-07-27T13:00:38Z
artifact-hash: sha256:882d61ab71b9
---

# Are comments forbidden by default in the lint, with exactly three structural exemptions and zero shipped citation tags?

## Claims

**1. Title — "Comments are forbidden by default, with structural exemptions
only."** Two assertions: the default disposition is forbid, and every escape is
structural (decidable by pattern, not by taste). Both are carried by the
per-comment loop below; neither exemption path consults a judgment-call
vocabulary of "good" comment kinds. Honored.

**2. Choice — "comments are not permitted in source files by default."** The
hygiene check tokenizes a file into comments (a per-language extractor that
tracks strings, block comments, JS regex literals, and shell quoting/heredocs,
so a `#` or `//` inside data is not mistaken for a comment) and then, for each
extracted comment, *collects a violation unless one of the escapes fires*.
There is no allowlist consulted, no severity, no opt-out: the fall-through at
the bottom of the loop is `violations.push(...)`. Verified live in a scratch
project — a lone `# stray note` above `x = 1` yields
`plumbline/comment-hygiene: comment is not permitted`, exit 2. Honored.
`cite-span: … "function checkCommentHygiene(filePath, content, grammar, config) {" +27`.

**3. Choice — "Exactly three structural exemptions exist."** Quantifier. I
enumerated the population from reality, not from the Choice: the escapes are
exactly the `continue` statements inside the per-comment loop, and that loop is
wholly contained in the cited span (so the span is also the population pin).
There are four `continue`s: (a) `if (!first) continue` — a comment whose
significant-line set is empty, i.e. no content to judge, not an exemption for
content; (b) `machineDirectiveViolation(c) === null` — exemption one;
(c) `isPureCitationBlock(c, config.citations)` — exemption two; (d) the
`isJsDocStyle` / `isGoDocStyle` pair, reachable only when
`docstringsAllowed` — exemption three. No other path out of the loop exists.
Three content exemptions. Honored.
`cite-span: … "function checkCommentHygiene(filePath, content, grammar, config) {" +27`.

**4. Choice — exemption one, "machine directives (tooling syntax such as
license headers, suppressions, build tags, shebangs)."** The registry is a
closed table of 24 named regexes matched against a comment's significant lines,
and the exemption is decided **per line**: the block is exempt only if line one
is a directive *and* every subsequent significant line is itself a directive,
or — when line one opens a license header — matches the separate
license-continuation table. A prose tail appended under a directive is
therefore reported at the offending line, not swallowed. The four kinds the
Choice names are all present (`spdxLicenseLine` / `copyrightLine` /
`licensedUnderLine` / `dualLicensedLine`; `eslintSuppression` /
`tsSuppression` / `pythonNoqa` / `pylintSuppression` /
`shellcheckSuppression` / `golangciSuppression` / `tslintSuppression` /
`biomeSuppression` / `prettierSuppression` / `denoSuppression`;
`goDirective`; `shebang`). Every entry is tooling syntax some tool reads —
including `materializedStamp` and `plumblineDirective`, which are
machine-written markers, not prose. Honored.
`cite-span: … "const MACHINE_DIRECTIVE_PATTERNS = {" +26`,
`cite-span: … "function machineDirectiveViolation(comment) {" +12`.

**5. Choice — exemption two, "project-declared citation tags whose slugs
resolve structurally."** Two halves, both mechanical. Form: a block is exempt
only if *every* significant line is `<tag><whitespace><kebab-slug>` and nothing
else — the slug regex `^\s+[a-z0-9][a-z0-9-]*\s*$` admits no em-dash tail, no
continuation prose, no trailing punctuation, so one prose line fails the whole
block. Resolution: the second check substitutes each parsed slug into the
declared `file_template` (path must exist) or greps the declared
`appears_in_glob` population, and reports `citation-unresolved` otherwise.
Both checks run on every lint invocation from the same driver, and the
fixture pairs `citation-file-{resolved,unresolved}` and
`citation-glob-{resolved,unresolved}` exercise both directions. Honored.
`cite-span: … "function isPureCitationBlock(comment, citations) {" +10`,
`cite-span: … "function runLint(target) {" +18`.

**6. Choice — exemption three, "documentation comments in files carrying an
explicit opt-in marker."** The marker is the literal
`@plumbline:allow-docstrings`; without it in the file's text the JSDoc/GoDoc
branches are unreachable. With it, the exemption is still structural: the
comment must be block-shaped (JS/TS) or adjacent-line-shaped (Go) *and* the
next non-comment line must match a declaration pattern — a docstring floating
away from a declaration is not exempt even in an opted-in file. The fixture
pair `docstring-opted-in` (exit 0) / `docstring-not-opted-in` (exit 2)
exercises the gate in both directions. Honored.
`cite: … "const DOCSTRING_OPT_IN_MARKER = '@plumbline:allow-docstrings';"`,
`cite-span: … "function hasDocstringOptIn(content) {" +3`.

**7. Choice — "The methodology ships zero default citation tags; projects
declare their own."** Quantifier over the shipped default set; the population
source is the config loader, the only producer of the citations array. It
initialises `const citations = []` and appends only entries the user's config
declares, each validated (non-empty `tag`, exactly one of `file_template` /
`appears_in_glob`, `{slug}` literal required). Nothing seeds a default. The
starter verb *proposes* the three ok-planner tags when it detects
`.ok-planner/`, but it prints JSON to stdout and writes nothing — confirmed by
running it in a scratch project with `.ok-planner/`, `go.mod` and
`package.json` present: the proposal appeared on stdout, the directory listing
was unchanged. Honored.
`cite-span: … "function loadConfig(repoRoot) {" +26`,
`cite-span: … "function starterCmd(target) {" +44`.

**8. Choice — "Everything else is residue whose default action is delete,
including in code you didn't write."** The disposition is stated identically in
the two places it has to be — the tool's own remediation output (the
fall-through suggestion when no heuristic matches is literally "delete the
comment", justified as the default under the methodology) and the methodology's
rulebook, whose manifesto and style guide both say delete on sight *including
in code you didn't write*. No authorship test exists anywhere in the walker or
the check; every file with a known grammar is treated identically. Honored.
`cite: … bin/plumbline "      why: 'no recognized shape; …'"`,
`cite: … docs/plumbline-manifesto.md "- **Everything else is residue.** …"`,
`cite: … docs/plumbline-style-guide.md "Any comment that doesn't fit …"`.

**9. Rationale capability claim — "converting the convention into a mechanical
check."** The check is executable and self-applied: the family's own tree is
linted by the family's own binary as the *first* assertion in its harness, and
it passes (`ok: the family's own tree is clean under its own lint`). A
methodology that could not be run against itself would be discipline, not a
check. Honored.
`cite-span: … test/run.sh "run_self_lint_gate() {" +12`.

## Determination

**satisfied.** Every normative sentence of the Choice is realized in the
hygiene check as written: violation is the fall-through, the escapes are
exactly three and each is decided by pattern rather than by reading the
comment's meaning, the citations array ships empty, and the delete-by-default
disposition is stated in the tool's own remediation text and in the
methodology's rulebook without an authorship carve-out.

Two boundaries a reader should hold honestly, neither of which contradicts the
Choice. First, "source files" is scoped by the grammar table: a file whose
extension is absent from that table (and whose shebang matches no known
interpreter) is walked past unchecked. That is a language-coverage limit, not a
permissive default — nothing in the check *allows* a comment there; some files
are simply outside the lint's reach. Second, the `plumblineDirective` and
`materializedStamp` entries in the directive registry are the methodology's own
machine markers rather than a third party's tooling syntax; they remain
structural (regex-decided, not judgment-decided), which is what the Choice's
"structural exemptions only" actually forbids.

This stops holding if: a fourth `continue` appears in the per-comment loop, or
any existing one is widened to admit content by shape-of-prose rather than by
pattern; `machineDirectiveViolation` reverts to judging only the first line, so
a prose tail rides in under a directive; the pure-citation slug regex is
loosened to permit anything after the slug; the docstring branches become
reachable without the marker; `loadConfig` seeds a non-empty default citations
array (or `starterCmd` gains a write path); or the delete-by-default statement
is softened in the manifesto/style guide or in the tool's fallback suggestion.

## Citations

- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCommentHygiene(filePath, content, grammar, config) {" +27 sha256:6bf8cc494b10
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "const MACHINE_DIRECTIVE_PATTERNS = {" +26 sha256:cc985cf7cec1
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function machineDirectiveViolation(comment) {" +12 sha256:9d12538b6503
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function isPureCitationBlock(comment, citations) {" +10 sha256:146d1850d161
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function hasDocstringOptIn(content) {" +3 sha256:bbcaf74cbd61
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const DOCSTRING_OPT_IN_MARKER = '@plumbline:allow-docstrings';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function loadConfig(repoRoot) {" +26 sha256:32307f1ddbbc
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function starterCmd(target) {" +44 sha256:bf6272e67732
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function runLint(target) {" +18 sha256:5d204f7417f4
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "      why: 'no recognized shape; the default action under plumbline is to delete (comments are not permitted unless they are a machine directive, a configured citation, or a docstring in an opt-in file)',"
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-manifesto.md :: "- **Everything else is residue.** The default action is delete, including in code you didn't write — it will be regenerated as precedent otherwise."
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-style-guide.md :: "Any comment that doesn't fit the three exemptions is residue. Delete on sight — including in code you didn't write (it will be regenerated as precedent otherwise)."
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_self_lint_gate() {" +12 sha256:4e21a84e1aa5
