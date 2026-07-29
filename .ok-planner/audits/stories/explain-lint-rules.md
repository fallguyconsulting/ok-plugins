---
audit: explain-lint-rules
artifact: story:explain-lint-rules
determination: violated
audited: 2026-07-29T02:00:00Z
artifact-hash: sha256:9c0c426f05f6
---

# Does a reader asking about a check code or a configuration topic receive that rule's canonical definition *and worked examples*, and does the proof confirm the explanation's stated behavior?

Fifth re-audit. The design artifact's hash has not moved, so the prior reasoning is
precedent; the bytes the surviving claim rested on have changed, so this is a whole
rewrite. The lint binary is **byte-identical** to the copy the previous four passes
read — its whole-file node hash is unchanged — so `EXPLAIN_TOPICS` and every word of
explanation prose are confirmed untouched by the last fix. All of it was nevertheless
rebuilt from scratch this pass in fresh `git init` repositories, and every result
reproduced.

**The explanation half is discharged and stays discharged, on execution and not on
report.** Every documented trigger and every stated fix in the whole topic table was
rebuilt verbatim in a fresh repository this pass. All three triggers reproduce their
documented lines byte for byte after the path. All nine stated fixes clear at exit 0 —
`comment-hygiene`'s four (the renamed function with the comment deleted, the SPDX
directive, the declared citation, the opt-in marker plus JSDoc block, the last with its
necessity confirmed by negative control), `file_template`'s three (correct the slug,
create the artifact, delete the citation line), and `appears_in_glob`'s two (carry the
slug verbatim into a glob-matching file, correct the slug at the code site to one
already present). The derived identifier `def test_no_negative_balances()` leaves
`appears_in_glob` firing exactly as the text says. Both `citations` entry shapes,
written verbatim, are accepted and govern their tags. The listing prints two check codes
and two configuration topics at exit 0; an unknown topic exits 1 with a pointer back to
the listing. No Falsifier disjunct fires on the explanation as it stands.

**The configuration-path defect stays discharged, and the reported-line defect — the
fourth pass's sole ground — is now genuinely discharged too.** Each of the three worked
examples' documented `the lint reports:` transcripts is read out of that example's own
block at run time and compared, whole-line and fixed-string, against what the fixture
run emits. Verified by mutation in both directions and on both sides: rewriting the
documented transcripts to contradict the lint fails the harness; rewording the lint's
own message constructors under an untouched explanation fails the harness; renaming the
`lint reports:` marker so the extraction returns empty fails the harness rather than
passing on empty-equals-empty. That work is real and must not be lost.

**The proof-coverage claim is still not discharged, on a sixth and narrower ground:
each worked example's documented *starting state* is invented by the harness rather than
read out of that example's own text, while three conjuncts assert in terms that it is
read from there.** Measured by mutation on a sandbox copy outside the repository, in
both directions.

Three quantified populations were re-enumerated from reality. The check codes the lint
can emit were read from the three violation-construction sites — one in
`checkCommentHygiene`, two in `checkCitationResolution`, the only three `code:` keys
that reach `formatViolation` — yielding two distinct codes, not from the list that
claims to cover them. The topics the verb can deliver were read from the topic table and
confirmed by running the verb with and without an argument: four. Every string in the
binary naming a config file was enumerated by grepping both spellings across the whole
file and reading each hit in place: five user-facing, all canonical.

## Claims

**Title / Story — "As someone meeting a lint violation I do not recognise, I want the
canonical definition and examples for the rule that fired, so that I can decide whether
to fix the code or change the configuration without reading the linter's source."**
Honored. The verb exists, is vendored, prefers the project's committed binary, and
delivers definition-plus-working-example prose for both codes the lint can emit. Both
decisions the "so that" clause names were exercised end to end from a cold start: every
code-side remediation the table states was executed and each one clears, and the
configuration a reader is told to write is the configuration the lint reads. Nothing in
the reader's path requires opening `configPathFor`.

**Acceptance clause 1 — "The reader asks about a check code or a configuration topic →
they receive that rule's canonical definition and worked examples."** Honored.
Population, enumerated from the topic table and confirmed by running the verb with no
argument: `comment-hygiene`, `citation-unresolved`, `citations`, and the docstring
opt-in marker — four topics, printed as two check codes and two configuration topics.

