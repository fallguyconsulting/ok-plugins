---
issue: lint-patterns-divider-bound
kind: audit
category: product-intent
artifacts: []
status: verified
triage: question
opened: 2026-10-05T10:03:49Z
---

# The lint calls a punctuation-only comment a divider only when its line is eight characters or longer

`plumbline patterns` groups the lint's comment violations by shape, so the audit can sort them by the action each needs. One shape is `divider`: a comment made of punctuation alone, such as `// ========`. The lint labels a comment `divider` only when its trimmed source line is at least eight characters long. A shorter punctuation-only comment, such as `// --`, falls through and gets the label `disallowed-prose`.

The label does not change the lint's verdict. Both labels are `comment-hygiene` violations, and the exit code is the same. The label matters to the audit. Its lint sweep puts dividers in the mechanical cluster, where the fix is fully determined: delete. Prose can carry a real constraint, so a reader of a `disallowed-prose` cluster must look at each member before acting. A short divider labelled prose therefore leaves the mechanical bucket and costs the owner a look it does not need.

The eight-character bound counts the comment marker with the rest of the line. `// --` is 5 characters, `// ----` is 7, and `//------` is 8. Two dividers of one style can thus label differently by a character or two. No concept, story, decision, or practice defines a divider. The term appears only in the lint and in the audit's sweep instructions.

The bound has a history. A fixer in run converge-2026-10-05T024119 rebuilt the shape check to fix defect i38. That fixer kept the base's bound on the source line, because no bound on the stripped comment text reproduces the base: stripped length varies by marker style (`// -----` gives 5, `/* ** */` gives 1). The fixer recorded the other reading, no bound at all, as an open call.

## Options

- **Any punctuation-only comment is a divider, whatever its length.** Cost: `// --` and its kin move from `disallowed-prose` to `divider`, so the audit treats them as mechanical deletes. A bare `//` or `#` with no text also becomes a divider. It is deleted either way.
- **Keep the eight-character bound on the source line.** Cost: an arbitrary threshold that counts the marker, so two dividers of one style label differently.
- **Bound the punctuation after the marker is stripped.** Cost: a new threshold to pick, which must differ by marker style and still labels by length.

No stated rule decides between them. The ruling decides what the lint counts as a divider.

## Ruling

> Recommended ruling (/triage-issues): A divider is any comment of punctuation alone, whatever its length. Drop the length bound.
>
> Rationale: The label exists to sort violations by the action the owner takes. The audit defines the mechanical cluster as violations whose fix is fully determined. A comment with no letter or digit says nothing, so its fix is always a delete, at any length. A length bound sends a contentless comment to the prose cluster, which asks the owner to read it for a constraint it cannot hold. The other two options keep a threshold that no project rule or corpus artifact explains. Flip case: if the owner finds short punctuation-only comments that carry meaning, such as an elision marker in a code example that the owner keeps on purpose, a bound keeps those out of the delete bucket. Then the stripped-text bound is the better threshold, because it stops counting the marker.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
