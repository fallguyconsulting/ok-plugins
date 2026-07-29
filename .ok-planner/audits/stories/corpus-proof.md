---
audit: corpus-proof
artifact: story:corpus-proof
determination: satisfied
audited: 2026-07-28T22:40:00Z
artifact-hash: sha256:7247b129eeac
---

# Does the proof run give every executed proof a verdict *and* a time, leave those timings where a later session reads them without re-running, and still write nothing to the intake?

Rewritten whole. The design artifact's own hash moved this cycle — the
Acceptance gained a cost clause ("each executed proof also receives the time
it took; the run leaves those timings as a durable artifact a later session
reads without re-running anything"), the Falsifier gained its negation, and
the Proof field gained the second-session conjunct — so the prior audit's
precedent lapses and the whole story is read fresh. The prior audit carried
no `## Notes` ledger; none is opened here.

The new clause is quantified ("each executed proof"), so its population was
enumerated from reality rather than from the verb's text: every harness this
project documents as runnable, taken from the README's own list, and each one
checked for whether it actually emits a per-proof number. The mechanism was
also exercised end to end rather than read — a real run of one documented
harness through the recorder, then a second, fresh process reading the record
back with nothing re-executed.

Amended this pass, citation-only plus one substantive correction. Two of
this audit's whole-file pins moved (`test/proofs.sh`, gaining a new
`trace-corpus-to-code` section elsewhere in the file; `ok-plumbline/test/run.sh`,
whose `run_ci_proof` and `run_explain_proof` were rewritten) — every span this
audit cites inside either file is byte-identical and none was re-flagged
stale, so the six-harness enumeration and the mixed-run attribution mechanism
stand by recorded precedent, re-verified against the current tree below.
The substantive change is in the family `CLAUDE.md`'s guidance sentence,
which this audit had flagged as a non-determinative overclaim; the fixer
corrected the prose this cycle (see the Determination's limits, below),
closing that note rather than leaving it open.

Refreshed again. All three whole-file pins (`test/proofs.sh`, `test/run.sh`,
`ok-plumbline/test/run.sh`) moved once more this cycle from unrelated edits
elsewhere in each file (new floor fixtures, a new story's section); every
span this audit cites inside any of the three — the six-harness enumeration
spans and the mixed-run attribution mechanism — is byte-identical and none
re-flagged stale. Citations regenerated; nothing else touched.

## Claims

**Title / Story — "every live story's registered proofs executed
deterministically, so that a story's promised functionality is demonstrated
by a run a third party can repeat rather than by a read-through opinion."**
Honored, and unchanged from the prior reading. The verb's default scope is
every live story under `.ok-planner/design/stories/`, with caller narrowing (a
slug list, or a sprint whose deltas name the touched stories) as the stated
exception and a whole-corpus run reserved for an explicit request, never a
contract-time override. "Registered" is mechanical, not judged: collection is
`rg -l '@story:\s*<slug>'`, so what counts as a proof is decided by a grep.

**Acceptance 1 — "each receives a verdict (pass, missing, failing, or
unrunnable)."** Honored. The four verdicts were checked against four producing
conditions rather than against the report template: zero annotated artifacts →
`missing` (step 1); no discoverable invocation → `unrunnable` (step 2);
execution result → pass or `failing` (step 3). No verdict is discretionary and
there is no fifth. The recorder independently constrains the same set — its
`VERDICTS` tuple is exactly those four and `record` rejects anything else.

**Acceptance 2 — "in a structured in-context report, with failure output
carried verbatim."** Honored. Step 4 fixes the report shape (status line,
verdict table with one row per in-scope story, a findings block per non-pass
verdict) and step 3 requires capturing "the failure output verbatim on
failure".

**Acceptance 3 (new) — "each executed proof also receives the time it
took."** Honored, and this is the clause that carried the adversarial weight.
Three things had to hold, and all three do.