- *comment-hygiene* — definition plus a worked example naming a file, the offending
  comment, the emitted violation line, and four fixes. Rebuilt verbatim: the trigger
  reproduces its documented line byte for byte after the path, and all four fixes clear.
  Honored.
- *citation-unresolved / `file_template`* — rebuilt verbatim with the config at the path
  the example's own block states: the trigger reproduces the emitted line exactly, and
  all three stated fixes each clear. Honored.
- *citation-unresolved / `appears_in_glob`* — rebuilt verbatim: the starting state fires
  the documented line; the derived identifier the text explicitly disowns leaves the
  violation firing; both stated remediations clear it at exit 0 with the cited code site
  intact. Honored.
- *citations* and *the docstring opt-in marker* — definitions plus literal instances.
  Both `citations` entry shapes were written verbatim into a fresh repo and observed to
  govern their tags. Both topics name the canonical config path, consistent with
  `configPathFor`, `loadConfig`, `starterCmd`, `diagnoseCmd` and `validateCitation`'s
  error strings. Honored.

**Acceptance clause 2 — "drawn from the project's own committed lint so the explanation
matches the rules that project actually enforces."** Honored on the text as it stands.
The verb's script prefers the project's vendored binary and falls back to the payload
with an announced note; the topic table is a string-constants block inside that binary,
beside the check-code constants and the checking functions. The prose a project receives
is its own pinned lint's prose, and that prose agrees with the same binary's resolution,
starter, and diagnosis paths, and with the family's converge, which migrates the root
file into the canonical one. The only surviving mentions of the pre-migration root path
in the binary are three internal and one correctly labelled: `configPathFor`'s documented
fallback, `findRepoRoot`'s root detection, `diagnoseCmd`'s equality test, and
`diagnoseCmd`'s warning, which calls the root location pre-migration and names the
canonical path the front door's administration moves it to. None is a user-facing
instruction to write a file the lint ignores.

**Acceptance clause 3 — "asking without a topic lists what can be explained."** Honored
as observed, with one unguarded seam recorded below. Run with no topic the verb prints
the two check codes and then the two configuration topics as separate groups, exiting 0;
a check code lacking a definition would be printed with a no-definition marker and the
command would exit non-zero naming the count. An unknown topic exits 1 with a pointer
back to the listing. The population it must cover was re-enumerated from the three
violation-construction sites, yielding two codes, both declared in `CHECK_CODES` and
both defined. Confirmed live.

**Acceptance clause 4 — "The definitions delivered are the lint's own, not a separately
maintained restatement of them."** Honored as written, with its limit narrowed but not
closed. The definitions are string constants shipped and versioned with the checks.
Guards now keep the *configuration* half from drifting at every site, keep *coverage*
from drifting, and — new this pass — keep each example's *reported line* pinned to what
the lint constructs, in both directions. What no guard reaches is the prose stating each
example's *inputs*: the offending comment, each config entry's tag and `file_template` /
`appears_in_glob`, and the file the citation sits in. The clause denies a separately
maintained restatement rather than promising generated prose, so it stands as written;
the consequence of the remaining limit is recorded against the proof claim, where it is
measurable.

**Falsifier — "An explained rule's description contradicts what the lint enforces; a
check code the lint can emit has no explanation; the explanation is a hand-maintained
copy that drifts from the rules it describes; or the reader must read the lint's source
to learn what a code means."** **No disjunct fires on the explanation as it stands.**
Disjunct one: every worked example and every stated fix was built and run against the
committed binary in a converged repository, and nothing the topics assert was refuted —
including the three documented violation transcripts, which match byte for byte after
the path. Disjunct two: both emittable codes, enumerated from the emission sites rather
than from `CHECK_CODES`, carry definitions and worked examples. Disjunct three: the prose
is hand-maintained but does not presently disagree with the rules it describes at any
point checked. Disjunct four: following the explanation from a cold start succeeds
without opening the binary.

Two bounded observations, carried forward and re-verified as still not firing. The
`comment-hygiene` topic's parenthetical list of machine directives is under-inclusive
against `MACHINE_DIRECTIVE_PATTERNS` (which also recognises `type: ignore`, `global`,
`/ <reference`, `pragma`, `@plumbline:`, and materialization stamps); the list is framed
illustratively, and a reader misled by it writes *less* than the lint permits, never a
violation. The `citations` topic states a kebab-case slug format that nothing in
`parseCitations` enforces — its slug match is `[^\s,;]+` with trailing punctuation
stripped; the sentence describes the convention rather than claiming the lint rejects
otherwise.

