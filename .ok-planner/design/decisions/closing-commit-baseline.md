---
decision: closing-commit-baseline
---

# The close is recorded in the live closed-record ledger

## Choice

When a certification close-out closes a sprint, it first commits the sprint's work while the sprint still sits among the live sprints. It then records the close in the closed-record ledger, a live bookkeeping file outside the archive: the sprint's name and the commit that holds its work. Only then does it move the sprint's test plan to the test-plan folder and the sprint with its other companion files to the archive, and it commits the closed-record ledger entry with the moves in one follow-on commit that holds only records and bookkeeping (see also: archive-read-by-nothing). A documentation sprint's close records its closing commit the same way. The closed-record ledger also lists each test sprint an earlier release closed, with its closing commit, and the name of each sketch moved to the archive, so a new sketch never takes an archived sketch's name. It also lists each name true-up moved into the archive, so an archive step picks a free name without reading the archive (see also: archive-read-by-nothing). The planning ceremony resolves its out-of-band baseline as the closing commit of the newest sprint the closed-record ledger lists, and computes the reconciliation window from that commit to the current tree. In that window it reads the closing commit of each test sprint an earlier release closed as that run's work: its fixes restore what a story promises, so the reconcile step reads them as work done inside a run, not out of band. A closed-record ledger that lists no sprint yields no baseline, and the ceremony asks the owner for one rather than guessing.

## Rationale

The closing commit makes "what landed outside any sprint" a mechanical git question instead of a memory question. Keeping it in a live closed-record ledger lets every tool that needs it read one small file and never the archive (see also: archive-read-by-nothing). One closed-record ledger holds closed sprints, closed documentation sprints, an earlier release's closed test sprints, archived sketches' names, and the names true-up moved into the archive, so each fact the tools need about them has one home: the baseline, the work of a documentation sprint or of an earlier release's test sprint, and the names already used. A closed issue's record keeps a file of its own (see also: closed-issues-leave-the-live-file). Listing each archived sketch's name keeps two sketches from being archived under one name, where one would overwrite or shadow the other. Committing the work before the closed-record ledger entry lets the entry name the commit exactly; the follow-on commit is the small price of an exact pointer, and it carries only records and bookkeeping.

## Alternatives

- Stamp the closing commit into the archived sprint file's frontmatter — the record travels with the archive, and every reader of the baseline reads the archive.
- One ledger per kind of closed sprint or sketch — each tool reads a file of its own, and several files hold one kind of fact.
- Derive the close by inference (the commit that moved the sprint into the archive) — reconstructable but fragile across history rewrites and file moves.
- No recorded baseline — out-of-band detection degrades to human memory, which is the failure the mechanism exists to end.
