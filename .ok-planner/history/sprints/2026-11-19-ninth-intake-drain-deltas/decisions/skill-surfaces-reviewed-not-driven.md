---
decision: skill-surfaces-reviewed-not-driven
---

# A driver reviews a skill surface against the story

## Choice

A surface that is a skill, a prompt the product ships for an agent
session to run, is reviewed, not driven. A driver cannot run a
session's skill, so it reviews the skill's text and the scripts and
tools the skill calls against the story's intent, and files each
divergence as a failure. This is the one surface on which a driver
reads the source (see also: driver-uses-only-the-public-surface). A
script the skill calls runs only where it writes nothing outside the
driver's scratch folder (see also: drive-writes-only-in-scratch).

## Rationale

Reviewing a skill surface keeps the drive's frame, the story's
promise, for a product whose surface no driver can operate, so a
product of skills is certified by the same loop as a product of code.

## Alternatives

- A separate execution path for products made of skill text, where
  the session builds and reviews in rounds with no drive — a second
  shape to keep, and a project that gains a code surface would have to
  leave it.