**Proof — "Demo — a check code taken from a real lint run and explained; the
explanation's stated behavior confirmed by a run that triggers the rule and then
satisfies it; and the topic listing covering every check code the lint can emit."**
Conjuncts one and three are honored: the harness parses the emitted code out of a real
violation line rather than hard-coding it and explains that parsed code through the
committed binary, for both codes; and it derives the emittable-code set mechanically
from the binary's source at proof time rather than from a literal list. Conjunct two —
*the explanation's stated behavior confirmed* — is now honored for the *report* half of
each example's stated behavior and for trigger-and-clear, but not for the *stated
starting state* the report is a consequence of. See the proof-coverage claim.

**Proof coverage against the Acceptance — stated as its own claim line. Not honored.**

What changed since the last pass is substantial and was verified rather than accepted.
`example_reported_line` slices a named `Worked example` block and returns the first
non-blank line after that block's `lint reports:` marker; `lint_transcript` runs the
committed binary over the fixture and normalizes only the repo-root path prefix;
`documented_line_holds` requires both sides non-empty and an exact whole-line
fixed-string match. All three worked examples now route through them. Every one of the
prior determination's mutation-verified guards survives: the site-scoped config-path
derivations, the two-config preference fixture, the coverage checks. And the first half
of the prior determination's flip condition is met, measured on a sandbox copy (green at
baseline, green again after restore):

- Rewriting all three documented transcripts to state things the lint does not do
  fails the harness — together and each alone.
