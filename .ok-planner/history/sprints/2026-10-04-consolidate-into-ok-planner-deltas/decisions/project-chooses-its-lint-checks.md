---
decision: project-chooses-its-lint-checks
---

# Each project turns each lint check on or off, and the rule text follows

## Choice

Each project turns each of the suite's lint checks on or off in
ok-planner's configuration: the comment rule, citation
resolution, and the no-tests rule. A check is on unless the project
turns it off. The edit hook and every whole-tree run of the lint read
the same choice. Turning a check off also drops its rule from the
suite-owned rules text the project's agents read, so the written rule
and the lint never disagree.

## Rationale

A project may allow comments or tests where this suite forbids them,
and only its owner knows which. With no switch, such a project either
carries a check that blocks every legitimate edit or stops using the
lint, and loses the checks it does want. The switch is one owner act
in committed configuration, per check and per project, so no agent
editing code meets a seam it can reach for at a site. Agents follow
the text they read, so a rule the lint no longer enforces must leave
that text in the same act; otherwise the text tells every agent a
rule the project has dropped.

## Alternatives

- No switch, with a recorded baseline that may only fall: eases a
  backlog the project means to clear, and gives a project that allows
  comments or tests no way to say so.
- Suppression markers at each exempt site: scatters exemptions through
  the code as residue, each one a judgment an agent can make alone.
- A switch in the lint's configuration alone, the rule text unchanged:
  agents read a rule the lint no longer checks, and follow the text.
