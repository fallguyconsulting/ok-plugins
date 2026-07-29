---
audit: explain-lint-rules
artifact: story:explain-lint-rules
determination: satisfied
audited: 2026-07-29T07:15:00Z
artifact-hash: sha256:9c0c426f05f6
---

# Does a reader asking about a check code or a configuration topic receive that rule's canonical definition *and worked examples*, and does the proof confirm the explanation's stated behavior?

Sixth re-audit, and the first that flips. The design artifact's hash has not moved, so
the prior five passes' reasoning is precedent; a nomination landed on the cited proof
harness and the bytes the sole surviving claim rested on changed, so this is a whole
rewrite. The lint binary is **byte-identical** to the copy all five prior passes read —
its whole-file node hash is unchanged at `5ae82d9e7276`, and every `cite-span` over
`EXPLAIN_TOPICS`, the three worked-example blocks, `checkCommentHygiene`,
`checkCitationResolution`, `configPathFor` and `loadConfig` re-derives to the same hash.
So the explanation half of this story is confirmed untouched, and the mutation-verified
exhibitions recorded against it stand as precedent unchanged.

**The explanation half is discharged and stays discharged.** Every documented trigger and
every stated fix in the whole topic table was rebuilt verbatim in fresh repositories by
the prior pass and reproduced; none of the bytes those results rest on moved. All three
triggers reproduce their documented lines byte for byte after the path. All nine stated
fixes clear at exit 0. Both `citations` entry shapes govern their tags. The listing prints
two check codes and two configuration topics at exit 0; an unknown topic exits 1 with a
pointer back to the listing. No Falsifier disjunct fires.

**The configuration-path defect and the reported-line defect stay discharged**, on the
same unmoved bytes, and every guard the prior determination insisted must not be lost is
still in place and still cited below.

**The proof-coverage claim — the sole ground of the previous five determinations — is now
discharged.** The prior determination's recorded flip condition was exact: *"This
determination flips when each executed worked example's documented starting state is read
out of that example's own text — the offending comment, the config entry's tag and
`file_template` / `appears_in_glob`, and the file the citation sits in — and used to build
the fixture, so that an edit to any documented input fails the harness; and when the
conjuncts that observe a trigger stop naming inputs they do not read."* Both halves are
met. Four new helpers (`example_block`, `example_source_file`, `example_source_content`,
`example_config_entry`) extract each example's starting state from the topic text at run
time, all three fixtures are built from what was read, every extraction fails closed on
empty, and the three trigger-observing conjunct messages now name only what they read.
Verified by reading the extraction logic against the topic text character by character
(below), and corroborated by the gate's own demonstration record.

Three quantified populations were re-enumerated from reality. The check codes the lint can
emit were read from the violation-construction sites — one in `checkCommentHygiene`, two
in `checkCitationResolution`, the only three `code:` keys that reach `formatViolation`
(the fourth `code:` occurrence re-buckets an existing `v.code` in the summary path and
constructs nothing) — yielding **two** distinct codes, not from the list that claims to
cover them. The topics the verb can deliver were read from the topic table: **four**
(`comment-hygiene`, `citation-unresolved`, `citations`, the docstring opt-in marker).
Every string in the binary naming a config file was enumerated by grepping both spellings
across the whole file: five user-facing, all canonical.

Refreshed. The lint binary is unchanged (its whole-file pin still verifies), so nothing
above is re-litigated. `test/run.sh` moved: a new `brief()` helper (squash-and-truncate for
diagnostic output) was added, and the three `proof_bad` messages this audit cites for the
"yields no readable starting state" failure mode now interpolate `$(brief "$ex_src")` (and,
for the two `citation-unresolved` messages, `config '$cfg'`) into their text — richer
fail-closed diagnostics, not a change to what is extracted, what is compared, or when the
branch fires. Read directly against the current `run_explain_proof`: `example_block`,
`example_source_file`, `example_source_content`, and `example_config_entry` are
byte-identical to the copy this audit's determination rests on, and every `[ -n … ]` guard
and its `proof_bad` else-branch are unmoved. Citations regenerated to the current message
text; nothing else touched.

## Claims

**Title / Story — "As someone meeting a lint violation I do not recognise, I want the
canonical definition and examples for the rule that fired, so that I can decide whether to
fix the code or change the configuration without reading the linter's source."** Honored.
The verb exists, is vendored, prefers the project's committed binary, and delivers
definition-plus-working-example prose for both codes the lint can emit. Both decisions the
"so that" clause names were exercised end to end from a cold start by the prior pass on
bytes that have not moved: every code-side remediation the table states executes and
clears, and the configuration a reader is told to write is the configuration the lint
reads. Nothing in the reader's path requires opening `configPathFor`.

