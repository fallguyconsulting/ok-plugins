# ok-planner — audit ceremony surface

What the suite's periodic audit does about this family's estate. The
ceremony owns the spine — surface, enumerate, determine, judge, check,
present, close out; this file owns everything ok-planner contributes
to it. Materialized into consumer projects at
`.ok-planner/ceremony/audit.md`; the ceremony reads it there when
`.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root. Without a design corpus
there is nothing here to audit: say so, point at `/discover-design`,
and let the other estates' phases run.

`.ok-planner/surface/surface.json` — the **surface declaration**: the
owner's committed list of the product's user-facing surface kinds,
each paired with a mechanical enumeration source. Shape:

```json
{
  "kinds": [
    { "kind": "cli-verbs",
      "enumerate": "<command whose stdout is one member per line>",
      "expectedEmpty": false },
    { "kind": "config-keys",
      "enumerate": "cat .ok-planner/surface/members/config-keys",
      "derivation": "agentic",
      "reads": "<one line naming what the derivation reads>" }
  ]
}
```

A kind whose population no mechanical source can produce is marked
`"derivation": "agentic"` and carries `"reads"` — one line naming
what the derivation reads. The two fields travel together: a marked
kind without `reads`, or an unmarked kind carrying either field, is a
declaration error the reconciler rejects. A marked kind's `enumerate`
is still an ordinary command with the ordinary loud-error contract —
conventionally `cat` over the kind's **committed member list** at
`.ok-planner/surface/members/<kind>` (one member per line), the
mechanical face of a population only agentic derivation can produce.

`.ok-planner/surface/guidance.md` — the **surface guidance**: the
owner's prose rules for ruling any enumerated element public or
private (general rules narrowed by exceptions; prose for judgment,
never a member inventory).

Both are owner-owned: detection may propose a kind or a rule, only the
owner declares, and the files are written only as transcription of the
owner's explicit answers. Without them the surface determination
cannot run — say so, report any candidate kinds detected, and run the
story audits by reading with every determination capped at `unclear`
(a user-vantage claim cannot be measured without a ruled surface);
decisions and concepts audit normally.

## Layout

`mkdir -p .ok-planner/audits/concepts .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/audits/surface .ok-planner/surface/members .ok-planner/experiments .ok-planner/issues .ok-planner/history/issues`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

## Surface

The run opens by settling the public-surface partition, per
`decision:owner-guided-surface-partition`: every enumerated element
ruled public or private by applying the owner's guidance, no default,
nothing invisible. This is the run's **one interactive moment**; a
settled partition and ratified guidance pass it silently, so cadence
runs stay hands-free.

Run the vendored reconciler:

```bash
.ok-planner/bin/surface-reconcile
```

(If the project has not converged, fall back to the payload's
`scripts/surface-reconcile` and announce the fallback exactly as the
Check phase does for its checker.)

The tool reads the declaration, runs each kind's enumerator, writes
the fresh extraction to `.ok-planner/audits/surface/extraction.json`,
diffs it against the membership the current ruling was computed from,
and reports per element — classified public, classified private, or
unclaimed — plus the guidance-anchor comparison: the current guidance
blob hash against the one the ruling recorded, plus the **agentic
inventory** — one line naming the marked kinds, their count out of
all declared kinds, and what each reads. Exit 0 means settled;
exit 2 means unclaimed elements or an unratified guidance change;
exit 1 is an error in the declaration or an enumerator, which is a
loud failure the run does not proceed past.

**Re-derive the agentic kinds — every run, before reading the exit
code as settled.** The reconciler can only compare the committed
member lists against the ruling; whether those lists still match
reality is this run's agentic work. For each kind marked
`"derivation": "agentic"`, re-derive its members from what `reads`
names, and diff the result against the committed list at
`.ok-planner/surface/members/<kind>`. No drift → nothing to say. Drift
is walked with the owner exactly as unclaimed elements are — one
prose question per divergent member, batched where obviously
parallel — and the committed list is updated only from that walk,
never silently; a changed list then re-runs the reconciler, and any
newly listed member lands unclaimed and is classified in the ordinary
walk below.

On exit 2, in order:

1. **Ratify guidance changes.** If the guidance hash moved, read
   `git log` for `surface/guidance.md` since the ruling's stamped
   commit. A change carried by an approved sprint's execution is
   already ratified — the sprint's sign-off was the owner's approval;
   acknowledge it in one line. Any other change is walked with the
   owner now: confirm it stands (it is ratified by the confirmation)
   or the owner revises it on the spot. Ratification is detected by
   comparing anchors, never by tracked state.
2. **Classify the unclaimed.** Apply the guidance to every unclaimed
   element. An element the guidance settles is classified, with the
   governing rule noted in the walk summary. An element the guidance
   cannot settle reaches the owner as one prose question per element
   (batch the obviously-parallel ones); **every answer lands in the
   guidance** — transcribed as the owner's own text, a rule or an
   exception — never only in the ruling. This walk is owner
   conversation, not filing: nothing here enters the intake.
3. **Write the ruling.** Regenerate
   `.ok-planner/audits/surface/ruling.json` whole:

   ```json
   {
     "commit": "<stamped at close-out>",
     "guidanceHash": "<git hash-object .ok-planner/surface/guidance.md>",
     "kinds": [
       { "kind": "cli-verbs",
         "public": ["..."],
         "private": ["..."] }
     ]
   }
   ```

   Every extracted member appears in exactly one of `public`/`private`
   for its kind — the partition is total, and an element nobody ruled
   is a failure, never "private by omission". The two anchors — the
   commit (stamped at close-out, like every audit file) and the
   guidance hash — are what make staleness and ratification pure git
   questions. Re-run the reconciler after writing; it must exit 0.

Candidate surface kinds detected in the tree but not declared are
reported to the owner in the walk, never auto-added.

**Identify the agentic at settle time.** Whenever the walk settles a
new or changed kind — a candidate the owner adopts, an enumeration
source the owner revises — the run identifies whether any mechanical
source can enumerate its population. None means the kind is marked
`"derivation": "agentic"` with `reads` naming the source the
derivation reads, the run derives the members and commits the list at
`.ok-planner/surface/members/<kind>`, and the kind's `enumerate`
reads that list. The marked set is a standing inventory the owner
inspects and retires — each kind by adopting a practice that makes
its population mechanically enumerable, ordinary sprint work — so the
walk reports it whenever it changes.

## Enumerate

Every file under `.ok-planner/design/concepts/`,
`.ok-planner/design/stories/`, and `.ok-planner/design/decisions/` is in
scope — there is no subset. **Concepts are audited like decisions**,
because the compliance axis is a reading of any artifact against its own
authoring rules and a concept has rules of its own: the altitude bar, the
self-containment restrictions, and the no-implementation-enumeration
tightening. Its support axis is its Invariants read against the code,
exactly as a decision's Choice is.

**Stories are enumerated apart from the other two**, because their
instrument differs (`decision:user-vantage-story-audits`): story
support is measured from the user's side, through the ruled public
surface, never settled by reading or by citing a test. Batch stories
by the surface elements their ways drive, five to ten per batch.
Batch decisions and concepts **by locality**, so artifacts whose
claims rest on the same code ride in one dispatch and that code is
read once. Say how many artifacts and how many batches of each
instrument before dispatching.

## Determine

Two instruments, one collection, the same three words.

**Decisions and concepts — adversarial reading.** One dispatch per
batch of `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from
`.claude/skills/_shared/implementation-auditor.md`, with `[AUDIT SET]`
filled with that batch's refs. Each writes its batch's audit files to
`.ok-planner/audits/<bucket>/<slug>.md` and reports one line per
artifact.

