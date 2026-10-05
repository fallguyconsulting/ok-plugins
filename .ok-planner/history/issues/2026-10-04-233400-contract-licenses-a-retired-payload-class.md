---
issue: contract-licenses-a-retired-payload-class
kind: audit
category: design
artifacts:
  - decision:per-project-pinning
  - concept:integration-contract
status: retired
triage: question
opened: 2026-10-04T23:34:00Z
---

# The integration contract still allows a payload fallback the pinning decision rejects, and the fix loop cannot correct it

The suite's normative contract, `docs/integration-contract.md`, says in its Support scripts section: "Exactly two classes legitimately run from the carried payload: the administration process itself (...), and read-only advisory verbs falling back with an announcement in their output." The design corpus says one class. decision:per-project-pinning reads: "Exactly one class legitimately runs from the payload: the administration process itself — diagnosis, bootstrap, and converge". It lists "Let read-only verbs fall back to the payload copy and announce it" as a rejected alternative. No skill in the product falls back to the payload today; the consolidation sprint removed the audit's fallback.

The contract is the suite's normative spine (concept:integration-contract). A reader who follows it may build a read-only verb that runs from the payload, which answers at a version the project was never converged to. That is the harm the pinning decision exists to prevent.

The contract is the project's own prose. It carries no suite stamp and no `/document` provenance stamp, so nothing regenerates it. The corpus settles the end state: the section names one class. What stays open is which act edits the sentence.

Sprint certification run converge-2026-10-04T060800 tried. Its round-1 fixer changed the sentence to "Exactly one class legitimately runs from the carried payload: the administration process itself". The verifier sent it back, because the converge prompts forbid fixers to edit any prose file. The round-2 fixer made no change. The run backed the edit out, so the two-class sentence stands. Issue `fix-loop-cannot-fix-prose-sites` asks whether that bar should change. Sibling prose defects, `readme-describes-the-retired-suite` and `administration-doc-omits-converge-refusals-and-offer-scope`, wait on the same question.

## Options

- The owner edits the sentence by hand, outside any run. Cost: the change gets no review, and the habit of hand-fixing prose defects leaves the loop's gap unaddressed.
- The next sprint carries a work item that rewrites the Support scripts section to name one class. Cost: a sprint item for one sentence.
- Change the converge prompts so a fixer may edit product prose where the defect's site is that file, then let the next `/converge` fix it. Cost: this issue waits on a tooling change that issue `fix-loop-cannot-fix-prose-sites` owns.

The ruling decides which act brings the contract into line with decision:per-project-pinning.

## Ruling

Retired by the owner on 2026-10-04: fixed by hand. The Support scripts section of docs/integration-contract.md now reads "Exactly one class legitimately runs from the carried payload: the administration process itself (diagnosis, bootstrap, and converge run before or while the project copies are being written)", as decision:per-project-pinning says; the read-only fallback class is gone. No other live site states the fallback.
