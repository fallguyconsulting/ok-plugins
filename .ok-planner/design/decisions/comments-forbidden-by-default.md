---
decision: comments-forbidden-by-default
status: as-is
---

# Comments are forbidden by default, with structural exemptions only

## Choice

Under the lint methodology, comments are not permitted in source files by default. Exactly three structural exemptions exist: machine directives (tooling syntax such as license headers, suppressions, build tags, shebangs), project-declared citation tags whose slugs resolve structurally, and documentation comments in files carrying an explicit opt-in marker. The methodology ships zero default citation tags; projects declare their own. Everything else is residue whose default action is delete, including in code you didn't write.

## Rationale

Comments are generation residue and a drift hazard with a sharper edge for agents, which weight them as intent signals — a confidently wrong comment pulls an agent toward "fixing" correct code. The predecessor tag vocabulary was a judgment-call seam agents reliably routed around; only structural exemptions leave no judgment seam, converting the convention into a mechanical check per the methodology's cost model: discipline does not compose across sessions, checks do.

## Alternatives

- A curated tag vocabulary of allowed comment kinds — the methodology's own earlier rule, retired because agents routed around its judgment calls.
- Conventional comment hygiene by review — pure discipline, which the cost model says to trust less over time, not more.

## Proof

The lint binary's comment-hygiene and citation-resolution checks exit nonzero on any non-exempt comment or unresolvable citation slug, asserted by the plugin's fixture test suite; adding a prose comment to a clean fixture, or breaking a citation's resolution, turns the run red.
