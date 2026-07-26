---
concept: citation-tag
---

# Citation tag

## What it is

A citation tag is a project-declared comment form the lint methodology permits: a tag paired with a structural resolution rule — a file template containing the slug, or a glob the slug must appear in — such that a comment line carrying the tag is allowed only when its slug resolves. It is the only way a project declares allowed comment forms beyond the structural exemptions.

## Purpose

Citation tags let load-bearing cross-references survive the no-comments rule without reopening a judgment seam: every permitted comment is mechanically resolvable, so an agent can neither invent documentation prose nor leave a dangling reference undetected.

## Boundaries

Tags are owner-declared configuration, never shipped as defaults and never added on an agent's initiative (see also: comments-forbidden-by-default under decisions, stack-profile for the declaration pattern). The design-corpus annotations become citation tags when a project declares the bridge, making the lint the mechanical twin of the corpus audit's integrity pass (see also: annotation). The strict line form — tag and slug only, no prose tail — belongs to the lint's grammar.

## Invariants

- Each tag pairs with exactly one structural resolution rule; each slug on a stacked block resolves independently.
- An unresolvable citation is a violation, identical in standing to any other residue.