**Stories — user-vantage measurement.** One dispatch per story batch
of `{{STORY-AUDITOR-PROMPT}}` from the same file, with `[AUDIT SET]`
filled with the batch's refs and `[SURFACE]` with the ruling's public
elements for the kinds the batch drives. The instrument is the
**experiment harness** at `.ok-planner/experiments/` (one experiment
per directory: the runnable files plus a `record.md` — frontmatter
`experiment:`, `commit:`; body: what it ran against, what was
observed):

- an archived experiment covering a claim is **re-run** at this tree;
- one the extraction diff makes suspect is **repaired first**, the
  diff steering the repair;
- a claim no archived experiment covers gets a **new** experiment;
- one whose surface elements are gone from the ruling is **retired**.

A story is `supported` only when passing runs driven through elements
the ruling classifies public demonstrate the capability and the
benefit. A failing run is never a finding — it dispatches diagnosis
(stale probe, wrong probe, or wrong assumption; the project's tests
may steer diagnosis but never stand as warrant). Conclusions never
carry: a prior run warrants nothing until re-run at this tree.

Each audit records **two independent axes**, per `{{AUDIT-DEFINITION}}`:
whether the artifact complies with its own authoring rules, and whether
the codebase supports what it claims. They genuinely come apart, and
both are written. Never one agent per artifact, and never a subagent
inside an auditor.

