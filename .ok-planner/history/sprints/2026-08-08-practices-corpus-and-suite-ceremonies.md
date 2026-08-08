---
closed: ec7e6d3c5a944d751a01779ab402092f7debcb50
---
# Sprint: Practices corpus and suite-level ceremonies

## Intent

Three unrelated bodies of work, taken together because the second and
third depend on each other and the first was already ruled.

First, corpus deltas are settled in their final-form shape: every
edit is resolved fully during planning and carried as a complete
body, with a sidecar folder beside the sprint for large bodies. This
closes the ruled issue `corpus-deltas-cannot-express-a-revision` by
declining the revision form — review and fix are part of the sprint,
and the divergence and escalation mechanisms already cover an
artifact change that only becomes apparent during the work.

Second, ok-plumbline gains a durable corpus of its own — **subjects**
(named, enumerable populations of code constructs) and **practices**
(affirmative statements of what the codebase does about a subject's
members). This is the structure and the machinery only: no discovery
pass, no pattern library, no lint enumeration of a subject's members,
and nothing about any particular language, serialization format, or
schema tool baked into any skill, template, or guidance.

Third, planning, certification, and audit become suite-owned verbs
scoped by which estates a project has, rather than planner-owned verbs
the other families must duplicate. The two audit verbs collapse into
one: the compliance reporter folds into the periodic audit, which
always writes, and reports two independent axes — whether an artifact
complies with its authoring rules, and whether the codebase supports
what it claims.

Issues promoted into this sprint:
`corpus-deltas-cannot-express-a-revision`,
`workspaces-src-tag-payload-fails-consumer-plumbline-lint`.

## Corpus deltas

### Amend concept: corpus-delta

```markdown
---
concept: corpus-delta
aliases:
  - delta
---

# Corpus delta

## What it is

A corpus delta is one unit of change to the design corpus as carried inside a sprint: a final-form artifact body — a complete concept, story, or decision file content — under an operation heading declaring it new, an amendment, or a retirement. A sprint whose delta bodies are large may carry them in a sidecar folder beside the sprint file, one file per artifact, with each delta heading pointing there; the sidecar is part of the sprint and archives with it. Applying a delta IS updating the corpus: the implementer copies the final form into place, or removes the artifact for a retirement.

## Purpose

Deltas make corpus mutation reviewable and mechanical at once. The owner signs off on exact final text during planning; the executor applies it verbatim with zero interpretive latitude, so the corpus after execution matches what was approved, not a paraphrase of it.

## Boundaries

A delta owns the complete post-change state of exactly one artifact. It is NOT a diff, a summary, or a partial edit — summarized or partial deltas are non-compliant, and no delta carries a base pin or a machine-checked derivation (see also: final-form-deltas under decisions). Deltas exist only inside sprints (see also: sprint); the corpus they mutate is the design corpus (see also: design-corpus). Verification that deltas were applied verbatim belongs to the completion contract and the certification gate (see also: completion-contract).

## Invariants

- Every delta is final-form: everything needed to apply it is in the sprint or its sidecar, and applying it requires no consultation of the queue or history.
- Retirement via delta is the only sanctioned way an artifact leaves the live corpus.
```

### New decision: final-form-deltas

```markdown
---
decision: final-form-deltas
---

# Corpus edits are resolved fully during planning

## Choice

A corpus delta carries the complete final-form artifact body, resolved fully during the planning ceremony, and execution applies it by copying the body into place or deleting the file. A sprint whose delta bodies are large carries them in a sidecar folder beside the sprint file, archived with it. No delta carries a diff, a base pin, or any machine-checked derivation.

## Rationale

Review and fix are part of the sprint, and the suite's design posture is to trust its adversarial reviewers rather than add mechanical constraints beside them. A derivation or base check would hard-stop exactly the sprint where an artifact legitimately needs a change that only became apparent during the work — and the suite already has the two mechanisms for that case: divergences surfaced in the certification presentation for after-the-fact veto, and issue escalation for genuine forks. Whether the applied corpus is coherent with the live corpus is the certification gate's alignment producer's business, which reads rather than pins. The sidecar keeps a large sprint readable without changing the delta's shape: the body is the same final form, carried in its own file.

## Alternatives

- Revision-bearing amendments — a base stamp, the revision as anchored edits, and a resulting body derived from the two. Reviewable at the size of the change, but it needs a diff derivation both sides trust and halts execution on any base movement, including the legitimate mid-work artifact change.
- A bare base checksum with a halt, no diff — closes the silent-revert case alone, at the same hard-stop cost.
- Diff-only deltas applied at execution — cheapest to author, and it moves interpretation to apply time, where the completion contract's file-equality check stops being a comparison.
```

