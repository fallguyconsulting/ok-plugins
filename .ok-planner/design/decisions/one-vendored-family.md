---
decision: one-vendored-family
---

# Everything the suite vendors comes from one family

## Choice

Everything the suite vendors into a project comes from one family,
ok-planner, carried as the front door's payload: every skill, agent
profile, rules file, support script, hook, and the one estate. The
coding standards and their lint and the stack helpers are all
ok-planner's. No skill reads a
per-family contribution: each skill carries its own instructions
whole.

## Rationale

Separate families that ship at one suite version give the owner no
separate releases. Each family still costs something: an estate, a
discovery marker, an administration pair, and a cheatsheet. The
families are also not independent. The planner's review pastes the
coding standards into the prompts of the agents that hunt, fix, and
verify, and
sprint planning runs the coding standards' planning steps itself. One
family turns each of those reaches into an ordinary read inside one
payload. A project then has one estate to discover, one true-up to
drive, and one body per ceremony. The cost: new tooling goes into
ok-planner rather than into a conforming directory of its own.

## Alternatives

- Three families, each with its own estate, marker, and
  administration files — the owner gains nothing for them.
- Two families, the coding standards apart from the planner — carries
  no unused verbs, and splits the coding standards from the review
  that reads them.
