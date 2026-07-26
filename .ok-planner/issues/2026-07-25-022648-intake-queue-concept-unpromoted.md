---
issue: intake-queue-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:issue
status: verified
opened: 2026-07-25T02:26:48Z
---

# The intake container has no concept — and the artifacts describing it are wrong about the mechanism

Two problems share this file, one optional and one mandatory. The optional one is the filed question: "intake queue" — the container with its own semantics (many writers may open an issue; only the planning ceremony terminates one; intake, not a work tracker) — recurs across concept, decision, and story prose with no artifact owning the container as distinct from the `issue` row it holds.

The mandatory one surfaced in re-verification: **`concept:issue` and `decision:append-only-issue-queue` describe a mechanism the suite retired.** Both still describe a single append-only JSONL event log folded by stable id. The current mechanism — since suite v9.0.0, confirmed by the shared artifact definitions, the estate docs, and the actual contents of `.ok-planner/issues/` — is one markdown file per issue with a `status:` lifecycle (`open → verified → promoted/retired/answered/repaired`) and closure into `history/issues/`. The corpus's current-state-only rule leaves no compliant alternative: both artifacts must be rewritten to the file-per-issue reality regardless of how the promotion question lands. `decision:append-only-issue-queue` is worse than stale — its Choice (a JSONL log, three event shapes) is the retired alternative, so the honest move is retiring the decision itself.

## Options

- **Fold container semantics into `concept:issue`** — rewrite it to own both the row shape and the container rules as one artifact, and retire `decision:append-only-issue-queue`. One home, no new file, and the mandatory drift correction rides the same delta.
- **Promote an `intake-queue` concept** — container semantics get their own file; `concept:issue` narrows to the row. Two files where one fold suffices, per the standard shared with the two sibling promotion issues.

The ruling decides: fold or promote — plus the non-optional rewrite either way.

## Ruling

> Recommended ruling (/verify-issues): fold and correct — a sprint delta rewrites `concept:issue` to the file-per-issue reality, owning both row shape and container semantics (many-writers-open, ceremony-only closure, intake-not-tracker), and retires `decision:append-only-issue-queue` as superseded by the file-per-issue intake shipped in v9.0.0.
>
> Rationale: the issue and its container change together in every rule that governs them — one artifact owning both is self-containment working as intended, matching the fold standard proposed across all three promotion siblings. The JSONL decision records a choice the project has since unmade; keeping it alive misdescribes the estate to every reader, and the drift correction is forced by current-state-only regardless of the fold-vs-promote call.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
