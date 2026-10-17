---
decision: discovery-notes-archived-on-consent
---

# The corpus bootstrap offers to archive its discovery notes once the catalogs exist

## Choice

At the end of a run that wrote at least one concept, story, or
decision, `/discover-design` offers the owner once to move its
discovery notes to the archive, and moves them on the owner's yes.
The archive keeps one folder per record kind, named for the kind, and
the notes go to its discovery folder. The skill's re-run guidance
names that folder as the place to restore the notes from before a
full rebuild. Notes the owner keeps in place stay beside the
design catalogs, and every reader treats them as records.

## Rationale

Once the catalogs exist, the bootstrap reads the notes again only
after the owner clears the catalogs for a full rebuild. Left in the corpus,
they sit among readers that treat the corpus as live text, guarded
only by each reader remembering to skip them. In the archive they sit
among records, which every reader already leaves alone, and a move
carries a record unchanged. The skill asks at the moment the owner
already reads the bootstrap's report, so the question costs one
answer per bootstrap. Moving the notes without asking would move files
the owner can see without the owner's word, and the suite moves a file
into the archive only on the owner's word, as true-up does (see also:
true-up-asks-once-before-destructive-steps).

## Alternatives

- Always move the notes at the end of a run that wrote at least one concept, story, or decision,
  with no question — the owner gives no consent, and an incremental
  re-run must restore the notes by hand.
- Leave the notes in the corpus for good — every corpus reader that
  does not skip them keeps reading them as live text.
- Offer the move from every true-up while the catalogs hold files and
  the notes stay in place — reaches projects bootstrapped earlier, and
  adds a judgment to the administration that the skill can ask once.