**Acceptance clause 1 — "The reader asks about a check code or a configuration topic →
they receive that rule's canonical definition and worked examples."** Honored. Population,
enumerated from the topic table and confirmed against the verb's listing code: four
topics, printed as two check codes and two configuration topics.

- *comment-hygiene* — definition plus a worked example naming a file, the offending
  comment, the emitted violation line, and four fixes. Honored.
- *citation-unresolved / `file_template`* — worked example with config entry, citing file,
  emitted line, three fixes. Honored.
- *citation-unresolved / `appears_in_glob`* — worked example with config entry, citing
  file, emitted line, the explicitly-disowned derived identifier, two remediations.
  Honored.
- *citations* and *the docstring opt-in marker* — definitions plus literal instances. Both
  name the canonical config path, consistent with `configPathFor`, `loadConfig`,
  `starterCmd`, `diagnoseCmd` and `validateCitation`'s error strings. Honored.

**Acceptance clause 2 — "drawn from the project's own committed lint so the explanation
matches the rules that project actually enforces."** Honored. The verb's script prefers the
project's vendored binary and falls back to the payload with an announced note; the topic
table is a string-constants block inside that binary, beside the check-code constants and
the checking functions. The prose agrees with the same binary's resolution, starter and
diagnosis paths, and with the family's converge, which migrates the root file into the
canonical one. The only surviving mentions of the pre-migration root path in the binary are
three internal and one correctly labelled; none is a user-facing instruction to write a
file the lint ignores.

**Acceptance clause 3 — "asking without a topic lists what can be explained."** Honored,
and honored *structurally* rather than by inspection: `explainCmd` with no topic prints
every member of `CHECK_CODES` (flagging any without a definition and exiting non-zero with
the count) and then `Object.keys(EXPLAIN_TOPICS).filter((t) => !CHECK_CODES.includes(t))`.
Those two groups partition the explainable set, so no explainable topic can be omitted
without editing the listing itself. An unknown topic exits 1 with a pointer back to the
listing.

**Acceptance clause 4 — "The definitions delivered are the lint's own, not a separately
maintained restatement of them."** Honored, and its remaining limit is narrower than at any
prior pass. The definitions are string constants shipped and versioned with the checks.
Guards now keep the *configuration* half from drifting at every site, keep *coverage* from
drifting, keep each example's *reported line* pinned to what the lint constructs in both
directions, and — new — keep each example's *starting inputs* pinned to what the example's
own text states. What no guard reaches is the *fix*-side prose of the `comment-hygiene`
example and the `citations` topic's documented entry shapes (recorded under the proof claim
as the residual). The clause denies a separately maintained restatement rather than
promising generated prose, so it stands as written.

**Falsifier — "An explained rule's description contradicts what the lint enforces; a check
code the lint can emit has no explanation; the explanation is a hand-maintained copy that
drifts from the rules it describes; or the reader must read the lint's source to learn what
a code means."** **No disjunct fires.** Disjunct one: every worked example and every stated
fix was built and run against this exact binary and nothing the topics assert was refuted,
including the three documented transcripts, which match byte for byte after the path.
Disjunct two: both emittable codes, enumerated from the emission sites rather than from
`CHECK_CODES`, carry definitions and worked examples. Disjunct three: the prose is
hand-maintained but does not presently disagree with the rules it describes at any point
checked, and it is now pinned to the lint at the configuration, the reported line, and the
example inputs. Disjunct four: following the explanation from a cold start succeeds without
opening the binary.

Two bounded observations, carried forward and re-verified as still not firing. The
`comment-hygiene` topic's parenthetical list of machine directives is under-inclusive
against `MACHINE_DIRECTIVE_PATTERNS`; the list is framed illustratively, and a reader
misled by it writes *less* than the lint permits, never a violation. The `citations` topic
states a kebab-case slug format that nothing in `parseCitations` enforces — its slug match
is `[^\s,;]+` with trailing punctuation stripped; the sentence describes the convention
rather than claiming the lint rejects otherwise.

**Proof — "Demo — a check code taken from a real lint run and explained; the explanation's
stated behavior confirmed by a run that triggers the rule and then satisfies it; and the
topic listing covering every check code the lint can emit."** All three conjuncts honored.
Conjunct one: the harness parses the emitted code out of a real violation line rather than
hard-coding it and explains that parsed code through the committed binary, for both codes.
Conjunct three: it derives the emittable-code set mechanically from the binary's source at
proof time rather than from a literal list. Conjunct two — *the explanation's stated
behavior confirmed* — is now honored for the stated starting state, the stated report, and
trigger-and-clear, for all three worked examples.

