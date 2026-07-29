---
concept: decision-artifact
aliases:
  - decision
  - TD
  - technical decision
---

# Decision (artifact kind)

## What it is

A decision is the design-corpus artifact kind that records a real architectural or technical choice: one shape adopted over identifiable alternatives, with non-trivial tradeoffs. The bar is that a reasonable engineer can name both the choice and a plausible different choice, and the rationale is a tradeoff rather than a default. A choice with no plausible alternative is a default, not a decision.

## Purpose

Decisions preserve the reasoning that picked one shape over another, so later work neither silently re-litigates settled tradeoffs nor cargo-cults shapes whose rationale is lost. They also absorb the specifics that concepts must not carry: the decision names the instances; the concept names the kind.

## Boundaries

A decision owns the choice, the tradeoff, and the alternatives that were on the table. It owns no verification of its own: whether an implementation honors the choice is determined adversarially by the decision's implementation audit, which identifies where and how the choice is implemented and derives what would violate it from the choice itself. Its choice section may name the specific artifact picked, because the artifact identity carries the tradeoff — the sanctioned exemption to self-containment. It is NOT a spec (no implementation steps or schemas) and NOT a design (no inner workings of the chosen thing). Neighbors: concept-artifact, story-artifact.

## Invariants

- One decision per choice; unrelated choices never share a file.
