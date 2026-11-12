---
decision: lean-body-copied-word-for-word
---

# True-up copies a lean profile's rules word for word

## Choice

True-up writes each lean profile's body (see also:
lean-profiles-carry-their-rules). It selects the suite's rules by
section heading and copies each listed section word for word from the
four cheatsheet files that state the suite's rules, as it renders
them for the project; no agent condenses anything.

## Rationale

Copying word for word from one source keeps one text of each rule. A
lean agent and an agent that loads the cheatsheets then read the same
words, and a change to a cheatsheet section reaches the profile on the
next true-up. Rendering the sections as true-up renders the
cheatsheets for the project applies the project's lint check choices
to both alike. A condensed copy would be a second statement of each
rule, and it would drift from the first.

## Alternatives

- An agent that condenses the rules into the body — a second text of each rule that drifts from the first.
