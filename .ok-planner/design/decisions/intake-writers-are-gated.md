---
decision: intake-writers-are-gated
---

# Agents reach the intake only through gated writers

## Choice

An agent reaches the intake through these gated paths and no others:

- `/converge`'s owner list, the one writer of what a run leaves: each
  real defect outside the run's scope as a `category: defect` issue
  for the next run; each defect stuck at its limit of send-backs, its
  change backed out of the tree, as a judgment issue; each defect
  whose fix would edit the design corpus, the coding standards, a
  docspec, the surface intent, or the harness settings, as a
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
- A sprint's build task, filing only an upstream issue for a harm in
  a part the project does not own (see also:
  foreign-harms-become-upstream-issues).

Every judgment issue is made ruling-ready before it becomes owner
agenda. Unmarked ruling text is the owner's alone, and a marked
generated or recommended ruling becomes the owner's when the owner
leaves it standing until a planning session carries it. An owner
comment that triage has not yet marked seen holds the marked ruling
back from that session, which walks the issue with the owner instead.
Those gates govern the repeating cycle's filings, not the intake's
whole membership — humans file directly whenever they choose, the
owner rules and comments on an issue directly, the front door's
administration converts an earlier intake into the current one under
the owner's one up-front consent, files one issue for each retired
suite script caller it cannot repoint, and files one for a review
facts file it cannot decode, the ceremonies that transcribe the
owner's own questions file directly, the planning session files as a
defect issue each improvement the owner drops at approval that names
an accept-list harm, and so does the one-time corpus bootstrap, whose
review loops file their questions ungated by design: the queue is what
the owner invoked that run to get, and a run that aborts rather than
repeat over a populated corpus cannot accumulate against the owner.
The owner's durable agenda is a property of those gates, never of how
much any run records. Deduplication against the slugs already present
is the standing discipline of every writer into the intake, the gates
included.

## Rationale

The split keeps work moving and the owner uninterrupted: an agent that
fixes defects needs them now, in context, at machine tempo, while the
owner's queue must stay an owner-calibrated worklist. What bounds the
queue is which paths may write to it. An agent that filed every
observation as a question would be an ungated writer inside a
repeating cycle, growing the queue run after run without anything
checking that a reasonable owner would want to read it. Each gate
bounds that growth its own way. The owner list writes only what a run
could not fix, had no scope to fix, or could not decide, and a defect
issue asks no judgment: it waits for the next run, not for the owner.
Triage applies the accept list, the corpus, and the tooling, and
closes or retires what they settle. The build task files only a harm
the project cannot fix in its own tree. The corpus bootstrap files
ungated without defeating that, because it sits outside the repeating
cycle — one owner-invoked adoption run that refuses to run again over
a populated corpus, and the queue of judgment questions it hands back
is the outcome the owner invoked it for rather than a cost imposed on
them.

## Alternatives

- Every run writing the intake directly — the intake stops meaning
  "requires owner calibration" by construction, growing run after
  run inside the repeating cycle.
- A run filing its own judgment class outside the gates — reintroduces
  ungated agent writes and duplicates the gates' dedup and
  confirmation outside them.
- A capped fix loop that stops and waits for the owner's word before
  filing what it could not fix — bounds the loop, and holds a run or a
  sprint open on the owner's attention instead of ending at a state
  they can read.
