---
decision: stack-advice-outside-the-rules
---

# The suite's stack advice lives in a reference document, not in the always-loaded rules

## Choice

The suite's always-loaded rules state no rule about verification
stacks. One reference document, which no session loads unless an agent
reads it, describes the stack helpers and the reference stack tool and
gives the suite's advice on run tags and host ports (see also:
stack-helpers-serve-project-commands). The suite's lint carries no
check of a stack definition.

## Rationale

The always-loaded rules hold the conventions every change in a project
follows, and every agent in every session reads them. How a project
starts its verification stack is one of its own tools, which few
changes touch, so advice about it belongs in a document an agent reads
when it builds or changes that tool. A rule with no check is prose an
agent may skip, and a check of one stack format serves only the
projects whose stacks take that format. The cost: an agent that edits
a stack definition without reading the document can publish a bare
port or leave an unlabelled image, and nothing flags it.

## Alternatives

- The stack rules in the always-loaded rules, checked by the suite's lint for compose files — every agent in every project reads rules about a tool most of its changes never touch, and a stack outside compose goes unchecked anyway.
- The stack rules in the always-loaded rules, with no check — the same reading cost, and the rules bind nothing a lint enforces.
- Each project writes its own stack practice — every project words the same advice its own way, and a project that writes none gets none.