## Judge

Collect every ref the auditors returned as `unsupported` or `unclear`.
None → skip this stage and say so. Otherwise dispatch
`{{AUDIT-JUDGE-PROMPT}}` from the same file with the full escalation
list — each ref, its determination, its instrument (reading or
measurement), and its one-line reason, verbatim. The judge finalizes
each: confirmed (issue filed, `unsupported` stands — a story's
measured surface contradiction among them), overturned (rewritten as
`supported`), or undecidable (issue filed, `unclear` stands). It is
terminal; whatever it returns is the run's answer.

The compliance axis never escalates. A form defect is mechanical by
construction — the rules determine the compliant text — so it is
recorded in the audit, reported to the human, and fixed by whoever
holds the report.

## Distill

Experiments this run had to **build**, passing at the stamp, that
would have to be maintained to keep, are promotion candidates: file
each as an intake issue per the estate's issue-file conventions —
never a failed run, never an opinion of the product. Promotion into
the project's suites (as an ordinary test, or an expected-fail test
encoding a standing trap) is sprint work through the intake, never
this run's act.

## Sweep

Two checks no per-artifact reading can perform. Both report findings
in-context; neither writes an audit file and neither files anything.

### Cross-artifact consistency

```
Agent (general-purpose, model: sonnet-5):
  ## Cross-artifact consistency audit

  ### Your job

  Find pairs (or small groups) of live design artifacts under
  `.ok-planner/design/` that contradict each other. Each artifact
  may be internally valid; the finding is the *conflict between*
  them. You resolve nothing yourself — you classify each
  contradiction per {{MECHANICAL-VS-JUDGMENT-RULE}} (transcluded
  below) and report it.

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  {{LEAF-AGENT-RULE}}

  ### What counts as a conflict

  - Two decisions that mandate incompatible mechanisms for the
    same concern — e.g. one decision requires a component the
    deployment another decision mandates cannot run.
  - A decision whose Choice negates another decision's Choice.
  - An invariant one concept states that another artifact's body
    contradicts.
  - A decision or concept that forecloses a user-outcome a story
    promises.

  ### How to work

  Read every live concept, story, and decision.
  For each, note what it *requires* and what it *forbids*. Then
  look for a second artifact whose requirement collides with the
  first's — the collision is the finding. Read the code where
  deciding whether two claims actually collide depends on what the
  code does.

  ### Output format

  Status line first: `Status: Consistent | Conflicts Found`.
  Then one entry per conflicting pair/group: the artifact slugs,
  the specific claim in each that collides, and why they cannot
  both hold. Classify each: when the code and one artifact agree
  and the other's colliding text is a stale rendering of the
  same commitment — nothing the project commits to changes by
  aligning it — class `mechanical`, stating the determined fix
  (align the stale text to the commitment the code and the
  counterpart artifact share). When both readings are live
  possibilities, the code sides with neither, or any alignment
  would change what the project commits to, class `judgment`,
  category `conflicting` — only the owner resolves a real
  contradiction. Read the code before classing: whether a
  collision is stale prose or a live disagreement is a fact
  about the code, not an opinion.

  ### Anti-padding

  - A conflict is a genuine contradiction, not a tension or a
    neighbor-boundary blur (that is `muddy-boundary`, and only
    when real). Two artifacts on the same topic conflict only if
    both cannot hold.
  - Don't grade severity. Don't propose the resolution for a
    `judgment` finding — that is the owner's; a `mechanical`
    finding states its determined fix, which is not a proposal.
  - Report only contradictions between live artifacts.
```

