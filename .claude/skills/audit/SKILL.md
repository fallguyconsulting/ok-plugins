---
name: audit
description: "ONLY activated by explicit /audit slash command, or run by /document as its measurement front. Never auto-triggered by conversation content. The suite's periodic audit, covering every estate this project has: opens with a short interactive intent stage in which the owner and the run co-author the surface intent at the class level (the reason the ceremony is interactive at all), then autonomously dispatches a surface extractor subagent that reads the just-landed intent and writes the run's surface extraction (filing intake issues where the intent still does not settle an element, and defaulting those elements internal for the run) — followed, only when /document invoked the run, by the documentation walk that settles the declared document types against that extraction — then measures story support from the user's side through the extraction's public elements on the maintained experiments, synthesizes user assumptions cold and measures them on the same instrument, re-reads decisions and concepts against the codebase, hands every escalation to one terminal judge, writes the run report, then commits the audit corpora and stamps the commit. Two determination stages, no loop; run on the owner's cadence, never per sprint."
---

# Audit (the periodic run)

**You are the orchestrator of this run.** You resolve scope, drive
the stages, and dispatch the agents; you determine nothing yourself,
and **you file nothing of your own motion** — the judge, the
distillation, and the surface extractor's intake issues for residual
ambiguity are the run's only filing paths. Anything you would
otherwise stop to tell the owner — a defect you noticed while
driving, an instrument you had to repair, a suspicion about the suite
itself — is an escalation for the judge where it needs a ruling, and
a line in the run report either way; the run's autonomous portion
does not pause to say it. **You walk the owner in the interactive
intent stage at the top of the run** — a short class-level
conversation that produces or updates the surface intent at
`.ok-planner/surface/surface.md` — and, **only when `/document`
invoked the run, once more in the documentation walk** immediately
after the extractor returns; after that the run drives itself. An à
la carte run has the one walk and no other.

The audit runs on the owner's cadence, not at every close.
Certification does not touch audits at all: `/certify-work` runs the
tests, the alignment producers, and code review, and says nothing
about whether a corpus's claims still hold. This verb is where that
question gets asked, over every corpus the project has, and answered.
It is also the documentation ceremony's entire measurement front:
`/document` opens by ensuring a current audit and constructs from the
records this run leaves, measuring nothing itself.

This is a **suite verb**, not any one family's. One canonical body
covers whichever skill families the project integrates, and which those
are is read from the filesystem when the verb runs — never fixed when
it was vendored.

The run makes four determinations:

1. **The surface** — where an estate declares a public-surface
   intent, two sub-stages. First, the **interactive intent stage**
   with the owner: read the current `.ok-planner/surface/surface.md`
   if it exists (summarize it back and ask what has changed) or
   author it from zero, working top-down at the class level ("every
   CLI verb is public", "the foobar module is user-facing") with
   specific exceptions named where they exist, and land the document
   the owner approves (`concept:surface-intent`). Then,
   autonomously, dispatch a **surface extractor subagent**: it reads
   the just-landed intent, walks the
   code and deployment configuration purpose-bound to classification,
   and writes the run's **surface extraction** — one entry per
   element found, with kind discovered by the walk. Elements the
   intent still cannot clearly settle are defaulted internal for the
   run, and the subagent files one intake issue per residually
   ambiguous element asking the owner to amend the intent. The
   autonomous portion does not stall on the owner; the extraction is
   the run's operational surface, stamped with the closing commit.
   When `/document` invoked the run, the **documentation walk** the
   owning contribution defines runs here — immediately after the
   extractor returns and before anything else is dispatched — a
   short owner conversation that reads the extraction's public side
   against the declared document types and lands the deltas
   (`decision:documentation-walk-in-composed-audit`); an à la carte
   run does not run it. Run à la carte, hand the owner one line to
   paste **after the interactive stage lands the intent** — `/goal`
   on the vendored goal file — so everything after it is driven to
   completion hands-free.
2. **Story support, from the user's side** — each story verified by
   driving the released product through the public surface the
   extraction records, on the maintained experiments, per its
   estate's protocol.
3. **Assumptions, formed cold and measured the same way** — once the
   story determinations land, one boxed synthesizer forms the
   user-vantage priors from user-visible material alone, and the run
   measures each on the same instrument as the stories. The claim is
   presumed rather than promised, and that difference governs what a
   contradiction means.
4. **Decision and concept support, from the technical side** — an
   adversarial reading of each claim against the code as it stands.
   The reading track runs in parallel with the measurement track;
   nothing orders them against each other.

Then one **judge** over every escalation — the determinations nothing
could call `supported`, the assumption contradictions, the corpus
contradictions the extraction surfaced, and the orchestrator's own
driving observations — and the run ends. There is no fix loop, no
re-audit, and no third determination stage. The judge is terminal, so
nothing comes back for another pass. What the run leaves behind is a
corpus of current determinations, this run's assumption records with
their dispositions, this run's surface intent (as the interactive
stage landed it) and its surface extraction — and, in a run
`/document` invoked, the document types the documentation walk
landed — the maintained experiments, a run report in the archive, a commit that names
itself, and — where gaps are real, or where the just-landed intent
still did not settle an element — issues in the intake for the owner
to rule on.

