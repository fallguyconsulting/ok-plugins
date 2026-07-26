---
issue: front-door-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:integration-contract
  - concept:plugin
status: verified
opened: 2026-07-25T02:26:48Z
---

# Does "the front door" deserve its own concept file?

"Front door" — the deliberately ignorant dispatcher that knows only discovery markers and the lifecycle verb, never plugin internals — recurs across four artifacts spanning all three catalogs, always by name, never with its own file. The property it names is load-bearing: the dispatcher's ignorance is what makes the suite composable. Today the full definition lives inside `concept:integration-contract`'s Purpose, so a reader *can* resolve the term — but nothing marks that paragraph as the term's canonical home, and no stable `@concept:front-door` slug exists for code to cite.

No rule forces promotion: the corpus's bar ("a reviewer reading code that mentions the noun needs a stable definition") is met, diffusely, and no threshold exists for when recurrence earns a file. This is the first of three sibling issues asking the same underlying question about different nouns (with `intake-queue-concept-unpromoted` and `project-record-concept-unpromoted`); a single standard, set once, answers all three consistently. The natural standard: promote when the noun owns behavior or rules no existing concept can host without stretching; otherwise fold it explicitly into its home concept.

## Options

- **Fold explicitly** — one sentence in `concept:integration-contract` marking its Purpose as the canonical definition of the front door (aliasing the term). No thin new file; the term gets a citable home.
- **Promote a `front-door` concept** — gives the slug independence, at the cost of a file that would largely restate the contract's existing paragraph — the "thin concept" smell the altitude rules warn about.

The ruling decides: fold or promote — ideally as one standard applied to all three sibling issues.

## Ruling

> Recommended ruling (/verify-issues): fold — a sprint delta amends `concept:integration-contract` to name "front door" as an alias it canonically defines (its Purpose paragraph being the definition), with no new concept file.
>
> Rationale: the front door owns no behavior the contract doesn't already govern — its defining property (ignorance of internals) *is* a contract clause, so a separate file would be a restatement with a slug. Under the promote-only-when-it-owns-something standard proposed across all three siblings, this is the clearest fold of the three.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
