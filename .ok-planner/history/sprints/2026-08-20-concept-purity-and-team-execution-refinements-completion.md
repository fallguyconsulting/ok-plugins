# Completion report — Sprint: Concept purity, prose-hook scope, and team-execution refinements

Sprint: `.ok-planner/sprints/2026-08-20-concept-purity-and-team-execution-refinements.md`

## Stages

- [x] Stage 1 — Corpus deltas without code: apply the 16 amended decisions and 5 new decisions from the sidecar, verify the new story and the three retirements by file equality, regenerate `decisions.md` and `stories.md`. Work items: (none; deltas only, per "apply a delta no work item implements on its own").
- [x] Stage 2 — Concept rules: concept definition and template; sign-off compliance reviewer's Concept form; audit reads a concept as vocabulary. Work items: Concept definition and template; Sign-off compliance reviewer enforces concept form; Audit reads a concept as vocabulary.
- [x] Stage 3 — Concept sweep: apply the 35 concept bodies, regenerate `concepts.md`, run the compliance reviewer as the check. Work items: Apply the concept sweep.
- [x] Stage 4 — Prose hook binds files only: plumbline hooks, proofs, docs, converge. Work items: Prose hook binds files only.
- [x] Stage 5 — Team execution shape: retirement band; two reviewer instruments; ledger sidecar and "edits no file a worker owns"; monitor-based liveness. Work items: Retirement band; Two reviewer instruments in the code-review brief; Ledger sidecar; Monitor-based liveness.
- [x] Stage 6 — Family test suites follow, both suites pass, project copies converged. Work items: Family test suites follow.
- [x] Closing — finish this completion report.
- [x] Closing — run `/certify-work` with the sprint's path as its argument.
- [x] Closing — walk the presentation.
- [x] Closing — offer archive-and-commit.

## Work done

### Stage 1 — Corpus deltas without code

I copied 21 decision bodies from the sidecar into
`.ok-planner/design/decisions/` verbatim, then checked every one of
them byte-identical to its sidecar. They break down as 16 amendments
(`adversarial-implementation-audits`, `affirmative-warrant-ladder`,
`closing-commit-baseline`, `code-cites-design`, `cold-boxed-synthesis`,
`comments-forbidden-by-default`, `declared-stack-profile`,
`documentation-walk-in-composed-audit`, `filesystem-discovery-markers`,
`final-form-deltas`, `lockstep-suite-version`,
`relevance-scoped-queue-gate`, `steering-over-prose-lint`,
`team-execution-cold-gate`, `vendored-skills`, `whole-file-ownership`),
four new files (`administration-is-a-user-act`,
`generated-catalog-tocs`, `open-refuses-an-occupied-workspace`,
`sprint-goal-read-from-the-repository`), and `per-run-artifact-tag`,
which existed live and whose sidecar body supersedes it with the
re-homed commitments. The catalog now holds 44 decisions.

I verified the deltas that landed out of band in commit `b61e166`.
`.ok-planner/design/stories/fresh-artifacts-per-run.md` is identical
to its sidecar body. `concepts/content-addressed-tag.md`,
`decisions/content-addressed-src-tag.md`, and
`stories/content-addressed-artifacts.md` are all absent. The three
retired slugs leave no dangling citation, and no file outside the
sprint and record directories still names them, so the retirements
resolve cleanly.

I regenerated `.ok-planner/design/decisions.md` per
`discover-design`'s catalog-TOC step. It keeps the do-not-edit header
verbatim and carries one bullet per live file, sorted by slug, each
summary the first sentence of the artifact's `## Choice` bounded at 120
characters. The 44 bullets match the 44 files exactly, in the same
order, and no summary names a path or an external document. I left
`.ok-planner/design/stories.md` alone, because a regeneration
reproduces it byte for byte. I left `concepts/` and `concepts.md`
untouched for Stage 3.

The stage changes corpus prose only, so it carries no test: the sprint
gives no test to a commitment realized in prose.

### Stage 2 — Concept rules