### New concept: subject

```markdown
---
concept: subject
---

# Subject

## What it is

A subject is a named, enumerable population of constructs in a
codebase that a project has something to say about. Its members share
a need; what the project does about that need is what its practices
state. A subject says what its members are and how they are found, so
a reader can enumerate the population and settle claims about it by
counting rather than by impression.

## Purpose

Naming the population apart from the policy is what stops policies
from each smuggling in an unstated universal and colliding over a set
nobody defined. It also puts every claim about adoption on a footing
that can be refuted cheaply: coverage is a count against an enumerated
population, not an assurance.

## Boundaries

A subject says what its members are; it never says what should be done
about them, which is its practices' territory (see also: practice). It
is not a noun of the product's own domain (see also: concept-artifact):
a concept says what a kind of thing is, a subject says which
constructs in this codebase are to be accounted for.

## Invariants

- A subject is admissible only if its members can be enumerated; a
  population nobody can list carries no coverage claim.
- The practices covering a subject account for its whole population: a
  member no practice claims is a gap, and a member claimed by two
  practices whose conditions conflict is a collision.
- Gaps and collisions are questions for the project owner, never
  settled by ordering, recency, or a reviewer's preference.
```

### New concept: practice

```markdown
---
concept: practice
---

# Practice

## What it is

A practice is an affirmative statement of what a codebase does about
some members of a subject: what the code is, the condition under which
the practice governs, and the maintenance operation the practice buys.
Practices are cited from the sites they govern, so a reader meeting a
construct finds the practice that accounts for it instead of
re-deriving the intent.

## Purpose

Stating policy affirmatively makes a departure a claim rather than a
hole. A site that does not follow one practice is governed by another,
and which one applies is something a reviewer can check and can be
wrong about — where silencing a check asserts nothing and so can never
be refuted.

## Boundaries

A practice governs members of exactly one subject and never names the
population itself (see also: subject). It states what the codebase
does, not how well it does it: a practice whose benefit only taste can
settle is a style preference and belongs to formatting. Its
verification is coverage over its subject rather than a per-artifact
verdict (see also: finding).

## Invariants

- Every practice names the maintenance operation it buys, concretely
  enough that a reader can settle whether that operation holds.
- Every practice names the condition under which it governs, so a
  reader can tell which of a subject's practices applies to a member
  without asking its author.
- Where more than one condition matches a member, the more specific
  condition governs; equally specific conditions that conflict are a
  collision for the owner, not a precedence puzzle.
- A practice is never written as an exception to another practice, and
  no site is exempted by suppression.
```

### New decision: affirmative-practices-over-exemptions

```markdown
---
decision: affirmative-practices-over-exemptions
---

# Coding policy is affirmative practices over named subjects

## Choice

A project's coding policy is expressed as practices over named
subjects, every one of them affirmative. A site that departs from one
practice cites a different practice whose condition covers it; no
mechanism exempts a site without asserting something in its place.
Where more than one practice's condition matches, the more specific
condition governs.

## Rationale

An exemption marker asserts nothing, so nothing about it can be wrong,
and any agent that finds a check inconvenient can silence it — the
same judgment-call seam the lint methodology already removed once when
it replaced its tag vocabulary with structural exemptions. A competing
practice is a falsifiable claim about the site, so a departure changes
which policy is checked rather than removing the site from
enforcement.

Specificity as the resolution rule is what keeps the corpus additive.
A new practice re-partitions its subject without amending the
incumbents, so no artifact ever acquires a negative "except" clause and
adding one policy is never an edit to the others. The case the rule
does not settle — two equally specific conditions — is exactly the
ambiguity the owner should be ruling on, and it surfaces as a
collision rather than being resolved by whichever practice was written
first.

## Alternatives

- One rule per subject plus suppression markers at exempt sites —
  cheap, and unfalsifiable at exactly the sites that most need
  scrutiny.
- Explicit precedence ordering between practices — settles conflicts
  mechanically, and hides genuine ambiguity behind an ordering nobody
  reviewed.
- Prohibitions rather than affirmations — familiar from linters, but a
  prohibition cannot be cited at a site to explain what the code is
  doing instead.
```

