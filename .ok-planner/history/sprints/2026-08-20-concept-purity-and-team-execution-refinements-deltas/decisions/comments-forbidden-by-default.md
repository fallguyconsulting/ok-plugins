---
decision: comments-forbidden-by-default
---

# Comments are forbidden by default, with structural exemptions only

## Choice

Under the lint methodology, comments are not permitted in source files by default. Exactly three structural exemptions exist: machine directives (tooling syntax such as license headers, suppressions, build tags, shebangs), project-declared citation tags whose slugs resolve structurally, and documentation comments in files carrying an explicit opt-in marker. The methodology ships zero default citation tags; projects declare their own. An agent writes a citation tag only where a declared standard directs it, never on its own initiative. A tag whose slug does not resolve is a violation of the same standing as any other residue. Everything else is residue whose default action is delete, including in code you didn't write.

## Rationale

Comments are generation residue and a drift hazard with a sharper edge for agents, which weight them as intent signals — a confidently wrong comment pulls an agent toward "fixing" correct code. Only structural exemptions leave no judgment seam, converting the convention into a mechanical check per the methodology's cost model: discipline does not compose across sessions, checks do. An exemption an agent could invoke on its own initiative would reopen that seam, so a tag earns its exemption from a standard that directed it and a slug that resolves.

## Alternatives

- A curated tag vocabulary of allowed comment kinds — every classification boundary is a judgment call, and a judgment seam is what agents route around rather than submit to.
- Conventional comment hygiene by review — pure discipline, which the cost model says to trust less over time, not more.
