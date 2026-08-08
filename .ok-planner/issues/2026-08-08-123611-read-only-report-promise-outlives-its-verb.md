---
issue: read-only-report-promise-outlives-its-verb
kind: audit
category: conflicting
artifacts:
  - story:rules-compliance-report
  - decision:audit-audience-split
  - decision:adversarial-implementation-audits
status: open
opened: 2026-08-08T12:36:11Z
---

# A story still promises a read-only drift report, and no verb is read-only any more

## Problem

`story:rules-compliance-report` reads: "As a project owner, I want a
**read-only** report of where my project drifts from a skill family's
declared rules, grouped so I can tell mechanical fixes from structural
questions, so that remediation happens at my direction rather than
being applied silently."

The sprint `2026-08-08-practices-corpus-and-suite-ceremonies` retired
the read-only reporter verb and folded its artifact-form and
annotation-integrity checks into the periodic audit, which **writes**:
the amended `decision:audit-audience-split` says "The audit writes its
own determinations and nothing else… Its findings reach the human who
invoked it in context as well, each classified mechanical or judgment."

So the part of the story that survives intact is the one that matters —
a report of drift, grouped mechanical vs judgment, with nothing applied
silently. The word that does not survive is "read-only", which
described the retired verb's behavior rather than anything the user
gets. Two further facts bear on it:

- The canonical story rules forbid a body that prescribes mechanism, and
  "read-only" is mechanism. The clause was arguably a form defect before
  this sprint touched anything.
- None of the sprint's sixteen deltas amends this story, so changing it
  is outside the delta mechanism, which is the only sanctioned way what
  the corpus commits to changes.

The executing session did drop the word in cycle and disclosed it as a
divergence; the certification alignment judge called that a commitment
change made outside a delta, and the edit was reverted. The story is
back to its original text and the contradiction is live.

## Candidates

- Amend the story in a later sprint to drop "read-only" from the title
  and the body, leaving the rest of the sentence untouched — the
  user-outcome is unchanged and the mechanism clause goes.
- Amend it more substantially to name what the audit now delivers on
  both axes, since the report the owner gets is wider than "drift from
  declared rules".
- Retire the story, on the ground that `story:corpus-audit` already
  promises the recorded report and this one only ever described a verb.
- Keep it as written and treat the audit's in-context report as
  satisfying "read-only" from the owner's side, since the audit fixes
  nothing.

## Ruling
