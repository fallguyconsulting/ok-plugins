---
topic: issue-queue
kind: concept
---

# The intake queue (.ok-planner/issues.jsonl)

## Description

An **issue** is "anything about the design corpus that requires human judgment to resolve: sloppy, unspecified, unclear, overloaded, conflicting, or vestigial design — or a proof whose intent has drifted, or a question deferred during planning." Issues live as rows in `.ok-planner/issues.jsonl`, the **intake queue** — "intake, not a work tracker. An issue is a question waiting to reach a sprint; it is never worked, fixed, or tracked to completion in the queue itself." Categories: `overloaded`, `unspecified`, `unclear`, `inconsistent`, `conflicting`, `vestigial`, `muddy-boundary`, `proof`, `other`. **Only judgment items become issues**: "Anything mechanically fixable ... is fixed in-cycle by whoever found it, never filed. An issue row means 'requires owner calibration' by construction."

The file is an **append-only event log**: one JSON object per line, never edited or deleted; "an issue's current state is the fold of its rows by `id`." Three event shapes: `open` (fields id, event, kind ∈ audit|discover|sprint|human, category, artifacts[], summary, detail, candidates[], at), and the two terminals `promote` (resolution, sprint, at) and `retire` (reason, at). Rules from `{{ISSUE-QUEUE-FORMAT}}`: **id is a stable fingerprint** of artifact + nature (no line numbers, no dates) so re-observation appends nothing — "fold first, then append only genuinely new ids"; **writers may open; only planning terminates** — `audit`, `discover-design`, `plan-sprint` (deferring a question), and humans append `open` rows, while `promote`/`retire` are written only from a `/plan-sprint` session ("resolution is the calibration act, and the queue's lifecycle enforces it"); **promote names its sprint and that is the handoff** — "Once the row is written the queue's involvement is over ... A promote row is never followed by another row for the same id"; **legacy `resolve` rows are terminal on read, never written** (fold as promoted if they name a spec/backlog/sprint file, retired otherwise; a legacy `backlog` or `spec` field is read as the sprint reference).

The **two-words-that-must-not-blur** rule: "The *intake queue* holds questions; the *sprint* holds committed work. An issue crosses from one to the other by promotion, one-way, and from then on the sprint is the source of truth — nothing reads the queue to interpret a sprint. Never call `issues.jsonl` a sprint in any user-facing text." Settled means settled: "A later sprint does not re-open, re-litigate, or 'check on' a promoted issue; if the sprint turns out to have gotten it wrong, that is a *new* issue with its own row."

Writers append with Bash `>>` (durable if the session dies), timestamp `date -u +%Y-%m-%dT%H:%M:%SZ`. `/prove` conspicuously never writes the queue (its findings are for the executing agent); `/audit` writes only `open` rows; true-up creates the empty file and validates integrity (parseable lines, known events, required fields, promote rows pointing at existing sprint files) but never edits it.

## Code surface

- `artifact-definitions.md` `{{ISSUE-DEFINITION}}` and `{{ISSUE-QUEUE-FORMAT}}` (canonical).
- Writers: audit SKILL step 6 (dedup against open ids, kind `audit`); discover-design (kind `discover`, both codebase muddiness and agent-confessed uncertainty); plan-sprint §4/§6 (retire during walk, promote after sign-off; deferred questions as kind `sprint`); certify step 4/6 (files prove-`uncertain` and truly-unclear findings); pre-4.0 migration (tensions → open rows, kind `human`).
- Integrity check: true-up SKILL §2. Creation: `scripts/true-up` (`: > issues.jsonl` if absent).
- Live instance: `.ok-planner/issues.jsonl` (empty, day one).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` "The single source of truth" (queue lifecycle summary + the must-not-blur rule); `scripts/ok-planner-CLAUDE.md` "The intake queue"; cheatsheet.

## Adjacent topics

- `sprint`, `plan-sprint-ceremony` (the only terminator), `audit-verb` (writer, and the mechanical/judgment finding split), `discover-design`, `backlog-sprint-rename` (legacy fields), `self-containment-rule` (candidates must be path-free).

## Observations

- The queue is described as "operational state: fold it when a skill needs it; don't editorialize it into prose summaries" (index skill) — a context-discipline stance distinct from both source-of-truth (design/) and records (sprints/).
- The `artifacts[]` field's typed refs (`concept:<slug>` etc.) are what `surface-corpus` treats as tier-1 signals — the row schema quietly feeds the ceremony tooling.
- `kind` names the *writer* (audit/discover/sprint/human) while `category` names the *nature* — two orthogonal enums that prose occasionally comes close to conflating ("category from the finding's nature").
