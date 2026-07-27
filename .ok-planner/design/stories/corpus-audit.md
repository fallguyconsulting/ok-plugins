---
story: corpus-audit
---

# Audit the corpus and report the judgment calls

## Story

As a project owner, I want the whole design corpus periodically checked for compliance, proof coverage, intent drift, and cross-artifact conflict, with every finding returned to me classified as mechanical or judgment, so that design rot surfaces the moment I ask instead of accumulating silently.

## Acceptance

The audit runs over a project with a corpus → the caller receives one in-context report: mechanical findings to fix in-cycle, judgment findings classified for the owner's calibration; nothing anywhere is written — the verb is read-only against corpus, code, and intake alike, and it never executes proofs. What the caller does with the report is the caller's: a human files what they judge fork-worthy, and the certification gate drains it through its review-fix loop. The check behind every one of those findings — compliance, proof coverage, intent drift, cross-artifact conflict — is real, not stubbed.

## Falsifier

Corpus muddiness or a claim that outran the code passes without a finding; the audit fixes artifacts itself; the run writes anything — the intake included; or the mechanical/judgment classification is missing, so the owner cannot tell calibration questions from mechanical debris.

## Proof

Demo — an audit over a corpus seeded with a known compliance violation, an uncovered claim, and a cross-artifact contradiction, after which a third party finds all three in the caller's report with the judgment items classified as such, and the working tree — intake included — unchanged.
