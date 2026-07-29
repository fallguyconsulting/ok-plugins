---
issue: plumbline-slug-verb-ungoverned
kind: audit
category: unspecified
artifacts:
  - concept:annotation
  - concept:citation-tag
  - concept:skill-family
status: promoted
sprint: 2026-07-28-corpus-browser-and-ruled-intake.md
opened: 2026-07-28T10:12:59Z
---

# A slug generator ships from one family but exists for another's artifacts

The suite ships `/ok-plumbline:slug` into every consumer project: give it
prose, it returns a stable kebab-case identifier (lowercase, stop-words
stripped, up to five significant words). Its own documentation states what it
is for: "creating a new design artifact (concept, story, decision)" — which
are the planner family's artifact kinds, not the lint family's. No design
artifact claims the capability, and no planner skill references or depends on
it. The whole-corpus certification's surface inventory found the hole and will
re-file it every run until the owner rules.

Two questions are stacked. First, whether identifier generation is owed at
all: the annotation concept fixes what a slug must *satisfy* ("the slug
stamped in code is the exact basename of the artifact" — `concept:annotation`)
and the citation-tag concept pairs a tag with a resolution rule, but nothing
anywhere commits to a generator, and unlike every other vendored plumbline
verb, nothing names this one's outcome. Second, if it is owed, who owns it:
the skill-family concept holds that "family-specific knowledge lives nowhere
but the family's directory" (`concept:skill-family`), and a verb documented
around the planner's artifact kinds shipping from the lint family is either a
generic citation-identifier tool whose documentation drifted toward one
example, or family knowledge sitting in the wrong directory.

State of play: the verb is live and vendored, nothing consumes it
programmatically, and its only documented use case belongs to a family that
never mentions it.

## Options

- **Add a story** committing the product to deterministic identifier
  generation — cost: a proof obligation for a convenience any session can
  perform inline, and the ownership question still needs an answer.
- **Extend `concept:annotation` / `concept:citation-tag`** to cover how an
  identifier is produced — cost: a commitment with no proof, ownership still
  unsettled.
- **Amend `concept:skill-family`'s Boundaries** to settle cross-family verb
  ownership and relocate the verb — cost: heavier than it reads; it is a
  cross-family code move of a shipped skill, not a documentation edit.
- **Retire the verb** — cost: removes a shipped convenience; consumers who
  want the derivation lose the deterministic recipe.
- **Record a class decision** that identifier-shaping conveniences are
  ordinary mechanism — cost: the corpus deliberately under-claims shipped
  verbs, blunting the surface inventory for the class.

## Ruling

> Recommended ruling (/verify-issues): retire the verb — remove the `slug`
> skill from the family's vendored surface and its `VENDORED_SKILLS` entry, so
> the inventory hole closes by the surface disappearing.
>
> Rationale: retirement is the only resolution that settles both stacked
> forks without a new commitment. The verb's only documented consumer is
> another family's artifact workflow, which has never referenced it; the
> identifier contract that actually matters is already committed
> (`concept:annotation`'s exact-basename rule), and deriving a kebab-case slug
> is within any session's ordinary competence — the deterministic recipe
> protects nothing a proof could observe a user losing. Keeping it means
> either widening the corpus for a convenience or carving a mechanism class
> that weakens the surface inventory. What would flip this: evidence that
> consumers depend on the exact deterministic algorithm (stable re-derivation
> of the same slug across sessions), which would make it a real commitment
> worth a story — placed with the planner, whose artifacts it names.

<!-- Owner: this is a recommendation, not your decision. Leave it as-is to
accept — the next /plan-sprint carries it, naming the recommended batch at
sign-off. Edit the text to redirect, empty the section to discuss live, or
delete this note to adopt the ruling as your own. -->
