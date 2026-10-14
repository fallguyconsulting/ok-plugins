---
decision: messages-styled-by-type
---

# The dashboard styles a message by its type and names every author

## Choice

The dashboard picks a message's style from its type, not its author:
a comment or a ruling shows as a person's, and a reply or an update as
an agent's. It shows the author's name on every message. A comment or
a ruling shows as a person's whatever name it carries.

## Rationale

The intake module already ties each message type to who may write it,
so the type says whether a person or an agent wrote the message
whatever name it carries, and a person's message never passes for an
agent's analysis. The set of people's names is open, while the set of
agents is fixed, so a style read from the name would misplace every
name the page has not met. Showing the name on every message tells
each reader who said what.

## Alternatives

- Style a message by its author, with one fixed person's name — a person's message under any other name shows as an agent's analysis.
- A third style for an author who is neither the known person nor a known agent — one more display branch, and a second person's message reads as from an unknown author.