*The verb makes timing unconditional rather than encouraged.* Step 3 is
"Execute, timed": every proof runs through the recorder, `.ok-planner/bin/
proof-timings run <story>[,<story>…] <proof-path> -- <invocation>`, with the
word **never bare** on the invocation and an instruction to name *every* story
a harness proves so a multi-story harness is recorded against each of them.
The verdicts reached without executing anything — `missing`, `unrunnable` —
are recorded too, at zero, "so the record never reads as coverage it does not
have". The report template carries a `seconds` column with a worked value in
the example row, so a timeless report is off-contract.

*The recorder cannot leave an executed proof timeless.* `cmd_run` stamps the
wall clock around the child process, exports `PROOF_TIMINGS_OUT` to it, and
hands whatever the child emitted to `attribute`, which is the load-bearing
piece: a story that emitted its own section spans is charged the sum of them
and judged by their verdicts alone (deliberately *not* by the invocation's
exit code, because one process proving ten stories exits non-zero when any one
fails, which would otherwise record every passing story of a mixed run as
failing); a story that emitted nothing falls back to the whole invocation's
elapsed time, flagged `whole-run` so the record never passes a shared number
off as a per-story measurement. So a harness that ignores the variable
entirely still yields a number per proof, honestly labelled.

*Every documented harness actually emits.* The quantifier's population is the
harnesses this project documents as runnable; the enumeration source is the
README's own list, pinned whole below. That list has six members, and each was
read and then run:

- the planner's story proofs — `section`/`close_section` bracket every story,
  emitting one span per proved story with `story-section` or `shared-section`
  scope; ten sections observed in a live run;
- the planner's audit-check harness — `run_case` emits one span per case (the
  story field left empty, which `read_emitted`/`attribute` fold into the
  single named story's `cases` list); it declares no sections, so its
  story-level number is the honest `whole-run` fallback rather than a
  fabricated split;
- the plumbline harness — five sections over its five stories, observed live;
- the workspaces demo harness — two sections, observed live;
- the workspaces tag harness — one section, observed live;
- the front door's administration harness — three sections, observed live.

No documented harness is silent, and the one that emits only cases is covered
by the fallback rather than by an exception.

**Acceptance 4 (new) — "the run leaves those timings as a durable artifact a
later session reads without re-running anything."** Honored, and demonstrated
rather than inferred. `merge` writes `.ok-planner/proof-timings.json`,
replacing only the `(story, proof)` entries just measured and leaving every
other story's timings standing, so a narrowed run cannot destroy the profile;
`cmd_show` reads that file and prints a per-story table plus the slowest cases,
executing nothing. The demonstration: one documented harness (the plumbline
run) was executed once through `proof-timings run` naming its five stories,
and a separate, later `proof-timings show` process printed all five stories
with their own measured seconds and their scope labels, having run no proof at
all. Two of the five carried `shared-section` (they are proved by one section
together), three `story-section` — the record says which, so a reader is never
misled about what a number covers. The record reaches consumer projects: the
converge core renders `scripts/proof-timings` to `.ok-planner/bin/proof-timings`
and the estate's own ignore file to `.ok-planner/.gitignore`, and that ignore
file names `proof-timings.json`, which is what makes leaving the record behind
a non-mutation of the repository.

**Acceptance 5 — "the run invokes only harnesses the project itself
documents."** Honored as a prohibition, not a preference: commands are
discovered "from the project's own docs (CLAUDE.md, README, Makefile, package
manifest) — never invent an invocation", and finding none yields `unrunnable`
rather than a guess. Checked against this project rather than assumed: all six
harnesses above are named, with their invocations, in the repository README.

**Acceptance 6 — "the intake queue is never written."** Honored, stated in the
verb's frontmatter and again in its body, and additionally pinned by a
repository maintenance assertion registered under
`decision:prove-audit-audience-split`, so deleting the sentence turns a check
red independently of any audit. The recorder does not weaken this: the only
path it writes is `.ok-planner/proof-timings.json` (plus a system tempfile it
unlinks), never `.ok-planner/issues/`.