### Surface inventory

The inverse of every other pass: the others read the corpus and ask
whether the code honors it; this one reads *reality* and asks whether
the corpus claims it. It is the only pass that catches an artifact
whose text honestly under-claims — a decision scoped to one transport
while a second transport ships, an entry point no invariant governs —
because every corpus-anchored check inherits the corpus's own blind
spot. What it finds that no **declared surface kind's** enumerator
would produce is also a candidate-kind report for the opening walk's
list: detection proposes, only the owner declares.

```
Agent (general-purpose, model: sonnet-5):
  ## Surface-inventory audit

  ### Your job

  Enumerate the project's externally reachable surfaces from the
  code and deployment configuration alone — never from the design
  corpus — then check each against the corpus. Classify findings
  per {{MECHANICAL-VS-JUDGMENT-RULE}} (transcluded below).

  {{MECHANICAL-VS-JUDGMENT-RULE}}

  {{LEAF-AGENT-RULE}}

  ### Build the inventory (from reality only)

  Read the deployment composition (compose files, deploy
  manifests, service definitions) and the code's listener/route
  registrations. List every surface an outside party can reach:
  published ports and what answers on them, HTTP routes and
  their authentication posture, message-broker listeners and
  their transport security, scheduled or event-driven entry
  points. For each, record: surface, transport, authentication
  observed in code/config (not assumed), and the file:line
  evidence.

  ### Check the inventory against the corpus

  For each surface, find the live concepts, stories, and
  decisions whose text governs it (read the corpus only AFTER
  the inventory is built, so the corpus cannot shape what you
  look for). Verdicts per surface:

  - **claimed and consistent** — some artifact governs it and
    the observed posture matches the text. No finding.
  - **claimed and contradicted** — an artifact's text asserts a
    posture the observed surface violates (an "every surface
    authenticates" Choice beside an unauthenticated published
    port). Class `judgment`, category `conflicting`: quote the
    claim and the evidence.
  - **unclaimed** — no artifact's text reaches this surface at
    all. Class `judgment`, category `unspecified`: the corpus
    has a hole exactly the shape of this surface. Record what
    the surface does and which artifacts come closest.

  ### Anti-padding

  - Internal-only surfaces (private-network listeners, in-
    composition addresses) are in scope only when an artifact
    claims a property about them; never file "internal service
    is internal".
  - One finding per surface, not per artifact it collides with.
  - Don't grade severity. Don't propose resolutions for
    judgment findings.
```

## Check

One mechanical floor, and it is deterministic: run
`.ok-planner/bin/audit-check`. If the project has not converged, fall
back to the payload's `scripts/audit-check` and **announce the fallback
verbatim in the report**, on its own line, before the findings:
`note: no vendored checker — using the payload's copy; /ok pins one to
this project`. An unpinned verdict is never delivered silently.

The checker validates, across every estate that carries a corpus: audit
coverage, the audit files' shape on both axes, one-paragraph brevity,
the rule that a non-supported determination names its issue, the
coverage shape's counts agreeing with the determination, that each
catalog's table of contents lists exactly its collection's live slugs
(the backstop `concept:catalog-toc` names), and — where a surface
ruling exists — the ruling itself: both anchors present, the partition
total against the cached extraction (no unclassified member), and the
recorded guidance hash agreeing with the guidance file as of the
stamped commit. Nothing else. A finding means the judge or the surface
determination left something unfinished; re-dispatch that stage rather
than editing a record by hand. Do not re-derive its checks by reading;
its output is authoritative.

**Annotation integrity** rides here too:
`rg -n '@(concept|story|decision):\s*\S+'` across the codebase; every
(kind, slug) pair must resolve to
`.ok-planner/design/<collection>/<slug>.md`. Dangling and kind-mismatched
annotations are mechanical findings — repoint to the renamed slug,
correct the kind prefix, or remove one pointing at a retired artifact.

## Verify

If the judge or the distillation filed any, invoke `verify-issues`; it
makes each one ruling-ready per its own process. Zero filings → skip,
silently.

## Present

