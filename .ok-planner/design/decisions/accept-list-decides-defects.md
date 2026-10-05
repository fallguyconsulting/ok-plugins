---
decision: accept-list-decides-defects
---

# One harm-keyed accept list decides what every review counts as a defect

## Choice

One accept list decides what every review in the suite counts as a
defect: an enumerated set of harms, each entry naming one harm and the
sites that can cause it, with a section naming what the list leaves
standing. One entry counts a breach of a rule the project states, where
the rule leaves one compliant form, and it names the rule's sources:
the coding rules, the code-rule files the project lists, the
commitments of the live design corpus, the events standard, and the
project's ruled practices. The agents that hunt, merge, fix, and
verify read the list; a driver reports each failure it meets, and the
merge sorts those failures against the list. A site the list does not
cover stands. An agent that sees a harm the list does not name records a
proposal; the list itself is suite-owned, so an adopted entry changes
it upstream.

## Rationale

Open reviewer judgment makes what a run fixes depend on who read the
code: one reviewer's preference becomes another's defect, and a loop
that fixes everything a reviewer can name runs to its cap filing
defects against its own fixes. A list keyed to harm, not to the shape
of code, gives every agent the same test and lets a run end once its
list is fixed. Naming rule sources in one entry lets the project's own
rules count without the list restating them. That entry counts only a
rule that leaves one compliant form, because a rule that leaves two is
a question for the owner, not a fix. The events standard and the ruled
practices are sources because the review pastes the standards the
project lists — by default the events standard and the practices —
into its hunt, fix, and verify prompts, and without the entry a reviewer reads a rule it cannot enforce. Keeping
the list suite-owned keeps every project's runs on one definition, and
a proposal records the harm a project meets so the suite can judge it.

## Alternatives

- Open reviewer judgment — no list to keep, and what counts as a
  defect changes with the reviewer, so runs disagree and never settle.
- Grade each report by severity and fix above a threshold — keeps
  every observation, and moves the decision to a threshold someone
  must set and argue again each run.
- One entry per rule, restating each rule — one place to read, and two
  copies of every rule to keep in agreement.
