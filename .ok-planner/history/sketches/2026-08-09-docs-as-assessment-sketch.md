# Documentation as assessment

A proposal for a new ok-* family skill: release-time documentation produced as
an **assessment of the project's story catalog from the user's vantage**, not
as prose describing the code. It extends the existing pipeline

```
[design corpus] → [code] → [audit] → [docs]
```

so that documentation is a release product like the audit — and, like the
audit, a diagnostic instrument. The skill applies to any ok-planner project;
rimsky is the motivating case study and first adopter.

Status: proposal, distilled from rimsky's v0.15.0 documentation run
(2026-08-08/09) and revised the same day in owner discussion; this version
supersedes the original draft throughout. The skill is `/document` — an
orchestrator named for the user's intent; the assessment is its method, and
`/audit` is its first step. The major calls from that discussion, all
reflected below: full re-assessment each release (no carry-forward), the
audit invoked as phase 0, audit-style snapshot semantics with citations as
part of the product, assumptions (formerly "pseudo-stories") synthesized
cold and warranted by an affirmative-only ladder, experiments held distinct
from tests, audit-shaped batching, owner-declared surface-kind
enumerators, and reference documentation as projection plus warranted
enrichment on the catalog's own spine. One open question remains, and it is
suite-level: the ladder for `/audit`.

---

## 1. The problem, and the evidence

Rimsky's documentation was maintained by a conventional reconcile-and-review
skill: per-surface agents brought prose current against source, a review loop
re-read it, structural lints gated it. Two full generations of that skill
produced a corpus whose failures were measured in the v0.15.0 run:

- **Restatement drifts, systematically.** Of 209 classified finding-units, 61
  were prose restating what source says — and every one had drifted, 14 into
  asserting the **opposite** of current behavior. Another 33 were
  mechanically-derivable structure carried by hand. 45% of all findings were
  maintenance rent on content the source already carries.
- **No gate checks truth.** Parity gates structure, prose gates non-emptiness,
  link gates resolution. A sentence true at release N and false at N+1 passes
  every gate verbatim. Prose is a cache with no invalidation.
- **Reading does not find the valuable content; execution does.** ~10 strong
  agents reviewing prose against source: ~100 findings, **zero** new traps.
  One cold agent executing five user tasks against the released artifacts:
  **three** new high-severity traps, plus independent confirmation of four
  known ones. In that experiment, 4 of 5 tasks would have shipped wrong if
  answered by reading source alone; execution corrected every one.
- **Value clusters in the test suite's shadow.** Every high-value trap sat
  where tests are not: paths nothing in-tree reaches, user-facing paths the
  suite bypasses (the project's own test driver bypassed the CLI a user must
  use), or expectations no developer would test because the developer knows
  better. Structural: tests encode the developer's assumptions; traps are the
  **user's** assumptions contradicted.
- **Completeness pays.** The one clearly successful prose pattern: catalogs
  complete over their domain let a cold reader answer "does X exist?" with
  confidence from a single read (5/5 absence probes in the case study).

The design below keeps the moral of the third finding without its cost:
nothing is ever called *held* without a run — but most runs are the
project's own tests, re-executed at the release, with hand-built
experiments reserved for the remainder the suite doesn't reach.

## 2. The theory

Documentation is an honest assessment: *we went in as the user, and here is
what happened.* Three statement kinds, one shape — **what it is, exactly**:

- **ordinary** — the surface, and what it does **not** do. The negative half
  is the authored value; the positive half is nearly free from source.
- **trap** — an assumption a user would reasonably hold, contradicted by
  measured behavior. The creative content of the whole product.
- **defect** — the call, and that it misbehaves, with the issue ref.

**The economy rule.** An assumption that holds gets no ink. The corpus's
silence *means* "your assumption is correct here" — honest only because
assessment records attest the assumptions were measured. The product is
exactly the divergence set, plus evidence the rest was checked.

**Assumptions make trap-hunting semi-systematic.** An assumption is a
user-vantage prior written down before measuring: "as a user, I *assume* I
can…" — the record kind every trap begins as. Where a story is a promise the
owner committed to, an assumption is a prior the user would hold; the two
are different kinds, not grades of the same one. Assumption sources are
enumerable — names (a field called `reason`
that surfaces nowhere), symmetry between sibling components, convention
(retry implies a cap), concept-derived expectations, ecosystem priors (a
`jsonpath` field that is not JSONPath). Generation is creative in selection,
mechanical in execution.

**"No story claims it" is not a defect.** A surface element no story claims
is documented as what it is (often: "has no effect beyond X"). A defect is a
*story that doesn't work*. The design corpus captures intent; absence of
intent is information, not accusation.