**Proof coverage against the Acceptance — stated as its own claim line. Honored.**

The extraction was verified by reading, not accepted on report. `example_block <topic>
<want>` slices the lines from the `Worked example` header containing `<want>` up to the
next `Worked example` header that does not — for `comment-hygiene` the want is now the
generic `'Worked example.'` (so the example's *file name* is no longer a block selector and
is free to be read as data), and for the two `citation-unresolved` examples the wants
`file_template` and `appears_in_glob` each select exactly one of the two headers. On top of
that one slice:

- `example_source_file` takes the first `… [Ii]n <token>:`-terminated line in the block
  whose captured token is not a `.json` path. On `comment-hygiene`'s block the only
  matching line in the whole block is the header (`Worked example. In src/rates.ts:`) —
  I checked every other colon-terminated line in that block by hand and none contains a
  literal `in ` before its final token. On each `citation-unresolved` block the header
  captures the config path and is filtered, and the next match is the prose line `and this
  in src/scheduler.py:` / `and this in src/ledger.py:`.
- `example_source_content` skips the `.json` header, arms at the first non-json
  `… in <file>:` line, then emits the first run of four-space-indented lines with the
  four-space margin stripped. On all three blocks it terminates on the two-space prose line
  that follows (`the lint reports:` / `the substituted path …`), so the documented
  transcript can never be collected as source. Verified line by line against the topic
  text.
- `example_config_entry` takes the first exactly-four-space-indented `{…}` line in the
  block — the entry line in each `citation-unresolved` block, captured whole and
  interpolated into `{"citations":[…]}`.
- The three fixtures are then built from those reads — `printf '%s\n' "$ex_src" >
  "$repo/$ex_file"` and `printf '{"citations":[%s]}\n' "$entry" > "$repo/$cfg"` — with
  `$cfg` itself read by `example_config_path` from the same block, and every branch guarded
  by `[ -n … ]` with a `proof_bad` on the else, so an empty extraction fails rather than
  vacuously passes.

Each of the five input mutations that left the *previous* harness fully green now fails, and
this follows from the code rather than from a report: the documented transcript is read from
the block independently of the starting state and compared whole-line, fixed-string, both
sides required non-empty (`documented_line_holds`), so an edit to any documented input moves
the emitted line while the documented line stands still.

| # | Mutation (previously green) | Now |
| --- | --- | --- |
| H7a | `comment-hygiene`'s offending comment replaced by an exempt SPDX directive | **fails** — the directive is read and written, the lint emits nothing, the empty-run guard fires |
| H7b | `file_template` example's template changed to `docs/concepts/{slug}.md` | **fails** — the entry is read, the lint reports the `docs/` path, the documented line says `design/` |
| H7c | `appears_in_glob` example's glob changed to `**/*_spec.py` | **fails** — the entry is read, the lint names `_spec.py`, the documented line names `_test.py` |
| H7d | `file_template` example's tag renamed at entry **and** code site | **fails** — both are read, the lint reports `@my-idea:`, the documented line reports `@my-concept:` |
| H7e | `appears_in_glob` example's citing file moved to `src/accounts.py` in the prose | **fails** — the file is read, the lint reports `src/accounts.py:1`, the documented line reports `src/ledger.py:1` |

H7a2 (the offending comment merely *reworded*) remains green, and correctly so: the reworded
comment is now read and written, it is still prose, and the documented transcript — which
does not quote the comment — is still exactly what the lint emits. The example remains true,
so a green harness is the right answer, where under the previous harness green was
vacuous.

The gate that dispatched this audit records running the full harness green in-repo and
running the H7a / H7b / H7c mutations on a sandbox copy, each failing the conjuncts that read
those inputs (`.ok-planner/sprints/2026-07-28-ratify-inline-certification-repairs-completion.md`).
That record was left by the gate, not by this auditor; I weigh it as corroboration and rest
the determination on the reading above, whose claimed code paths I verified myself.

Residual coverage gaps, recorded as characterisation so a later pass does not re-derive
them, and none of them the ground of a violation:

- **Only the first documented transcript line is read.** `example_reported_line` prints the
  first non-blank line after the `lint reports:` marker and exits. All three blocks are
  single-line today — verified by reading each block — so nothing is presently unchecked; a
  second documented line added under any marker would drift undetected.
- **The topic population's enumeration is circular in the proof.** `topic_listing` reads the
  topic set from the verb's own listing, so nothing in the harness independently asserts
  Acceptance clause 3's "lists what can be explained" over `EXPLAIN_TOPICS`. The code makes
  the claim true by construction (the two printed groups partition the key set), so this is
  a missing tripwire rather than an untrue claim.
