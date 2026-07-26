---
concept: finding
---

# Finding

## What it is

A finding is one defect surfaced by any of the suite's review passes — compliance review, coverage and drift checks, code review, proof runs. Every finding is classified on one axis: mechanical (fixable without owner judgment — a forbidden section to strip, a stale index line, a dangling cross-reference with an obvious successor) or judgment (requires owner calibration — a boundary unstatable without naming a file, a story with no honest benefit clause, a decision with no expressible proof).

## Purpose

The mechanical/judgment split is the suite's routing rule for defects: it keeps owners out of work agents can finish alone, and keeps agents from silently deciding questions that belong to the owner. Everything downstream — who fixes, who is asked, what lands in the queue — follows from the classification.

## Boundaries

Mechanical findings are handed back to the producing cycle's caller and fixed in-cycle, then re-verified; they never become issues. Judgment findings become open rows in the intake queue and wait for planning (see also: issue). During certification the bar is deliberately high: fixable is the overwhelming default, a finding is judgment only when sprint and corpus are silent AND reasonable resolutions materially diverge on product intent, and the owner is never asked live (see also: certify-completion under stories). Proof-run verdicts are findings for the executing agent, never queue rows (see also: corpus-proof under stories).

## Invariants

- A finding is fixed, filed, or explicitly stuck at a loop cap — never silently dropped, summarized away, or triaged out by an orchestrator.
- The classifier never grades severity; the split is the only taxonomy.
