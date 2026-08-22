---
issue: conduct-lacks-a-message-level-directness-check
kind: filed
category: other
artifacts: []
status: open
opened: 2026-08-22T18:30:00Z
---

# The conduct's delivery rules land where they carry a send-time check; "plain and direct, lead with the issue" carries none and does not land

## Problem

In a live LineScout session under ok-conduct 1.17.0, the owner got
"one concept per turn" to stick but not "lead with the answer" or
"write in plain language". The session presented a design issue so
discursively that the owner read it three times and needed four
rounds of follow-up questions to learn a point that fits in two
sentences.

The diagnosis from that session: a delivery rule sticks when it
carries a mechanical operation checkable at send time, at the right
granularity. Segmentation sticks because its check operates on the
message — find the seam, cut, hold the rest — and the per-turn hook
restates it. The writing standard's read-back operates on the
sentence. Every sentence of the failed message individually passed
(active voice, short, one claim); the message still opened in the
wrong place and spoke the source artifact's vocabulary instead of
the listener's. Two conduct rules pushed the wrong way: "use the
same term for the same thing every time" and "ground every claim"
pulled the assistant toward relaying the artifact's register and
structure — fidelity to the document over translation to the
listener.

A second, distinct failure: the owner had never read the artifacts
under discussion, and the assistant described their text instead of
quoting it. When an issue turns on a document's text, a paraphrase
forces the reader to reconstruct the original through questions.

## The example

The issue under discussion: a design decision names four facts an
instance discloses without authentication, then closes with
"Everything else the instance serves stays behind authorization" —
false, because the instance deliberately serves sign-up, bootstrap
state, sign-up policy, and health unauthenticated, and another
decision already owns the instance-wide rule.

What the assistant sent first (opening excerpt):

> **Third: `discovery-decision-forbids-the-public-front-door`.** The
> decision `unauthenticated-instance-discovery` names the four facts
> an instance discloses without authentication, then closes with
> "Everything else the instance serves stays behind authorization."
> Read literally, that sentence is false: the deployment's front
> door marks four routes public — health, version, sign-up, and
> bootstrap — and the discovery decision accounts only for version.
> Three live artifacts owe the others: [...]

Three more paragraphs followed. The two unrelated "fours" (four
facts, four routes) collided; the owner could not tell whether the
decision named facts or routes, asked where "all served by one
route" came from, and only on the fourth round got the plain
statement.

What the whole presentation should have been:

> The decision's Choice reads: "An instance answers, without
> authentication, what release it runs, the oldest client release it
> accepts, where its identity authority lives, and where its
> dashboard lives [...]. Everything else the instance serves stays
> behind authorization."
>
> The second sentence is false: the instance serves sign-up,
> bootstrap state, sign-up policy, and health unauthenticated, on
> purpose. The generated ruling cuts that sentence.

## Candidates

- A lede drill with a send-time check at message granularity:
  "Before sending an explanation, write the one-or-two-sentence
  version a reader with no context could act on. That version opens
  the message; if the draft's first sentences are not it, replace
  them. The rest of the draft is optional detail beneath it."
- A quotation rule: "When an issue turns on an artifact's text,
  quote the operative text verbatim — never describe what you can
  quote." The owner has usually not read the artifact; the operative
  text is the evidence, and a paraphrase of it is a claim the reader
  cannot check.
- Reconcile the register pull: note that "use the same term for the
  same thing every time" governs the assistant's own coinages, not a
  license to relay a source document's internal register when
  explaining it to a listener who has not read it.