**Concept definition and template.** In
`skills/_shared/artifact-definitions.md` I rewrote
`{{CONCEPT-DEFINITION}}` to the sprint's wording: a concept defines,
and it does not guarantee, forbid, or decide; it says what kind of
thing exists, what it is for, and where it ends against its neighbors;
it names no instance, no mechanism, no requirement, and no
prohibition; instances and mechanisms belong in code or in a decision,
and a promise to a user belongs in a story; one concept per file. I
removed the `## Invariants` section from `{{CONCEPT-TEMPLATE}}`, so the
template now runs `What it is`, `Purpose`, `Boundaries`, `Aliases`.

**Sign-off compliance reviewer.** In
`skills/_shared/design-doc-compliance-reviewer.md` I added a `### Concept
form` block that transcludes `{{CONCEPT-DEFINITION}}` beside the story
and decision definitions and enforces the form on every in-scope
concept: the body is `What it is`, `Purpose`, `Boundaries`, optionally
`Aliases`, and an `## Invariants` section or any other section is a
violation; a sentence stating a requirement, a prohibition, a
guarantee, a mechanism, a constant, a command, or an instance is a
violation whose fix is to remove it or move it to the decision or story
that owns it; an alias not live in code or prose is a violation. I
updated the preamble line listing what the prompt transcludes, added
concept form to the reviewer's job sentence, and pointed the
anti-padding bullet at the new block.

**Audit reads a concept as vocabulary.** In `ceremony/audit.md` and
`skills/_shared/implementation-auditor.md` I replaced the concept
support axis. The auditor no longer reads Invariants against the code;
it reads the concept as vocabulary — the concept has one live name, and
the sites that cite it and the code around them agree with its `What it
is` and its `Boundaries`, while `Purpose` carries no determination. The
compliance axis for a concept now names the concept form.