### New decision: violations-are-remediation-not-issues

```markdown
---
decision: violations-are-remediation-not-issues
---

# Practice violations are work; only ambiguity reaches the intake

## Choice

A site that departs from the practice governing it is remediation work
carried by ordinary planning, never an entry in the issue intake.
Three things from a coverage run become issues instead: a gap, a
collision, and a site whose governing practice could only be
established by tracing beyond the point of use. The escalation flag is
the cost of determining the violation, not the size of the fix.

## Rationale

The intake exists for questions requiring the owner's judgment. A
ruled practice has already had that judgment, so a site that departs
from it poses no question — filing it would flood a judgment queue
with work nobody needs to decide, and the queue would stop meaning
what it means.

Keying escalation to determination cost rather than fix size inverts
the usual instinct, and the inversion is the point. A large but obvious
rewrite needs a worker, not a ruling. A site whose governing practice
can only be established by tracing is a site whose intent is not
legible from the code, and illegibility is precisely what an owner has
to settle. It also asks the reviewer only for something it knows
exactly — how it reached its own conclusion — rather than for a
prediction about effort, which it estimates badly.

## Alternatives

- File every violation as an issue — durable, and it destroys the
  intake's meaning within a run or two.
- Escalate by fix size or estimated risk — matches intuition, and
  rests on an estimate the reviewer is poorly placed to make.
- Let the coverage run fix what it judges straightforward — closes the
  backlog fastest, and puts an unreviewable whole-codebase diff behind
  a judgment the run has no scope to check.
```

### New decision: suite-owned-ceremonies

```markdown
---
decision: suite-owned-ceremonies
---

# Planning, certification, and audit are suite verbs scoped by estate

## Choice

Planning, certification, and audit are suite-owned verbs rather than
any family's: one canonical body each, vendored into consumer projects
like every other skill, covering whichever estates the project has.
Which estates those are is read at invocation from the filesystem
markers, never fixed at vendoring time. Each family contributes its
ceremony-specific instructions from inside its own directory, as a
conventional surface the ceremony drives — the counterpart, on the
ceremony axis, of the administration surfaces the front door drives.

## Rationale

The suite had already hoisted one axis this way: families expose no
administration verbs of their own, because administration is what the
front door does by driving conventional surfaces. Ceremonies were the
axis that had not been hoisted, and the cost showed in the collision
rule — three families each claiming `audit`, materializing
family-prefixed, leaving the owner to know which family owns which
verb and to run the same ceremony once per family.

Reading estate presence at invocation rather than at vendoring keeps a
project correct after it adopts a family later, without a converge in
between. Keeping the ceremony body thin and delegating to per-family
surfaces is what stops every project from vendoring every family's
instructions: a skill body is context an agent pays for on every read,
which is why the contract already keeps unrelated content out of one.

## Alternatives

- Ceremonies stay family-owned and each family implements its own —
  no new contract surface, and the owner runs three ceremonies and
  reconciles them.
- Ceremonies live in the front-door plugin rather than being vendored
  — simplest to maintain, and it breaks self-containment: a clone with
  nothing installed loses its ceremonies.
- One hoisted body carrying every family's instructions inline —
  no per-family surface to design, paid for in context on every read
  in every project, whether or not the family is present.
```

### Amend decision: adversarial-implementation-audits

