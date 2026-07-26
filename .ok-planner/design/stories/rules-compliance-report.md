---
story: rules-compliance-report
---

# Read-only report of drift from declared rules

## Story

As a project owner, I want a read-only report of where my project drifts from a plugin's declared rules, grouped so I can tell mechanical fixes from structural questions, so that remediation happens at my direction rather than being applied silently.

## Acceptance

The owner runs a plugin's compliance verb → violations and residue are reported grouped by rule and location, with a remediation view distinguishing what is mechanically fixable from what needs judgment; the verb proposes and stops — nothing in the project is modified. Each rules-bearing plugin delivers this over its own rulebook with its real checking machinery.

## Falsifier

The report mutates the project; real drift goes unreported; or proposed fixes are applied without the owner's direction.

## Proof

Demo — a compliance run over a project seeded with known violations of the plugin's rules, producing a grouped report a third party can reconcile against the seeded defects, with the working tree unchanged.
