# Concept Definitional Purity — Design Sketch

**Date:** 2026-08-20
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

A consumer project swept its 74-concept catalog against ok-planner's
own concept rules and found 48 files carrying content the rules
assign elsewhere: instance enumerations (verbs, wire identifiers,
role names) in about 23 files, interface and schema content (route
shapes, RPC methods, state tables, CLI grammar) in about 22,
decision-style choice-arguments in 10, story-style guarantees in 2 —
plus roughly 505 invariants across the catalog. Two suite changes
follow: close the enforcement hole that let the drift accumulate,
and remove the Invariants section — the owner has ruled it out of
the concept template. The measuring project's catalog goes first,
ahead of the suite change; the next ok-planner version carries the
rule.

## Shape

**1. Transclude the concept definition into the sign-off compliance
reviewer.** `_shared/design-doc-compliance-reviewer.md` transcludes
`{{STORY-DEFINITION}}` and `{{DECISION-DEFINITION}}` but not
`{{CONCEPT-DEFINITION}}`, so a sprint's concept deltas are checked
for self-containment and repository truth, never for definitional
form. The periodic audit's worker carries the definition, but its
findings route to the intake, not the sign-off gate — the slow path
only. Adding the transclusion makes the gate enforce the rule the
preamble already states ("interface designs, route shapes, CLI
grammars, schemas, and implementation diagrams live in code").

**2. Drop the Invariants section; audit a concept as vocabulary.**
Ruled, not open: a concept is abstract — it defines a kind of thing
and holds no prescription, no requiring or forbidding of
implementation behavior. `{{CONCEPT-TEMPLATE}}` sanctions
"Invariants: load-bearing properties of the concept," and in
practice the section grows prescriptive: guarantees, forbidden
implementation patterns, argued tradeoffs — an average of seven
invariants per noun in the measured catalog. A property worth
checking is a promise to a user (a story) or a chosen shape (a
decision). The audit already reads those artifacts. An invariant
that is neither is a property nobody owes. Nothing in the suite
reads the section constructively. Every use of a concept outside
the audit — the session-start TOC, `@concept:` annotations, the
issue verifier, the planning ceremony, the concept router, every
subagent prompt — reads it as the definition a reader reaches for
when the noun appears. The change:

- Remove `## Invariants` from the concept template, and say in the
  definition's sentence: a concept defines; it does not guarantee,
  forbid, or decide.
- Change the concept's audit support axis (`ceremony/audit.md`,
  `_shared/implementation-auditor.md`). The auditor reads the code's
  use of the noun against the definition instead of reading
  Invariants against the code: the concept has one live name, and
  the `@concept:` sites and the code around them agree with What it
  is and Boundaries.
- Sweep the corpus: every concept with an Invariants section loses
  it (35 in this repository), and an invariant that is a real
  promise moves to a story or a decision.

## Evidence

The measured project's sweep record: 48 of 74 files with findings,
26 clean, ~505 invariants. One file enumerates literals directly
under its own sentence that membership of the set is owned by the
code. One concept's guarantee sentence restates an existing decision
verbatim; the duplication fed a wrong ruling on an unrelated issue
before the decision was found.