**Two spines.** Stories and assumptions drive *assessments* — conditional,
behavioral, measured. The surface-kind declaration drives the *catalog* —
unconditional, one row per enumerated element, no story required. The
completeness contract and its absence-answers hang on the second spine;
everything the run measures hangs on the first.

## 3. Placement and composition

**The skill runs inside the project**, at release time, beside the audit —
they share the trigger, the inputs (the design corpus and the release), and
much of the machinery (batched readers, evidence discipline, issue filing). The separate
docs-repo pattern rimsky used is the anti-pattern this proposal retires: it
recreated the project's execution context at great cost, and its entire
handoff/flag ceremony existed only because defect-finder and defect-owner sat
in different repos. In-project, a failed assessment files an issue in the
intake — nothing else.

**Audit first.** `/document` opens by invoking `/audit` at the release
commit — phase 0 of the run, with the audit remaining its own skill that
the orchestrator composes rather than absorbs. The two
instruments are the two sides of the knowledge gap this sketch is built on:
the audit is the corpus-soaked pass that reads source and rules on support;
`/document` forms the user's expectations cold and warrants every claim
affirmatively against the release. The audit sets
the delivery criterion — only stories the audit called `supported` are
documented as delivered; an `unsupported` or `unclear` story is already an
intake issue, and assessing it as delivered would document a known gap as
product. Audit results steer dispatch (which stories are assessed, which are
pre-excluded) but never enter the synthesizer's context — audit prose is
exactly the developer-side knowledge the coldness invariant keeps away from
assumption formation. Assessors, warm by design, still form their positions
from their own reading, never from the audit's.

**Snapshot semantics.** The produced corpus adopts the audit corpus's
semantics wholesale: stamped with the release commit, a statement about that
tag and never a standing verdict. It lives in the estate beside the audits,
under the same out-of-context-by-default record discipline — never consulted
to understand the current tree, never reconciled or refreshed by day-to-day
sessions. Describing an earlier iteration is its job, so staleness is a git
question, not a defect. The one difference from the audits: this record is
also shipped, through the separate publisher below.

**Traps double as test-gap reports.** "Nothing in-tree reaches this path" is
actionable in-project: add the scenario (the trap becomes measured behavior)
or fix the bug. The trap registry is a standing critique of the suite.

**The coldness invariant — synthesis only.** Traps live in the gap between
developer knowledge and user expectation, so the agent that *forms*
assumptions must sit on the user's side: the synthesizer sees only what a
user could see — the story catalog, the published concept layer, the surface
catalog, the prior release's published corpus — never source, tests,
internal docs, or audit output. Verification is deliberately the opposite:
batched assessors are warm — linkage-following, code-reading — because
taking a position requires the code, and what keeps warm verification
honest is not input restriction but the affirmative-only rule of the
warrant ladder (process section): no assumption is *held* without a passing
run. Synthesis coldness is enforced mechanically (the box, next), because
the case study proved instruction-only enforcement fails: an orchestrator's
briefs twice contaminated agents with a false claim absorbed from a release
note.

**The box — synthesis coldness enforced in four layers**, each covering
another's gap:

1. **Construct by export, not checkout.** Phase 1 copies the allowed
   materials into a fresh scratch directory outside the project tree. (A
   worktree is the wrong tool: it checks out the whole source, which is the
   contraband.) The synthesizer's box: stories + published concepts +
   surface catalog + the prior release's published corpus.
2. **Launch minimal.** The agent's working directory is the box; it is never
   told the repo path; read-only file tools only — no shell, no network.
   Ecosystem priors live in the model's weights, and the project's own
   public repo is contraband too.
3. **Deny at the tool layer.** A permission rule or pre-tool-use hook
   rejects any access resolving outside the box — mechanical refusal, not
   exhortation.
4. **Verify the transcript, void on contact.** The phase-4 gate scans the
   synthesizer's transcript for out-of-box access; a single hit voids the
   output and the run is redone. Peeking produces nothing usable.

**The brief is a fixed template.** The case study's contamination arrived
through composed orchestrator prose, so the brief a cold agent receives
ships with the skill verbatim; the orchestrator interpolates file paths and
nothing else.

**Distribution is separate and optional.** A project may package the produced
corpus as an installable skill (rimsky ships a plugin); that publisher is a
thin shell, not part of this skill.

## 4. The process — audit, then four phases, one of which thinks