```markdown
---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project supports what a story or decision claims is
determined by an adversarial implementation audit: a per-artifact
determination — `supported`, `unsupported`, or `unclear` — recorded in
a fourth corpus collection, written only by the periodic audit run and
never by the session that implemented the work, and never hand-edited.
The same run also checks each live artifact against its own authoring
rules and the integrity of the annotations pointing at it. The
compliance finding and the support determination are independent and
both are recorded: a malformed artifact may be accurately implemented,
and a well-formed one may be implemented nowhere. Where a family's
artifacts are governed by coverage over an enumerated population
rather than by a per-artifact verdict, its determination takes that
shape — the count checked, the population it was enumerated from, and
the members not accounted for — and the run's stages and its refusal
to fix are the same either way.

An audit is a statement about a **named commit** rather than a standing
verdict: its frontmatter carries the commit it describes, so whether it
still holds is a question about how far the tree has since moved, and
nothing computes that. The audit body is one sentence to one paragraph
saying what was looked at and what was found, broad rather than
exhaustive, carrying no citations, hashes, line numbers, or pasted
code. Where the artifact quantifies over a population, the audit
reports the count it checked and the population it enumerated from —
the one precision a reader can refute in seconds. Where a claim is
implemented in code, the audit asks whether a test in the project's
ordinary suites exercises it end-to-end and says so; whether that test
passes is the change gate's business. Qualitative clauses ground no
determination: each becomes a referral naming the promise, what was
established in form, and the discipline that owns the judgment. The
run has two stages and no loop — auditors read every live artifact in
parallel batches, and everything they could not call `supported` goes
to one second-opinion judge that confirms it, overturns it, or calls it
undecidable, filing an intake issue in the first and third cases. The
judge is terminal, and neither stage fixes anything. A determination of
`unsupported` or `unclear` must name its issue; a deterministic checker
enforces that, the audit file's shape, and its one-paragraph bound, and
nothing else.

## Rationale

The claims that go wrong in practice are disproportionately
structural, negative, or quantified — a transport a decision's text
never reached, a rationale selling a property nothing delivers, an
"every" enforced on the members someone remembered — and for those the
honest verification is an adversarial reading against reality, with the
population enumerated from the filesystem or the route table rather
than from the artifact's own examples. Mandating a test per claim buys
determinism at the cost of test-side machinery per claim and still
misses the claims that are not runtime-observable; an audit covers
every decidable claim at the cost of trusting a reader, and that trust
is bounded three ways: the reader is never the author of the work, an
independent judge re-reads everything the reader could not affirm, and
the determination names a count and a population a later reader can
refute cheaply.

Folding the form check into the same run follows from the two axes
being independent. A separate read-only reporter answered a question
whose findings are transient by nature — a recorded form defect is one
somebody chose not to fix — while charging a second whole-corpus read
for it, and it left the owner with no durable record of the axis it
covered. Running both in one pass costs one read, records both, and
keeps the two determinations from being mistaken for each other.

Pinning an audit to a commit rather than to the code it describes is
what keeps the cost proportionate. A citation-and-hash tripwire buys
precise invalidation and charges for it twice: a monolithic file cited
by many audits re-opens all of them for an edit that concerns one, and
each re-opening costs an agent a read. Naming the commit instead makes
freshness a question anyone can answer with git, and makes upkeep a
single periodic sweep priced by the corpus rather than by how often
unrelated code moves. A broad paragraph is the same trade: the audit's
job is to tell a reader whether the claim holds and what was looked at,
not to reproduce the evidence, and precision nobody will refute is not
precision. Determinations stop at the decidability line because an
adversarial re-audit against quality prose never converges — there is
always one more sense in which an explanation might fall short — so
qualitative clauses become referrals marking where this process's
jurisdiction ends. The run refuses a fix loop for the same reason it
refuses staleness: a loop whose own fixes invalidate its measurements
cannot converge, so the judge's third outcome is filing an issue and
the run ends there.

## Alternatives

- Test mandates with a registered failure exhibit per claim —
  deterministic and unfoolable where it applies, but a per-claim
  authoring and maintenance layer, and structurally blind to claims
  that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same
  class once, but leaves nothing behind for the next reader to compare
  against or refute.
- A separate read-only compliance reporter beside the audit — keeps a
  no-write check available, at the cost of a second whole-corpus read
  and a class of finding no record survives.
- Citations pinned by content hash, with a mechanical stale set and a
  judged inspection layer above it — precise about what a change puts
  in question, at the cost of re-opening every audit that happens to
  name a file an unrelated edit touched, each re-opening priced as an
  agent's read.
- Auditing at every change close rather than on a cadence — catches
  drift sooner, but pays the whole corpus's read price per sprint and
  re-runs against a target its own fix loop keeps moving.
- A fix loop inside the audit run — closes gaps in the same pass, but
  every fix invalidates the reads already taken, so the run either
  re-audits repeatedly or reports measurements its own edits voided.
- An auditor licensed to run tests and experiments — settles some
  claims first-hand, at the cost of corrupting the state under
  judgment and leaving the evidence unrecorded.
- Forbidding qualitative language in artifacts so every clause is
  mechanically auditable — a corpus made clean by silencing intent;
  the decidability boundary handles it instead by referring such
  clauses out.
```

### Amend decision: audit-audience-split