**Acceptance 7 — "whether a green proof spans its story's claim is left to the
implementation audit, never asserted by the run."** Honored twice: in the
opening ("that judgment belongs to the implementation audit … `/prove` answers
exactly one thing, deterministically") and in the NOT-do list ("Does not judge
whether a passing proof covers its story").

**Acceptance 8 — "The proof-running skill and the proofs it executes are
real."** Honored: `prove` is in the converge core's `SKILLS` map, so consumers
receive it rather than it living only in the payload, and this repository
carries real annotated harnesses that run green on the current tree — the
planner's proof harness passed every assertion in a run made for this audit,
covering ten live stories.

**Falsifier — "a verdict issued for a proof never executed; a failing run
reports pass; the run bends a proof to green or weakens a verdict; an invented
invocation; findings leak into the queue; or a completed run leaves no
readable record of what each proof cost, so the next cost question requires
another full run."** Each disjunct has its counterpart prohibition: the four
verdict conditions; the verbatim-capture rule; the NOT-do list's "Does not fix
proofs, code, or corpus" and "Nothing in this verb edits the working tree";
the never-invent rule; the intake prohibition. The new disjunct is the one
that mattered, and it is closed by the durable record plus `show` — the next
cost question is a read, and the harness asserts exactly that with a fresh
process.

**Proof — "a run over stories containing one honest passing proof, one
deliberately failing proof, and one story with no annotated proof, reporting
pass, failing, and missing respectively, leaving per-proof timings a second
session reads without re-running, with the working tree otherwise unchanged
afterward."** The proof spans the field, including its new conjunct. The
harness builds the three-story fixture and collects by annotation exactly as
the verb documents, asserting pass / failing / missing. It then materializes
the estate's real ignore file into the fixture and commits it — so
"otherwise unchanged" is earned by the shipped mechanism rather than by an
exemption in the test — runs two proofs and one non-executing verdict through
the real recorder, asserts the record exists, and then reads it back in a
*fresh process* (`show`) and requires all three stories present. Two sharper
conjuncts follow: the passing proof sleeps a known quarter second and the
recorded number must be ≥ 0.2s with the right verdict, so the row is a
measurement rather than a placeholder; and a two-story fixture where one story
fails inside a single invocation must still record the other as passing, which
is the mixed-run attribution rule exercised against reality. Finally the
fixture's `git status --porcelain` must be empty. All eight assertions pass on
the current tree.

Refreshed once more this cycle: `test/proofs.sh`'s whole-file pin moved
again, from the owner-ratified cap-rewording exhibitions added to the
`certify-completion` story's section elsewhere in the file. Every span this
audit cites inside it — the six-harness enumeration spans and the
mixed-run attribution mechanism — is byte-identical and none re-flagged
stale. Citation regenerated; nothing else touched.

## Determination

**satisfied.** Every Acceptance clause has a citable enforcement point, and
the two new ones are enforced by mechanism rather than by exhortation: the
verb forbids a bare invocation, the recorder guarantees a number for every
named story (measured section, summed sections, or honestly-labelled whole-run
fallback), the merge is per-`(story, proof)` so a narrowed run cannot erase the
profile, `show` is a pure read, and the converge core places both the recorder
and the ignore file that keeps its output out of the repository. The
quantifier was enumerated from the README's list rather than from the verb's
text, and all six documented harnesses emit — five by explicit per-story
sections, the sixth by per-case spans folded into the whole-run fallback. The
mechanism was exercised, not just read: one real run, then one fresh process
reading five stories' costs back with nothing re-executed.

One limit is worth naming, non-determinative. The harness models the verb's
documented collection-and-verdict algorithm in shell rather than driving the
prompt, and says so at its head — honest about what it exhibits, but a
regression in the verb's *text* (the `seconds` column dropped from the report
template, say) would not by itself turn it red.

A second limit, previously recorded here, is now closed rather than merely
non-determinative. The family's own guidance in `plugins/ok/families/ok-planner/CLAUDE.md`
formerly overclaimed — "Every harness under `test/` reports per-case and
per-story cost" — against a planner audit-check harness that reports per-case
only and has no `section` machinery, so its per-story number comes from the
recorder's fallback rather than a measured section. This cycle's fixer
corrected the sentence rather than the harness: it now reads "Every harness
under `test/` reports per-case cost, and the story harness (`test/proofs.sh`)
reports per-story cost as well" — an accurate claim about the population as
enumerated above (five harnesses carry `section` machinery and report
per-story directly; the sixth, the planner's own audit-check harness, is the
one the *story* harness — `test/proofs.sh` — covers per-story via the
fallback, exactly as the corrected sentence now says). Re-checked against the
population rather than assumed: nothing about which harnesses emit sections
changed this cycle, only the guidance prose's accuracy.