```
## ok-planner

Status: all supported | N unsupported, M unclear
Compliance: all compliant | N noncompliant

### Surface
<The partition: N elements over K kinds, P public / Q private — and
beside those counts the agentic inventory: the marked kinds out of
all declared kinds, each with what it reads, and any drift the
re-derivation walked ("agentic kinds: none" when nothing is marked).
Then what the opening walk settled, if anything: guidance changes
ratified (sprint-carried acknowledged vs ad hoc confirmed), elements
classified by new guidance, candidate kinds reported. "Settled —
passed silently" when the reconciler exited 0 up front.>

### Determinations
<Counts first: supported / unsupported / unclear out of the total,
split by instrument (measured stories, read decisions and concepts),
and the batch count that produced them. Then, one line each, every
artifact NOT supported: the ref, the one-sentence reason, and its
issue slug. Supported artifacts are a count, not a list — the corpus
is where they live.>

### Harness
<The experiment harness's ledger for this run: re-run / repaired /
built / retired counts, and the promotion candidates the distillation
filed, by path. Omit when no story audit ran.>

### Compliance
<One line per noncompliant artifact: the ref, the rule its body breaks,
and the compliant text. These are mechanical and yours to fix; the run
recorded them and fixed nothing. "All compliant" when there are none.>

### Overturned by the judge
<Every determination the judge flipped to supported, one line each: the
ref and what the auditor missed. This is the run's own error rate, and
it belongs in front of the owner. "None" if the judge confirmed
everything it was handed.>

### Cross-artifact and surface findings
<Every finding from the two whole-corpus passes, each carrying its
advisory mechanical/judgment class. These are reported, never recorded
and never filed. Omit when both passes came back clean.>

### Referrals
<The subjective promises the auditors referred out, enumerated from the
audits' Referrals sections: per referral, the promise, what was
established in form, and the discipline that owns the judgment. These
are artifacts of completion, not work items. Omit when there are none.>
```

## Close-out

The run commits its own output — that is what makes an audit a
statement about a commit rather than about a moment. Two commits, both
the ceremony's own act, covering every estate's audits together:

1. Commit the audit corpora, the surface ruling and extraction, the
   walk's transcriptions into the guidance and the declaration (the
   agentic marks the settle walk added), the committed member lists at
   `.ok-planner/surface/members/`, the experiment harness's changes,
   and any issue files, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field
   and the ruling's `commit` anchor, and make one small follow-on
   commit. Each record then names the commit whose tree holds both the
   code it describes and the record itself — the same shape the sprint
   close-out's `closed:` stamp uses.

**The staleness rule consumers key on:** this run's output paths are
`.ok-planner/audits/`, `.ok-planner/experiments/`,
`.ok-planner/issues/`, `.ok-planner/surface/guidance.md` and
`.ok-planner/surface/surface.json` (the walk's transcriptions,
declaration marks included), and `.ok-planner/surface/members/` (the
derived member lists). The audit is current for a later tree exactly
when the diff from its stamped commit touches only those paths — a
path-scoped diff, no tracked state.

Archive nothing and offer nothing else: this run has no sprint, and the
issues it filed stay in the intake until a planning ceremony closes
them.

## Boundaries

- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded and reported
  for whoever holds the report. There is no fixer, no architect, and no
  cycle cap, because there is no loop.
- Does not run the project's test suites or build it; whether they pass
  is `/certify-work`'s business. The story instrument does execute the
  released product — through elements the ruling classifies public and
  through nothing else.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run; every experiment re-runs
  at this tree.
- Does not touch `.ok-planner/design/`. The corpus's claims are the
  subject under audit, never the thing edited to make an audit pass.
- Writes the declaration and the guidance only as transcription of the
  owner's explicit answers in the opening walk: the guidance rules the
  owner dictates, and — for a kind the walk settles as agentically
  derived — that kind's `derivation`/`reads` mark plus its committed
  member list at `.ok-planner/surface/members/<kind>`, together with
  the drift the owner accepts into that list. It declares no kind and
  revises no enumeration source of its own motion; detection proposes,
  only the owner declares.
- Does not read `.ok-planner/sprints/` or `history/`. Project records
  are out of context.
- Does not ask the owner anything past the opening surface walk — the
  run's one interactive moment. After it, the run audits, judges,
  files, presents, and commits.

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