**The sweep.** I walked every hit of `rg -n -i invariant` under the
family and changed only the sites that name the section or describe a
concept as carrying invariants: `scripts/ok-planner-CLAUDE.md` ("with
definitions, purposes, and boundaries"), `ceremony/plan-sprint.md` (the
surfacer's "Invariants and Boundaries", and its example line), and
`skills/discover-design/SKILL.md` at three sites — the sign-off rule
"Invariants are properties of the concept", now a rule that the body
defines and nothing more; the back-edge's list of a concept's editable
sections; and the cross-check phrase placing an annotation in
`concepts/` "as an invariant". The family `CLAUDE.md` names no
invariant and needed no edit.

I left the unrelated senses alone. `_discover/` scaffolding still
records the invariants the code maintains, because it describes code
rather than concepts, which covers five hits in
`skills/discover-design/SKILL.md`. The mechanical-versus-judgment test
in `artifact-definitions.md`, `certification-core.md`, and
`verify-issues/SKILL.md` still offers "an invariant added or dropped"
as an example of changing a commitment, which no longer points at a
concept section. The self-containment rule still allows invariant IDs
in a body, and narrowing it would change what a decision may write. The
sprint's bearing test in `plan-sprint.md` still lists an invariant
among the things a live artifact commits to; an over-inclusive
detection test costs nothing, and trimming it risks missing a bearing
change. `design-doc-compliance-reviewer.md` uses the word as an
adjective.

**Materialize and test.** `bash plugins/ok/families/ok-planner/admin/converge`
rewrote the project copies, and `converge diagnose` now reports
agreement with the carried v18.8.0. The vendored compliance reviewer
carries the `{{CONCEPT-DEFINITION}}` token, the Concept form block, and
the updated preamble. No assertion in `test/stories.sh` reads any block
this stage changed — its concept references cover the session hook's
TOC injection and the surfacer's ranking, neither of which this stage
touches — so no test needed updating. I ran the suite anyway as a
sanity check on the reconverged copies: 40 pass, 0 fail, exit 0.

### Stage 3 — Concept sweep

I copied all 35 concept bodies from the sidecar into
`.ok-planner/design/concepts/` and checked each one byte-identical to
its sidecar afterwards. The slug sets matched before the copy, so the
sweep amended 35 concepts and added or retired none.

I regenerated `.ok-planner/design/concepts.md` with the generator that
wrote `decisions.md`: the do-not-edit header kept verbatim, one bullet
per live file sorted by slug, each summary the first sentence of
`## What it is` bounded at 120 characters, and the alias parenthetical
carried in the bullet as the previous file carried it. The 35 bullets
match the 35 files, and no summary names a path.

**The concept-form check: 35 checked, 1 finding, fixed.** I applied the
new Concept form block myself over every applied concept, as the
reviewer would. All 35 carry exactly `What it is`, `Purpose`,
`Boundaries`, and optionally `Aliases`; none carries an `## Invariants`
section or any other section; frontmatter carries only `concept:` and
`aliases:`. I checked all 20 aliases across the 13 concepts that
declare them, and every one is live in code or prose outside the
concept bodies themselves.

The finding was in `annotation`, and D3 records it. I repaired the live
file only. The sidecar keeps the text the owner approved, because the
sidecar is the record of that approval and the builder is not one of
the corpus's writers.

`run-tag` states that no other run uses the value. I left it as
approved: uniqueness is what the noun means, so the sentence defines
rather than commits. Two more bodies sit closer to the line, and F1 and
F2 carry them for the gate's architect.

The stage carries no test: it changes corpus prose only.

### Stage 4 — Prose hook binds files only

**The hook.** In `scripts/hooks/post-edit.js` the `Bash` case of
`writtenSources` no longer contributes the command text. A Bash call
now contributes only the files it changed under the project root, found
through the start marker the pre hook stamps; a call with no start
marker contributes nothing. Dropping that source left five definitions
unreachable — `HEREDOC_OPEN`, `REDIRECT_TARGET`,
`resolveRedirectTarget`, `redirectsOnlyOutsideRoot`, and
`withoutTextRedirectedOutsideRoot` — and I removed all five. Nothing
else referenced them. I reworded the `PostToolUse` reminder to
"review every sentence you wrote in these files", and carried the same
wording into the Stop instruction in `scripts/hooks/stop-review.js`. The
`plumbline:prose-reviewed` clear marker is untouched.

**The proofs.** I flipped the three proofs that asserted command text
is flagged, so each now asserts the call leaves no flag: a commit
message passed with `-m` (`tb2`), a heredoc whose target is a project
file (`tb5`), and a commit message carried by a heredoc (`tb6`). I kept
the two that still hold: a heredoc's target file under the root is
found through the start marker and flagged (`tb1`), and a heredoc
redirected to a scratch directory leaves no flag (`tb4`). The Stop-hook
proof seeded its flag file with the label "the Bash command text",
which the hook can no longer write, so it now seeds a file the hook
does write and greps for that instead.

**The docs.** `docs/plumbline-cheatsheet.md`,
`README.md`, and `admin/ADMINISTRATION.md` each described the detector
as reading command text; all three now say the hook binds files and
that a commit message, changing no file, is not a written source.
`docs/integration-contract.md` names the hook's wiring but never its
detection sources, so it needed no change.

**Materialize and test.** `bash plugins/ok/families/ok-plumbline/admin/converge`
rewrote the project copies and `converge diagnose` reports healthy. I
ran `test/run.sh` whole, as the only suite covering the hooks: 121
proofs pass, none fail. A sweep for the old detection claims returns
nothing outside the archive.

### Stage 5 — Team execution shape

**Retirement band.** In `skills/_shared/dispatch-discipline.md` the
worker-pool rule's retirement bullet is now a band: a worker retires at
an item boundary carrying roughly 300k to 500k tokens of measured
context on a 1M-token window, scaled on a smaller window, and at each
boundary the session projects what the next item costs and hands it
over only when the worker will still retire inside the band. The bullet
says what the band buys: its floor stops a worker retiring with context
to spare, and its ceiling stays below the compaction window.
`skills/_shared/sprint-document.md`'s Retirement bullet cites that band
rather than restating a threshold.

**Two reviewer instruments.** In `{{CODE-REVIEW-BRIEF}}` in
`skills/_shared/certification-core.md`, the testing-standard bullet now
names the three elapsed-time shapes a fixed detector misses — an
elapsed-time comparison inside an assertion, a timeout context feeding
a call whose success the test asserts, a timer whose firing changes the
outcome — with the one rule that judges all three: a deadline that is
the input under test is fine, and a deadline whose expiry decides pass
or fail is a finding. A new bullet covers suites the change did not
run: `rg` for assertions about the behavior the change altered and read
whether the change falsifies them. Both are worded without reference to
this project, and the standing reviewer inherits them through the
shared brief.

**Ledger sidecar.** The relay protocol beside
`{{STANDING-REVIEWER-PROMPT}}` and step 3 of `sprint-document.md` now
have the session write the reviewer's open ledger and the open claimed
forks to `<sprint-name>-ledger.md` beside the completion report on
every relay, so a replacement session and a replacement reviewer read
that state from disk. "During the build it edits nothing" narrows to
"edits no file a worker owns" in `sprint-document.md`, the worker-pool
rule, `scripts/ok-planner-CLAUDE.md`, both cheatsheets, and
`plugins/ok/CLAUDE.md`. The archival sentence names the ledger file
among what moves to `history/`, and the goal rule says the ledger file
is no term of the contract. The standing reviewer's own "It edits
nothing and runs no suite" stays: that sentence is about the reviewer,
which still edits nothing at all.

**Monitor-based liveness.** The worker-pool rule's "Quiet is not
finished" bullet now says that where the harness offers a file monitor,
the session arms one on each worker's output and takes its trip as the
liveness signal, and never polls by hand.

**The audit ceremony's worker pool.** `plugins/ok/ceremonies/audit/SKILL.md`
restated the fixed threshold for its own pool. I changed it to the
band. The worker-pool rule governs that pool too, and leaving one
ceremony on a threshold the shared rule no longer states would put two
retirement rules in the suite at once.

**Materialize and test.** Both layers converged and
`converge diagnose` reports agreement with the carried v18.8.0. No
assertion in `test/stories.sh` reads a block this stage changed: its
ledger assertions are about the certification loop's
`## Certification ledger` section in the completion report, which is a
different artifact and untouched here. I ran the suite anyway: 40 pass,
0 fail. The stage carries no test of its own, because every commitment
it lands is realized in prose.

### Stage 6 — Family test suites follow

**The gate's archival enumeration.** The close-out listed the sprint,
the completion report, the delta sidecar, and the promoted issue files,
but never the ledger file this sprint introduces, so a close-out today
would leave the ledger behind at the `sprints/` path. Both statements
of that enumeration now name it — `{{CERTIFY-CLOSE-OUT}}` in
`skills/_shared/certification-core.md` and the Close-out section of
`ceremony/certify-work.md` — as the ledger file where the sprint has
one. The audit ceremony's restated pool rule took the retirement band
in Stage 5 but not the monitor sentence the shared bullet gained; it
carries both now, so the restatement matches the rule it restates.

**Every suite, run whole.** All five pass:
`ok-planner/test/stories.sh` 40 proofs, `ok-plumbline/test/run.sh` 121
proofs, `ok-workspaces/test/tags.sh` 12 proofs,
`ok-workspaces/test/demo.sh` four scenarios, and
`plugins/ok/test/administration.sh` 125 proofs. Every suite exits 0 and
none reports a failure. The two suites that read prompt blocks or hook
behavior this sprint changed are the planner's and the plumbline's, and
Stages 2 through 5 updated their assertions with each change.

**Every layer, diagnosed.** The ceremony layer and all three families
report agreement with the carried v18.8.0: `ok ceremonies` in
agreement, `ok-planner` in agreement, `ok-plumbline` healthy, and
`ok-workspaces` clean. No layer reports drift.

**Completion contract, item 1.** I compared all 57 delta bodies against
their live artifacts: 35 concepts, 21 decisions, and one story. Fifty-six
are byte-equal. The single difference is
`.ok-planner/design/concepts/annotation.md`, which D3 records: the live
file drops the words "enforced or", and the sidecar keeps the text the
owner approved. The three retirements stay absent, and each catalog
matches its directory — 35 concepts, 44 decisions, 27 stories.

## Divergences

D1 — The regenerated `decisions.md` shortens four summaries that the
previous file carried truncated. `discover-design`'s catalog-TOC step
asks for a "one-sentence summary, ≤120 chars" and the `catalog-toc`
concept asks for "a bounded one-sentence summary". The generation that
produced the file in the tree read the rule differently: it flattened
the whole `## Choice` section and cut it at 120 characters, which runs
past the first sentence wherever that sentence is short. The two
readings agree on every entry whose first sentence already exceeds 120
characters, so nothing in the file showed the difference until a
decision with a short first sentence landed. I followed the written
rule: the summary is the first sentence, truncated only when it
exceeds 120 characters. Three of the four shortened entries belong to
decisions this sprint amends (`comments-forbidden-by-default`,
`steering-over-prose-lint`, `team-execution-cold-gate`). The fourth,
`affirmative-practices-over-exemptions`, this sprint does not amend; it
changes because regeneration rewrites the whole file, which
`generated-catalog-tocs` — landing in this same stage — makes the
governing rule. I validated the generator against the two catalogs this stage
does not rewrite: it reproduces `stories.md` byte for byte, and it
reproduces `concepts.md` byte for byte apart from the same
first-sentence cases.

D2 — Three decision deltas landed in this stage ahead of the work that
realizes them: `adversarial-implementation-audits`,
`steering-over-prose-lint`, and `team-execution-cold-gate`. The session
staged every decision delta into Stage 1, and the work items that make
these three true land later — the concept-audit rewrite in Stage 2, the
prose-hook narrowing in Stage 4, and the retirement band, the ledger
sidecar, and monitor-based liveness in Stage 5. Between this stage and
those, the corpus asserts behavior the tree does not carry yet: for
example `post-edit.js` still counts the Bash command text as a written
source, and `dispatch-discipline.md` and the cheatsheets still carry the
fixed ~300k retirement threshold and "during the build it edits
nothing". The staging is deliberate and the gap closes inside this
sprint; nothing here is a commitment the work leaves unmet.

D3 — I removed the words "enforced or" from
`.ok-planner/design/concepts/annotation.md`. Its `What it is` described
an annotation as marking "a concept enforced or expressed". The new
`{{CONCEPT-DEFINITION}}` says a concept does not guarantee, forbid, or
decide, so nothing enforces a concept, and the same phrase was struck
from the annotation glossary in `discover-design/SKILL.md` earlier in
this sprint. The rule determines the repair and no commitment changes:
the annotation still marks the same sites. The live file now differs
from its delta body by those two words. The delta keeps the approved
text, so the difference is visible to the gate rather than hidden by an
edit to both sides.

F1 — Determined call, not a fork. The record-discipline sentence stands
in `.ok-planner/design/concepts/estate.md` as the sprint approved it,
and the architect changed no file. Reading (a) is the one every
reasonable owner lands on. The estate concept names the content kinds
the directory holds, and this sentence names what a record is inside an
estate. It states no mechanism that produces one. The owner approved
this body as a final-form delta under the same concept definition the
fork weighs it against. The execution contract applies every delta
verbatim. Options (b) and (c) each move a commitment: (b) writes a
decision no work item authorizes, and (c) drops the rule from the
corpus and leaves it only in a cheatsheet the front door overwrites.
Verified: the live file matches its sidecar body byte for byte.

F2 — Determined call, not a fork. The shape sentence stands in
`.ok-planner/design/concepts/catalog-toc.md` as the sprint approved it,
and the architect changed no file. Alphabetical order and the
leading-line summary define the noun: a reader who meets a catalog
table of contents in code needs both to read the file.
`generated-catalog-tocs` settles one tradeoff — a generator writes the
index instead of an author — and its Rationale and Alternatives argue
that tradeoff alone. Moving the shape into its Choice would leave a
Choice clause the Rationale does not back. This sprint fixes that
decision in final form, and no work item authorizes amending it.
Verified: the live file matches its sidecar body byte for byte.

D4 — The fix loop adopts D3's repair to
`.ok-planner/design/concepts/annotation.md`, and the live file keeps
"a concept expressed". `final-form-deltas` names certification's
expression repair as a licensed writer of the corpus. This repair
meets that decision's test: the rules determine the text, and no
commitment changes. The new `{{CONCEPT-DEFINITION}}` says a concept
does not guarantee, forbid, or decide, so nothing enforces a concept.
The same sprint dropped the enforcement framing from the annotation
glossary in `discover-design/SKILL.md` and from
`concept-artifact.md`'s Boundaries. Restoring "enforced" would return
the one word the sweep removed everywhere else. The delta sidecar
keeps the approved text, so completion-contract item 1 reports one
visible difference across the 57 deltas: these two words. I changed no
file for this entry.

D5 — I split the prose hook's tb3 proof in two. The block named "a
Bash call that writes no prose leaves no flag" stamped no start
marker, so the hook returned early and the prose test never ran. The
first block now stamps the marker and writes a code-only file under
the project root, so the prose test decides the verdict. The second
block keeps the unmarked call under a name that says what it proves.
A mutation of each block's input flips that block to a failure, so
neither passes vacuously. The finding left the second proof optional; the marker gate
is a branch the hook takes on external input, so I kept it proved.

D6 — Corpus edit. `.ok-planner/design/_discover/annotation-convention.md`
quoted the annotation glossary as "load-bearing site where a concept
is enforced or expressed". This sprint rewrote that glossary line in
`discover-design/SKILL.md` to "load-bearing site where a concept is
expressed", so the scaffolding quoted text the tree no longer carries.
I updated the quote to the source. The entry describes the tooling as
it stands, and the change follows the same sweep as D3 and D4.

D7 — The marker-stamp helper takes its paths as parameters.
`stamp_bash_marker` in `plugins/ok/families/ok-plumbline/test/run.sh`
reads the repository and the temp directory from `$1` and `$2`, the
way `invoke_hook` and `hook_case` read theirs, rather than from the
calling function's locals. The five stamping sites call it with the
tool-use id. The tb1 block keeps its inline stamp, because it asserts
on the marker file it writes, and the tb3n block keeps its bare
removal, because it proves the unmarked path.

## Certification ledger

| id | site | producer | round entered | outcome | repeats | rounds touched | note |
|---|---|---|---|---|---|---|---|
| C1 | `.ok-planner/design/concepts/estate.md` Boundaries — the record discipline sentence (report entry F1) | sprint alignment | 1 | fixed 1 | 0 | 1 | CLAIMED FORK; architect OVERTURNED: definitional under the approved definition; built reading (a) stands; F1 rewritten in Divergences |
| C2 | `.ok-planner/design/concepts/catalog-toc.md` What it is — the index's shape (report entry F2) | sprint alignment | 1 | fixed 1 | 0 | 1 | CLAIMED FORK; architect OVERTURNED: the shape is what the noun is; built reading (a) stands; F2 rewritten in Divergences |
| C3 | `.ok-planner/design/concepts/annotation.md` What it is — "enforced or" absent; live file differs from the sidecar delta | code review | 1 | fixed 1 | 0 | 1 | fixer: (b) — live text stands as the loop's expression repair; D4 recorded; sidecar keeps approved bytes; `_discover/annotation-convention.md` quote swept (D6) |
| C4 | `plugins/ok/families/ok-plumbline/test/run.sh` tb4 proof message — claims outside-root exclusion the block never exercises | code review | 1 | fixed 1 | 0 | 1 | fixer: tb4 now writes the prose file outside the root before the hook runs; message true |
| C5 | `plugins/ok/families/ok-plumbline/test/run.sh` tb3 proof — no start marker, so the no-prose case is never decided by `isProse` | code review | 1 | fixed 1 | 0 | 1 | fixer: tb3 stamps a marker and writes a code-only file; new tb3n keeps the no-marker path under its own name; both mutation-checked (D5) |
| C6 | `implementation-auditor.md:102`, `sprint-document.md:218`, `discover-design/SKILL.md:695` — ragged wraps inside hard-wrapped blocks | code review | 1 | fixed 1 | 0 | 1 | fixer: three blocks rewrapped in plugins/ok/**; re-converged; diagnose in agreement |
| C7 | `plugins/ok/families/ok-plumbline/test/run.sh` — the three-line marker-stamp preamble copied five times (tb2, tb3, tb4, tb5, tb6) | code review | 2 | fixed 2 | 0 | 1 | fixer: `stamp_bash_marker` helper extracted, five sites call it; suite 122 ok; D7 recorded |

# Certification — Sprint: Concept purity, prose-hook scope, and team-execution refinements

Status: certified clean

## Outcomes delivered

- `concept-artifact` and the concept definition: a concept now defines only — no Invariants section, no instance, mechanism, requirement, or prohibition. The definition, the template, the sign-off reviewer's Concept form block, and the audit's concept instrument all say so, and all 35 concepts in this corpus carry the new form.
- `adversarial-implementation-audits`: the audit reads a concept as vocabulary — one live name, the citing sites and surrounding code agreeing with What it is and Boundaries — and a decision by the adversarial reading; every restatement of the old concept instrument is gone.
- `steering-over-prose-lint`: the plumbline post hook flags only files written under the project root; a Bash call's command text and commit message are never flagged; the end-of-work reminder and the Stop backstop read "every sentence you wrote in these files".
- `team-execution-cold-gate`: the worker-pool rule retires a worker inside a 300k–500k band by the session's projection at each boundary; the session edits no file a worker owns and writes the standing ledger to `<sprint-name>-ledger.md` on every relay; a file monitor is the liveness signal; the code-review brief names the three elapsed-time shapes and the cross-suite assertion check; the close-out archives the ledger file.
- 13 decisions amended and 4 new (`generated-catalog-tocs`, `sprint-goal-read-from-the-repository`, `administration-is-a-user-act`, `open-refuses-an-occupied-workspace`) carry the commitments the concept sweep removed.
- `per-run-artifact-tag` and `fresh-artifacts-per-run` authorized retroactively; the content-addressed trio retired.

## Divergences

- D1 — `decisions.md` regenerated on the first-sentence reading of the "one-sentence summary, ≤120 chars" rule; four summaries shortened, one of them on an unamended decision.
- D2 — three decision deltas (`adversarial-implementation-audits`, `steering-over-prose-lint`, `team-execution-cold-gate`) applied in Stage 1 ahead of the stages that realized them; the gap closed inside the sprint.
- D3 / D4 — corpus repair: `concepts/annotation.md` What it is reads "a concept expressed", not "a concept enforced or expressed"; the loop adopted it as an expression repair under the new concept definition; the sidecar keeps the approved text, so the live file differs from its delta by those two words.
- D5 — the plumbline `tb3` proof split into a marker-stamped code-only proof and `tb3n` for the unmarked path.
- D6 — corpus edit: `_discover/annotation-convention.md`'s glossary quote synced to the rewritten source line.
- D7 — `stamp_bash_marker` helper takes its paths as parameters.
- F1 — architect OVERTURNED (determined call): `estate.md`'s record-discipline sentence is definitional; the approved text stands.
- F2 — architect OVERTURNED (determined call): `catalog-toc.md`'s shape sentence is what the noun is; the approved text stands.
- Refuted: none. Reversals: none.

## Findings fixed

- Sprint alignment (the corpus-change judge): 2 — the two claimed forks, both overturned by the architect; otherwise clean across three passes.
- Mechanical floor (ok-planner annotation integrity; ok-plumbline lint and catalog TOC check; ok-workspaces discipline sweep): clean on first pass and every re-run.
- Test suites (five: planner stories, plumbline run, workspaces tags and demo, ok administration): pass on first pass and every re-run.
- Code review: 5 — one delta-verbatim difference (resolved as the expression repair, D4), two vacuous test proofs (C4, C5), three ragged wraps (C6), one DRY extraction (C7). Reviewer reported DRY after round 2.
- Loop subtractions: 0 repeats; 0 reversals. Three rounds; the third had no edit.

## The finding ledger

See `## Certification ledger` above: C1–C7, every row settled (`fixed 1` or `fixed 2`), none open.

## Dissolved

None.

## Issues promoted

None. The intake is empty; `/verify-issues` skipped.

Close-out offer: archive the sprint — move it to `.ok-planner/history/sprints/` with its completion report, its ledger file, and its delta sidecar — and commit the work. Both on the owner's word only.
