---
issue: plumbline-explain-verb-ungoverned
kind: audit
category: unspecified
artifacts:
  - story:rules-compliance-report
  - concept:citation-tag
  - concept:skill
status: promoted
sprint: 2026-07-28-corpus-browser-and-ruled-intake.md
opened: 2026-07-28T10:12:59Z
---

# The lint's definition-lookup command is shipped but never promised

The suite ships a slash command, `/ok-plumbline:explain`, into every consumer
project it converges: ask it about a lint check code, the citations config, or
the docstring opt-in marker, and it recites the canonical definition with
examples. No design artifact anywhere claims that capability. The whole-corpus
certification's surface inventory — the pass that enumerates what a consumer
can actually reach and asks whether the corpus claims it — found the hole, and
it will re-file the same finding on every run until the owner rules on whether
the capability is owed, unwanted, or deliberately unclaimed.

The gap is legible because of the corpus's own coverage convention: every
other vendored plumbline verb answers to a clause naming its outcome. The
compliance report and its remediation view are named by the compliance story
(`story:rules-compliance-report`); the whole-repo report, the clusters, the
port plan, the ratchet baseline, and the starter proposal are each named in
the adoption story (`story:incremental-lint-adoption`). `explain` has no such
clause. The nearest concept — the cheatsheet, the one always-in-context rules
file each family maintains — describes itself as "a condensation of rules
canonical elsewhere, never the canonical statement itself" (`concept:cheatsheet`),
and `explain` is functionally that addressable "elsewhere" for a consumer at
the terminal; the corpus never says so.

State of play: the verb is live and vendored (the family binary's
`VENDORED_SKILLS` map materializes it into every consumer's skills directory),
it works today, and nothing verifies or protects it — no story, no proof, no
concept boundary reaches it.

## Options

- **Add a story** committing the product to on-demand explanation of the
  lint's own rules — cost: a proof obligation and one more promise the corpus
  must keep true.
- **Extend `concept:cheatsheet`'s Boundaries** to name the canonical-statement
  surface without a story — cost: a commitment carried by a concept, so
  nothing proves it stays delivered.
- **Retire the verb** — cost: removes a shipped convenience consumers may use
  daily, on no evidence either way about usage.
- **Record a class decision** that a family's help/definition surfaces are
  ordinary mechanism no artifact governs — cost: the corpus deliberately
  under-claims shipped verbs, and the surface inventory loses its teeth for
  this whole class of verb.

## Ruling

> Recommended ruling (/verify-issues): add a story committing the product to
> on-demand explanation of the lint's canonical rule definitions — the need,
> a user-observable acceptance over check codes and config topics, a
> falsifier, and a proof intent — with the topic set and the delivery surface
> left as mechanism outside the story body.
>
> Rationale: the capability sits squarely in the family's charter (the lint's
> own knowledge), and the per-verb-clause convention is the corpus's strongest
> audit lever — a "help surfaces are mechanism" class decision would blunt the
> surface inventory for every future verb, while a story keeps `explain`
> honest with a proof. If the owner instead regards `explain` as scaffolding
> rather than an owed capability, retirement is the honest alternative; the
> middle options leave the capability claimed but unverified.

<!-- Owner: this is a recommendation, not your decision. Leave it as-is to
accept — the next /plan-sprint carries it, naming the recommended batch at
sign-off. Edit the text to redirect, empty the section to discuss live, or
delete this note to adopt the ruling as your own. -->
