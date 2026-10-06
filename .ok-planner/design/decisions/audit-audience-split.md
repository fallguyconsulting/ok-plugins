---
decision: audit-audience-split
---

# The audit records what it saw; the intake is reached only through gated writers

## Choice

The audit writes its own records — the per-artifact determinations
of the two axes it checks, into the corpus collection that holds them,
and the surface extraction, into its own machinery record — and reaches
the intake only through its judge, its surface extractor, and, in a
composed run, its documentation walk, below. It
writes no code and no design artifact, and it fixes
nothing. Its opening surface walk is owner conversation, not filing:
what the owner settles there lands in the surface intent as the
owner's own text, never in the intake. The documentation walk a
`/document`-composed run adds after extraction lands what the owner
settles in the document types, and files one intake issue for each
document type the owner leaves unsettled; that type is left out for
the run. What the run saw reaches
the owner through the run report it writes at its close — a record
beside its other outputs; an à la carte run's wrap-up is composed from
that report, and a run a ceremony invoked ends silently at its stamp.
The experiments stay the audit's instruments: the run never proposes
adopting one into the project.

An agent reaches the intake through these gated paths and no others:

- `/converge`'s owner list, the one writer of what a run leaves: each
  real defect outside the run's scope as a `category: defect` issue
  for the next run; each defect stuck at its limit of send-backs, its
  change backed out of the tree, as a judgment issue; each defect whose fix would edit the design
  corpus, the coding standards, or the harness settings, as a
  judgment issue; each harm in a part the project does not own, as
  an upstream issue; and each
  question about what the product owes or how the project's own
  tooling works, as a judgment issue.
- `/triage-issues`, which opens no new question: it rewrites each
  untriaged issue for its next reader, closes what the code, the
  corpus, or the tooling already answers, leaves an upstream issue
  open for the planning session while the project still shows its
  harm, retires a defect claim no
  accept-list entry covers and that proposes no entry, and writes under the ruling only a marked ruling: generated, recommended, or a
  retirement reason. It answers the owner's messages on an issue,
  replying and revising the issue where a message shows it wrong or
  thin, and never rewrites the owner's ruling (see also:
  triage-answers-owner-messages).
- The audit's second-opinion judge, filing only what an independent
  read confirmed as a real gap or found undecidable from the
  artifact's own text — a story's measured surface contradiction among
  them, a corpus contradiction the extraction turned up, and the run's
  own driving observations, which reach the intake through the judge's
  confirmation and no other way — and filing the practice violations it
  confirms as defect issues, one per practice, per
  decision:practice-violations-are-defects, and filing each harm in a
  part the project does not own as an upstream issue (see also:
  foreign-harms-become-upstream-issues).
- A sprint's build task, filing only an upstream issue for a harm in
  a part the project does not own (see also:
  foreign-harms-become-upstream-issues).
- The surface extractor, filing one issue for each element the
  surface intent does not settle, which the run defaults to internal.
- The documentation walk, at either of its call sites (see
  decision:documentation-walk-in-composed-audit), filing one issue for
  each document type the owner leaves unsettled, which the run leaves
  out.

Every judgment issue is made ruling-ready before it becomes owner
agenda. Unmarked ruling text is the owner's alone, and a marked
generated or recommended ruling becomes the owner's when the owner
leaves it standing until a planning session carries it. An owner
comment that triage has not yet marked seen holds the marked ruling
back from that session, which walks the issue with the owner instead.
Those gates govern the repeating cycle's filings, not the
intake's whole membership — humans file directly whenever they choose,
the owner rules and comments on an issue directly,
the front door's administration converts an earlier intake into the
current one on the owner's consent and files one issue for each
retired suite script caller it cannot repoint, the ceremonies that transcribe the
owner's own questions file directly, and so does the one-time corpus
bootstrap, whose review loops file
their questions ungated by design: the queue is what the owner invoked
that run to get, and a run that aborts rather than repeat over a
populated corpus cannot accumulate against the owner. The owner's
durable agenda is a property of those gates, never of how much the
audit records. Deduplication against the slugs already present is the
standing discipline of every writer into the intake, the gates
included.

## Rationale

The split keeps work moving and the owner uninterrupted: an agent that
fixes defects needs them now, in context, at machine tempo, while the
owner's queue must stay an owner-calibrated worklist. What bounds the
queue is which paths may write to it, not whether the audit keeps a
record of what it saw — an audit that records determinations in its
own collections costs the owner nothing to ignore, while an audit that
filed every observation as a question would be an ungated writer
inside a repeating cycle, growing the queue run after run without
anything checking that a reasonable owner would want to read it. Each
gate bounds that growth its own way. The owner list writes only what a
run could not fix, had no scope to fix, or could not decide, and a defect issue asks no
judgment: it waits for the next run, not for the owner. Triage applies
the accept list, the corpus, and the tooling, and closes or retires
what they settle. The judge confirms by an independent second read that
overturns as readily as it confirms. The corpus bootstrap files ungated without
defeating that, because it sits outside the repeating cycle — one
owner-invoked adoption run that refuses to run again over a populated
corpus, and the queue of judgment questions it hands back is the
outcome the owner invoked it for rather than a cost imposed on them. A
standalone audit's other observations still reach the owner: the human
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
  and duplicates the gates' dedup and confirmation outside them.
- A capped fix loop that stops and waits for the owner's word before
  filing what it could not fix — bounds the loop, and holds a run or a
  sprint open on the owner's attention instead of ending at a state
  they can read.
- The measurement runs nominating passing built experiments into the
  intake as candidates for adoption — another writer, and it blurs
  the audit's instruments with the project's code.
- The orchestrator filing its own driving observations directly —
  an ungated writer inside the repeating
  cycle, pre-empting the owner's intake under the appearance of
  bookkeeping; routing them through the judge keeps the observation
  and the gate both.
