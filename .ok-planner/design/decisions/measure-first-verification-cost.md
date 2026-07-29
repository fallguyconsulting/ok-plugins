---
decision: measure-first-verification-cost
---

# Changing verification cost is performance engineering

## Choice

Changing what a verification suite costs follows performance-engineering discipline: a profile is taken before any change, the change is justified by what that profile names, and a re-measure confirms the effect. The timings the proof run records are the profile of record.

## Rationale

Verification cost reads as test work, and the measure-first reflex that fires reliably on product code does not fire on it. Naming the discipline is what makes the reflex fire. Grounding it on timings the proof run already leaves is what makes measuring the cheap path rather than another full run. The two halves fail apart: a measure-first rule with no measurement available is unaffordable in practice, and a timing record nobody is directed to consult changes nothing.

## Alternatives

- Leave verification cost to ordinary engineering judgment — no new commitment, but the observed failure stands unaddressed.
- Record the timing artifact without stating the discipline — the data exists and nothing directs anyone to it before changing the suite.
- Home the discipline with the lint family's existing check-speed criterion — reaches authoring-time placement choices only, never the cost of a run.
