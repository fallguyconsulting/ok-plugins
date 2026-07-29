---
decision: local-web-surface
---

# The corpus view is a local web application

## Choice

The corpus view is delivered as a read-only local web application — a page served over loopback by a program the project runs on demand — rather than as terminal output or an editor extension. The surface is chosen for what it has to carry: lateral movement in any direction, artifact to code and code back to the artifacts claiming it, with the cited excerpts held open inline beside the list they were reached from, all within one invocation the owner starts and closes.

## Rationale

A terminal report can print any one of those movements but cannot keep several navigable at once, so every lateral step costs another invocation and loses the reader's place. An editor extension buys the best code surface at the price of one editor's plugin model and a separate implementation per editor. A local page is the cheapest surface that carries both halves at once, and unlike a committed static site it is a process rather than an artifact — nothing is left behind in the consumer's repository when the owner closes it.

## Alternatives

- A terminal report per artifact — composes with the suite's existing verbs, but flattens navigation into one linear dump per invocation.
- An editor extension — the strongest code surface, at the cost of a per-editor implementation and per-editor drift.
- A static site generated and committed per project — no service to run, but excerpts freeze at generation time and the generated artifact lands in every consumer repository.