- **The emittable-code derivation is convention-bound.** It matches `code: (CODE_[A-Z_]+),`,
  and `CHECK_CODES` — the list the verb hard-fails against — is hand-maintained. A new check
  whose code is a literal string would be invisible to both. The property holds today (I
  enumerated the three construction sites myself and the derivation agrees), but the
  tripwire is narrower than the quantifier.
- **Fix-side inputs remain hard-coded.** `comment-hygiene`'s declared-citation fix line and
  the `citations` entry it is exercised against, the SPDX exemption string, and the
  `citations` topic's documented entry shape are written into the harness rather than read
  out of the topic. The Proof field asks only for "a run that triggers the rule and then
  satisfies it" and states no transcript for the fix side, and each of these strings is
  verbatim the topic's own; the exposure is that a reworded *fix* or entry shape would not
  fail the harness. The prior determination recorded this as an honest limit under that
  wording and it stays one.
- **Two narrow shape assumptions in the new extractors.** `example_source_content` skips
  blank lines rather than terminating on them, so a documented source with an internal blank
  line would be rebuilt without it; and the fix-side `grep -q -F -- "$ex_src"` would degrade
  to an OR over lines if a documented source were multi-line. Both documented citation
  sources are single-line today and `comment-hygiene`'s four lines are one contiguous run —
  verified by reading — so neither assumption is presently violated.

Two things were probed for fail-open by the prior pass and found to fail **closed**, on
bytes that have not moved: `lint_transcript`'s root normalization (both `sed` expressions
are anchored at line start and can only shorten a prefix, so a layout matching neither
spelling leaves the absolute prefix and the comparison fails), and the absence of any
documented fix-side transcript to compare against.

## Determination

**satisfied.**

Both frontiers hold. The enforcing frontier — the lint binary's topic table, its check
codes, its listing, its resolver — is byte-identical to the copy five adversarial passes
rebuilt and re-ran in fresh repositories, and every anchor and span this audit holds on it
re-derives unchanged. The proof frontier, which was the sole ground of the previous five
determinations, now reads each worked example's documented starting state out of that
example's own text and builds the fixture from what it read: the offending comment and its
file for `comment-hygiene`, the config entry plus the citing file and its citation line for
both `citation-unresolved` examples, each at the config path the example's own block states.
Every extraction fails closed on empty, and the three conjunct messages name only inputs
they actually read. The five one-line documented-input edits that previously left the harness
fully green with the explanation and the lint in flat contradiction now each fail it, and
that follows from the mechanism — a separately-read documented transcript compared whole-line
against the fixture run — not from a report.

What was already repaired and must not be lost in any future change: every config-naming site
in every topic is individually guarded against drift; every equality fails closed on an empty
parse on either side; the comparison target is `configPathFor`'s reported resolution rather
than a literal; the fixtures are built at the path each site itself states; `configPathFor`'s
preference order is exercised by a two-config fixture rather than assumed; each example's
documented violation line is read out of its own block at run time and compared whole-line,
failing on a reword of either side; every fix in every worked example clears; the
`appears_in_glob` example works end to end with the cited code site untouched; the invocation
preference for the committed binary is real and announced; and the listing behaviour matches
the Acceptance.