- Rewording the lint's *own* message constructors under an untouched explanation fails
  the harness: both `citation-unresolved` templates ("does not resolve to" → "has no
  artifact at"; "not found in any file matching" → "appears in no file matching"), and
  `checkCommentHygiene`'s message parenthetical.
- Renaming the `lint reports:` marker so the extraction returns empty fails the harness
  — nothing passes on empty-equals-empty.
- Renaming the example's file, in the transcript alone or in the block header and the
  transcript together, fails the harness.

The substitution nevertheless survives, in a sixth and narrower place, in the same shape
it has taken four times: a guard that reads as behavioural while checking something
adjacent. The second half of the prior determination's flip condition — *stop asserting
more than is checked in the conjuncts that observe a trigger* — was not met; the
conjuncts now assert **more** than they did before, enumerating specific example inputs
that are not read from the example at all.

- **Ground — the documented starting state is never read.** Each worked example states
  its inputs in its own text: the offending comment, the config entry's `tag` and
  `file_template` / `appears_in_glob`, and the file the citation sits in. The harness
  hard-codes all of them and then prints that the fixture was *built verbatim from its
  own text — same file, same comment, same line*, that it carries *the tag and
  file_template of its config entry, the file and citation it shows*, and that the
  *starting state, built verbatim from its own text, fires exactly as the explanation
  says it does*. Measured on a sandbox copy, every one of these leaves the **entire
  harness green**:
  - Replacing the `comment-hygiene` example's offending comment with
    `// SPDX-License-Identifier: Apache-2.0` — a machine directive the very same topic
    lists as exemption 1 — while its transcript still claims `comment-hygiene` fires.
    A reader following that example sees nothing at all. Green. (So does merely
    rewording the comment.)
  - Changing the `file_template` example's config entry to
    `"file_template": "docs/concepts/{slug}.md"` while its transcript still reports
    `does not resolve to design/concepts/casacde.md`. Green.
  - Changing the `appears_in_glob` example's config entry to
    `"appears_in_glob": "**/*_spec.py"` while its transcript still reports
    `not found in any file matching **/*_test.py`. Green.
  - Renaming the `file_template` example's tag to `@my-idea:` at both the config entry
    and the code site, transcript untouched. Green.
  - Moving the `appears_in_glob` example's citation to `src/accounts.py` in the prose,
    transcript untouched. Green.

  This is the drift the story exists to prevent, reachable by an ordinary one-line edit,
  and the conjuncts carrying it name the very inputs they do not read. The extraction
  technique is already in the harness — `example_config_path` and
  `example_reported_line` both slice a named block out of the topic — so the missing
  work is bounded and mechanical, not a research problem. The audit itself has now built
  every example's stated starting state by hand from the topic text five times.

Three further fail-open observations, recorded as characterisation rather than as
independent grounds:

- **Only the first documented transcript line is read.** `example_reported_line` prints
  the first non-blank line after the marker and exits. All three blocks are single-line
  today — verified by reading each block — so nothing is presently unchecked; but a
  second documented line added under any marker drifts undetected. Measured: appending a
  second transcript line contradicting the lint leaves the harness green.
- **The topic population can shrink silently.** `topic_listing` reads the topic set from
  the verb's own listing, and the listing filters `Object.keys(EXPLAIN_TOPICS)`. A new
  configuration topic naming a drifted path is caught while it is listed (measured: the
  topic-wide conjunct fails). Excluding it from the listing filter as well makes it
  invisible: measured, a topic added to `EXPLAIN_TOPICS` naming `.plumbline.json` and
  filtered out of the listing leaves the harness green — and nothing anywhere checks
  Acceptance clause 3's promise that the listing lists *every* explainable topic, only
  that it lists every emittable check code.
- **The emittable-code derivation is convention-bound.** It matches
  `code: (CODE_[A-Z_]+),`, and `CHECK_CODES` — the list the verb hard-fails against — is
  hand-maintained. A new check whose code is a literal string is invisible to both.
  Measured: a new check emitting `plumbline/tab-indentation` with no definition and no
  listing entry leaves the harness green while the lint emits it at exit 2. The property
  holds today — I enumerated the three construction sites myself and the derivation
  agrees — but the tripwire is narrower than the quantifier.

Two things were probed for fail-open and found to fail **closed**, recorded so a future
pass does not re-pay for them. `lint_transcript`'s normalization strips both the logical
and the physical spelling of the fixture root (on this platform the binary emits the
physical spelling; both `sed` expressions are anchored at line start and can only shorten
a prefix), so a fixture layout in which neither spelling matches leaves the absolute
prefix in place and the comparison fails rather than passes. And the *fix* side of each
worked example states no transcript at all — only that a fix satisfies the rule — so
there is no documented text to compare; the harness's exit-0 checks are what the Proof
field's "a run that triggers the rule and then satisfies it" asks for. That the harness
executes two of `comment-hygiene`'s four stated fixes, one of `file_template`'s three,
and one of `appears_in_glob`'s two is an honest limit under that singular wording, not a
violation — and all nine were verified by hand this pass.

## Determination

**violated.**

The ground is proof coverage, and only that. The configuration-location defect and the
reported-line defect are both discharged and were re-proved discharged by mutation this
pass, not taken on report: the transcripts are read out of the topic text at run time and
compared whole-line against the fixture run, and a reword on either side — explanation or
message constructor — fails the harness. What remains is a sixth instance of the same
substitution, one layer in from the last. The harness now proves that the *place* each
worked example tells the reader to write configuration is the place the lint reads, and
that the *line* each example says the lint prints is the line it prints; it still does
not prove that the *inputs* each example tells the reader to write are the inputs that
produce that line. It builds a starting state of its own invention and then prints that
the example was "built verbatim from its own text — same file, same comment, same line"
and that it carries "the tag and file_template of its config entry, the file and citation
it shows". A one-line edit to any of those documented inputs — including one that turns
the example's own offending comment into a directive the same topic declares exempt —
leaves the harness fully green with the explanation and the lint in flat contradiction.

Mutations run this pass, on a sandbox copy of the tree outside the repository. The
sandbox was green at baseline, restored between every mutation, and green again at the
end; the repository's own `git status --short` was identical at start and finish.

| # | Mutation | Harness |
| --- | --- | --- |
| A | `citations` topic alone reverted to `.plumbline.json` | **fails** (3 conjuncts) |
| C | both `citation-unresolved` worked-example blocks reverted | **fails** (7) |
| D | `configPathFor` reordered to prefer the pre-migration path | **fails** (2) |
| P1 | `diagnoseCmd`'s "parses" phrasing changed → resolved side empty | **fails** (6) |
| H1a | `file_template` worked example renamed → block slice empty | **fails** (1) |
| H1b | `appears_in_glob` worked example deleted | **fails** (1) |
| H6 | all three documented transcripts rewritten to contradict the lint | **fails** (3) |
| H6-hyg / H6-ft / H6-glob | each documented transcript rewritten alone | **fails** (1 each) |
| H6b | both `citation-unresolved` message templates reworded in the lint | **fails** (2) |
| H6c | `checkCommentHygiene`'s message parenthetical reworded in the lint | **fails** (1) |
| M | `lint reports:` marker renamed in all three topics → documented line empty | **fails** (3) |
| M′ | marker renamed in `comment-hygiene` alone | **fails** (1) |
| H8a | `comment-hygiene` example's file renamed in header **and** transcript | **fails** (1) |
| H8b | same file renamed in the transcript only | **fails** (1) |
| H8c | `file_template` example's citing file renamed in prose and transcript | **fails** (1) |
| **H7a** | **`comment-hygiene` example's offending comment replaced by an exempt SPDX directive** | **green** |
| H7a2 | same comment merely reworded | **green** |
| **H7b** | **`file_template` example's `file_template` value changed to `docs/concepts/{slug}.md`** | **green** |
| **H7c** | **`appears_in_glob` example's glob changed to `**/*_spec.py`** | **green** |
| H7d | `file_template` example's tag renamed to `@my-idea:` at entry and code site | **green** |
| H7e | `appears_in_glob` example's citation moved to `src/accounts.py` in the prose | **green** |
| H9 | a second documented transcript line added under the marker, contradicting the lint | **green** |
| H2 | new topic naming `.plumbline.json`, also filtered out of the listing | **green** |
| H5c | new emittable check code as a literal string, undefined and unlisted | **green** |

What is genuinely repaired, and must not be lost in a further fix: every config-naming
site in every topic is individually guarded against drift; every equality fails closed on
an empty parse on either side; the comparison target is `configPathFor`'s reported
resolution rather than a literal; the fixtures are built at the path each site itself
states; `configPathFor`'s preference order is exercised by a two-config fixture rather
than assumed; each example's documented violation line is read out of that example's own
block at run time and compared whole-line against the fixture run, failing on a reword of
either side and on an empty extraction; every fix in every worked example clears; the
`appears_in_glob` example works end to end with the cited code site untouched; the
invocation preference for the committed binary is real and announced; and the listing
behaviour matches the Acceptance.

This determination flips when each executed worked example's documented *starting state*
is read out of that example's own text — the offending comment, the config entry's tag
and `file_template` / `appears_in_glob`, and the file the citation sits in — and used to
build the fixture, so that an edit to any documented input fails the harness; and when
the conjuncts that observe a trigger stop naming inputs they do not read. Closing the
three characterisation gaps would harden the coverage quantifiers further: reading every
documented line under a `lint reports:` marker rather than the first, a conjunct that
every topic in `EXPLAIN_TOPICS` appears in the listing, and an emittable-code enumeration
that does not depend on the `CODE_*` naming convention. None is on its own the ground of
this determination.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:5ae82d9e7276
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_COMMENT_HYGIENE = 'comment-hygiene';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CODE_CITATION_UNRESOLVED = 'citation-unresolved';"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CHECK_CODES = [CODE_COMMENT_HYGIENE, CODE_CITATION_UNRESOLVED];"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const EXPLAIN_TOPICS = {"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function explainCmd(topic) {" +31 sha256:ffad56cc3cf4
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    const other = Object.keys(EXPLAIN_TOPICS).filter((t) => !CHECK_CODES.includes(t));"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "      console.log(`  ${c}${EXPLAIN_TOPICS[c] ? '' : '   (NO DEFINITION)'}`);"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  2. Project-configured citation tags from .ok-plumbline/config.json's "citations" array,"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  Worked example. In src/rates.ts:" +33 sha256:5ec410069f54
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    // convert the rate to basis points before comparing"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    src/rates.ts:1: plumbline/comment-hygiene: comment is not permitted (not a machine directive, not a configured citation, no docstring opt-in)"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  Worked example — file_template. With this in .ok-plumbline/config.json:" +22 sha256:76c8631cb8d8
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    { "tag": "@my-concept:", "file_template": "design/concepts/{slug}.md" }"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    src/scheduler.py:1: plumbline/citation-unresolved: @my-concept: "casacde" does not resolve to design/concepts/casacde.md"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "  Worked example — appears_in_glob. With this in .ok-plumbline/config.json:" +23 sha256:5825c9fa6187
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    { "tag": "@my-invariant:", "appears_in_glob": "**/*_test.py" }"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    src/ledger.py:1: plumbline/citation-unresolved: @my-invariant: "no-negative-balances" not found in any file matching **/*_test.py"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  citations: `citations — the .ok-plumbline/config.json mechanism for declaring"
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#checkCommentHygiene @ sha256:6fcc9779aea7
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "      : 'comment is not permitted (not a machine directive, not a configured citation, no docstring opt-in)';"
- cite-span: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {" +56 sha256:c35ecf669164
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "          message: `${cit.tag} "${cit.slug}" does not resolve to ${path.relative(repoRoot, target)}`,"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "          message: `${cit.tag} "${cit.slug}" not found in any file matching ${cit.citation.appears_in_glob}`,"
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#configPathFor @ sha256:03f7e2f1cc48
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#loadConfig @ sha256:02b57f5037c6
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  const canonical = path.join(repoRoot, '.ok-plumbline', 'config.json');"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "      checks.push(['ok', `${cfgRel} parses (${cfg.citations.length} citation tag(s) declared)`]);"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "        checks.push(['warn', `config at pre-migration root location .plumbline.json — the front door's administration (/ok) moves it to .ok-plumbline/config.json`]);"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  console.error('# Suggested plumbline config above. Save as .ok-plumbline/config.json at the repo root.');"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "    console.error(`error: .ok-plumbline/config.json: citations[${idx}].tag must be a non-empty string`);"
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite: plugins/ok/families/ok-plumbline/admin/converge :: "    git mv .plumbline.json .ok-plumbline/config.json 2>/dev/null || mv .plumbline.json .ok-plumbline/config.json"
- cite-node: plugins/ok/families/ok-plumbline/skills/explain/SKILL.md @ sha256:f9e79b468b08
- cite: plugins/ok/families/ok-plumbline/skills/explain/SKILL.md :: "# Prefer the project's vendored binary so the explanation matches the rules"
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:db521a8880a6
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_explain_proof @ sha256:24a1d2db7bd6
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#topic_listing @ sha256:7ea24c435467
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#topic_config_paths @ sha256:7a936977a00c
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_config_path @ sha256:092e4be7617f
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#sentence_config_path @ sha256:b12993cacfda
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_reported_line @ sha256:7f18ce6c1c7e
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#lint_transcript @ sha256:73d87b0c72a3
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#documented_line_holds @ sha256:bf9136006c4e
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#lint_resolved_config @ sha256:75671745e0e4
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#config_path_candidates @ sha256:889e5811aa94
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_repo @ sha256:d0ec1772aabf
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  doc=$(example_reported_line comment-hygiene 'src/rates.ts')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    doc=$(example_reported_line citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    doc=$(example_reported_line citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  if documented_line_holds "$doc" "$actual"; then"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  printf '// convert the rate to basis points before comparing\nexport function compare(a: number, b: number) {\n  return a * 10000 > b * 10000;\n}\n' \"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '{"citations":[{"tag":"@my-concept:","file_template":"design/concepts/{slug}.md"}]}\n' \"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '# @my-concept: casacde\nq = 1\n' > "$repo/src/scheduler.py""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '{"citations":[{"tag":"@my-invariant:","appears_in_glob":"**/*_test.py"}]}\n' \"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '# @my-invariant: no-negative-balances\nq = 1\n' > "$repo/src/ledger.py""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    proof_ok "comment-hygiene's worked example, built verbatim from its own text — same file, same comment, same line — emits the very line that example's own 'the lint reports:' block documents, read out of the topic at run time: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "the file_template worked example, built verbatim from its own text — the tag and file_template of its config entry, the file and citation it shows, the config at the path its own block states — emits the very line its 'the lint reports:' block documents, read out of the topic at run time: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "the appears_in_glob worked example's starting state, built verbatim from its own text, fires exactly as the explanation says it does — the emitted line is the very line its own 'the lint reports:' block documents, read out of the topic at run time: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    proof_ok "every check code the lint can emit carries a worked example — a coverage check over the emittable codes, and nothing more than that""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "with a config at both locations the lint still resolves the one the topics name ($again) — the preference the explanation relies on, exercised rather than assumed""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  hyg=$(sentence_config_path comment-hygiene '"citations" array')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfgtopic=$(sentence_config_path citations 'mechanism for declaring')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfg=$(example_config_path citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfg=$(example_config_path citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  other=$(config_path_candidates | grep -v -x -F -- "$resolved" | head -1)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "for m in re.finditer(r"path\.join\(repoRoot,([^)]*)\)", body):"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "used = set(re.findall(r"code: (CODE_[A-Z_]+),", src))"
