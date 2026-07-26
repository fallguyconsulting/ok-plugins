---
issue: proof-slash-only-activation
kind: discover
category: proof
artifacts:
  - decision:slash-only-activation
status: verified
opened: 2026-07-25T02:16:01Z
---

# The activation-guard convention is checkable text — and ten skills are in drift right now

`decision:slash-only-activation` — user-facing skills declare themselves activated only by their explicit slash command, so conversation content never triggers a ceremony — has no enforcing check. Here the missing check is not a prompt-behavior question at all: what the decision demands is literally that a specific phrase stand in each user-facing skill's frontmatter `description`. That is a text-presence check in the exact, native sense of the owner's `prompt-executed-checks-as-proofs` ruling — greppable governing text, falsifier = the phrase removed — and it is fully buildable today.

And it would fire immediately: re-verification found all ten of ok-plumbline's user-facing skills (`slug`, `suggest`, `explain`, `patterns`, `ci`, `audit`, `version`, `starter`, `port`, `budget`) omit the phrase, while ok-planner's and ok-workspaces' skills comply. The decision's own Choice text already answers whether that drift is acceptable — every user-facing skill carries the phrase; these ten don't self-describe as plumbing — so a sprint picking this up should treat the remediation as forced, not open. (What the membership criterion *is* for edge cases is the sibling issue `activation-class-rule-unstated`, ruled separately; the ten above are user-facing under any candidate criterion.)

## Options

- **Build the presence check and remediate** — a check (script or audit pass) asserting every user-facing skill's description carries the guard phrase, with a plumbing allowlist; rewrite the Proof field to name it; bring the ten drifted skills into compliance. The check has live violations to catch on day one — the opposite of vacuous.
- **Retire the decision** — precluded: the two-class split is a real, documented choice with a real alternative.

## Ruling

> Generated ruling (/verify-issues): the sprint rewrites `decision:slash-only-activation`'s Proof as the frontmatter presence check (every user-facing skill's description carries the guard phrase; plumbing skills on a named allowlist; falsifier = the phrase stripped from any user-facing skill), adds the check as a work item, and adds the forced remediation of ok-plumbline's ten drifted user-facing skills. Rule together with `activation-class-rule-unstated`, which supplies the membership criterion the allowlist encodes.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
