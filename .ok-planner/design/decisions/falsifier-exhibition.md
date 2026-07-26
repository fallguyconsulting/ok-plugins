---
decision: falsifier-exhibition
---

# Non-vacuity is established by exhibiting falsifiers, never by reading

## Choice

A proof counts as passing only when its declared falsifier has been exhibited in this run: the falsifying mutation applied, the proof confirmed red, the mutation reverted, green confirmed. Reading a proof and forming an opinion is never a substitute; a falsifier that cannot be produced marks the proof vacuous, and only a mutation unsafe to stage and undo yields an uncertain verdict naming the exact unrunnable mutation.

## Rationale

The read is the foolable step: an eager agent can rubber-stamp "looks fine," but it cannot make a check flip that does not flip. Exhibition is also the seam-catcher for corpus claims that outran the code — a universal claim over a population of one, or an asserted implementation the code lacks, cannot exhibit a falsifier and surfaces as vacuous instead of green.

## Alternatives

- Read-and-judge verification — restores the exact rubber-stamping failure the discipline exists to remove.
- Permanent mutation-testing infrastructure — heavier machinery for a suite that ships no runtime; exhibition gets the flip evidence transiently.

## Proof

The proof run itself is the enforcing check: it reports vacuous for any proof that stays green under its falsifier or whose falsifier cannot be produced, and never issues a pass without an exhibited red-green cycle — a stubbed component or crossed boundary that leaves a proof green is exactly what turns its verdict from pass to vacuous.