```markdown
---
decision: audit-audience-split
---

# The audit records its findings; the intake is reached only through gated writers

## Choice

The audit writes its own determinations and nothing else: the
per-artifact records of the two axes it checks, into the corpus
collection that holds them. It writes no code and no design artifact,
and it fixes nothing. Its findings reach the human who invoked it in
context as well, each classified mechanical or judgment. Test runs are
the project's ordinary suites, run by whoever is executing work or by
the certification gate; their failures are findings for the executing
agent, in context, never intake rows. An agent reaches the intake
through exactly three gated paths and no others: certification's
architect, filing only findings that survived the fixer's veto test and
its own adversarial check; the cycle cap's escalation, which files the
remainders a bounded fix loop tried and failed to drive to clean —
reachable only once the cap is hit, taken only on the owner's word, the
run stopping at the cap and waiting for their direction however long
that takes; and the periodic audit's second-opinion judge, filing only
what an independent read confirmed as a real gap or found undecidable
from the artifact's own text, and made ruling-ready before it becomes
owner agenda. Those gates govern the repeating cycle's
findings, not the intake's whole membership — humans file directly
whenever they choose, the ceremonies that transcribe the owner's own
questions file directly, and so does the one-time corpus bootstrap,
whose review loops surface findings in the defined sense and file them
ungated by design: the queue is what the owner invoked that run to get,
and a run that aborts rather than repeat over a populated corpus cannot
accumulate against the owner. The owner's durable agenda is a property
of those gates, never of how much the audit records: the architect's
path is bounded by adversarial confirmation before anything costs owner
attention, the cap's by exhaustion and the owner's word, and the
judge's by a second independent read of a determination the first
reader would not affirm. Deduplication against the slugs already
present is the standing discipline of every writer into the intake, the
gates included.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an
executing agent needs findings now, in context, at machine tempo,
while the owner's queue must stay an owner-calibrated worklist. What
bounds the queue is which paths may write to it, not whether the audit
keeps a record of what it saw — an audit that records determinations
in its own collection costs the owner nothing to ignore, while an
audit that filed its findings as questions would be an ungated writer
inside a repeating cycle, growing the queue run after run without
anything checking that a reasonable owner would want to read it. The
gated paths bound that growth in different ways and each bounds it —
the architect's by adversarial confirmation, the cap's by exhaustion
and the owner's word, the judge's by an independent second read that
overturns as readily as it confirms: a remainder is filed only after a
bounded loop has failed to fix it and the owner chooses the wrap-up
over another cycle, which makes it rare by construction and makes the
filing the alternative to losing the finding altogether when the owner
closes a capped run. The corpus bootstrap files ungated without
defeating that, because it sits outside the repeating cycle — one
owner-invoked adoption run that refuses to run again over a populated
corpus, and the queue of judgment questions it hands back is the
outcome the owner invoked it for rather than a cost imposed on them. A
standalone audit's judgment findings still reach the owner: the human
who ran it is holding the report, and reading it is the calibration
act — what they judge fork-worthy, they file.

## Alternatives

- The audit writing the intake directly — the intake stops meaning
  "requires owner calibration" by construction, growing run after
  run inside the repeating cycle.
- The audit writing nothing at all, reporting only in context —
  keeps every write gated, and leaves no durable record of either
  axis for the next reader to compare against.
- The audit filing its own judgment class — preserves a durable
  agenda from standalone runs, but reintroduces ungated agent writes
  and duplicates the promotion gate's dedup and confirmation outside
  it.
- Routing the audit judge's confirmed gaps through the architect too,
  keeping certification the single writer — buys nothing the judge's
  own independent read does not already provide, and puts a
  change-scoped reviewer in front of a whole-corpus determination it
  has no scope to weigh.
- Routing cap remainders through the architect too, keeping one
  writer — buys an adversarial check the remainders cannot pass by
  construction, since a remainder is a finding the fixer failed to
  fix rather than one it kicked back as a fork, and the check's own
  rule is that inability is never grounds.
- Escalating by default on an unattended capped run — keeps the run
  moving without the owner, at the cost of making the cap's choice
  for them: the sprint wraps up in their absence and resuming the
  remainders costs a fresh planning ceremony, when waiting — however
  long — lets them finish the sprint in flight.
```

### Amend concept: integration-contract

