---
issue: concept-invariance-test-reads-as-any-change
kind: human
category: unclear
artifacts:
  - concept:concept-artifact
  - concept:design-corpus
  - story:plan-a-sprint
status: open
opened: 2026-09-14T22:55:49Z
---

# The concept invariance test says "an implementation change could falsify", which reads as any change at all

## Problem

The invariance test under `{{CONCEPT-DEFINITION}}` in
`plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`
reads:

> **Invariance.** Every sentence under `## What it is` and
> `## Boundaries` stays true if the product were rebuilt on a
> different surface with a different implementation. A sentence a
> surface change or an implementation change could falsify describes
> an instance, and goes.

An implementation change could falsify any sentence, so an owner
reading the rule cannot tell which sentences it strikes. In one
planning session a drafter wrote four concept sentences that list the
acts a surface offers and the fields a record holds, the compliance
reviewer flagged them under this test, the drafter first recommended
keeping them because the live bodies already carry sentences of the
same shape, and then reversed after working out the rule's intent:
the rebuild the test imagines keeps every story met and every
decision's intent kept, and changes only how the product is built or
presented, so a sentence fails when the product could be the same
product with the sentence false. The owner asked what the actual
interpretation was, which the text should have said.

The live corpora that this rule has governed carry the fault the
reviewer flagged: concept bodies that enumerate the acts a surface
offers ("It creates, pauses, resumes, and removes a simulation only
through the control plane") beside sentences that define ("acts under
the signed-in viewer's own authority"). The rule's text did not stop
them at drafting or at review.

## Candidates

- Restate the invariance test as the question a drafter can ask of
  each sentence: could the product meet every story and keep every
  decision with this sentence false? If yes, the sentence describes
  what this build happens to do, and it goes; if no, it defines the
  thing, and it stays. Add that a sentence listing the acts a surface
  offers, the fields a record holds, or the steps a mechanism takes
  fails, and a sentence saying what the thing owns and where it ends
  against its neighbors passes.
- Keep the test as written and add the worked pair above as an
  example under it, one failing sentence and one passing sentence.
- Retire the invariance test and rely on the existence test and the
  "names no instance" list alone, accepting that act enumerations in
  concept bodies stand.

## Ruling

The rebuild the invariance test imagines meets every story and is free to change every decision. Concepts sit beside stories, above decisions: the stories say what a user needs to do in the absence of any technical choice, the concepts name the kinds of thing those needs are about, and many different sets of decisions could serve both. Restate the test so it says this: a sentence stays when it holds for every product that meets the same stories, whatever decisions that product makes; a sentence that some such product could make false describes this build, and goes. In nonlinear editing software, "a timeline arranges media clips in time" stays, and "a timeline is saved as an edit decision list" goes, because a different decision could save it another way and still meet every story. The candidate that holds every decision fixed is rejected: it would let a concept restate decisions.
