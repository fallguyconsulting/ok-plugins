---
story: session-awareness
status: as-is
---

# Sessions start knowing the suite and my vocabulary

## Story

As a project owner, I want every session in my project to start already briefed on the suite's available skills and on my project's concept vocabulary, so that agents use my terms and my verbs correctly without me pasting context or repeating rules.

## Acceptance

Any session opens in a converged project → the plugin's skills briefing and, where a corpus exists, the concept catalog's table of contents are injected automatically with a banner naming the governing versions, directing agents to read a term's full definition before using it and to invoke skills only on explicit command; per-turn, the conduct reminder re-anchors delivery rules when the conduct is active. The materialized session hooks and context payloads are real.

## Falsifier

A fresh session is ignorant of the available skills or defines corpus terms by paraphrase from prior context; the injection reflects the installed plugin rather than what this project was converged to; or sessions in projects without the estate are disturbed at all.

## Proof

Demo — a fresh session in a converged project answers what skills exist and defines a project concept by reading its catalog file unprompted, while the same question in an unintegrated project shows no injection.
