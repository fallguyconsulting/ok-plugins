---
story: certify-completion
---

# Certify completed work through one gate

## Story

As a project owner, I want one terminal gate that aligns finished work to its sprint, drives every fixable finding to zero without my mid-run involvement, and presents outcomes and divergences to me whole, so that "done" means the same thing for every piece of work and I keep an after-the-fact veto over every call made in my absence.

## Acceptance

The owner (or the sprint's own boilerplate) invokes certification over completed work → sprint alignment is verified with undershoot treated as blocking, the completion-contract verbs run, implementation audits are written or refreshed by an auditor that did not implement the work — covering the touched artifacts and everything the change made stale — code and design-doc reviews dispatch, and a no-discretion fix loop drives findings to zero within a bounded number of cycles; truly unclear findings are filed to the intake queue, never asked live; the owner then receives one whole presentation — status, outcomes, divergences including every call made where sprint and corpus were silent, findings fixed, issues filed — and the sprint archives only when clean, with committing left to the owner and the close-out recording the close so the next planning ceremony can detect what lands after it.

## Falsifier

An undershoot survives into the presentation instead of being fixed; the implementer authors its own audit determinations; the orchestrator triages, defers, or summarizes findings away; the owner is interrupted mid-run with questions; an uncertified sprint is archived; a close leaves no record for the next ceremony's baseline; or divergences the owner should veto go unreported.

## Proof

Demo — a certification over work seeded with an undershot work item and a silent-intent gap, after which a third party sees the undershoot fixed (absent from the presentation), the gap either fixed-and-reported as a divergence or filed as an issue, the sprint archived only on clean status, and the archived sprint carrying its close record.
