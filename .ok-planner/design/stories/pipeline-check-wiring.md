---
story: pipeline-check-wiring
---

# Receive working pipeline configuration for the adopted checks

## Story

As an owner adopting the lint on a project with a pipeline, I want ready-to-use configuration that runs the committed checks on every change, so that the rules the project has adopted are enforced on contributions I never review by hand.

## Acceptance

The owner asks for pipeline configuration for their platform → they receive working configuration that runs the lint, failing on any violation, and the ratchet check, failing whenever the recorded violation count has risen; the configuration invokes the project's own committed lint rather than an installed one, so the pipeline enforces the version the project was converged to. What the owner receives runs as given — it is real configuration, not an illustration to adapt.

## Falsifier

The emitted configuration does not run as given; it passes while a violation is present, or while the recorded count has risen; it invokes a lint the pipeline does not have, so the job fails for want of an install rather than for a violation; or the owner must write the wiring themselves from prose.

## Proof

Demo — the emitted configuration for one platform, run unmodified against a repository with a seeded violation and against one whose recorded count has risen, failing in both, and passing on a clean tree at a held count.