This determination stops holding if: step 3's "never bare" recorder
requirement is softened or the `seconds` column leaves the report template;
`attribute` stops falling back to the whole-run elapsed for a silent harness,
or starts folding a shared invocation's exit code over a story that emitted a
passing section; `merge` stops being per-`(story, proof)`, so a narrowed run
destroys the rest of the profile; `cmd_show` starts re-running anything, or the
record stops being written where a later session can find it; the converge core
stops rendering `bin/proof-timings` or the estate `.gitignore`, or that ignore
file stops naming `proof-timings.json` (at which point a run mutates the
repository and the Proof's unchanged-tree conjunct fails for real); the
never-writes-the-intake sentence is softened; the harness-discovery step gains
a fallback that invents an invocation; the adequacy hand-off to the
implementation audit is dropped; `prove` leaves the converge `SKILLS` map; a
newly documented harness appears in the README that emits no timing (the
whole-file pin on the README re-opens this audit when the list moves); or
`test/proofs.sh` loses its `corpus-proof` block, its `@story:` annotation, or
any of the four cost assertions.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.process @ sha256:ec4293fbb2af
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.scope @ sha256:f0065ca94261
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.what-this-skill-does-not-do @ sha256:0ea56c9a8b95
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "3. **Execute, timed.** Run every proof through the project's own recorder"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never invent an invocation"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "- Does not judge whether a passing proof covers its story"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "the only thing a run leaves behind is"
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def attribute(root, stories, proof, spans, whole_elapsed, rc):" +32 sha256:650bd0b6a402
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def merge(root, entries):" +11 sha256:41a6f2c2ea01
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "def read_emitted(path):"
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "def cmd_show(argv):"
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "    env = dict(os.environ, PROOF_TIMINGS_OUT=spans_file)"
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$PROOF_TIMINGS" > "${OK_DIR}/bin/proof-timings""
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$ESTATE_GITIGNORE" > "${OK_DIR}/.gitignore""
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:8aa7cd5969fb
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "proof-timings.json"
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh#emit_timing @ sha256:45d852a040d5
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh#close_section @ sha256:7c9d8adfa7f8
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh#verdict_for @ sha256:d678e5d9bf26
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: a later session reads every proof's cost without re-running"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: each proof's recorded cost is its own measured time"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: a story that passes beside a failing one in the same invocation is recorded as passing"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "corpus-proof: working tree otherwise unchanged after the run"
- cite-node: plugins/ok/families/ok-planner/test/run.sh#run_case @ sha256:33798e6ae95d
- cite-node: plugins/ok/families/ok-planner/test/run.sh#emit_timing @ sha256:c2d6be117857
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#emit_timing @ sha256:fc35cbda7827
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#close_section @ sha256:7c9d8adfa7f8
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh#emit_timing @ sha256:298b5a30a855
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh#emit_timing @ sha256:45d852a040d5
- cite-node: plugins/ok/test/administration.sh#emit_timing @ sha256:45d852a040d5
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite: plugins/ok/families/ok-planner/CLAUDE.md :: "Every harness under `test/` reports per-case cost, and the story harness (`test/proofs.sh`) reports per-story cost as well, so that profile exists to be read."
- cite-node: README.md @ sha256:e1090bf5222a
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-node: plugins/ok/families/ok-planner/scripts/proof-timings @ sha256:a02e8cbfb2fa
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore @ sha256:6e2b32d8b092
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:0c4a64e5255e
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:ea9c18329ea1
- cite-node: plugins/ok/families/ok-workspaces/test/tags.sh @ sha256:df8544882d8d
- cite-node: plugins/ok/test/administration.sh @ sha256:215e1489d4ce