| Phase | Actor | Output |
|---|---|---|
| **0 Audit** | the `/audit` skill, invoked | support determinations at this commit — the delivery criterion and the dispatch pre-filter |
| **1 Project** | generators, no agents | the surface catalog (every user-facing element, kinds configured per project); the story↔test↔artifact map read from plumbline `@story:` tags and scenario names |
| **2 Assess** | one cold synthesizer, then batched warm assessors | the typed assumption list; one ladder-warranted record per story-way and assumption |
| **3 Distill** | one editorial agent | traps extracted into the registry; defects filed as issues; router updated |
| **4 Gate** | mechanical | every citation resolves at the tag; every artifact re-runs; catalogs complete over their domains; every audit-`supported` story carries at least one assessment at this release |

**Surface-kind declaration — owner judgment once, mechanical ever after.**
Following the suite's stack-profile pattern, the project commits one
declaration in the estate: a list of surface kinds, each naming a
mechanical enumeration source — a command or script the phase-1 generator
runs to produce that kind's full population (the router's table dump, a
config-module grep, the CLI tree walk). The declared enumerator defines the
domain, which is what makes the gate's completeness check real: catalog
rows must match the enumerated population one-to-one. Two loud-failure
guards, in the no-silent-caps spirit: each run compares the declaration
against cheap detectors (the stack profile, obvious project markers) and
*reports* candidate kinds the declaration misses — reported, never
auto-added, the declaration being owner-owned; and an enumerator that
errors or returns zero members fails the gate unless the kind is marked
expected-empty, so an empty catalog can never vacuously pass.

**Phase 2 is two roles: cold synthesis, warm assessment.** A single
**synthesizer** holds the whole published picture — its box holds stories,
published concepts, the surface catalog, and the prior release's published
corpus — and its fixed brief asks, in effect: *you have read everything
this project publishes about itself; what do you assume to be true about
what it does and how it behaves?* The brief then walks the assumption
sources as a checklist — every name that promises observable behavior,
every sibling pair checked for the other's affordances, every convention
invoked, every ecosystem term — so the output is a typed assumption list
carrying coverage counts, written down before anything is verified. One
mind matters here: the strongest source, symmetry, is visible only to an
agent holding the full surface at once. **Batched assessors** then take
slabs of stories and assumptions and climb the warrant ladder (next); they
are warm by design, following each story's linkages (`@story:` annotations,
the story↔test map) into tests and source. The role split still prevents
self-softening: the agent that verifies never rewrites the expectation it
started with.

**The warrant ladder — each item climbs only as far as it must.**

1. **Existing warrant.** Find a test in the project's own suite that
   exercises the behavior and passes at the release commit → *held*,
   `warrant: upstream-test`. The cheap rung most items should die on; every
   story is expected to carry test linkages, and one that has none is
   itself an intake finding.
2. **Careful reading.** No existing test — read what the linkages lead to.
   Reading can establish a *trap* (this is where evidence sets come from),
   but per the affirmative-only rule it never upgrades "probably holds" to
   *held*.
3. **Experiment.** Write a small runnable and run it. Passing → affirmative
   proof, *held*, the experiment archived in the corpus as the proof
   artifact. Failing → not a finding: one piece of evidence sending the
   assessor back to rung 2 to build a position.

**Experiments, not tests — and what an experiment can prove.** An
executable proves an assumption only in the affirmative: a passing run is a
constructive proof regardless of the experiment's craftsmanship, while a
failing run cannot distinguish "assumption false" from "experiment stale"
from "experiment wrong" — so a failure is never a finding, only a flag that
dispatches diagnosis. A trap's warrant is therefore **never a failed
experiment but the evidence set** — citations showing the behavior isn't
there — with the failed runnable attached as corroboration (`repro:`), not
proof. Experiments live in the documentation corpus, stamped at the
release like every other record, and staleness is harmless by construction:
a rotted experiment that starts failing mints nothing and simply re-enters
diagnosis at the next run. Every item exits the ladder in exactly one of
three recorded states: **held** (affirmative warrant only), **trap** (for
an assumption) or **defect** (for a promise) warranted by evidence, or
**unverified** (the climb stopped — stated, never silent).

**Promotion is the owner's, through the sprint loop.** `/document`, like
the audit, changes no code. The distill phase may emit a candidate test
beside a trap or held-assumption record; it enters the project's maintained
suite only via intake issue and sprint work item — as an ordinary test for
behavior worth keeping measured, or as an expected-fail test (the `xfail`
idiom) encoding a standing trap, whose unexpected *pass* is CI's own signal
that the trap has dissolved. An assumption that was simply wrong and will
never be made right stays expected-fail indefinitely: permanent executable
documentation, citing its trap slug.

