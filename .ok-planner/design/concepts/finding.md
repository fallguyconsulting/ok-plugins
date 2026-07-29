---
concept: finding
---

# Finding

## What it is

A finding is one defect surfaced by any of the suite's review passes — compliance review, coverage and drift checks, code review, proof runs. Every finding is classified on one axis: mechanical (fixable without owner judgment — a forbidden section to strip, a stale index line, a dangling cross-reference with an obvious successor) or judgment (requires owner calibration — a boundary unstatable without naming a file, a story with no honest benefit clause, a decision whose rationale is a default rather than a tradeoff).

## Purpose

The mechanical/judgment split is the suite's routing rule for defects: it keeps owners out of work agents can finish alone, and keeps agents from silently deciding questions that belong to the owner. The classification says which findings an agent may finish and which need the owner's calibration; it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act.

## Boundaries

Mechanical findings are handed back to the producing cycle's caller and fixed in-cycle, then re-verified; they never become issues. Judgment findings do not route themselves: a judgment classification is advisory context for whoever holds the report, and the intake is reached only by a deliberate act of filing — the human reading a standalone report files what they judge fork-worthy, the repeating cycle reaches the intake through its two gated paths — certification's architect files what survived the fixer's veto test and its own adversarial check, and the cycle cap's escalation files the remainders a bounded fix loop tried and failed to fix — and the one-time corpus bootstrap files the judgment questions its review loops surface, ungated by design because it sits outside that cycle; what lands there then waits for planning (see also: issue, prove-audit-audience-split under decisions). During certification the bar is deliberately high: fixable is the overwhelming default, a finding is judgment only when sprint and corpus are silent AND reasonable resolutions materially diverge on product intent, and the owner is never asked live (see also: certify-completion under stories). Proof-run verdicts are findings for the executing agent, never queue rows (see also: corpus-proof under stories).

## Invariants

- A finding is fixed, filed, or explicitly stuck at a loop cap — never silently dropped, summarized away, or triaged out by an orchestrator.
- The classifier never grades severity; the split is the only taxonomy.