## The two axes

Every audit over a corpus artifact answers two independent questions,
on two independent frontmatter axes: **`text:`** — does the artifact's
body comply with its own authoring rules? — and **`implementation:`**
— does the codebase support what it claims, at this commit? Both are
recorded, because they genuinely come apart — a malformed artifact may
be accurately implemented, and a well-formed one may be implemented
nowhere. Only the `implementation:` axis escalates to the judge; a
`text:` defect is mechanical by construction, so it is recorded in the
audit file for whoever reads the corpus to fix. The audit corpus and
the issue intake are independent by construction: where the judge
finalizes an `unsupported` verdict it files an intake issue by the
ordinary intake conventions, and the audit carries no `issue:` field
in either direction.

The support instrument differs by what the artifact claims. A story
promises a user outcome, which reading can only infer — so its
instrument is measurement through the public surface, and it is never
settled by reading or by citing a test. A decision or concept
describes internals no user-vantage run can see — so its instrument is
the adversarial reading. The same two words, the same collection, the
same escalation, a different instrument.

An **assumption** is not a corpus artifact: it is a prior the run
itself synthesized, so it carries no `text:` axis and no `supported`
verdict. Its record carries a **disposition** — `held`, `trap`, or
`unverified` — and a contradicted assumption is documentation, not
work: the judge confirms it as a trap disposition and files nothing,
unless its diagnosis shows a story is also violated, which is a story
finding on the story's own track.

The canonical shape is `{{AUDIT-DEFINITION}}` and
`{{AUDIT-FILE-FORMAT}}` in `../_shared/artifact-definitions.md`. No
citations, no hashes, no line numbers. Every universal an artifact
claims comes back as a count plus the population it was taken from,
because that is the one form of precision a reader can refute in
seconds. Asking whether an audit still holds is a git question — how
far HEAD has moved since the commit it names — not a computation.

## Resolve the estates

