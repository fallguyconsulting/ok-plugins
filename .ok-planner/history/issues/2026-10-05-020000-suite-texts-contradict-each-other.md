---
issue: suite-texts-contradict-each-other
kind: human
category: tooling
artifacts:
  - story:see-governing-versions
status: promoted
opened: 2026-10-05T02:00:00Z
sprint: 2026-10-05-drain-the-intake.md
---

# Five suite texts carry a prohibition that another suite text or the corpus contradicts

## Problem

A sweep of the suite's prohibitions on 2026-10-04 found five that another text contradicts. An agent that reads both texts cannot follow both. Paths are under `plugins/`.

- `ok/families/ok-planner/review/catalog/failure-paths.md`, row F2, says "never widen a catch to a library's whole family". `ok/families/ok-planner/docs/plumbline-coding.md`, rule 4.3, says "Where the handler acts on a family, read the callee's source or docs and catch the whole family."
- `ok/families/ok-planner/skills/ok-version/SKILL.md` says "No disk read, no comparison, no verdict". `story:see-governing-versions` asks to see which version governs "alongside what is installed, so that version drift is visible".
- `ok/families/ok-planner/admin/ADMINISTRATION.md` closes with "Does not validate the contents of existing artifacts", and the same file runs an intake-integrity check over existing issue files.
- `ok-web/skills/setup-dom-picker/SKILL.md` says to "only adapt (e.g. to `.js`) when the frontend has no TypeScript pipeline", and the same file says "Converge each frontend to this behavior, not to byte-identical source".
- `ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` says "A Rationale sentence claiming a capability or property that no Choice clause commits to is a violation", and the same file calls Rationale the owner's record that needs no verification to be legal.

## Candidates

- Settle each pair in the next sprint: cut or narrow the prohibition so it agrees with the text it contradicts, or amend that text where the prohibition is the intended rule.
- Leave them, accepting that agents resolve each conflict case by case.

## Ruling

Settle all five pairs in this sprint (owner, 2026-10-05):

1. Catch width: narrow failure-paths row F2's "never widen a catch to a library's whole family" to a catch added for an error that escapes to its owner frame, and point to plumbline-coding rule 4.3 for a catch that stands and acts on a family.
2. `/ok-version`: drop "no disk read, no comparison". It shows the governing version, the installed plugin version, and the project's vendored-layer stamp side by side, and still gives no verdict.
3. ADMINISTRATION.md: narrow "Does not validate the contents of existing artifacts" to design-corpus artifacts, naming the issue-frontmatter integrity check as the one exception.
4. setup-dom-picker: scope the copy-and-adapt rule to a frontend with no picker; an existing picker that meets the contract stays as it is.
5. Compliance reviewer: keep both rules; the claim-grounding paragraph names the Rationale capability rule as the one shape rule on Rationale.
