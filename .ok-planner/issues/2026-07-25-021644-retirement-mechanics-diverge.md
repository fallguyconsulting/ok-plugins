---
issue: retirement-mechanics-diverge
kind: discover
category: inconsistent
artifacts:
  - concept:corpus-delta
  - concept:catalog-toc
status: verified
opened: 2026-07-25T02:16:44Z
---

# Two retirement mechanics coexist: delete the file vs. move it to `_retired/`

When a sprint retires a concept, story, or decision, one part of the plugin deletes the file and another part behaves as if it moves to an archive. `plan-sprint` templates retirement deltas as outright deletion ("the implementer copies the final form into place, or deletes, for retirements"), and `concept:corpus-delta` agrees ("removes the artifact for a retirement"). But the shared compliance-reviewer prompt excludes `.ok-planner/design/concepts/_retired/` from scope as "terminal state, historical record," checks that "Retired-only entries belong in the 'Retired' section, not the live list" of the catalog TOCs, and flags cross-references into `_retired/` as violations; the audit skill likewise skips `_retired/` when reading catalogs. One mechanic deletes; the other's checks presuppose an archive that deletion guarantees will never exist.

The practical consequence: every `_retired/`-aware check is permanently vacuous today — nothing ever lands there — or would misfire if something did. And `concept:catalog-toc` never mentions a Retired section at all, so the reviewer is checking TOC structure against a convention no artifact defines. Neither cited concept resolves the conflict; corpus-delta's "removes" wording, read literally, contradicts the reviewer's checks.

Worth weighing: the estate already has an archival principle — records move to `history/`, and `design/` is current-state-only. A `_retired/` area inside `design/` would be a second archive inside the one directory defined as holding only what currently holds, while deletion leaves git history as the record, consistent with how the rest of the suite treats superseded content.

## Options

- **Retirement is deletion** — `concept:corpus-delta` stands as written; strip every `_retired/`/Retired-section line from the compliance reviewer, the audit skill, and any TOC prose. Removes dead checks; git history remains the archive.
- **Retirement is archival** — the delta mechanic becomes move-into-`_retired/`; `concept:catalog-toc` gains a defined Retired-section shape; the TOC generator must actually emit one. Keeps an in-corpus trail at the cost of a second archive mechanism and an exception to current-state-only.

The ruling decides: delete or archive — the two mechanics cannot both be live. (The sibling issue `toc-retired-section-shape` turns on the same choice and should receive the same ruling.)

## Ruling

> Recommended ruling (/verify-issues): retirement is deletion — keep `concept:corpus-delta`'s mechanic as written, and remove the `_retired/` scope carve-outs and Retired-section checks from the compliance reviewer and audit prompts (with `toc-retired-section-shape` resolved the same way).
>
> Rationale: `design/` is defined current-state-only with git history as the durable record — an in-corpus archive would be a second, redundant history mechanism contradicting that rule, and nothing has ever populated `_retired/`, so the checks presupposing it protect nothing. Deletion is also what the shipped ceremony already does; the fix is deleting dead prose, not building new machinery.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