**Cost is audit-shaped.** Assessment runs as parallel batches like the
audit's, and the expensive instrument — the experiment — is reached only
when both cheap rungs fail. The per-release budget caps experiments;
whatever isn't climbed is recorded `unverified`, never silently dropped.

**The run is the story-fitness test.** An assessor that cannot connect a
story to any measured way — no test linkage to follow, no path reading can
settle, no experiment it can even formulate from the story's promise — has
found something real: a user holding the story is in the same position. No
user-vantage rewrite pass runs ahead of the assessment (a hand-maintained
parallel restatement of the story catalog is the disease this sketch
diagnoses); instead the assessor records the outcome, the distill phase
files an intake issue on the story (a rewrite is owner judgment), and the
story is excluded from documented-as-delivered this release — an
unassessable story has no measurement behind it. First adoption will
surface these in a batch; that is one sprint's worth of intake, and fitness
converges through the normal issue loop thereafter.

**Full re-assessment, no carry-forward.** Every release re-assesses every
story; nothing carries, nothing tracks staleness, nothing invalidates
anything. An earlier draft of this sketch carried assessments forward on a
still-resolving evidence set — smart-invalidation machinery the suite has
built before and retired before, because it costs more than paying for the
re-run (the audit skill reached the same terminus). The cost envelope is
managed the way the audit's is: batched agent runs, paid only at release.

**The prior docs are an input, not a cache.** Invalidating everything does
not mean discarding it: the last published corpus goes into the
synthesizer's box — legitimately, since it is shipped, user-visible
material, and so its contents are user priors by the box's own admission
test. Every prior trap thereby re-enters as an assumption and is
re-measured: still contradicted, it reappears; fixed, it dissolves into
attested silence per the economy rule. Continuity of attention, without
carry-forward of conclusions.

**Assumption lifecycle is re-derivation.** There is no standing registry to
manage: the assumption list is synthesized fresh each release, so a fixed
trap needs no retirement ceremony and an added test simply shrinks the
measured map's complement. Graduation is the owner's act through machinery
that already exists — an assumed capability worth *promising* is an intake
issue and then a sprint's corpus delta; a test-gap trap becomes a sprint
work item the same way. The distill phase files issues; it does not
auto-nominate traps for promotion.

**Dispatch targeting.** Every audit-`supported` story is assessed;
assumptions are prioritized by the complement of the measured map —
surfaces no test touches, and user paths the suite shortcuts — where value
density was proven to concentrate. The audit's pre-filtering reaches the
orchestrator only — the synthesizer never sees it, and assessors form their
positions from their own reading (placement section).

**What the test suite contributes.** Working artifacts (scenario fixtures are
CI-verified runnables), observed outputs (assertions), partial story→test
mapping (plumbline tags), and the *warrant for the unwritten portion* — a
passing scenario is a measurement, re-run every release. What it cannot
contribute: assumptions (wrong side of the knowledge gap — tests encode the
developer's expectations, and forming the user's is the cold synthesizer's
job). An assessment's `warrant:` field distinguishes "we ran an experiment"
from "their suite runs it"; where a test harness diverges from the packaged
product, those are different claims and the record says which it rests on.

## 5. The artifact spec

Five record kinds; greppable markdown with typed frontmatter, living beside
the design corpus. Surface-kind vocabulary (`yaml:`, `cli:`, `route:`,
`env:`, `signal:`, `class:`, …) is per-project configuration — the
surface-kind declaration in the process section.

**Citation policy.** Every citation means "at the stamped commit." Citations
are part of the product — the handoff pointing an agent reader into the
tagged source for further understanding — and the gate checks them once, at
production. They are never process inputs: no gate, carry-forward, or
freshness check may key on whether they resolve against anything later. (The
audit corpus's citation ban is audit-local — an audit has no reader whose job
a citation serves — not a family principle this corpus inherits.)

**Catalog row** — one per surface element, unconditional (the completeness
contract; absence-answers depend on it). Prose beyond the row arrives only
through use; `refs` are derived, never authored.

```yaml
id: yaml:error_types.reason
is: optional string on an error_types entry; empty becomes the literal give_up
not: surfaced anywhere — not persisted, not on the signal, absent from every API response
src: lib/foundation/spec/policy.go::ErrorTypePolicy @<release>
refs: [trap:reason-is-write-only, assess:template-error-policy]
```