**This stops being true if:** any of the four extraction helpers stops reading a documented
input and the corresponding fixture goes back to a literal (the conjunct messages would then
over-claim again — the failure this story has taken six passes to close); `documented_line_holds`
loses either non-empty guard or its whole-line fixed-string comparison; a guarded branch's
`else` stops being a `proof_bad`; a check is added whose code is a literal string rather than a
`CODE_*` constant, or a topic is added naming a non-canonical config path (either would be
invisible to the present tripwires); a second line is added under any `lint reports:` marker;
a documented example source gains an internal blank line or a second paragraph; or the lint's
message constructors and the topic prose are edited in matching pairs, which no mechanism can
catch and which the audit's own reading is the only defence against.

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
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:0c4a64e5255e
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_explain_proof @ sha256:d1a010b5e235
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#topic_listing @ sha256:7ea24c435467
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#topic_config_paths @ sha256:7a936977a00c
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_block @ sha256:30a60c3ee84a
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_config_path @ sha256:418c4b83deed
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#sentence_config_path @ sha256:b12993cacfda
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_reported_line @ sha256:7bc453338206
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_source_file @ sha256:e963d98cdf79
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_source_content @ sha256:3c0657bb009f
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_config_entry @ sha256:d0a911a0698c
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#lint_transcript @ sha256:73d87b0c72a3
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#documented_line_holds @ sha256:bf9136006c4e
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#lint_resolved_config @ sha256:75671745e0e4
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#config_path_candidates @ sha256:889e5811aa94
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#ci_repo @ sha256:d0ec1772aabf
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  doc=$(example_reported_line comment-hygiene 'Worked example.')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  ex_file=$(example_source_file comment-hygiene 'Worked example.')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  ex_src=$(example_source_content comment-hygiene 'Worked example.')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  entry=$(example_config_entry citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  ex_file=$(example_source_file citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  entry=$(example_config_entry citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  ex_src=$(example_source_content citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    doc=$(example_reported_line citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    doc=$(example_reported_line citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  if documented_line_holds "$doc" "$actual"; then"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '%s\n' "$ex_src" > "$repo/$ex_file""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    printf '{"citations":[%s]}\n' "$entry" > "$repo/$cfg""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    if [ "$rc" -eq 0 ] && grep -q -F -- "$ex_src" "$repo/$ex_file"; then"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "comment-hygiene's worked example, built from its own text at run time — the source its block shows, written to the file its block names ($ex_file) — emits the very line its own 'the lint reports:' block documents, also read from the topic: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "proof_bad "comment-hygiene's worked example yields no readable starting state (file '$ex_file', source '$(brief "$ex_src")') — an example whose documented inputs cannot be read out of its own block cannot be exercised as documented""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "the file_template worked example, built from its own text at run time — the config entry its block shows ($entry) at the path its block states, the citation its block shows written to the file its block names ($ex_file) — emits the very line its 'the lint reports:' block documents, also read from the topic: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "proof_bad "the file_template worked example yields no readable starting state out of its own block — config '$cfg', entry '$entry', file '$ex_file', source '$(brief "$ex_src")' — an example whose documented inputs cannot be read cannot be exercised as documented""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "the appears_in_glob worked example's starting state, built from its own text at run time — the config entry its block shows ($entry), the citation its block shows written to the file its block names ($ex_file) — fires exactly as the explanation says it does: the emitted line is the very line its own 'the lint reports:' block documents, also read from the topic: '$doc'""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "proof_bad "the appears_in_glob worked example yields no readable starting state out of its own block — config '$cfg', entry '$entry', file '$ex_file', source '$(brief "$ex_src")' — an example whose documented inputs cannot be read cannot be exercised as documented""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "    proof_ok "every check code the lint can emit carries a worked example — a coverage check over the emittable codes, and nothing more than that""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "      proof_ok "with a config at both locations the lint still resolves the one the topics name ($again) — the preference the explanation relies on, exercised rather than assumed""
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  hyg=$(sentence_config_path comment-hygiene '"citations" array')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfgtopic=$(sentence_config_path citations 'mechanism for declaring')"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfg=$(example_config_path citation-unresolved file_template)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  cfg=$(example_config_path citation-unresolved appears_in_glob)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "  other=$(config_path_candidates | grep -v -x -F -- "$resolved" | head -1)"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "for m in re.finditer(r"path\.join\(repoRoot,([^)]*)\)", body):"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "used = set(re.findall(r"code: (CODE_[A-Z_]+),", src))"

## Notes

- note: `plugins/ok/families/ok-plumbline/test/run.sh` gained four new helper functions in this change — `example_block`, `example_config_entry`, `example_source_content`, `example_source_file` — extracted so `run_explain_proof`'s worked examples read their starting state (source file path and body, config entry) out of the topic text itself rather than reproducing it verbatim in the harness. They are new siblings beside `run_explain_proof`, `example_config_path`, and `example_reported_line` — this claim's own cited mechanism — and are not yet cited themselves.
  adjudication: promoted — the nomination is exactly on target: these four helpers are the mechanism the prior determination's recorded flip condition demanded, so they are not adjacent to this claim, they *are* it. All four are now cited by node (`example_block @ sha256:30a60c3ee84a`, `example_source_file @ sha256:e963d98cdf79`, `example_source_content @ sha256:3c0657bb009f`, `example_config_entry @ sha256:d0a911a0698c` — the same hashes the inspection registry recorded for its four nominated nodes), together with the refactored `example_config_path` and `example_reported_line` whose bodies moved onto the shared `example_block`, the rebuilt `run_explain_proof`, and `cite:` anchors on every reading site, fixture-building line and rewritten conjunct message. Finding: the extraction logic was verified by reading against the topic text, all three fixtures are built from what was read, every branch fails closed on an empty extraction, the conjunct messages name only inputs they read, and the five documented-input mutations that previously left the harness green now each fail it — the determination flips from `violated` to `satisfied` and the prior `issue:`-free violation is discharged.