```markdown
---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set
of conventions by which every skill family meets a consumer project, by
which the front door administers them all, and by which the suite's
ceremonies cover them all. It defines the layers of a family's presence
— the committed project-side estate whose existence is the discovery
marker, the always-in-context rules cheatsheet, the vendored skill set
in the project's committed skills directory, and hook wiring transcribed
into the project's committed harness settings — plus each family's
conventional surfaces (a deterministic converge core and an
administration document for the judgment the core cannot encode, and a
ceremony surface carrying what planning, certification, and audit need
to know about that family's corpus), the ownership rule, the vendored-name
collision rule, version stamps, and stack tailoring.

## Purpose

The contract is what keeps the suite composable as it grows: family
knowledge lives in the family's own directory at the contract's
conventional surfaces, so the front door — the term names the
administrator plugin, and this Purpose is its canonical definition —
administers every family by driving those surfaces, and the suite's
ceremonies cover every family by driving theirs. Adding a family means
adding a conforming directory, never rewriting the administrator and
never editing a ceremony. The front door is the suite's sole
administrator, and administration is one process: install, converge,
repair.

## Boundaries

The contract governs how families meet consumer projects, how the front
door administers them, and how the suite's ceremonies reach them; it
does not govern any family's interior behavior, and the user-scoped
plugins — the front door and the conduct — never integrate, so it does
not govern their presence on a machine. Repo-root machinery — the
marketplace catalog, the contract's own document, the release tooling,
the maintenance checks — is maintenance material and part of no plugin
or family. Its layers are realized by neighboring concepts:
skill-family, estate, cheatsheet, skill, true-up, materialized-artifact,
stack-profile. "Front door" has no concept of its own — this artifact
defines it. The front door's own conduct is the contract's consumer-side
realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every family exposes the conventional surfaces the suite drives —
  administration and ceremony alike; families expose no administration
  verbs of their own, and no ceremony verbs of their own.
- Vendored verb names collide by rule, never by accident: a verb name
  claimed by more than one integrated family materializes
  family-prefixed.
- Whether a project uses a family is a filesystem check, never an
  inference, and it is answered when a verb runs rather than when it
  is vendored.
- Every discovery marker the front door honors is documented in the
  contract; the contract, not the administrator's prompt, is where the
  convention lives.
- Nothing in any family may assume a specific consumer project, and
  nothing a family materializes into one may depend on a declaration
  that project has not made.
```

### Amend concept: skill-family

```markdown
---
concept: skill-family
aliases:
  - family
---

# Skill family

## What it is

A skill family is the suite's unit of project-scoped distribution: a
self-contained directory of skills, templates, support scripts, and the
conventional surfaces the suite drives, carried whole as payload inside
the front-door plugin and delivered into consumer projects as committed,
vendored files. A family is not a plugin: nothing family-scoped installs
machine-globally, and consumers meet a family only through its vendored
presence in their project.

## Purpose

The family is the shape that gives every project its own version of the
suite's behavior: installing one user-scoped plugin puts every family's
canonical source on the machine, and each project owner converges
deliberately from that payload. It also fixes where knowledge lives —
everything specific to a family, from converge mechanics to migration
judgment to what its corpus needs from a ceremony, belongs to the
family's own directory, so the suite grows by adding a conforming
directory rather than by editing its administrator or its ceremonies.

## Boundaries

A family owns its skills, its estate's shape, its cheatsheet, and its
conventional surfaces — administration and ceremony (see also: estate,
cheatsheet, skill, true-up). It does NOT own its own delivery:
vendoring, wiring, and upkeep are the front door's administration,
driven through the contract's conventional surfaces (see also:
integration-contract, one-command-suite-upkeep under stories). It does
NOT own the ceremonies that reach its corpus: planning, certification,
and audit are suite-owned verbs that drive the family's ceremony
surface. The plugin system carries only the user-scoped plugins — the
front door that carries the families, and the personal conduct (see
also: conduct).

## Invariants

- Families travel only as front-door payload and reach projects only by
  vendoring; no family is separately installable.
- Every family exposes the contract's conventional surfaces, and
  family-specific knowledge lives nowhere but the family's directory.
- Whether a project uses a family is a filesystem check against its
  committed markers, never an inference.
```

### Amend concept: finding

