---
issue: auditor-executes-instead-of-reading
kind: human
category: unspecified
artifacts:
  - decision:adversarial-implementation-audits
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T01:03:07Z
---

# Review-side agents run tests and experiments when their job is to read and judge

## Problem

Observed in a consumer session: auditors — and reviewers generally —
were put in the position of performing ad hoc tests and experiments
instead of reading and judging, which led to problems. The auditor is
the sharpest case, but no review-side prompt (code reviewer,
compliance reviewer, consistency checker, change inspector, the
planning ceremony's reviewers) draws the execution line either. The
principle to encode once: execution belongs to the gate and to
/prove; every review-side agent reads and judges, and one that
believes a claim can only be settled by running something reports
that need through a defined channel — the gate decides how to run it. The behavior is licensed,
not rogue: the prompt's rule says only "You are a determiner, not a
fixer" — banning editing, not executing — and the exhibition
paragraph explicitly contemplates the auditor running things ("re-run
it only if one of those citations moved… A demonstration you run
cites what it exercised"). Execution belongs to whoever orchestrates
the gate, which already owns /prove; per-project facts like stack
ownership stay with the gate.

Two subtleties bound the fix. The auditor's method requires running
read-only search and the vendored citation helper (rg, audit-check
cite generation), so a blanket "execute nothing" would break the
prompt's own instructions. And "report the need back to the gate"
requires a defined channel; an undefined report line dead-ends and
auditors will quietly go back to running things themselves.

## Candidates

- Extend the determiner rule to execution with the carve-out stated:
  read-only search and citation generation are the toolkit; tests,
  proofs, builds, deployments, and stack commands are prohibited.
- Rewrite the exhibition paragraph to consume rather than produce: a
  recorded demonstration stands as precedent while its citations
  hold; a claim genuinely needing a new live demonstration is
  reported back on a defined line (alongside the existing escalate
  form), with one consumer sentence added to the gates saying they
  run it via prove and re-dispatch the ref.
- Generalize beyond the auditor: a canonical read-only-reviewer rule
  in the dispatch discipline, carried by every review-side dispatch
  (code review, compliance, consistency, change inspection, the
  planning ceremony's reviewers), permitting read-only commands and
  prohibiting tests, builds, experiments, and the project's stack.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
taking the generalized shape: a canonical
`{{READ-ONLY-REVIEWER-RULE}}` block was added to
`skills/_shared/dispatch-discipline.md` and transcluded into every
review-side prompt (implementation auditor, change inspector, code
reviewer, compliance reviewer, the consistency checker, and
plan-sprint's out-of-band and relevance reviewers) — read-only
commands (rg, git inspection, the vendored checkers) are the whole
execution surface; tests, proofs, builds, deployments, experiments,
and the project's stack are the gate's to run. The auditor's rule now
reads determiner-not-fixer-and-not-runner, its exhibition paragraph
consumes recorded demonstrations rather than producing them, and a
defined `needs-demonstration: <ref> — <what and why>` report line is
consumed by both certify gates: the gate runs the demonstration
(via prove where it is a story proof), records the result, and
re-dispatches the ref in a full-pass batch. This issue stays open so
the next sprint picks it up and ratifies; the work ships with the
next release/re-vendor.