**Reference documentation is projection plus warranted enrichment.** "What
is legal to send" decomposes into two layers. The *structural* layer —
fields, types, flags, enum values, required/optional — is derived by the
phase-1 projection generators from the same source the code compiles
against (the `.proto`, the CLI parser tree, the route table), fresh at the
release commit: true by construction, checked by regeneration rather than
review, since structure regenerated at the tag cannot disagree with the
tag. (This is the layer the case study measured drifting when carried by
hand.) The *behavioral* layer — what a field actually does, constraints
enforced in code but absent from the schema, the `not:` line — is not
derivable and enters a row only through use, carrying a warrant: an
assessment or experiment that touched it (`refs:` are derived from those
records) or an assessor's evidence citations. For everything deeper, the
row's `src:` is the handoff: the agent reader has the tag checked out, so
reference docs project the shape, warrant the behavior, and cite the rest.

**Assessment** — one per *measured way*. The audit asks of a story "is it
supported?" and answers with a verdict reached by reading source; an
assessment asks "how does a user obtain the promised benefit?" and answers
with a demonstrated path — the runnable, the observation, the honest
boundary. The path is the product: this record *is* the story's
documentation, not commentary on it. A story the software honors several
ways (a CLI path, an API path, a config path) carries one record per way,
each standing on its own evidence and re-measured without disturbing its
siblings; the story's documentation is the set. `story:` names the promise,
`assumption:` a user-vantage prior; a contradicted *promise* is a defect, a
contradicted *assumption* is a trap. An assessor that cannot construct any
way at all records that outcome — the story-fitness rule in the process
section.

```yaml
story: template-error-policy        # or assumption: "<as a user, I assume …>"
way: cli-run                        # one record per measured way; the story's docs are the set
release: <tag>
warrant: experiment                 # experiment | upstream-test:<path>
artifact: |                         # the exact runnable, verbatim
observed: |                         # what actually happened, incl. output
traps: [<slugs>]
defects: [<issue refs>]
unverified: <what + why>            # the honest boundary, always present
```

**Trap** — assumption → actual → evidence, with an honest three-state repro.
The warrant is the evidence set, never a failed experiment (affirmative-only
rule); the evidence is frozen provenance at the stamped commit, and traps,
like assessments, are re-measured each release rather than expired by
citation drift. (The stricter rule — "no
repro, no entry" — was tested against the case-study inventory and rejected:
it excluded 27% of traps non-randomly, clustering exactly on licensing facts,
absences-of-checks, and paths nothing in-tree exercises — including the
single highest-value find.)

```yaml
trap: reason-is-write-only
assumption: a string field named `reason` on a give-up policy surfaces somewhere an operator can read
actual: copied into a struct field with zero non-test readers; not persisted, not on the signal, in no API response; validation accepts it silently
evidence:
  - <file>::<symbol>    # what this establishes
repro: assertion        # command | assertion | none:<why>
found-by: assess:<id>
```

**Defect** — not a corpus artifact. An issue in the project intake;
assessments reference it; a catalog row may carry `known: <summary> — see #NNN`.

**Router + concepts** — the mental model and map (small), and the mirrored
intent layer from the design corpus (the one prose surface the case study
proved sound, except where the corpus itself was wrong — which is an audit
finding, not a docs edit).

## 6. What this deletes, relative to the conventional docs skill

The per-surface reconcile subagents, the reviewer/fixer converge loop, the
prose-presence gates, the description-sidecar round-trip machinery, and most
prose-style rules — all of it existed to produce and police the restatement
layer, which no longer exists. Surviving: projection generators (minus their
hand-carried description columns), a symbol/citation-resolution lint
repurposed as the evidence gate, and the executed walkthroughs — no longer
a late verification gate but phase 2's experiments, the warrant of last
resort. Target size for the
skill: a few pages. The case-study skill was ~2,500 lines across three files;
its length was the cost of prose, and the new skill's shortness is the
receipt.

## 7. First adopter: rimsky

Seed material already exists in rimsky-docs' uncommitted v0.15.0 run:
**62 verified traps** in four-field form (evidence-checked; the discipline of
writing evidence sets itself surfaced 11 bad citations and refuted 2
findings), **5 prototype assessments** (the cold experiment's task reports,
verified live), **4 compiled protocol skeletons** as assessment artifacts,
**2 executed journey walkthroughs**, complete catalog raw material (routes
with auth posture, CLI tree, template schema, signal payloads, 86/86 env
vars), and ~9 verified upstream defect candidates that become intake issues
on adoption. Whether rimsky-docs ships its uncommitted run as a final
old-shape release or holds it as seed is a separate decision recorded there.

## 8. Open questions

1. **The ladder for `/audit`** — the affirmative-only warrant ladder
   (existing test → reading → experiment) may fit the audit's support
   determinations too; today the audit only reads. A suite-level question
   beyond this sketch.