```markdown
---
concept: finding
---

# Finding

## What it is

A finding is one defect surfaced by any of the suite's review passes —
compliance review, coverage and drift checks, code review, the
alignment judge, the practice-coverage run — stated so that whoever
receives it can act on it without re-deriving it: what is wrong, where,
and what a correct state would be.

## Purpose

Naming the unit is what lets every pass feed one disposition instead of
each inventing its own. A finding is routed, not merely reported: fixed
in cycle, carried as work, or escalated as a question — and which of
those it is follows from what the finding is, not from which pass
produced it.

## Boundaries

A finding is a defect against something already decided — a rule, a
commitment, a ruled practice. A question the project has not decided is
not a finding but an issue (see also: issue). A finding whose
disposition is ordinary work is carried as work, never filed as a
question (see also: practice).

## Invariants

- Every finding names what a correct state would be, not only what is
  wrong.
- No pass routes its own findings to the owner's agenda; routing
  belongs to the gate or ceremony that received them.
```

### New story: record-coding-practices

```markdown
---
story: record-coding-practices
---

# Record what the codebase does, citably

## Story

As a project owner, I want the policies my codebase follows recorded as
citable artifacts that name the population they govern and the
condition under which each applies, so that an agent editing a file can
tell which policy accounts for a construct without asking me.
```

### New story: practice-coverage-report

```markdown
---
story: practice-coverage-report
---

# See how far a practice actually reached

## Story

As a project owner, I want each subject's population enumerated and
every member not accounted for by a practice listed, so that I can see
how far adoption reached instead of trusting an impression of it.
```

### New story: one-ceremony-per-project

```markdown
---
story: one-ceremony-per-project
---

# One ceremony covers every family a project has

## Story

As a project owner whose project integrates more than one family, I
want planning, certification, and audit each to reach every estate I
have, so that I neither repeat the same ceremony once per family nor
have to track which family owns which part of it.
```

### Amend story: corpus-audit

```markdown
---
story: corpus-audit
---

# Audit the corpus and record what was found

## Story

As a project owner, I want one periodic audit that checks every
family's durable artifacts against their authoring rules and against
what my codebase actually does, recording both, so that drift becomes a
record I can act on later rather than an impression I have to
re-derive.
```

## Work items

- State the final-form delta shape and the sidecar in the corpus-delta
  authoring rules and the sprint document's delta section: every delta
  a complete body resolved during planning, a sprint with large bodies
  carrying them in a sidecar folder beside it, archived with the
  sprint. No diff, no base pin, no derivation tooling. Realizes
  `final-form-deltas`, `corpus-delta`.

- Author the subject and practice artifact definitions and templates in
  ok-plumbline's family directory, as that family's canonical authoring
  rules. No language, format, or tooling specifics appear in them.
  Realizes `subject`, `practice`, `affirmative-practices-over-exemptions`.

- Give ok-plumbline's estate its subjects and practices collections and
  their catalog tables of contents, on the same shape the design corpus
  uses. Realizes `record-coding-practices`.

- Declare the subject and practice citation tags in ok-plumbline's
  config so the lint resolves a cited slug structurally and fails on one
  that does not resolve. Realizes `record-coding-practices`.

- Update ok-plumbline's cheatsheet so every session in a consuming
  project knows how to read, cite, and author subjects and practices,
  and knows that a departure cites a competing practice rather than a
  suppression. Realizes `record-coding-practices`,
  `affirmative-practices-over-exemptions`.

- Make planning, certification, and audit suite-owned verbs: one
  canonical body each, vendored into consumer projects, resolving which
  estates are present at invocation. Realizes `suite-owned-ceremonies`,
  `one-ceremony-per-project`, `integration-contract`, `skill-family`.

- Define the conventional ceremony surface a family exposes, as the
  counterpart to the administration surfaces, and give ok-planner,
  ok-plumbline, and ok-workspaces each a conforming one. Realizes
  `suite-owned-ceremonies`, `skill-family`.

- Collapse the two audit verbs into one that always writes: fold the
  compliance reporter's artifact-form and annotation-integrity checks
  into the periodic audit run, record the compliance axis and the
  support axis independently per artifact, and retire the separate
  reporter verb and its family-prefixed name. Realizes `corpus-audit`,
  `adversarial-implementation-audits`, `audit-audience-split`.

- Extend the deterministic audit checker to the two-axis determination
  shape and to the coverage-shaped determination, keeping its scope to
  file shape and the rule that a non-supported determination names its
  issue. Realizes `adversarial-implementation-audits`.

