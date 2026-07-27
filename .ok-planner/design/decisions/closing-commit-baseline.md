---
decision: closing-commit-baseline
---

# The close is recorded as a commit stamp on the archived sprint

## Choice

When a certification close-out archives a sprint and commits the work, it stamps the archived sprint file's frontmatter with the closing commit — `closed: <sha of the archive commit>`, written after that commit lands and carried in one small follow-on commit. The planning ceremony resolves its out-of-band baseline as the newest archived sprint's stamp and computes the reconciliation window from that commit to the current tree; an archive with no stamped sprint yields no baseline, and the ceremony asks the owner for one rather than guessing.

## Rationale

The stamp makes "what landed outside any sprint" a mechanical git question instead of a memory question, and it lives on the artifact that defines the boundary — the closed sprint — so the record travels with the archive and needs no second ledger. Stamping after the archive commit is what lets the stamp name that commit exactly; the follow-on commit is the small price of an exact pointer.

## Alternatives

- A separate baseline ledger file in the estate — a second source of truth that drifts from the archive it describes.
- Deriving the close by inference (the commit that moved the sprint into the archive) — reconstructable but fragile across history rewrites and file moves, and invisible to a reader of the sprint file.
- No recorded baseline — out-of-band detection degrades to human memory, which is the failure the mechanism exists to end.
