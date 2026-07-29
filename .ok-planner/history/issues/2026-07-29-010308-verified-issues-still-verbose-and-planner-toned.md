---
issue: verified-issues-still-verbose-and-planner-toned
kind: human
category: conflicting
artifacts:
  - concept:issue
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T01:03:08Z
---

# Verified issues and their rulings are verbose and opaque; the authorship rules are style adjectives and the ruling format forces the wrong altitude

## Problem

Issues as rewritten by the verifier are still verbose and opaque, and
so are the recommendations. Two textual causes.

The narrative contract is uncheckable style direction — "write like a
journalist," "nut graf," "not chattily," "one breath each" — which an
agent can satisfy in the letter while producing walls of prose.
"Gloss every project term in a clause" licenses a sentence-long
digression per term. "ONE narrative, not sections that restate each
other" carries no test.

The ruling templates force planner-altitude output: the generated
form demands the resolution "stated as the corpus mutation to make"
and the recommended form "stated as what /plan-sprint should carry —
the corpus mutation, the work item." That is the sprint planner's
job, not the verifier's. The suite's altitude ladder runs: ruling
(intent, informal engineer's tone) → sprint (outcome-level deltas and
work items) → implementer (mechanics and judgment); the planner will
understand a plain ruling or ask, per its own only-when-not-understood
clarification rule. Corpus-mutation phrasing in the ruling is
machine-facing by construction and is where the opacity comes from.

What is wanted: from-the-top (an engineer with no project knowledge
can understand and form a technical opinion) AND concise, free of
blather.

## Candidates

- Replace the style adjectives with two checkable rules: every
  project term gets a two-or-three-word parenthetical on first use
  then stands alone; every fact gets exactly one home (a sentence
  deletable with nothing lost is a violation; the ruling's rationale
  weighs options by reference, never re-describes them).
- Retone both ruling templates to informal engineer speech — what to
  do and why, no artifact operations, no file paths — leaving
  delta/work-item form to the planning ceremony.
- Make the flip-case standard in every recommended ruling (currently
  required only for close calls), and add one domain-neutral exemplar
  lede — a single example, since this text materializes into every
  consumer repo and a second example starts a style corpus.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
taking all the candidates with one simplification decided in
discussion: no split Ruling and no Carry: block — the ruling is a
decision in an engineer's informal register (what to do and why, no
artifact operations, no file paths), and translating it into deltas
and work items is the planning ceremony's job, per the suite's
altitude ladder (ruling states intent → sprint states outcomes →
implementer owns mechanics), with plan-sprint's existing
only-when-not-understood clarification valve as the escape. The
narrative contract's style adjectives were replaced with the two
checkable rules (first-use parenthetical then the term stands alone;
one home per fact with the deletable-sentence test, rationale
weighing options by reference), a single domain-neutral exemplar
lede was added, the flip case is now standard in every recommended
ruling, and the issue-format rules in the canonical artifact
definitions were aligned. The owner then fixed the audience,
verbatim, into the contract — "an experienced engineer who doesn't
know much about the project or its implementation and doesn't have a
lot of time to read, but needs to evaluate a ruling based on an
informed technical opinion" — with two consequences also applied:
the deletable-sentence test is anchored to that purpose (deletable
without weakening the reader's ability to evaluate the ruling), and
terms are taught only when the evaluation requires them — a concept
that doesn't bear on the decision is omitted, not glossed. Stays
open for the next sprint to ratify; ships with the next
release/re-vendor.