- Implement ok-plumbline's coverage determination for the audit run:
  enumerate a subject's population, report the count, the population it
  was enumerated from, and the members no practice accounts for, and
  file only gaps, collisions, and sites whose governing practice could
  not be established at the point of use. Realizes
  `practice-coverage-report`, `violations-are-remediation-not-issues`,
  `subject`.

- Make certification's change-scoped pass check that constructs it
  introduced or touched carry a practice citation where a subject
  claims them, and cite one as part of the same change. Realizes
  `record-coding-practices`, `violations-are-remediation-not-issues`.

- Make every file the families materialize into a consumer project
  stand on its own there: no prose comments beyond what the machine
  requires, and no citation whose slug depends on a declaration the
  consuming project has not made. The src-tag payload that currently
  fails a consuming project's lint is the known instance; the outcome
  is that no materialized file depends on such a declaration, and no
  consumer carries an exemption for one. Realizes
  `integration-contract`.

- Update the integration contract document for the ceremony surface,
  the invocation-time estate resolution, and the collapsed audit verb.
  Realizes `integration-contract`, `suite-owned-ceremonies`.

- Update every reference across the suite's skills, cheatsheets, and
  shared definitions that names a renamed or retired verb, so no
  vendored body points at a verb that no longer exists. Realizes
  `suite-owned-ceremonies`, `corpus-audit`.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work into a task list. The items above are a flat,
   unordered list; group them by theme, file surface, or dependency,
   order the groups so nothing is built on something not yet there,
   and build the list in your own working state — the harness's task
   tracking where available, one entry per stage; an orchestrator
   uses its own graph. Seed the closing entries up front — finish
   the completion report, run `/certify-work` with this sprint's
   path as its argument, clear this task list just before the
   presentation (complete or remove every remaining entry, so a
   stale list does not linger past the run), walk the presentation,
   offer archive-and-commit — so the ceremony is a
   standing unchecked item from the first minute, not a memory to
   retain past a long run. Staging is never rewritten into a plan
   document: this sprint is the whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim
   (from the sidecar where the heading points there), or delete the
   file for a retirement. A delta no work item implements (a
   clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story whose substance
   is implemented in code is exercised end-to-end by a test in the
   project's ordinary suites, carrying the `@story:` annotation for
   navigation — that annotation is also how the periodic audit finds
   the test later. No test ever checks the existence of static text,
   code, or prose: a commitment realized in prose carries no test.
   Write the tests with the work, not at the end.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, a destructive/irreversible
   action not clearly authorized — or the closing `/certify-work`
   step being unrunnable for you (e.g. its subagent dispatches are
   unavailable): surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker — pick the most
   plausible reading and continue, surfacing the choice at the end.
   (An orchestrator that supervises its own executors folds this into
   its own control.)

8. Keep the completion report current. Beside this sprint file lives
   its report — same filename with `-completion` before the
   extension — and you write it as you go: as each stage lands,
   record what was done, every divergence, and every call you made
   where the sprint was silent. It is the durable record the closing
   ceremony finishes and walks with the owner, the artifact a goal
   checker requires, and it is archived together with this sprint.
   It is a record of this execution, never a plan document.

9. Close by running `/certify-work` with this sprint's path as its
   argument — the argument is what puts the sprint in the gate's
   scope; the gate never adopts one on its own. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope, across every estate this project
   has: the project's own test suites over the touched work,
   change-scoped corpus checks over the touched artifacts and
   annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whether the corpus's claims still hold is the periodic `/audit`
   run, on the owner's cadence, never this close.) The goal is to
   finish the work: this file stays in `sprints/` through the
   presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends the run as the ceremony: it writes its
   composed presentation into the completion report (finishing the
   record kept in step 8), walks it with the owner, and offers the
   close-out — archiving this sprint together with its completion
   report and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold, each
verifiable from the repository as it stands:

1. The design corpus matches every delta above (applied verbatim,
   from the sidecar where a heading points there).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp — the owner
accepted and closed the work; terminal, stop checking — or this file
is still at its `sprints/` path and items 1–3 all verify against the
repository. A missing completion report means NOT done, however
green the rest looks; an archived, stamped sprint means DONE,
whatever else seems unfinished. A run parked at the review-fix
loop's cycle cap awaiting the owner's direction is a legal in-flight
state — not done, not failed, and never grounds for the run to take
either cap step itself. Nothing else counts either way.