Every family's presence is a filesystem check at the project root —
the nearest ancestor of the working directory (itself included)
holding an estate directory, never derived from `.git` and never an
inference:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/audit.md` — the
family's **ceremony contribution**. That file, not this one, says
which collection the family exposes, how its determinations are
shaped, whether and how it rules a surface partition, and what else it
checks; this body never carries family-specific instructions and never
improvises them. A contribution that is missing where its estate
exists is a conformance defect: record it in the run report and carry
on with the rest.

No estate at all → say so and stop; there is nothing to audit.

**`.ok-planner/` is required for this verb.** The audit definition and
file format this body transcludes, the auditor and judge prompts, the
issue-file format the judge files by, and the goal file the walk
hands off are all vendored or materialized by the planner estate's
converge. Without it, say so and stop — a run that cannot record a
verdict or file a confirmed gap is not an audit.

Tell the owner which estates are in scope, and how many artifacts each
contributes, before dispatching anything.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate
   convergence is the front door's administration (`/ok`), never this
   run's.
2. **Resolve the subject.** The run audits the project as it stands.
   Read `git status`; if the tree is dirty, say so in one line and
   audit the working tree as it is — the audits name the commit they
   are recorded in, which is the honest anchor either way.
3. **Surface** — each contribution that declares a surface
   determination runs it now, per its own instructions: two
   sub-stages, the interactive intent stage with the owner (produce
   or update the estate's surface intent at the class level, land
   the document the owner approves) then the autonomous extractor
   dispatch (subagent reads the just-landed intent, walks the code
   and deployment configuration, writes the run's surface
   extraction, files intake issues for elements the intent still
   does not settle — defaulted internal for the run). When
   `/document` invoked the run, a third sub-stage follows
   immediately, before Enumerate: the **documentation walk** the
   owning contribution defines, run against the extraction just
   written; an à la carte run skips it. Everything downstream of
   the surface stage is autonomous — no reconciler tool, no
   committed member lists, no guidance hash, no stamped ruling. Run
   à la carte, hand the owner the `/goal` handoff line naming the
   vendored goal file at `.ok-planner/ceremony/audit-goal.md` **once
   the interactive stage lands the intent**; the run then proceeds
   hands-free whether or not the owner sets the goal.
4. **Enumerate** — each contribution names its live artifacts and the
   feed order, by instrument: measurement items grouped by the
   surface elements they drive, reading items by code locality, so
   consecutive items reuse what a worker already holds.
5. **Determine** — two tracks, run in parallel, each fed through the
   worker pool below: the **measurement track** (story
   determinations; then the cold-boxed assumption synthesis, per the
   owning estate's contribution; then the assumption measurements on
   the same instrument) and the **reading track** (decisions and
   concepts, adversarially read). Workers write their audit files as
   they finish each item. Never a subagent inside a worker.
6. **Judge** — collect every escalation from every estate — each
   determination no instrument could call `supported`, each measured
   assumption contradiction, each corpus contradiction the extraction
   surfaced, and your own driving observations — and dispatch **one**
   judge over the lot. One judge per run, not one per family: its
   independence is what the stage buys, and splitting it by estate
   buys nothing and costs a read.
7. **Distill** — each contribution's nomination filing: the
   experiments this run had to build, passing at the stamp, that
   would have to be maintained to keep. Never a failed run, never an
   opinion of the product.
8. **Verify** — if the judge or the distillation filed any issues,
   each contribution's post-filing step makes them ruling-ready. Zero
   filings → skip, silently.
9. **Report** — write the run report into the planner estate's
   archive at `history/audits/<date>-<sha>-report.md`, per the shape
   the contribution defines: the receipt facts (per-estate artifact
   counts and dispositions, issues filed by path, the two shas) and
   the run narrative (dispatches, judge outcomes, diagnoses, worker
   retirements, and every observation you accumulated while driving).
   The report is a record, never a channel: nothing lives only there —
   everything durable is in the corpora and the intake — and it is
   never read to understand the project.
10. **Close-out** — commit, then stamp.
11. **Present, then stop** — only when the run was invoked à la
    carte: compose the owner's wrap-up **from the run report**, in
    the shape the contribution defines, so a long run presents from
    what it wrote while fresh rather than from summarized context.
    The wrap-up closes on a receipt — the run is complete and
    committed, the two shas, the report's archive path — and the turn
    ends there. Nothing is offered after it, because the close-out
    already committed and stamped and the report is already in the
    archive. Invoked by `/document`, the run ends silently at the
    stamp and `/document`'s own wrap-up covers both, reading the same
    report as an input.

## The worker pool

Where the harness supports cross-agent messaging, each Determine track
runs as a pool: spawn N workers per instrument once, then feed each
worker one artifact at a time by message, routed so consecutive items
land on the worker already holding the relevant code or surface
elements. Each worker writes its audit file per item on completion and
reports one line back.

Retirement is by measured context. Each task notification carries the
worker's token count (`subagent_tokens`) — a per-request measure of
the context the worker is actually carrying, not a running tally.
**Retire a worker when it finishes an item and its last round exceeded
~300k tokens**, spawning a replacement so N holds. The threshold
assumes a 1M-token window — roughly 30% — and scales proportionally on
smaller windows. A worker gone quiet is not a finish: that is a
liveness problem — stop it and redispatch its item — never a
retirement.

Where the harness lacks cross-agent messaging, fall back to bounded
batches: stories and assumptions grouped by the surface elements they
drive, decisions and concepts by code locality, five to ten per batch,
splitting any batch whose shared reading set is too large for one
agent to genuinely hold and read.

## The close-out

The run commits its own output — that is what makes an audit a
statement about a commit rather than about a moment. Two commits, both
this verb's own act, covering every estate's audits together:

1. Commit the audit corpora, this run's assumption records, each
   estate's surface extraction, the document types a composed run's
   walk landed, the experiments' changes, the run report, and any
   issue files, with a message naming the run and its counts.
2. Stamp that commit's short sha into every audit's `commit:` field —
   into each extraction's `commit` field, and into the run report's
   name and body — and make one small follow-on commit. Each record
   then names the commit whose tree holds both the code it describes
   and the record itself.

**The staleness rule consumers key on.** The audit is current for a
later tree exactly when the diff from its stamped commit touches
only the run's own output paths — the audit corpora and assumption
records, each estate's surface intent (the interactive stage's own
output) and its extraction, the document types a composed run's
walk landed, the experiments, the issues it filed, and the run
report in the archive, as each estate's contribution enumerates
them. A path-scoped diff, no tracked state. An edit to
the surface intent between audits (the owner amending it directly)
moves the tree on the same rule as any other output-path edit. This
is how `/document` (and an owner running audit-then-document) avoids
paying the measurement twice: the audit's own committed outputs
move the tree, but the diff shows that nothing the audit measured
changed.

Archive nothing else and offer nothing else: this run has no sprint,
and the issues it filed stay in the intake until a planning ceremony
closes them. Both commits are the run's own act and land before the
presentation, so the owner is never asked to authorize either — they
are reported in the presentation's receipt instead.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes
  from the ceremony contributions in the estates present, and nothing
  else.
- Does not fix anything. A real gap becomes an issue for the owner to
  rule on and a sprint to close; a form defect is recorded in the
  audit file. There is no fixer, no architect, and no cycle cap,
  because there is no loop.
- **Does not file. You file nothing of your own motion.** The judge,
  each contribution's distillation, and the surface extractor's
  intake issues for residual ambiguity are the run's only filing
  paths. A defect you discover while driving — in the project, in an
  estate, or in your own instruments — is an escalation for the
  judge and a line in the run report, and enters the intake only if
  the judge confirms it. What enters the intake is gated, and a file
  you create on your own motion pre-empts the owner under the
  appearance of bookkeeping.
- Does not run the project's test suites or build it; whether they
  pass is `/certify-work`'s business. The measurement instrument does
  execute the released product — only through elements the run's
  extraction records public, per each estate's protocol.
- Does not compute staleness, maintain a re-audit set, or track what
  changed. Every artifact is read every run; every experiment re-runs
  at this tree; the assumption set is re-synthesized whole; the
  extraction is re-derived whole. The path-scoped currency rule is a
  question a consumer asks of git, not state this run maintains.
- Does not edit any corpus. The corpora's claims are the subject under
  audit, never the thing edited to make an audit pass.
- **Writes the surface intent only through the interactive intent
  stage.** The intent is the owner's authority; the interactive
  stage co-authors it with the owner in-session, and the autonomous
  extractor never writes it — it reads the just-landed intent,
  records the join, and files intake issues where the intent still
  does not settle an element.
- Does not read project records — sprints, sketches, history. The run
  report it writes is append-only output into the archive, not a
  license to read what lives there.
- **Asks the owner only in the surface stage.** The interactive
  intent stage — a short class-level conversation that lands the
  surface intent — is an à la carte run's one owner walk; a run
  `/document` invoked adds the documentation walk right after the
  extractor returns, and nothing else. Everything downstream is
  autonomous. Presentation happens once, at the end, from the
  report, and only when the run was invoked à la carte.
- **Does not roll into follow-on work.** The presentation ends on the
  receipt and stops. Proposing a sprint, offering to fix a gap or
  close an issue, offering to archive or commit anything further, and
  asking what to do next all re-open a run that is finished. The gaps
  it found are issues in the intake, for the owner to rule on and a
  planning ceremony to close.
- Does not converge an estate, materialize a file, or repair a
  family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
