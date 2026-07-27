---
issue: audit-verb-intake-channel
kind: audit
category: conflicting
artifacts:
  - decision:prove-audit-audience-split
  - story:corpus-audit
status: promoted
sprint: 2026-07-27-mechanical-release-audit-masking.md
opened: 2026-07-27T12:15:23Z
---

# Who may write the owner's issue intake: the audit verb, or only certification's architect?

Two design artifacts promise that the corpus-audit verb files judgment
findings straight into the owner's issue intake; the shipped verb is a
declared pure reporter that writes nothing, and every other surface of the
suite — the certification core, the estate guide, the counterpart proof
story — says the intake has exactly one gated agent writer. One ruling
settles both artifacts, and until it lands their implementation audits
stand `violated` (correctly linked to this issue) and the audit story's
proof cannot be written, because two of its three Proof conjuncts assert
intake writes the shipped shape forbids.

The mechanism in play is the intake's calibration guarantee. The issue
intake is the owner's reading queue: everything in it costs owner
attention, so the certification architecture funnels every agent write
through one adversarial gate — a finding must survive the fixer's veto
test and then the architect's owner-roleplay check before it may become a
file in the queue ("promotion is the loop's only path to the intake").
The older two-channel decision (`decision:prove-audit-audience-split`)
was written before that gate existed: it split verification into a proof
run reporting to the agent and an audit filing to the human, and credited
the audit with giving the owner "a durable, deduplicated agenda". The gate
has since absorbed both halves of that credit — deduplication lives in the
certification loop's dedup step and the architect's slug check — and a
deliberate pre-sprint commit reshaped the audit verb into a pure reporter.
The shipped shape is a third option neither of the decision's recorded
Alternatives contains: *neither* corpus-checking verb writes the intake.

State of play: the code, the certification core, the estate guide, and
`story:corpus-proof` all agree on the one-writer shape; only the two
linked artifacts still tell the two-channel story. A standalone `/ok-planner-audit`
run today returns its judgment findings in-context to the human who
invoked it, who files what they judge fork-worthy — humans are always a
legal path into the intake.

## Options

- **Corpus catches up to the one-writer shape.** Rewrite the decision
  (title, Choice, Rationale, Alternatives) so both corpus-checking verbs
  are pure in-context reporters distinguished by audience, with the
  durable, deduplicated agenda recorded as a property of the promotion
  gate; rewrite the story's title, Story clause, two append-bearing
  Acceptance clauses, and Proof field to promise a report to the caller.
  Cost: a wholesale rewrite of one decision and one story, and a
  standalone audit's judgment findings remain ephemeral unless the human
  files them.
- **Code catches up to the corpus.** Give the audit verb an intake-filing
  step for its judgment class, deduplicated against present slugs. Cost:
  reopens the pure-reporter posture, the certification core's one-path
  sentence, the estate guide's "only agent path in", and the finding/issue
  concepts — an ungated second writer into the owner's queue.
- **Split by caller.** Pure reporter as a certification producer; files
  its judgment class when a human runs it standalone. Cost: a
  caller-conditional channel rule threaded through both artifacts,
  `concept:finding`, and the certification core's scoping — the most
  moving parts for the narrowest benefit.

The ruling decides one thing: whether any verb other than certification's
architect may write the owner's intake.

## Ruling

> Recommended ruling (/verify-issues): the corpus catches up to the
> one-writer shape — the next sprint carries deltas rewriting
> `decision:prove-audit-audience-split` (both verbs report in-context;
> the deduplicated agenda is the promotion gate's property; the rejected
> filing-verb shape recorded as an Alternative) and `story:corpus-audit`
> (title, Story clause, Acceptance, and Proof restated around the
> reporting channel and the untouched intake), plus a work item writing
> the story's proof against the restated Proof field.
>
> Rationale: the one-writer gate is the deliberate, corroborated shape —
> a titled commit reshaped the verb, and four other surfaces commit to
> it — while the two-channel text predates the gate that absorbed its
> benefits. Filing-by-verb would reintroduce ungated writes into a queue
> whose whole value is calibration; the caller-split buys little that a
> human running the audit cannot do by filing directly. What would flip
> this: if standalone audit runs become a routine owner cadence and the
> in-context report proves too lossy in practice, the caller-split is
> the shape to revisit.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
