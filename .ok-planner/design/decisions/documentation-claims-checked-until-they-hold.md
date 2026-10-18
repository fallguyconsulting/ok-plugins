---
decision: documentation-claims-checked-until-they-hold
---

# Every documentation claim is checked against the tree until it holds or is cut

## Choice

In a documentation sprint, a checker that is not the writer checks
each claim the run must check, by the strongest check that applies: it
runs an example and compares its output, asks the program about a
flag through its own help or argument parser, or reads the code the
claim describes and names the symbol it read. A link must resolve, and
an in-code docspec's generator must run. The checker sends each false
claim back to a writer and checks the rewrite, with no cap on the
rounds, until every claim holds or is cut. A claim the tree cannot
settle is cut, and the run's report lists every cut. Which claims a
run must check is a decision of its own (see also:
documentation-claim-ledger).

## Rationale

A document makes a finite number of claims, and the code holds still
while the run works, so the loop ends without a cap. A writer checking
its own text confirms what it meant to say. Running or asking beats
reading, because a read can be wrong where a run cannot. Listing every
cut claim keeps a checker from cutting a hard claim unseen.

## Alternatives

- Cap the fact loop's rounds — a bounded run, and documentation can
  ship with a claim known false.
- Let the writer check its own claims — one agent fewer, and the
  writer confirms what it meant instead of what the tree does.
