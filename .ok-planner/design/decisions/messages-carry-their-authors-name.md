---
decision: messages-carry-their-authors-name
---

# Every comment and ruling carries its author's name

## Choice

Several people may work one project's intake. Every comment and
ruling a person writes records its author's name: the name the person configures,
kept with that person and never in the committed project
configuration, or else git's user.name. Where neither gives a name,
the write refuses and says how to set one.

## Rationale

A ruling is a person's word, so the record must say whose word it is
once more than one person writes. A name kept with the person follows
that person across projects and clones and puts no roster in a
committed file. Git's user.name is already set wherever a person
commits, so most people never configure anything. Refusing a write
with no name keeps every message attributable, and the refusal tells
the person the one step that unblocks it.

## Alternatives

- One owner writes every comment and ruling under one fixed author — a second person's words carry no name.
- A roster of names in the committed project configuration — each person edits a shared file to join, and one person's setting reaches every clone.
- A message with no resolvable name is written under a placeholder — a placeholder cannot tell two people apart.
